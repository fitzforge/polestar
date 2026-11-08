-- Russian (ruRU): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Chillwind Camp
	["Chillwind Camp"] = "",

	-- Step 2: Sorrow Hill: kill these as you meet them
	["Sorrow Hill: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "Дом {npc:10927} стоит на холме к востоку от лагеря; памятник ({npc:10936}) – чуть севернее.",
	["Upstairs"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894} – у памятника",

	-- Step 4: Dalson's Tears
	["Dalson's Tears"] = "",
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Езжайте на северо-запад к ферме Далсона. Дневник лежит в амбаре; ключ от нужника носит бродячий скелет, а {npc:10836} ждет в нужнике с ключом от шкафчика.",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",
	["Inside"] = "Внутри",

	-- Step 5: The Writhing Haunt: kill these as you meet them
	["The Writhing Haunt: kill these as you meet them"] = "",

	-- Step 6: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "",

	-- Step 7: Chillwind Camp
	["Ride back south to the camp."] = "Езжайте назад на юг к лагерю.",

	-- Step 8: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Сторожевые башни Андорала",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Используйте {item:12815} у подножия каждой из четырех сторожевых башен по краям Андорала, к северу от лагеря.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",

	-- Step 9: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала.",

	-- Step 10: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",

	-- Step 11: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} – элитный противник 61-го уровня",

	-- Step 12: Dalson's Tears cauldron
	["Dalson's Tears cauldron"] = "",
	["The cauldron sits at Dalson's Tears, north-east of Felstone; its Cauldron Lord stands beside it."] = "",

	-- Step 13: Andorhal
	["Andorhal"] = "Андорал",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Используйте {item:12627} у зернохранилищ, чтобы выманить временных паразитов. {quest:5154} – один из пыльных томов в ратуше. С каждого скелета в городе падает {quest:5537}.",

	-- Step 15: Writhing Haunt cauldron
	["Writhing Haunt cauldron"] = "",
	-- {npc:10739} Mulgris Deepriver
	["The cauldron sits at the Writhing Haunt, by {npc:10739}' farm."] = "",

	-- Step 17: Diseased Grizzlies
	["Diseased Grizzlies"] = "Болезненные гризли",

	-- Step 18: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Для друидов ({zone:1457}): сохраните задание",

	-- Step 20: Chromie
	-- {quest:5210} Brother Carlin
	["{quest:5210}, at Light's Hope Chapel: keep it"] = "",

	-- Step 21: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 23: More watches
	["More watches"] = "Еще часы",

	-- Step 25: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Езжайте по дороге на север к Лесопилке Северного Кряжа; {npc:11610} прячется на краю лагеря.",

	-- Step 26: The Scarlet Crusade
	["The Scarlet Crusade"] = "Алый орден",
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward Hearthglen."] = "",

	-- Step 28: Radley and Durgen
	["Radley and Durgen"] = "Рэдли и Дурген",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at Hearthglen's southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 30: Hearthglen overlook
	["Hearthglen overlook"] = "",
	["Climb the hill west of Hearthglen to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 32: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Езжайте на восток к пограничной реке: {npc:1855} живет в маленькой хижине на берегу.",

	-- Step 33: Gahrron's Withering cauldron
	["Gahrron's Withering cauldron"] = "",
	-- {npc:11078} Cauldron Lord Soulwrath
	["Ride south to Gahrron's Withering, where {npc:11078} guards the cauldron."] = "",

	-- Step 34: Chillwind Camp
	["Ride south-west to the camp."] = "Езжайте на юго-запад к лагерю.",
	-- {npc:5411} Krinkle Goodsteel
	["{npc:5411} in Gadgetzan: keep it"] = "",

	-- Step 35: Fly to Light's Hope Chapel
	["Fly to Light's Hope Chapel"] = "",
	["Chillwind Camp flight master"] = "",

	-- Step 36: Light's Hope Chapel
	["Light's Hope Chapel"] = "",

	-- Step 37: Aurora Skycaller
	["Ride north-west to Quel'Lithien Lodge, at the edge of the Plaguewood."] = "",

	-- Step 38: Villains of Darrowshire
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at Blackwood Lake and Marduk's sword in the Infectis Scar, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 39: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to Terrordale. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "",

	-- Step 40: Augustus the Touched
	-- {npc:12384} Augustus the Touched
	["Ride north to Terrordale. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "",

	-- Step 41: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "{npc:8598} – 170 ярдов к северо-востоку",

	-- Step 42: Plaguewood: kill these as you meet them
	["Plaguewood: kill these as you meet them"] = "",

	-- Step 43: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Перейдите реку на запад к хижине {npc:1855}.",

	-- Step 45: Tirion Fordring
	["Listen to his story"] = "Выслушайте его историю",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} – элитный противник: лучше собрать группу",

	-- Step 46: Davil's Libram
	-- {item:12954} Davil's Libram · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of Hearthglen, west of {npc:1855}: the Scarlet guards stand close together."] = "",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 47: Redpath's Shield
	-- {item:12955} Redpath's Shield
	["{item:12955} lies east of the barn at Gahrron's Withering."] = "",

	-- Step 49: The Undercroft
	["The Undercroft"] = "",
	-- {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the Undercroft, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "",

	-- Step 51: Fly to Southshore
	["Fly to Southshore"] = "",
	["Aerie Peak flight master"] = "",

	-- Step 53: Fly to Rut'theran Village
	["Fly to Rut'theran Village"] = "",
	["Auberdine flight master"] = "",

	-- Step 55: The Temple Gardens
	["The Temple Gardens"] = "",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} и {npc:7740} стоят у Храма Луны; наполните {item:11682} у лунного колодца внутри.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}: keep it for Gadgetzan"] = "",

	-- Step 56: Darnassus
	-- {zone:1457} Darnassus
	["The portal in Rut'theran Village leads up to {zone:1457}."] = "",
	-- {npc:9047} Jenal
	["{npc:9047}, in the Cenarion Enclave"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, где следующий гайд посещает учителей, не имеет учителя друидов",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Десять шт. {item:11040} из предмета {item:11020}",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} ({zone:1450}): сохраните задание",

	-- Step 57: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 58: Rut'theran Village
	["Rut'theran Village"] = "",
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "",

	-- Step 59: Feathermoon Stronghold
	-- {object:152576} Feathermoon Stronghold (no name in this language: may be words)
	["From Rut'theran Village, fly to {object:152576}."] = "",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: сохраните задание для зоны {zone:1446}",

	-- Step 61: Boat to The Forgotten Coast
	["Boat to The Forgotten Coast"] = "",

	-- Step 62: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {object:152574} Twin Colossals (no name in this language: may be words)
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {object:152574}."] = "",

	-- Step 63: The Forgotten Coast: kill these as you meet them
	["The Forgotten Coast: kill these as you meet them"] = "",
	-- {object:152574} Twin Colossals (no name in this language: may be words)
	["The shrunken giants roam the {object:152574}; the sea elementals wade along the coast to the west."] = "",

	-- Step 65: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {object:152574} Twin Colossals (no name in this language: may be words) · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {object:152574}. He sells the {item:11243} once he has his bait."] = "",

	-- Step 67: Fly to Theramore
	["Fly to Theramore"] = "Лететь на остров Терамор",
	["Thalanaar flight master"] = "",

	-- Step 69: Ratchet
	["Ratchet"] = "",
	-- {zone:1413} The Barrens
	["From Theramore, ride west into the {zone:1413} and north up the coast to Ratchet."] = "",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901} – на побережье к северу от города",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Для зоны {zone:1448}: сохраните задание",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "",

	-- Step 70: Fly to Everlook
	["Fly to Everlook"] = "",
	["Ratchet flight master"] = "",

	-- Step 72: Donova Snowden
	["Ride west along the road to the hot springs."] = "Езжайте по дороге на запад к горячим источникам.",
	-- {npc:9299} Gaeriyan
	["{npc:9299} in Gadgetzan: keep it"] = "",

	-- Step 74: Rabine Saturna
	-- {zone:1450} Moonglade
	["Walk into Timbermaw Hold and take the {zone:1450} branch of the tunnel to Nighthaven."] = "",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Для зоны {zone:1451}: сохраните задание",

	-- Step 75: Fly to Gadgetzan
	["Fly to Gadgetzan"] = "",

	-- Step 76: Gadgetzan
	["Gadgetzan"] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "У персонажа {npc:7583}",
	["For Chillwind Camp: keep it"] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "",

	-- Step 77: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} ждет на кладбище чуть восточнее города; надгробие стоит рядом.",

	-- Step 78: Broken Pillar
	["Broken Pillar"] = "",
	-- {npc:7771} Marvon Rivetseeker
	["Ride south-west to {npc:7771}'s camp at the Broken Pillar."] = "",
	-- {quest:3444} The Stone Circle
	["{quest:3444} is in Ratchet"] = "",

	-- Step 80: Fly to Marshal's Refuge
	["Fly to Marshal's Refuge"] = "",
	["Gadgetzan flight master"] = "",

	-- Step 81: Linken
	-- {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from Gadgetzan to Marshal's Refuge. {npc:8737}'s hut stands at the Lakkari Tar Pits, west of the refuge; {npc:9117} is up the hill behind it.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с NPC {npc:9997}",

	-- Step 83: Cenarion Hold
	["Cenarion Hold"] = "",
	-- {zone:1451} Silithus · {npc:15189} Beetix Ficklespragg
	["Ride out of the crater's north-western pass into {zone:1451} and on to Cenarion Hold. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 84: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Землечерпы роются в дюнах к северо-западу от крепости; повсюду бродят камнехвостые скорпиды и песчаные пауки-быстроноги.",

	-- Step 85: Level 56.89
	["Level 56.89"] = "",
	-- {item:9328} Super Snapper FX
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan. Or, with a group, run the Blackrock Depths dungeon or the Blackrock Spire dungeon (Lower) instead."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 86: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Follow the road south-west out of the pass to Cenarion Hold. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082} – у палаток Альянса",

	-- Step 87: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Дальше на западе роются земляные сокрушители; в тех же песках охотятся камнехвостые клешневики, камнехвостые живодеры и скальные пауки-скакуны.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 88: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "Езжайте на восток: {npc:13220}.",

	-- Step 89: Southwind Village
	["Southwind Village"] = "",
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Истерзанные друиды и часовые бродят по разрушенной деревне к юго-западу от {npc:13220}.",

	-- Step 91: The Hive'Ashi tower
	["The Hive'Ashi tower"] = "",
	["Ride east to the Hive'Ashi tower in Southwind Village; climb it and kill the ambushers that rise for the encrusted object."] = "",

	-- Step 92: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Умбер ({zone:1450}): сохраните задание",

	-- Step 94: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",

	-- Step 95: Krakle
	-- {npc:10302} Krakle
	["Ride west past Marshal's Refuge and south down the western side to Golakka Hot Springs: {npc:10302} the goblin sits by the water."] = "",

	-- Step 96: Krakle's Thermometer
	-- {npc:10541} Krakle's Thermometer
	["Ride east to Fire Plume Ridge, climb it and use {npc:10541} at the lava vents near the top."] = "",

	-- Step 97: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Завершается у NPC {npc:9298} (зона {zone:1452}): сохраните",

	-- Step 98: Northern Pylon
	["Northern Pylon"] = "Северный пилон",

	-- Step 99: Marshal's Refuge
	["Marshal's Refuge"] = "",

	-- Step 100: The crater
	["The crater"] = "Кратер",
	-- {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the Lakkari Tar Pits; the fire elementals of Fire Plume Ridge in the middle carry the ash; the Gorishi wasps of the Slithering Scar in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",

	-- Step 102: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Езжайте по спуску вниз в кратер: {npc:9619} стоит лагерем у его подножия.",
	["The pelts come after loop 2, on the gorilla plateau"] = "Шкуры – после 2-го круга, на плато горилл",

	-- Step 103: Lakkari Tar Pits: kill these as you meet them
	["Lakkari Tar Pits: kill these as you meet them"] = "",
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on Ironstone Plateau, east of Marshal's Refuge. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "",

	-- Step 105: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Езжайте на север по восточной стороне к плато горилл. {npc:9622}, горилла 55-го уровня, сидит в самой глубокой пещере: сначала перебейте горилл у входа.",
	["Below ground"] = "",

	-- Step 106: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Логово зверя {npc:9684} – в джунглях к северу от {npc:9619}, под восточными утесами: используйте там {item:11568}. {npc:9684} – 56-го уровня: начинайте бой с полным здоровьем.",

	-- Step 107: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Пересеките юг кратера и вернитесь к {npc:9619} у спуска.",

	-- Step 108: The Marshlands: kill these as you meet them
	["The Marshlands: kill these as you meet them"] = "",

	-- Step 109: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the south-east slope of Fire Plume Ridge, in the middle of the crater."] = "",

	-- Step 110: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Сопроводите NPC {npc:9999}",
	-- {npc:9999} Ringo · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to Marshal's Refuge. When he faints, use {item:11804} on him to wake him."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "Часы из Андорала",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Назад на север: {area:202} – теперь котел предлагает свое задание. С ближайших вурдалаков падают соматические усилители.",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Купите {item:13320} (1 шт.) для котла Фелстоуна прямо перед выходом; продает {npc:11056}. Ускорители исчезают через 30 минут.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Купите еще два чародейских ускорителя для котлов ({area:202} и Далсона) и сразу езжайте туда: они исчезают через 30 минут.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Поднимитесь на холм к западу (ориентир: {area:190}), чтобы осмотреть город сверху.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Перейдите реку на восток к {area:2261} – склепу на юго-западе зоны. {object:177667} лежит внутри: ключ от него у персонажа {npc:12248} на дальнем северо-востоке, это будет в следующем гайде.",
	-- ["Diseased Wolves"] = "Больные волки",
	-- ["Fly to {area:392}."] = "Летите сюда: {area:392}.",
	-- ["Follow the road south-west out of the pass to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Следуйте по дороге на юго-запад из прохода сюда: {area:3425}. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- ["For {zone:1451}: keep it"] = "Для зоны {zone:1451}: сохраните задание",
	-- ["For {zone:1453}: keep it"] = "Для города {zone:1453}: сохраните задание",
	-- ["From Theramore, ride west into the {area:17} and north up the coast to {area:392}."] = "Из Терамора езжайте на запад ({area:17}) и на север вдоль побережья сюда: {area:392}.",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Летите: {area:392} → {area:2255}, затем езжайте на юг: {area:2250}.",
	-- ["From {area:702}, fly to {area:1116}."] = "Летите: {area:702} → {area:1116}.",
	-- ["Gaeriyan in {area:976}: keep it"] = "Гаэриан ({area:976}): сохраните задание",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Череп Хоргуса лежит здесь: {area:2624}, а меч Мардука – здесь: {area:2623}; оба там, где сражаются призраки. На равнинах между ними охотятся взрослые чумные псы.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Езжайте назад: {area:3197}, летите сюда: {area:150}, плывите на корабле сюда: {area:442} и летите сюда: {area:702}; портал ведет наверх ({zone:1457}).",
	-- ["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Езжайте на северо-запад: {area:2276}, на краю зоны {area:2277}.",
	-- ["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Выезжайте из кратера через северо-западный проход ({area:1377}) и дальше сюда: {area:3425}. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Езжайте на юг: {area:201}; там котел охраняет {npc:11078}.",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Езжайте на запад: {area:2627}. По лесам бродят карликовые чумные псы, чумные нетопыри и личинки-падальщики; наполните предмет {item:15042} у больших термитников и убейте бесноватых чумных псов дальше к северу.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Скелеты-живодеры и слюнявые вурдалаки бродят по полям к северу от лагеря; со всей Плети здесь падают камни Плети.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Маленькие сундучки лежат в развалинах по всему Андоралу; в каждом – часы.",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Плывите на корабле на материк и езжайте на северо-восток к лагерю {npc:14637} (ориентир: {area:1119}).",
	-- ["Temple of the Moon"] = "Храм Луны",
	-- ["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Медики, охотники, рыцари и маги из Алого ордена патрулируют лесопилку и дорогу к месту {area:190}.",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Теперь котел предлагает свое задание; с окрестных скелетов падают костяные катализаторы.",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Котел стоит у фермы {npc:10739}: {area:202}.",
	-- ["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "Котел стоит к северо-востоку от поля Фелстоуна ({area:200}); рядом – его повелитель котла.",
	-- ["The fields"] = "Поля",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Следующий гайд начинается здесь ({area:392}) и продолжается полетом сюда: {area:976}.",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Уменьшенные великаны бродят здесь: {area:1119}; морские элементали – вдоль побережья к западу.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Войдите сюда: {area:1769} – и идите по ответвлению туннеля в зону {zone:1450}, до места {area:2361}.",
	-- ["Zapped giants and sea elementals"] = "Уменьшенные великаны и морские элементали",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "убивайте мобов ({npc:1796}): {area:202}, {zone:1422}",
	-- ["{area:190} overlook"] = "Обзорная точка: {area:190}",
	-- ["{area:199} cauldron"] = "Котел: {area:199}",
	-- ["{area:200} cauldron"] = "Котел: {area:200}",
	-- ["{area:201} cauldron"] = "Котел: {area:201}",
	-- ["{area:202} cauldron"] = "Котел: {area:202}",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} лежит в ратуше ({area:190}) к западу от {npc:1855}: стражи Алого ордена стоят плотно.",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} лежит к востоку от амбара ({area:201}).",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}: продает {npc:11056}",
	-- ["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} ({zone:1452}): сохраните задание",
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
	-- ["{npc:5411} in {area:976}: keep it"] = "{npc:5411} ({area:976}): сохраните задание",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: сохраните задание для места {area:976}",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "Лагерь {npc:7775} – к северу (ориентир: {area:1119}). Он продает {item:11243}, когда получит свою наживку.",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: сохраните задание для зоны {zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: сохраните задание для Кратера Ун'Горо",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047} – здесь: {area:1658}",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924} – в доме",
	-- ["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210} ({area:2268}): сохраните задание",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} ({zone:1450}): сохраните задание",
}
