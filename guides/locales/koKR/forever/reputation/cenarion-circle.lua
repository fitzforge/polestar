-- Korean (koKR): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "세나리온 의회 평판",
	-- {zone:1451} Silithus
	["Nature resistance enchants and patterns, badge gear and Forever's new {zone:1451} patterns, from {zone:1451}'s camps."] = "자연 저항 마법부여와 도안, 배지 장비, 그리고 Forever의 새 {zone:1451} 도안을 {zone:1451}의 야영지에서 얻습니다.",
	-- {zone:1451} Silithus
	["Forever's new {zone:1451} patterns for Tailors, Leatherworkers and Blacksmiths, Friendly and Honored"] = "Forever의 새 {zone:1451} 도안: 재단사, 가죽세공인, 대장장이용, 약간 우호적과 우호적",

	-- Step 1: The emissary in Ironforge
	-- {zone:1455} Ironforge
	["The emissary in {zone:1455}"] = "{zone:1455}의 사절",
	-- {npc:15187} Cenarion Emissary Jademoon · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15187} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "선택 사항이며 나중의 드레드 퀘스트에만 필요합니다: {npc:15187}이(가) {quest:8275}, 평판 10의 서한과 함께 당신을 {zone:1451}(으)로 보냅니다. 이미 {zone:1451}에 있다면 건너뛰세요.",

	-- Step 2: The emissary in Orgrimmar
	-- {zone:1454} Orgrimmar
	["The emissary in {zone:1454}"] = "{zone:1454}의 사절",
	-- {npc:15188} Cenarion Emissary Blackhoof · {zone:1451} Silithus · {quest:8276} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15188} sends you to {zone:1451} with {quest:8276}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "선택 사항이며 나중의 드레드 퀘스트에만 필요합니다: {npc:15188}이(가) {quest:8276}, 평판 10의 서한과 함께 당신을 {zone:1451}(으)로 보냅니다. 이미 {zone:1451}에 있다면 건너뛰세요.",

	-- Step 3: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {faction:609} Cenarion Circle · {npc:15270} Huum Wildmane · {quest:8318} Secret Communication · {item:20404} Encrypted Twilight Text
	["{area:3425} is the walled druid camp in north-central {zone:1451}, with flight points for both sides. Everyone starts Neutral with the {faction:609} (druids at 2,000 of 3,000). Bor and {npc:15270} stand together in the main building. {quest:8318} opens the {item:20404} turn-ins for good. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3425}은(는) 북부 중앙 {zone:1451}의 벽으로 둘러싼 드루이드 야영지로, 양 진영 모두의 비행 지점이 있습니다. 모두 {faction:609}과(와) 중립으로 시작하며(드루이드는 3,000 중 2,000), 보르와 {npc:15270}은(는) 본관에 함께 서 있습니다. {quest:8318}이(가) {item:20404} 반납을 영구히 엽니다. 유산 특성 외교관은 모든 획득량에 최대 10%를 더하며, 이 가이드의 수치에는 그것이 반영되어 있지 않습니다.",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, level 60"] = "{npc:15270}, 60레벨",

	-- Step 4: The cultist camp west of Cenarion Hold
	-- {area:3425} Cenarion Hold
	["The cultist camp west of {area:3425}"] = "{area:3425} 서쪽의 신도 야영지",
	-- {item:20404} Encrypted Twilight Text · {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Wind Stones = {object:180461} Wind Stone
	["The nearest Twilight's Hammer camp lies just south-west of the Hold. Avengers, Geolords and Stonecallers (level 57 to 59) each drop an {item:20404} about a third of the time, and every cultist kill is 1 reputation. {npc:11804} walks the edge of the camp. Keep every cultist robe, cowl and mantle you loot: they are the Twilight Trappings for the Wind Stones later."] = "가장 가까운 황혼의망치단 야영지는 전초기지 바로 남서쪽에 있습니다. 응징자, 지질군주, 바위소환사(57~59레벨)가 각각 약 3분의 1 확률로 {item:20404}을(를) 떨어뜨리고, 신도 처치 하나에 평판 1입니다. {npc:11804}은(는) 야영지 가장자리를 거닐니다. 전리한 신도의 로브, 두건, 어깨걸이를 모두 간수하세요: 나중의 바람의 돌에 쓰는 황혼 의복입니다.",

	-- Step 5: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "{area:3425}(으)로 돌아가기",

	-- Step 6: Cultists until the top of Friendly, texts saved
	["Cultists until the top of Friendly, texts saved"] = "약간 우호적 정점까지 신도를, 서류는 보관",
	-- {npc:11880} Twilight Avenger · {item:20404} Encrypted Twilight Text · {area:2742} Hive'Ashi · {npc:15308} Twilight Prophet · {npc:15306} Bor Wildmane
	["Neutral to Honored is 9,000 reputation (7,000 for druids). Every {npc:11880}, Geolord, Stonecaller, Master and Overlord gives 1 reputation until 5,999 of 6,000 Friendly, one point short of Honored; there they stop. Save every {item:20404} and leave the quests of the next steps for later: each kill below that point is a free point on top of its text, and the texts and quests pay the same at any standing. A text drops about every third kill, so 30 kills make 30 reputation and 10 texts (100 reputation later). Four camps: south-west of the Hold (39,44), the far west (26,34), the far south-west (19,84) and the north-east below {area:2742} (66,18: Overlords, and Flamereavers that count until the top of Honored). The {npc:15308} (87% text) walks between 18,31 and 23,69. Texts sell on the auction house if you would rather buy. At 5,999 Friendly the last point into Honored comes from a Flamereaver, Twilight Keeper or Marauder, or from your first 10 texts at {npc:15306}."] = "중립에서 우호적은 평판 9,000입니다(드루이드는 7,000). 모든 {npc:11880}, 지질군주, 바위소환사, 대가, 지배자가 우호적 6,000 중 5,999까지, 우호적 한 포인트 모자란 곳에서 평판 1을 주고 거기서 멈춥니다. {item:20404}을(를) 모두 아껴 두고 다음 단계의 퀘스트는 나중으로 미루세요: 그 지점 아래의 처치마다 서류 위에 공짜 포인트가 붙고, 서류와 퀘스트는 어떤 등급에서도 같은 값을 치릅니다. 서류는 대략 세 번 중 한 번 꼴로 떨어지니 30번 처치하면 평판 30과 서류 10개(나중에 평판 100)입니다. 야영지 넷: 전초기지 남서쪽(39,44), 먼 서쪽(26,34), 먼 남서쪽(19,84), 그리고 {area:2742} 아래 북동쪽(66,18: 지배자, 그리고 우호적 정점까지 반영되는 불타는 약탈자). {npc:15308}(서류 87%)은(는) 18,31과 23,69 사이를 거닐니다. 사고 싶다면 경매장에서 파는 서류도 있습니다. 우호적 5,999에서 우호적으로 가는 마지막 포인트는 불타는 약탈자, 황혼의 문지기, 약탈자에게서 오거나 {npc:15306}에게 처음 서류 10개를 반납할 때 옵니다.",
	["Kills alone to the top of Friendly is 8,999 kills (6,999 for druids), but the texts they drop (about 3,000) are worth 30,000 more: most of the way to Exalted."] = "처치만으로 약간 우호적 정점까지는 8,999번(드루이드는 6,999번)이지만, 그들이 떨어뜨리는 서류(약 3,000개)가 30,000어치를 더합니다: 확고한 동맹까지의 대부분입니다.",
	-- {item:20732} Formula: Enchant Cloak - Greater Fire Resistance · {item:22251} Cenarion Herb Bag · {item:22758} Sylvan Shoulders
	["Friendly (3,000) opens Kania's {item:20732} (10g), Mishta's {item:22251} (2g) and {item:22758} (5g), and Forever's new Friendly gloves patterns (7g 50s)."] = "약간 우호적(3,000)이면 카니아의 {item:20732}(10골), 미슈타의 {item:22251}(2골), {item:22758}(5골), 그리고 Forever의 새 약간 우호적 장갑 도안(7골 50실)이 열립니다.",
	-- {item:20404} Encrypted Twilight Text
	["{item:20404}: save them"] = "{item:20404}: 보관하세요",
	-- {npc:15201} Twilight Flamereaver
	["{npc:15201}: still counts at 5,999 Friendly"] = "{npc:15201}: 약간 우호적 5,999에서도 여전히 반영됩니다",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100, for the last point"] = "{npc:15306}: 마지막 포인트를 위한 서류 10개, 100",

	-- Step 7: Vyral the Vile
	-- {quest:8321} Vyral the Vile · {area:3446} Twilight's Run · {zone:1451} Silithus
	-- plural, as words: Twilight Masters = {npc:11883} Twilight Master
	["{quest:8321} (level 61, not elite) waits at the back of {area:3446}, the cave in the north-east of {zone:1451}. Flamereavers and Twilight Masters guard the way: the Flamereavers count until the top of Honored, the Masters stop at the top of Friendly like the other cultists."] = "{quest:8321}(61레벨, 비정예)은(는) {zone:1451} 북동쪽 동굴 {area:3446} 안쪽에서 기다립니다. 길을 불타는 약탈자와 황혼의 장로가 지킵니다: 불타는 약탈자는 우호적 정점까지 반영되고, 장로는 다른 신도처럼 약간 우호적 정점에서 멈춥니다.",

	-- Step 8: Silithus quests at Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451} quests at {area:3425}"] = "{area:3425}의 {zone:1451} 퀘스트",
	-- {quest:8280} Securing the Supply Lines · {quest:8275} Taking Back Silithus · {npc:15196} Deathclasp · {npc:15174} Calandrath · {quest:8307} Desert Recipe · {item:20452} Smoked Desert Dumplings · {npc:15189} Beetix Ficklespragg
	["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "이제 일회성 퀘스트를 바꾸세요: 솔로로 약 1,700, 파티 퀘스트를 포함하면 2,400 평판입니다. 55~60레벨이니 60에서 정액을 받습니다. {quest:8280}은(는) {quest:8275}이(가) 먼저 필요합니다. {npc:15196}은(는) 호위 둘을 데린 정예 전갈입니다(2~3인 파티). {npc:15174}의 {quest:8307}은(는) 요리사용이며, 그 제조법이 그가 원하는 {item:20452}을(를) 만듭니다. {npc:15189}은(는) 자기 건물 위층에 서 있습니다: 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",
	-- {npc:15191} Windcaller Proudhorn · {quest:8275} Taking Back Silithus
	["{npc:15191}, after {quest:8275}"] = "{npc:15191}, {quest:8275} 이후",
	-- {npc:15196} Deathclasp
	["Wanted poster: {npc:15196}, elite"] = "현상 수배 전단: {npc:15196}, 정예",
	-- {npc:15174} Calandrath
	["{npc:15174}, for Cooks"] = "{npc:15174}, 요리사용",

	-- Step 9: Around Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Around {area:3425}"] = "{area:3425} 주변",
	-- {object:180503} Sandy Cookbook
	-- plural, as words: Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer · Dredge Strikers = {npc:11740} Dredge Striker
	["Stonelash Scorpids and Sand Skitterers roam the sands around the Hold; Dredge Strikers dig north-east of it. The {object:180503} lies in the cultist camp south-west of the Hold."] = "돌꼬리전갈과 모래그물 바위거미가 전초기지 주변 모래를 돌아다니고, 작살미늘벌레는 그 북동쪽을 파헤칩니다. {object:180503}은(는) 전초기지 남서쪽 신도 야영지에 있습니다.",

	-- Step 10: Back at the Hold
	["Back at the Hold"] = "전초기지로 돌아가기",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}은(는) 자기 건물 위층에 서 있습니다: 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 11: Stonelash and Dredge Crushers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash and Dredge Crushers"] = "스톤래시와 망치미늘벌레",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker · Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash Flayers, Pincers and Rock Stalkers live south and south-west of the Hold; their stingers and fangs drop about one time in ten. Dredge Crushers dig south and west of the Hold."] = "돌꼬리채찍전갈, 핀서, 긴다리 바위거미는 전초기지 남쪽과 남서쪽에 삽니다. 그들의 독침과 송곳니는 열 번에 한 번 꼴로 떨어집니다. 망치미늘벌레는 전초기지 남쪽과 서쪽을 파헤칩니다.",
	-- {item:20452} Smoked Desert Dumplings · {object:180503} Sandy Cookbook
	["{item:20452}, from the {object:180503}"] = "{item:20452}: {object:180503}에서",
	-- {item:20452} Smoked Desert Dumplings · {item:20424} Sandworm Meat · {item:3713} Soothing Spices
	["{item:20452}, from {item:20424} and {item:3713}"] = "{item:20452}, {item:20424}과(와) {item:3713}으로 만듦",

	-- Step 12: Noggle Ficklespragg and Proudhorn
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} and Proudhorn"] = "{npc:15190}과(와) 자부심",
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}과(와) {npc:15190}은(는) 자기 건물 위층에 서 있습니다: 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 13: The Ravaged Twilight Camp
	-- {area:3100} Ravaged Twilight Camp
	["The {area:3100}"] = "{area:3100}",
	-- {zone:1451} Silithus
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["The broken camp in the far north-west of {zone:1451}: the Twilight Tablet Fragments lie on the ground among the ruins."] = "{zone:1451} 먼 북서쪽의 부서진 야영지: 황혼의 서판 조각이 폐허 사이 땅 위에 있습니다.",

	-- Step 14: Larksbane
	["Larksbane"] = "라크스베인",

	-- Step 15: Hermit Ortell
	-- {npc:15194} Hermit Ortell · {zone:1451} Silithus · {quest:8319} Encrypted Twilight Texts · {quest:8349} Bor Wildmane
	["{npc:15194} hides in the hills of eastern {zone:1451}. He also decodes {quest:8319} for a chance at a scroll of beckoning, but {quest:8349} pays the reputation: keep the texts for Bor."] = "{npc:15194}은(는) 동부 {zone:1451} 언덕에 숨어 삽니다. 그는 {quest:8319}를 복호화해 소환 두루마리의 기회를 주지만, {quest:8349}가 평판을 주니 서류는 보르에게 주세요.",

	-- Step 16: The three Twilight Keepers
	["The three Twilight Keepers"] = "황혼의 문지기 셋",
	["Each Keeper is a level 60, not elite, alone at a camp edge, and always drops its chapter: Mayna in the far west camp, Havunth in the camp south-west of the Hold, Exeter in the far south-west camp beside the Twilight Lord."] = "각 문지기는 60레벨 비정예로 야영지 가장자리에 혼자 있고 항상 자기 장을 떨어뜨립니다: 메이나는 먼 서쪽 야영지, 하빈스는 전초기지 남서쪽 야영지, 엑서터는 황혼의 군주 옆 먼 남서쪽 야영지에 있습니다.",

	-- Step 17: Back to Ortell
	["Back to Ortell"] = "오텔에게로 돌아가기",

	-- Step 18: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "브론즈비어드 야영지",
	-- {zone:1451} Silithus · {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {quest:8304} Dearest Natalia · {item:20379} Noggle's Satchel · {npc:15196} Deathclasp · {spell:10101} Knock Away
	["The dwarves' camp in the south of {zone:1451}. Talk {npc:15171} and {npc:15170} through their whole stories for {quest:8304}. {item:20379} lies on the mountain south-east of the camp. {npc:15196} lives up the trail east of the camp: an elite, and his {spell:10101} can throw you off the cliff."] = "{zone:1451} 남부의 드워프 야영지. {quest:8304}를 위해 {npc:15171}과(와) {npc:15170}의 이야기를 처음부터 끝까지 들으세요. {item:20379}은(는) 야영지 남동쪽 산에 있습니다. {npc:15196}은(는) 야영지 동쪽 오솔길 위에 삽니다: 정예이며, 그의 {spell:10101}은(는) 당신을 절벽으로 던질 수 있습니다.",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170}"] = "{npc:15171}와(과) {npc:15170}",
	-- {item:20385} Deathclasp's Pincer
	["{item:20385}, elite: group of 2 or 3"] = "{item:20385}, 정예: 2~3인 파티",

	-- Step 19: Back to Cenarion Hold with news
	-- {area:3425} Cenarion Hold
	["Back to {area:3425} with news"] = "소식을 가지고 {area:3425}(으)로 돌아가기",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}은(는) 자기 건물 위층에 서 있습니다: 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",
	["Natalia, elite: group up"] = "나탈리아, 정예: 파티를 모으세요",

	-- Step 20: Rubbings and brains
	["Rubbings and brains"] = "탁본과 뇌",
	-- {object:210337} Glyphed Crystal (no name in this language: may be words) · {item:20453} Geologist's Transcription Kit · {area:2742} Hive'Ashi · {area:2743} Hive'Zora · {area:2744} Hive'Regal · {quest:8308} Brann Bronzebeard's Lost Letter
	["Rutgar and Frankal hand out the next two quests at their camp. Each hive has a {object:210337} to rub with the {item:20453}, and its silithid drop the brains: {area:2742} north of the Hold, {area:2743} in the west, {area:2744} in the south. Inside {area:2744} waits Mistress Natalia (level 62 elite, mind control and fear; group of 3 to 5). Now and then a hive silithid drops {quest:8308}: it starts a quest for Rutgar worth 100."] = "러트가와 프랭컬이 야영지에서 다음 퀘스트 둘을 줍니다. 각 우리에는 {item:20453}(으)로 문질러 탁본할 {object:210337}이(가) 있고, 그 실리시드는 뇌를 떨어뜨립니다: {area:2742}는 전초기지 북쪽, {area:2743}은(는) 서쪽, {area:2744}은(는) 남쪽입니다. {area:2744} 안쪽에는 나탈리아 부인(62레벨 정예, 정신 지배와 공포, 3~5인 파티)이 기다립니다. 가끔 우리 실리시드가 {quest:8308}을(를) 떨어뜨리는데, 러트가를 위한 100짜리 퀘스트를 시작합니다.",
	-- {item:20456} Hive'Regal Rubbing · {area:2744} Hive'Regal
	["{item:20456}, deep in {area:2744}"] = "{item:20456}, {area:2744} 깊은 곳",
	-- {quest:8308} Brann Bronzebeard's Lost Letter
	["{quest:8308}, a rare drop"] = "드물게 떨어지는 {quest:8308}",

	-- Step 21: Mistress Natalia
	["Mistress Natalia"] = "나탈리아 부인",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	["Optional: Natalia waits deep in {area:2744}, the hive in the south of {zone:1451}. She is a level 62 elite who mind-controls, fears and heals herself below half health: bring a group of 3 to 5 and interrupt her heals."] = "선택 사항: 나탈리아는 {zone:1451} 남부의 우리 {area:2744} 깊은 곳에서 기다립니다. 정신을 지배하고 공포를 걸며 체력 절반 아래에서 자신을 치유하는 62레벨 정예입니다: 3~5인 파티를 데려가 치유를 방해하세요.",
	["Mistress Natalia: group of 3 to 5"] = "나탈리아 부인: 3~5인 파티",

	-- Step 22: The Calling
	-- {quest:8314} Unraveling the Mystery · {quest:8315} The Calling · {npc:15183} Geologist Larksbane · {area:3257} Bones of Grakkarond · {npc:14862} Emissary Roman'khan
	["{quest:8314} leads to {quest:8315}: {npc:15183} sends you to the {area:3257} to summon {npc:14862}, a level 63 boss for a raid of about 20. Take it only with a raid."] = "{quest:8314}이(가) {quest:8315}(으)로 이어집니다: {npc:15183}이(가) {area:3257}(으)로 보내 {npc:14862}, 약 20인 레이드용 63레벨 우두머리를 소환하게 합니다. 레이드와 함께만 받으세요.",
	["raid of 20"] = "20인 레이드",
	-- {item:20465} Crystal Unlocking Mechanism · {npc:14862} Emissary Roman'khan
	["{item:20465}, {npc:14862}: raid of 20"] = "{item:20465}, {npc:14862}: 20인 레이드",

	-- Step 23: The New Frontier, Thunder Bluff
	-- {quest:1123} Rabine Saturna · {npc:10881} Bluff Runner Windstrider · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:1123}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10881} sends you to {npc:5769} on {area:1639}, who sends you to {quest:1123} in {area:2361}, {zone:1450}."] = "선택 사항: {quest:1123} 사슬이 55~57레벨 퀘스트 일곱 개로 세나리온 평판 525를 주며, 60에서 정액입니다. {npc:10881}이(가) {area:1639}의 {npc:5769}에게 보내고, 그가 {zone:1450}의 {area:2361}에 있는 {quest:1123}(으)로 보냅니다.",

	-- Step 24: The New Frontier, Darnassus
	-- {quest:6762} Rabine Saturna · {npc:10878} Herald Moonstalker · {npc:3516} Arch Druid Fandral Staghelm · {npc:4217} Mathrengyl Bearwalker · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:6762}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10878} sends you to {npc:3516}, who sends you to {npc:4217}, who sends you to {quest:6762} in {area:2361}, {zone:1450}."] = "선택 사항: {quest:6762} 사슬이 55~57레벨 퀘스트 일곱 개로 세나리온 평판 525를 주며, 60에서 정액입니다. {npc:10878}이(가) {npc:3516}에게 보내고, 그가 {npc:4217}에게 보내고, 그가 {zone:1450}의 {area:2361}에 있는 {quest:6762}(으)로 보냅니다.",

	-- Step 25: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest · {zone:1451} Silithus
	["{quest:1123} lives in {area:2361}. She sends you to {npc:13220} at {area:3077}, the camp in the north-east corner of {zone:1451}."] = "{quest:1123}은(는) {area:2361}에 삽니다. 그녀가 {zone:1451} 북동쪽 귀퉁이 야영지 {area:3077}에 있는 {npc:13220}(으)로 보냅니다.",

	-- Step 26: Southwind Village
	-- {area:2738} Southwind Village · {area:3425} Cenarion Hold · {object:178553} Hive'Ashi Pod
	-- plural, as words: Tortured Druids = {npc:12178} Tortured Druid
	["The Tortured Druids and Sentinels roam the ruins of {area:2738}, south-east of {area:3425}; the {object:178553} sits on the top floor of its wasp-circled tower."] = "고통받는 드루이드와 감시병이 {area:3425} 남동쪽 {area:2738}의 폐허를 떠돌고, {object:178553}은(는) 말벌이 에워싼 탑 꼭대기 층에 있습니다.",

	-- Step 27: Umber in Nighthaven
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} in {area:2361}"] = "{area:2361}의 {npc:11939}",

	-- Step 28: Quests elsewhere
	["Quests elsewhere"] = "다른 곳의 퀘스트",
	-- {faction:609} Cenarion Circle · {zone:1414} Kalimdor · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {area:2100} Maraudon · {quest:1123} Rabine Saturna · {item:18501} Felvine Shard · {area:2577} Dire Maul
	["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. Forever pays them in full at any level: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) 75 and 75, Corruption of Earth and Seed ({area:2100}, level 51) 150. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "{faction:609}의 다른 퀘스트는 {zone:1414}와 역병지대에 흩어져 있습니다. Forever는 어떤 레벨에서도 정액을 줍니다: 「야생이 고통받는 것도 마찬가지」({npc:10739}, {zone:1422}, 54와 56레벨) 75와 75, 「대지와 씨앗의 오염」({area:2100}, 51레벨) 150. 「지옥덤불의 파편」({quest:1123}, 60레벨, {area:2577}의 칼잔에게서 얻는 {item:18501})은(는) 150을 주고 그 성물함은 어떤 레벨에서도 100을 줍니다.",
	-- {zone:1422} Western Plaguelands · {area:2100} Maraudon
	["Do the {zone:1422} and {area:2100} quests while you level; at 60 they may pay a fraction."] = "레벨을 올리는 동안 {zone:1422}와 {area:2100} 퀘스트를 하고, 60이 되면 일부만 줄 수 있습니다.",

	-- Step 29: Encrypted Twilight Texts to Revered
	-- {quest:8319} Encrypted Twilight Texts
	["{quest:8319} to Revered"] = "{quest:8319}(으)로 매우 우호적까지",
	-- {npc:15306} Bor Wildmane · {quest:8319} Encrypted Twilight Texts · {npc:14479} Twilight Lord Everun · {item:20733} Formula: Enchant Cloak - Greater Nature Resistance · {item:22773} Pattern: Sylvan Crown
	["Honored to Revered is 12,000 reputation. {npc:15306} takes 10 {quest:8319} for 100 reputation, again and again, until Exalted: 120 turn-ins (1,200 texts) to Revered without the quests, or about 950 texts after them. Hand in the texts you saved now. The cultists no longer count, but the Flamereavers, Twilight Keepers, Marauders and Templars count until 11,999 of 12,000 Honored, and the {npc:14479} and Prophet until Exalted. Honored opens Kania's {item:20733} (10g), Mishta's {item:22773} (5g) and Forever's new Honored patterns (7g 50s each)."] = "우호적에서 매우 우호적은 평판 12,000입니다. {npc:15306}이(가) {quest:8319} 10개를 100 평판에 받아 주고, 확고한 동맹까지 반복됩니다: 퀘스트 없이 매우 우호적까지 120번(서류 1,200개), 퀘스트 이후에는 약 950개. 아껴 둔 서류를 지금 반납하세요. 신도는 더 이상 반영되지 않지만, 불타는 약탈자, 황혼의 문지기, 약탈자, 기사는 우호적 12,000 중 11,999까지 반영되고, {npc:14479}과(와) 예언자는 확고한 동맹까지입니다. 우호적이면 카니아의 {item:20733}(10골), 미슈타의 {item:22773}(5골), Forever의 새 우호적 도안(각 7골 50실)이 열립니다.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100"] = "{npc:15306}: 서류 10개, 100",

	-- Step 30: Field Duty, level 60
	-- {quest:8507} Field Duty
	["{quest:8507}, level 60"] = "{quest:8507}, 60레벨",
	-- {npc:15540} Windcaller Kaldon · {area:3425} Cenarion Hold · {quest:8507} Field Duty · {npc:15440} Captain Blackanvil · {area:2743} Hive'Zora · {npc:15612} Krug Skullsplit · {area:2744} Hive'Regal · {item:20809} Tactical Assignment · {item:7936} Ornate Mithril Boots · {npc:15542} Twilight Marauder · {quest:9338} Allegiance to Cenarion Circle
	-- plural, as words: Heavy Runecloth Bandages = {item:14530} Heavy Runecloth Bandage
	["{npc:15540} stands by the moonwell of {area:3425}. {quest:8507} (25 reputation, repeatable) sends you with unsigned papers to your side's captain: {npc:15440}'s Ironforge Brigade outside {area:2743} (Alliance) or {npc:15612}'s Orgrimmar Legion outside {area:2744} (Horde). Use the papers first, then talk to the captain: a level 60 elite silithid attacks; keep the captain alive and he signs. Kaldon then lets you pick a Combat, Logistics or {item:20809}, each holding a random briefing worth 50 reputation and a badge: 30 hive silithid kills (elites), goods such as 30 Heavy Runecloth Bandages or 3 {item:7936}, or one Templar, {npc:15542} or scout report. One badge of each kind buys {quest:9338} at Kaldon: 200 reputation, repeatable. A full round is about 375 reputation."] = "{npc:15540}은(는) {area:3425}의 달샘 옆에 서 있습니다. {quest:8507}(평판 25, 반복 가능)이(가) 서명되지 않은 서류를 들고 진영의 대장에게 보냅니다: {area:2743} 밖 {npc:15440}의 스톰윈드 여단(얼라이언스) 또는 {area:2744} 밖 {npc:15612}의 오그리마 군단(호드). 먼저 서류를 사용한 뒤 대장에게 말을 거세요: 60레벨 정예 실리시드가 공격하고, 대장을 살려 두면 서명합니다. 이어서 칼던이 전투, 보급, 또는 {item:20809} 중 하나를 고르게 하고, 각각 무작위 브리핑 50 평판과 배지가 들어 있습니다: 우리 실리시드 30 처치(정예), 두꺼운 룬매듭 붕대 30개나 {item:7936} 3개 같은 물자, 또는 기사, {npc:15542}, 정찰 보고서 하나. 각 종류 배지 하나씩이 칼던에게 {quest:9338}을(를) 사 줍니다: 평판 200, 반복 가능. 한 바퀴면 약 375 평판입니다.",
	["Allegiance: one Combat, Logistics and Tactical badge, 200"] = "충성: 전투, 보급, 전술 배지 하나씩, 200",
	-- {quest:8800} Cenarion Battlegear · {npc:15176} Vargus
	["{quest:8800}: {npc:15176}'s badge gear"] = "{quest:8800}: {npc:15176}의 배지 장비",

	-- Step 31: Templars and the Abyssal Council
	["Templars and the Abyssal Council"] = "기사와 심연 의회",
	-- {object:180456} Lesser Wind Stone · {item:20513} Abyssal Crest · {quest:8361} Abyssal Contacts · {npc:15270} Huum Wildmane · {quest:8331} Aurel Goldleaf · {item:14344} Large Brilliant Shard · {object:180461} Wind Stone · {item:20514} Abyssal Signet
	["Wearing a full set of Twilight Trappings (cultist Cowl, Mantle and Robe, about 8%, 8% and 6% per cultist) lets you use a {object:180456}: two stand in each of the three western camps. A random Abyssal Templar appears: a level 60 elite for 1 to 3 players, 5 reputation until the top of Honored and an {item:20513} 93% of the time. The summon uses up the set (and later the medallion and ring too), and if the elemental gets away they are gone: summon only when you can win. {quest:8361} pays 100 for the first crest; after that Bor takes 3 crests for 50. From Friendly, {npc:15270} sends you to {quest:8331}: 3 crests and a {item:14344} buy the Medallion of Station that, worn with a set, opens the larger {object:180461} for a Duke (level 62 elite, group of 5; 25 reputation, {item:20514} 85%)."] = "황혼 의복 세트(신도의 두건, 어깨걸이, 로브, 신도당 각각 약 8%, 8%, 6%)를 완전히 입으면 {object:180456}을(를) 쓸 수 있습니다: 서쪽 야영지 세 곳에 각각 둘씩 서 있습니다. 무작위 심연의 기사가 나타납니다: 1~3인용 60레벨 정예로, 우호적 정점까지 평판 5, {item:20513}은(는) 93%의 경우 나옵니다. 소환은 세트(나중에는 메달과 반지도)를 소모하고, 정령이 달아나면 사라집니다: 이길 수 있을 때만 소환하세요. {quest:8361}이(가) 첫 문장에 100을 주고, 이후 보르가 문장 3개를 50에 받습니다. 약간 우호적부터 {npc:15270}이(가) {quest:8331}(으)로 보냅니다: 문장 3개와 {item:14344}이(가) 직급의 메달을 사 주고, 세트와 함께 착용하면 62레벨 정예 공작(5인 파티, 평판 25, {item:20514} 85%)을 위해 더 큰 {object:180461}을(를) 엽니다.",
	-- {item:20513} Abyssal Crest
	["{item:20513}: Templar, group of 1 to 3"] = "{item:20513}: 기사, 1~3인 파티",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Friendly"] = "{npc:15270}, 약간 우호적",
	-- {item:14344} Large Brilliant Shard
	["3 crests and a {item:14344}: the Medallion of Station"] = "문장 3개와 {item:14344}: 직급의 메달",
	-- {item:20514} Abyssal Signet
	["{item:20514}: Duke, group of 5"] = "{item:20514}: 공작, 5인 파티",

	-- Step 32: Signets and scepters to Exalted
	["Signets and scepters to Exalted"] = "인장과 왕홀로 확고한 동맹까지",
	-- {quest:8363} Abyssal Signets · {npc:15282} Aurel Goldleaf · {item:20515} Abyssal Scepter · {quest:9248} A Humble Offering · {quest:8343} Goldleaf's Discovery · {quest:8341} Lords of the Council · {object:180466} Greater Wind Stone · {item:22252} Satchel of Cenarius · {item:22660} Gaea's Embrace · {item:22756} Sylvan Vest · {npc:15176} Vargus
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["Revered to Exalted is 21,000 reputation: 210 text turn-ins (2,100 texts), or less with the rest. From Honored, Bor takes 3 {quest:8363} for 100 (each Duke also gives 25, to Exalted), and {npc:15282} takes one {item:20515} for {quest:9248} (200, once). From Revered, {quest:8343} leads to {quest:8341}: 3 signets and 5 Large Brilliant Shards buy the Ring of Lordship, and set, medallion and ring open the {object:180466} for an Abyssal Lord: a level 63 boss for a raid of about 20, 50 reputation, and an {item:20515}. Bor pays 200 for the first scepter and 150 for each 3 after. Revered opens Mishta's {item:22252} (5g), {item:22660} (9g) and {item:22756} (5g); Exalted is the standing for Champion's Battlegear at {npc:15176}."] = "매우 우호적에서 확고한 동맹은 평판 21,000입니다: 서류 210번(2,100개), 나머지를 쓰면 더 적게. 우호적부터 보르가 {quest:8363} 3개를 100에 받고(각 공작도 확고한 동맹까지 25를 주며), {npc:15282}이(가) {item:20515} 하나를 {quest:9248}에 받습니다(200, 한 번). 매우 우호적부터 {quest:8343}이(가) {quest:8341}(으)로 이어집니다: 인장 3개와 눈부신 큰 결정 5개가 지배의 인장을 사 주고, 세트, 메달, 반지가 심연의 군주(약 20인 레이드용 63레벨 우두머리, 평판 50, {item:20515})를 위해 {object:180466}을(를) 엽니다. 보르는 첫 왕홀에 200, 이후 3개마다 150을 줍니다. 매우 우호적은 미슈타의 {item:22252}(5골), {item:22660}(9골), {item:22756}(5골)을 열고, 확고한 동맹은 {npc:15176}의 챔피언 전투복 등급입니다.",
	["10 texts: 100"] = "서류 10개: 100",
	-- {quest:8363} Abyssal Signets
	["3 {quest:8363}: 100, Honored"] = "{quest:8363} 3개: 100, 우호적",
	-- {item:20515} Abyssal Scepter
	["{item:20515}: Lord, raid of 20"] = "{item:20515}: 군주, 20인 레이드",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Revered"] = "{npc:15270}, 매우 우호적",
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["3 signets and 5 Large Brilliant Shards: the Ring of Lordship"] = "인장 3개와 눈부신 큰 결정 5개: 지배의 인장",
	-- {quest:8364} Abyssal Scepters
	["3 {quest:8364}: 150, Revered"] = "{quest:8364} 3개: 150, 매우 우호적",

	-- Step 33: The Ruins of Ahn'Qiraj, when they open
	-- {area:3454} Ruins of Ahn'Qiraj
	["The {area:3454}, when they open"] = "열리면 {area:3454}",
	-- {area:2737} Scarab Wall · {zone:1451} Silithus · {quest:8791} The Fall of Ossirian · {npc:15185} Brood of Nozdormu · {npc:15498} Windcaller Yessendra · {npc:15500} Keyl Swiftclaw · {npc:15499} Warden Haro · {npc:16091} Dirk Thunderwood · {quest:9023} The Perfect Poison · {item:22217} Kurinnaxx's Venom Sac · {area:19} Zul'Gurub · {npc:15471} Lieutenant General Andorov · {item:22219} Plans: Jagged Obsidian Shield · {item:22191} Obsidian Mail Tunic
	["A 20-player raid behind the {area:2737} in the far south-west of {zone:1451}. A full clear is about 1,600 Cenarion reputation: the trash 3 each until 20,999 of 21,000 Revered, Kurinnaxx, Moam, Buru and Ayamiss 150 each and Ossirian 300, to Exalted. Ossirian's head starts {quest:8791} (200 here and 200 {npc:15185}). Their drops buy the ring (Honored), cloak (Revered) and weapon (Exalted) quests of {npc:15498}, {npc:15500} and {npc:15499} in the Hold, 100 reputation each. {npc:16091} in the Hold pays 100 once for {quest:9023}: {item:22217} from here and Venoxis's from {area:19}. {npc:15471} sells {item:22219} (Revered, 5g) and {item:22191} (Exalted, 8g) inside."] = "{zone:1451} 먼 남서쪽 {area:2737} 뒤의 20인 레이드입니다. 전체 공략이면 세나리온 평판 약 1,600입니다: 잡몹이 매우 우호적 21,000 중 20,999까지 하나에 3, 카르낙스, 모암, 부루, 아야미스가 각각 150, 오시리안이 300으로 확고한 동맹까지입니다. 오시리안의 머리가 {quest:8791}을(를) 시작합니다(여기 200, {npc:15185} 200). 그들의 전리품이 전초기지의 {npc:15498}, {npc:15500}, {npc:15499}에게 반지(우호적), 망토(매우 우호적), 무기(확고한 동맹) 퀘스트를 사 주며 각각 평판 100입니다. 전초기지의 {npc:16091}이(가) {quest:9023}에 한 번 100을 줍니다: 여기서 나오는 {item:22217}과 {area:19}에서 나오는 베녹시스의 것. {npc:15471}이(가) 내부에서 {item:22219}(매우 우호적, 5골)와 {item:22191}(확고한 동맹, 8골)을 팝니다.",

	-- Step 34: Venoxis's Venom Sac, Zul'Gurub
	-- {quest:9023} The Perfect Poison · {npc:14507} High Priest Venoxis · {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale
	["Optional, for {quest:9023}: {npc:14507} is the first boss of {area:19}, a 20-player raid in north-east {zone:1434}."] = "선택 사항, {quest:9023}용: {npc:14507}은(는) {zone:1434} 북동부에 있는 20인 레이드 {area:19}의 첫 우두머리입니다.",
	-- {item:22216} Venoxis's Venom Sac
	["{item:22216}: raid of 20"] = "{item:22216}: 20인 레이드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "심연의 문장, 심연의 인장, 심연의 홀은 시작 퀘스트를 마치면 {npc:15306}에게 반복해서 제출할 수 있습니다.",
	-- ["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "암호화된 황혼의 문서는 반복 퀘스트입니다. {npc:15306}이(가) 문서를 계속 받습니다. 신도 야영지에서 모으십시오.",
	-- ["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "이제부터는 {area:3454} 공격대와 Abyssal Council 반납품(문장, 인장, 홀)이 평판 대부분을 줍니다.",
	-- ["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "황혼의 야영지에서 계속 사냥하십시오. Twilight Trappings(황혼의 신도 세트와 {npc:15282}의 황혼의 신도 계급장 퀘스트에서 얻는 계급장)를 착용하면 바람의 돌에서 Abyssal Templar를 소환할 수 있으며, 그들의 심연의 문장은 {npc:15306}에게 가져가십시오.",
	-- ["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "확고한 동맹이 될 때까지 {area:3454}을(를) 계속 돌고 Abyssal Council 휘장을 제출하십시오.",
	-- ["Optional, 100 reputation once: {quest:9419}. Your side's camp sits by a hive: {npc:17080}'s by {area:2743} (Alliance), {npc:17079}'s by {area:2744} (Horde). Silithyst rises from glowing geysers around the desert: walk through one, carry the Silithyst to your camp's Silithyst Extractor, then talk to the camp's leader. It is a world PvP objective: players of the other side can take it from you."] = "선택 사항, 한 번만 평판 100: {quest:9419}. 진영 야영지는 우리 옆에 있습니다: {npc:17080}은(는) {area:2743} 옆(얼라이언스), {npc:17079}은(는) {area:2744} 옆(호드)에 있습니다. 실리시스트는 사막 주변의 빛나는 간헐천에서 솟아오릅니다: 하나를 지나 실리시스트를 야영지의 실리시스트 추출기로 운반한 뒤 야영지 지도자에게 말을 거세요. 월드 PvP 목표입니다: 상대 진영 플레이어가 빼앗을 수 있습니다.",
	-- ["Silithyst"] = "실리시스트",
	-- ["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "황혼의망치단 신도들이 {zone:1451} 서부의 야영지를 차지하고 있습니다. 이곳에는 {quest:8320}와(과) 황혼의 돌소환사가 섞여 있으며, 어느 신도든 {item:20404}을(를) 떨어뜨릴 수 있습니다. 신도를 처치할 때마다 {faction:609} 평판도 오릅니다. 대지술사는 60레벨이고 {quest:8320}을(를) 수락했을 때만 집계됩니다.",
	-- ["deliver Silithyst at the extractor"] = "추출기에서 실리시스트 전달",
	-- ["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425}은(는) {zone:1451} 중북부의 성벽 마을입니다. 보르 와일드메인과 {npc:15270}이(가) 안에 함께 있습니다. {faction:609} 평판은 중립에서 시작합니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{faction:609} to Exalted"] = "{faction:609} 확고한 동맹까지",
	-- ["{faction:609} to Honored"] = "{faction:609} 우대까지",
	-- ["{faction:609} to Revered"] = "{faction:609} 존경까지",
	-- ["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: 암호화된 황혼의 문서",
	-- ["{quest:8320} needs level 60"] = "{quest:8320}은(는) 60레벨 필요",
}
