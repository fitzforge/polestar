-- Korean (koKR): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "노즈도르무 무리 평판",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "청동용군단의 반지로, 등급이 오를 때마다 강화됩니다. 적대에서 시작해 대부분 레이드로 올라가는 긴 여정입니다.",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "{item:21175} 퀘스트 사슬",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "{area:3425}에 있는 바리스톨스",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{npc:15192}을(를) 만나기 전까지 {faction:910}은(는) 평판 목록에 없습니다. {area:3425} 본관에 있는 {npc:15180}이(가) 그에게 보냅니다. 그를 만나면 적대, 0/36,000이 됩니다. 중립까지 평판 42,000이며, 그 대부분은 레이드에서 옵니다. {area:2677}과(와) {area:16076}은(는) Blizzard가 Forever로 발표한 첫 레이드에 없습니다. 그중 하나가 열리기 전까지, 바리스톨스의 첫 퀘스트 100이 무리 평판의 전부입니다. 유산 특성 외교관은 모든 획득량에 최대 10%를 더하며, 이 가이드의 수치에는 그것이 반영되어 있지 않습니다.",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "{area:2300}에 있는 {npc:15192}",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "{npc:15192}은(는) 엘프 모습의 청동용으로, 동부 {zone:1446}, {area:976} 남동쪽에 있는 {area:2300} 입구에 서 있습니다. 다가가 말을 거세요.",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "{npc:15192}을(를) 만나세요",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "바리스톨스에게로 돌아가기",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "{quest:8288}은(는) {area:2677}({area:254}에 있는 40인 레이드)의 세 번째 우두머리 {npc:12017}의 머리를 요구합니다. 그 이후의 모든 것, 파편 반납도 포함해서 머리가 필요합니다. 손에 넣기 전까지 {quest:8286}이(가) 솔로든 아니든 무리 평판의 전부입니다.",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "{area:2677}은(는) {area:254} 꼭대기의 40인 레이드입니다. {npc:12017}은(는) 항상 자기 머리를 떨어뜨립니다.",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "{item:20383}: 40인 레이드",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "{quest:8301}은(는) 실리시드 등껍질 조각 200개를 요구합니다. 모든 우리 실리시드는 대부분의 처치에서 1~3개를 떨어뜨립니다: {area:3425} 북쪽과 북서쪽의 일꾼 하이브아쉬, 독침, 무리, 방어병, 그리고 서쪽 {area:2743}과 남쪽 {area:2744}의 것들입니다. 그 대부분은 57~60레벨 정예입니다: 솔로로는 하나씩, 파티에서는 더 빠릅니다.",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "적대에서 중립까지",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "정의의 길 이후, 바리스톨스는 {quest:8302}를 위해 파편 200개를 더 받습니다: 200 평판, 반복 가능하지만 중립까지입니다. 적대 500에서 208번 반납, 파편 41,600개, 정예 처치 20,000~30,000으로, 사원 없이는 유일한 방법이자 아주 긴 길입니다. {area:16076}(40인 레이드)이 열리면 훨씬 빠릅니다: 사원의 잡몹이 중립 3,000 중 2,999까지 하나에 100을 주고, 전체 정화당 약 9,500이니 네다섯 번이면 중립입니다. {item:21230}과 {item:21229}는 잡몹이 더 이상 반영되지 전까지 모두 아껴 두세요. 나중에 똑같이 치릅니다.",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "{quest:8302}: 파편 200개, 200",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "{quest:8303}의 퀘스트",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "중립이 되면 이동하는 모래의 왕홀 사슬의 나머지가 열립니다. 바리스톨스가 {quest:8303}(으)로 돌려보냅니다.",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "{object:180633}",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "{object:180633}은(는) {zone:1451} 남서 끝, {area:3428} 문 바로 밖 땅 위의 작은 붉은 수정입니다. 클릭한 뒤 그 자리에 서서 이동하는 모래 전쟁 환영이 끝날 때까지 지켜보세요. 중간에 끊기면 퀘스트를 포기하고 다시 수정을 클릭하세요.",
	["Watch the vision"] = "환영 지켜보기",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "{npc:15192}이(가) 이제 {item:21200}을(를) 세 종류로 줍니다: 수호자의 길(방어 전담), 정복자의 길(근접 전사), 소환사의 길(마법 시전자). 하나를 고르면 나머지 둘은 닫힙니다. 우호적부터 확고한 동맹까지 각 등급마다 같은 반지가 강화되며, 매번 평판 100입니다. {quest:8555}이(가) 이동하는 모래의 왕홀 조각 셋을 찾아 보냅니다.",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "하나를 고르세요: 수호자의 길, 정복자의 길, 소환사의 길, 100",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "붉은 조각: 밸라스트라즈",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "붉은 조각: {area:2677}의 두 번째 우두머리 {npc:13020}이(가) 전투 전에 {quest:8730}을(를) 주고, 마지막 우두머리 네파리안이(가) 퀘스트를 받은 레이더 1명에게 매 처치로 {item:21138}을(를) 떨어뜨립니다. 퀘스트는 다섯 시간 지속됩니다.",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "{npc:13020}, {area:2677}: 40인 레이드",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "{item:21138}, 네파리안",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "푸른 조각: 아주레고스의 장부",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "{npc:15481}이(가) {zone:1447} 남쪽 해안에 서 있습니다. 그의 장부가 {zone:1446}에 있는 {npc:11811}의 긴 사슬을 시작합니다.",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "{npc:11811}, 고블린 예언가가 {area:976} 북동쪽 오두막에 삽니다. 그는 세 곳으로 동시에 보냅니다: {zone:1421}에 있는 스터벌의 상자, {zone:1446} 남쪽 해안 앞 섬, 그리고 {area:976}에 있는 {npc:8125}에게로요.",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "스터벌의 상자",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "{object:180642}은(는) {zone:1421} 남쪽 끝, 닫힌 문 왼쪽 {area:230}에 기대어 있습니다.",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "{object:180652}은(는) {area:987} 남쪽 두 섬 중 먼 섬, 피로도 경계 너머에 있습니다. 해변 남쪽 난파된 콥터 아래 바다 밑에 있는 {npc:15526}이(가) {quest:8599}와(과) 3분간 수영 속도를 올려 주는 축복을 줘서 건너갈 수 있게 합니다.",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "{area:987} 앞 섬",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "{npc:11811}에게 돌아가기",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "{quest:8606}이(가) {npc:11811}의 터번으로 변장한 당신을 {zone:1452}에 있는 {area:2255} 남쪽 하역장으로 보냅니다. 황금 자루를 그곳에 두면, 61레벨 정예 {npc:15554}이(가) 찾아옵니다(3~5인 파티).",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "{npc:15554}, 정예: 3~5인 파티",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "{npc:8125}은(는) {area:976}에서 요리합니다. 그는 남부 {zone:1444} 앞 {area:1121}(으)로 가서 키메로크 만찬을 가져오라고 합니다.",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "{area:1121}",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "{npc:12803}과(와) {area:1121}의 키메로크는 10분마다 다시 나타나는 60~62레벨 정예로, 레이드용 일거리입니다. 키메로크는 약 절반의 경우 등심을, 라크마에란은 가끔 2~4개를 떨어뜨립니다.",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "{item:21027}, {npc:12803}: 레이드",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "{quest:8597}, 2권",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "{quest:8620}은(는) {quest:8597} 2권의 여덟 장을 모아야 합니다: {area:2079} 집에 있는 {npc:15552}(경호원이 따른 63레벨 정예, 레이드), {zone:1419}의 정예 지옥군단병, 파멸의수호대 사령관, 공포의 군주, {area:2255} 남쪽의 헤더린, 그리고 {zone:1458}에 있는 책입니다. {npc:11811}이(가) 수락할 때 제본을 나눠 줍니다.",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "{quest:8597}: 2권",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "{npc:8125}의 앞다리",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "{npc:8125}는 고기가 있으면 {item:9061} 20개와 {item:8150} 20개를 원합니다. {npc:11811}은(는) 이어서 아케이나이트 주괴 20개, {item:18562} 10개, 아제로스 다이아몬드 10개, 푸른 사파이어 10개를 원하고 {item:21136}을(를) 줍니다. {zone:1447}의 {area:1227}에 있는 {object:180669}에 설치하면 63레벨 레이드 우두머리 {npc:15571}을(를) 불러냅니다. {npc:15571}은(는) 퀘스트를 받은 레이더 1명에게 매 처치로 {item:21137}을(를) 떨어뜨립니다.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "{item:12360}: 연금술사, 또는 경매장",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "{item:18562}: {area:2677}, 또는 경매장",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "{item:21137}, {npc:15571}: 레이드",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "푸른 조각: 에라니쿠스",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "{npc:15362}이(가) 다인 던전 {area:1477} 바닥의 {npc:5709} 옆에 나타납니다. 그는 {zone:1457} 밖 {npc:15624}에게 보내고(호드 플레이어는 도시 경비병을 지나쳐야 합니다), 이어서 {zone:1450}의 {npc:11832}에게 보냅니다.",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "{npc:15362}, {area:1477} 안쪽",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "{npc:15624}",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "{npc:15624}: 25(세나리온 서클도 25)",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {npc:235289} Dragons of Nightmare · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four {npc:235289} portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "{quest:8735}은(는) 네 {npc:235289} 차원문 각각의 파편을 요구합니다: {zone:1440}, {zone:1444}, {zone:1425} 차원문의 정예 용족(각 5%)과 {zone:1431}의 {npc:15625}. 레이드 콘텐츠입니다.",
	["10 (and 100 Cenarion Circle)"] = "10(세나리온 서클도 100)",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "{zone:1440} 차원문",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "네 개의 꿈 차원문은 30분마다 다시 나타나는 60~62레벨 정예 용족이 지키는 작은 숲에 있고, 각각 스무 번에 한 번 꼴로 차원문 파편을 떨어뜨립니다. 레이드 콘텐츠입니다.",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "{zone:1431} 차원문",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "{npc:15625}(63레벨 우두머리)은(는) 항상 자기 파편을 떨어뜨립니다.",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "{zone:1444} 차원문",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "{zone:1425} 차원문",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "레이드 이벤트: {npc:11832}을(를) 따라 {area:2361}(으)로 가고, 티란데가 도착해 에라니쿠스를 구원할 때까지 에라니쿠스와 그의 악몽 추종자들 상대로 그를 살려 두세요. 에라니쿠스를 죽이지 마세요.",
	["100 (and 100 Cenarion Circle)"] = "100(세나리온 서클도 100)",
	["The Redemption of Eranikus: raid"] = "에라니쿠스의 구원: 레이드",
	["200 (and 200 Cenarion Circle)"] = "200(세나리온 서클도 200)",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "조각 셋이 모이면 {npc:15192}이(가) 이동하는 모래의 왕홀을 만듭니다. Classic에서는 처음 든 사람이 서버 전체를 위해 {object:180717}을(를) 한 번 울려 {area:3428} 문을 열고, 열 시간 안에 끝낸 사람은 검은 킬라지 수정 탈것을 얻습니다. Forever 서버가 그 이벤트를 얻을지는 알려지지 않았습니다.",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "{object:180717}은(는) {area:3428} 문 앞에 매달려 있습니다. 종을 울리면 {npc:15693}이(가) 그 옆에 나타나 {quest:8745}를 주며, 무기와 평판 200입니다.",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "사원에서 중립에서 우호적까지",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "중립에서 우호적은 평판 3,000입니다. {area:16076}({area:2737} 뒤의 40인 레이드)의 잡몹 하나에 100, 쌍둥이 황제에게는 각 210으로 중립 3,000 중 2,999까지, 우호적 한 포인트 모자란 곳에서 멈춥니다. 그다음 아껴 둔 {item:21230}(1,000, {npc:15502}) 또는 {item:21229}(500, {npc:15503})를 반납해 넘어가세요. 사원 세트의 어깨와 장화 교환은 등급을 요구하지 않습니다: {npc:15502}(어깨) 또는 {npc:15503}(장화)에게 토큰, 우상 둘, 스카라베 열 개를 주면 각 200입니다. {area:3454}(20인)는 우두머리에서 조금 줍니다: 쿠리낙스, 모암, 부루, 아야미스 각 50, 라자크스 34, 오시리안 100으로 확고한 동맹까지입니다.",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "{item:21229}, 사원 우두머리",
	-- {npc:15503} Kandrostrasz
	["{npc:15503}: 500, handed in from his window"] = "{npc:15503}: 500, 그의 대화창에서 바로 제출",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "우호적에서의 반지",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "우호적이 되면 {npc:15192}이(가) 고른 길의 반지를 강화합니다: 수호자의 길, 정복자의 길, 소환사의 길. 착용 중인 반지를 가져가세요. 평판 100입니다.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "{npc:15192}: 내 길의 우호적 반지 퀘스트",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "우호적에서 존경까지: 반납",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "이제 아껴 둔 것을 반납하세요. {item:21230}(사원 잡몹, 1~9%)마다 {quest:8784}가 시작되고 사원 안쪽 청동용 셋 중 하나 {npc:15502}이(가) 평판 1,000을 줍니다. {item:21229}(사원 우두머리 대부분) 매개로 {npc:15503}에게 가 {quest:8595}를 받으세요: 여기 500, 세나리온 서클 100. {npc:15727}은(는) 확고한 동맹까지 2,500을 줍니다. 우호적에서 존경까지는 6,000입니다: 유물 여섯 개나 인장 열둘. 우호적은 사원 세트의 투구와 다리 교환({npc:15502}와 {npc:15503}에게 각 200)도 엽니다.",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "{item:21230}: 우클릭한 뒤 {npc:15502}",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "{quest:8595}: 인장 1개, 500",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "존경에서의 반지",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "존경이 되면 {npc:15192}이(가) 고른 길의 반지를 강화합니다: 수호자의 길, 정복자의 길, 소환사의 길. 착용 중인 반지를 가져가세요. 평판 100입니다.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "{npc:15192}: 내 길의 존경 반지 퀘스트",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "존경에서 평판 우호",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "존경에서 매우 우호적까지는 12,000입니다: 유물 열둘, 인장 스물넷, 또는 {npc:15727}(2,500)과 섞어서. 처음 이후에는 인장마다 반복 가능한 {quest:8595}입니다. 사원 우두머리들이 가끔 {quest:8789}이나 위엄장을 떨어뜨립니다(스무 번에 한 번 꼴): {npc:15727}이(가) 죽은 뒤 사원 안에 있는 {npc:15380}과 {npc:15378}이(가) {item:18562} 3개와 함께 200과 무기를 받습니다. 존경이 세트의 가슴 교환을 엽니다(200).",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "{item:18562}, {area:2677} 또는 경매장",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "{npc:15380}: 무장과 {item:18562} 3개, 200",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "{npc:15378}: 위엄장과 {item:18562} 3개, 200",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "매우 우호적에서의 반지",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "매우 우호적이 되면 {npc:15192}이(가) 고른 길의 반지를 강화합니다: 수호자의 길, 정복자의 길, 소환사의 길. 착용 중인 반지를 가져가세요. 평판 100입니다.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "{npc:15192}: 내 길의 매우 우호적 반지 퀘스트",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "평판 우호에서 확고",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "매우 우호적에서 확고한 동맹까지는 21,000입니다: 유물 스물한 개나 인장 마흔둘, {npc:15727}의 주간 2,500과 함께. {npc:15727}의 눈이 {npc:15379}를 위한 {quest:8801}을(를) 시작합니다(200, 세나리온 서클도 200). 확고한 동맹이 되면 아나크로노스가 마지막 반지를 줍니다: 칼림도르의 수호자, 킬라지 정복자, 대소환사.",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "확고한 동맹에서의 반지",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "확고한 동맹이 되면 {npc:15192}이(가) 내 길의 마지막 반지를 줍니다: 칼림도르의 수호자, 킬라지 정복자, 대소환사. 매우 우호적 반지를 가져가세요. 평판 100입니다.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "{npc:15192}: 내 길의 확고한 동맹 반지 퀘스트",
}
