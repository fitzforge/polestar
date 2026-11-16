-- Korean (koKR): the guide forever/alliance/40-50/01b-riverglades (forever/alliance/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16724} Farholde Keep
	["About 90 quests in Forever's new zone, 42 to 45, from {area:16724}: the level for its port and Western Front."] = "Forever의 새 지역에서 약 90개 퀘스트, 42~45레벨, {area:16724}에서 시작: 항구와 서부 전선을 위한 레벨입니다.",

	-- Step 1: Ironforge flight master
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",
	-- {zone:1426} Dun Morogh · {zone:1455} Ironforge · {area:69} Lakeshire
	["The Stranglethorn guide leaves Dwarves and Gnomes at their riding trainer in {zone:1426}: ride back west into {zone:1455}, where the flight to {area:69} leaves from the gryphon master."] = "가시덤불 골짜기 가이드는 드워프와 노움을 {zone:1426}의 탈것 상급자에게서 끝냅니다. 서쪽으로 {zone:1455}에 돌아가면 그리폰 조련사에게서 {area:69}행 비행편을 탈 수 있습니다.",

	-- Step 2: Into the Riverglades
	-- {zone:2548} Riverglades
	["Into the {zone:2548}"] = "{zone:2548}으로",
	-- {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass · {zone:2548} Riverglades · {area:16737} Bristle Hills
	["Fly from {zone:1455} to {area:69} in Redridge, then follow the road north out of town and up through {area:2417}: it comes down into the western {zone:2548} by the {area:16737}."] = "{zone:1455}에서 붉은마루 산맥의 {area:69}까지 날아간 뒤, 길을 따라 마을 북쪽으로 나가 {area:2417}을 넘으세요. 길은 {area:16737} 옆 {zone:2548} 서부로 내려옵니다.",
	-- {zone:2548} Riverglades
	["The western {zone:2548}"] = "{zone:2548} 서부",

	-- Step 3: Scout Bolain
	-- {npc:260026} Scout Bolain
	["{npc:260026} waits beside the road east of the pass."] = "{npc:260026}은(는) 고개 동쪽 길가에서 기다립니다.",

	-- Step 4: Southern Watch
	-- {area:16744} Southern Watch
	["Follow the road east to {area:16744}, the Alliance outpost above the river. The gnolls you passed on the way in are Captain Dalton's job: you go back for them after the lumber camp."] = "길을 따라 동쪽으로 강 위의 얼라이언스 전초기지인 {area:16744}까지 가세요. 오는 길에 지나친 놀은 달튼 대장의 일입니다. 벌목장 다음에 처치하러 돌아옵니다.",
	-- {quest:95148} Southern Watch Gnoll Report · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95148}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95148}: {area:16724}의 {npc:257558}에게 줄 것, 보관하세요",

	-- Step 5: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906}은(는) {area:16737}의 남서쪽 야영지를 돌아다니는 정예 놀(40레벨)입니다. 파티를 권장합니다.",

	-- Step 6: Turner's Logging Camp
	-- {npc:256438} Halligan Turner
	["North up the road to the lumber camp. {npc:256438} runs it; his third job, the saplings, comes once his plant food is in."] = "길을 따라 북쪽 벌목장으로 가세요. {npc:256438}이(가) 운영합니다. 세 번째 일인 묘목은 식물 비료를 건넨 뒤에 나옵니다.",

	-- Step 7: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp on the slopes all the way from the hills west of the lumber camp to the pass you came in by. The stolen saw blades lie only in the western camps, near the pass.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "서쪽 {area:16737}으로 가세요. 붉은마루 놀은 벌목장 서쪽 언덕부터 들어온 고개까지 비탈 곳곳에 진을 치고 있습니다. 도난당한 톱날은 고개 근처 서쪽 야영지에만 있습니다.\n주의: 정예 놀(40레벨) {npc:255906}이(가) 남서쪽 야영지를 돌아다닙니다. 놀들을 그에게서 떼어내 끌어오세요.",

	-- Step 9: Southern Watch
	-- {area:16744} Southern Watch
	["Back east along the road to {area:16744}."] = "길을 따라 동쪽 {area:16744}으로 돌아가세요.",

	-- Step 11: Gelinda Coppergleam
	-- {area:16744} Southern Watch · {npc:262399} Gelinda Coppergleam
	["South-west past {area:16744}: {npc:262399}, a prospector, has camped by the Cinderscale dragonkin's hollow."] = "{area:16744}을(를) 지나 남서쪽으로 가십시오: 탐광꾼 {npc:262399}이(가) 잿빛비늘 용족의 분지 옆에 야영하고 있습니다.",

	-- Step 12: The Cinderscale hollow
	["The Cinderscale hollow"] = "잿빛비늘 분지",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors (level 41-42) guard its back, by the {item:271611}. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "새끼용은 분지 곳곳에 둥지를 틀고 있고, 전사(41-42레벨)는 분지 안쪽 {item:271611} 옆을 지킵니다. 희귀 정예 비룡 스칼다론도 이곳에 나타날 수 있습니다: 파티가 없다면 건드리지 마십시오.",

	-- Step 14: Holmsby farm
	["Holmsby farm"] = "홈스비 농장",
	-- {area:16744} Southern Watch
	["Back past {area:16744} and south to the Holmsbys' farm by the river."] = "{area:16744}을(를) 다시 지나 남쪽 강가의 홈스비 농장으로 가십시오.",

	-- Step 15: Benjy Wheeler
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner
	["North-east across the fields to {area:16725}: {npc:258317} wants the Mudfin murlocs on the river thinned out, the same murlocs whose heads {npc:256438} needs, so one pass along the river does both."] = "들판을 가로질러 북동쪽 {area:16725}(으)로 가십시오: {npc:258317}은(는) 강가의 진흙지느러미 멀록 수를 줄여 달라고 합니다. {npc:256438}에게 필요한 머리도 같은 멀록에게서 나오므로, 강을 따라 한 번만 돌면 둘 다 끝납니다.",

	-- Step 16: Meadowsbrook and the river
	-- {area:16735} Meadowsbrook
	["{area:16735} and the river"] = "{area:16735}와(과) 강",
	-- {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner · {npc:258588} Jumbo Crawfish · {npc:258935} Curly · {npc:259049} Robbie Holmsby · {area:16735} Meadowsbrook · {npc:263380} Ghostmaw
	-- plural, as words: Mudfin Warriors = {npc:258574} Mudfin Warrior
	["Back south-west along the river: kill the Mudfin Warriors and Oracles on the banks for {npc:258317} (they drop {npc:256438}'s heads) and the {npc:258588} in the shallows for the shells. {npc:258935}, one of {npc:256438}'s lumberjacks, is stuck on the bank just north-west of the murlocs; {npc:259049}'s hat lies on the riverbank among them; the fresh manure is in the fields of {area:16735}, between the river and the farm. {npc:263380}, an elite (level 42), prowls the river: if he comes your way, back off and let him pass."] = "강을 따라 남서쪽으로 돌아가십시오: {npc:258317}을(를) 위해 강둑의 진흙지느러미 전사와 진흙지느러미 점쟁이를 처치하고({npc:256438}의 머리를 떨어뜨립니다), 껍데기를 얻으려면 얕은 물의 {npc:258588}을(를) 처치하십시오. {npc:256438}의 벌목꾼 중 하나인 {npc:258935}은(는) 멀록들 바로 북서쪽 강둑에 갇혀 있습니다. {npc:259049}의 모자는 멀록들 사이 강둑에 있고, 신선한 거름은 강과 농장 사이 {area:16735}의 들판에 있습니다. 정예 {npc:263380}(42레벨)이(가) 강을 배회합니다: 다가오면 물러나서 지나가게 두십시오.",

	-- Step 18: Watcher Fredericks
	-- {npc:259051} Watcher Fredericks · {area:16744} Southern Watch
	["{npc:259051} keeps the west end of {area:16744}."] = "{npc:259051}은(는) {area:16744}의 서쪽 끝을 지킵니다.",

	-- Step 19: Turner's Logging Camp
	["North up the road to the lumber camp."] = "길을 따라 북쪽의 벌목장으로 가십시오.",

	-- Step 20: Saplings
	["Saplings"] = "묘목",
	-- {npc:256438} Halligan Turner · {item:266161} Tree Sprouting Kit
	["Use {npc:256438}'s {item:266161} on bare ground around the camp: five saplings."] = "{npc:256438}의 {item:266161}을(를) 벌목지 주변 맨땅에 사용하십시오: 묘목 5그루.",

	-- Step 21: Hurley
	-- {npc:258963} Hurley · {npc:258935} Curly · {quest:94861} Helping Hands · {npc:263380} Ghostmaw
	["{npc:258963} stands at the camp's south end. He sets off for {npc:258935}, south-east of the camp, as soon as you take {quest:94861}: go with him and keep the attackers off, and wait if {npc:263380} is in sight. If it fails, {npc:258963} offers the quest again."] = "{npc:258963}은(는) 벌목지 남쪽 끝에 서 있습니다. {quest:94861}을(를) 수락하면 바로 벌목지 남동쪽의 {npc:258935}에게 출발합니다: 함께 가며 공격자를 막고, {npc:263380}이(가) 보이면 기다리십시오. 실패하면 {npc:258963}에게서 퀘스트를 다시 받을 수 있습니다.",
	-- {npc:258963} Hurley · {npc:258935} Curly
	["go with {npc:258963} to save {npc:258935}"] = "{npc:258963}와(과) 함께 {npc:258935} 구출",

	-- Step 23: Wheeler's Grange
	-- {area:16724} Farholde Keep · {npc:258317} Benjy Wheeler · {area:16725} Wheeler's Grange
	["East along the road towards {area:16724}: hand {npc:258317} his murlocs as you pass {area:16725}."] = "길을 따라 동쪽 {area:16724} 쪽으로 가십시오: {area:16725}을(를) 지나며 {npc:258317}에게 멀록을 넘겨주십시오.",

	-- Step 24: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257087} Gretchen Mayberry · {npc:260070} Bertrand Ironbrow · {npc:260080} Ember Bladewhisper · {npc:263613} Brother Lowley · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["On east along the road to {area:16724}. {npc:257087}, the gryphon master, stands at its western gate; {npc:260070} and {npc:260080} are on the way in, {npc:263613} tends the wounded by the barracks, {npc:257558} and {npc:257591} wait in the keep at the east end, and the inn is in the south of the walls."] = "길을 따라 계속 동쪽 {area:16724}(으)로 가십시오. 그리폰 조련사 {npc:257087}은(는) 서쪽 문에 서 있고, {npc:260070}와(과) {npc:260080}은(는) 들어가는 길에 있습니다. {npc:263613}은(는) 병영 옆에서 부상자를 돌보고, {npc:257558}와(과) {npc:257591}은(는) 동쪽 끝 성채 안에서 기다립니다. 여관은 성벽 안 남쪽에 있습니다.",
	-- {npc:257087} Gretchen Mayberry
	["{npc:257087}, at the western gate"] = "{npc:257087}, 서쪽 문",
	-- {npc:257558} Demar Brant
	["{npc:257558}, in the keep"] = "{npc:257558}, 성채 안",
	-- {quest:94877} Saving Sunnyglade
	["{quest:94877}: for later in this guide"] = "{quest:94877}: 이 가이드 후반용",
	-- {npc:257591} Ashe Amberhall · {quest:94881} Curious Trinkets
	["{npc:257591}: {quest:94881}, for later in this guide"] = "{npc:257591}: {quest:94881}, 이 가이드 후반용",
	-- {quest:94879} Scraps of Knowledge
	["{quest:94879}, for later in this guide"] = "{quest:94879}, 이 가이드 뒷부분용",
	-- {npc:259863} Cassandra Wheeler · {quest:95330} Love Thy Neighbor · {area:16736} Turner's Logging Camp
	["{npc:259863}, by the inn: {quest:95330}, for {area:16736} later in this guide"] = "{npc:259863}, 여관 옆: {quest:95330}, 이 가이드 뒷부분의 {area:16736}용",
	-- {npc:257595} Barracks Master Harlan
	["{npc:257595}, at the inn"] = "{npc:257595}, 여관에서",

	-- Step 25: The cathedral
	["The cathedral"] = "대성당",
	-- {npc:262031} Sister Rowland · {area:16724} Farholde Keep · {npc:272437} Marla Bell · {npc:271742} Abbot Schuncke
	["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} sells the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031}은(는) {area:16724} 남서쪽 구석의 옛 대성당을 지키고 있습니다. 박쥐는 대성당 위층에 둥지를 틀고 있고, 그 옆에서 {npc:272437}이(가) 신성한 양초를 팔며, 무덤은 예배당 묘지에 있습니다.\n53레벨 정예인 {npc:271742}이(가) 대성당 안에 서 있습니다: 먼저 공격하지 않으니 절대 공격하지 말고, 박쥐는 그에게서 떨어진 곳으로 끌어내십시오.",
	-- {item:17028} Holy Candle · {npc:272437} Marla Bell
	["{item:17028}, from {npc:272437}"] = "{item:17028}, {npc:272437}에게서",
	-- {item:269997} Bundle of Candles
	["{item:269997}, on the graves"] = "무덤 위의 {item:269997}",

	-- Step 26: Wheeler's Grange
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler
	["West to {area:16725}: {npc:258317} stands by the farmhouse."] = "서쪽 {area:16725}(으)로: {npc:258317}이(가) 농가 옆에 서 있습니다.",

	-- Step 27: The stables
	["The stables"] = "마구간",
	["Search around the stables south of the farmhouse for the horses' tracks; the bundles of hay lie around the farm."] = "농가 남쪽 마구간 주변에서 말 발자국을 찾으십시오. 건초 더미는 농장 곳곳에 있습니다.",

	-- Step 29: The coyote den
	["The coyote den"] = "코요테 굴",
	-- {npc:258522} Sootfur
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The coyotes den in the hills south of the farm: {npc:258522}, the big dark one, sits at the back of it; the Plains Coyotes around it drop the pelts."] = "코요테 굴은 농장 남쪽 언덕에 있습니다: 크고 어두운 색의 {npc:258522}이(가) 굴 안쪽에 있고, 주변의 평원 코요테가 가죽을 떨어뜨립니다.",

	-- Step 30: The lost horse
	["The lost horse"] = "잃어버린 말",
	["One of Benjy's horses ran north up the river, past the farm. Give it the feed, then lead it home."] = "벤지의 말 한 마리가 농장을 지나 강을 따라 북쪽으로 달아났습니다. 먹이를 준 뒤 집으로 데려가십시오.",
	-- {area:16725} Wheeler's Grange
	["walk it back to {area:16725}"] = "{area:16725}까지 걸어서 데려가기",

	-- Step 32: Foreman's Crate
	-- {area:16729} Terral's Watch
	["North up the track towards {area:16729}: the foreman's crate lies by the road."] = "길을 따라 북쪽 {area:16729} 방향으로: 십장의 상자가 길가에 있습니다.",

	-- Step 33: Terral's Watch
	-- {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{npc:259352} holds {area:16729}, the tower on the plains north-east of the crate."] = "{npc:259352}은(는) 상자 북동쪽 평원의 탑인 {area:16729}에 있습니다.",

	-- Step 34: The plains
	["The plains"] = "평원",
	-- {quest:95983} A Feast for Buzzards · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Poachers = {npc:259052} Rog'mar Poacher
	["The Rog'mar Poachers hunt the plains north of the tower; the Wildplains lions roam among them. A picked carcass lies in the grass east of the tower: its skull starts {quest:95983}.\nCareful: {npc:263380}, an elite (level 42), hunts along the river west of the plains: keep an eye on the riverbank."] = "로그마르 밀렵꾼은 탑 북쪽 평원에서 사냥하고, 그 사이로 들평원 사자가 돌아다닙니다. 탑 동쪽 풀밭에 뼈만 남은 사체가 있습니다: 그 두개골로 {quest:95983}이(가) 시작됩니다.\n주의: 정예(42레벨)인 {npc:263380}이(가) 평원 서쪽 강을 따라 사냥합니다: 강변을 잘 살피십시오.",

	-- Step 35: Terral's Watch
	-- {quest:94928} A Few Furs for Friz · {area:16727} Powderfuse Port
	["{quest:94928}: for {area:16727}, keep it"] = "{quest:94928}: {area:16727}용, 보관하십시오",
	-- {quest:95984} Song of the Strider · {npc:263367} Sleebo Fizzlespout
	["{quest:95984}: for later, where the tallstriders graze by {npc:263367}'s workshop; keep it"] = "{quest:95984}: 나중에 {npc:263367}의 작업장 옆 타조가 풀을 뜯는 곳에서 합니다. 보관하세요",
	-- {quest:95064} Preventative Measures · {area:16743} Rog'mar
	["{quest:95064}: for later, at the Horde's training grounds north of {area:16743}"] = "{quest:95064}: 나중에 {area:16743} 북쪽 호드 훈련장에서 합니다",
	-- {quest:96125} In Need of Relief · {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["{quest:96125}: for {npc:259057} in {area:16726}, keep it"] = "{quest:96125}: {area:16726}의 {npc:259057}에게 줄 것, 보관하세요",
	-- {quest:95426} Rog'mar Supplies
	["{quest:95426}: for later, the same training grounds"] = "{quest:95426}: 나중에 같은 훈련장에서 합니다",

	-- Step 36: Farholde Keep
	-- {area:16724} Farholde Keep
	["South back to {area:16724}."] = "남쪽 {area:16724}(으)로 돌아가십시오.",
	-- {quest:96009} High Stakes · {area:16736} Turner's Logging Camp
	["{quest:96009}: for {area:16736} later in this guide"] = "{quest:96009}: 이 가이드 후반 {area:16736}에서 합니다",

	-- Step 37: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch · {npc:259859} Wheatley
	["{npc:263380} is an elite (level 42) who hunts along the river between {area:16725} and {area:16729}, on your way north later in this guide: grouping up is advised. The poster hangs by the keep; {npc:259859}, who takes the fang, stands south of the inn."] = "{npc:263380}은(는) {area:16725}와(과) {area:16729} 사이 강을 따라 사냥하는 정예(42레벨)로, 이 가이드 후반 북쪽으로 가는 길에 있습니다: 파티를 권장합니다. 현상수배 전단은 성채 옆에 걸려 있고, 송곳니를 받는 {npc:259859}은(는) 여관 남쪽에 서 있습니다.",
	-- {object:645166} WANTED! (no name in this language: may be words)
	["the {object:645166} poster"] = "{object:645166} 전단",

	-- Step 38: WANTED: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo · {area:16743} Rog'mar
	["{npc:263071} is an elite (level 42) at the Horde's training grounds north of {area:16743}, where this guide goes later: grouping up is advised."] = "{npc:263071}은(는) {area:16743} 북쪽 호드 훈련장에 있는 정예(42레벨)로, 이 가이드에서 나중에 갑니다: 파티를 권장합니다.",
	-- {object:707245} Wanted (no name in this language: may be words)
	["the {object:707245} poster"] = "{object:707245} 전단",

	-- Step 39: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch
	["{npc:263380}, the elite, hunts along the river between {area:16725} and {area:16729}, on your way north."] = "정예인 {npc:263380}은(는) 북쪽으로 가는 길에 {area:16725}와(과) {area:16729} 사이 강을 따라 사냥합니다.",

	-- Step 40: Sunnyglade
	-- {area:16724} Farholde Keep · {area:16729} Terral's Watch · {area:16723} Sunnyglade · {area:16743} Rog'mar · {npc:259158} Fuzzle · {npc:256831} Apprentice Claire · {npc:258697} Farmer Elbrim
	["North from {area:16724}, past {area:16729} and across the river, to {area:16723}, the farm town the Twilight cult holds; keep clear of {area:16743}, the Horde's fort east of the town. {npc:259158} the kobold hides in the middle of the town, {npc:256831} at its eastern edge, and {npc:258697} waits at his farm on the north-eastern edge."] = "{area:16724}에서 북쪽으로 {area:16729}을(를) 지나 강을 건너, 황혼의 교단이 장악한 농촌 마을 {area:16723}(으)로 가십시오. 마을 동쪽의 호드 요새 {area:16743}에는 가까이 가지 마십시오. 코볼트 {npc:259158}은(는) 마을 한가운데 숨어 있고, {npc:256831}은(는) 동쪽 끝에, {npc:258697}은(는) 북동쪽 끝 자기 농장에서 기다립니다.",

	-- Step 41: The Twilight cult
	["The Twilight cult"] = "황혼의 교단",
	-- {area:16723} Sunnyglade · {item:266148} Farmers' Mementos · {item:4338} Mageweave Cloth · {npc:263613} Brother Lowley · {area:16724} Farholde Keep · {quest:94885} Field Marshal's Log · {npc:256899} Chogg'Zac · {npc:263380} Ghostmaw
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["The cultists fill the streets and fields of {area:16723}. Start at the ritual circles in the middle (fill Claire's catalyst there), work west through the burnt houses to the edge of town, then back north-east to the loose soil west of Elbrim's farm: bury the {item:266148} the Twilight Raiders drop there. The charms, pages and finger bones drop from the cultists.\nKeep the {item:4338} they drop: {npc:263613} in {area:16724} asks for twenty when you are back there. Now and then a cultist drops the {quest:94885}: right-click it to start the quest.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass; players died here more than anywhere else in the zone.\n{npc:263380}, the river's elite (level 42), can wander up from the south-western fields: let him pass."] = "교단원들이 {area:16723}의 거리와 들판을 메우고 있습니다. 한가운데 의식의 원에서 시작해(거기서 클레어의 촉매를 채우십시오), 불탄 집들을 지나 서쪽 마을 끝까지 간 뒤, 북동쪽 엘브림 농장 서쪽의 무른 흙으로 돌아오십시오: 황혼의 약탈자가 떨어뜨리는 {item:266148}을(를) 그곳에 묻으십시오. 부적, 책장, 손가락뼈는 교단원에게서 나옵니다.\n교단원이 떨어뜨리는 {item:4338}은(는) 보관하세요: {area:16724}의 {npc:263613}이(가) 돌아가면 20개를 요구합니다. 가끔 교단원이 {quest:94885}을(를) 떨어뜨립니다: 우클릭하여 퀘스트를 시작하십시오.\n주의: 정예 오우거 {npc:256899}(41레벨)이(가) {area:16723} 서쪽 거리 44-47,47-52 부근을 돌아다닙니다. 교단원을 끌어내고 그가 지나가게 두십시오. 이 지역에서 플레이어가 가장 많이 죽은 곳입니다.\n강의 정예 {npc:263380}(42레벨)이(가) 남서쪽 들판에서 올라올 수 있습니다: 지나가게 두십시오.",
	-- {item:269990} Crystal Catalyst
	["fill the {item:269990} at the ritual circles"] = "의식의 원에서 {item:269990} 채우기",
	-- {object:621813} Loose Soil (no name in this language: may be words)
	["{object:621813}: bury the mementos"] = "{object:621813}: 유품 묻기",
	-- {quest:94885} Field Marshal's Log
	["{quest:94885}: only if a cultist dropped the log"] = "{quest:94885}: 교단원이 일지를 떨어뜨린 경우에만",

	-- Step 43: Cut Off the Heads
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{npc:256899}, the two-headed ogre, is an elite (level 41) at the western edge of {area:16723}: grouping up is advised. Claire then has the filled catalyst for {npc:257591} in {area:16724}."] = "머리 둘 달린 오우거 {npc:256899}은(는) {area:16723} 서쪽 끝의 정예(41레벨)입니다: 파티를 권장합니다. 이어서 클레어가 {area:16724}의 {npc:257591}에게 줄 채워진 촉매를 건넵니다.",
	-- {quest:94884} An Unsettling Discovery · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{quest:94884}: for {npc:257591} in {area:16724}"] = "{quest:94884}: {area:16724}의 {npc:257591}에게",

	-- Step 44: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158}은(는) {area:16723}을(를) 빠져나가고 싶어 합니다: 서쪽 마을 끝의 보물까지 데려가며 교단원을 막아 주십시오.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "{npc:259158}을(를) {area:16723} 밖으로 데리고 마을 서쪽의 보물까지 가십시오",

	-- Step 45: Farmer Elbrim
	["Back east through the town to Elbrim's farm: the doll and the locket are in the burnt farmhouse beside it."] = "마을을 지나 다시 동쪽 엘브림의 농장으로 가십시오. 인형과 목걸이는 그 옆의 불탄 농가에 있습니다.",

	-- Step 46: The Rog'mar training grounds
	-- {area:16743} Rog'mar
	["The {area:16743} training grounds"] = "{area:16743} 훈련장",
	-- {area:16743} Rog'mar · {npc:263071} Blademaster Kaijo · {npc:263615} Krek the Noxious
	-- plural, as words: Rog'mar Grunts = {npc:255996} Rog'mar Grunt
	["North-east of Elbrim's farm, the Horde drills its trainees in the fields north of {area:16743}. Stay north of the fort: its guards are far above your level. The supply crates lie around the drill grounds. Three elites work this ground: {npc:263071} (42) walks among the trainees, {npc:263615} (42) lurks at the north end, and Komuk (45), a Horde elite, patrols the hills to the east; give each of them room.\nCareful: Rog'mar Grunts (55) guard the fort's north wall, around 59,39 to 61,41. Leave the crates and trainees by the wall and take the ones further north, around 57-61,34-37."] = "엘브림의 농장 북동쪽, {area:16743} 북쪽 들판에서 호드가 훈련병들을 훈련시킵니다. 요새 북쪽에 머무르십시오. 요새 경비병은 당신보다 레벨이 훨씬 높습니다. 보급품 상자는 훈련장 곳곳에 있습니다. 이곳에는 정예 셋이 있습니다. {npc:263071}(42)은(는) 훈련병들 사이를 걸어 다니고, {npc:263615}(42)은(는) 북쪽 끝에 숨어 있으며, 호드 정예 코무크(45)는 동쪽 언덕을 순찰합니다. 모두 거리를 두십시오.\n주의: 로그마르 그런트(55)가 59,39에서 61,41 부근 요새 북쪽 성벽을 지킵니다. 성벽 근처의 상자와 훈련병은 두고, 더 북쪽인 57-61,34-37 부근의 것을 노리십시오.",

	-- Step 47: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo
	["{npc:263071}, the elite, walks the training grounds."] = "정예 {npc:263071}은(는) 훈련장을 걸어 다닙니다.",

	-- Step 48: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "{npc:263367}의 작업장",
	-- {area:16743} Rog'mar · {npc:263367} Sleebo Fizzlespout · {area:16726} Bolder'ok
	["South-east, round {area:16743}'s east side, to {npc:263367}'s workshop on the hill. Komuk and the {area:16726} ogres walk the road east of the fort: let them pass before you cross it."] = "남동쪽으로 {area:16743}의 동쪽을 돌아 언덕 위 {npc:263367}의 작업장으로 가십시오. 코무크와 {area:16726} 오우거들이 요새 동쪽 길을 걸어 다니니, 지나갈 때까지 기다렸다 길을 건너십시오.",

	-- Step 49: The tallstriders and the marsh
	["The tallstriders and the marsh"] = "타조와 습지",
	-- plural, as words: Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Roving Tallstriders graze the meadows south-west of the workshop; further south-west the marsh bubbles with gas: fill the vials at the vents."] = "떠도는 타조는 작업장 남서쪽 초원에서 풀을 뜯습니다. 더 남서쪽 습지에는 가스가 끓어오르니, 분출구에서 약병을 채우십시오.",

	-- Step 50: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower stands just south-west of the marsh."] = "{npc:259352}의 탑은 습지 바로 남서쪽에 있습니다.",
	-- {quest:95066} The Rog'mar Situation · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95066}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95066}: {area:16724}의 {npc:257558}에게 제출하니, 보관하십시오",

	-- Step 51: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257591} Ashe Amberhall · {npc:257558} Demar Brant · {area:16723} Sunnyglade · {npc:263089} Tessa Dawnbright · {npc:263613} Brother Lowley
	["South across the plains to {area:16724}: {npc:257591} and {npc:257558} stand together in the keep at the east end, {npc:257591} first, her news is what Brant's next orders wait on. With {area:16723} saved, {npc:263089} by the orchard and {npc:263613} by the barracks have work for you too."] = "평원을 건너 남쪽 {area:16724}(으)로 가십시오. {npc:257591}와(과) {npc:257558}은(는) 동쪽 끝 성채에 함께 있습니다. {npc:257591}부터 만나십시오. 그녀의 소식이 있어야 브랜트의 다음 명령이 나옵니다. {area:16723}을(를) 구했으니 과수원 옆의 {npc:263089}와(과) 막사 옆의 {npc:263613}도 일을 줍니다.",
	-- {quest:94907} A Small Favor
	["{quest:94907}: for later in this guide"] = "{quest:94907}: 이 가이드 후반에 진행합니다",
	-- {quest:95329} Out in the Field · {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{quest:95329}: for {npc:259352} at {area:16729}, keep it"] = "{quest:95329}: {area:16729}의 {npc:259352}에게 제출하니, 보관하십시오",
	-- {quest:94886} The Western Front
	["{quest:94886}: for later in this guide"] = "{quest:94886}: 이 가이드 후반에 진행합니다",
	-- {npc:263613} Brother Lowley · {item:4338} Mageweave Cloth · {area:16723} Sunnyglade
	["{npc:263613}: twenty {item:4338}, from {area:16723}'s cultists and the pirates; hand it in when you are back"] = "{npc:263613}: {area:16723}의 광신도와 해적에게서 얻는 {item:4338} 20개. 돌아오면 제출하십시오",

	-- Step 52: Tessa Dawnbright
	-- {npc:263089} Tessa Dawnbright
	["{npc:263089} stands west of the inn, by the orchard: the apples hang on the trees around it."] = "{npc:263089}은(는) 여관 서쪽 과수원 옆에 있습니다. 사과는 주변 나무에 달려 있습니다.",

	-- Step 53: Coyote pelts
	["Coyote pelts"] = "코요테 가죽",
	-- {area:16725} Wheeler's Grange
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The Plains Coyotes roam west and south-west of the keep, towards {area:16725}."] = "평원 코요테는 성채 서쪽과 남서쪽, {area:16725} 방향으로 돌아다닙니다.",

	-- Step 54: Tessa Dawnbright
	-- {quest:95961} Stepped Out · {npc:263120} Gray Dawnbright · {area:16727} Powderfuse Port
	["{quest:95961}: for {npc:263120} in {area:16727}, keep it"] = "{quest:95961}: {area:16727}의 {npc:263120}에게 제출하니, 보관하십시오",

	-- Step 55: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16729} Terral's Watch
	["{npc:263315}, an elite lion (level 41), prowls the plains north of {area:16729}, on your way back north: grouping up is advised."] = "정예 사자(41레벨)인 {npc:263315}이(가) {area:16729} 북쪽 평원을 배회합니다. 북쪽으로 돌아가는 길에 있으니 파티를 권장합니다.",

	-- Step 57: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to {npc:263367}'s workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "북동쪽 {npc:263367}의 작업장으로 가십시오. {npc:263367}의 스트레스 테스트는 작업장 옆의 G45-B4G와 싸우는 것입니다. 쓰러뜨리면 퀘스트를 제출하십시오.",
	["the stress test: beat G45-B4G beside the workshop"] = "스트레스 테스트: 작업장 옆의 G45-B4G 쓰러뜨리기",

	-- Step 58: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:263120} Gray Dawnbright · {npc:255894} Innkeeper Zizplink · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz · {npc:260487} Gritta Chumwater · {npc:260565} Kor'gar · {npc:260560} Krikshank
	["East down the road to {area:16727}, the goblins' harbour. {npc:255897} keeps a stall at the west end of the docks; {npc:263120}, {npc:255894} and {npc:259962} are at the inn, and {npc:259961} works the north pier. Zizplink's drink needs three things the port's traders sell: the chum from {npc:260487}, the degreaser and the old poison from {npc:260565} and {npc:260560}, by {npc:255897}'s stall."] = "길을 따라 동쪽, 고블린 항구인 {area:16727}(으)로 내려가십시오. {npc:255897}은(는) 부두 서쪽 끝에 노점을 차렸고, {npc:263120}, {npc:255894}, {npc:259962}은(는) 여관에, {npc:259961}은(는) 북쪽 부두에서 일합니다. 지즈플링크의 음료에는 항구 상인들이 파는 세 가지가 필요합니다. {npc:260487}의 미끼, 그리고 {npc:255897}의 노점 옆에 있는 {npc:260565}와(과) {npc:260560}의 탈지제와 오래된 독극물입니다.",
	-- {quest:95059} Frazzlespark's Crate · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95059}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95059}: {area:16724}의 {npc:257558}에게 줄 것이니 보관하십시오",
	-- {item:271657} Fresh Chum · {npc:260487} Gritta Chumwater
	["{item:271657}, from {npc:260487}"] = "{item:271657}, {npc:260487}에게서",
	-- {item:271653} Goblin Degreaser · {npc:260565} Kor'gar
	["{item:271653}, from {npc:260565}"] = "{item:271653}, {npc:260565}에게서",
	-- {item:271654} Expired Poison · {npc:260560} Krikshank
	["{item:271654}, from {npc:260560}"] = "{item:271654}, {npc:260560}에게서",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "여관 옆 {object:628948} 벽보: {npc:260235}",

	-- Step 59: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001}은(는) 남쪽 해안의 정예(42레벨)입니다. 파티를 권장합니다.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "여관 옆 {object:628948} 벽보",

	-- Step 60: The murlocs, south-west
	["The murlocs, south-west"] = "남서쪽의 멀록",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "항구에서 해안을 따라 남서쪽으로 가십시오. 바닷물 멀록이 해변에 진을 치고 있습니다. 가는 길에 길가에 칠한 가죽이 펼쳐져 있는데, 부두의 {npc:260231}을(를) 위한 {quest:95260}이(가) 시작됩니다.",

	-- Step 62: Back through the port
	["Back through the port"] = "항구를 거쳐 돌아가기",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "해안을 따라 북쪽으로 돌아가십시오. 게들에게 가는 길에 부두에서 멀록 퀘스트와 가죽 퀘스트를 제출하십시오.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms are for later"] = "{quest:95261}: 짐승 내장은 진행하며 모이고, 버섯은 나중에 합니다",

	-- Step 63: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "게와 {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962} and the spittle for Zizplink, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "부두에서 해변을 따라 북쪽으로 가십시오. 게들은 {npc:259962}에게 줄 고기와 지즈플링크에게 줄 침을 떨어뜨리고, 그 내장은 {npc:260231}의 퀘스트에 포함됩니다. 큰 게인 {npc:260235}은(는) 부두 동쪽 바위를 따라 돌아다닙니다. 49레벨 희귀 정예 {npc:259758}이(가) 부두에서 해적 야영지까지 이 해안을 배회합니다. 보이면 멀리 피하십시오.",

	-- Step 64: The Eastsea pirates
	["The Eastsea pirates"] = "동부해 해적",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "해안을 따라 북동쪽, 절벽 위 해적 야영지로 가십시오. 해적과 머스킷병이 밀수품을 지니고 있습니다. {npc:259758}도 야영지를 돌아다니니 주의하십시오.",

	-- Step 65: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "북쪽 부두에서 서쪽으로 선착장을 지나 항구로 돌아가십시오.",
	-- {quest:95122} Unchecked Expansion
	["{quest:95122}: for later in this guide"] = "{quest:95122}: 이 가이드 후반에 진행",
	-- {quest:95123} A Blast Ye Scurvy Dogs!
	["{quest:95123}: for later in this guide"] = "{quest:95123}: 이 가이드 후반에 진행",
	-- {quest:95975} Her World
	["{quest:95975}: for later, the wildflowers west of the port"] = "{quest:95975}: 나중에, 항구 서쪽의 들꽃",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: 해적 야영지의 {npc:260390}에게",

	-- Step 67: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "이동하며 {item:268632} 모으기",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42), Komuk (a Horde elite, 45) and {npc:263380} (elite, 42) range over the zone's wilds: take your beasts away from them."] = "{zone:2548}의 야수 대부분이 {npc:260231}에게 줄 {item:268632}을(를) 떨어뜨립니다. 이 해안의 해안 게와 해적 서쪽 능선의 멧돼지가 좋습니다.\n주의: {npc:257001}(정예, 42), 코무크(호드 정예, 45), {npc:263380}(정예, 42)이(가) 지역의 야생을 돌아다닙니다. 이들에게서 멀리 떨어져 사냥하십시오.",

	-- Step 68: Level 44.4 on the Eastsea pirates
	["Level 44.4 on the Eastsea pirates"] = "동부해 해적에게서 44.4레벨까지 사냥",
	-- {npc:259758} Gul'gash · {area:1517} Uldaman
	["Before the second wave: its raiders and bombardiers (43-45) and the pirates' ships after them are a level over you below 44.4. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "두 번째 무리 전에: 그 약탈자와 폭격수(43-45), 그리고 그다음의 해적선은 44.4레벨 미만이면 당신보다 한 레벨 높습니다. 항구에서 떨어진 첫 번째 야영지 남서쪽 끝의 해적과 머스킷병(41-43)으로 경험치를 채우십시오. 49레벨 희귀 정예 {npc:259758}이(가) 이 절벽을 돌아다닙니다. 보이면 멀리 피하십시오. 또는 파티가 있다면 대신 {area:1517} 던전을 도십시오.",
	-- {npc:257901} Eastsea Buccaneer
	["grind on {npc:257901}"] = "{npc:257901} 사냥",

	-- Step 69: The pirates' second wave
	["The pirates' second wave"] = "해적의 두 번째 무리",
	-- {npc:259758} Gul'gash
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. They stand close together: pull them one at a time. {npc:259758}, a rare elite of level 49, roams these cliffs and the beach below: if you see him, keep well away."] = "항구에서 해안을 따라 북쪽으로: 동해 약탈자와 폭격수가 해적 야영지 서쪽 비탈의 화약통 사이에 자리 잡고 있습니다. 서로 붙어 있으니 하나씩 끌어내십시오. 49레벨 희귀 정예 {npc:259758}이(가) 이 절벽과 아래 해변을 돌아다닙니다. 보이면 멀리 피하십시오.",

	-- Step 70: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "절벽을 따라 동쪽으로 해적 야영지 맨 끝까지 가십시오. {npc:260390}이(가) 물가에, 그 옆에 {npc:260391}이(가) 있습니다.",

	-- Step 71: Powderfuse Port
	["Back to the port."] = "항구로 돌아가십시오.",

	-- Step 72: The pirates' ships
	["The pirates' ships"] = "해적선",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} (level 45) stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way."] = "다시 해적 절벽으로 가십시오. 야영지 아래 정박한 배 세 척에 남쪽부터 북쪽 순서로 위즈버즈의 폭약을 설치하십시오. {quest:95124}(45레벨)은(는) 가운데 배 옆에 전리품 상자와 함께 있습니다. 가는 길에 {npc:259758}을(를) 주의하십시오.",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, 남쪽 배",
	["the middle ship"] = "가운데 배",
	["the northern ship"] = "북쪽 배",

	-- Step 73: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "부패살점 버섯",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "북쪽 배에서 서쪽으로 능선을 오르십시오. 부패살점 버섯은 황혼의 망치 오우거 야영지 근처 바위 사이에 자랍니다. 능선의 다 자란 흰엄니도 내장을 줍니다.",

	-- Step 74: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:259057} Dunston Willis
	["North-west to {area:16726}, the ogres' town. Its ogres side with the Horde and attack you on sight, and Clugfist on his hill in the middle is an elite (level 50): keep to the town's north-eastern edge, where {npc:259057} hides."] = "북서쪽의 오우거 마을 {area:16726}(으)로 가십시오. 이곳 오우거는 호드 편이라 보는 즉시 공격하며, 한가운데 언덕의 클러그피스트는 정예(50레벨)입니다. {npc:259057}이(가) 숨어 있는 마을 북동쪽 가장자리로 다니십시오.",

	-- Step 75: Gronok's Key
	-- {npc:263749} Gronok the Butcher · {npc:259057} Dunston Willis · {item:275043} Bloodmaster's Ring
	["{npc:263749} (level 44) carries the key: he paces the lanes south of {npc:259057}'s hut.\nThe {item:275043} lies just west of the lanes: its fighters (elites, 41-45) only fight in a bout, so leave them be."] = "{npc:263749}(44레벨)이(가) 열쇠를 지니고 있습니다. {npc:259057}의 오두막 남쪽 골목을 오갑니다.\n{item:275043}은(는) 골목 바로 서쪽에 있습니다. 그곳 투사들(정예, 41-45)은 시합 중에만 싸우니 내버려 두십시오.",

	-- Step 76: Dunston Willis
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["Free him, then get him out: {npc:259057} fights his way out of {area:16726}, and you keep the ogres off him. If he falls, take the quest from him again."] = "그를 풀어 준 뒤 데리고 나가십시오. {npc:259057}이(가) 싸우며 {area:16726}을(를) 빠져나가는 동안 오우거가 그를 공격하지 못하게 막으십시오. 그가 쓰러지면 퀘스트를 다시 수락하십시오.",
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["help {npc:259057} break out of {area:16726}"] = "{npc:259057}이(가) {area:16726}에서 탈출하도록 돕기",

	-- Step 77: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "{item:268632} 마저 모으기",
	-- {npc:259758} Gul'gash
	["South-east out of the hills towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "언덕에서 남동쪽 항구 쪽으로 나가십시오. 부두 북쪽 해변의 해안 게가 내장을 가장 빨리 모으는 방법입니다. {npc:259758}도 이 해변까지 내려와 돌아다닙니다.",

	-- Step 78: Powderfuse Port
	["Down to the port."] = "항구로 내려가십시오.",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: 항구 남서쪽 얕은 물, 정예 {npc:257001} 근처의 큰 야수",

	-- Step 79: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244}은(는) 항구 남서쪽, 멀록 해변 아래 얕은 물을 배회합니다. 정예인 {npc:257001}이(가) 근처 해안을 걸어 다니니 거리를 두십시오.",

	-- Step 81: The meadows
	["The meadows"] = "초원",
	-- {npc:263367} Sleebo Fizzlespout
	["West of the port, the wildflowers grow in the meadows below {npc:263367}'s workshop."] = "항구 서쪽, {npc:263367}의 작업장 아래 초원에 야생화가 자랍니다.",

	-- Step 82: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257558} Demar Brant
	["South-west across the plains to {area:16724}: {npc:257558} in the keep at the east end."] = "남서쪽으로 평원을 가로질러 {area:16724}(으)로 가십시오. {npc:257558}은(는) 동쪽 끝 성채에 있습니다.",

	-- Step 83: Demar Brant
	-- {quest:94887} Saving Marshal Ryan
	["{quest:94887}: for later in this guide"] = "{quest:94887}: 이 가이드 후반용",

	-- Step 86: Brother Lowley
	-- {npc:263613} Brother Lowley · {npc:262031} Sister Rowland
	["{npc:263613} tends the wounded beside the barracks: bandage three of his soldiers, then he has a note for {npc:262031} in the cathedral."] = "{npc:263613}은(는) 병영 옆에서 부상병을 돌보고 있습니다. 병사 세 명에게 붕대를 감아 주면 대성당의 {npc:262031}에게 보낼 쪽지를 줍니다.",
	-- {item:272126} Makeshift Bandages
	-- plural, as words: Wounded Soldiers = {npc:263614} Wounded Soldier
	["{item:272126}, on the Wounded Soldiers beside him"] = "{item:272126}, 그의 옆에 있는 부상당한 병사들에게",

	-- Step 87: Farholde Keep, the west side
	-- {area:16724} Farholde Keep
	["{area:16724}, the west side"] = "{area:16724}, 서쪽",
	-- {npc:263089} Tessa Dawnbright · {npc:259859} Wheatley
	["West through the keep: {npc:263089} by the orchard, then the cathedral and {npc:259859} south of the inn if you have their errands."] = "성채를 지나 서쪽으로 가십시오. 과수원 옆의 {npc:263089}, 그다음 심부름이 있다면 대성당과 여관 남쪽의 {npc:259859}에게 들르십시오.",

	-- Step 88: Sister Rowland
	-- {quest:96084} Something's in the Water
	["{quest:96084}: for later in this guide"] = "{quest:96084}: 이 가이드 후반용",

	-- Step 90: Something's in the Water
	-- {area:16729} Terral's Watch · {npc:262031} Sister Rowland
	["North past {area:16729}: fill {npc:262031}'s phial in the marsh water north-east of the tower."] = "북쪽으로 {area:16729}을(를) 지나 탑 북동쪽 습지 물에 {npc:262031}의 약병을 채우십시오.",

	-- Step 91: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower."] = "{npc:259352}의 탑.",

	-- Step 93: Turner's Logging Camp
	-- {area:16736} Turner's Logging Camp · {npc:263380} Ghostmaw
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["West across the river to {area:16736}: the Peasant Woodpiles around the camp give the wood bundles.\nCareful: {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "강을 건너 서쪽 {area:16736}(으)로 가십시오. 야영지 주변의 농부 장작더미에서 나무 묶음을 얻습니다.\n주의: 정예 {npc:263380}(42레벨)이(가) 야영지 옆 강을 배회합니다. 다가오면 물러나서 지나가게 두십시오.",

	-- Step 94: Sergeant Riftan
	-- {area:16685} Twilight's Shroud · {npc:258023} Sergeant Riftan
	["North up the long valley towards {area:16685}: {npc:258023} holds a small camp below the Twilight cult's fortress."] = "긴 골짜기를 따라 북쪽 {area:16685}(으)로 가십시오. {npc:258023}은(는) 황혼의 교단 요새 아래 작은 야영지에 있습니다.",

	-- Step 95: The Twilight camps
	["The Twilight camps"] = "황혼의 야영지",
	-- {npc:258652} Twilight Thrall · {npc:257591} Ashe Amberhall · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The cult's camps fill the valley north and west of Riftan. Free the captive Farholde Scouts as you find them, and kill a {npc:258652} for {npc:257591}: her soulstone takes it. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them."] = "교단의 야영지가 리프탄 북쪽과 서쪽 골짜기를 채우고 있습니다. 붙잡힌 파홀드 정찰병을 보이는 대로 풀어 주고, {npc:257591}을(를) 위해 {npc:258652}을(를) 처치하십시오. 그녀의 영혼석이 그것을 담습니다. 황혼의 집행자(정예, 45레벨)가 야영지를 순찰하니 끌어오기 전마다 이동 경로를 확인하십시오. {npc:256881}와(과) {npc:256891}(정예, 46)이(가) 골짜기 끝의 요새를 지키고 있으니 교단원을 그들에게서 떨어뜨려 끌어내십시오.",
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout
	["free five captive Farholde Scouts"] = "붙잡힌 파홀드 정찰병 다섯 명 풀어 주기",
	-- {npc:258652} Twilight Thrall
	["kill a {npc:258652}"] = "{npc:258652} 처치",

	-- Step 96: Marshal Ryan
	-- {npc:257250} Marshal Ryan · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	["{npc:257250} lies wounded among the camps at the valley's western edge.\nCareful: {npc:256881} and {npc:256891} (elites, 46) hold the fortress north of him: come at Ryan from the south."] = "{npc:257250}은(는) 골짜기 서쪽 끝 야영지 사이에 부상당한 채 쓰러져 있습니다.\n주의: {npc:256881}와(과) {npc:256891}(정예, 46)이(가) 그의 북쪽 요새를 지키고 있습니다. 라이언에게는 남쪽에서 접근하십시오.",
	-- {npc:257250} Marshal Ryan
	["find {npc:257250} and talk to him"] = "{npc:257250}을(를) 찾아 대화하기",
	-- {quest:94892} Dying Wish · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:94892}: for {npc:257558} in {area:16724}"] = "{quest:94892}: {area:16724}의 {npc:257558}에게",

	-- Step 97: The ogre mine
	["The ogre mine"] = "오우거 광산",
	-- plural, as words: Twilight Subjugators = {npc:260996} Twilight Subjugator · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine, driven by the Twilight Subjugators.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in, and pull the miners and Subjugators back out to you."] = "야영지 북쪽 광산에서 교단이 황혼의 정복자를 시켜 오우거 광부들을 부리고 있습니다.\n주의: 황혼의 집행자(정예, 45레벨)가 야영지를 오가며 광산 입구를 지나갑니다. 지나간 뒤에 들어가고, 광부와 정복자는 밖으로 끌어내십시오.",

	-- Step 99: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881}은(는) 골짜기 끝 요새에 있는 정예(46레벨)이며 주위에 집행자들이 있습니다. 파티를 권장합니다.",
	-- {quest:94891} News to Farholde · {npc:257591} Ashe Amberhall
	["{quest:94891}: for {npc:257591}"] = "{quest:94891}: {npc:257591}에게",

	-- Step 100: Back to Farholde Keep
	-- {area:16724} Farholde Keep
	["Back to {area:16724}"] = "{area:16724}(으)로 귀환",
	-- {area:16724} Farholde Keep
	["Your hearthstone is bound at {area:16724}'s inn: use it, or ride back south to the keep."] = "귀환석이 {area:16724} 여관에 지정되어 있습니다. 사용하거나 남쪽 성채로 말을 타고 돌아가십시오.",

	-- Step 101: Farholde Keep
	-- {npc:260070} Bertrand Ironbrow · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["From the inn: {npc:260070} on the way in, then {npc:257558} and {npc:257591} in the keep."] = "여관에서: 들어가는 길에 {npc:260070}, 이어서 성채 안의 {npc:257558}와(과) {npc:257591}.",

	-- Step 103: Demar Brant
	-- {quest:94893} Delivering Closure · {npc:278088} Abigail Lawson · {zone:1453} Stormwind
	["{quest:94893}: for {npc:278088} in {zone:1453}"] = "{quest:94893}: {zone:1453}의 {npc:278088}에게",

	-- Step 104: The Twilight Threat
	-- {npc:257558} Demar Brant · {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:257558}: Kilgar's head for {npc:1748} in {object:2117}"] = "{npc:257558}: 킬가르의 머리를 {object:2117}의 {npc:1748}에게",

	-- Step 105: Sister Rowland
	-- {npc:262031} Sister Rowland
	["{npc:262031}, in the cathedral at the keep's south-west corner."] = "{npc:262031}, 성채 남서쪽 모퉁이의 대성당에 있습니다.",

	-- Step 106: Stormwind
	-- {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind · {npc:278088} Abigail Lawson · {object:2098} Cathedral Square
	["{npc:257087} flies to {zone:1453}. {npc:278088} waits in the {object:2098}."] = "{npc:257087}을(를) 통해 {zone:1453}(으)로 날아갈 수 있습니다. {npc:278088}은(는) {object:2098}에서 기다리고 있습니다.",

	-- Step 108: Train before the Badlands
	-- {zone:1418} Badlands
	["Train before the {zone:1418}"] = "{zone:1418}에 가기 전에 수련하기",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1425} Hinterlands · {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}, and the {zone:1418} & {zone:1425} guide passes none: {npc:257087} flies to {zone:1453}, where you train before you go on."] = "{zone:2548}에는 직업 상급자가 없고, {zone:1418} & {zone:1425} 가이드도 상급자를 거치지 않습니다: {npc:257087}을(를) 통해 {zone:1453}(으)로 날아가서 계속 가기 전에 수련하십시오.",

	-- Step 109: Your class trainer
	["Your class trainer"] = "직업 상급자",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}: train here in {zone:1453} before you fly on."] = "{zone:2548}에는 직업 상급자가 없습니다: 계속 날아가기 전에 이곳 {zone:1453}에서 수련하십시오.",

	-- Step 110: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 111: Shaman trainer
	["Shaman trainer"] = "",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind · {zone:1418} Badlands · {zone:1425} Hinterlands · {area:1537} Ironforge · {area:144} Thelsamar
	["No shaman trainer stands in the {zone:2548} or in {zone:1453}, and the {zone:1418} & {zone:1425} guide passes none: fly to {area:1537} and train there; {area:144} is a short flight on."] = "{zone:2548}과(와) {zone:1453}에는 주술사 상급자가 없고, {zone:1418} & {zone:1425} 가이드도 상급자를 거치지 않습니다: {area:1537}(으)로 날아가서 수련하십시오. {area:144}은(는) 거기서 조금만 더 날아가면 됩니다.",

	-- Step 112: Leave Stormwind
	-- {zone:1453} Stormwind
	["Leave {zone:1453}"] = "{zone:1453} 떠나기",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1453} Stormwind · {object:2096} Trade District
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}. {zone:1453}'s gryphon master stands in the {object:2096}."] = "다음 가이드는 {zone:1432} 남쪽의 {zone:1418}에서 시작합니다: {area:144}(으)로 날아가십시오. {zone:1453}의 그리폰 조련사는 {object:2096}에 있습니다.",

	-- Step 113: Loch Modan
	-- {area:144} Thelsamar · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["No flight path to {area:144} yet: go to {zone:1455} (by the {area:2257} from {zone:1453}), ride out of its gates east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "아직 {area:144}(으)로 가는 비행 경로가 없다면: {zone:1453}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 간 뒤, 성문을 나와 동쪽으로 {zone:1426}을(를) 지나 터널을 통해 {zone:1432}(으)로 들어가서 길을 따라 {area:144}까지 가십시오.",

	-- Step 114: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "{area:144}(으)로 비행",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}."] = "다음 가이드는 {zone:1432} 남쪽의 {zone:1418}에서 시작합니다: {area:144}(으)로 날아가십시오.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:17028}, from {npc:272437}"] = "{npc:272437}에게서 {item:17028}",
	-- ["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} hands out the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031}은(는) {area:16724} 남서쪽 구석의 옛 대성당을 지키고 있습니다. 박쥐는 대성당 위층에 둥지를 틀고 있고, 그 옆에서 {npc:272437}이(가) 신성한 양초를 나눠 주며, 무덤은 예배당 묘지에 있습니다.\n53레벨 정예인 {npc:271742}이(가) 대성당 안에 서 있습니다: 먼저 공격하지 않으니 절대 공격하지 말고, 박쥐는 그에게서 떨어진 곳으로 끌어내십시오.",
}
