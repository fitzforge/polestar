-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands
	["Western & {zone:1423}"] = "Occidentales y {zone:1423}",

	-- Step 1: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Vuela a {area:702}",
	-- {zone:1457} Darnassus · {zone:1450} Moonglade · {zone:1455} Ironforge · {area:3197} Chillwind Camp
	["The {zone:1457}, {zone:1450} and {zone:1455} stops are for players coming from the previous guides with their quests; opened with none of those quests in the log, the guide starts at {area:3197}."] = "Las paradas de {zone:1457}, {zone:1450} y {zone:1455} son para jugadores que vienen de las guías anteriores con sus misiones; abierta sin ninguna de esas misiones en el registro, la guía empieza en {area:3197}.",

	-- Step 2: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "El vuelo aterriza en {area:702}. {npc:7916} está a un paseo corto al noroeste del maestro de vuelo.",
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}' next task sends you back to Ranshalla in {zone:1452}, behind the route now: skip it."] = "La siguiente tarea de {npc:7916} te manda de vuelta con Ranshalla en {zone:1452}, ya detrás de la ruta: omítela.",

	-- Step 4: Herald Moonstalker
	-- {npc:10878} Herald Moonstalker
	["{npc:10878} stands by the Temple of the Moon."] = "{npc:10878} está junto al Templo de la Luna.",

	-- Step 6: Arch Druid Fandral Staghelm
	-- {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building of the {area:1658}; {npc:4217}, next, is lower down inside it."] = "Fandral está en lo alto del edificio de los druidas de {area:1658}; {npc:4217}, a continuación, está más abajo dentro de él.",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "{npc:3516}, en el piso de arriba",

	-- Step 8: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, arriba",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade · {zone:2482} Mount Hyjal
	["{quest:6762} in {zone:1450}: {zone:2482}'s {zone:1450} errand takes you to her, in the next guide; keep it"] = "{quest:6762} en {zone:1450}: el encargo de {zone:1450} de {zone:2482} te lleva con ella, en la siguiente guía; guárdala",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} no tiene instructor de druidas",

	-- Step 9: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal a {zone:1438}",

	-- Step 10: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Vuela a {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maestro de vuelo de {area:702}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",

	-- Step 12: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maestro de vuelo de {area:150}",

	-- Step 13: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle
	["{npc:9616}' next task fills his jars in Un'Goro, behind the route now: skip it."] = "La siguiente tarea de {npc:9616} llena sus frascos en Un'Goro, ya detrás de la ruta: omítela.",

	-- Step 14: Ironforge
	-- {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["{npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14724} y {npc:14723} reciben cada uno sesenta de lana, sesenta de seda y sesenta de tejido mágico, y luego sesenta de {item:14047}: entrega lo que lleves (o cómpralo en la casa de subastas) y omite el resto.",
	-- {npc:15187} Cenarion Emissary Jademoon · {npc:15191} Windcaller Proudhorn · {zone:1451} Silithus
	["{npc:15187}, by the flight master where you land: for {npc:15191} in {zone:1451}, on the last guide; keep it"] = "{npc:15187}, junto al maestro de vuelo donde aterrizas: para {npc:15191} en {zone:1451}, en la última guía; guárdala",
	-- {npc:13843} Lieutenant Rotimer · {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13843}: for {npc:13841}, on the way to {area:3197}"] = "{npc:13843}: para {npc:13841}, de camino a {area:3197}",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "{item:2592}, de tus bolsas",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "{item:4306}, de tus bolsas",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "{item:4338}, de tus bolsas",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "{item:14047}, de tus bolsas",

	-- Step 15: Courier Hammerfall
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10877} Courier Hammerfall · {zone:1455} Ironforge · {npc:10838} Commander Ashlam Valorfist
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10877} walks the ring of {zone:1455} and sends you to {npc:10838}, whose camp this guide visits next. Chillwind's chain starts with it."] = "Sin las misiones de {area:3197} de la guía de {zone:1428}: {npc:10877} recorre el anillo de {zone:1455} y te manda con {npc:10838}, cuyo campamento visita esta guía a continuación. La cadena de Vientofrío empieza con ella.",

	-- Step 16: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",

	-- Step 17: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them."] = "Cabalga al norte desde {area:271} hacia Alterac y al oeste hasta las murallas de {area:279}: {npc:34365} está fuera de ellas.",

	-- Step 18: Lieutenant Haggerdin
	-- {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13841} camps beside the road north to {area:3197}."] = "{npc:13841} acampa junto al camino al norte hacia {area:3197}.",

	-- Step 19: Chillwind Camp: Clear the Way
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10838} Commander Ashlam Valorfist · {quest:5092} Clear the Way
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10838} stands in the middle of the camp. His {quest:5092} opens the camp's chain."] = "Sin las misiones de {area:3197} de la guía de {zone:1428}: {npc:10838} está en el centro del campamento. Su {quest:5092} abre la cadena del campamento.",

	-- Step 20: Sorrow Hill: Clear the Way
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields just north of the camp.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled."] = "Los despellejadores esqueléticos y los necrófagos esclavizantes (50) rondan los campos justo al norte del campamento.\nCuidado: estos no-muertos te detectan desde lejos, y otros no-muertos cercanos se suman a la pelea cuando atraes a uno.",

	-- Step 21: Chillwind Camp: the cauldrons
	-- {area:3197} Chillwind Camp
	["{area:3197}: the cauldrons"] = "{area:3197}: los calderos",
	-- {npc:11053} High Priestess MacDonnell
	["Back to the camp: Valorfist, then {npc:11053} beside him."] = "De vuelta al campamento: Valorfist, y luego {npc:11053} a su lado.",
	-- {area:199} Felstone Field
	["{area:199}'s cauldron, later in this guide"] = "El caldero de {area:199}, más adelante en esta guía",

	-- Step 22: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Puricorazón, Dumah, Puño de Valor y MacDonnell están en el centro del campamento, junto al maestro de vuelo.",
	-- {npc:11616} Nathaniel Dumah · {area:2277} Plaguewood
	["{npc:11616}: the termites come later, in the {area:2277}"] = "{npc:11616}: las termitas vienen después, en {area:2277}",
	-- {npc:10838} Commander Ashlam Valorfist · {area:199} Felstone Field
	["{npc:10838}: the watchtowers stand around Andorhal, on the way to {area:199}"] = "{npc:10838}: las atalayas están alrededor de Andorhal, de camino a {area:199}",

	-- Step 23: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission
	["No {quest:5401} yet? Pureheart gives you one here: the scourgestone quests need it."] = "¿Todavía sin {quest:5401}? Pureheart te da una aquí: las misiones de piedras de la Plaga la necesitan.",

	-- Step 24: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Las atalayas de Andorhal",
	-- {item:12815} Beacon Torch · {area:199} Felstone Field · {npc:7572} Fallen Hero of the Horde
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp, on the way to {area:199}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Usa la {item:12815} al pie de cada una de las cuatro atalayas del borde de Andorhal, al norte del campamento, de camino a {area:199}.\nCuidado: los señores de la guerra esqueléticos y los gólems de carne (57, élites) recorren las calles de Andorhal, y el {npc:7572} (59, élite) deambula entre Andorhal y Cresta Norte: quédate en las torres del borde del pueblo y déjalos pasar.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca {npc:10902} con la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca {npc:10903} con la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca {npc:10904} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca {npc:10905} con la {item:12815}",

	-- Step 25: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Caldero de {area:199}",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw · {npc:10778} Janice Felstone · {zone:1453} Stormwind
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["West of Andorhal to {area:199}: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54).\n{npc:10778}'s ghost wanders by the farmhouse at the field's edge, upstairs; her parcel lies inside the house: take it for {zone:1453}, at the end of this guide."] = "Al oeste de Andorhal hasta {area:199}: {npc:11075} (53) custodia el caldero entre los necrófagos farfullantes (54).\nEl fantasma de {npc:10778} ronda la casa de la granja en el borde del campo, en el piso de arriba; su paquete está dentro de la casa: tómalo para {zone:1453}, al final de esta guía.",
	-- {npc:10778} Janice Felstone
	["{npc:10778}, upstairs in the farmhouse"] = "{npc:10778}, en el piso de arriba de la granja",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "{object:175894}, adentro",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Para {zone:1453}: guárdala",

	-- Step 26: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Back to {area:3197}."] = "De vuelta a {area:3197}.",
	-- {area:200} Dalson's Tears
	["The cauldron is at {area:200}"] = "El caldero está en {area:200}",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} es élite de nivel 61",

	-- Step 27: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: mata a estos según te los encuentres",
	-- {quest:5401} Argent Dawn Commission · {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones while you wear the {quest:5401} (equip it as a trinket first).\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Los Despellejadores esqueléticos y Necrófagos esclavizantes rondan los campos al norte del campamento; toda la Plaga de aquí suelta piedras de la Plaga mientras lleves la {quest:5401} (equípala primero como abalorio).\nCuidado: Estos no-muertos te detectan desde lejos, y otros no-muertos cercanos se suman a la pelea cuando atraes a uno.\nCuidado: {npc:10411} (3 apariciones, reaparece en 15 min) se vuelve invisible fuera de combate y llama a Gárgolas Ventorroca en cuanto empieza una pelea.",

	-- Step 28: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the ghost in {area:2262}, the next stop."] = "En el camino al este que sale de {area:3197}, la granja de {npc:10927} está en {area:197}: su {quest:5142} va al fantasma de {area:2262}, la siguiente parada.",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: guárdala para {area:2262}",

	-- Step 29: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Hacia {zone:1423}",
	-- {zone:1422} Western Plaguelands
	["Follow the southern road east out of the {zone:1422}."] = "Sigue el camino del sur al este fuera de {zone:1422}.",

	-- Step 30: Pamela Redpath
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["The ruins of {area:2262} lie south of the road. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Las ruinas de {area:2262} están al sur del camino. El fantasma de {npc:10926} juega junto a la casa en ruinas del extremo sur.",

	-- Step 31: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "La muñeca de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Las tres piezas de la muñeca están en las casas en ruinas de {area:2262}; recoger una puede atraer fantasmas. Combínalas para formar la muñeca.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "{item:12886}; adentro",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "{item:12888}; adentro",

	-- Step 32: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, back in the {zone:1422}: keep it"] = "{quest:5152}, de vuelta en {zone:1422}: guárdala",
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["{npc:11063} at {area:2268}, on this guide's second ride east: keep it"] = "{npc:11063} en {area:2268}, en la segunda cabalgata al este de esta guía: guárdala",

	-- Step 33: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride back west along the road to {npc:10927}'s farmhouse; {npc:10936}'s monument is just north of it."] = "Cabalga de vuelta al oeste por el camino hasta la granja de {npc:10927}; el monumento de {npc:10936} está justo al norte.",
	["Upstairs"] = "Arriba",
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal, later on this loop: keep it"] = "{npc:10667} en Andorhal, más adelante en este recorrido: guárdala",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, en el monumento",

	-- Step 34: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {npc:10927} Marlene Redpath
	["{npc:10739} stands by the farm at the {area:202}, north of {npc:10927}."] = "{npc:10739} está junto a la granja de {area:202}, al norte de {npc:10927}.",
	["Inside"] = "Adentro",

	-- Step 35: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202}: mata a estos según te los encuentres",
	-- {item:12841} Invader's Scourgestone · {quest:5401} Argent Dawn Commission
	["{item:12841}: wear the {quest:5401} while you kill"] = "{item:12841}: lleva puesta la {quest:5401} mientras matas",

	-- Step 37: Diseased Grizzlies
	["Diseased Grizzlies"] = "Osos pardos malsanos",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The Diseased Grizzlies (55-56) roam the woods around the {area:202}, east and north of {npc:10739}."] = "Los osos pardos malsanos (55-56) recorren el bosque alrededor de {area:202}, al este y al norte de {npc:10739}.",

	-- Step 38: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1457} Darnassus
	["{npc:10739}' next task goes to the druids of {zone:1457}, behind the route now: skip it."] = "La siguiente tarea de {npc:10739} va a los druidas de {zone:1457}, ya detrás de la ruta: omítela.",

	-- Step 39: Dalson's Tears
	-- {npc:10836} Farmer Dalson · {npc:11152} The Scourge Cauldron
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key. {npc:11152} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "Cabalga al noroeste hasta la granja Dalson. El diario está en el granero; un esqueleto errante lleva la llave de la letrina, y {npc:10836} espera en la letrina con la llave del armario. {npc:11152} está justo al suroeste de la casa, y su Señor del caldero, a su lado, lleva la llave.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}, en la casa de la granja; adentro",

	-- Step 40: Argent Officer Pureheart
	-- {area:3197} Chillwind Camp
	["Ride back south to {area:3197}."] = "Cabalga de vuelta al sur hasta {area:3197}.",

	-- Step 42: Chillwind Camp
	-- {area:200} Dalson's Tears
	["Ride back south from {area:200} to the camp."] = "Cabalga de vuelta al sur desde {area:200} hasta el campamento.",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} (from level 55)"] = "{npc:10838} (desde el nivel 55)",
	["The skeletons of Andorhal, next on this guide"] = "Los esqueletos de Andorhal, a continuación en esta guía",

	-- Step 43: Chromie
	-- {npc:10667} Chromie
	["North to {npc:10667} in the ruined inn on the west side of Andorhal."] = "Al norte, hasta {npc:10667} en la posada en ruinas del lado oeste de Andorhal.",

	-- Step 44: Andorhal
	["Andorhal"] = "Andorhal",
	-- {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments · {npc:1852} Araj the Summoner
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["{quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk the streets: let them pass.\n{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{quest:5154} es uno de los tomos mohosos del ayuntamiento. Cada esqueleto del pueblo suelta {quest:5537}.\nCuidado: los señores de la guerra esqueléticos ({npc:1788}) y los gólems de carne ({npc:1805}) (57, élite) recorren las calles: déjalos pasar.\n{npc:1852} es élite: se recomienda ir en grupo. Guarda su filacteria en el centro de Andorhal.",

	-- Step 45: Andorhal's grain silos
	["Andorhal's grain silos"] = "Los silos de grano de Andorhal",
	-- {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["Use the {item:12627} by each grain silo on the north side of town to draw out Temporal Parasites, one silo after another.\nCareful: the Temporal Parasites are 55-57: draw them out one silo at a time, away from the Skeletal Warlords and Flesh Golems (57, elites) in the streets."] = "Usa {item:12627} junto a cada silo de grano del norte del pueblo para sacar a los parásitos temporales ({npc:10717}), un silo tras otro.\nCuidado: los parásitos temporales son 55-57: sácalos de silo en silo, lejos de los señores de la guerra esqueléticos ({npc:1788}) y los gólems de carne ({npc:1805}) (57, élite) de las calles.",

	-- Step 46: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, en {area:2268}: guárdala",

	-- Step 47: Sorrow Hill: kill these as you meet them
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Hay pequeños cofres entre los escombros por todo Andorhal; cada uno guarda un reloj.\nCuidado: casi siempre hay necrófagos y esqueletos junto a los cofres, que atacan cuando te acercas. Los necrófagos abrasadores además dañan a todos los que están cerca y rompen el sigilo.",

	-- Step 49: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Caldero de {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm, east of Andorhal."] = "El caldero está en {area:202}, junto a la granja de {npc:10739}, al este de Andorhal.",

	-- Step 50: Chillwind Camp
	-- {area:201} Gahrron's Withering
	["{area:201}'s cauldron, on this guide's ride north-east"] = "El caldero de {area:201}, en la cabalgata al noreste de esta guía",
	-- {area:976} Gadgetzan
	["Arbington's next task goes to {area:976}, behind the route now: skip it."] = "La siguiente tarea de Arbington va a {area:976}, ya detrás de la ruta: omítela.",

	-- Step 51: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone
	["Fly to {zone:1453} for Highlord Bolvar's errand for SI:7 and {npc:10778}'s parcel, then straight back."] = "Vuela a {zone:1453} por el encargo del alto señor Bolvar para el IV:7 y el paquete de {npc:10778}, y luego vuelve directo.",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Maestro de vuelo de {area:3197}",

	-- Step 52: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, en el IV:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}, on the flight back"] = "{quest:6184} en {area:3197}, en el vuelo de vuelta",

	-- Step 53: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} acepta sesenta de paño de seda, sesenta de tejido mágico y sesenta de {item:14047}: entrega lo que tengas (o cómpralo en la casa de subastas) y sáltate el resto.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, que recorre los canales",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, out of the way now: skip it."] = "El amuleto de Emma vuelve a {npc:10778} en {zone:1422}, fuera del camino ahora: omítela.",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, en {object:2096}",

	-- Step 54: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Vuela a {area:3197}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maestro de vuelo de {zone:1453}",

	-- Step 55: Flint Shadowmore
	-- {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["The agents' remains lie at the {area:2260} in the {zone:1423}, on this guide's ride east"] = "Los restos de los agentes están en {area:2260} de {zone:1423}, en la cabalgata al este de esta guía",

	-- Step 56: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Sigue el camino al norte hasta el Aserradero Crestanorte; {npc:11610} se esconde en el borde del campamento.",

	-- Step 57: The Scarlet Crusade
	["The Scarlet Crusade"] = "La Cruzada Escarlata",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Los Médicos, Cazadores, Caballeros y Magos Escarlata patrullan el aserradero y el camino hacia {area:190}.",

	-- Step 59: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} (56) walks the Northridge camp east of {npc:11610}; {npc:11611} (57) guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} (56) recorre el campamento de Cresta Norte al este de {npc:11610}; {npc:11611} (57) vigila la torre del acceso sur a {area:190}.\nCuidado: hay guardias en la base de la torre y uno más da vueltas a su alrededor patrullando. Despéjalos antes de enfrentar a Durgen para que no se sumen a la pelea.",

	-- Step 60: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} se esconde en el borde del campamento maderero.",

	-- Step 61: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Mirador de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Sube a la colina al oeste de {area:190} para mirar el pueblo desde arriba.\nCuidado: Los centinelas apostados en la puerta pueden detectar a los jugadores en sigilo. Hay más centinelas dentro del pueblo, y un élite patrulla cerca.",

	-- Step 63: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2277} Plaguewood · {area:2627} Terrordale
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank. His hunts are in the {area:2277} and {area:2627}, at the end of this guide's ride east."] = "Cabalga al este hasta el río fronterizo: {npc:1855} vive en una pequeña choza en la orilla. Sus cacerías están en {area:2277} y {area:2627}, al final de la cabalgata al este de esta guía.",

	-- Step 64: Gahrron's Withering
	-- {npc:1855} Tirion Fordring · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south from {npc:1855}'s hut to {area:201}. {npc:11078} (58) guards the cauldron.\nCareful: Soulwrath is level 58, a level over you here: clear the ghouls around the cauldron first and pull him alone."] = "Cabalga al sur desde la choza de {npc:1855} hasta {area:201}. {npc:11078} (58) custodia el caldero.\nCuidado: Soulwrath es de nivel 58, uno por encima de ti aquí: limpia primero a los necrófagos alrededor del caldero y atráelo solo.",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "Para {npc:11053} en {area:3197}, al final de esta guía",

	-- Step 65: Marris Stead
	-- {zone:1423} Eastern Plaguelands · {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride east into the {zone:1423}: the {area:2260} is the farm north of the southern road, north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "Cabalga al este hacia {zone:1423}: {area:2260} es la granja al norte del camino del sur, al noroeste de {area:2262}. Los restos de los tres agentes son siluetas de huesos en el suelo: uno junto al camino al sur de la granja, uno en la colina al este de la casa y uno en el montículo frente a ella.\nCuidado: {npc:11878} (élite de nivel 62) y sus canes élite están frente a la casa: toma los restos del montículo desde un costado y no lo atraigas. No tienes que pelear con él.",
	["Close enough to see the Blightcaller in front of the house"] = "Lo bastante cerca para ver al Clamañublo frente a la casa",

	-- Step 66: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: mata a estos según te los encuentres",
	-- {zone:1423} Eastern Plaguelands · {area:2268} Light's Hope Chapel
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Gargantuan Plaguebats = {npc:272342} Gargantuan Plaguebat
	["Ride east along the southern road across the {zone:1423} to {area:2268}: Plaguehound Runts and Plaguebats roam beside it.\nCareful: Gargantuan Plaguebats (60) fly among the smaller bats near the western border: take the Plaguebats of your level."] = "Cabalga al este por el camino del sur cruzando {zone:1423} hasta {area:2268}: los cachorros de can de peste y los murcipestes andan a su lado.\nCuidado: los Gargantuan Plaguebats (60) vuelan entre los murciélagos más pequeños cerca del límite oeste: ve por los murcipestes de tu nivel.",

	-- Step 67: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "La siguiente tarea de {npc:11063}, en {area:2264}, transcurre entre la Plaga de nivel 57-60: omítela.",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, at the end of this ride: keep it"] = "{npc:11038}, junto a las tumbas al sur de la capilla: {npc:11140} está en {area:2627}, al final de esta cabalgata: guárdala",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast · {area:2261} Undercroft
	["{npc:11038}'s {npc:12250} is a group quest in the {area:2261} (a level 54 elite)."] = "{npc:12250} de {npc:11038} es una misión de grupo en {area:2261} (un élite de nivel 54).",

	-- Step 68: Carlin Redpath: Heroes of Darrowshire
	-- {area:190} Hearthglen · {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	-- plural, as words: Haunting Visions = {npc:4472} Haunting Vision
	["The libram is inside {area:190} among elite Scarlet guards, and {item:12955} among Haunting Visions at {area:201}: a group quest."] = "El libram está dentro de {area:190} entre guardias Escarlata élite, y el {item:12955}, entre visiones encantadas en {area:201}: una misión de grupo.",

	-- Step 69: Villains of Darrowshire
	-- {area:2623} Infectis Scar · {area:2624} Blackwood Lake
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["West into the middle of the zone: Marduk's sword lies in the {area:2623} and Horgus' skull at {area:2624}, north of it, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Al oeste, hacia el centro de la zona: la espada de Marduk está en {area:2623} y el cráneo de Horgus en {area:2624}, al norte, cada uno donde pelean los fantasmas; los canes de peste adultos cazan en las llanuras entre ambos.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "{item:12956}; bajo el agua",

	-- Step 70: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath
	["Back east to {npc:11063} at the chapel."] = "De vuelta al este con {npc:11063} en la capilla.",

	-- Step 71: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Cabalga al noroeste hasta {area:2276}, en el borde de {area:2277}.",

	-- Step 72: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: mata a estos según te los encuentres",
	-- {area:2277} Plaguewood · {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Carrion Devourers = {npc:8605} Carrion Devourer
	["West through the {area:2277} to {area:2627}: fill the {item:15042} at the big termite mounds, and kill the Frenzied Plaguehounds and the Carrion Devourers on the way.\nCareful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "Al oeste cruzando {area:2277} hasta {area:2627}: llena el {item:15042} en los grandes termiteros y mata a los canes de peste demenciados y a los devoradores carroñeros en el camino.\nCuidado: los canes de peste demenciados son de nivel 57-58: atráelos de uno en uno.",

	-- Step 73: Augustus the Touched
	-- {npc:12384} Augustus the Touched · {area:2627} Terrordale · {npc:11140} Egan · {npc:16184} Nerubian Overseer · {area:2626} Terrorweb Tunnel
	["{npc:12384} lives in the ruined hut in {area:2627}, and his receipt book lies in the ruined inn nearby. {npc:11140} stands by {npc:12384}' hut.\nCareful: a {npc:16184} (60, elite) walks {area:2627} and the {area:2626} south-west of it. Look for him before you ride in, and wait for him to pass."] = "",

	-- Step 75: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:2626} Terrorweb Tunnel
	-- plural, as words: Crypt Fiends = {npc:8555} Crypt Fiend
	["Cross the river west to {npc:1855}'s hut.\nCareful: the short way from {area:2627} to {npc:1855} is the {area:2626}, whose south mouth opens by his hut: Crypt Fiends, Walkers, Horrors and Slayers (53-58) stand close together inside. Pull them one at a time, or ride round by the road outside it."] = "Cruza el río al oeste hasta la choza de {npc:1855}.\nCuidado: el camino corto de {area:2627} a {npc:1855} es {area:2626}, cuya entrada sur da a su choza: adentro hay mefistos, caminantes, horrores y destripadores de la cripta (53-58) muy juntos. Atráelos de uno en uno, o rodea por el camino de afuera.",

	-- Step 77: Tirion Fordring
	["Listen to his story"] = "Escucha su historia",

	-- Step 78: Tirion Fordring: Of Forgotten Memories
	-- {quest:5781} Of Forgotten Memories · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["{quest:5781} is a group quest: {npc:11886} (57, elite) and his adds in the {area:2261}."] = "{quest:5781} es una misión de grupo: {npc:11886} (57, élite) y sus esbirros en {area:2261}.",

	-- Step 79: Undercroft
	-- {area:2261} Undercroft
	["Cross the river south-east to the {area:2261}, the crypt in the south-west of the zone.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cruza el río al sureste hasta {area:2261}, la cripta del suroeste de la zona.\nCuidado: con Mercutio vienen unos cuatro esbirros que no son élite. Caminan hasta la tumba en vez de aparecer en el lugar.",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886} (57, elite)"] = "{item:14613}, de {npc:11886} (57, élite)",

	-- Step 80: Tirion Fordring
	-- {quest:5845} Of Lost Honor · {area:2277} Plaguewood · {area:3197} Chillwind Camp
	["{quest:5845}'s symbol lies in the lake south of the {area:2277}: your group fetches it before the ride back to {area:3197}."] = "El símbolo de {quest:5845} está en el lago al sur de {area:2277}: tu grupo lo busca antes de la cabalgata de vuelta a {area:3197}.",

	-- Step 81: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1839} Scarlet High Clerist
	-- plural, as words: Scarlet Paladins = {npc:1834} Scarlet Paladin
	["Careful: Scarlet Paladins (55-56) and priests guard {item:12954} inside {area:190}'s town hall. They are elite, and a {npc:1839} (63, elite) stands near the book. Go in with your group; stay out of the Clerist's reach."] = "Cuidado: los paladines Escarlata (55-56) y los sacerdotes custodian el {item:12954} dentro del ayuntamiento de {area:190}. Son élites, y un {npc:1839} (63, élite) está cerca del libro. Entra con tu grupo; mantente fuera del alcance del clérigo.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "{item:12954}; adentro",

	-- Step 82: Redpath's Shield
	-- {area:201} Gahrron's Withering
	["The shield lies east of the barn at {area:201}. Take your group around the barn to reach it."] = "El escudo está al este del granero de {area:201}. Lleva a tu grupo alrededor del granero para llegar a él.",

	-- Step 83: Carlin Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["Back to {npc:11063} at {area:2268} with your group."] = "De vuelta con {npc:11063} en {area:2268}, con tu grupo.",

	-- Step 84: Eastern Plaguelands
	-- {area:2277} Plaguewood · {area:2268} Light's Hope Chapel
	["Ride to the lake south of the {area:2277}, north-west of {area:2268}."] = "Cabalga hasta el lago al sur de {area:2277}, al noroeste de {area:2268}.",
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "El lago para {quest:5845}",

	-- Step 85: Of Lost Honor
	["Underwater"] = "Bajo el agua",

	-- Step 86: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:3197} Chillwind Camp
	["West across the zone to {npc:1855}'s hut on the way back to {area:3197}."] = "Al oeste cruzando la zona hasta la choza de {npc:1855}, de camino de vuelta a {area:3197}.",

	-- Step 87: Western Plaguelands
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp
	["Ride south-west through the {zone:1422} to {area:3197}."] = "Cabalga al suroeste cruzando {zone:1422} hasta {area:3197}.",

	-- Step 88: Chillwind Camp
	["Dumah's next task sets a barrel down at Northridge, behind you now: skip it."] = "La siguiente tarea de Dumah deja un barril en Cresta Norte, ya detrás de ti: omítela.",

	-- Step 89: Flint Shadowmore
	-- {zone:1453} Stormwind
	["Highlord Bolvar in {zone:1453}, on the way out of this guide"] = "El alto señor Bolvar en {zone:1453}, de salida de esta guía",

	-- Step 91: Stormwind City
	["Stormwind City"] = "Ciudad de Ventormenta",
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:1748}, in {object:2117}"] = "{npc:1748}, en el {object:2117}",

	-- Step 92: Stormwind
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone · {npc:10782} Royal Factor Bathrilor · {object:2096} Trade District · {npc:3520} Ol' Emma · {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["Without the flight to {zone:1453} at 56 earlier in this guide: {npc:10778}'s parcel goes to {npc:10782} in the {object:2096}, then {npc:3520} takes her own errand on the canals. {npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "Si antes en esta guía no volaste a {zone:1453} a nivel 56: el paquete de {npc:10778} va a {npc:10782} en el {object:2096}, y luego {npc:3520} recibe su propio encargo en los canales. {npc:14722} recibe sesenta de seda, sesenta de tejido mágico y sesenta de {item:14047}: entrega lo que lleves (o cómpralo en la casa de subastas) y omite el resto.",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, behind you now: skip it."] = "El amuleto de Emma vuelve a {npc:10778} en {zone:1422}, ya detrás de ti: omítela.",

	-- Step 93: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",

	-- Step 94: Boat to Theramore
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook
	["Take the boat to Theramore: {zone:2482}, the next guide, starts with the flight to {area:2255}."] = "Toma el barco a Theramore: {zone:2482}, la siguiente guía, empieza con el vuelo a {area:2255}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["After the farm's keys: the {object:177289} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "Después de las llaves de la granja: {object:177289} está justo al suroeste de la casa de la granja, y su Señor del caldero, a su lado, lleva la llave.",
	-- ["Andorhal Watches"] = "Relojes de Andorhal",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Regresa al norte, a {area:202}: ahora el caldero ofrece su propia misión. Los necrófagos cercanos sueltan Intensificadores somáticos.",
	-- ["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one, and {npc:9299} in {area:976} shows himself only to someone who has drunk one."] = "De vuelta al campamento de {npc:7775}, justo al sureste de {npc:7765}: la {item:11242} te da tres Elixires de Videre. Guárdalos: {npc:9298} se queda con uno, y {npc:9299} en {area:976} solo se muestra a quien haya bebido uno.",
	-- ["Below ground"] = "Bajo tierra",
	-- ["Boat to {area:1108}"] = "Barco a {area:1108}",
	-- ["Bones and equipment"] = "Huesos y equipo",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Compra un {item:13320} a {npc:11056} para el caldero de Campo de Piedramácula justo antes de ir: los aceleradores desaparecen a los 30 minutos.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Compra dos Aceleradores Arcanos más para los calderos de {area:202} y de Lágrimas de Dalson, y cabalga directo hacia allá: desaparecen a los 30 minutos.",
	-- ["Careful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "Cuidado: los Canes de peste demenciados son de nivel 57-58: atráelos de uno en uno.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Sube a la colina al oeste de {area:190} para mirar el pueblo desde arriba.",
	-- ["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "Viniendo desde {zone:1451}, {area:543} está justo al entrar al cráter: {npc:10302}, el goblin, está sentado junto al agua.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cruza el río al este hasta {area:2261}, la cripta al suroeste de la zona. El {object:177667} está adentro: la llave la tiene {npc:12248}, en el extremo noreste; se hace en la siguiente guía.\nCuidado: Con Mercutio vienen unos cuatro refuerzos no élite. Caminan hacia la tumba en vez de aparecer en el lugar.",
	-- ["Cross the river west to {npc:1855}'s hut."] = "Cruza el río al oeste hasta la choza de {npc:1855}.",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Cruza el sur del cráter hasta {npc:9619}, junto a la rampa.",
	-- ["Diseased Wolves"] = "Lobos malsanos",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Los trituradores deslizantes excavan más al oeste; los tenazarios y despellejadores Latipiedra y los acecharrocas cazan en las mismas arenas.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Los asediadores deslizantes excavan en las dunas al noroeste del fuerte; los escórpidos Latipiedra y los arácnidos de arena deambulan por todas partes.",
	-- ["Eastern Pylon and the crate"] = "Pilón del este y el cajón",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Termina con {npc:9298} en {area:618}: guárdala",
	-- ["Ends with {npc:9298} in {zone:1452}: keep it"] = "Termina con {npc:9298} en {zone:1452}: guárdala",
	-- ["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- ["Fly from {area:976} to {area:541}. {npc:8737} stands at the back of the refuge; {npc:9117} is in the cave behind him.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Vuela de {area:976} a {area:541}. {npc:8737} está al fondo del refugio; {npc:9117} está en la cueva detrás de él.\nEl amigo de {npc:9997}, {npc:9999}, ha desaparecido.",
	-- ["Fly to Theramore"] = "Vuela a Isla Theramore",
	-- ["Fly to {area:2255}"] = "Vuela a {area:2255}",
	-- ["Fly to {area:2268}"] = "Vuela a {area:2268}",
	-- ["Fly to {area:392}"] = "Vuela a {area:392}",
	-- ["Fly to {area:392}."] = "Vuela a {area:392}.",
	-- ["Fly to {area:541}"] = "Vuela a {area:541}",
	-- ["Fly to {area:976}"] = "Vuela a {area:976}",
	-- ["For the druids of {zone:1457}: keep it"] = "Para los druidas de {zone:1457}: guárdala",
	-- ["For {area:1377}: keep it"] = "Para {area:1377}: guárdala",
	-- ["For {area:3197}: keep it"] = "Para {area:3197}: guárdala",
	-- ["For {zone:1448}: keep it"] = "Para {zone:1448}: guárdala",
	-- ["For {zone:1451}: keep it"] = "Para {zone:1451}: guárdala",
	-- ["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Desde Theramore, cabalga al oeste hacia {zone:1413} y al norte por la costa hasta {area:392}.",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Desde {area:392}, vuela a {area:2255} y cabalga al sur hasta {area:2250}.",
	-- ["From {area:702}, fly to {area:1116}."] = "Desde {area:702}, vuela a {area:1116}.",
	-- ["Hearth to {area:392} (bound there earlier on this guide), then fly on to {area:976}."] = "Usa la piedra de hogar a {area:392} (vinculada antes en esta guía), luego vuela a {area:976}.",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "El cráneo de Horgus está en {area:2624} y la espada de Marduk en {area:2623}, cada uno donde pelean los fantasmas; Canes de peste adultos cazan en las llanuras entre ambos.",
	-- ["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan."] = "Si te saltaste {item:9328}, mata enemigos aquí hasta el nivel 56.89 para seguir el plan de la ruta.",
	-- ["Into {zone:1451}"] = "Hacia {zone:1451}",
	-- ["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Lleva a {npc:7774} de vuelta con {npc:7765} al paso: se aleja, así que toca la campana para llamarla (no en combate), y despeja las arpías del camino antes de que llegue a ellas.",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Lleva a {npc:9999} al norte hasta {area:541}. Cuando se desmaye, usa {item:11804} en él para despertarlo.",
	-- ["Level 56.89"] = "Nivel 56.89",
	-- ["MacDonnell's next task, {area:201}'s cauldron, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "La siguiente tarea de MacDonnel, el caldero de {area:201}, espera al tramo de las Tierras de la Peste de la guía de {zone:1451}: tómala entonces.",
	-- ["More watches"] = "Más relojes",
	-- ["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "¿Todavía sin {quest:5401}? ({spell:437801} te la da cuando la guía de {zone:1452} pasa por ahí). Pureheart te da una aquí: las misiones de piedras de la Plaga la necesitan.",
	-- ["North to the refuge, for the quests the first Un'Goro visit left: {npc:9618} stands just outside and {npc:9117} in the cave at the back; the expedition's other three wait for your next stop here."] = "Al norte hasta el refugio, por las misiones que dejó la primera visita a Un'Goro: {npc:9618} está justo afuera y {npc:9117} en la cueva del fondo; los otros tres de la expedición esperan a tu próxima parada aquí.",
	-- ["Northern Pylon"] = "Pilón norte",
	-- ["On {npc:7583}"] = "En {npc:7583}",
	-- ["Ranshalla in {zone:1452}: keep it"] = "Ranshalla en {zone:1452}: guárdala",
	-- ["Ride back south to the camp."] = "Regresa al sur, al campamento.",
	-- ["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga de vuelta al suroeste hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Regresa a {area:3197} y vuela a {area:150}, toma el barco a {area:442} y vuela a {area:702}; el portal sube a {zone:1457}.",
	-- ["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Cabalga de vuelta a {area:3425}. {npc:15189} está en el piso de arriba de su edificio: sube por adentro, la flecha no distingue los pisos.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Baja por la rampa al cráter: {npc:9619} acampa al pie.",
	-- ["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Cabalga al este hasta el río fronterizo: {npc:1855} vive en una pequeña choza en la orilla.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga al este hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Cabalga al este hasta {area:1943}, donde el robot está entre los gorilas. No entres en la cueva profunda de allí.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Cabalga al este hasta {area:537}, súbela y usa {npc:10541} en las grietas de lava cerca de la cima.",
	-- ["Ride east to {npc:13220}."] = "Cabalga al este hasta {npc:13220}.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Cabalga al norte por el lado este hasta la meseta de los gorilas. {npc:9622}, un gorila de nivel 55, está en su cueva más profunda: limpia antes los gorilas de la boca de la cueva.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cabalga al norte hasta {area:2627}. {npc:12384} vive en la choza en ruinas, y su libro de recibos está en la posada en ruinas cercana.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\nCareful: the Frenzied Plaguehounds north-east of the hut are 57-58, a level or two over you: pull them one at a time."] = "Cabalga al norte hasta {area:2627}. {npc:12384} vive en la choza en ruinas, y su libro de recibos está en la posada en ruinas cercana.\nCuidado: los Canes de peste demenciados al noreste de la choza son de nivel 57-58, uno o dos niveles más que tú: atráelos de uno en uno.",
	-- ["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Cabalga al noroeste hasta la granja Dalson. El diario está en el granero; un esqueleto errante lleva la llave de la letrina, y {npc:10836} espera en la letrina con la llave del armario.",
	-- ["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Sigue cabalgando al oeste hasta {area:3425}. {npc:15189} está en el piso de arriba de su edificio: sube por adentro, la flecha no distingue los pisos.",
	-- ["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "Sal del cráter por el paso del noroeste hacia {zone:1451}: {npc:13220} está en {area:3077}, donde sale el paso.",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Cabalga al sur hasta {area:201}, donde {npc:11078} vigila el caldero.",
	-- ["Ride south-west to the camp."] = "Cabalga al suroeste hasta el campamento.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en {area:1938}.",
	-- ["Ride west along the road to the hot springs."] = "Cabalga al oeste por el camino hasta las aguas termales.",
	-- ["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Cabalga al oeste hacia las Ruinas de Viento Cuervo: {npc:7774} se esconde en el pequeño edificio redondo del fondo. Abre el cofre junto a ella para obtener {item:9189}: dura 15 minutos, igual que la misión.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Cabalga al oeste pasando {area:541} y al sur por el lado oeste hasta {area:543}: {npc:10302}, el goblin, está sentado junto al agua.",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Cabalga al oeste hasta {area:2627}. {npc:8596}, {npc:8600} y {npc:8603} rondan sus bosques; llena el {item:15042} en los termiteros grandes y mata a los Canes de peste demenciados ({npc:8598}) más al norte.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Asusta a {npc:7583} con {item:12928}",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Despellejadores esqueléticos y Necrófagos esclavizantes rondan los campos al norte del campamento; toda la Plaga de aquí suelta Piedras de la Plaga.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Los despellejadores esqueléticos y necrófagos esclavizantes rondan los campos al norte del campamento; toda la Plaga de aquí suelta piedras de la Plaga.\nCuidado: Estos no-muertos te detectan desde lejos, y otros no-muertos cercanos se suman a la pelea cuando atraes a uno.\nCuidado: {npc:10411} (3 apariciones, reaparece en 15 min) se vuelve invisible fuera de combate y llama a gárgolas Alarroca en cuanto empieza una pelea.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Hay arcones pequeños entre los escombros por todo Andorhal; cada uno guarda un reloj.",
	-- ["Take the boat to the mainland and ride north-east past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Toma el barco al continente y cabalga al noreste, más allá de {area:1119}, hasta el campamento de {npc:7775}. Prepara el {item:11243} a partir de una {item:11242}: acepta su encargo para conseguir una.",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Toma el barco al continente y cabalga al noreste hasta el campamento de {npc:14637}, junto a {area:1119}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Las bestias de alquitrán se revuelcan en {area:538}; los elementales de fuego de {area:537}, en el centro, llevan la ceniza; las avispas Gorishi de {area:540}, en el sur, llevan la glándula. Cualquier criatura del cráter puede soltar {item:11018}.\nCuidado: Las obreras Gorishi que bajan del 45% de salud tienen un 50% de probabilidad de pedir ayuda a los aliados a menos de 25 m.",
	-- ["Temple of the Moon"] = "Templo de la Luna",
	-- ["Ten {item:11040} from the {item:11020}"] = "Diez {item:11040} del {item:11020}",
	-- ["The Gorishi hive"] = "La colmena Gorishi",
	-- ["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Las Bestias de alquitrán y los Señores del alquitrán se revuelcan en {area:538}, al sur del refugio, de camino al cráter.",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Ahora el caldero ofrece su propia misión; los esqueletos de alrededor sueltan Agitadores óseos.",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "El caldero está en {area:202}, junto a la granja de {npc:10739}.",
	-- ["The crater"] = "El cráter",
	-- ["The fields"] = "Los campos",
	-- ["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "El gigante {npc:7765} está sentado justo al noroeste del campamento de {npc:7775}.",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Los gorilas viven en {area:1943}, al este de {area:541}. Guarda sus pieles para {npc:9619}. No entres en la cueva más profunda: {npc:9622} es de nivel 55.\nCuidado: Los gorilas de Un'Goro (nivel 50-51) piden ayuda a los aliados a menos de 20 m cuando bajan al 25% de salud. En la zona hay una cueva llena de simios, y pelear ahí trae muchos enemigos de más.",
	-- ["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Los gorilas viven en {area:1943}, justo al este del pilón: consigue ahora las pieles para {npc:9619}, ya que estás aquí arriba. No entres en la cueva más profunda: {npc:9622} es de nivel 55.\nCuidado: Los Gorilas de Un'Goro (nivel 50-51) piden ayuda a aliados a menos de 20 m cuando bajan al 25% de salud. Hay una cueva llena de simios en la zona, y pelear allí atrae a muchos enemigos más.",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "La siguiente guía empieza aquí en {area:392} y sigue en vuelo hasta {area:976}.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Las pieles vienen después del circuito 2, en la meseta de los gorilas",
	-- ["The pelts come from the gorillas on {area:1943}"] = "Las pieles salen de los gorilas de {area:1943}",
	-- ["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "El pilón está en los acantilados del este, sobre la guarida de {npc:9684}; el {item:11113} de la expedición está en el campamento abandonado de la jungla del este.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}."] = "El pilón está en la ladera al este del refugio. Los {npc:9166} rondan las laderas a su alrededor: cuentan para {npc:9997}.",
	-- ["The pylon stands on the western cliffs."] = "El pilón está en los acantilados del oeste.",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Los gigantes encogidos rondan {area:1119}; los elementales de mar recorren la costa al oeste.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Los druidas y centinelas torturados rondan la aldea en ruinas al suroeste de {npc:13220}.",
	-- ["The wooden sign beside {npc:9997}"] = "El letrero de madera junto a {npc:9997}",
	-- ["The {area:2742} tower"] = "La torre de {area:2742}",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "La {item:11242} crece dentro de un edificio en ruinas al norte de {npc:7765}: entra por la brecha de su muro desde la cornisa de al lado.",
	-- ["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "El {item:280417} está a poca distancia al oeste del campamento de {npc:9619}.",
	-- ["Umber in {area:493}: keep it"] = "Umber en {area:493}: guárdala",
	-- ["Umber in {zone:1450}: keep it"] = "Umber en {zone:1450}: guárdala",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Usa el {item:12627} junto a los silos de grano para hacer salir Parásitos temporales. {quest:5154} es uno de los tomos mohosos del ayuntamiento. Todos los esqueletos del pueblo sueltan {quest:5537}.",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "Usa el {item:12627} junto a los silos de grano para hacer salir Parásitos temporales. {quest:5154} es uno de los tomos mohosos del ayuntamiento. Todos los esqueletos del pueblo sueltan {quest:5537}.\nCuidado: los Parásitos temporales son de nivel 55-57, y Señores de la guerra esqueléticos y Gólems de carne (57, élites) recorren las calles: haz salir a los parásitos junto a los silos, de uno en uno, y deja pasar a los élites.",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass.\n{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "Usa el {item:12627} junto a los silos de grano para hacer salir parásitos temporales. {quest:5154} es uno de los tomos mohosos del ayuntamiento. Todos los esqueletos del pueblo sueltan {quest:5537}.\nCuidado: los parásitos temporales son de nivel 55-57, y los señores de la guerra esqueléticos y los gólems de carne (57, élites) recorren las calles: haz salir a los parásitos junto a los silos, de uno en uno, y deja pasar a los élites.\n{npc:1852} es élite: se recomienda ir en grupo. Custodia su filacteria en el centro de Andorhal.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Usa la {item:12815} al pie de cada una de las cuatro atalayas en el borde de Andorhal, al norte del campamento.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Usa la {item:12815} al pie de cada una de las cuatro atalayas del borde de Andorhal, al norte del campamento.\nCuidado: Señores de la guerra esqueléticos y Gólems de carne (57, élites) recorren las calles de Andorhal, y el {npc:7572} (59, élite) deambula entre Andorhal y Cresta Norte: quédate en las torres del borde del pueblo y déjalos pasar.",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Entra en {area:1769} y toma el ramal del túnel hacia {area:493} hasta {area:2361}.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entra en {area:1769} y toma el ramal del túnel hacia {zone:1450} hasta {area:2361}.",
	-- ["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Al oeste por el sur del cráter: hay Huesos de dinosaurio en el suelo al suroeste, entre los estegodones: son élite, recoge los huesos a su alrededor y consigue el resto de los Diemetradones. El {item:11112} de la expedición está en la jungla del suroeste.",
	-- ["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Al oeste por el sur del cráter: la colmena Gorishi lo llena. Usa el Vial raspador en una sala de cría, una cámara con larvas colgando.",
	-- ["Western Pylon"] = "Pilón del Oeste",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "No hiciste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",
	-- ["Zapped giants and sea elementals"] = "Gigantes encogidos y elementales de mar",
	-- ["grind on {npc:11740}"] = "farmea {npc:11740}",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "mata {npc:1796} en {area:202}, {zone:1422}",
	-- ["their trainers are in {zone:1457} too"] = "sus instructores también están en {zone:1457}",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: mata a estos según te los encuentres",
	-- ["{area:1942}: kill these as you meet them"] = "{area:1942}: mata a estos según te los encuentres",
	-- ["{area:1943}: kill these as you meet them"] = "{area:1943}: mata a estos según te los encuentres",
	-- ["{area:200} cauldron"] = "Caldero de {area:200}",
	-- ["{area:201} cauldron"] = "Caldero de {area:201}",
	-- ["{area:348} flight master"] = "Maestro de vuelo de {area:348}",
	-- ["{area:392} flight master"] = "Maestro de vuelo de {area:392}",
	-- ["{area:442} flight master"] = "Maestro de vuelo de {area:442}",
	-- ["{area:489} flight master"] = "Maestro de vuelo de {area:489}",
	-- ["{area:538}: kill these as you meet them"] = "{area:538}: mata a estos según te los encuentres",
	-- ["{area:976} flight master"] = "Maestro de vuelo de {area:976}",
	-- ["{item:11478}; below ground"] = "{item:11478}; bajo tierra",
	-- ["{item:11479}; below ground"] = "{item:11479}; bajo tierra",
	-- ["{item:11480}; below ground"] = "{item:11480}; bajo tierra",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} está en el ayuntamiento de {area:190}, al oeste de {npc:1855}: los guardias Escarlata están muy juntos.",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} está al este del granero de {area:201}.",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}, de {npc:11056}",
	-- ["{item:14613}, from {npc:11886} (57, elite): grouping up is advised"] = "{item:14613}, de {npc:11886} (57, élite): se recomienda agruparse",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: su escolta viene más adelante en la ruta",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} espera en la posada en ruinas del lado oeste de Andorhal.",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} está junto a la granja de {area:202}, al noreste de los campos.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "El fantasma de {npc:10778} vaga junto a la granja de {area:199}, al oeste de {area:200}; su paquete está adentro.",
	-- ["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} y {npc:7740} están junto al Templo de la Luna; llena el {item:11682} en el pozo de la luna de adentro.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path now; the {zone:2482} guide flies to {area:493}, and the {zone:1451} guide comes back here."] = "{npc:10897}, el maestro de vuelo de {area:493}, está al sur del lago, fuera de {area:2361}: aprende la ruta de vuelo ahora; la guía de {zone:2482} vuela a {area:493}, y la guía de {zone:1451} vuelve aquí.",
	-- ["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "La granja de {npc:10927} está en la colina al este del campamento; el monumento de {npc:10936} está justo al norte.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, junto a las tumbas al sur de la capilla",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} vigila el caldero de {area:199}, al oeste de Andorhal.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} está junto a la choza de Augustus en {area:2627}.",
	-- ["{npc:11610}'s next task, {npc:11613} and {npc:11611}, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "La siguiente tarea de {npc:11610}, {npc:11613} y {npc:11611}, espera al tramo de las Tierras de la Peste de la guía de {zone:1451}: tómala entonces.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} recorre el Aserradero Crestanorte al este de {npc:11610}; {npc:11611} vigila la torre en el acceso sur de {area:190}.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} recorre el campamento de Crestanorte al este de {npc:11610}; {npc:11611} vigila la torre del acceso sur a {area:190}.\nCuidado: Hay guardias en la base de la torre y uno más da vueltas a su alrededor patrullando. Despéjalos antes de enfrentar a Durgen para que no se sumen.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: las termitas vienen después, en {area:2627}",
	-- ["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} recorre esta zona: busca dentro del círculo del mapa",
	-- ["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} es élite: se recomienda ir en grupo",
	-- ["{npc:12384} lives in the ruined hut in {area:2627}, and his receipt book lies in the ruined inn nearby. {npc:11140} stands by {npc:12384}' hut."] = "{npc:12384} vive en la choza en ruinas de {area:2627}, y su libro de recibos está en la posada en ruinas cercana. {npc:11140} está junto a la choza de {npc:12384}.",
	-- ["{npc:15189}'s and {npc:15191}'s next tasks (the Stonelash scorpids and the Dredge Crushers) wait for the {zone:1451} guide's {area:3425} stop: take them then."] = "Las siguientes tareas de {npc:15189} y {npc:15191} (los escórpidos Latigazo de piedra y los Trituradores deslizantes) esperan a la parada en {area:3425} de la guía de {zone:1451}: acéptalas entonces.",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: la guía anterior te vincula aquí, así que esto suele marcarse de inmediato",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, en las tiendas de la Alianza",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} es élite: se recomienda ir en grupo. Vigila su filacteria en el centro de Andorhal.",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852} es élite: se recomienda agruparse. Vigila su filacteria en el centro de Andorhal.\nHay cajas fuertes pequeñas entre los escombros por todo Andorhal; cada una tiene un reloj.\nCuidado: Suele haber necrófagos y esqueletos junto a las cajas, que atacan cuando te acercas. Los necrófagos abrasadores además dañan a quien esté cerca y rompen el sigilo.",
	-- ["{npc:5411} in {area:976}: keep it"] = "{npc:5411} en {area:976}: guárdala",
	-- ["{npc:5594}, inside"] = "{npc:5594}, adentro",
	-- ["{npc:5901}, on the coast north of town"] = "{npc:5901}, en la costa al norte del pueblo",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: guárdala para {area:976}",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "El campamento de {npc:7775} está al norte de {area:1119}. Prepara el {item:11243} a partir de una {item:11242}: acepta su encargo para conseguir una.",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "El campamento de {npc:7775} está al norte de {area:1119}. Vende el {item:11243} una vez que tiene su cebo.",
	-- ["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "{npc:7876}, lado norte del pueblo: el alquitrán está en Un'Goro, guárdala",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: guárdala para {area:440}",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: guárdala para {zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: guárdala para el Cráter de Un'Goro",
	-- ["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}: guárdala para Un'Goro; adentro",
	-- ["{npc:8598}, 170 yd north-east"] = "{npc:8598}, 170 m al noreste",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}, en {area:1658}",
	-- ["{npc:9117}, below ground"] = "{npc:9117}, bajo tierra",
	-- ["{npc:9299} in {area:976}: keep it"] = "{npc:9299} en {area:976}: guárdala",
	-- ["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} es un fantasma en el cementerio justo al este del pueblo: bebe un {item:11243} allí, lo cual te mata, libera tu espíritu y habla con él como fantasma. Luego corre de vuelta a tu cuerpo para revivir: la lápida está cerca.",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} espera en el cementerio justo al este del pueblo; la lápida está cerca.",
	-- ["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} acampa al pie de la rampa de entrada al cráter.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "La guarida de {npc:9684} está en la jungla al norte de {npc:9619}, bajo los acantilados del este: usa {item:11568} allí. {npc:9684} es de nivel 56: empieza con la salud completa.",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado en la ladera sureste de {area:537}, en medio del cráter.",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}, en la granja",
	-- ["{object:177667}, below ground"] = "{object:177667}, bajo tierra",
	-- ["{object:179565}; inside"] = "{object:179565}; adentro",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} está en {area:392}",
	-- ["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, si aún la llevas de la primera visita",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} en {area:493}: guárdala",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} en {zone:1450}: guárdala",
	-- ["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, si un ravasaurio soltó la escama desde la primera visita",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}: mata a estos según te los encuentres",
	-- ["{zone:1451}: kill these as you meet them"] = "{zone:1451}: mata a estos según te los encuentres",
	-- ["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, donde entrena la siguiente guía, no tiene instructor de druidas",
}
