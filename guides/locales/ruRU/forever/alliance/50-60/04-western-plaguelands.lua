-- Russian (ruRU): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission · {spell:437801} Light's Hope · {zone:1452} Winterspring
	["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 4: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 5: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "Дом {npc:10927} стоит на холме к востоку от лагеря; памятник ({npc:10936}) – чуть севернее.",
	["Upstairs"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894} – у памятника",

	-- Step 6: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Езжайте на северо-запад к ферме Далсона. Дневник лежит в амбаре; ключ от нужника носит бродячий скелет, а {npc:10836} ждет в нужнике с ключом от шкафчика.",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",
	["Inside"] = "Внутри",

	-- Step 7: The Writhing Haunt: kill these as you meet them
	-- {area:202} The Writhing Haunt
	["{area:202}: kill these as you meet them"] = "",

	-- Step 8: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "",

	-- Step 9: Chillwind Camp
	["Ride back south to the camp."] = "Езжайте назад на юг к лагерю.",

	-- Step 10: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Сторожевые башни Андорала",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Используйте {item:12815} у подножия каждой из четырех сторожевых башен по краям Андорала, к северу от лагеря.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",

	-- Step 11: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала.",

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

	-- Step 15: Andorhal
	["Andorhal"] = "Андорал",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Используйте {item:12627} у зернохранилищ, чтобы выманить временных паразитов. {quest:5154} – один из пыльных томов в ратуше. С каждого скелета в городе падает {quest:5537}.",

	-- Step 17: The Writhing Haunt cauldron
	-- {area:202} The Writhing Haunt
	["{area:202} cauldron"] = "Котел: {area:202}",
	-- {area:202} The Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Котел стоит у фермы {npc:10739}: {area:202}.",

	-- Step 19: Diseased Grizzlies
	["Diseased Grizzlies"] = "Болезненные гризли",

	-- Step 20: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Для друидов ({zone:1457}): сохраните задание",

	-- Step 22: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210} ({area:2268}): сохраните задание",

	-- Step 23: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 25: More watches
	["More watches"] = "Еще часы",

	-- Step 27: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Езжайте по дороге на север к Лесопилке Северного Кряжа; {npc:11610} прячется на краю лагеря.",

	-- Step 28: The Scarlet Crusade
	["The Scarlet Crusade"] = "Алый орден",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Медики, охотники, рыцари и маги из Алого ордена патрулируют лесопилку и дорогу к месту {area:190}.",

	-- Step 30: Radley and Durgen
	["Radley and Durgen"] = "Рэдли и Дурген",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 32: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Обзорная точка: {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 34: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Езжайте на восток к пограничной реке: {npc:1855} живет в маленькой хижине на берегу.",

	-- Step 35: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Котел: {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Езжайте на юг: {area:201}; там котел охраняет {npc:11078}.",

	-- Step 36: Chillwind Camp
	["Ride south-west to the camp."] = "Езжайте на юго-запад к лагерю.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} ({area:976}): сохраните задание",

	-- Step 37: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Летите сюда: {area:2268}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 39: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Езжайте на северо-запад: {area:2276}, на краю зоны {area:2277}.",

	-- Step 40: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Череп Хоргуса лежит здесь: {area:2624}, а меч Мардука – здесь: {area:2623}; оба там, где сражаются призраки. На равнинах между ними охотятся взрослые чумные псы.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 41: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Езжайте на запад: {area:2627}. По лесам бродят карликовые чумные псы, чумные нетопыри и личинки-падальщики; наполните предмет {item:15042} у больших термитников и убейте бесноватых чумных псов дальше к северу.",

	-- Step 42: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Скачите на север сюда: {area:2627}. {npc:12384} живет в разрушенной хижине, а его книга расписок лежит в разрушенной таверне поблизости.",

	-- Step 43: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "{npc:8598} – 170 ярдов к северо-востоку",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",

	-- Step 45: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Перейдите реку на запад к хижине {npc:1855}.",

	-- Step 47: Tirion Fordring
	["Listen to his story"] = "Выслушайте его историю",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} – элитный противник: лучше собрать группу",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} лежит в ратуше ({area:190}) к западу от {npc:1855}: стражи Алого ордена стоят плотно.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} лежит к востоку от амбара ({area:201}).",

	-- Step 51: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Перейдите реку на восток к {area:2261} – склепу на юго-западе зоны. {object:177667} лежит внутри: ключ от него у персонажа {npc:12248} на дальнем северо-востоке, это будет в следующем гайде.",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "",

	-- Step 53: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Летите сюда: {area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 55: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 56: Rut'theran Village
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "Раншалла ({zone:1452}): сохраните задание",

	-- Step 58: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} и {npc:7740} стоят у Храма Луны; наполните {item:11682} у лунного колодца внутри.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: сохраните задание для места {area:976}",

	-- Step 59: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047} – здесь: {area:1658}",

	-- Step 63: Darnassus
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, где следующий гайд посещает учителей, не имеет учителя друидов",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Десять шт. {item:11040} из предмета {item:11020}",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} ({zone:1450}): сохраните задание",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 65: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Летите: {area:702} → {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: сохраните задание для зоны {zone:1446}",

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

	-- Step 73: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "",

	-- Step 74: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride north into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "",

	-- Step 75: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "",

	-- Step 77: Fly to Theramore
	["Fly to Theramore"] = "Лететь на остров Терамор",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 79: Ratchet
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Из Терамора езжайте на запад ({zone:1413}) и на север вдоль побережья сюда: {area:392}.",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901} – на побережье к северу от города",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Для зоны {zone:1448}: сохраните задание",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "",

	-- Step 80: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 82: Donova Snowden
	["Ride west along the road to the hot springs."] = "Езжайте по дороге на запад к горячим источникам.",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "{npc:9299} ({area:976}): сохраните задание",

	-- Step 84: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Войдите сюда: {area:1769} – и идите по ответвлению туннеля в зону {zone:1450}, до места {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Для зоны {zone:1451}: сохраните задание",

	-- Step 85: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",

	-- Step 86: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "У персонажа {npc:7583}",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "Для места {area:3197}: сохраните задание",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "",

	-- Step 87: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} ждет на кладбище чуть восточнее города; надгробие стоит рядом.",

	-- Step 88: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Езжайте на юго-запад к лагерю ({npc:7771}): {area:1938}.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444} – здесь: {area:392}",

	-- Step 90: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 91: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с NPC {npc:9997}",

	-- Step 92: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "В зону {zone:1451}",

	-- Step 93: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "",

	-- Step 95: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082} – у палаток Альянса",

	-- Step 96: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Землечерпы роются в дюнах к северо-западу от крепости; повсюду бродят камнехвостые скорпиды и песчаные пауки-быстроноги.",

	-- Step 97: Level 56.89
	["Level 56.89"] = "",
	-- {item:9328} Super Snapper FX · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 98: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 99: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Дальше на западе роются земляные сокрушители; в тех же песках охотятся камнехвостые клешневики, камнехвостые живодеры и скальные пауки-скакуны.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 100: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Истерзанные друиды и часовые бродят по разрушенной деревне к юго-западу от {npc:13220}.",

	-- Step 102: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "Башня: {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Езжайте на восток к башне ({area:2742}, {area:2738}); поднимитесь на нее и убейте засаду, которая появляется ради покрытого коркой предмета.",

	-- Step 103: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Умбер ({zone:1450}): сохраните задание",

	-- Step 105: Krakle
	-- {zone:1451} Silithus · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "",

	-- Step 106: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",

	-- Step 107: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Езжайте на восток к вулкану ({area:537}), поднимитесь на него и используйте {npc:10541} у лавовых отдушин у вершины.",

	-- Step 108: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Завершается у NPC {npc:9298} (зона {zone:1452}): сохраните",

	-- Step 109: Northern Pylon
	["Northern Pylon"] = "Северный пилон",

	-- Step 111: The crater
	["The crater"] = "Кратер",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",

	-- Step 112: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "",

	-- Step 113: Lakkari Tar Pits: kill these as you meet them
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

	-- Step 115: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Езжайте на север по восточной стороне к плато горилл. {npc:9622}, горилла 55-го уровня, сидит в самой глубокой пещере: сначала перебейте горилл у входа.",
	["Below ground"] = "",

	-- Step 116: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Логово зверя {npc:9684} – в джунглях к северу от {npc:9619}, под восточными утесами: используйте там {item:11568}. {npc:9684} – 56-го уровня: начинайте бой с полным здоровьем.",

	-- Step 117: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Пересеките юг кратера и вернитесь к {npc:9619} у спуска.",

	-- Step 118: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "",

	-- Step 119: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} сидит на юго-восточном склоне вулкана ({area:537}) в середине кратера.",

	-- Step 120: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Сопроводите NPC {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "Часы из Андорала",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Назад на север: {area:202} – теперь котел предлагает свое задание. С ближайших вурдалаков падают соматические усилители.",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Купите {item:13320} (1 шт.) для котла Фелстоуна прямо перед выходом; продает {npc:11056}. Ускорители исчезают через 30 минут.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Купите еще два чародейских ускорителя для котлов ({area:202} и Далсона) и сразу езжайте туда: они исчезают через 30 минут.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Поднимитесь на холм к западу (ориентир: {area:190}), чтобы осмотреть город сверху.",
	-- ["Diseased Wolves"] = "Больные волки",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Завершается у NPC {npc:9298} (зона {area:618}): сохраните",
	-- ["Fly to {area:392}."] = "Летите сюда: {area:392}.",
	-- ["Follow the road south-west out of the pass to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Следуйте по дороге на юго-запад из прохода сюда: {area:3425}. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- ["For {area:1377}: keep it"] = "Для зоны {area:1377}: сохраните задание",
	-- ["For {zone:1453}: keep it"] = "Для города {zone:1453}: сохраните задание",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Летите: {area:392} → {area:2255}, затем езжайте на юг: {area:2250}.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Езжайте назад: {area:3197}, летите сюда: {area:150}, плывите на корабле сюда: {area:442} и летите сюда: {area:702}; портал ведет наверх ({zone:1457}).",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Езжайте по спуску вниз в кратер: {npc:9619} стоит лагерем у его подножия.",
	-- ["Ride east to {npc:13220}."] = "Езжайте на восток: {npc:13220}.",
	-- ["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Выезжайте из кратера через северо-западный проход ({area:1377}) и дальше сюда: {area:3425}. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Езжайте на запад мимо места {area:541} и на юг по западной стороне: {area:543}. {npc:10302}, гоблин, сидит у воды.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Скелеты-живодеры и слюнявые вурдалаки бродят по полям к северу от лагеря; со всей Плети здесь падают камни Плети.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Маленькие сундучки лежат в развалинах по всему Андоралу; в каждом – часы.",
	-- ["Temple of the Moon"] = "Храм Луны",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Теперь котел предлагает свое задание; с окрестных скелетов падают костяные катализаторы.",
	-- ["The fields"] = "Поля",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Следующий гайд начинается здесь ({area:392}) и продолжается полетом сюда: {area:976}.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Шкуры – после 2-го круга, на плато горилл",
	-- ["Umber in {area:493}: keep it"] = "Умбер ({area:493}): сохраните задание",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Войдите сюда: {area:1769} – и идите по ответвлению туннеля в зону {area:493}, до места {area:2361}.",
	-- ["Zapped giants and sea elementals"] = "Уменьшенные великаны и морские элементали",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "убивайте мобов ({npc:1796}): {area:202}, {zone:1422}",
	-- ["{area:199} cauldron"] = "Котел: {area:199}",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}: продает {npc:11056}",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: ее сопровождение будет позже по маршруту",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} стоит у фермы к северо-востоку от полей: {area:202}.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от места {area:200}; ее посылка лежит внутри.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038} – у могил к югу от часовни",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} охраняет котел ({area:199}) к западу от Андорала.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} стоит у хижины Августа ({area:2627}).",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} ходит по лагерю Северного Кряжа к востоку от {npc:11610}; {npc:11611} охраняет башню на южных подступах (ориентир: {area:190}).",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: термиты будут позже, здесь: {area:2627}",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} – элитный противник: лучше собрать группу. Он охраняет свою филактерию в центре Андорала.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: сохраните задание для зоны {area:440}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: сохраните задание для Кратера Ун'Горо",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924} – в доме",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} ({area:493}): сохраните задание",
}
