-- German (deDE): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Light's Hope Chapel
	-- {npc:16256} Jessica Chambers
	["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",

	-- Step 2: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: Die Termiten kommen später, im {area:2627}",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}s Bauernhaus steht auf dem Hügel östlich des Lagers; das Denkmal von {npc:10936} liegt gleich nördlich davon.",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, am Denkmal",

	-- Step 4: The fields
	["The fields"] = "Die Felder",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Skelettschinder und Sabbernde Ghule streifen über die Felder nördlich des Lagers; die ganze Geißel hier droppt Geißelsteine.",

	-- Step 5: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} steht beim Hof am Ort {area:202}, nordöstlich der Felder.",

	-- Step 6: Diseased Wolves
	["Diseased Wolves"] = "Kranke Wölfe",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "Kranke Grizzlys",

	-- Step 9: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Für die Druiden von {zone:1457}: Behalte es",

	-- Step 10: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Reite nach Nordwesten zu Dalsons Hof. Das Tagebuch liegt in der Scheune; ein umherwanderndes Skelett trägt den Schlüssel für das Nebengebäude, und {npc:10836} wartet im Nebengebäude mit dem Schrankschlüssel.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "{object:175924}, im Bauernhaus",

	-- Step 11: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}s Geist wandert beim Bauernhaus im {area:199} umher, westlich von {area:200}; ihr Paket liegt drinnen.",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Für {zone:1453}: Behalte es",

	-- Step 12: Chillwind Camp
	["Ride back south to the camp."] = "Reite zurück nach Süden zum Lager.",

	-- Step 13: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Die Wachtürme von Andorhal",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Benutze die {item:12815} am Fuß jedes der vier Wachtürme rund um den Rand von Andorhal, nördlich des Lagers.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Markiere {npc:10902} mit der {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Markiere {npc:10903} mit der {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Markiere {npc:10904} mit der {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Markiere {npc:10905} mit der {item:12815}",

	-- Step 14: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Kessel im {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} bewacht den Kessel im {area:199}, westlich von Andorhal.",

	-- Step 15: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Kaufe für den Kessel im Teufelssteinfeld einen {item:13320} bei {npc:11056}, direkt bevor du losgehst: Die Beschleuniger verschwinden nach 30 Minuten.",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{item:13320}, von {npc:11056}",

	-- Step 16: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Der Kessel bietet jetzt eine eigene Aufgabe an; die Skelette um ihn herum droppen Knöcherne Aufstachler.",

	-- Step 17: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Kessel bei {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "Der Kessel steht bei {area:200}, nordöstlich vom Teufelssteinfeld; sein Kessellord steht daneben.",

	-- Step 19: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Kessel: {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Der Kessel steht am Ort {area:202}, bei {npc:10739}' Hof.",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "grinde an {npc:1796} am Ort {area:202}, {zone:1422}",

	-- Step 20: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Kaufe zwei weitere Arkanbeschleuniger für die Kessel am Ort {area:202} und bei Dalsons Tränenfeld und reite direkt dorthin: Sie verschwinden nach 30 Minuten.",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} ist ein Elite der Stufe 61",

	-- Step 21: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Zurück nach Norden zum Ort {area:202}: Der Kessel bietet jetzt eine eigene Aufgabe an. Die Ghule in der Nähe droppen Somatische Verstärker.",

	-- Step 23: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} wartet im zerstörten Gasthaus auf der Westseite von Andorhal.",

	-- Step 24: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Benutze den {item:12627} bei den Getreidesilos, um Temporale Parasiten hervorzulocken. {quest:5154} ist einer der muffigen Folianten im Rathaus. Jedes Skelett in der Stadt droppt {quest:5537}.",

	-- Step 25: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} ist Elite: Eine Gruppe wird empfohlen. Er bewacht sein Phylakterium in der Mitte von Andorhal.",

	-- Step 26: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, bei der {area:2268}: Behalte es",

	-- Step 27: Andorhal Watches
	["Andorhal Watches"] = "Andorhal-Uhren",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Kleine Schließkassetten liegen überall in Andorhal im Schutt; in jeder steckt eine Uhr.",

	-- Step 29: More watches
	["More watches"] = "Mehr Uhren",

	-- Step 31: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Reite auf der Straße nach Norden zum Holzlager Northridge; {npc:11610} versteckt sich am Rand des Lagers.",

	-- Step 32: The Scarlet Crusade
	["The Scarlet Crusade"] = "Der Scharlachrote Kreuzzug",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Scharlachrote Sanitäter, Jäger, Ritter und Magier patrouillieren durch das Holzlager und auf der Straße Richtung {area:190}.",

	-- Step 34: Radley and Durgen
	["Radley and Durgen"] = "Radley und Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} läuft durch das Holzlager Northridge östlich von {npc:11610}; {npc:11611} bewacht den Turm am südlichen Zugang von {area:190}.",

	-- Step 36: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Aussichtspunkt über {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "Steig auf den Hügel westlich von {area:190} und blick auf die Stadt hinunter.",

	-- Step 38: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Reite nach Osten zum Grenzfluss: {npc:1855} lebt in einer kleinen Hütte am Ufer.",

	-- Step 39: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Kessel bei {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Reite nach Süden nach {area:201}, wo {npc:11078} den Kessel bewacht.",

	-- Step 40: Chillwind Camp
	["Ride south-west to the camp."] = "Reite nach Südwesten zum Lager.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} in {area:976}: Behalte es",

	-- Step 41: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, bei den Gräbern südlich der Kapelle",

	-- Step 42: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Horgus' Schädel liegt am {area:2624} und Marduks Schwert im Gebiet {area:2623}, jeweils dort, wo Geister kämpfen; ausgewachsene Seuchenhunde jagen auf den Ebenen dazwischen.",

	-- Step 44: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Reite nach Nordwesten zur {area:2276}, am Rand des Gebiets {area:2277}.",

	-- Step 45: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Reite nach Westen ins {area:2627}. Kleine Seuchenhunde, Seuchenfledermäuse und Aaslarven streifen durch seine Wälder; füll {item:15042} an den großen Termitenhügeln und töte weiter nördlich die Rasenden Seuchenhunde.",

	-- Step 46: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} steht bei der Hütte von Augustus im {area:2627}.",

	-- Step 47: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Überquere den Fluss nach Westen zu {npc:1855}s Hütte.",
	["Listen to his story"] = "Hör dir seine Geschichte an",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} ist Elite: Eine Gruppe wird empfohlen",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} liegt im Rathaus von {area:190}, westlich von {npc:1855}: Die scharlachroten Wachen stehen dicht beieinander.",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} liegt östlich der Scheune bei {area:201}.",

	-- Step 50: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Überquere den Fluss nach Osten zum {area:2261}, der Gruft im Südwesten des Gebiets. {object:177667} liegt drinnen: Ihr Schlüssel ist bei {npc:12248} ganz im Nordosten, was im nächsten Guide erledigt wird.",

	-- Step 51: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Reite zurück zum {area:3197} und flieg zum Ort {area:150}, nimm das Boot nach {area:442} und flieg nach {area:702}; das Portal führt hinauf nach {zone:1457}.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, im Gebiet {area:1658}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Zehn {item:11040} aus dem {item:11020}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, wo im nächsten Guide trainiert wird, hat keinen Druidenlehrer",

	-- Step 52: Temple of the Moon
	["Temple of the Moon"] = "Der Tempel des Mondes",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} und {npc:7740} stehen beim Tempel des Mondes; fülle {item:11682} am Mondbrunnen darin.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: Behalte es für {area:976}",

	-- Step 53: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} in {zone:1450}: Behalte es",

	-- Step 54: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} in {zone:1452}: Behalte es",

	-- Step 55: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Flieg von {area:702} zur {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: Behalte es für {zone:1446}",

	-- Step 56: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Nimm das Boot zum Festland und reite nach Nordosten zu {npc:14637}s Lager beim Ort {area:1119}.",

	-- Step 57: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "Geschrumpfte Riesen und Meereselementare",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Die geschrumpften Riesen streifen durch das Gebiet {area:1119}; die Meereselementare waten westlich davon an der Küste entlang.",

	-- Step 59: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}s Lager liegt nördlich vom Ort {area:1119}. Er verkauft das {item:11243}, sobald er seinen Köder hat.",

	-- Step 60: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "Flieg nach {area:392}.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: Behalte es für Un'Goro",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}, an der Küste nördlich der Stadt",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Für {zone:1448}: Behalte es",

	-- Step 61: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Flieg von {area:392} nach {area:2255} und reite nach Süden zum {area:2250}.",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: Ihre Eskorte kommt später auf der Route",

	-- Step 62: Donova Snowden
	["Ride west along the road to the hot springs."] = "Reite auf der Straße nach Westen zu den heißen Quellen.",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "Gaeriyan in {area:976}: Behalte es",

	-- Step 63: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Geh in die {area:1769} und nimm den Tunnelzweig nach {zone:1450} bis nach {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Für {zone:1451}: Behalte es",

	-- Step 64: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "Der nächste Guide beginnt hier in {area:392} und fliegt weiter nach {area:976}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Überquere den Fluss nach Osten zum Ort {area:2261}, der Gruft im Südwesten des Gebiets. Die {object:177667} liegt drinnen: Ihr Schlüssel ist bei {npc:12248} ganz im Nordosten, was im nächsten Guide erledigt wird.",
}
