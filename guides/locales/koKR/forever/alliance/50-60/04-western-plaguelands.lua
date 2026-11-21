-- Korean (koKR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands
	["Western & {zone:1423}"] = "",

	-- Step 1: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",

	-- Step 2: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "",
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}' next task sends you back to Ranshalla in {zone:1452}, behind the route now: skip it."] = "",

	-- Step 4: Herald Moonstalker
	-- {npc:10878} Herald Moonstalker
	["{npc:10878} stands by the Temple of the Moon."] = "",

	-- Step 6: Arch Druid Fandral Staghelm
	-- {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building of the {area:1658}; {npc:4217}, next, is lower down inside it."] = "",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "",

	-- Step 8: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, 위층",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade · {zone:2482} Mount Hyjal
	["{quest:6762} in {zone:1450}: {zone:2482}'s {zone:1450} errand takes you to her, in the next guide; keep it"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455}에는 드루이드 상급자가 없습니다",

	-- Step 9: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "{zone:1438}행 차원문",

	-- Step 10: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "{area:442}(으)로 비행",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702} 비행 조련사",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",

	-- Step 12: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "{area:1537}(으)로 비행",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 13: Ironforge
	-- {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["{npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:15187} Cenarion Emissary Jademoon · {npc:15191} Windcaller Proudhorn · {zone:1451} Silithus
	["{npc:15187}, by the flight master where you land: for {npc:15191} in {zone:1451}, on the last guide; keep it"] = "",
	-- {npc:9616} Laris Geardawdle
	["{npc:9616}' next task fills his jars in Un'Goro, behind the route now: skip it."] = "",
	-- {npc:13843} Lieutenant Rotimer · {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13843}: for {npc:13841}, on the way to {area:3197}"] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",

	-- Step 14: Courier Hammerfall
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10877} Courier Hammerfall · {zone:1455} Ironforge · {npc:10838} Commander Ashlam Valorfist
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10877} walks the ring of {zone:1455} and sends you to {npc:10838}, whose camp this guide visits next. Chillwind's chain starts with it."] = "",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",

	-- Step 16: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them."] = "",

	-- Step 17: Lieutenant Haggerdin
	-- {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13841} camps beside the road north to {area:3197}."] = "",

	-- Step 18: Chillwind Camp: Clear the Way
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10838} Commander Ashlam Valorfist · {quest:5092} Clear the Way
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10838} stands in the middle of the camp. His {quest:5092} opens the camp's chain."] = "",

	-- Step 19: Sorrow Hill: Clear the Way
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields just north of the camp.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled."] = "",

	-- Step 20: Chillwind Camp: the cauldrons
	-- {area:3197} Chillwind Camp
	["{area:3197}: the cauldrons"] = "",
	-- {npc:11053} High Priestess MacDonnell
	["Back to the camp: Valorfist, then {npc:11053} beside him."] = "",
	-- {area:199} Felstone Field
	["{area:199}'s cauldron, later in this guide"] = "",

	-- Step 21: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "퓨어하트, 두마, 밸러피스트, 맥도넬은 야영지 한가운데, 비행 조련사 옆에 서 있습니다.",
	-- {npc:11616} Nathaniel Dumah · {area:2277} Plaguewood
	-- was: ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: 흰개미는 나중에 {area:2627}에서 모읍니다"
	["{npc:11616}: the termites come later, in the {area:2277}"] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {area:199} Felstone Field
	["{npc:10838}: the watchtowers stand around Andorhal, on the way to {area:199}"] = "",

	-- Step 22: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission
	["No {quest:5401} yet? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 23: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "안돌할 감시탑",
	-- {item:12815} Beacon Torch · {area:199} Felstone Field · {npc:7572} Fallen Hero of the Horde
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	-- was: ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "야영지 북쪽, 안돌할 외곽의 감시탑 네 곳 아래에서 각각 {item:12815}을(를) 사용하세요.\n주의: 해골 사령관과 살덩어리 골렘(57, 정예)이 안돌할 거리를 돌아다니고, {npc:7572}(59, 정예)이(가) 안돌할과 북부능선 사이를 배회합니다. 마을 가장자리의 탑에만 머물며 그들이 지나가게 두세요."
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp, on the way to {area:199}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",

	-- Step 24: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199} 가마솥",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw · {npc:10778} Janice Felstone · {zone:1453} Stormwind
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["West of Andorhal to {area:199}: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54).\n{npc:10778}'s ghost wanders by the farmhouse at the field's edge, upstairs; her parcel lies inside the house: take it for {zone:1453}, at the end of this guide."] = "",
	-- {npc:10778} Janice Felstone
	["{npc:10778}, upstairs in the farmhouse"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "{zone:1453}용: 보관하세요",

	-- Step 25: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Back to {area:3197}."] = "",
	-- {area:200} Dalson's Tears
	["The cauldron is at {area:200}"] = "",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}은(는) 61레벨 정예입니다",

	-- Step 26: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: 만나는 대로 처치하세요"
	["{area:197}: kill these as you meet them"] = "",
	-- {quest:5401} Argent Dawn Commission · {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones while you wear the {quest:5401} (equip it as a trinket first).\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "해골 타작꾼과 걸신들린 구울이 야영지 북쪽 들판을 돌아다닙니다. {quest:5401}을(를) 착용하고 있으면 이곳의 모든 스컬지가 스컬지석을 떨어뜨립니다(먼저 장신구로 착용하세요).\n주의: 이 언데드들은 멀리서도 알아차리며, 하나를 끌면 근처의 다른 언데드도 싸움에 합류합니다.\n주의: {npc:10411}(3곳 출현, 15분 재생성)은 전투 중이 아닐 때 투명해지며, 전투가 시작되면 바위날개 가고일을 부릅니다.",

	-- Step 27: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the ghost in {area:2262}, the next stop."] = "",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: {area:2262}을(를) 위해 보관하세요",

	-- Step 28: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",
	-- {zone:1422} Western Plaguelands
	["Follow the southern road east out of the {zone:1422}."] = "",

	-- Step 29: Pamela Redpath
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["The ruins of {area:2262} lie south of the road. {npc:10926}'s ghost plays by the ruined house at the south end."] = "",

	-- Step 30: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}의 인형",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "인형 조각 세 개는 {area:2262}의 무너진 집들에 있습니다. 하나를 주울 때 유령이 나타날 수 있습니다. 조각을 합쳐 인형을 만드세요.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "",

	-- Step 31: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, back in the {zone:1422}: keep it"] = "",
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["{npc:11063} at {area:2268}, on this guide's second ride east: keep it"] = "",

	-- Step 32: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride back west along the road to {npc:10927}'s farmhouse; {npc:10936}'s monument is just north of it."] = "",
	["Upstairs"] = "위층",
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal, later on this loop: keep it"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "기념비의 {item:12894}",

	-- Step 33: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {npc:10927} Marlene Redpath
	["{npc:10739} stands by the farm at the {area:202}, north of {npc:10927}."] = "",
	["Inside"] = "",

	-- Step 34: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: 만나는 대로 처치하세요"
	["{area:202}: kill these as you meet them"] = "",
	-- {item:12841} Invader's Scourgestone · {quest:5401} Argent Dawn Commission
	["{item:12841}: wear the {quest:5401} while you kill"] = "{item:12841}: 처치할 때 {quest:5401}을(를) 착용하세요",

	-- Step 36: Diseased Grizzlies
	["Diseased Grizzlies"] = "오염된 불곰",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The Diseased Grizzlies (55-56) roam the woods around the {area:202}, east and north of {npc:10739}."] = "",

	-- Step 37: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1457} Darnassus
	["{npc:10739}' next task goes to the druids of {zone:1457}, behind the route now: skip it."] = "",

	-- Step 38: Dalson's Tears
	-- {npc:10836} Farmer Dalson · {npc:11152} The Scourge Cauldron
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key. {npc:11152} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "농가 안의 {object:175924}, 안",

	-- Step 39: Argent Officer Pureheart
	-- {area:3197} Chillwind Camp
	["Ride back south to {area:3197}."] = "",

	-- Step 41: Chillwind Camp
	-- {area:200} Dalson's Tears
	["Ride back south from {area:200} to the camp."] = "",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} (from level 55)"] = "",
	["The skeletons of Andorhal, next on this guide"] = "",

	-- Step 42: Chromie
	-- {npc:10667} Chromie
	["North to {npc:10667} in the ruined inn on the west side of Andorhal."] = "",

	-- Step 43: Andorhal
	["Andorhal"] = "안돌할",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments · {npc:1852} Araj the Summoner
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	-- was: ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "곡물 저장고 옆에서 {item:12627}을(를) 사용해 시간의 기생충을 끌어내세요. {quest:5154}은(는) 시청에 있는 낡은 책 중 하나입니다. 마을의 모든 해골이 {quest:5537}을(를) 떨어뜨립니다.\n주의: 시간의 기생충은 55-57레벨이고, 해골 사령관과 살덩어리 골렘(57, 정예)이 거리를 돌아다닙니다. 저장고 옆에서 기생충을 하나씩 끌어내고, 정예는 지나가게 두세요."
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass.\n{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "",

	-- Step 44: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{area:2268}의 {quest:5210}: 보관하세요",

	-- Step 45: Sorrow Hill: kill these as you meet them
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 47: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "{area:202} 가마솥",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	-- was: ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "가마솥은 {npc:10739}의 농장 옆 {area:202}에 있습니다."
	["The cauldron sits at the {area:202}, by {npc:10739}' farm, east of Andorhal."] = "",

	-- Step 48: Chillwind Camp
	-- {area:201} Gahrron's Withering
	["{area:201}'s cauldron, on this guide's ride north-east"] = "",
	-- {area:976} Gadgetzan
	["Arbington's next task goes to {area:976}, behind the route now: skip it."] = "",

	-- Step 49: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone
	["Fly to {zone:1453} for Highlord Bolvar's errand for SI:7 and {npc:10778}'s parcel, then straight back."] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 50: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, SI:7 안",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}, on the flight back"] = "",

	-- Step 51: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, 운하를 걸어다님",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, out of the way now: skip it."] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, {object:2096} 안",

	-- Step 52: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "{area:3197}(으)로 비행",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 53: Flint Shadowmore
	-- {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["The agents' remains lie at the {area:2260} in the {zone:1423}, on this guide's ride east"] = "",

	-- Step 54: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "북쪽 길을 따라 북마루 벌목지로 가세요. {npc:11610}은(는) 벌목지 가장자리에 숨어 있습니다.",

	-- Step 55: The Scarlet Crusade
	["The Scarlet Crusade"] = "붉은십자군",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "붉은십자군 의무병, 붉은십자군 사냥꾼, 붉은십자군 기사, 붉은십자군 마법사가 벌목지와 {area:190}(으)로 가는 길을 순찰합니다.",

	-- Step 57: Radley and Durgen
	-- was: ["Radley and Durgen"] = "래들리와 드루겐"
	["Radley and Durgen"] = "",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	-- was: ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613}은(는) {npc:11610} 동쪽의 북마루 벌목지를 돌아다니고, {npc:11611}은(는) {area:190} 남쪽 진입로의 탑을 지킵니다.\n주의: 탑 아래에 경비병이 서 있고, 하나가 더 탑 주위를 순찰합니다. 두르겐과 싸우기 전에 처치해 싸움에 끼어들지 않게 하세요."
	["{npc:11613} (56) walks the Northridge camp east of {npc:11610}; {npc:11611} (57) guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 58: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610}은(는) 벌목지 가장자리에 숨어 있습니다.",

	-- Step 59: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190} 전망 지점",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 61: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2277} Plaguewood · {area:2627} Terrordale
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank. His hunts are in the {area:2277} and {area:2627}, at the end of this guide's ride east."] = "",

	-- Step 62: Gahrron's Withering
	-- {npc:1855} Tirion Fordring · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south from {npc:1855}'s hut to {area:201}. {npc:11078} (58) guards the cauldron.\nCareful: Soulwrath is level 58, a level over you here: clear the ghouls around the cauldron first and pull him alone."] = "",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "이 가이드 마지막에 {area:3197}의 {npc:11053}에게 가져갑니다",

	-- Step 63: Marris Stead
	-- {zone:1423} Eastern Plaguelands · {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride east into the {zone:1423}: the {area:2260} is the farm north of the southern road, north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "",
	["Close enough to see the Blightcaller in front of the house"] = "",

	-- Step 64: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: 만나는 대로 처치하세요"
	["{zone:1423}: kill these as you meet them"] = "",
	-- {zone:1423} Eastern Plaguelands · {area:2268} Light's Hope Chapel
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Gargantuan Plaguebats = {npc:272342} Gargantuan Plaguebat
	["Ride east along the southern road across the {zone:1423} to {area:2268}: Plaguehound Runts and Plaguebats roam beside it.\nCareful: Gargantuan Plaguebats (60) fly among the smaller bats near the western border: take the Plaguebats of your level."] = "",

	-- Step 65: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "{npc:11063}의 다음 임무는 {area:2264}의 57-60레벨 스컬지 사이에서 해야 하니 건너뛰세요.",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, at the end of this ride: keep it"] = "",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast · {area:2261} Undercroft
	["{npc:11038}'s {npc:12250} is a group quest in the {area:2261} (a level 54 elite)."] = "",

	-- Step 66: Carlin Redpath: Heroes of Darrowshire
	-- {area:190} Hearthglen · {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	-- plural, as words: Haunting Visions = {npc:4472} Haunting Vision
	["The libram is inside {area:190} among elite Scarlet guards, and {item:12955} among Haunting Visions at {area:201}: a group quest."] = "",

	-- Step 67: Villains of Darrowshire
	-- {area:2623} Infectis Scar · {area:2624} Blackwood Lake
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["West into the middle of the zone: Marduk's sword lies in the {area:2623} and Horgus' skull at {area:2624}, north of it, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 68: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath
	["Back east to {npc:11063} at the chapel."] = "",

	-- Step 69: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "북서쪽 {area:2277} 가장자리의 {area:2276}(으)로 가세요.",

	-- Step 70: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: 만나는 대로 처치하세요"
	["{area:2277}: kill these as you meet them"] = "",
	-- {area:2277} Plaguewood · {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Carrion Devourers = {npc:8605} Carrion Devourer
	["West through the {area:2277} to {area:2627}: fill the {item:15042} at the big termite mounds, and kill the Frenzied Plaguehounds and the Carrion Devourers on the way.\nCareful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "",

	-- Step 71: Augustus the Touched
	-- {npc:12384} Augustus the Touched · {area:2627} Terrordale · {npc:11140} Egan
	["{npc:12384} lives in the ruined hut in {area:2627}, and his receipt book lies in the ruined inn nearby. {npc:11140} stands by {npc:12384}' hut."] = "",

	-- Step 73: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:2626} Terrorweb Tunnel
	-- plural, as words: Crypt Fiends = {npc:8555} Crypt Fiend
	["Cross the river west to {npc:1855}'s hut.\nCareful: the short way from {area:2627} to {npc:1855} is the {area:2626}, whose south mouth opens by his hut: Crypt Fiends, Walkers, Horrors and Slayers (53-58) stand close together inside. Pull them one at a time, or ride round by the road outside it."] = "",

	-- Step 75: Tirion Fordring
	["Listen to his story"] = "그의 이야기를 들으세요",

	-- Step 76: Tirion Fordring: Of Forgotten Memories
	-- {quest:5781} Of Forgotten Memories · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["{quest:5781} is a group quest: {npc:11886} (57, elite) and his adds in the {area:2261}."] = "",

	-- Step 77: Undercroft
	-- {area:2261} Undercroft
	["Cross the river south-east to the {area:2261}, the crypt in the south-west of the zone.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886} (57, elite)"] = "",

	-- Step 78: Tirion Fordring
	-- {quest:5845} Of Lost Honor · {area:2277} Plaguewood · {area:3197} Chillwind Camp
	["{quest:5845}'s symbol lies in the lake south of the {area:2277}: your group fetches it before the ride back to {area:3197}."] = "",

	-- Step 79: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1839} Scarlet High Clerist
	-- plural, as words: Scarlet Paladins = {npc:1834} Scarlet Paladin
	["Careful: Scarlet Paladins (55-56) and priests guard {item:12954} inside {area:190}'s town hall. They are elite, and a {npc:1839} (63, elite) stands near the book. Go in with your group; stay out of the Clerist's reach."] = "",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 80: Redpath's Shield
	-- {area:201} Gahrron's Withering
	["The shield lies east of the barn at {area:201}. Take your group around the barn to reach it."] = "",

	-- Step 81: Carlin Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["Back to {npc:11063} at {area:2268} with your group."] = "",

	-- Step 82: Eastern Plaguelands
	-- {area:2277} Plaguewood · {area:2268} Light's Hope Chapel
	["Ride to the lake south of the {area:2277}, north-west of {area:2268}."] = "",
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 83: Of Lost Honor
	["Underwater"] = "물속",

	-- Step 84: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:3197} Chillwind Camp
	["West across the zone to {npc:1855}'s hut on the way back to {area:3197}."] = "",

	-- Step 85: Western Plaguelands
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp
	["Ride south-west through the {zone:1422} to {area:3197}."] = "",

	-- Step 86: Chillwind Camp
	["Dumah's next task sets a barrel down at Northridge, behind you now: skip it."] = "",

	-- Step 87: Flint Shadowmore
	-- {zone:1453} Stormwind
	["Highlord Bolvar in {zone:1453}, on the way out of this guide"] = "",

	-- Step 89: Stormwind City
	["Stormwind City"] = "",
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:1748}, in {object:2117}"] = "",

	-- Step 90: Stormwind
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone · {npc:10782} Royal Factor Bathrilor · {object:2096} Trade District · {npc:3520} Ol' Emma · {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["Without the flight to {zone:1453} at 56 earlier in this guide: {npc:10778}'s parcel goes to {npc:10782} in the {object:2096}, then {npc:3520} takes her own errand on the canals. {npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, behind you now: skip it."] = "",

	-- Step 91: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "{area:150}(으)로 비행",

	-- Step 92: Boat to Theramore
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook
	["Take the boat to Theramore: {zone:2482}, the next guide, starts with the flight to {area:2255}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["After the farm's keys: the {object:177289} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "농장 열쇠를 얻은 뒤: {object:177289}은(는) 농가 바로 남서쪽에 있고, 그 옆의 가마솥군주가 열쇠를 가지고 있습니다.",
	-- ["Andorhal Watches"] = "안돌할 시계",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "북쪽 {area:202}(으)로 돌아가세요. 이제 가마솥이 직접 퀘스트를 줍니다. 근처 구울들이 체세포 강화물질을 떨어뜨립니다.",
	-- ["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one, and {npc:9299} in {area:976} shows himself only to someone who has drunk one."] = "{npc:7765} 바로 남동쪽의 {npc:7775} 야영지로 돌아가세요. {item:11242}(으)로 비데레 비약 세 개를 받습니다. 보관하세요. {npc:9298}이(가) 하나를 가져가며, {area:976}의 {npc:9299}은(는) 비약을 마신 사람에게만 모습을 드러냅니다.",
	-- ["Below ground"] = "지하",
	-- ["Bones and equipment"] = "뼈와 장비",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "출발 직전에 펠스톤 가마솥에 쓸 {item:13320} 하나를 {npc:11056}에게서 구입하세요. 촉매제는 30분 후에 사라집니다.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "{area:202} 가마솥과 달슨 가마솥에 쓸 비전 촉매제를 두 개 더 구입하고 곧장 가세요. 촉매제는 30분 후에 사라집니다.",
	-- ["Careful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "주의: 광포한 역병사냥개는 57-58레벨이니 하나씩 끌어서 잡으세요.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "{area:190} 서쪽 언덕에 올라 마을을 내려다보세요.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "강을 건너 동쪽, 지역 남서쪽의 지하 묘지인 {area:2261}으로 가세요. {object:177667}은(는) 그 안에 있습니다. 열쇠는 북동쪽 끝의 {npc:12248}이(가) 가지고 있으며, 다음 가이드에서 처리합니다.\n주의: 머큐시오와 함께 정예가 아닌 몹 약 네 마리가 나옵니다. 그 자리에 나타나지 않고 무덤으로 걸어옵니다.",
	-- ["Cross the river west to {npc:1855}'s hut."] = "강을 건너 서쪽 {npc:1855}의 오두막으로 가세요.",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "분화구 남쪽을 가로질러 비탈 옆의 {npc:9619}에게 가세요.",
	-- ["Diseased Wolves"] = "역병에 걸린 늑대",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "{npc:11741}은(는) 더 서쪽을 파고, {npc:11736}, 돌꼬리채찍전갈, {npc:11739}이(가) 같은 모래밭에서 사냥합니다.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "{npc:11740}은(는) 요새 북서쪽 모래언덕을 파고, {npc:11735}와(과) {npc:11738}은(는) 사방을 돌아다닙니다.",
	-- ["Eastern Pylon and the crate"] = "동쪽 수정탑과 상자",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "{area:618}의 {npc:9298}에게서 끝납니다: 보관하세요",
	-- ["Ends with {npc:9298} in {zone:1452}: keep it"] = "{zone:1452}의 {npc:9298}에게서 끝납니다: 보관하세요",
	-- ["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- ["Fly from {area:976} to {area:541}. {npc:8737} stands at the back of the refuge; {npc:9117} is in the cave behind him.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "{area:976}에서 {area:541}(으)로 날아가세요. {npc:8737}은(는) 피난처 안쪽에 있고, {npc:9117}은(는) 그 뒤 동굴에 있습니다.\n{npc:9997}의 친구 {npc:9999}이(가) 실종되었습니다.",
	-- ["Fly to Theramore"] = "테라모어 섬으로 비행",
	-- ["Fly to {area:2268}"] = "{area:2268}(으)로 날아가기",
	-- ["Fly to {area:392}"] = "{area:392}(으)로 비행",
	-- ["Fly to {area:392}."] = "{area:392}(으)로 날아가세요.",
	-- ["Fly to {area:976}"] = "{area:976}(으)로 날아가기",
	-- ["For the druids of {zone:1457}: keep it"] = "{zone:1457}의 드루이드용: 보관하세요",
	-- ["For {area:1377}: keep it"] = "{area:1377}용: 보관하세요",
	-- ["For {area:3197}: keep it"] = "{area:3197}에 쓸 것: 보관하세요",
	-- ["For {zone:1448}: keep it"] = "{zone:1448}용: 보관하세요",
	-- ["For {zone:1451}: keep it"] = "{zone:1451}용: 보관하세요",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "{area:392}에서 {area:2255}(으)로 날아간 뒤 남쪽 {area:2250}(으)로 가세요.",
	-- ["From {area:702}, fly to {area:1116}."] = "{area:702}에서 {area:1116}(으)로 날아가세요.",
	-- ["Hearth to {area:392} (bound there earlier on this guide), then fly on to {area:976}."] = "귀환석으로 {area:392}에 가서(이 가이드 앞부분에서 귀환 장소로 설정함) {area:976}(으)로 날아가세요.",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "호르구스의 해골은 {area:2624}에, 마르두크의 검은 {area:2623}에 있으며, 둘 다 유령들이 싸우는 곳입니다. 다 자란 역병사냥개가 그 사이 평원을 사냥합니다.",
	-- ["Into {zone:1451}"] = "{zone:1451}(으)로",
	-- ["MacDonnell's next task, {area:201}'s cauldron, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "맥도널의 다음 임무인 {area:201}의 가마솥은 {zone:1451} 가이드의 역병지대 구간에서 하니 그때 수락하세요.",
	-- ["More watches"] = "추가 시계",
	-- ["North to the refuge, for the quests the first Un'Goro visit left: {npc:9618} stands just outside and {npc:9117} in the cave at the back; the expedition's other three wait for your next stop here."] = "북쪽 피난처로 가서 첫 운고로 방문 때 남은 퀘스트를 처리하세요. {npc:9618}은(는) 바로 바깥에, {npc:9117}은(는) 안쪽 동굴에 있습니다. 탐험대의 나머지 세 명은 다음 방문 때 처리합니다.",
	-- ["Northern Pylon"] = "북쪽 수정탑",
	-- ["On {npc:7583}"] = "{npc:7583}에게",
	-- ["Radley and Durgen"] = "래들리와 드루겐",
	-- ["Ranshalla in {zone:1452}: keep it"] = "{zone:1452}의 란샬라: 보관하세요",
	-- ["Ride back south to the camp."] = "남쪽 야영지로 돌아가세요.",
	-- ["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "남서쪽으로 돌아가 {area:2738}의 {area:2742} 탑으로 가세요. 탑에 올라 딱딱한 실리시드 조각을 노리고 나타나는 잠복꾼을 처치하세요.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "{area:3197}(으)로 돌아가 {area:150}(으)로 날아간 다음, 배를 타고 {area:442}(으)로 가서 {area:702}(으)로 날아가세요. 차원문을 타면 {zone:1457}(으)로 올라갑니다.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "비탈을 내려가 분화구로 가세요. {npc:9619}은(는) 비탈 아래에 진을 치고 있습니다.",
	-- ["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "동쪽 경계의 강으로 가세요. {npc:1855}은(는) 강둑의 작은 오두막에 삽니다.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "동쪽으로 {area:2738}의 {area:2742} 탑으로 가세요. 탑에 올라 딱딱한 실리시드 조각을 노리고 나타나는 잠복꾼을 처치하세요.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "동쪽으로 {area:1943}까지 가세요. 로봇은 고릴라들 사이에 서 있습니다. 그곳의 깊은 동굴에는 들어가지 마세요.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "동쪽으로 {area:537}까지 가서 올라간 뒤, 꼭대기 근처 용암 분출구에서 {npc:10541}을(를) 사용하세요.",
	-- ["Ride east to {npc:13220}."] = "동쪽으로 {npc:13220}에게 가세요.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "동쪽을 따라 북쪽의 고릴라 고원으로 가세요. 55레벨 고릴라 {npc:9622}은(는) 가장 깊은 동굴에 있습니다. 먼저 동굴 입구의 고릴라를 정리하세요.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "북쪽으로 {area:2627}까지 가세요. {npc:12384}은(는) 무너진 오두막에 살고, 그의 영수증 장부는 근처의 무너진 여관에 있습니다.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\nCareful: the Frenzied Plaguehounds north-east of the hut are 57-58, a level or two over you: pull them one at a time."] = "북쪽으로 {area:2627}까지 가세요. {npc:12384}은(는) 무너진 오두막에 살고, 그의 영수증 장부는 근처의 무너진 여관에 있습니다.\n주의: 오두막 북동쪽의 광포한 역병사냥개는 57-58레벨로 자신보다 한두 레벨 높으니 하나씩 끌어서 잡으세요.",
	-- ["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "북서쪽 달슨 농장으로 가세요. 일기는 헛간에 있고, 떠도는 해골이 옥외 화장실 열쇠를 가지고 있으며, {npc:10836}은(는) 옥외 화장실에서 진열장 열쇠를 가지고 기다립니다.",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "남쪽 {area:201}(으)로 가세요. {npc:11078}이(가) 가마솥을 지킵니다.",
	-- ["Ride south-west to the camp."] = "남서쪽 야영지로 가세요.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "남서쪽으로 {area:1938}의 {npc:7771} 야영지로 가세요.",
	-- ["Ride west along the road to the hot springs."] = "길을 따라 서쪽 온천으로 가세요.",
	-- ["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "서쪽 레이븐윈드 폐허로 가세요. {npc:7774}은(는) 안쪽의 작고 둥근 건물에 숨어 있습니다. 그녀 옆의 상자를 열어 {item:9189}을(를) 얻으세요. 퀘스트처럼 15분간 지속됩니다.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "서쪽으로 {area:541}을(를) 지나 서쪽을 따라 남쪽의 {area:543}까지 가세요. 고블린 {npc:10302}이(가) 물가에 앉아 있습니다.",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "서쪽으로 {area:2627}까지 가세요. 숲에는 {npc:8596}, {npc:8600}, {npc:8603}이(가) 돌아다닙니다. 큰 흰개미 둔덕에서 {item:15042}을(를) 채우고, 더 북쪽에서 {npc:8598}을(를) 처치하세요.",
	-- ["Scare {npc:7583} with {item:12928}"] = "{item:12928}(으)로 {npc:7583} 겁주기",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "해골 타작꾼과 걸신들린 구울이 야영지 북쪽 들판을 배회합니다. 이곳의 스컬지는 모두 스컬지석을 떨어뜨립니다.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "안돌할 곳곳의 잔해 속에 작은 금고가 있고, 각각 시계가 하나씩 들어 있습니다.",
	-- ["Take the boat to the mainland and ride north-east past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "배를 타고 본토로 건너가 {area:1119}을(를) 지나 북동쪽 {npc:7775}의 야영지로 가세요. 그는 {item:11242}(으)로 {item:11243}을(를) 만듭니다. 비약을 하나 얻으려면 그의 심부름을 수락하세요.",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "배를 타고 본토로 건너가 북동쪽 {area:1119} 옆에 있는 {npc:14637}의 야영지로 가세요.",
	-- ["Temple of the Moon"] = "달의 신전",
	-- ["Ten {item:11040} from the {item:11020}"] = "{item:11020}에서 {item:11040} 10개",
	-- ["The Gorishi hive"] = "고리쉬 벌집",
	-- ["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "타르 야수와 타르 군주는 분화구로 내려가는 길에 있는 피난처 남쪽의 {area:538}에서 뒹굴고 있습니다.",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "이제 가마솥이 직접 퀘스트를 줍니다. 주변 해골들이 골성 교반기를 떨어뜨립니다.",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "가마솥은 {npc:10739}의 농장 옆 {area:202}에 있습니다.",
	-- ["The crater"] = "분화구",
	-- ["The fields"] = "들판",
	-- ["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "고릴라는 수정탑 바로 동쪽의 {area:1943}에 삽니다. 여기 올라온 김에 지금 {npc:9619}에게 줄 가죽을 모으세요. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}은(는) 55레벨입니다.\n주의: 운고로 고릴라(50-51레벨)는 생명력이 25%로 떨어지면 20미터 안의 동료를 불러 도움을 요청합니다. 이 지역에는 고릴라로 가득한 동굴이 있어, 그곳에서 싸우면 많은 적이 몰려듭니다.",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "다음 가이드는 여기 {area:392}에서 시작해 {area:976}(으)로 날아갑니다.",
	-- ["The pelts come from the gorillas on {area:1943}"] = "가죽은 {area:1943}의 고릴라에게서 모읍니다",
	-- ["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "수정탑은 {npc:9684}의 굴 위 동쪽 절벽에 있습니다. 탐험대의 {item:11113}은(는) 동쪽 밀림의 버려진 야영지에 있습니다.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}."] = "수정탑은 피난처 동쪽 비탈에 있습니다. 주변 비탈을 맴도는 {npc:9166}은(는) {npc:9997}의 퀘스트에 포함됩니다.",
	-- ["The pylon stands on the western cliffs."] = "수정탑은 서쪽 절벽에 있습니다.",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "축소된 거인들은 {area:1119}을(를) 돌아다니고, 바다 정령들은 서쪽 해안을 따라 물속을 걷습니다.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "고통받는 드루이드와 고통받는 파수꾼이 {npc:13220} 남서쪽의 폐허가 된 마을을 떠돕니다.",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",
	-- ["The {area:2742} tower"] = "{area:2742} 탑",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "{item:11242}은(는) {npc:7765} 북쪽의 무너진 건물 안에서 자랍니다. 옆의 바위턱에서 벽의 갈라진 틈으로 들어가세요.",
	-- ["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "{item:280417}은(는) {npc:9619}의 야영지에서 서쪽으로 조금만 가면 있습니다.",
	-- ["Umber in {area:493}: keep it"] = "{area:493}의 움버: 보관하세요",
	-- ["Umber in {zone:1450}: keep it"] = "{zone:1450}의 움버: 보관하세요",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "곡물 저장고 옆에서 {item:12627}을(를) 사용해 시간의 기생충을 끌어내세요. {quest:5154}은(는) 시청에 있는 낡은 책 중 하나입니다. 마을의 모든 해골이 {quest:5537}을(를) 떨어뜨립니다.",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "곡물 저장고 옆에서 {item:12627}을(를) 사용해 시간의 기생충을 끌어내세요. {quest:5154}은(는) 시청에 있는 낡은 책 중 하나입니다. 마을의 모든 해골이 {quest:5537}을(를) 떨어뜨립니다.\n주의: 시간의 기생충은 55-57레벨이고, 해골 사령관과 살덩어리 골렘(57, 정예)이 거리를 돌아다닙니다. 저장고 옆에서 기생충을 하나씩 끌어내고, 정예는 지나가게 두세요.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "야영지 북쪽, 안돌할 가장자리에 있는 네 감시탑 아래에서 각각 {item:12815}을(를) 사용하세요.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "야영지 북쪽, 안돌할 외곽의 감시탑 네 곳 아래에서 각각 {item:12815}을(를) 사용하세요.\n주의: 해골 사령관과 살덩어리 골렘(57, 정예)이 안돌할 거리를 돌아다니고, {npc:7572}(59, 정예)이(가) 안돌할과 북부능선 사이를 배회합니다. 마을 가장자리의 탑에만 머물며 그들이 지나가게 두세요.",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "{area:1769}에 들어가 터널의 {area:493} 갈림길을 따라 {area:2361}(으)로 가세요.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "{area:1769}에 들어가 터널의 {zone:1450} 갈림길을 따라 {area:2361}(으)로 가세요.",
	-- ["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "분화구 남쪽을 가로질러 서쪽으로 가세요. 남서쪽 스테고돈들 사이 땅에 공룡 뼈가 놓여 있습니다. 스테고돈은 정예이니 그 주변에서 뼈를 줍고, 나머지는 디메트라돈에게서 얻으세요. 탐험대의 {item:11112}은(는) 남서쪽 밀림에 있습니다.",
	-- ["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "분화구 남쪽을 따라 서쪽으로 가세요. 고리시 벌집이 그곳을 채우고 있습니다. 애벌레가 매달린 방인 부화장에 긁개 유리병을 사용하세요.",
	-- ["Western Pylon"] = "서쪽 수정탑",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "경로의 이전 방문 때 이것을 놓쳤습니다. 지금 이것부터 합니다. 금방 끝나며 뒤에 이어지는 퀘스트를 열어 줍니다.",
	-- ["Zapped giants and sea elementals"] = "축소된 거인과 바다 정령",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "{zone:1422} {area:202}에서 {npc:1796} 사냥",
	-- ["their trainers are in {zone:1457} too"] = "이들의 상급자도 {zone:1457}에 있습니다",
	-- ["{area:1943}: kill these as you meet them"] = "{area:1943}: 만나는 대로 처치하세요",
	-- ["{area:200} cauldron"] = "{area:200} 가마솥",
	-- ["{area:201} cauldron"] = "{area:201} 가마솥",
	-- ["{area:976} flight master"] = "{area:976} 비행 조련사",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}은(는) {npc:1855} 서쪽 {area:190}의 시청에 있습니다. 붉은십자군 경비병들이 가까이 붙어 서 있습니다.",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}은(는) {area:201}의 헛간 동쪽에 있습니다.",
	-- ["{item:13320}, from {npc:11056}"] = "{npc:11056}에게서 {item:13320}",
	-- ["{item:14613}, from {npc:11886} (57, elite): grouping up is advised"] = "{item:14613}: {npc:11886}(57, 정예)에게서. 파티를 권장합니다",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: 호위 퀘스트는 경로 후반에 합니다",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}은(는) 안돌할 서쪽의 무너진 여관에서 기다립니다.",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}은(는) 들판 북동쪽, {area:202}의 농장 옆에 있습니다.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}의 유령은 {area:200} 서쪽, {area:199}의 농가 근처를 떠돕니다. 소포는 농가 안에 있습니다.",
	-- ["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}와(과) {npc:7740}은(는) 달의 신전 옆에 있습니다. 안쪽 달샘에서 {item:11682}을(를) 채우세요.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path now; the {zone:2482} guide flies to {area:493}, and the {zone:1451} guide comes back here."] = "{area:493}의 비행 조련사 {npc:10897}은(는) 호수 남쪽, {area:2361} 밖에 있습니다. 지금 비행 경로를 익혀 두세요. {zone:2482} 가이드에서 {area:493}(으)로 날아가고, {zone:1451} 가이드에서 이곳으로 돌아옵니다.",
	-- ["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}의 농가는 야영지 동쪽 언덕 위에 있고, {npc:10936}의 기념비는 바로 그 북쪽에 있습니다.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "예배당 남쪽 무덤 옆의 {npc:11038}",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}이(가) 안돌할 서쪽 {area:199}의 가마솥을 지킵니다.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}은(는) {area:2627}의 아우구스투스 오두막 옆에 있습니다.",
	-- ["{npc:11610}'s next task, {npc:11613} and {npc:11611}, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "{npc:11610}의 다음 임무인 {npc:11613}와(과) {npc:11611}은(는) {zone:1451} 가이드의 역병지대 구간에서 하니 그때 수락하세요.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613}은(는) {npc:11610} 동쪽의 북마루 벌목지를 돌아다니고, {npc:11611}은(는) {area:190} 남쪽 진입로의 탑을 지킵니다.\n주의: 탑 아래에 경비병이 서 있고, 하나가 더 탑 주위를 순찰합니다. 두르겐과 싸우기 전에 처치해 싸움에 끼어들지 않게 하세요.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: 흰개미는 나중에 {area:2627}에서 모읍니다",
	-- ["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}은(는) 정예이므로 파티를 권장합니다",
	-- ["{npc:15189}'s and {npc:15191}'s next tasks (the Stonelash scorpids and the Dredge Crushers) wait for the {zone:1451} guide's {area:3425} stop: take them then."] = "{npc:15189}와(과) {npc:15191}의 다음 퀘스트(채찍꼬리 전갈과 망치미늘벌레)는 {zone:1451} 가이드의 {area:3425} 방문 때 수락하세요.",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, 얼라이언스 천막",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}은(는) 정예이므로 파티를 권장합니다. 안돌할 중앙에서 성물함을 지킵니다.",
	-- ["{npc:5411} in {area:976}: keep it"] = "{area:976}의 {npc:5411}: 보관하세요",
	-- ["{npc:5901}, on the coast north of town"] = "마을 북쪽 해안의 {npc:5901}",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: {area:976}용으로 보관하세요",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "{npc:7775}의 야영지는 {area:1119} 북쪽에 있습니다. 그는 {item:11242}(으)로 {item:11243}을(를) 만듭니다. 그 재료를 구해 오는 심부름을 받으세요.",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}의 야영지는 {area:1119} 북쪽에 있습니다. 미끼를 받으면 {item:11243}을(를) 팝니다.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: {area:440}용으로 보관하세요",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: {zone:1446}용으로 보관하세요",
	-- ["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}: 운고로용으로 보관하세요. 안",
	-- ["{npc:9047}, in the {area:1658}"] = "{area:1658}의 {npc:9047}",
	-- ["{npc:9299} in {area:976}: keep it"] = "{area:976}의 {npc:9299}: 보관하세요",
	-- ["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299}은(는) 마을 바로 동쪽 묘지에 있는 유령입니다. 그곳에서 {item:11243}을(를) 마시면 죽습니다. 영혼을 해방한 뒤 유령 상태로 그에게 말을 거세요. 그런 다음 시체로 달려가 되살아나세요. 묘비는 근처에 있습니다.",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}은(는) 마을 바로 동쪽 묘지에서 기다리며, 묘비는 그 근처에 서 있습니다.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}의 굴은 {npc:9619} 북쪽, 동쪽 절벽 아래 밀림에 있습니다. 그곳에서 {item:11568}을(를) 사용하세요. {npc:9684}은(는) 56레벨이니 생명력이 가득한 상태로 시작하세요.",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}은(는) 분화구 한가운데 {area:537}의 남동쪽 비탈에 앉아 있습니다.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444}은(는) {area:392}에 있습니다",
	-- ["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, 첫 방문 때부터 아직 가지고 있다면",
	-- ["{quest:6762} in {area:493}: keep it"] = "{area:493}의 {quest:6762}: 보관하세요",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}의 {quest:6762}: 보관하세요",
	-- ["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, 첫 방문 이후 라바사우루스가 비늘을 떨어뜨렸다면",
	-- ["{zone:1455}, where the next guide trains, has no druid trainer"] = "다음 가이드에서 훈련하는 {zone:1455}에는 드루이드 상급자가 없습니다",
}
