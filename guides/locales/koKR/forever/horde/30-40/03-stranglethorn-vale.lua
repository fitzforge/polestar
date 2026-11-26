-- Korean (koKR): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "{area:1637}(으)로 돌아가기",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456} 비행 조련사",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "{zone:1454} 상급자",
	["Train while you are in the city."] = "",

	-- Step 6: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "{area:392}(으)로 날아가기",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["{area:35} first: the goblins' boat sails there from {area:392}, and every {area:35} quest is for the north of the vale, which you then walk up into."] = "먼저 {area:35}부터 갑니다. 고블린의 배가 {area:392}에서 그곳으로 운항하며, {area:35}의 퀘스트는 모두 골짜기 북쪽에서 진행하므로 이후 걸어서 올라갑니다.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 7: Ratchet
	-- {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["{npc:3391} waits upstairs in the house by the flight master; {quest:1111} stands on the docks, beside the boat."] = "{npc:3391}은(는) 비행 조련사 옆 건물 위층에 있고, {quest:1111}은(는) 부두의 배 옆에 서 있습니다.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, 위층",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631} in {area:35}, where the boat goes"] = "{npc:3391}: 배가 향하는 {area:35}의 {npc:4631}에게 전달",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}, 부두",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "디지위그의 부품은 경로에서 벗어난 {area:439}의 크라벨에게 돌아가야 하니 받지 마세요.",

	-- Step 8: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "{area:35}행 배",

	-- Step 9: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil · {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:2858} Gringer
	["{npc:4631} stands on the pier where the boat docks. {npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs, {npc:2858} the flight master on the upper deck."] = "{npc:4631}은(는) 배가 정박하는 부두에 서 있습니다. {npc:2495}의 상점은 여관 동쪽 건물에 있고, {npc:2498}은(는) 여관 1층, {npc:2496}, {npc:737}, {npc:773}은(는) 위층, 비행 조련사 {npc:2858}은(는) 위층 갑판에 있습니다.",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the pier"] = "{npc:4631}, 부두",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, 내부",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}, 위층",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, 위층",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, 위층",

	-- Step 10: Grom'gol
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Leave {area:35} through the tunnel and follow the road north to {object:3202}, the orc camp on the west side of the vale. Stay on the road: the jungle beside it is above your level."] = "터널을 통해 {area:35}을(를) 나와 길을 따라 북쪽으로 골짜기 서쪽의 오크 주둔지 {object:3202}(으)로 가세요. 길에서 벗어나지 마세요. 길 옆 정글은 레벨이 더 높습니다.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: 경로 후반의 아라시 고원용",

	-- Step 11: Nesingwary's camp
	["Nesingwary's camp"] = "네싱워리의 야영지",
	-- {object:3202} Grom'gol · {npc:773} Krazek · {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. {npc:773} wants it investigated: walk among its tents. From here on, keep every page of The {item:2755} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "길을 따라 {object:3202}에서 북쪽으로 나가세요. 네싱워리의 사냥 야영지는 강 북동쪽 언덕에 있습니다. {npc:773}이(가) 조사를 원하니 천막 사이를 걸어 다니세요. 지금부터 얻는 {item:2755}의 모든 쪽은 보관하세요. 다음에 가시덤불 골짜기에 올 때 {npc:716}이(가) 받습니다.",

	-- Step 12: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}: 만나는 대로 처치하세요",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "민물악어는 야영지 아래 강을 따라 있습니다. 어린 가시덤불호랑이는 야영지 서쪽, 어린 표범은 동쪽에 돌아다닙니다. 야영지를 지나 서쪽으로 가세요. 가시덤불랩터(33-34)는 빈터에서 사냥하고, 붉은머리부족 트롤은 해안의 폐허를 차지하고 있습니다. 붉은머리부족은 모두 엄니를 떨어뜨릴 수 있습니다. 이들에게서 {item:4614}이(가) 매우 드물게 떨어지니, 얻으면 읽어 보세요. 주의: 트롤 야영지에는 순찰하는 몹이 많아 다른 트롤이 자주 전투에 끼어듭니다.",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent
	-- was: ["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "가시덤불 호랑이(32)는 야영지 주변과 남쪽 언덕을, 표범(32)은 서쪽과 남서쪽 빈터를 돌아다닙니다. 연마된 수정을 지닌 투자개발회사 지질학자(34-36)는 야영지 남동쪽 {area:37} 근처 야영지에서 일합니다. 주의: 투자개발회사 건물 근처 서쪽 야영지에는 투자개발회사 요원(39)이 지질학자 사이에 서 있으니, 그들을 피해 동쪽 야영지에서 사냥하세요."
	["Stranglethorn Tigers (32) roam the hills west of the camp and east of it toward the lake: the arrow takes the eastern ones, on your way to the geologists. Panthers (32) roam the clearings west and south-west of the camp. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "",
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["Tumbled Crystals, from the geologists of the eastern camps"] = "연마된 수정, 동쪽 야영지의 지질학자에게서 획득",

	-- Step 15: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "그림자퓨마는 훨씬 나중에 {object:3202} 근처에서 나옵니다",

	-- Step 16: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 17: Nesingwary's camp
	["Back north to the camp."] = "북쪽의 야영지로 돌아가세요.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}: {npc:729} (37) comes at the end of this guide, from level 36"] = "",

	-- Step 18: Thoroughly Scavenged Supplies
	-- {object:661516} Thoroughly Scavenged Supplies (no name in this language: may be words) · {quest:97328} Anything of Value · {area:102} Ruins of Zul'Kunda
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["On the walk west from Nesingwary's camp, a pile of {object:661516} lies by the path: it starts {quest:97328}, whose Stolen Shipments lie in the {area:102} on the coast ahead."] = "네싱워리 야영지에서 서쪽으로 가는 길가에 {object:661516} 더미가 있습니다. {quest:97328}을(를) 시작하며, 도난당한 화물은 앞쪽 해안의 {area:102}에 있습니다.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}: 만나는 대로 처치하세요",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	-- was: ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and the 40-50 Stranglethorn guide comes back to him.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "야영지를 지나 서쪽 바위에는 수정가시 바실리스크(34-35)가 있습니다. 그 너머 마을의 붉은머리부족은 모두 귀를 떨어뜨릴 수 있습니다.\n야영지 남서쪽 언덕 위의 37레벨 호랑이 {npc:729}은(는) 지금은 두세요. 2레벨 높으며, 40-50 가시덤불 골짜기 가이드에서 다시 옵니다.\n주의: 랩터 둥지에는 어른 랩터를 공격하면 전투에 끼어드는 새끼 랩터가 있습니다."
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and this guide comes back to him at its end, from level 36.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 20: Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark · {area:102} Ruins of Zul'Kunda · {item:277957} Primitive Key · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Scouts = {npc:588} Bloodscalp Scout · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["{npc:268992} is held at the east edge of the {area:102}; the Stolen Shipments lie among the ruins around him. The Bloodscalp Scouts, Hunters and Mystics (34-35) there carry his {item:277957}: {npc:4631} in {area:35} takes the shipments.\nCareful: Bloodscalp Berserkers and Headhunters (36-37) and Witch Doctors (37, casters) hold the ruins north and west of {npc:268992}, close to the northern shipments (around 24.9,9.6): pick the shipments in the southern ruins by {npc:268992} first, and pull one at a time if you go north."] = "{npc:268992}은(는) {area:102} 동쪽 끝에 붙잡혀 있고, 도난당한 화물은 그 주변 폐허에 있습니다. 그곳의 피투성이 정찰병, 사냥꾼, 신비술사(34-35)가 그의 {item:277957}을(를) 지니고 있습니다: {area:35}의 {npc:4631}이(가) 화물을 받습니다.\n주의: 피투성이 광전사와 머리사냥꾼(36-37), 주술 의사(37, 주문시전자)가 {npc:268992} 북쪽과 서쪽 폐허, 북쪽 화물 근처(24.9,9.6 부근)를 지킵니다: {npc:268992} 옆 남쪽 폐허의 화물부터 줍고, 북쪽으로 가면 하나씩 끌어내십시오.",
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["Stolen Shipments, in the ruins"] = "도난당한 화물, 폐허에서",
	-- {item:277957} Primitive Key
	-- plural, as words: Bloodscalp Scouts = {npc:588} Bloodscalp Scout
	["{item:277957}, from the Bloodscalp Scouts, Hunters and Mystics"] = "{item:277957}, 붉은머리부족 정찰병, 사냥꾼, 신비술사에게서 획득",

	-- Step 21: Escort Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992}"] = "{npc:268992} 호위",
	-- {npc:268992} Zimmix Sputterspark
	["Lead {npc:268992} out of the ruins and keep him alive: Lozgil takes the news once he is safe."] = "{npc:268992}을(를) 폐허 밖으로 데려가 살려 두십시오: 그가 안전해지면 로즈길이 소식을 받습니다.",
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992} out of the ruins and keep him alive: Lozgil takes the news once he is safe."] = "{npc:268992}을(를) 폐허 밖으로 호위하며 살려 두세요. 안전해지면 로즈길이 소식을 받습니다.",

	-- Step 23: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "",
	-- {object:3202} Grom'gol · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor · Carnivorous Weeds = {npc:269175} Carnivorous Weed
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}. Careful: the 36s can be two over you: pull them one at a time. Carnivorous Weeds (36-38) are rooted in the jungle south of the raptors: walk around them."] = "{object:3202}(으)로 남쪽으로 돌아가는 길에, 야영지와 {object:3202} 사이 정글에서 채찍꼬리랩터(35-36)가 사냥합니다. 헤메트와 {npc:2464} 퀘스트 모두에 집계됩니다. 주의: 36레벨은 2레벨 높을 수 있으니 하나씩 끌어내세요. 식충 덩굴(36-38)이 랩터 남쪽 정글에 뿌리박고 있으니 돌아가세요.",

	-- Step 24: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464}은(는) {object:3202} 한가운데, {npc:2497}은(는) 비행선 탑 근처, {npc:2465}은(는) 비행 조련사 옆에 있습니다.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "",

	-- Step 25: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "{area:35}(으)로 날아가기",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 26: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:4631} Wharfmaster Lozgil
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master. {npc:4631} stands on the pier."] = "{npc:2495}의 상점은 여관 동쪽 건물에 있고, {npc:2498}은(는) 여관 1층, {npc:2496}, {npc:737}, {npc:773}은(는) 위층 비행 조련사 옆에 있습니다. {npc:4631}은(는) 부두에 서 있습니다.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, 내부",
	-- {npc:4631} Wharfmaster Lozgil
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{npc:4631}, on the pier: the Stolen Shipments"] = "{npc:4631}, 부두: 도난당한 화물",
	-- {npc:4631} Wharfmaster Lozgil · {npc:268992} Zimmix Sputterspark
	["{npc:4631}: {npc:268992} is safe"] = "{npc:4631}: {npc:268992} 무사함",

	-- Step 27: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35} 비행 조련사",

	-- Step 28: Level 35
	["Level 35"] = "",
	-- {quest:629} The Vile Reef · {area:35} Booty Bay · {object:3202} Grom'gol
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter · Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:629}'s and Zul'Kunda's quests are next, with Bloodscalp Headhunters of 36-37. Still below 35 after {area:35}'s hand-ins? The Elder Stranglethorn Tigers (34-35) roam the hills north of {object:3202}, below Nesingwary's camp: kill them until level 35. The Lashtail Raptors (35-36) beside them are a level higher."] = "다음은 {quest:629}와 줄쿤다 퀘스트로, 36-37 레벨의 붉은머리부족 인간사냥꾼이 나옵니다. {area:35}에서 퀘스트를 제출하고도 35 레벨이 안 되나요? 덩치큰 가시덤불 호랑이(34-35)가 {object:3202} 북쪽, 네싱워리 야영지 아래 언덕을 돌아다닙니다. 35 레벨까지 처치하세요. 그 옆의 채찍꼬리랩터(35-36)는 한 레벨 더 높습니다.",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "{npc:1085} 사냥",

	-- Step 29: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "그롬골 북서쪽 해안 앞바다 물속에 {area:104}이(가) 있습니다. {item:4094}은(는) 가라앉은 폐허 옆 바닥에 있습니다. 숨과 멀록을 조심하세요.",
	["Underwater"] = "물속",

	-- Step 30: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}: 만나는 대로 처치하세요",
	-- {item:3915} Bloody Bone Necklace · {item:2755} Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads. Careful: the 37s can be two over you: pull them one at a time from the village's edge, never into the middle with the Witch Doctors.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of The {item:2755}."] = "해안 마을의 붉은머리부족 인간사냥꾼(36-37)이 쪼그라든 머리를 가지고 있습니다. 주의: 37 레벨은 나보다 2레벨 높을 수 있습니다. 마을 가장자리에서 한 마리씩 끌어오고, 주술사가 있는 마을 한가운데로는 절대 들어가지 마세요.\n붉은머리부족 트롤은 산호초 북쪽 해안의 폐허와 그 너머 마을을 차지하고 있습니다. 모두 {item:3915}을(를) 떨어뜨릴 수 있습니다. {item:2755}의 쪽도 계속 모으세요.",

	-- Step 32: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them; the 38s can be two over you: pull them one at a time and leave the Elders alone."] = "모쉬오그 언덕 동쪽, 호수 쪽 정글에 그림자퓨마(37-38)가 돌아다닙니다. 같은 곳의 가시덤불 암호랑이는 가끔 완벽한 송곳니를 떨어뜨립니다. 무쇠턱 악어는 정글 바로 서쪽 강가에 있습니다. 가죽은 {npc:2495}에게 줄 테니 보관하세요. 주의: 그림자퓨마(37-38 레벨)와 덩치큰 그림자퓨마(42-43 레벨)는 비전투 중 은신을 사용하므로 가까이 가기 전까지 보이지 않습니다. 38 레벨은 나보다 2레벨 높을 수 있으니 한 마리씩 끌어오고, 덩치큰 그림자퓨마는 건드리지 마세요.",

	-- Step 33: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "모쉬오그일족 야영지",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time. Careful: the 37s can be two over you: take them from the camp's western edge, never two together."] = "모쉬오그일족 오우거는 돌아가는 길, {object:3202} 바로 동쪽 언덕에 야영하고 있습니다. 모쉬오그일족 투사 10마리와 모쉬오그일족 의술사 5마리(36-37)를 처치하세요. 한 마리씩 끌어오세요. 주의: 37 레벨은 나보다 2레벨 높을 수 있습니다. 야영지 서쪽 가장자리에서 잡고, 절대 두 마리를 한꺼번에 상대하지 마세요.",

	-- Step 34: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "{object:3202}(으)로 돌아가세요.",
	-- {npc:2465} Far Seer Mok'thardin · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["{npc:2465}: for the {zone:1434} & {zone:1435} guide, at about 40"] = "",
	-- {npc:2497} Nimboya · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["{npc:2497}: for the {zone:1434} & {zone:1435} guide, at about 40"] = "",
	-- {npc:729} Sin'Dall · {zone:1454} Orgrimmar
	-- was: ["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "다음 가이드는 주둔지 서쪽의 탑에서 비행선을 타고 {zone:1454}(으)로 갑니다."
	["After {npc:729}, back here: the next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "",

	-- Step 35: Level 36
	["Level 36"] = "",
	-- {npc:729} Sin'Dall · {object:3202} Grom'gol
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	-- was: ["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36, then walk back to the zeppelin tower. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "먼지진흙 습지대 퀘스트는 35-38 레벨입니다. {object:3202}에서 퀘스트를 제출하고도 36 레벨이 안 되나요? 무쇠턱 악어(35-36)가 주둔지 바로 동쪽, 모쉬오그 언덕 아래 강가에 있습니다. 36 레벨까지 처치한 뒤 비행선 탑으로 걸어 돌아가세요. 그 위의 모쉬오그일족 오우거(36-37)는 건드리지 마세요."
	["Dustwallow's quests are 35-38, and {npc:729} (37) is next. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "{npc:1152}",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "{npc:1152} 사냥",

	-- Step 36: Sin'Dall
	-- {object:3202} Grom'gol · {npc:729} Sin'Dall
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["North from {object:3202} to the hilltop just south-west of Nesingwary's camp: {npc:729} prowls there alone.\nCareful: {npc:729} (37) is a level over you: pull him at full health, clear of the Elder Stranglethorn Tigers (34-35) on the hill's slopes."] = "",

	-- Step 37: Nesingwary's camp
	-- {npc:717} Ajeck Rouack · {object:3202} Grom'gol
	["North to {npc:717} in Nesingwary's camp, then back south to {object:3202}'s zeppelin tower."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36, then walk back to the zeppelin tower. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "먼지진흙 습지대 퀘스트는 35-38 레벨입니다. {object:3202}에서 퀘스트를 제출하고도 36 레벨이 안 되나요? 무쇠턱 악어(35-36)가 주둔지 바로 동쪽, 모쉬오그 언덕 아래 강가에 있습니다. 36 레벨까지 처치한 뒤 비행선 탑으로 걸어 돌아가세요. 그 위의 모쉬오그일족 오우거(36-37)는 건드리지 마세요.",
	-- ["Elder tigers and Lashtail raptors"] = "덩치큰 호랑이와 채찍꼬리랩터",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "길을 따라 {object:3202}에서 북쪽으로 나가세요. 네싱워리의 사냥 야영지는 강 북동쪽 언덕에 있습니다. 지금부터 얻는 {quest:338}의 모든 쪽은 보관하세요. 나중에 {npc:716}이(가) 요구합니다.",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "길을 따라 골짜기 남쪽 끝의 {area:35}(으)로 가서 절벽의 터널로 들어가세요. 길에서 벗어나지 마세요. 길 옆 정글은 레벨이 훨씬 높습니다. 호드 비행 조련사 {npc:2858}은(는) 위층 갑판에 있습니다.",
	-- ["Green Hills pages"] = "푸른 언덕의 쪽",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}의 쪽은 붉은머리부족과 백골가루부족 트롤에게서 각각 약 1% 확률로 떨어집니다. 얻은 쪽은 모두 보관하고 나머지는 경매장에서 찾아보세요. {npc:716}은(는) 이 가이드 후반에 장을 받습니다.",
	-- ["Shadowmaw panthers"] = "그림자퓨마",
	-- ["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "가시덤불 호랑이(32)는 야영지 주변과 남쪽 언덕을, 표범(32)은 서쪽과 남서쪽 빈터를 돌아다닙니다. 연마된 수정을 지닌 투자개발회사 지질학자(34-36)는 야영지 남동쪽 {area:37} 근처 야영지에서 일합니다. 주의: 투자개발회사 건물 근처 서쪽 야영지에는 투자개발회사 요원(39)이 지질학자 사이에 서 있으니, 그들을 피해 동쪽 야영지에서 사냥하세요.",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "채찍꼬리랩터(35-36)는 {object:3202} 바로 북동쪽 정글에서 사냥합니다.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "모쉬오그일족 오우거는 돌아가는 길, {object:3202} 바로 동쪽 언덕에 야영하고 있습니다. 모쉬오그일족 투사 10마리와 모쉬오그일족 의술사 5마리(36-37)를 처치하세요. 한 마리씩 끌어오세요.",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "그림자퓨마(37-38)는 모쉬오그일족 언덕 동쪽과 북동쪽 호수 방향 정글에 숨어 다니며, 은신 상태에서 공격합니다. 가는 길에 보이는 푸른 언덕의 쪽은 모두 챙기세요.",
	-- ["The camp by the river"] = "강가의 야영지",
	-- ["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "다음 가이드는 주둔지 서쪽의 탑에서 비행선을 타고 {zone:1454}(으)로 갑니다.",
	-- ["Venture Co. camp"] = "투자개발회사 야영지",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and the 40-50 Stranglethorn guide comes back to him.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "야영지를 지나 서쪽 바위에는 수정가시 바실리스크(34-35)가 있습니다. 그 너머 마을의 붉은머리부족은 모두 귀를 떨어뜨릴 수 있습니다.\n야영지 남서쪽 언덕 위의 37레벨 호랑이 {npc:729}은(는) 지금은 두세요. 2레벨 높으며, 40-50 가시덤불 골짜기 가이드에서 다시 옵니다.\n주의: 랩터 둥지에는 어른 랩터를 공격하면 전투에 끼어드는 새끼 랩터가 있습니다.",
	-- ["Zeppelin to {object:3202}"] = "{object:3202}행 비행선",
	-- ["from {npc:4723}"] = "{npc:4723}에게서",
	-- ["{area:2408} flight master"] = "{area:2408} 비행 조련사",
	-- ["{item:5852}, in {object:20691}"] = "{item:5852}, {object:20691} 안",
	-- ["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "{npc:2495}의 상점은 여관 동쪽 건물에 있고, {npc:2498}은(는) 여관 1층, {npc:2496}, {npc:737}, {npc:773}은(는) 위층 비행 조련사 옆에 있습니다.",
	-- ["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496}: 코즐의 사물함은 이 가이드 후반에 가는 {area:37}에 있습니다",
	-- ["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496}: 레벨 43쯤 {zone:1446}(으)로 가는 길에 있는 {area:2240}의 포직에게 전달",
	-- ["{npc:268992} is held at the east edge of the {area:102}; the Stolen Shipments lie among the ruins around him. The Bloodscalp Scouts, Hunters and Mystics (34-35) there carry his {item:277957}. Then lead him out of the ruins: {npc:4631} in {area:35} takes the news and the shipments.\nCareful: Bloodscalp Berserkers and Headhunters (36-37) and Witch Doctors (37, casters) hold the ruins north and west of {npc:268992}, close to the northern shipments (around 24.9,9.6): pick the shipments in the southern ruins by {npc:268992} first, and pull one at a time if you go north."] = "{npc:268992}은(는) {area:102} 동쪽 끝에 붙잡혀 있고, 도난당한 화물은 그 주변 폐허에 있습니다. 그곳의 붉은머리부족 정찰병, 사냥꾼, 신비술사(34-35)가 {item:277957}을(를) 지니고 있습니다. 그런 다음 그를 폐허 밖으로 데리고 나가세요. {area:35}의 {npc:4631}이(가) 소식과 화물을 받습니다.\n주의: 붉은머리부족 광전사와 머리사냥꾼(36-37), 주술사(37, 시전자)가 {npc:268992} 북쪽과 서쪽 폐허, 북쪽 화물(약 24.9,9.6) 근처를 차지하고 있습니다. 먼저 {npc:268992} 옆 남쪽 폐허의 화물을 줍고, 북쪽으로 가면 하나씩 끌어내세요.",
	-- ["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}. Careful: Venture Co. Agents (39) stand in and around the house: clear the doorway before you go in."] = "{npc:4723}(38)은(는) {area:37} 서쪽 기슭의 투자개발회사 건물 안 지질학자들 사이에 있습니다. 그의 열쇠로 같은 건물의 {object:20691}을(를) 열 수 있으며, 그 안에 {npc:2496}에게 줄 설계도가 있습니다. 주의: 투자개발회사 요원(39)이 건물 안팎에 서 있습니다. 들어가기 전에 입구를 정리하세요.",
	-- ["{npc:717}: {npc:729} (37) waits for your next Nesingwary stop, at about 40 in forever/horde/40-50/01-stranglethorn-vale"] = "{npc:717}: {npc:729}(37)은(는) forever/horde/40-50/01-stranglethorn-vale 가이드의 다음 네싱워리 방문(약 40레벨) 때 처리합니다",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}의 실종된 사냥꾼들의 야영지는 네싱워리의 야영지입니다. 천막 사이를 걸으면 조사가 완료됩니다. 민물악어는 야영지 아래 강을 따라 있습니다.",
}
