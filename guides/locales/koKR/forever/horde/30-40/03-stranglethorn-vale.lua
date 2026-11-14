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
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408} 비행 조련사",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
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
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}, 위층",
	-- {npc:2496} Baron Revilgaz · {area:37} Lake Nazferiti
	["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496}: 코즐의 사물함은 이 가이드 후반에 가는 {area:37}에 있습니다",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",

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
	["{area:100}: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "민물악어는 야영지 아래 강을 따라 있습니다. 어린 가시덤불호랑이는 야영지 서쪽, 어린 표범은 동쪽에 돌아다닙니다. 야영지를 지나 서쪽으로 가세요. 가시덤불랩터(33-34)는 빈터에서 사냥하고, 붉은머리부족 트롤은 해안의 폐허를 차지하고 있습니다. 붉은머리부족은 모두 엄니를 떨어뜨릴 수 있습니다. 이들에게서 {item:4614}이(가) 매우 드물게 떨어지니, 얻으면 읽어 보세요. 주의: 트롤 야영지에는 순찰하는 몹이 많아 다른 트롤이 자주 전투에 끼어듭니다.",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: their camps are crowded, with Venture Co. Agents (39) among the geologists (36-38): pull from the camps' edges, one at a time."] = "",

	-- Step 15: Cozzle's Footlocker
	-- {npc:4723} Foreman Cozzle · {area:37} Lake Nazferiti · {object:20691} Cozzle's Footlocker · {npc:2496} Baron Revilgaz
	-- plural, as words: Venture Co. Agents = {npc:260429} Venture Co. Agent
	["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}. Careful: Venture Co. Agents (39) stand in and around the house: clear the doorway before you go in."] = "{npc:4723}(38)은(는) {area:37} 서쪽 기슭의 투자개발회사 건물 안 지질학자들 사이에 있습니다. 그의 열쇠로 같은 건물의 {object:20691}을(를) 열 수 있으며, 그 안에 {npc:2496}에게 줄 설계도가 있습니다. 주의: 투자개발회사 요원(39)이 건물 안팎에 서 있습니다. 들어가기 전에 입구를 정리하세요.",
	-- {npc:4723} Foreman Cozzle
	["from {npc:4723}"] = "{npc:4723}에게서",
	-- {item:5852} Fuel Regulator Blueprints · {object:20691} Cozzle's Footlocker
	["{item:5852}, in {object:20691}"] = "{item:5852}, {object:20691} 안",

	-- Step 16: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "그림자퓨마는 훨씬 나중에 {object:3202} 근처에서 나옵니다",

	-- Step 17: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 18: Nesingwary's camp
	["Back north to the camp."] = "북쪽의 야영지로 돌아가세요.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 21: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "",
	-- {object:3202} Grom'gol · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}."] = "",

	-- Step 22: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464}은(는) {object:3202} 한가운데, {npc:2497}은(는) 비행선 탑 근처, {npc:2465}은(는) 비행 조련사 옆에 있습니다.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "",

	-- Step 23: Level 35
	["Level 35"] = "",
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{area:35}'s and {object:3202}'s next quests are 35-38. Still below 35 after Aggro'gosh's hand-in? The Lashtail Raptors (35) hunt the jungle just north of {object:3202}: kill them until level 35."] = "",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "{area:35}(으)로 날아가기",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 25: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "{npc:2495}의 상점은 여관 동쪽 건물에 있고, {npc:2498}은(는) 여관 1층, {npc:2496}, {npc:737}, {npc:773}은(는) 위층 비행 조련사 옆에 있습니다.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",

	-- Step 26: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 27: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "그롬골 북서쪽 해안 앞바다 물속에 {area:104}이(가) 있습니다. {item:4094}은(는) 가라앉은 폐허 옆 바닥에 있습니다. 숨과 멀록을 조심하세요.",
	["Underwater"] = "물속",

	-- Step 28: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {item:2755} Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of The {item:2755}."] = "",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 31: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "모쉬오그일족 야영지",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "모쉬오그일족 오우거는 돌아가는 길, {object:3202} 바로 동쪽 언덕에 야영하고 있습니다. 모쉬오그일족 투사 10마리와 모쉬오그일족 의술사 5마리(36-37)를 처치하세요. 한 마리씩 끌어오세요.",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "{object:3202}(으)로 돌아가세요.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "다음 가이드는 주둔지 서쪽의 탑에서 비행선을 타고 {zone:1454}(으)로 갑니다.",

	-- Step 33: Level 36
	["Level 36"] = "",
	-- {object:3202} Grom'gol
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Mosh'Ogg Brutes and Witch Doctors camp in the hills just east of the camp: kill them until level 36, pulling one at a time, then walk back to the zeppelin tower."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Elder tigers and Lashtail raptors"] = "덩치큰 호랑이와 채찍꼬리랩터",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "길을 따라 {object:3202}에서 북쪽으로 나가세요. 네싱워리의 사냥 야영지는 강 북동쪽 언덕에 있습니다. 지금부터 얻는 {quest:338}의 모든 쪽은 보관하세요. 나중에 {npc:716}이(가) 요구합니다.",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "길을 따라 골짜기 남쪽 끝의 {area:35}(으)로 가서 절벽의 터널로 들어가세요. 길에서 벗어나지 마세요. 길 옆 정글은 레벨이 훨씬 높습니다. 호드 비행 조련사 {npc:2858}은(는) 위층 갑판에 있습니다.",
	-- ["Green Hills pages"] = "푸른 언덕의 쪽",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}의 쪽은 붉은머리부족과 백골가루부족 트롤에게서 각각 약 1% 확률로 떨어집니다. 얻은 쪽은 모두 보관하고 나머지는 경매장에서 찾아보세요. {npc:716}은(는) 이 가이드 후반에 장을 받습니다.",
	-- ["Shadowmaw panthers"] = "그림자퓨마",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "채찍꼬리랩터(35-36)는 {object:3202} 바로 북동쪽 정글에서 사냥합니다.",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "그림자퓨마(37-38)는 모쉬오그일족 언덕 동쪽과 북동쪽 호수 방향 정글에 숨어 다니며, 은신 상태에서 공격합니다. 가는 길에 보이는 푸른 언덕의 쪽은 모두 챙기세요.",
	-- ["The camp by the river"] = "강가의 야영지",
	-- ["Venture Co. camp"] = "투자개발회사 야영지",
	-- ["Zeppelin to {object:3202}"] = "{object:3202}행 비행선",
	-- ["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496}: 레벨 43쯤 {zone:1446}(으)로 가는 길에 있는 {area:2240}의 포직에게 전달",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}의 실종된 사냥꾼들의 야영지는 네싱워리의 야영지입니다. 천막 사이를 걸으면 조사가 완료됩니다. 민물악어는 야영지 아래 강을 따라 있습니다.",
}
