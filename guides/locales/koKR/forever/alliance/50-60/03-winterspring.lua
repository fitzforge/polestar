-- Korean (koKR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}은(는) {area:1769} 터널의 {zone:1452} 쪽 출구, 나오는 바로 그 자리에 서 있습니다.",

	-- Step 4: Everlook's inn
	-- {area:2255} Everlook
	["{area:2255}'s inn"] = "{area:2255} 여관",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands · {zone:1452} Winterspring · {area:2255} Everlook
	["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "귀환석이 {zone:1455}에 설정되어 있지 않습니다({zone:1425} 가이드가 그곳에 귀환 지점을 정하고, 이 가이드는 그곳을 통해 {zone:1452}을(를) 떠납니다). 대신 마을로 돌아올 때를 위해 {area:2255}에 귀환 지점을 정하세요.",

	-- Step 5: Everlook
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}: 역병지대를 위해 보관하세요. 안쪽",
	-- {npc:11754} Meggi Peppinrocker · {area:2255} Everlook
	["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "",

	-- Step 7: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "길을 따라 서쪽으로 온천 옆 {npc:9298}의 야영지까지 가세요.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "보관하세요: 나중에 {zone:1444}의 그레간이 비약을 만듭니다",

	-- Step 8: Level 55 at Frostfire Hot Springs
	-- {area:2246} Frostfire Hot Springs
	["Level 55 at {area:2246}"] = "{area:2246}에서 55레벨",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:14047} Runecloth · {area:1584} Blackrock Depths · {area:2577} Dire Maul
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "서쪽 눈사태일족 야영지는 {npc:11556}와(과) {npc:9298} 사이의 언덕에 있습니다. 먼저 야영지 가장자리의 눈사태일족 길잡이(53-54)를 잡아 55레벨까지 올리세요. 안쪽의 눈사태일족 굴 감시자는 55-56레벨입니다. 이들을 처치하면 나무구렁 평판이 오르고, 메일로쉬에게 줄 {item:14047}도 가방에 쌓입니다. 파티가 있다면 대신 {area:1584}이나 {area:2577}을(를) 도세요.",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "",

	-- Step 9: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "",
	-- {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {item:14047} Runecloth
	["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "이곳의 퍼볼그는 누구든 {item:12771}(약 10분의 1 확률: 이 퀘스트들에 필요한 처치 수 안에 나옵니다)과 {quest:8471}(약 30분의 1 확률)을(를) 떨어뜨릴 수 있습니다. 떨어진 것을 오른쪽 클릭하세요. 퍼볼그가 떨어뜨리는 {item:14047}은(는) 메일로쉬를 위해 보관하세요.",

	-- Step 10: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "{zone:1448}의 마른가지일족 가마솥: 보관하세요",

	-- Step 11: Level 55.05
	["Level 55.05"] = "",
	-- {area:2255} Everlook · {area:2246} Frostfire Hot Springs · {area:1769} Timbermaw Hold · {quest:8471} Winterfall Ritual Totem · {area:1584} Blackrock Depths · {area:2577} Dire Maul
	["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "{area:2255}에서 퀘스트를 제출하기 전에 여기서 55.05레벨까지 올리세요. 제출하면 56레벨이 됩니다. {area:2246} 옆에 진을 친 눈사태일족 펄볼그(길잡이, 토템술사, 굴 감시자)를 사냥하세요. 이들을 처치하면 이곳 퀘스트와 {area:1769} 통과에 필요한 나무구렁 평판이 오르고, 그중 하나가 {quest:8471}을(를) 떨어뜨리며, 메일로쉬가 요구하는 룬무늬 옷감 30개도 모입니다. 파티가 있다면 대신 {area:1584}이나 {area:2577}을(를) 도세요.",

	-- Step 12: Winterfall Ritual Totem
	["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "{area:1769}의 케른다에게: 보관하세요",

	-- Step 13: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "폐허는 {area:2253} 남쪽의 얼어붙은 호수 주변에 있습니다. 폐허에 놓인 유물 조각 네 개를 줍고, 올빼미야수가 돌아다니는 땅에서 달빛 깃든 깃털을 주우세요.",

	-- Step 14: Ice Thistle Hills: kill these as you meet them
	-- {area:2247} Ice Thistle Hills
	["{area:2247}: kill these as you meet them"] = "",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind · Chillwind Ravagers = {npc:7449} Chillwind Ravager
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "얼음엉겅퀴설인은 {area:2244} 남쪽 언덕에, 서리바람 키메라는 {area:2255} 쪽 골짜기에 삽니다.\n주의: 얼음엉겅퀴설인은 55-56레벨, 키메라는 55-57레벨입니다. 언덕 가장자리의 떠도는 얼음엉겅퀴설인(53-55)과 어린 서리바람 키메라(53-55)를 잡고, 갈퀴발톱 서리바람 키메라(57-59)는 피하세요.",

	-- Step 16: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "온전한 설인 뿔",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "언덕으로 돌아가세요. 뿔은 맹렬한 얼음엉겅퀴설인(56-57)과 얼음엉겅퀴설인 우두머리(57-58)만 가지고 있습니다.\n주의: 맹렬한 얼음엉겅퀴설인을 언덕 가장자리에서 하나씩 잡고, 우두머리는 피하세요. 뿔은 둘 다에게서 나옵니다.",

	-- Step 17: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "{npc:10978}에게, 여관 옆",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583}와(과) {npc:10977}은(는) 나중에",
	-- {npc:10978} Legacki · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10978} with {item:12928}"] = "{item:12928}(으)로 {npc:10978} 겁주기",

	-- Step 18: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "{zone:1455}(으)로",
	-- {zone:1455} Ironforge · {area:3197} Chillwind Camp · {area:2255} Everlook
	["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "귀환석이 아직 {zone:1455}에 설정되어 있습니다. 그곳에서 {area:3197}행 그리폰을 타는 것이 {area:2255}에서 테라모어 섬으로 날아가 배를 타는 것보다 약 10분 빠릅니다.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "{zone:1455} 여관",

	-- Step 20: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle · {object:32356} Hall of Explorers (no name in this language: may be words) · {zone:1448} Felwood
	["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616}은(는) 탐험가의 전당에서 일합니다. 지나가는 길에 {zone:1448}의 수액 단지를 지금 건네주세요.",
	-- {zone:1451} Silithus
	["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "단지는 {zone:1451} 가이드의 운고로 방문 때 채웁니다: 보관하세요",

	-- Step 21: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "{area:3197}(으)로 날아가기",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",

	-- Step 22: Fly to Theramore
	["Fly to Theramore"] = "테라모어 섬으로 날아가기",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 23: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",

	-- Step 24: Fly to Chillwind Camp
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 25: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "퓨어하트, 두마, 밸러피스트, 맥도넬은 야영지 한가운데, 비행 조련사 옆에 서 있습니다.",
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: 흰개미는 나중에 {area:2627}에서 모읍니다",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "",

	-- Step 26: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199} 가마솥",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "야영지에서 북서쪽으로 안돌할 서쪽의 {area:199}까지 가세요. {npc:11075}(53)이(가) 비명소리 구울(54) 사이에서 가마솥을 지킵니다.",

	-- Step 27: Chillwind Camp
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["Back to {npc:11053} at {area:3197}."] = "{area:3197}의 {npc:11053}에게 돌아가세요.",
	-- {npc:11053} High Priestess MacDonnell · {area:200} Dalson's Tears
	["{npc:11053}: the cauldron is at {area:200}, keep it"] = "",

	-- Step 28: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "{area:3197}에서 동쪽으로 난 길가, {area:197}에 {npc:10927}의 농가가 있습니다. 그녀의 {quest:5142} 퀘스트는 {area:2262}의 같은 유령에게 이어집니다.",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: {area:2262}을(를) 위해 보관하세요",

	-- Step 29: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "",
	["Inside"] = "",

	-- Step 30: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 32: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "남쪽 길을 따라 동쪽으로 {zone:1423}에 들어가세요. {area:2262}의 폐허는 그 남쪽에 있습니다. {npc:10926}의 유령은 남쪽 끝의 무너진 집 옆에서 놀고 있습니다.",

	-- Step 33: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}의 인형",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "인형 조각 세 개는 {area:2262}의 무너진 집들에 있습니다. 하나를 주울 때 유령이 나타날 수 있습니다. 조각을 합쳐 인형을 만드세요.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "",

	-- Step 34: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, {zone:1422}에서: 보관하세요",

	-- Step 35: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "길을 따라 동쪽으로 지역을 가로질러 예배당까지 가세요.",
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "{npc:11063}의 다음 임무는 {area:2264}의 57-60레벨 스컬지 사이에서 해야 하니 건너뛰세요.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: 추방자 자엘다르는 54레벨 정예입니다",

	-- Step 36: The Undercroft
	-- {area:2261} The Undercroft
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "잴다르는 정예이니 파티를 권장합니다. 그는 지역 남서쪽의 지하실인 {area:2261}의 맨 아래에서 기다립니다.",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "",

	-- Step 37: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "다음 가이드는 여기서 시작해 {area:3197}(으)로 날아갑니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "언덕으로 돌아가세요. 맹렬한 얼음엉겅퀴설인과 덩치큰 얼음엉겅퀴설인만 뿔을 지니고 있습니다.",
	-- ["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "남쪽 길을 따라 동쪽으로 {area:139}에 들어가세요. {area:2262}의 폐허는 그 남쪽에 있습니다. {npc:10926}의 유령은 남쪽 끝의 무너진 집 옆에서 놀고 있습니다.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "{npc:9298}의 안내를 따라 서리망치거인들을 지나 {area:2256} 입구로 가세요. 거인은 하나씩 지나가세요.",
	-- ["Free Darrowshire Spirits: talk to them"] = "{npc:11064} 해방: 대화하기",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "얼음엉겅퀴설인은 {area:2244} 남쪽 언덕에, 서리바람 키메라는 {area:2255} 쪽 계곡에 삽니다.",
	-- ["Optional: {area:1417}"] = "선택: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "마차 주변의 보급품을 줍고, 근처 올빼미야수에게서 {npc:10301}의 목걸이를 되찾으세요.",
	-- ["Pristine Yeti Horns"] = "온전한 설인 뿔",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "북쪽으로 {area:2627}까지 가세요. {npc:12384}은(는) 무너진 오두막에 살고, 그의 영수증 장부는 근처의 무너진 여관에 있습니다.",
	-- ["Ride north-west back to the village."] = "북서쪽으로 마을까지 돌아가세요.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "계곡을 따라 남동쪽으로 내려가 {area:2245}의 눈 속에 있는 {npc:10301}의 부서진 상자로 가세요. 부서진 마차가 그 바로 동쪽에 있습니다.",
	-- ["Ride west along the road to the night elf village."] = "길을 따라 서쪽으로 나이트 엘프 마을까지 가세요.",
	-- ["Ride west along the road to {npc:10301}."] = "길을 따라 서쪽으로 {npc:10301}에게 가세요.",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "설인 사냥 후에도 54레벨이 안 되나요? 사냥 대신 파티로 {area:1417}(50-54)을(를) 돌면 더 빨리 도달합니다. 그 후 {area:2255}(으)로 돌아오세요.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "예배당 서쪽, {area:2264} 주변의 스컬지는 두 종류의 스컬지석을 모두 떨어뜨립니다. 그들에게서 대로우샤이어의 영혼이 솟아오르니 하나하나 대화해 풀어 주세요.\n주의: {npc:10411}은(는) 전투 밖에서는 보이지 않으며, 싸움이 시작되면 바위날개 가고일을 부릅니다. 3마리만 있으며 15분마다 다시 나타납니다.",
	-- ["The Winterfall camp"] = "눈사태일족 야영지",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "눈사태일족 펄볼그 마을은 {area:2255} 동쪽에 있습니다. 주술사(56-57), 보초(55-56), 펄볼그(57-58) 모두 당신보다 높습니다. 치유하는 주술사를 먼저 처치하고, 가장자리부터 끌어오세요. 뒤쪽 동굴의 {npc:10738}은(는) 정예이니 들어가지 마세요.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "서쪽 눈사태일족 야영지는 {npc:11556}와(과) {npc:9298} 사이의 언덕에 있습니다. 이곳의 펄볼그는 누구든 {item:12771}(약 10분의 1 확률)을, 드물게 {quest:8471}을(를) 떨어뜨릴 수 있습니다. 떨어진 것을 오른쪽 클릭하세요. 펄볼그가 떨어뜨리는 {quest:6031}은(는) 메일로쉬를 위해 보관하세요.",
	-- ["The western Winterfall furbolgs drop the beads."] = "서쪽 눈사태일족 펄볼그가 구슬을 떨어뜨립니다.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "{area:1769}을(를) 지나 {zone:1448}(으)로 간 뒤 동부 왕국으로 날아가세요({area:442}, {area:150}행 배). {area:271}(으)로 날아가 알터랙을 지나는 길을 따라 북쪽으로 {area:3197}까지 가세요.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "귀환석이 {zone:1455}에 설정되어 있지 않습니다({zone:1425} 가이드는 47레벨에 그곳에 귀환 지점을 정하고, 이 가이드는 그곳을 통해 {zone:1452}을(를) 떠납니다). 대신 마을로 돌아올 때를 위해 {area:2255}에 귀환 지점을 정하세요.",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "{zone:1452}의 {area:2247}에서 {npc:7460}을(를) 사냥하세요",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, 드문 전리품",
	-- ["{npc:10301}'s camp"] = "{npc:10301}의 야영지",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}의 보급품",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: 둘 다 역병지대를 위해 보관하세요. 안",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556}은(는) {npc:9298} 북서쪽의 {area:1769} 입구를 지킵니다.",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: {area:2262}을(를) 위해 보관하세요. 안",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250}은(는) 정예이니 파티를 권장합니다. 그는 지역 남서쪽의 지하실인 {area:2261}의 맨 아래에서 기다립니다.",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, {area:28}에서: 보관하세요",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, 나중에 메일로쉬에게",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, 드문 전리품",
}
