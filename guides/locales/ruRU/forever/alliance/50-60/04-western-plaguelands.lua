-- Russian (ruRU): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands
	["Western & {zone:1423}"] = "",

	-- Step 1: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Летите сюда: {area:702}",

	-- Step 2: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "Полет заканчивается здесь: {area:702}. {npc:7916} стоит недалеко к северо-западу от распорядителя полетов.",
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
	["{npc:4217}, upstairs"] = "{npc:4217}, наверху",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade · {zone:2482} Mount Hyjal
	["{quest:6762} in {zone:1450}: {zone:2482}'s {zone:1450} errand takes you to her, in the next guide; keep it"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "В городе {zone:1455} нет учителя друидов",

	-- Step 9: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Портал: {zone:1438}",

	-- Step 10: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Летите сюда: {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Распорядитель полетов: {area:702}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Корабль: {area:150}",

	-- Step 12: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Распорядитель полетов: {area:150}",

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
	["Fly to {area:271}"] = "Летите сюда: {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

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
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Чистое Сердце, Дума, Доблестный Кулак и Макдоннел стоят в центре лагеря, у распорядителя полетов.",
	-- {npc:11616} Nathaniel Dumah · {area:2277} Plaguewood
	-- was: ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: термиты будут позже, здесь: {area:2627}"
	["{npc:11616}: the termites come later, in the {area:2277}"] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {area:199} Felstone Field
	["{npc:10838}: the watchtowers stand around Andorhal, on the way to {area:199}"] = "",

	-- Step 22: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission
	["No {quest:5401} yet? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 23: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Сторожевые башни Андорала",
	-- {item:12815} Beacon Torch · {area:199} Felstone Field · {npc:7572} Fallen Hero of the Horde
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	-- was: ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Используйте {item:12815} у подножия каждой из четырех сторожевых башен по краю Андорала, к северу от лагеря.\nОсторожно: скелеты-вожди и мясные големы (57, элита) ходят по улицам Андорала, а {npc:7572} (59, элита) бродит между Андоралом и Северным Кряжем: держитесь башен на краю города и пропускайте их."
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp, on the way to {area:199}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",

	-- Step 24: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Котел: {area:199}",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw · {npc:10778} Janice Felstone · {zone:1453} Stormwind
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["West of Andorhal to {area:199}: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54).\n{npc:10778}'s ghost wanders by the farmhouse at the field's edge, upstairs; her parcel lies inside the house: take it for {zone:1453}, at the end of this guide."] = "",
	-- {npc:10778} Janice Felstone
	["{npc:10778}, upstairs in the farmhouse"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "{object:175894}, внутри",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Для города {zone:1453}: сохраните задание",

	-- Step 25: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Back to {area:3197}."] = "",
	-- {area:200} Dalson's Tears
	["The cauldron is at {area:200}"] = "",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} – элитный противник 61-го уровня",

	-- Step 26: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: убивайте их по пути",
	-- {quest:5401} Argent Dawn Commission · {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones while you wear the {quest:5401} (equip it as a trinket first).\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Скелеты-живодеры и слюнявые вурдалаки бродят по полям к северу от лагеря; вся Плеть здесь роняет камни Плети, пока на вас {quest:5401} (сначала наденьте его как аксессуар).\nОсторожно: эта нежить замечает вас издалека, а другая нежить рядом вступает в бой, когда вы атакуете одного.\nОсторожно: {npc:10411} (3 места появления, возрождение 15 мин) невидимо вне боя и призывает горгулий Крыла Скалы, как только начинается бой.",

	-- Step 27: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the ghost in {area:2262}, the next stop."] = "",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: сохраните для места {area:2262}",

	-- Step 28: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "В зону {zone:1423}",
	-- {zone:1422} Western Plaguelands
	["Follow the southern road east out of the {zone:1422}."] = "",

	-- Step 29: Pamela Redpath
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["The ruins of {area:2262} lie south of the road. {npc:10926}'s ghost plays by the ruined house at the south end."] = "",

	-- Step 30: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "Кукла {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Три части куклы лежат в разрушенных домах ({area:2262}); если подобрать одну, могут появиться призраки. Соедините их в куклу.",
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
	["Upstairs"] = "Наверху",
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal, later on this loop: keep it"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894} – у памятника",

	-- Step 33: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {npc:10927} Marlene Redpath
	["{npc:10739} stands by the farm at the {area:202}, north of {npc:10927}."] = "",
	["Inside"] = "Внутри",

	-- Step 34: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202}: убивайте их по пути",
	-- {item:12841} Invader's Scourgestone · {quest:5401} Argent Dawn Commission
	["{item:12841}: wear the {quest:5401} while you kill"] = "{item:12841}: убивайте, надев {quest:5401}",

	-- Step 36: Diseased Grizzlies
	["Diseased Grizzlies"] = "Болезненные гризли",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The Diseased Grizzlies (55-56) roam the woods around the {area:202}, east and north of {npc:10739}."] = "",

	-- Step 37: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1457} Darnassus
	["{npc:10739}' next task goes to the druids of {zone:1457}, behind the route now: skip it."] = "",

	-- Step 38: Dalson's Tears
	-- {npc:10836} Farmer Dalson · {npc:11152} The Scourge Cauldron
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key. {npc:11152} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924} – в доме; внутри",

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
	["Andorhal"] = "Андорал",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments · {npc:1852} Araj the Summoner
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	-- was: ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "Используйте {item:12627} у зернохранилищ, чтобы выманить временных паразитов. {quest:5154} – один из пыльных томов в ратуше. С каждого скелета в городе падает {quest:5537}.\nОсторожно: временные паразиты 55-57-го уровня, а по улицам ходят скелеты-вожди и мясные големы (57, элита): выманивайте паразитов у зернохранилищ по одному и пропускайте элиту."
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass.\n{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "",

	-- Step 44: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210} ({area:2268}): сохраните задание",

	-- Step 45: Sorrow Hill: kill these as you meet them
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 47: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Котел: {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	-- was: ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Котел стоит у фермы {npc:10739}: {area:202}."
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
	["{area:3197} flight master"] = "Распорядитель полетов: {area:3197}",

	-- Step 50: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332} – в здании ШРУ",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}, on the flight back"] = "",

	-- Step 51: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520} – ходит вдоль каналов",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, out of the way now: skip it."] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722} – здесь: {object:2096}",

	-- Step 52: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Летите сюда: {area:3197}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Распорядитель полетов: {zone:1453}",

	-- Step 53: Flint Shadowmore
	-- {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["The agents' remains lie at the {area:2260} in the {zone:1423}, on this guide's ride east"] = "",

	-- Step 54: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Езжайте по дороге на север к Лесопилке Северного Кряжа; {npc:11610} прячется на краю лагеря.",

	-- Step 55: The Scarlet Crusade
	["The Scarlet Crusade"] = "Алый орден",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Медики, охотники, рыцари и маги из Алого ордена патрулируют лесопилку и дорогу к месту {area:190}.",

	-- Step 57: Radley and Durgen
	["Radley and Durgen"] = "Рэдли и Дурген",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	-- was: ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} ходит по лагерю Северного Кряжа к востоку от {npc:11610}; {npc:11611} охраняет башню на южных подступах (ориентир: {area:190}).\nОсторожно: у подножия башни стоят стражи, и еще один патрулирует вокруг нее. Перебейте их, прежде чем нападать на Дургена, чтобы они не вмешались в бой."
	["{npc:11613} (56) walks the Northridge camp east of {npc:11610}; {npc:11611} (57) guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 58: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} прячется на краю лесопилки.",

	-- Step 59: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Обзорная точка: {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 61: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2277} Plaguewood · {area:2627} Terrordale
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank. His hunts are in the {area:2277} and {area:2627}, at the end of this guide's ride east."] = "",

	-- Step 62: Gahrron's Withering
	-- {npc:1855} Tirion Fordring · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south from {npc:1855}'s hut to {area:201}. {npc:11078} (58) guards the cauldron.\nCareful: Soulwrath is level 58, a level over you here: clear the ghouls around the cauldron first and pull him alone."] = "",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "Для персонажа {npc:11053} ({area:3197}), в конце этого гайда",

	-- Step 63: Marris Stead
	-- {zone:1423} Eastern Plaguelands · {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride east into the {zone:1423}: the {area:2260} is the farm north of the southern road, north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "",
	["Close enough to see the Blightcaller in front of the house"] = "",

	-- Step 64: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: убивайте их по пути",
	-- {zone:1423} Eastern Plaguelands · {area:2268} Light's Hope Chapel
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Gargantuan Plaguebats = {npc:272342} Gargantuan Plaguebat
	["Ride east along the southern road across the {zone:1423} to {area:2268}: Plaguehound Runts and Plaguebats roam beside it.\nCareful: Gargantuan Plaguebats (60) fly among the smaller bats near the western border: take the Plaguebats of your level."] = "",

	-- Step 65: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "Следующее задание NPC {npc:11063} ({area:2264}) — среди Плети 57-60-го уровня: пропустите его.",
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
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Езжайте на северо-запад: {area:2276}, на краю зоны {area:2277}.",

	-- Step 70: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: убивайте их по пути",
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
	["Listen to his story"] = "Выслушайте его историю",

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
	["Underwater"] = "Под водой",

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
	["Stormwind City"] = "Штормград",
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:1748}, in {object:2117}"] = "",

	-- Step 90: Stormwind
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone · {npc:10782} Royal Factor Bathrilor · {object:2096} Trade District · {npc:3520} Ol' Emma · {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["Without the flight to {zone:1453} at 56 earlier in this guide: {npc:10778}'s parcel goes to {npc:10782} in the {object:2096}, then {npc:3520} takes her own errand on the canals. {npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, behind you now: skip it."] = "",

	-- Step 91: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Летите сюда: {area:150}",

	-- Step 92: Boat to Theramore
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook
	["Take the boat to Theramore: {zone:2482}, the next guide, starts with the flight to {area:2255}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["After the farm's keys: the {object:177289} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "После ключей фермы: {object:177289} стоит чуть к юго-западу от фермерского дома, а ключ у его повелителя котла рядом.",
	-- ["Andorhal Watches"] = "Часы из Андорала",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Назад на север: {area:202} – теперь котел предлагает свое задание. С ближайших вурдалаков падают соматические усилители.",
	-- ["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one, and {npc:9299} in {area:976} shows himself only to someone who has drunk one."] = "Назад в лагерь {npc:7775}, чуть к юго-востоку от {npc:7765}: за {item:11242} вы получите три эликсира Видере. Сохраните их: {npc:9298} берет один, а {npc:9299} ({area:976}) показывается только тому, кто выпил эликсир.",
	-- ["Below ground"] = "Под землей",
	-- ["Boat to {area:1108}"] = "Корабль: {area:1108}",
	-- ["Bones and equipment"] = "Кости и оборудование",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Купите {item:13320} (1 шт.) для котла Фелстоуна прямо перед выходом; продает {npc:11056}. Ускорители исчезают через 30 минут.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Купите еще два чародейских ускорителя для котлов ({area:202} и Далсона) и сразу езжайте туда: они исчезают через 30 минут.",
	-- ["Careful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "Осторожно: бесноватые чумные псы 57–58-го уровня, выманивайте их по одному.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Поднимитесь на холм к западу (ориентир: {area:190}), чтобы осмотреть город сверху.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Перейдите реку на восток к {area:2261} – склепу на юго-западе зоны. {object:177667} лежит внутри: ключ от него у персонажа {npc:12248} на дальнем северо-востоке, это будет в следующем гайде.\nОсторожно: вместе с Меркуцио появляются около четырех неэлитных помощников. Они идут к могиле, а не появляются на месте.",
	-- ["Cross the river west to {npc:1855}'s hut."] = "Перейдите реку на запад к хижине {npc:1855}.",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Пересеките юг кратера и вернитесь к {npc:9619} у спуска.",
	-- ["Diseased Wolves"] = "Больные волки",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Дальше на западе роются земляные сокрушители; в тех же песках охотятся камнехвостые клешневики, камнехвостые живодеры и скальные пауки-скакуны.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Землечерпы роются в дюнах к северо-западу от крепости; повсюду бродят камнехвостые скорпиды и песчаные пауки-быстроноги.",
	-- ["Eastern Pylon and the crate"] = "Восточный пилон и ящик",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Завершается у NPC {npc:9298} (зона {area:618}): сохраните",
	-- ["Ends with {npc:9298} in {zone:1452}: keep it"] = "Завершается у NPC {npc:9298} (зона {zone:1452}): сохраните",
	-- ["Escort {npc:9999}"] = "Сопроводите NPC {npc:9999}",
	-- ["Fly from {area:976} to {area:541}. {npc:8737} stands at the back of the refuge; {npc:9117} is in the cave behind him.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Летите из места {area:976} сюда: {area:541}. {npc:8737} стоит в глубине убежища; {npc:9117} – в пещере за ним.\nДруг {npc:9997}, {npc:9999}, пропал.",
	-- ["Fly to Theramore"] = "Лететь на остров Терамор",
	-- ["Fly to {area:2255}"] = "Летите сюда: {area:2255}",
	-- ["Fly to {area:2268}"] = "Летите сюда: {area:2268}",
	-- ["Fly to {area:392}"] = "Летите сюда: {area:392}",
	-- ["Fly to {area:392}."] = "Летите сюда: {area:392}.",
	-- ["Fly to {area:541}"] = "Летите сюда: {area:541}",
	-- ["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- ["For the druids of {zone:1457}: keep it"] = "Для друидов ({zone:1457}): сохраните задание",
	-- ["For {area:1377}: keep it"] = "Для зоны {area:1377}: сохраните задание",
	-- ["For {area:3197}: keep it"] = "Для места {area:3197}: сохраните задание",
	-- ["For {zone:1448}: keep it"] = "Для зоны {zone:1448}: сохраните задание",
	-- ["For {zone:1451}: keep it"] = "Для зоны {zone:1451}: сохраните задание",
	-- ["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Из Терамора езжайте на запад ({zone:1413}) и на север вдоль побережья сюда: {area:392}.",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Летите: {area:392} → {area:2255}, затем езжайте на юг: {area:2250}.",
	-- ["From {area:702}, fly to {area:1116}."] = "Летите: {area:702} → {area:1116}.",
	-- ["Hearth to {area:392} (bound there earlier on this guide), then fly on to {area:976}."] = "Используйте камень возвращения ({area:392}, вы привязались там ранее в этом гайде), затем летите дальше: {area:976}.",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Череп Хоргуса лежит здесь: {area:2624}, а меч Мардука – здесь: {area:2623}; оба там, где сражаются призраки. На равнинах между ними охотятся взрослые чумные псы.",
	-- ["Into {zone:1451}"] = "В зону {zone:1451}",
	-- ["MacDonnell's next task, {area:201}'s cauldron, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "Следующее задание Макдонелл, котел ({area:201}), ждет части гайда {zone:1451} в Чумных землях: возьмите его тогда.",
	-- ["More watches"] = "Еще часы",
	-- ["North to the refuge, for the quests the first Un'Goro visit left: {npc:9618} stands just outside and {npc:9117} in the cave at the back; the expedition's other three wait for your next stop here."] = "На север к убежищу – за заданиями, оставшимися с первого визита в Ун'Горо: {npc:9618} стоит прямо у входа, а {npc:9117} – в пещере в глубине; трое других членов экспедиции подождут вашей следующей остановки здесь.",
	-- ["Northern Pylon"] = "Северный пилон",
	-- ["On {npc:7583}"] = "У персонажа {npc:7583}",
	-- ["Ranshalla in {zone:1452}: keep it"] = "Раншалла ({zone:1452}): сохраните задание",
	-- ["Ride back south to the camp."] = "Езжайте назад на юг к лагерю.",
	-- ["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Езжайте обратно на юго-запад к башне ({area:2742}, {area:2738}); поднимитесь на нее и убейте засаду, которая появляется ради покрытого коркой предмета.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Езжайте назад: {area:3197}, летите сюда: {area:150}, плывите на корабле сюда: {area:442} и летите сюда: {area:702}; портал ведет наверх ({zone:1457}).",
	-- ["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Езжайте обратно сюда: {area:3425}. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, стрелка не различает этажи.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Езжайте по спуску вниз в кратер: {npc:9619} стоит лагерем у его подножия.",
	-- ["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Езжайте на восток к пограничной реке: {npc:1855} живет в маленькой хижине на берегу.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Езжайте на восток к башне ({area:2742}, {area:2738}); поднимитесь на нее и убейте засаду, которая появляется ради покрытого коркой предмета.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Езжайте на восток: {area:1943}, где робот стоит среди горилл. Не заходите там в глубокую пещеру.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Езжайте на восток к вулкану ({area:537}), поднимитесь на него и используйте {npc:10541} у лавовых отдушин у вершины.",
	-- ["Ride east to {npc:13220}."] = "Езжайте на восток: {npc:13220}.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Езжайте на север по восточной стороне к плато горилл. {npc:9622}, горилла 55-го уровня, сидит в самой глубокой пещере: сначала перебейте горилл у входа.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Скачите на север сюда: {area:2627}. {npc:12384} живет в разрушенной хижине, а его книга расписок лежит в разрушенной таверне поблизости.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\nCareful: the Frenzied Plaguehounds north-east of the hut are 57-58, a level or two over you: pull them one at a time."] = "Скачите на север сюда: {area:2627}. {npc:12384} живет в разрушенной хижине, а его книга расписок лежит в разрушенной таверне поблизости.\nОсторожно: бесноватые чумные псы к северо-востоку от хижины 57-58-го уровня, на уровень-два выше вас: атакуйте их по одному.",
	-- ["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Езжайте на северо-запад к ферме Далсона. Дневник лежит в амбаре; ключ от нужника носит бродячий скелет, а {npc:10836} ждет в нужнике с ключом от шкафчика.",
	-- ["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Езжайте дальше на запад: {area:3425}. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, стрелка не различает этажи.",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Езжайте на юг: {area:201}; там котел охраняет {npc:11078}.",
	-- ["Ride south-west to the camp."] = "Езжайте на юго-запад к лагерю.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Езжайте на юго-запад к лагерю ({npc:7771}): {area:1938}.",
	-- ["Ride west along the road to the hot springs."] = "Езжайте по дороге на запад к горячим источникам.",
	-- ["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Езжайте на запад в Руины Воронова Ветра: {npc:7774} прячется в маленьком круглом здании в глубине. Откройте сундук рядом с ней ради предмета {item:9189}: он действует 15 минут, как и задание.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Езжайте на запад мимо места {area:541} и на юг по западной стороне: {area:543}. {npc:10302}, гоблин, сидит у воды.",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Езжайте на запад: {area:2627}. По лесам бродят карликовые чумные псы, чумные нетопыри и личинки-падальщики; наполните предмет {item:15042} у больших термитников и убейте бесноватых чумных псов дальше к северу.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Напугайте {npc:7583} с помощью предмета {item:12928}",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Скелеты-живодеры и слюнявые вурдалаки бродят по полям к северу от лагеря; со всей Плети здесь падают камни Плети.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Маленькие сундучки лежат в развалинах по всему Андоралу; в каждом – часы.",
	-- ["Take the boat to the mainland and ride north-east past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Плывите на корабле на материк и езжайте на северо-восток мимо места {area:1119} к лагерю {npc:7775}. Он варит {item:11243} из предмета {item:11242}: возьмите его поручение ради него.",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Плывите на корабле на материк и езжайте на северо-восток к лагерю {npc:14637} (ориентир: {area:1119}).",
	-- ["Temple of the Moon"] = "Храм Луны",
	-- ["Ten {item:11040} from the {item:11020}"] = "Десять шт. {item:11040} из предмета {item:11020}",
	-- ["The Gorishi hive"] = "Улей Гориши",
	-- ["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Смоляные чудища и смоляные повелители барахтаются здесь: {area:538} – к югу от убежища, по пути вниз в кратер.",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Теперь котел предлагает свое задание; с окрестных скелетов падают костяные катализаторы.",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Котел стоит у фермы {npc:10739}: {area:202}.",
	-- ["The crater"] = "Кратер",
	-- ["The fields"] = "Поля",
	-- ["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Гориллы живут здесь: {area:1943}, чуть к востоку от пилона. Соберите шкуры для {npc:9619} сейчас, пока вы наверху. Не заходите в самую глубокую пещеру: {npc:9622} – 55-го уровня.\nОсторожно: гориллы Ун'Горо (50–51-го уровня), потеряв 75% здоровья, зовут на помощь союзников в радиусе 20 ярдов. В этой местности есть пещера, полная обезьян, и бой там привлечет много противников.",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Следующий гайд начинается здесь ({area:392}) и продолжается полетом сюда: {area:976}.",
	-- ["The pelts come from the gorillas on {area:1943}"] = "Шкуры – с горилл на плато: {area:1943}",
	-- ["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "Пилон стоит на восточных утесах над логовом зверя {npc:9684}; {item:11113} экспедиции – в заброшенном лагере в восточных джунглях.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}."] = "Пилон стоит на склоне к востоку от убежища. По склонам вокруг него кружат жутедактили ({npc:9166}): они засчитываются для {npc:9997}.",
	-- ["The pylon stands on the western cliffs."] = "Пилон стоит на западных утесах.",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Уменьшенные великаны бродят здесь: {area:1119}; морские элементали – вдоль побережья к западу.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Истерзанные друиды и часовые бродят по разрушенной деревне к юго-западу от {npc:13220}.",
	-- ["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с NPC {npc:9997}",
	-- ["The {area:2742} tower"] = "Башня: {area:2742}",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "{item:11242} растет внутри разрушенного здания к северу от {npc:7765}: заберитесь внутрь через пролом в стене с уступа рядом.",
	-- ["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "{item:280417} – недалеко к западу от лагеря {npc:9619}.",
	-- ["Umber in {area:493}: keep it"] = "Умбер ({area:493}): сохраните задание",
	-- ["Umber in {zone:1450}: keep it"] = "Умбер ({zone:1450}): сохраните задание",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Используйте {item:12627} у зернохранилищ, чтобы выманить временных паразитов. {quest:5154} – один из пыльных томов в ратуше. С каждого скелета в городе падает {quest:5537}.",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "Используйте {item:12627} у зернохранилищ, чтобы выманить временных паразитов. {quest:5154} – один из пыльных томов в ратуше. С каждого скелета в городе падает {quest:5537}.\nОсторожно: временные паразиты 55-57-го уровня, а по улицам ходят скелеты-вожди и мясные големы (57, элита): выманивайте паразитов у зернохранилищ по одному и пропускайте элиту.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Используйте {item:12815} у подножия каждой из четырех сторожевых башен по краям Андорала, к северу от лагеря.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Используйте {item:12815} у подножия каждой из четырех сторожевых башен по краю Андорала, к северу от лагеря.\nОсторожно: скелеты-вожди и мясные големы (57, элита) ходят по улицам Андорала, а {npc:7572} (59, элита) бродит между Андоралом и Северным Кряжем: держитесь башен на краю города и пропускайте их.",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Войдите сюда: {area:1769} – и идите по ответвлению туннеля в зону {area:493}, до места {area:2361}.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Войдите сюда: {area:1769} – и идите по ответвлению туннеля в зону {zone:1450}, до места {area:2361}.",
	-- ["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "На запад через южную часть кратера: кости динозавров лежат на земле на юго-западе, среди стегодонов. Они элитные: подбирайте кости вокруг них, а остальные добудьте с диметродонов. {item:11112} экспедиции лежит в юго-западных джунглях.",
	-- ["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "На запад вдоль южной части кратера: ее занимает улей силитидов Гориши. Используйте пузырек для соскоба в инкубаторе – камере со свисающими личинками.",
	-- ["Western Pylon"] = "Западный пилон",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.",
	-- ["Zapped giants and sea elementals"] = "Уменьшенные великаны и морские элементали",
	-- ["grind on {npc:11740}"] = "убивайте: {npc:11740}",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "убивайте мобов ({npc:1796}): {area:202}, {zone:1422}",
	-- ["their trainers are in {zone:1457} too"] = "их учителя тоже в городе {zone:1457}",
	-- ["{area:1942}: kill these as you meet them"] = "{area:1942}: убивайте их по пути",
	-- ["{area:1943}: kill these as you meet them"] = "{area:1943}: убивайте их по пути",
	-- ["{area:200} cauldron"] = "Котел: {area:200}",
	-- ["{area:201} cauldron"] = "Котел: {area:201}",
	-- ["{area:348} flight master"] = "Распорядитель полетов: {area:348}",
	-- ["{area:392} flight master"] = "Распорядитель полетов: {area:392}",
	-- ["{area:442} flight master"] = "Распорядитель полетов: {area:442}",
	-- ["{area:489} flight master"] = "Распорядитель полетов: {area:489}",
	-- ["{area:538}: kill these as you meet them"] = "{area:538}: убивайте их по пути",
	-- ["{area:976} flight master"] = "Распорядитель полетов: {area:976}",
	-- ["{item:11478}; below ground"] = "{item:11478}; под землей",
	-- ["{item:11479}; below ground"] = "{item:11479}; под землей",
	-- ["{item:11480}; below ground"] = "{item:11480}; под землей",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} лежит в ратуше ({area:190}) к западу от {npc:1855}: стражи Алого ордена стоят плотно.",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} лежит к востоку от амбара ({area:201}).",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}: продает {npc:11056}",
	-- ["{item:14613}, from {npc:11886} (57, elite): grouping up is advised"] = "{item:14613}, с NPC {npc:11886} (57, элитный): лучше собрать группу",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: ее сопровождение будет позже по маршруту",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала.",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} стоит у фермы к северо-востоку от полей: {area:202}.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от места {area:200}; ее посылка лежит внутри.",
	-- ["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} и {npc:7740} стоят у Храма Луны; наполните {item:11682} у лунного колодца внутри.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path now; the {zone:2482} guide flies to {area:493}, and the {zone:1451} guide comes back here."] = "{npc:10897}, распорядитель полетов зоны {area:493}, стоит к югу от озера, за пределами места {area:2361}. Откройте маршрут полета сейчас: гайд по зоне {zone:2482} летит сюда ({area:493}), а гайд по зоне {zone:1451} возвращается сюда.",
	-- ["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "Дом {npc:10927} стоит на холме к востоку от лагеря; памятник ({npc:10936}) – чуть севернее.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038} – у могил к югу от часовни",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} охраняет котел ({area:199}) к западу от Андорала.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} стоит у хижины Августа ({area:2627}).",
	-- ["{npc:11610}'s next task, {npc:11613} and {npc:11611}, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "Следующее задание NPC {npc:11610}, {npc:11613} и {npc:11611}, ждет части гайда {zone:1451} в Чумных землях: возьмите его тогда.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} ходит по лагерю Северного Кряжа к востоку от {npc:11610}; {npc:11611} охраняет башню на южных подступах (ориентир: {area:190}).\nОсторожно: у подножия башни стоят стражи, и еще один патрулирует вокруг нее. Перебейте их, прежде чем нападать на Дургена, чтобы они не вмешались в бой.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: термиты будут позже, здесь: {area:2627}",
	-- ["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} – элитный противник: лучше собрать группу",
	-- ["{npc:15189}'s and {npc:15191}'s next tasks (the Stonelash scorpids and the Dredge Crushers) wait for the {zone:1451} guide's {area:3425} stop: take them then."] = "Следующие поручения {npc:15189} и {npc:15191} (скорпиды Каменного Хлыста и земляные сокрушители) ждут остановки в месте {area:3425} в гайде по зоне {zone:1451}: возьмите их тогда.",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082} – у палаток Альянса",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} – элитный противник: лучше собрать группу. Он охраняет свою филактерию в центре Андорала.",
	-- ["{npc:5411} in {area:976}: keep it"] = "{npc:5411} ({area:976}): сохраните задание",
	-- ["{npc:5594}, inside"] = "{npc:5594}, внутри",
	-- ["{npc:5901}, on the coast north of town"] = "{npc:5901} – на побережье к северу от города",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: сохраните задание для места {area:976}",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Лагерь {npc:7775} – к северу (ориентир: {area:1119}). Он варит {item:11243} из предмета {item:11242}: возьмите его поручение ради него.",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "Лагерь {npc:7775} – к северу (ориентир: {area:1119}). Он продает {item:11243}, когда получит свою наживку.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: сохраните задание для зоны {area:440}",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: сохраните задание для зоны {zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}: сохраните задание для Кратера Ун'Горо; внутри",
	-- ["{npc:8598}, 170 yd north-east"] = "{npc:8598} – 170 ярдов к северо-востоку",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047} – здесь: {area:1658}",
	-- ["{npc:9117}, below ground"] = "{npc:9117}, под землей",
	-- ["{npc:9299} in {area:976}: keep it"] = "{npc:9299} ({area:976}): сохраните задание",
	-- ["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} – призрак на кладбище чуть к востоку от городка: выпейте там {item:11243} (он вас убьет), освободите дух и поговорите с ним в облике призрака. Затем бегите обратно к телу, чтобы ожить: надгробие стоит неподалеку.",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} ждет на кладбище чуть восточнее города; надгробие стоит рядом.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Логово зверя {npc:9684} – в джунглях к северу от {npc:9619}, под восточными утесами: используйте там {item:11568}. {npc:9684} – 56-го уровня: начинайте бой с полным здоровьем.",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} сидит на юго-восточном склоне вулкана ({area:537}) в середине кратера.",
	-- ["{object:179565}; inside"] = "{object:179565}; внутри",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} – здесь: {area:392}",
	-- ["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, если оно еще осталось с первого визита",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} ({area:493}): сохраните задание",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} ({zone:1450}): сохраните задание",
	-- ["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, если с первого визита с равазавра выпала чешуя",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}: убивайте их по пути",
	-- ["{zone:1451}: kill these as you meet them"] = "{zone:1451}: убивайте их по пути",
	-- ["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, где следующий гайд посещает учителей, не имеет учителя друидов",
}
