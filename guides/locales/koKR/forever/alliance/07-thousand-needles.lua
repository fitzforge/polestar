-- Korean (koKR): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "{quest:174}에 쓸 {item:4371}이(가) 없나요? {npc:276} 옆집의 {npc:3133}이(가) 한정 수량으로 팔고, {area:150}의 {npc:1448}도 팝니다.",
	-- {npc:352} Dungar Longdrink · {zone:1453} Stormwind
	["From {npc:352} in {zone:1453}"] = "{zone:1453}의 {npc:352}에게서",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, 여관",
	-- {npc:840} Watcher Backus
	["{npc:840}, at the north entrance of town"] = "{npc:840}, 마을 북쪽 입구",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, 마을 회관 안",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, 마을 회관 옆",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, 없다면 {npc:3133}에게서",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, at the east end of town"] = "{npc:276}, 마을 동쪽 끝",

	-- Step 2: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "{npc:533}",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "늑대인간이 {area:42} 서쪽, 길 북쪽의 밝은나무 숲을 차지하고 있습니다. 하나씩 끌어오세요.",

	-- Step 4: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "{npc:205}",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "암흑길잡이는 {area:42} 서쪽, 길 남쪽 숲을 어슬렁거립니다.",

	-- Step 6: Blind Mary
	-- {area:42} Darkshire
	["Her house stands on the hill south-east of {area:42}."] = "그녀의 집은 {area:42} 남동쪽 언덕 위에 있습니다.",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "{npc:206}와(과) {npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "가장 강한 늑대인간은 {area:42} 남쪽, {area:121}의 서쪽과 남쪽 숲을 돌아다닙니다. {npc:511}은(는) 묘지 옆 작은 납골당에 숨어 있습니다.",

	-- Step 8: Darkshire
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house"] = "{npc:661}, {npc:633}의 집 옆",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "길을 따라 서쪽으로 가세요. 은둔자의 오두막은 {area:492} 북동쪽에 있습니다.",

	-- Step 10: Plague Spreaders
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["Plague Spreaders"] = "{npc:604}",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "{npc:604}은(는) {area:492} 북쪽 절반을 걸어다닙니다. 정예인 {npc:522}이(가) 무덤 사이를 배회하니 가까이 가지 마세요.",

	-- Step 11: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "{npc:311}의 야영지",

	-- Step 12: Raven Hill Cemetery, west
	-- {area:492} Raven Hill Cemetery
	["{area:492}, west"] = "{area:492}, 서쪽",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "{npc:1110}, 해골 치료사, 해골 문지기가 {npc:311}의 야영지 바로 동쪽, 묘지 서쪽 구역을 차지하고 있습니다.",

	-- Step 13: Sven Yorgen's Camp
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "다음 가이드에서 {zone:1453}의 {npc:1212}에게",

	-- Step 14: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "데피아즈단 야영지는 {zone:1431} 남서쪽, {area:94} 남쪽의 {zone:1436} 경계 근처에 있습니다. 금고는 천막들 사이에 있습니다.",

	-- Step 15: Vul'Gol Ogre Mound
	-- {object:119} Abercrombie's Crate
	["Ride east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "동쪽의 오우거 소굴로 가세요. {object:119}은(는) 입구의 야영지에 있으며 망치주먹 오우거가 지킵니다.",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "{npc:272273}이(가) {quest:96138}을(를) 떨어뜨렸을 때만: 오른쪽 클릭하세요",

	-- Step 17: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "{area:42}(으)로 돌아가기",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "다음 가이드에서 {zone:1453}의 {npc:482}에게",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263}, 마을 회관 안",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, 마을 회관 뒤 집",
	["Wait a moment, then speak with her again"] = "잠시 기다렸다가 그녀와 다시 대화하세요",

	-- Step 18: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, 여관 안",
	-- {item:2594} Flagon of Mead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, {npc:1464}에게서",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "{npc:1217}, 여관 위층",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "{npc:2104}, 성채 옆",

	-- Step 19: The wreck of the Third Fleet
	["The wreck of the Third Fleet"] = "제3함대 난파선",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "해안을 따라 북쪽의 난파선으로 가세요. {npc:1157}은(는) 해변을, {npc:1158}은(는) 갑판을 걸어다니고, {npc:1159}은(는) 뱃머리 옆 해변에 서 있습니다. {npc:2089}은(는) 그 바로 북쪽 해안에 숨어 있습니다.",

	-- Step 20: Bluegill Raiders
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Bluegill Raiders"] = "{npc:1418}",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "난파선을 지나 해안을 따라 북동쪽으로 가세요. {npc:1418}은(는) 거대한 습지악어 너머 습지를 차지하고 있습니다.",

	-- Step 22: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "선장은 난파선 갑판을 걸어다니고, 그의 금고는 선창에 있습니다.",

	-- Step 23: Glorin Steelbrow
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, in the next guide"] = "다음 가이드에서 {zone:1453}의 {npc:1284}에게",

	-- Step 24: Whelgar's Excavation Site
	["Follow the road east to the excavation site."] = "길을 따라 동쪽의 발굴 현장으로 가세요.",

	-- Step 25: The dig and Sarltooth
	-- {npc:1353} Sarltooth
	["The dig and {npc:1353}"] = "발굴지와 {npc:1353}",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "유물은 발굴지 안에 있습니다. 커다란 무쇠턱 랩터인 {npc:1353}은(는) 그 바로 서쪽의 랩터 계곡을 어슬렁거립니다.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 26: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078}와(과) 웰가르",

	-- Step 27: Dragonmaw camp
	["Dragonmaw camp"] = "용아귀부족 야영지",
	["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "용아귀부족 오크는 발굴 현장 동쪽에 진을 치고 있습니다. 약탈자와 늪길잡이가 전투 깃발을 가지고 있습니다.",

	-- Step 28: Captain Stoutfist
	-- {area:150} Menethil Harbor
	["Ride back west along the road to {area:150}."] = "길을 따라 서쪽으로 {area:150}까지 돌아가세요.",

	-- Step 29: Dragonmaw catapult
	["Dragonmaw catapult"] = "용아귀부족 투석기",
	["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "다시 동쪽으로 가세요. 투석기는 길 남쪽의 용아귀부족 야영지에 있습니다.",
	["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "다음 단계인 네크로쉬 처치는 정예 족장과 싸워야 합니다. 건너뛰세요.",

	-- Step 30: To Theramore
	["To Theramore"] = "테라모어로",
	-- {area:513} Theramore Isle · {zone:1445} Dustwallow Marsh
	["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "메네실 부두에서 배를 타고 {zone:1445}의 {area:513}(으)로 가세요.",

	-- Step 31: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "{zone:1413}을(를) 지나 남쪽으로 가는 길에서, {npc:6244}은(는) 길 동쪽, {area:378} 북동쪽에 진을 치고 있습니다. 동쪽에서 접근하고 호드 경비병을 피하세요.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: {zone:1443}(으)로 가는 길에 {zone:1440}에서",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: 서큐버스 옆의 인큐버스. {item:190309}은(는) {quest:1738} 근처에 있습니다",

	-- Step 32: The Great Lift
	-- {zone:1413} Barrens · {area:378} Camp Taurajo · {area:485} The Great Lift · {zone:1441} Thousand Needles
	["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "테라모어에서 길을 따라 서쪽으로 먼지진흙 습지대를 빠져나와 {zone:1413}에 들어간 뒤, 길을 따라 남쪽으로 가세요. {area:378}은(는) 멀리 돌아가세요. {zone:1413} 남쪽 끝의 {area:485}을(를) 타면 {zone:1441}(으)로 내려갑니다. 일지는 승강장 아래에 있습니다.",
	-- {npc:4048} Falfindel Waywarder · {zone:1444} Feralas
	["For {npc:4048} in {zone:1444}, much later"] = "한참 뒤에 {zone:1444}의 {npc:4048}에게",

	-- Step 33: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "협곡을 따라 동쪽의 소금 평원으로 가세요. {area:2240}의 고블린과 노움은 중립이며 양 진영 모두에게 퀘스트를 줍니다.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "나중에 가시덤불 골짜기에서 {quest:5762}에게",

	-- Step 34: The salt flats
	["The salt flats"] = "소금 평원",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Scorpid Terrors = {npc:4139} Scorpid Terror
	["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868}은(는) 평원 곳곳에 흩어져 있습니다. {npc:4140}, {npc:4142}, {npc:4147}은(는) 북쪽 절반을, 소금바위 수정바실리스크, {npc:4139}, 무쇠턱 소금껍질거북은 가운데를, 소금바위 큰눈바실리스크(34-35, 당신보다 5레벨 높음: 하나씩)는 맨 남쪽을 돌아다닙니다. 독수리는 그 모든 곳 위를 맴돕니다.",

	-- Step 35: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454}: 나중에 {zone:1418}의 마르텍에게",

	-- Step 36: Back to Menethil
	["Back to Menethil"] = "메네실로 돌아가기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride east to the ogre mound. {item:1349} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "동쪽의 오우거 소굴로 가세요. {item:1349}은(는) 입구의 야영지에 있으며 망치주먹 오우거가 지킵니다.",
}
