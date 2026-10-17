-- Korean (koKR): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- {area:35} Booty Bay · {object:3202} Grom'gol · {object:1661} The Undercity
	["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "{area:35}에서 {object:3202}(으)로 날아가세요. {object:1661}행 비행선은 야영지 서쪽 탑에서 출발합니다.",
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "{zone:1458}행 비행선",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661}에는 사냥꾼과 주술사 상급자가 없습니다. 대신 같은 탑에서 {zone:1454}행 비행선을 타고 도시에서 기술을 배운 뒤, {zone:1454} 정문 밖의 탑에서 {zone:1458}행 비행선을 타세요.",

	-- Step 3: Thunder Bluff
	-- {spell:18960} Teleport: Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "{spell:18960}을(를) 시전하고 {npc:11798}에게서 {area:1638}행 비행편을 타세요. {area:1639}의 {npc:3033}이(가) 기술을 가르쳐 줍니다. 그다음 {zone:1454}(으)로 날아가 정문 밖의 탑에서 {zone:1458}행 비행선을 타세요.",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458} 상급자",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "{zone:1458}에 있는 동안 기술을 배우세요. 상급자는 {object:36070}, {object:36073}, {object:36082}에 있습니다(성기사: {npc:260093}).",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- {zone:1458} Undercity · {area:272} Tarren Mill
	["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "비행선은 {zone:1458} 밖의 탑에 도착합니다. 도시로 내려가 {area:272}(으)로 날아가세요.",

	-- Step 6: Boulderfist camp
	["Boulderfist camp"] = "돌주먹일족 야영지",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "{area:272}에서 동쪽으로 {area:1857}을(를) 지나 길을 따라 동쪽으로 가세요. 돌주먹 오우거와 집행자(32-34)는 {area:313} 남동쪽, 길 남쪽에 야영하고 있습니다.",

	-- Step 7: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "보랏빛 파편은 {area:321} 조금 서쪽, 길 바로 옆에서 빛나고 있습니다.",

	-- Step 8: Hammerfall
	["The orc stronghold at the eastern end of the road. Urda, the wind rider master, stands by the gate."] = "길 동쪽 끝의 오크 요새입니다. 윈드라이더 조련사 우르다는 정문 옆에 서 있습니다.",

	-- Step 9: Highland raptors
	["Highland raptors"] = "고원랩터",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "줄무늬 고원랩터는 {area:321} 주변 언덕 곳곳을 돌아다닙니다. 이들과 더 서쪽의 외뿔 고원랩터 모두 눈알을 떨어뜨립니다.",

	-- Step 11: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "해머폴 북동쪽 골짜기에서 마른수염 코볼트가 채굴하고 있습니다. 입구의 코볼트와 안쪽의 채굴꾼, 흙점쟁이 모두 미즈라엘의 결정 파편을 떨어뜨립니다.",

	-- Step 12: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}은(는) 골짜기 맨 끝에 있습니다.",

	-- Step 13: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "각 {object:180105}은(는) 선돌이 둥글게 늘어선 곳으로, 열쇠는 한가운데 돌 위에 있습니다. 동쪽 결속의 원은 {area:321} 북서쪽 언덕에 있습니다.",

	-- Step 14: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "마른나무껍질부족 트롤이 남동쪽 언덕의 마을을 차지하고 있습니다. 바깥 오두막은 도끼투척병이 지키고, 마을 중심부는 의술사와 인간사냥꾼이 차지하고 있습니다.",

	-- Step 15: Fleshstalker raptors
	["Fleshstalker raptors"] = "식인 고원랩터",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "식인 고원랩터(36-37)는 고원 남부에서 사냥합니다. 한 무리는 {area:316} 북쪽에, 다른 무리는 그 서쪽 평원에 있습니다. 한 번에 한 마리씩 끌어오세요.",

	-- Step 16: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "남서쪽으로 남부 해안의 고블린 만으로 가세요. {npc:2766}은(는) 그 위 절벽에서 망을 봅니다.",

	-- Step 17: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "학자를 해안까지 호위하세요. 가는 길에 비수가시일족 나가 둘이 습격합니다. 가까이 붙어 있으세요.",

	-- Step 19: Daggerspine shore
	["Daggerspine shore"] = "비수가시일족 해안",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "만 서쪽 해안은 비수가시일족 침략자와 여마법사(38-40)가 차지하고 있습니다. 한 번에 하나씩 끌어오세요. 난파선 두 척은 앞바다 얕은 물에 있으며, 해도와 항해일지는 그 안에, 보석은 난파선 주변 해저에 있습니다.",

	-- Step 20: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "44레벨쯤 {area:35}의 {npc:2487}에게",

	-- Step 21: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Ride north; the outer circle stands in the middle of the highlands."] = "북쪽으로 가세요. 바깥 결속의 원은 고원 한가운데에 있습니다.",

	-- Step 22: Northfold Manor
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "비밀결사대가 북서쪽의 담장 두른 저택과 농장을 차지하고 있습니다. 강도, 용병, 추적자가 혈석 아뮬렛을 지니고 있습니다.",

	-- Step 23: The Stone of West Binding
	-- {object:2689} Stone of West Binding
	["The {object:2689}"] = "{object:2689}",
	-- {area:1857} Thoradin's Wall
	["The western circle is near {area:1857}, where you rode in."] = "서쪽 결속의 원은 처음 들어온 {area:1857} 근처에 있습니다.",

	-- Step 24: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "안쪽 결속의 원은 서쪽 결속의 원 남쪽, 스트롬가드 동쪽에 있습니다.",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "이 돌의 다음 임무에는 42레벨 정예인 포즈루크를 처치해야 합니다. 받지 마세요.",

	-- Step 25: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "{area:321}(으)로 돌아가기",

	-- Step 26: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "돌주먹일족 투사는 {area:321} 남쪽 오우거 전당 밖에 야영하고 있으며, 사제가 그들 사이에 있습니다. 한 번에 하나씩 끌어오세요.",

	-- Step 27: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "{npc:2771}의 다음 퀘스트인 {quest:678}은(는) 돌주먹일족 정예를 상대합니다. 받지 마세요.",

	-- Step 28: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "{zone:1418}(으)로",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "아라시 고원에서 남서쪽으로 {area:880}을(를) 건너, {zone:1437}을(를) 지나 남쪽으로 가고({area:150}은(는) 피하세요), 동쪽 {zone:1432}(으)로 들어가세요. 길은 {zone:1432}에서 남쪽 {zone:1418}(으)로 이어집니다. 길을 따라 남쪽의 {area:1877} 고블린 야영지로 가세요.",

	-- Step 29: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: {area:439}에서 받은 피즐의 편지",

	-- Step 30: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "길을 따라 서쪽으로 가세요. {npc:2921}의 야영지는 {area:340}(으)로 가는 중간쯤, {area:1878}에 있습니다.",

	-- Step 31: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340}은(는) 지역 서쪽 끝 절벽에 지어진 호드 요새입니다.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "42레벨쯤 {area:75}의 헬그럼에게",

	-- Step 32: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "하급 바위 정령",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "작은 정령들은 {npc:2921}의 야영지 바로 서쪽 평지를 떠다닙니다. 이 지역의 바위 정령은 모두 {npc:6868}에게 줄 바위 정령 파편을 떨어뜨릴 수 있습니다. 보관하세요.",

	-- Step 34: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "바위 정령",
	-- {area:1878} The Dustbowl
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "더 큰 바위 정령은 {area:1878} 북서쪽 비탈에 서 있습니다. 각각 석판을 떨어뜨립니다.",

	-- Step 36: Coyotes and buzzards
	["Coyotes and buzzards"] = "코요테와 대머리수리",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "덩치큰 바위산코요테와 거대한 대머리수리는 {area:1878} 남쪽 분지를 돌아다닙니다. 코요테는 턱뼈와 송곳니를 모두 떨어뜨리고, 날개와 모래주머니는 대머리수리만 떨어뜨립니다.",

	-- Step 37: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "상급 바위 정령",
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "상급 바위 정령(42-44, 레벨이 훨씬 높음)은 남서쪽 협곡을 돌아다닙니다. 손목보호대는 다섯 마리 중 한 마리 정도가 떨어뜨립니다. 한 번에 하나씩 끌어오고 전투 사이에 쉬거나, 그냥 두세요. 가는 길에 아직 필요한 코요테와 대머리수리를 계속 처치하세요.",

	-- Step 38: Kargath
	-- {area:340} Kargath
	["Ride north back to {area:340}."] = "북쪽의 {area:340}(으)로 돌아가세요.",

	-- Step 39: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: {item:2868}을(를) 가지고 있을 때만({skill:164} 또는 경매장)",

	-- Step 41: Stonevault troggs
	["Stonevault troggs"] = "바위동굴일족 트로그",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "바위동굴일족 트로그는 {area:1877} 남쪽, {area:345}(으)로 가는 길의 동굴 입구 주변을 파헤치고 있습니다. 뼈다귀싸움꾼과 주술사가 조각을 떨어뜨립니다.",

	-- Step 42: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "텔두린은 {area:1877} 남쪽, {area:345}의 드워프 폐허 사이에 앉아 있습니다.",

	-- Step 43: Valley of Fangs
	-- {npc:4618} Martek the Exiled
	["Follow the road north; {npc:4618}'s camp is on the way."] = "길을 따라 북쪽으로 가세요. {npc:4618}의 야영지가 가는 길에 있습니다.",

	-- Step 44: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "길을 따라 계속 북쪽으로 가세요. 상자는 길 북서쪽 폐허 기슭의 {area:1517} 발굴지에 있습니다.",

	-- Step 45: Agmond's End
	-- {area:1877} Valley of Fangs
	["Ride back south down the road, past the {area:1877}."] = "길을 따라 남쪽으로 {area:1877}을(를) 지나 돌아가세요.",

	-- Step 46: Hearth to Kargath
	-- {area:340} Kargath
	["Hearth to {area:340}"] = "귀환석으로 {area:340}에 가기",

	-- Step 47: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "{object:3202} 서쪽 탑에서 {zone:1454}행 비행선을 타세요.",
	["Zeppelin tower"] = "비행선 탑",

	-- Step 49: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "직업 상급자는 {zone:1454}에서 비행 한 번 거리의 {area:1638}에 있습니다: {area:1639}의 {npc:3033}(드루이드), {npc:246344}(성기사). 그곳에서 {area:380}(으)로 날아가세요.",

	-- Step 51: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "{area:380}에서 길을 따라 북쪽의 {area:386}(으)로 가세요. {npc:3389}은(는) 물 위쪽 언덕에서 망을 보고 있습니다.",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace
	["for {npc:5395} in {zone:1443}, in the next guide"] = "다음 가이드에서 {zone:1443}의 {npc:5395}에게",

	-- Step 52: Ratchet
	-- {area:380} Crossroads · {area:392} Ratchet
	["Ride back south to the {area:380} and fly to {area:392}."] = "남쪽의 {area:380}(으)로 돌아가 {area:392}(으)로 날아가세요.",
	-- {item:3713} Soothing Spices · {zone:1445} Dustwallow Marsh
	["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{zone:1445}의 \"늪지눈알\" 자를에게 줄 {item:3713}",
	-- {zone:1445} Dustwallow Marsh
	["The next guide heads into {zone:1445}."] = "다음 가이드는 {zone:1445}(으)로 향합니다.",

	-- Step 53: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "{area:392}에서 해안을 따라 남쪽의 {area:720}(으)로 가세요. {npc:6236}은(는) 투기장 옆에 서 있습니다. 쇠창살을 밟으면 싸움이 시작됩니다. 도전자가 한 명씩 나온 뒤 {npc:6238}(33)이(가) 나옵니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "길을 따라 서쪽으로 가세요. 로트윌의 야영지는 {area:340}(으)로 가는 중간쯤, {area:1878}에 있습니다.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "덩치큰 바위산코요테와 거대한 대머리수리는 {area:1878} 남쪽 분지를 돌아다닙니다. 코요테는 턱뼈와 송곳니를 모두 떨어뜨리고, 날개와 모래주머니는 대머리수리만 떨어뜨립니다.",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "더 큰 바위 정령은 {area:1878} 북서쪽 비탈에 서 있습니다. 각각 석판을 떨어뜨립니다.",
	-- ["The {area:380}"] = "{area:380}",
}
