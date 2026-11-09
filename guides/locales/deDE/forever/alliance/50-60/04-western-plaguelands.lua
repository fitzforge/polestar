-- German (deDE): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
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
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}s Bauernhaus steht auf dem Hügel östlich des Lagers; das Denkmal von {npc:10936} liegt gleich nördlich davon.",
	["Upstairs"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, am Denkmal",

	-- Step 6: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Reite nach Nordwesten zu Dalsons Hof. Das Tagebuch liegt in der Scheune; ein umherwanderndes Skelett trägt den Schlüssel für das Nebengebäude, und {npc:10836} wartet im Nebengebäude mit dem Schrankschlüssel.",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",
	["Inside"] = "",

	-- Step 7: The Writhing Haunt: kill these as you meet them
	-- {area:202} The Writhing Haunt
	["{area:202}: kill these as you meet them"] = "",

	-- Step 8: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "",

	-- Step 9: Chillwind Camp
	["Ride back south to the camp."] = "Reite zurück nach Süden zum Lager.",

	-- Step 10: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Die Wachtürme von Andorhal",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Benutze die {item:12815} am Fuß jedes der vier Wachtürme rund um den Rand von Andorhal, nördlich des Lagers.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Markiere {npc:10902} mit der {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Markiere {npc:10903} mit der {item:12815}",

	-- Step 11: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} wartet im zerstörten Gasthaus auf der Westseite von Andorhal.",

	-- Step 12: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Markiere {npc:10904} mit der {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Markiere {npc:10905} mit der {item:12815}",

	-- Step 13: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} ist ein Elite der Stufe 61",

	-- Step 14: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Kessel bei {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "Der Kessel steht bei {area:200}, nordöstlich vom Teufelssteinfeld; sein Kessellord steht daneben.",

	-- Step 15: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Benutze den {item:12627} bei den Getreidesilos, um Temporale Parasiten hervorzulocken. {quest:5154} ist einer der muffigen Folianten im Rathaus. Jedes Skelett in der Stadt droppt {quest:5537}.",

	-- Step 17: The Writhing Haunt cauldron
	-- {area:202} The Writhing Haunt
	["{area:202} cauldron"] = "Kessel: {area:202}",
	-- {area:202} The Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Der Kessel steht am Ort {area:202}, bei {npc:10739}' Hof.",

	-- Step 19: Diseased Grizzlies
	["Diseased Grizzlies"] = "Kranke Grizzlys",

	-- Step 20: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Für die Druiden von {zone:1457}: Behalte es",

	-- Step 22: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, bei der {area:2268}: Behalte es",

	-- Step 23: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 25: More watches
	["More watches"] = "Mehr Uhren",

	-- Step 27: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Reite auf der Straße nach Norden zum Holzlager Northridge; {npc:11610} versteckt sich am Rand des Lagers.",

	-- Step 28: The Scarlet Crusade
	["The Scarlet Crusade"] = "Der Scharlachrote Kreuzzug",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Scharlachrote Sanitäter, Jäger, Ritter und Magier patrouillieren durch das Holzlager und auf der Straße Richtung {area:190}.",

	-- Step 30: Radley and Durgen
	["Radley and Durgen"] = "Radley und Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 32: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Aussichtspunkt über {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 34: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Reite nach Osten zum Grenzfluss: {npc:1855} lebt in einer kleinen Hütte am Ufer.",

	-- Step 35: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Kessel bei {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Reite nach Süden nach {area:201}, wo {npc:11078} den Kessel bewacht.",

	-- Step 36: Chillwind Camp
	["Ride south-west to the camp."] = "Reite nach Südwesten zum Lager.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} in {area:976}: Behalte es",

	-- Step 37: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Flieg zur {area:2268}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 39: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Reite nach Nordwesten zur {area:2276}, am Rand des Gebiets {area:2277}.",

	-- Step 40: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Horgus' Schädel liegt am {area:2624} und Marduks Schwert im Gebiet {area:2623}, jeweils dort, wo Geister kämpfen; ausgewachsene Seuchenhunde jagen auf den Ebenen dazwischen.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 41: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Reite nach Westen ins {area:2627}. Kleine Seuchenhunde, Seuchenfledermäuse und Aaslarven streifen durch seine Wälder; füll {item:15042} an den großen Termitenhügeln und töte weiter nördlich die Rasenden Seuchenhunde.",

	-- Step 42: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Reite nach Norden nach {area:2627}. {npc:12384} lebt in der zerstörten Hütte, sein Quittungsbuch liegt im zerstörten Gasthaus in der Nähe.",

	-- Step 43: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",

	-- Step 45: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Überquere den Fluss nach Westen zu {npc:1855}s Hütte.",

	-- Step 47: Tirion Fordring
	["Listen to his story"] = "Hör dir seine Geschichte an",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} ist Elite: Eine Gruppe wird empfohlen",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} liegt im Rathaus von {area:190}, westlich von {npc:1855}: Die scharlachroten Wachen stehen dicht beieinander.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} liegt östlich der Scheune bei {area:201}.",

	-- Step 51: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Überquere den Fluss nach Osten zum {area:2261}, der Gruft im Südwesten des Gebiets. {object:177667} liegt drinnen: Ihr Schlüssel ist bei {npc:12248} ganz im Nordosten, was im nächsten Guide erledigt wird.",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "",

	-- Step 53: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Flieg nach {area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 55: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 56: Rut'theran Village
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "Ranshalla in {zone:1452}: Behalte es",

	-- Step 58: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} und {npc:7740} stehen beim Tempel des Mondes; fülle {item:11682} am Mondbrunnen darin.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: Behalte es für {area:976}",

	-- Step 59: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, im Gebiet {area:1658}",

	-- Step 63: Darnassus
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, wo im nächsten Guide trainiert wird, hat keinen Druidenlehrer",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Zehn {item:11040} aus dem {item:11020}",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} in {zone:1450}: Behalte es",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 65: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Flieg von {area:702} zur {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: Behalte es für {zone:1446}",

	-- Step 68: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "",

	-- Step 69: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Nimm das Boot zum Festland und reite nach Nordosten zu {npc:14637}s Lager beim Ort {area:1119}.",

	-- Step 70: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Die geschrumpften Riesen streifen durch das Gebiet {area:1119}; die Meereselementare waten westlich davon an der Küste entlang.",

	-- Step 72: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}s Lager liegt nördlich vom Ort {area:1119}. Er verkauft das {item:11243}, sobald er seinen Köder hat.",

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
	["Fly to Theramore"] = "Flieg nach Theramore",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 79: Ratchet
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}, an der Küste nördlich der Stadt",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Für {zone:1448}: Behalte es",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "",

	-- Step 80: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 82: Donova Snowden
	["Ride west along the road to the hot springs."] = "Reite auf der Straße nach Westen zu den heißen Quellen.",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "{npc:9299} in {area:976}: Behalte es",

	-- Step 84: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Geh in die {area:1769} und nimm den Tunnelzweig nach {zone:1450} bis nach {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Für {zone:1451}: Behalte es",

	-- Step 85: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",

	-- Step 86: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "Bei {npc:7583}",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "Für {area:3197}: Behalte es",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "",

	-- Step 87: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} wartet auf dem Friedhof gleich östlich des Orts; der Grabstein steht in der Nähe.",

	-- Step 88: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Reite nach Südwesten zum Lager von {npc:7771} bei {area:1938}.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444} ist in {area:392}",

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
	["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",

	-- Step 92: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "Nach {zone:1451}",

	-- Step 93: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "",

	-- Step 95: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}, bei den Zelten der Allianz",

	-- Step 96: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Baggerschläger graben in den Dünen nordwestlich der Burg; Steinpanzerskorpide und Sandhuscher streifen überall umher.",

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
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Baggerbrecher graben weiter westlich; Steinpanzerzangen, Steinpanzerschinder und Felspirscher jagen im selben Sand.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 100: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Die Gequälten Druiden und Schildwachen spuken im verfallenen Südwindposten südwestlich von {npc:13220}.",

	-- Step 102: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "Der Turm von {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Reite nach Osten zum Turm von {area:2742} in {area:2738}; klettere hinauf und töte die Angreifer, die beim Verkrusteten Silithidenobjekt auftauchen.",

	-- Step 103: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Umber in {zone:1450}: Behalte es",

	-- Step 105: Krakle
	-- {zone:1451} Silithus · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "",

	-- Step 106: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",

	-- Step 107: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Reite nach Osten zum {area:537}, klettere hinauf und benutze {npc:10541} an den Lavaschloten nahe dem Gipfel.",

	-- Step 108: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Endet bei {npc:9298} in {zone:1452}: Behalte es",

	-- Step 109: Northern Pylon
	["Northern Pylon"] = "Nördlicher Kristallpylon",

	-- Step 111: The crater
	["The crater"] = "Der Krater",
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
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Reite an der Ostseite nach Norden zum Gorillaplateau. {npc:9622}, ein Gorilla der Stufe 55, sitzt in dessen tiefster Höhle: Säubere zuerst die Gorillas am Höhleneingang.",
	["Below ground"] = "",

	-- Step 116: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Der Bau von {npc:9684} liegt im Dschungel nördlich von {npc:9619}, unterhalb der östlichen Klippen: Benutze dort {item:11568}. {npc:9684} ist Stufe 56: Fang mit voller Gesundheit an.",

	-- Step 117: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Durchquere den Süden des Kraters zu {npc:9619} an der Rampe.",

	-- Step 118: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "",

	-- Step 119: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} sitzt am Südosthang des {area:537}, in der Mitte des Kraters.",

	-- Step 120: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "Andorhal-Uhren",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Zurück nach Norden zum Ort {area:202}: Der Kessel bietet jetzt eine eigene Aufgabe an. Die Ghule in der Nähe droppen Somatische Verstärker.",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Kaufe für den Kessel im Teufelssteinfeld einen {item:13320} bei {npc:11056}, direkt bevor du losgehst: Die Beschleuniger verschwinden nach 30 Minuten.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Kaufe zwei weitere Arkanbeschleuniger für die Kessel am Ort {area:202} und bei Dalsons Tränenfeld und reite direkt dorthin: Sie verschwinden nach 30 Minuten.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Steig auf den Hügel westlich von {area:190} und blick auf die Stadt hinunter.",
	-- ["Diseased Wolves"] = "Kranke Wölfe",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Endet bei {npc:9298} in {area:618}: Behalte es",
	-- ["Fly to {area:392}."] = "Flieg nach {area:392}.",
	-- ["For {area:1377}: keep it"] = "Für {area:1377}: Behalte es",
	-- ["For {zone:1453}: keep it"] = "Für {zone:1453}: Behalte es",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Flieg von {area:392} nach {area:2255} und reite nach Süden zum {area:2250}.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Reite zurück zum {area:3197} und flieg zum Ort {area:150}, nimm das Boot nach {area:442} und flieg nach {area:702}; das Portal führt hinauf nach {zone:1457}.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Reite die Rampe hinab in den Krater: {npc:9619} lagert an ihrem Fuß.",
	-- ["Ride east to {npc:13220}."] = "Reite nach Osten zu {npc:13220}.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Reite nach Westen an {area:541} vorbei und an der Westseite nach Süden zu {area:543}: {npc:10302}, der Goblin, sitzt am Wasser.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Skelettschinder und Sabbernde Ghule streifen über die Felder nördlich des Lagers; die ganze Geißel hier droppt Geißelsteine.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Kleine Schließkassetten liegen überall in Andorhal im Schutt; in jeder steckt eine Uhr.",
	-- ["Temple of the Moon"] = "Der Tempel des Mondes",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Der Kessel bietet jetzt eine eigene Aufgabe an; die Skelette um ihn herum droppen Knöcherne Aufstachler.",
	-- ["The fields"] = "Die Felder",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Der nächste Guide beginnt hier in {area:392} und fliegt weiter nach {area:976}.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Die Felle kommen nach Runde 2, auf dem Gorillaplateau",
	-- ["Umber in {area:493}: keep it"] = "Umber in {area:493}: Behalte es",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Geh in die {area:1769} und nimm den Tunnelzweig nach {area:493} bis nach {area:2361}.",
	-- ["Zapped giants and sea elementals"] = "Geschrumpfte Riesen und Meereselementare",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "grinde an {npc:1796} am Ort {area:202}, {zone:1422}",
	-- ["{area:199} cauldron"] = "Kessel im {area:199}",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}, von {npc:11056}",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: Ihre Eskorte kommt später auf der Route",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} steht beim Hof am Ort {area:202}, nordöstlich der Felder.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}s Geist wandert beim Bauernhaus im {area:199} umher, westlich von {area:200}; ihr Paket liegt drinnen.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, bei den Gräbern südlich der Kapelle",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} bewacht den Kessel im {area:199}, westlich von Andorhal.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} steht bei der Hütte von Augustus im {area:2627}.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} läuft durch das Holzlager Northridge östlich von {npc:11610}; {npc:11611} bewacht den Turm am südlichen Zugang von {area:190}.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: Die Termiten kommen später, im {area:2627}",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} ist Elite: Eine Gruppe wird empfohlen. Er bewacht sein Phylakterium in der Mitte von Andorhal.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: Behalte es für {area:440}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: Behalte es für Un'Goro",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}, im Bauernhaus",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} in {area:493}: Behalte es",
}
