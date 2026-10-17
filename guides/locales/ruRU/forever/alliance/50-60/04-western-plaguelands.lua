-- Russian (ruRU): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Light's Hope Chapel
	-- {npc:16256} Jessica Chambers
	["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",

	-- Step 2: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: термиты будут позже, здесь: {area:2627}",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "Дом {npc:10927} стоит на холме к востоку от лагеря; памятник ({npc:10936}) – чуть севернее.",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894} – у памятника",

	-- Step 4: The fields
	["The fields"] = "Поля",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Скелеты-живодеры и слюнявые вурдалаки бродят по полям к северу от лагеря; со всей Плети здесь падают камни Плети.",

	-- Step 5: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} стоит у фермы к северо-востоку от полей: {area:202}.",

	-- Step 6: Diseased Wolves
	["Diseased Wolves"] = "Больные волки",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "Болезненные гризли",

	-- Step 9: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Для друидов ({zone:1457}): сохраните задание",

	-- Step 10: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Езжайте на северо-запад к ферме Далсона. Дневник лежит в амбаре; ключ от нужника носит бродячий скелет, а {npc:10836} ждет в нужнике с ключом от шкафчика.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "{object:175924} – в доме",

	-- Step 11: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от места {area:200}; ее посылка лежит внутри.",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Для города {zone:1453}: сохраните задание",

	-- Step 12: Chillwind Camp
	["Ride back south to the camp."] = "Езжайте назад на юг к лагерю.",

	-- Step 13: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Сторожевые башни Андорала",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Используйте {item:12815} у подножия каждой из четырех сторожевых башен по краям Андорала, к северу от лагеря.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",

	-- Step 14: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Котел: {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} охраняет котел ({area:199}) к западу от Андорала.",

	-- Step 15: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Купите {item:13320} (1 шт.) для котла Фелстоуна прямо перед выходом; продает {npc:11056}. Ускорители исчезают через 30 минут.",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{item:13320}: продает {npc:11056}",

	-- Step 16: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Теперь котел предлагает свое задание; с окрестных скелетов падают костяные катализаторы.",

	-- Step 17: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Котел: {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "Котел стоит к северо-востоку от поля Фелстоуна ({area:200}); рядом – его повелитель котла.",

	-- Step 19: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Котел: {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Котел стоит у фермы {npc:10739}: {area:202}.",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "убивайте мобов ({npc:1796}): {area:202}, {zone:1422}",

	-- Step 20: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Купите еще два чародейских ускорителя для котлов ({area:202} и Далсона) и сразу езжайте туда: они исчезают через 30 минут.",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} – элитный противник 61-го уровня",

	-- Step 21: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Назад на север: {area:202} – теперь котел предлагает свое задание. С ближайших вурдалаков падают соматические усилители.",

	-- Step 23: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала.",

	-- Step 24: Andorhal
	["Andorhal"] = "Андорал",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Используйте {item:12627} у зернохранилищ, чтобы выманить временных паразитов. {quest:5154} – один из пыльных томов в ратуше. С каждого скелета в городе падает {quest:5537}.",

	-- Step 25: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} – элитный противник: лучше собрать группу. Он охраняет свою филактерию в центре Андорала.",

	-- Step 26: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210} ({area:2268}): сохраните задание",

	-- Step 27: Andorhal Watches
	["Andorhal Watches"] = "Часы из Андорала",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Маленькие сундучки лежат в развалинах по всему Андоралу; в каждом – часы.",

	-- Step 29: More watches
	["More watches"] = "Еще часы",

	-- Step 31: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Езжайте по дороге на север к Лесопилке Северного Кряжа; {npc:11610} прячется на краю лагеря.",

	-- Step 32: The Scarlet Crusade
	["The Scarlet Crusade"] = "Алый орден",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Медики, охотники, рыцари и маги из Алого ордена патрулируют лесопилку и дорогу к месту {area:190}.",

	-- Step 34: Radley and Durgen
	["Radley and Durgen"] = "Рэдли и Дурген",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} ходит по лагерю Северного Кряжа к востоку от {npc:11610}; {npc:11611} охраняет башню на южных подступах (ориентир: {area:190}).",

	-- Step 36: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Обзорная точка: {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "Поднимитесь на холм к западу (ориентир: {area:190}), чтобы осмотреть город сверху.",

	-- Step 38: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Езжайте на восток к пограничной реке: {npc:1855} живет в маленькой хижине на берегу.",

	-- Step 39: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Котел: {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Езжайте на юг: {area:201}; там котел охраняет {npc:11078}.",

	-- Step 40: Chillwind Camp
	["Ride south-west to the camp."] = "Езжайте на юго-запад к лагерю.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} ({area:976}): сохраните задание",

	-- Step 41: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038} – у могил к югу от часовни",

	-- Step 42: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Череп Хоргуса лежит здесь: {area:2624}, а меч Мардука – здесь: {area:2623}; оба там, где сражаются призраки. На равнинах между ними охотятся взрослые чумные псы.",

	-- Step 44: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Езжайте на северо-запад: {area:2276}, на краю зоны {area:2277}.",

	-- Step 45: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Езжайте на запад: {area:2627}. По лесам бродят карликовые чумные псы, чумные нетопыри и личинки-падальщики; наполните предмет {item:15042} у больших термитников и убейте бесноватых чумных псов дальше к северу.",

	-- Step 46: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} стоит у хижины Августа ({area:2627}).",

	-- Step 47: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Перейдите реку на запад к хижине {npc:1855}.",
	["Listen to his story"] = "Выслушайте его историю",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} – элитный противник: лучше собрать группу",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} лежит в ратуше ({area:190}) к западу от {npc:1855}: стражи Алого ордена стоят плотно.",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} лежит к востоку от амбара ({area:201}).",

	-- Step 50: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Перейдите реку на восток к {area:2261} – склепу на юго-западе зоны. {object:177667} лежит внутри: ключ от него у персонажа {npc:12248} на дальнем северо-востоке, это будет в следующем гайде.",

	-- Step 51: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Езжайте назад: {area:3197}, летите сюда: {area:150}, плывите на корабле сюда: {area:442} и летите сюда: {area:702}; портал ведет наверх ({zone:1457}).",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047} – здесь: {area:1658}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Десять шт. {item:11040} из предмета {item:11020}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, где следующий гайд посещает учителей, не имеет учителя друидов",

	-- Step 52: Temple of the Moon
	["Temple of the Moon"] = "Храм Луны",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} и {npc:7740} стоят у Храма Луны; наполните {item:11682} у лунного колодца внутри.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: сохраните задание для места {area:976}",

	-- Step 53: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} ({zone:1450}): сохраните задание",

	-- Step 54: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} ({zone:1452}): сохраните задание",

	-- Step 55: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Летите: {area:702} → {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: сохраните задание для зоны {zone:1446}",

	-- Step 56: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Плывите на корабле на материк и езжайте на северо-восток к лагерю {npc:14637} (ориентир: {area:1119}).",

	-- Step 57: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "Уменьшенные великаны и морские элементали",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Уменьшенные великаны бродят здесь: {area:1119}; морские элементали – вдоль побережья к западу.",

	-- Step 59: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "Лагерь {npc:7775} – к северу (ориентир: {area:1119}). Он продает {item:11243}, когда получит свою наживку.",

	-- Step 60: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "Летите сюда: {area:392}.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: сохраните задание для Кратера Ун'Горо",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901} – на побережье к северу от города",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Для зоны {zone:1448}: сохраните задание",

	-- Step 61: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Летите: {area:392} → {area:2255}, затем езжайте на юг: {area:2250}.",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: ее сопровождение будет позже по маршруту",

	-- Step 62: Donova Snowden
	["Ride west along the road to the hot springs."] = "Езжайте по дороге на запад к горячим источникам.",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "Гаэриан ({area:976}): сохраните задание",

	-- Step 63: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Войдите сюда: {area:1769} – и идите по ответвлению туннеля в зону {zone:1450}, до места {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Для зоны {zone:1451}: сохраните задание",

	-- Step 64: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "Следующий гайд начинается здесь ({area:392}) и продолжается полетом сюда: {area:976}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Перейдите реку на восток: {area:2261} – склеп на юго-западе зоны. {object:177667} лежит внутри: ключ от него у персонажа {npc:12248} на дальнем северо-востоке, это будет в следующем гайде.",
}
