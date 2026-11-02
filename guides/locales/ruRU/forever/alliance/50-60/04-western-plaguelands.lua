-- Russian (ruRU): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "Дом {npc:10927} стоит на холме к востоку от лагеря; памятник ({npc:10936}) – чуть севернее.",
	["Upstairs"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894} – у памятника",

	-- Step 4: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} стоит у фермы к северо-востоку от полей: {area:202}.",
	["Inside"] = "",

	-- Step 5: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Езжайте на северо-запад к ферме Далсона. Дневник лежит в амбаре; ключ от нужника носит бродячий скелет, а {npc:10836} ждет в нужнике с ключом от шкафчика.",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",

	-- Step 6: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	["{area:202}: kill these as you meet them"] = "",

	-- Step 7: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "",

	-- Step 8: Chillwind Camp
	["Ride back south to the camp."] = "Езжайте назад на юг к лагерю.",

	-- Step 9: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Сторожевые башни Андорала",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Используйте {item:12815} у подножия каждой из четырех сторожевых башен по краям Андорала, к северу от лагеря.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",

	-- Step 10: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Котел: {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} охраняет котел ({area:199}) к западу от Андорала.",

	-- Step 11: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от места {area:200}; ее посылка лежит внутри.",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Для города {zone:1453}: сохраните задание",

	-- Step 12: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",

	-- Step 13: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} – элитный противник 61-го уровня",

	-- Step 14: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Котел: {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "Котел стоит к северо-востоку от поля Фелстоуна ({area:200}); рядом – его повелитель котла.",

	-- Step 15: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала.",

	-- Step 16: Andorhal
	["Andorhal"] = "Андорал",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Используйте {item:12627} у зернохранилищ, чтобы выманить временных паразитов. {quest:5154} – один из пыльных томов в ратуше. С каждого скелета в городе падает {quest:5537}.",

	-- Step 18: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Котел: {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Котел стоит у фермы {npc:10739}: {area:202}.",

	-- Step 20: Diseased Grizzlies
	["Diseased Grizzlies"] = "Болезненные гризли",

	-- Step 21: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Для друидов ({zone:1457}): сохраните задание",

	-- Step 24: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210} ({area:2268}): сохраните задание",

	-- Step 25: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 27: More watches
	["More watches"] = "Еще часы",

	-- Step 29: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Езжайте по дороге на север к Лесопилке Северного Кряжа; {npc:11610} прячется на краю лагеря.",

	-- Step 30: Scarlet Knight on the way
	-- {npc:1833} Scarlet Knight
	["{npc:1833} on the way"] = "",
	-- {npc:1833} Scarlet Knight · {npc:11610} Kirsta Deepshadow
	["{npc:1833} along the way to {npc:11610}"] = "",

	-- Step 31: The Scarlet Crusade
	["The Scarlet Crusade"] = "Алый орден",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Медики, охотники, рыцари и маги из Алого ордена патрулируют лесопилку и дорогу к месту {area:190}.",

	-- Step 33: Radley and Durgen
	["Radley and Durgen"] = "Рэдли и Дурген",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 35: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Обзорная точка: {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 37: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Езжайте на восток к пограничной реке: {npc:1855} живет в маленькой хижине на берегу.",

	-- Step 38: Slab of Carrion Worm Meat on the way
	-- {item:13853} Slab of Carrion Worm Meat
	["{item:13853} on the way"] = "",

	-- Step 39: Frenzied Plaguehound on the way
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598} on the way"] = "",

	-- Step 40: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Котел: {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Езжайте на юг: {area:201}; там котел охраняет {npc:11078}.",

	-- Step 41: Chillwind Camp
	["Ride south-west to the camp."] = "Езжайте на юго-запад к лагерю.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} ({area:976}): сохраните задание",

	-- Step 42: Hearth to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Hearth to {area:2268}"] = "",

	-- Step 43: To Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["To {area:2268}"] = "",

	-- Step 44: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038} – у могил к югу от часовни",

	-- Step 45: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Череп Хоргуса лежит здесь: {area:2624}, а меч Мардука – здесь: {area:2623}; оба там, где сражаются призраки. На равнинах между ними охотятся взрослые чумные псы.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 46: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Езжайте на северо-запад: {area:2276}, на краю зоны {area:2277}.",

	-- Step 47: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Езжайте на запад: {area:2627}. По лесам бродят карликовые чумные псы, чумные нетопыри и личинки-падальщики; наполните предмет {item:15042} у больших термитников и убейте бесноватых чумных псов дальше к северу.",

	-- Step 48: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "",

	-- Step 49: Egan
	-- {npc:11140} Egan · {npc:12384} Augustus the Touched · {area:2627} Terrordale
	["{npc:11140} stands by {npc:12384}' hut in {area:2627}."] = "",

	-- Step 50: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",

	-- Step 51: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Перейдите реку на запад к хижине {npc:1855}.",

	-- Step 53: Tirion Fordring
	["Listen to his story"] = "Выслушайте его историю",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} – элитный противник: лучше собрать группу",

	-- Step 55: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} лежит к востоку от амбара ({area:201}).",

	-- Step 56: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} лежит в ратуше ({area:190}) к западу от {npc:1855}: стражи Алого ордена стоят плотно.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 58: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 60: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 62: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} и {npc:7740} стоят у Храма Луны; наполните {item:11682} у лунного колодца внутри.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: сохраните задание для места {area:976}",

	-- Step 63: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047} – здесь: {area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, где следующий гайд посещает учителей, не имеет учителя друидов",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Десять шт. {item:11040} из предмета {item:11020}",
	-- {quest:6762} Rabine Saturna · {area:493} Moonglade
	["{quest:6762} in {area:493}: keep it"] = "",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 65: Rut'theran Village
	-- {area:618} Winterspring
	["Ranshalla in {area:618}: keep it"] = "",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Летите: {area:702} → {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {area:440} Tanaris
	["{npc:7900}: keep it for {area:440}"] = "",

	-- Step 68: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "",

	-- Step 69: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Плывите на корабле на материк и езжайте на северо-восток к лагерю {npc:14637} (ориентир: {area:1119}).",

	-- Step 70: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Уменьшенные великаны бродят здесь: {area:1119}; морские элементали – вдоль побережья к западу.",

	-- Step 72: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "Лагерь {npc:7775} – к северу (ориентир: {area:1119}). Он продает {item:11243}, когда получит свою наживку.",

	-- Step 74: Fly to Theramore
	["Fly to Theramore"] = "",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 76: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "Летите сюда: {area:392}.",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901} – на побережье к северу от города",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Для зоны {zone:1448}: сохраните задание",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "",

	-- Step 77: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 79: Donova Snowden
	["Ride west along the road to the hot springs."] = "Езжайте по дороге на запад к горячим источникам.",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "",

	-- Step 81: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {area:493} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Для зоны {zone:1451}: сохраните задание",

	-- Step 82: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 83: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",

	-- Step 84: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["From {area:392}, fly to {area:976}."] = "",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "",

	-- Step 85: Super Sticky Tar on the way
	-- {item:11834} Super Sticky Tar
	["{item:11834} on the way"] = "",

	-- Step 86: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "",

	-- Step 87: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "",

	-- Step 89: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 90: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9997} Spraggle Frock
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; J.D.\n{npc:9997}'s friend Ringo has gone missing."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "",

	-- Step 91: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",
	-- {npc:9167} Frenzied Pterrordax
	["{npc:9167} walks around here: look inside the circle on the map"] = "",

	-- Step 92: Level 56.84
	["Level 56.84"] = "",
	-- {item:9328} Super Snapper FX
	["If you skipped The {item:9328}, grind here to level 56.84 to stay on the route's plan."] = "",
	-- {npc:6520} Scorching Elemental
	["grind on {npc:6520}"] = "",

	-- Step 93: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 94: The crater
	["The crater"] = "",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",

	-- Step 95: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "",
	["The pelts come after loop 2, on the gorilla plateau"] = "",

	-- Step 96: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "",

	-- Step 97: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "",
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "",

	-- Step 99: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "",
	["Below ground"] = "",

	-- Step 100: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "",

	-- Step 101: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "",

	-- Step 102: J.D. Collie
	["Collie is up the hill behind it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",

	-- Step 105: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "",

	-- Step 106: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill Laris's Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "",

	-- Step 107: Krakle
	-- {npc:9298} Donova Snowden · {area:618} Winterspring
	["Ends with {npc:9298} in {area:618}: keep it"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "Часы из Андорала",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Назад на север: {area:202} – теперь котел предлагает свое задание. С ближайших вурдалаков падают соматические усилители.",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Купите {item:13320} (1 шт.) для котла Фелстоуна прямо перед выходом; продает {npc:11056}. Ускорители исчезают через 30 минут.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Купите еще два чародейских ускорителя для котлов ({area:202} и Далсона) и сразу езжайте туда: они исчезают через 30 минут.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Поднимитесь на холм к западу (ориентир: {area:190}), чтобы осмотреть город сверху.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Перейдите реку на восток к {area:2261} – склепу на юго-западе зоны. {object:177667} лежит внутри: ключ от него у персонажа {npc:12248} на дальнем северо-востоке, это будет в следующем гайде.",
	-- ["Diseased Wolves"] = "Больные волки",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Летите: {area:392} → {area:2255}, затем езжайте на юг: {area:2250}.",
	-- ["Gaeriyan in {area:976}: keep it"] = "Гаэриан ({area:976}): сохраните задание",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Езжайте назад: {area:3197}, летите сюда: {area:150}, плывите на корабле сюда: {area:442} и летите сюда: {area:702}; портал ведет наверх ({zone:1457}).",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Скелеты-живодеры и слюнявые вурдалаки бродят по полям к северу от лагеря; со всей Плети здесь падают камни Плети.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Маленькие сундучки лежат в развалинах по всему Андоралу; в каждом – часы.",
	-- ["Temple of the Moon"] = "Храм Луны",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Теперь котел предлагает свое задание; с окрестных скелетов падают костяные катализаторы.",
	-- ["The fields"] = "Поля",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Следующий гайд начинается здесь ({area:392}) и продолжается полетом сюда: {area:976}.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Войдите сюда: {area:1769} – и идите по ответвлению туннеля в зону {zone:1450}, до места {area:2361}.",
	-- ["Zapped giants and sea elementals"] = "Уменьшенные великаны и морские элементали",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "убивайте мобов ({npc:1796}): {area:202}, {zone:1422}",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}: продает {npc:11056}",
	-- ["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} ({zone:1452}): сохраните задание",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: ее сопровождение будет позже по маршруту",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} стоит у хижины Августа ({area:2627}).",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} ходит по лагерю Северного Кряжа к востоку от {npc:11610}; {npc:11611} охраняет башню на южных подступах (ориентир: {area:190}).",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: термиты будут позже, здесь: {area:2627}",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} – элитный противник: лучше собрать группу. Он охраняет свою филактерию в центре Андорала.",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: сохраните задание для зоны {zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: сохраните задание для Кратера Ун'Горо",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924} – в доме",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} ({zone:1450}): сохраните задание",
}
