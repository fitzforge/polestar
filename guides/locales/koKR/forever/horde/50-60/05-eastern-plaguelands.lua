-- Korean (koKR): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands · {zone:1448} Felwood
	["Western & {zone:1423} & {zone:1448}"] = "서부 역병지대, {zone:1423} & {zone:1448}",
	-- {area:152} The Bulwark · {zone:1448} Felwood · {zone:1452} Winterspring
	["{area:152} and both Plaguelands, then {zone:1448} and {zone:1452}."] = "{area:152}, 양쪽 역병지대, 그다음 {zone:1448}, {zone:1452}.",

	-- Step 1: The Bulwark
	-- {area:199} Felstone Field · {area:152} The Bulwark · {npc:11055} Shadow Priestess Vandis
	["Back west along the road from {area:199} to the {area:152}: {npc:11055} takes the cauldron's report."] = "",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: his termites are in {area:2627}, later in this guide"] = "",

	-- Step 2: Dalson's Tears
	-- {area:199} Felstone Field · {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road past {area:199}, {npc:11077} guards the cauldron at {area:200}: kill him for the key, then use the cauldron."] = "",

	-- Step 4: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "안돌할 감시탑과 저장고",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord
	["Ride south-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by each grain silo on the north side of town, one silo after another, to bring out Temporal Parasites (55-57): fight them one at a time and let the biggest go.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room.\nCareful: Skeletal Warlords, level 56-57 elites, stand by the first and second towers (the south-western and the western one): mark those towers from the far side of the doorway once the Warlord has turned away, and never pull one. Putridius (58, rare) walks among the silos."] = "남서쪽 안돌할로 가십시오. {npc:10667}은(는) 마을 서쪽의 무너진 여관에서 기다립니다. {item:12815}을(를) 가지고 네 탑 각각의 문간에 서서 표시하십시오. 마을 가장자리로 다니십시오. 마을 북쪽의 곡물 창고마다 차례로 {item:12627}을(를) 사용해 시간의 기생충({npc:10717}, 55-57)을 끌어내십시오: 하나씩 싸우고 가장 큰 것은 보내십시오.\n주의: 58-59레벨 정예인 {npc:10996}이(가) {zone:1422}의 다른 많은 곳처럼 안돌할에도 서 있을 수 있습니다: 거리를 두십시오.\n주의: 56-57레벨 정예 해골 전쟁군주({npc:1788})가 첫째와 둘째 탑(남서쪽과 서쪽) 옆에 서 있습니다: 전쟁군주가 돌아섰을 때 문간 반대편에서 그 탑들을 표시하고, 절대 끌어들이지 마십시오. 퓨트리디우스(58, 희귀)가 곡물 창고 사이를 걷습니다.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, 위층",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",

	-- Step 5: Chromie
	["Upstairs"] = "위층",

	-- Step 6: Counting Out Time
	-- {npc:10667} Chromie · {npc:1805} Flesh Golem
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth. A {npc:1805}, a level 56-57 elite, stands among the houses just east of the inn: take the boxes on the west side first and keep clear of it."] = "",

	-- Step 9: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "",

	-- Step 10: Apothecary Dithers
	-- {quest:838} Scholomance · {area:152} The Bulwark
	["Derrington's {quest:838} is offered from level 55: still under 55 here, the next {area:152} stop offers it again."] = "",

	-- Step 11: Skeletal Fragments
	-- {area:152} The Bulwark
	["The skeletons on the fields east of the {area:152} drop the fragments: take them on the ride east."] = "",

	-- Step 12: Target: Writhing Haunt
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt · {npc:11076} Cauldron Lord Razarch
	["East past {area:200} to the {area:202}: {npc:11076} guards its cauldron."] = "",
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark · {zone:1423} Eastern Plaguelands
	["from the cauldron, for {npc:11055} at the {area:152}: on the way back west, after the {zone:1423}"] = "",

	-- Step 13: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "경로의 이전 방문 때 이것을 놓쳤습니다. 지금 이것부터 합니다. 금방 끝나며 뒤에 이어지는 퀘스트를 열어 줍니다.",
	["Inside"] = "내부",

	-- Step 16: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} waits inside the farmhouse at the {area:202}, by the cauldron; his bears roam the hills north and east of it, towards the {zone:1423}."] = "",

	-- Step 17: Diseased Grizzlies
	["Diseased Grizzlies"] = "오염된 불곰",
	["Careful: the grizzlies are 55-56: pull them one at a time."] = "",

	-- Step 19: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "{zone:1423}(으)로",

	-- Step 20: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "길을 따라 동쪽의 {zone:1423}(으)로 가세요. {npc:1855}은(는) 경계의 길 바로 북쪽, {area:2619} 옆의 작은 집에 삽니다. 그의 사냥 퀘스트 세 개는 이 가이드의 지역에서 진행됩니다.",

	-- Step 22: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "{zone:1422}에서 길을 따라 동쪽으로 가서 강을 건너고 {zone:1423} 전체를 가로질러, 동쪽 끝에 있는 {object:92525}의 예배당으로 가세요.",

	-- Step 23: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}의 유령은 남서쪽의 {area:2262} 폐허에 서 있습니다.",

	-- Step 24: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "인형의 머리와 양쪽 몸통은 {npc:10926} 주변의 집들에 있습니다. 가방에서 합치세요.",

	-- Step 25: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "{area:2268}의 {npc:11063}에게 전할 전갈",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "{quest:5152}은(는) 보관하세요. {npc:10927}은(는) {zone:1422}의 {area:197}에 살고 있습니다.",

	-- Step 26: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "잴다르는 {area:2262} 바로 서쪽에 숨어 있습니다.",
	["Below ground"] = "지하",

	-- Step 27: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "주의: {npc:10411}은(는) 전투 중이 아닐 때 투명해지며, 전투가 시작되면 바위날개 가고일을 부릅니다. 3마리만 존재하며 15분마다 다시 나타납니다.",

	-- Step 28: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "{area:2268}(으)로 돌아가기",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "{quest:5211}의 영혼은 이 가이드 후반의 {area:2264} 단계에서 함께 처리합니다. 보관하세요.",

	-- Step 29: Caretaker Alen
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls · {spell:437801} Light's Hope
	["{npc:11038} offers {quest:5281} from level 55; under it, the next {spell:437801} stop offers it again."] = "",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}: for {npc:11140} in {area:2627} later in this guide"] = "",

	-- Step 30: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "{area:2268} 비행 조련사",

	-- Step 31: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "{area:197}(으)로",

	-- Step 32: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "{area:272}에서 길을 따라 북쪽으로 가세요. {npc:10927}의 집은 {area:197}의 길가에 있으며, {npc:10936}의 기념비는 그 뒤 묘지에 있습니다.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, 위층",

	-- Step 33: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "북서쪽의 안도할로 가세요. {npc:10667}은(는) 마을 서쪽의 폐허가 된 여관에서 기다립니다. 안의 해골들은 54-57레벨이니 가장자리로 다니세요.",

	-- Step 34: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "연대기는 안도할 마을 회관의 곰팡이 슨 고서 사이에 있습니다. 맞는 것을 찾을 때까지 열어 보세요.\n주의: {zone:1422}의 다른 여러 곳처럼 안도할에도 58-59레벨 정예인 {npc:10996}이(가) 있을 수 있습니다. 거리를 두세요.",

	-- Step 36: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "{area:2268}(으)로 날아가기",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "남쪽의 {area:272}(으)로 돌아가 {area:2268}(으)로 날아가세요.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "{area:272} 비행 조련사",

	-- Step 37: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls
	["{npc:11038}, if you didn't take {quest:5281} on the last stop"] = "",
	-- {npc:11063} Carlin Redpath · {area:190} Hearthglen
	["{npc:11063}'s Heroes of Darrowshire needs a group in {area:190} and a ride back here at the end: leave it."] = "",

	-- Step 38: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: 만나는 대로 처치하세요",
	-- {item:12957} Shattered Sword of Marduk · {area:2264} Corin's Crossing
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. The {item:12957} lies at the bottom of the gorge west of {area:2264}. Careful: the biggest Plaguehounds are 56, pull them one at a time."] = "",
	-- {area:2264} Corin's Crossing
	["At the bottom of the gorge west of {area:2264}"] = "",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His Ranger hunt (Rangers 59-60, in the north) is above you on this trip: leave it."] = "",

	-- Step 40: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "새끼 역병사냥개와 역병박쥐는 {area:2260} 북쪽 언덕을 돌아다니고, 청소부구더기가 그 사이를 기어다닙니다. 북쪽 {area:2627} 방향으로 나아가세요.",

	-- Step 41: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched · {npc:16184} Nerubian Overseer · {area:2626} Terrorweb Tunnel
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit · Crypt Horrors = {npc:8557} Crypt Horror · Crypt Walkers = {npc:8556} Crypt Walker
	-- was: ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut.\nCareful: Terrordale Spirits (59-60) drift through the north-west corner just north of {npc:11140}'s hut, and Crypt Horrors (57-58) and Crypt Walkers (55-56) stand around it; some of them root you. Walk in slowly and pull one at a time."] = "유령 {npc:11140}은(는) {area:2627} 북서쪽 구석의 오두막 옆에 서 있고, {npc:12384}은(는) 오두막 안에 앉아 있습니다.\n주의: 테러데일 원혼({npc:14564}, 59-60)이 {npc:11140}의 오두막 바로 북쪽 북서쪽 구석을 떠다니고, 지하묘지 괴물({npc:8557}, 57-58)과 지하묘지 보행자({npc:8556}, 55-56)가 그 주변에 서 있습니다. 일부는 묶어 버립니다. 천천히 들어가 하나씩 끌어내십시오."
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut.\nCareful: Terrordale Spirits (59-60) drift through the north-west corner just north of {npc:11140}'s hut, and Crypt Horrors (57-58) and Crypt Walkers (55-56) stand around it; some of them root you. Walk in slowly and pull one at a time.\nCareful: a {npc:16184} (60, elite) walks {area:2627} and the {area:2626} south-west of it. Look for him before you ride in, and wait for him to pass."] = "",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}, 안쪽",

	-- Step 42: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}: 만나는 대로 처치하세요",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "책은 {area:2627}의 폐허가 된 여관에 있습니다. 마을의 언데드는 54-56레벨이니 한 번에 한 마리씩 끌어오세요.\n큰 흰개미집은 {area:2627} 동쪽 언덕 곳곳에 있습니다. 지나가는 흰개미집마다 {item:15042}을(를) 사용하세요.\n주의: 지구라트 파수병(58레벨, 정예)이 마을 동쪽과 북동쪽 지구라트 옆에 서 있습니다. 마을에 가까운 흰개미집을 이용하고 그들을 피하세요.",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}: {item:12846}을(를) 착용하고 있으면 {area:2627}의 언데드가 떨어뜨립니다",

	-- Step 43: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Keep the termites: {npc:11615} at the {area:152} takes them on this guide's ride back west."] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: 만나는 대로 처치하세요",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the Monstrous Plaguebats up to 58: take the 57s one at a time and leave the 58s."] = "",

	-- Step 45: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "해골은 {area:2622}의 황폐의 그림자와 역병의 괴수 사이에 있습니다.",
	["Underwater"] = "물속",

	-- Step 46: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "길을 따라 남쪽의 {area:2264}(으)로 가세요. {item:15447}은(는) 10분 안에 상합니다. 마을의 스컬지를 빨리 처치하고, 일곱 조각을 바로 {item:15454}(으)로 빻으세요.\n주의: 보이지 않는 하수인은 생명력이 40%로 떨어지면 25미터 안의 동료에게 도움을 요청합니다. 전투 중이 아닐 때는 {spell:10228}(으)로 투명해지기도 합니다. 마을 안에서 도움 요청이 일어나면 많은 몹이 전투에 합류할 수 있습니다. 마을 외곽에서 싸우면 이 위험이 줄어듭니다.\n퀘스트 목록에 {quest:5211}이(가) 있으면(이 가이드 시작 부분에서 {npc:11063}에게 받음), 마을 주변의 스컬지가 다로우샤이어 영혼을 남깁니다. 각 영혼에게 말을 걸어 해방하세요. {item:15447} 작업을 시작하기 전에 영혼들을 해방하세요.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "대로우샤이어 영혼 해방: 말 걸기",
	-- {npc:8530} Cannibal Ghoul · {npc:11064} Darrowshire Spirit
	["{npc:8530}: a {npc:11064} rises where one dies"] = "{npc:8530}: 하나가 죽은 자리에 {npc:11064}이(가) 일어납니다",
	-- {npc:8531} Gibbering Ghoul
	["{npc:8531}: leaves a spirit too"] = "{npc:8531}: 영혼도 남깁니다",
	-- {npc:8532} Diseased Flayer
	["{npc:8532}: leaves a spirit too"] = "{npc:8532}: 영혼도 남깁니다",

	-- Step 47: Carlin Redpath
	-- {area:2268} Light's Hope Chapel
	["Ride east along the road to {area:2268}."] = "",

	-- Step 48: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride back west along the road to the {area:2260}."] = "",

	-- Step 49: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride north-west to {npc:1855}'s hut by the {area:2619} and hear him out."] = "",

	-- Step 50: Undercroft
	-- {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft · {area:2260} Marris Stead
	["{npc:11886} lurks in the {area:2261}, the crypt just south of the {area:2260}.\nCareful: about four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 51: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Back north-west to {npc:1855}'s hut."] = "",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next errand, Of Lost Honor, leads into the Mossflayer trolls (57-59) of the far north-east: leave it."] = "",

	-- Step 52: Kirsta Deepshadow
	-- {npc:1855} Tirion Fordring · {zone:1422} Western Plaguelands · {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp · {area:152} The Bulwark
	["Ride west from {npc:1855}'s hut into the {zone:1422}: {npc:11610} hides on the hill north-east of the {area:192}, on the way to the {area:152}."] = "",
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Her Scarlets wait until {npc:11615} has given you the termite barrel at the {area:152}: the barrel goes down in the same lumber mill."] = "",

	-- Step 54: The Bulwark
	-- {area:152} The Bulwark
	["On west to the {area:152}."] = "",

	-- Step 56: High Executor Derrington
	-- {area:152} The Bulwark · {quest:838} Scholomance · {quest:964} Skeletal Fragments · {area:201} Gahrron's Withering
	["Under 55 on the first {area:152} stop? Derrington's {quest:838} is offered now: Dithers' {quest:964} come from the skeletons on the ride back west from {area:201}."] = "",

	-- Step 58: Scarlet Crusade
	["Scarlet Crusade"] = "붉은십자군",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {item:15044} Barrel of Plagueland Termites · {object:177491} Termite Barrel · {quest:5902} A Plague Upon Thee · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Back north-east to the {area:192}: knights and magi work the camp, the medics and hunters camp south of it. In the middle of the lumber mill, stand by the crate and use {npc:11615}'s {item:15044} from your bags to set it on top; then click the {object:177491} that appears: it finishes {quest:5902} and gives the next part for {npc:11615}. Careful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "",

	-- Step 60: Radley and Durgen
	["Radley and Durgen"] = "",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 61: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11610}'s last errand looks over {area:190}, among Scarlets of 58-60: leave it."] = "",

	-- Step 62: Target: Gahrron's Withering
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south-east to {area:201}, the farm under the eastern hills: {npc:11078} (58) guards its cauldron. Kill him for the key, then use the cauldron.\nCareful: Soulwrath is about two levels over you here: clear the ghouls around the cauldron first, start at full health and use your cooldowns on him."] = "",

	-- Step 63: Skeletal Fragments
	-- {area:200} Dalson's Tears · {area:199} Felstone Field
	["On the ride back west, the skeletons on the fields around {area:200} and {area:199} (50-53) drop the fragments."] = "",

	-- Step 64: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "",

	-- Step 66: Class trainer
	["Class trainer"] = "직업 전문가",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Train before the flight."] = "",

	-- Step 67: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "{area:1638}(으)로 날아가기",
	-- {area:1638} Thunder Bluff · {quest:1000} The New Frontier · {zone:1452} Winterspring · {quest:1123} Rabine Saturna · {zone:1450} Moonglade · {zone:1451} Silithus
	["Only if {area:1638}'s {quest:1000} is still open for you (the {zone:1452} guide's stop offers it from level 54): it opens {quest:1123} in {zone:1450} and her {zone:1451} chain, so fly there first."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 68: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "{area:431}(으)로 날아가기",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Then the flight master."] = "",

	-- Step 69: Fly to Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop. Then the flight master."] = "",

	-- Step 70: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033}(드루이드)은(는) {area:1639}에서 배우고, {npc:246344}(성전사)도 도시에 있습니다.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}의 {npc:3033}, {npc:246344}",

	-- Step 71: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {area:1641} Hunter Rise
	["{npc:10881} stands on {area:1641}."] = "",

	-- Step 72: Arch Druid Hamuul Runetotem
	-- {area:1639} Elder Rise
	["Hamuul is on {area:1639}."] = "",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} is in {zone:1450}, later in this guide."] = "",

	-- Step 73: Fly to Splintertree Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456} 비행 조련사",

	-- Step 74: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "",
	-- {npc:10922} Greta Mosshoof · {zone:1413} Barrens
	["{npc:10922}: the Cleansed Water from Islen in the {zone:1413}"] = "",

	-- Step 75: Dousing the Flames of Protection
	-- {area:1763} Jaedenar · {area:1770} Shadow Hold · {item:12906} Purified Moonwell Water
	["Ride north-west to {area:1763} and go down into {area:1770}, the cave in its north: the four braziers stand inside. Use Greta's {item:12906} from your bags on each one. Careful: Shadow Council mobs of level 53-55 fill the cave and often come in linked groups, many with stuns: pull them one group at a time."] = "",

	-- Step 76: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "남쪽 성소로 돌아가세요. 금방입니다.",

	-- Step 77: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar · {npc:9529} Maybess Riverbreeze · {item:11511} Cenarion Beacon
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["{npc:9861}, {npc:9860} and {npc:9517} (57) wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go. Careful: the three bosses fight as a group: kill the nearby mobs first so you don't pull extra enemies. The cultists' Corrupted Soul Shards show only while you carry {npc:9529}'s {item:11511} (from Cleansing Felwood): without it, skip them."] = "",
	-- {npc:9529} Maybess Riverbreeze
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["Corrupted Soul Shards from the cultists, for {npc:9529}' Salve via Hunting"] = "",

	-- Step 78: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Enforcers = {npc:7114} Jaedenar Enforcer
	["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "{item:13140}이(가) 나왔습니다. 그림자 요새의 자에데나르 집행자, 암흑술사, 흑마법사, 군단병이 가끔 지니고 있습니다. 사용해서 퀘스트를 시작한 뒤, 나가는 길에 동굴 남쪽 끝 우리에서 {npc:11018}을(를) 풀어 주세요.",

	-- Step 79: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "{npc:11016}, 지하",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}: lead her out of {area:1770}"] = "",

	-- Step 80: Rescue From Jaedenar
	-- {npc:11018} Arko'narin · {npc:11019} Jessir Moonbow · {area:2479} Emerald Sanctuary
	["Escort {npc:11018}: she first goes to where Lightforge and her gear are held, then out through the cave. Keep her alive: she fights beside you, and the cultists you didn't clear on the way in come at you both. {npc:11019} takes her report at the {area:2479}, next."] = "",
	-- {area:1770} Shadow Hold
	["out of {area:1770}, at its mouth"] = "",

	-- Step 81: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["Back south to the Sanctuary: {npc:9529} takes the shards on the west side of the camp."] = "",

	-- Step 83: Jessir Moonbow
	-- {npc:11019} Jessir Moonbow · {npc:11018} Arko'narin
	["{npc:11019}, at the Sanctuary's east side, takes {npc:11018}'s report."] = "",
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {area:1763} Jaedenar · {zone:1448} Felwood
	["{npc:11019}: {npc:9518}, in {area:1763}, on the last guide's ride north through {zone:1448}"] = "",

	-- Step 84: Deadwood Cauldron
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	-- was: ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "길을 따라 북쪽으로 가세요. 가마솥은 {area:1769} 바로 남서쪽의 {area:1762}에 있습니다. 그곳의 마른가지일족 털보숭이는 적대적입니다."
	["Ride north up the whole {zone:1448} road, past {area:1997}. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 85: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {area:1769} Timbermaw Hold · {npc:11558} Kernda · {zone:1448} Felwood
	["Only if a {quest:8471} dropped for you and you are Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): {npc:11558} waits at the {zone:1448} entrance of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}이(가) 이 주변을 배회합니다. 지도 원 안을 살펴보세요.",

	-- Step 87: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {quest:5527} A Reliquary of Purity · {area:2577} Dire Maul
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}.\n{npc:11801} offers {quest:5527} only after you have been inside {area:2577} once: if he doesn't offer it, carry on without it."] = "",

	-- Step 88: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "두 퀘스트 모두 {zone:1451}(으)로 이어집니다. 보관하세요.",

	-- Step 90: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "터널의 {zone:1452} 출구에서 남쪽 {area:2246}(으)로 가십시오.",

	-- Step 91: Donova Snowden
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086}은(는) 나중에 {zone:1448}에 갈 때 처리합니다. 보관하세요.",

	-- Step 92: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "달빛 깃든 올빼미야수",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "동쪽의 {area:2255}(으)로 가서 북쪽으로 나가세요. 달빛 깃든 올빼미야수는 {area:2241} 남쪽 비탈의 언덕을 돌아다닙니다. 주의: 57-58레벨이니 한 번에 한 마리씩 끌어오세요.\n주의: 60레벨 정예인 헤일스파이트가 {area:2255} 남동쪽 설원에 모여 있고, 그곳에도 달빛 깃든 올빼미야수 몇 마리가 돌아다닙니다. 마을 북쪽 비탈에 머무르세요.",

	-- Step 93: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "온전한 설인 뿔",
	-- {area:2255} Everlook
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "지난 {area:2255} 방문 때 받은 우미의 뿔 퀘스트: 설인 언덕은 {area:2255} 바로 남동쪽에서 시작됩니다. 우두머리 암컷과 수컷만 뿔을 떨어뜨리며, 수컷은 58레벨까지 있으니 한 번에 한 마리씩 끌어오세요.",

	-- Step 94: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook · {zone:2482} Mount Hyjal · {zone:1451} Silithus
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it. {zone:2482} is next: its way in starts here in {area:2255}; {area:976}, Linken's sword and {zone:1451} follow it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "찢어진 두루마리는 {area:2260} 남쪽의 납골당인 {area:2261} 입구에 있습니다.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "터널로 돌아가 {area:618} 출구로 나간 뒤, 남쪽의 {area:2246}(으)로 가세요.",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "터널로 돌아가 {zone:1452} 출구로 나가세요. {npc:11556}은(는) 출구 바로 앞에 서 있습니다.",
	-- ["Back to {area:1638}"] = "{area:1638}(으)로 돌아가기",
	-- ["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "{area:976} 바로 동쪽 묘지에서 {item:11243}을(를) 마시세요. 마시면 죽으며, 유령 상태에서만 그 정북쪽 언덕의 바위 틈에 있는 {npc:9299}을(를) 볼 수 있습니다. 그곳에서 그에게 말을 건 뒤 시체로 달려가 부활하세요. 그가 알려 주는 눈에 띄는 묘비는 그 묘지에 있습니다.",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "{zone:1458}(으)로 날아가 {zone:1454}행 비행선을 탄 뒤 {area:1638}(으)로 날아가세요.",
	-- ["Fly to {area:1099}"] = "{area:1099}(으)로 날아가기",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "{area:1099}(으)로 날아가세요. 히포그리프 둥지는 {zone:1444} 남부에 있으며, 둥지마다 {object:142071}에 쓸 알이 하나씩 있습니다.",
	-- ["Fly to {area:1997}"] = "{area:1997}(으)로 날아가기",
	-- ["Fly to {area:541}"] = "{area:541}(으)로 날아가기",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "{area:541}(으)로 날아간 뒤, 남서쪽으로 운고로 분화구를 지나 {zone:1451}(으)로 가는 고갯길로 가세요. 다음 가이드는 고갯길이 끝나는 {area:3077}에서 시작합니다.",
	-- ["Fly to {area:976}"] = "{area:976}(으)로 날아가기",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "광포한 역병사냥개와 기괴한 역병박쥐는 {area:2273} 남쪽, {area:2272}와(과) {area:2271} 주변 들판에 함께 있습니다.",
	-- ["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "광포한 역병사냥개는 {area:2273} 남쪽 {area:2272}와(과) {area:2271} 주변 들판에 있습니다. 맹독 역병박쥐는 북쪽 들판 위를, 기괴한 역병박쥐는 {area:2272}와(과) {area:2271} 주변을 날아다닙니다. 주의: 사냥개는 57-58레벨, 가장 높은 기괴한 역병박쥐는 58레벨이니 한 번에 한 마리씩 끌어오세요.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "{area:1769}을(를) 지나 터널의 {area:493} 갈래로 가세요. {npc:11801}은(는) {area:2361}에 있습니다.",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "{area:1769}을(를) 지나 터널의 {zone:1450} 갈래로 가세요. {npc:11801}은(는) {area:2361}에 있습니다.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "하메야는 북동쪽 구석, {area:2273}의 이끼껍질부족 트롤 사이에 숨어 있습니다.",
	-- ["Hameya's mound"] = "하메야의 흙더미",
	-- ["Hameya's scroll"] = "하메야의 두루마리",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "귀환석으로 {zone:1454}에 가십시오. 귀환석은 {zone:1447} 가이드 때부터 아직 그곳에 설정되어 있습니다(마법사는 순간이동). 그다음 비행 조련사로 가십시오.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "귀환석으로 {zone:1454}에 가십시오. 귀환석은 {zone:1447} 가이드 때부터 아직 그곳에 설정되어 있습니다(마법사는 순간이동). 비행하기 전에 훈련하십시오.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "귀환석으로 {zone:1454}에 가십시오. 귀환석은 {zone:1447} 가이드 때부터 아직 그곳에 설정되어 있습니다. 그다음 비행 조련사로 가십시오.",
	-- ["Hippogryph eggs"] = "히포그리프 알",
	-- ["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "안쪽: {zone:1447} 가이드 중 {zone:1454}에서 {quest:4493}을(를) 받았다면",
	-- ["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "흰개미는 보관하세요: 다음 가이드에서 {zone:1422}에 갈 때 {area:813}의 {npc:11615}에게 제출합니다.",
	-- ["Level 56"] = "56레벨",
	-- ["On to {zone:1451}"] = "{zone:1451}(으)로",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "{area:1641}에 있습니다. 양모 옷감, 비단 옷감, 마법 옷감을 가방에 넣어 두세요.",
	-- ["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "{quest:8471}을(를) 얻었을 때만: {npc:11558}은(는) {area:1769}의 {zone:1448} 쪽 입구에서 기다리며, 나무구렁 평판이 중립일 때만 말을 겁니다.",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "아직 {quest:2741}을(를) 가지고 있을 때만: {area:1099}에서 남쪽으로 가세요. 히포그리프 둥지는 {zone:1444} 남부에 있으며, 둥지마다 에그-오-매틱에 쓸 알이 하나씩 있습니다.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "역병사냥개와 새끼 역병사냥개는 예배당 남서쪽 호숫가를 돌아다닙니다.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "역병사냥개와 그 새끼들은 예배당 남서쪽 호숫가를 돌아다니며, 역병박쥐와 청소부구더기도 같은 곳에 있습니다. 주의: 가장 높은 역병사냥개는 56레벨이니 한 번에 한 마리씩 끌어오세요.\n부러진 검은 호수 북서쪽 땅에 있습니다.",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "동쪽의 {area:2255}(으)로 가서 북쪽으로 나가세요. 달빛 깃든 올빼미야수는 {area:2241} 남쪽 비탈의 언덕을 돌아다닙니다. 한 번에 한 마리씩 끌어오세요.\n주의: 60레벨 정예인 Hailspite가 {area:2255} 남동쪽 설원에 모여 있고, 그곳에도 달빛 깃든 올빼미야수 몇 마리가 돌아다닙니다. 마을 북쪽 비탈에 머무르세요.",
	-- ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "길을 따라 북쪽으로 가세요. 가마솥은 {area:1769} 바로 남서쪽의 {area:1762}에 있습니다. 그곳의 마른가지일족 털보숭이는 적대적입니다.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "오두막에서 길을 따라 남쪽의 {area:2264}(으)로 가세요. {item:15447}은(는) 10분 안에 상합니다. 마을의 스컬지를 빨리 처치하고, 일곱 조각을 바로 {item:15454}(으)로 빻으세요.\n주의: 보이지 않는 하인은 생명력이 40%로 떨어지면 25미터 안의 동료에게 도움을 요청합니다. 전투 중이 아닐 때는 {spell:10228}(으)로 투명해지기도 합니다. 마을 안에서 도움 요청이 일어나면 많은 몹이 전투에 합류할 수 있습니다. 마을 외곽에서 싸우면 이 위험이 줄어듭니다.\n퀘스트 목록에 {quest:5211}이(가) 있으면(운고로 분화구 가이드 끝에서 {npc:11063}에게 받음), 마을 주변의 스컬지가 다로우샤이어 영혼을 남깁니다. 각 영혼에게 말을 걸어 해방하세요. {item:15447} 작업을 시작하기 전에 영혼들을 해방하세요.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "오두막에서 길을 따라 남쪽의 {area:2264}(으)로 가세요. {item:15447}은(는) 10분 안에 상합니다. 마을의 스컬지를 빨리 처치하고, 일곱 조각을 바로 {item:15454}(으)로 빻으세요.\n주의: 보이지 않는 하인은 생명력이 40%로 떨어지면 25미터 안의 동료에게 도움을 요청합니다. 전투 중이 아닐 때는 {spell:10228}(으)로 투명해지기도 합니다. 마을 안에서 도움 요청이 일어나면 많은 몹이 전투에 합류할 수 있습니다. 마을 외곽에서 싸우면 이 위험이 줄어듭니다.\n퀘스트 목록에 {quest:5211}이(가) 있으면(이 가이드 시작 부분에서 {npc:11063}에게 받음), 마을 주변의 스컬지가 다로우샤이어 영혼을 남깁니다. 각 영혼에게 말을 걸어 해방하세요. {item:15447} 작업을 시작하기 전에 영혼들을 해방하세요.",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "{area:1099}에서 남쪽으로 가세요. 히포그리프 둥지는 {zone:1444} 남부에 있으며, 둥지마다 {object:142071}에 쓸 알이 하나씩 있습니다.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "남서쪽 {area:2738} 폐허로 말을 타고 가세요. {quest:1123}용 {object:179565}은(는) 폐허가 된 집 안에 있습니다.",
	-- ["Ride west to the {area:2260}."] = "서쪽의 {area:2260}(으)로 가세요.",
	-- ["Scare {npc:7583} with {item:12928}"] = "{item:12928}(으)로 {npc:7583} 겁주기",
	-- ["Sword of Marduk"] = "마르두크의 검",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "연대기는 안도할 마을 회관의 퀴퀴한 고서 사이에 있습니다. 맞는 것을 찾을 때까지 열어 보세요.",
	-- ["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "비행기는 {area:541}에 착륙합니다. {npc:9997}은(는) 비행 조련사 옆에, {npc:8737}은(는) 몇 걸음 떨어진 동굴 곁에 있습니다. {npc:9997}의 일은 다음 가이드 북쪽 복귀 길의 운고로에 있습니다.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "하이 엘프 순찰자, 길잡이, 수렵꾼이 {area:2275} 옆의 오두막을 지키고 있으며, 명부는 그 안에 있습니다. 순찰자는 60레벨까지 됩니다. 한 번에 한 명씩 끌어오세요. 가는 길에 맹독 역병박쥐가 들판 위를 날아다닙니다.\n해골은 {area:2622}에서 역병 걸린 공포와 역병 괴물 사이에 있습니다.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "운고로 분화구에서 오는 고갯길은 {zone:1451} 북동쪽의 묘지인 {area:3077}(으)로 이어집니다. {npc:13220}은(는) 무덤 사이에 서 있습니다.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "부서진 검은 호수 북서쪽 땅바닥에 있습니다.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "해골은 {area:2622}의 황폐의 그림자와 역병의 괴수 사이에 있습니다.",
	-- ["The western hills"] = "서쪽 언덕",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "{object:142071} 기계",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}은(는) {area:2261} 바로 뒤에 있습니다.",
	-- ["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "북쪽골의 광포한 역병사냥개(57-58레벨) 전에 이곳에서 56레벨까지 올리세요. 동쪽으로 가는 길의 들판 위 맹독 역병박쥐(54-56레벨)가 레벨에 맞고, {npc:11878}이(가) 20마리를 원합니다. 또는 파티와 함께 {area:1583} 던전(하층)을 도세요.",
	-- ["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "우미의 세 번째 장난은 {area:976}, 운고로 분화구, {area:2255}의 고블린이 대상입니다. 나중을 위해 보관하세요.",
	-- ["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "{area:976}의 고블린 소녀 {npc:7583}에게 {item:12928}을(를) 사용하세요. {npc:10977}와(과) {npc:10978}은(는) 나중에 경로 중 놀래 줍니다.",
	-- ["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",
	-- ["grind on {npc:8601}"] = "{npc:8601} 사냥",
	-- ["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "보관하세요: 순찰자(59-60레벨)는 다음 가이드에서 북쪽으로 두 번째 갈 때 처리합니다",
	-- ["{area:2255} flight master"] = "{area:2255} 비행 조련사",
	-- ["{area:976} flight master"] = "{area:976} 비행 조련사",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447}은(는) 10분 안에 상합니다. 마을의 스컬지를 빨리 처치하고, 일곱 조각을 바로 {item:15454}(으)로 빻으세요.",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880}은(는) {object:172982}와(과) 그 주변 거리를 돌아다닙니다. 비행 조련사의 탑으로 가는 길에 찾아보세요. 지도의 원이 그의 이동 경로입니다.",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}: 이 가이드 끝의 {quest:7492}에 있는 {npc:7776}에게 전달",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "유령 {npc:11140}은(는) 북서쪽 구석, {area:2627}의 오두막 옆에 서 있습니다.",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "유령 {npc:11140}은(는) 북서쪽 구석, {area:2627}의 오두막 옆에 서 있습니다. {npc:12384}은(는) 오두막 안에 앉아 있습니다.",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut.\nCareful: Terrordale Spirits (59-60) drift through the north-west corner just north of {npc:11140}'s hut, and Crypt Horrors (57-58) and Crypt Walkers (55-56) stand around it; some of them root you. Walk in slowly and pull one at a time."] = "유령 {npc:11140}은(는) {area:2627} 북서쪽 구석의 오두막 옆에 서 있고, {npc:12384}은(는) 오두막 안에 앉아 있습니다.\n주의: 테러데일 원혼({npc:14564}, 59-60)이 {npc:11140}의 오두막 바로 북쪽 북서쪽 구석을 떠다니고, 지하묘지 괴물({npc:8557}, 57-58)과 지하묘지 보행자({npc:8556}, 55-56)가 그 주변에 서 있습니다. 일부는 묶어 버립니다. 천천히 들어가 하나씩 끌어내십시오.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}의 용사가 {area:2261} 북쪽의 {area:2260} 농가를 차지하고 있습니다.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "{npc:15193}의 용사가 {area:2261} 북쪽의 {area:2260} 농가를 차지하고 있습니다. 지역 북쪽에서 하는 그의 {npc:8564} 사냥은 다음 가이드의 역병지대 방문 때 처리합니다.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "{npc:15193}의 용사가 {area:2260} 농가를 차지하고 있습니다.",
	-- ["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}은(는) {area:976} 남쪽, {area:1336}(으)로 가는 길가에 야영하고 있습니다.",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299}은(는) {area:976} 바로 북쪽 묘지의 유령입니다. 눈에 띄는 묘비는 그 남쪽, 마을 성벽 밖에 있습니다.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "{object:1661}의 비행 조련사는 성벽 밖, {object:36078}의 서쪽 탑에 있습니다.",
	-- ["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914}은(는) 운고로 분화구의 {npc:8737}에게 돌아갑니다. 보관하세요.",
	-- ["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "{quest:3941}은(는) 이 동굴의 {npc:9117}에게로, 다음 가이드가 {area:541}로 돌아올 때 제출하세요. 보관하세요.",
	-- ["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "{quest:5168}의 물품은 나중의 역병지대 지역에 있습니다. 보관하세요.",
}
