-- Spanish (Latin America) (esMX): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "Theramore",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} está cerca de la posada; {npc:4897}, una proveedora de comercio a pocos pasos al sur, vende las especias que quiere Jarl.",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para \"Ojolodo\" Jarl",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Sigue el camino al noroeste desde Theramore hasta la atalaya de {area:503}. Los hurgadores Fangorroca deambulan por el pantano a su alrededor.",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "De vuelta en Theramore: Tervosh espera con Lady Jaina en la torre de {area:514}.",

	-- Step 4: Swamplight Manor
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Toma el camino al norte hasta la mansión en ruinas; Jarl vive en la choza de al lado y la tierra removida está en la esquina de la casa.",
	["with the spices from Theramore"] = "con las especias de Theramore",

	-- Step 5: Mudrock tortoises
	["Mudrock tortoises"] = "Tortugas Fangorroca",
	-- plural, as words: Mudrock Tortoises = {npc:4396} Mudrock Tortoise
	["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Las tortugas y caparapicos Fangorroca toman el sol en la orilla al noreste de la mansión.",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "\"Apestoso\" Ignatz",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Apestoso espera al oeste de la mansión, en el pantano bajo {area:504}. Llévalo hasta sus hojas de frijol de pantano y mantén a las criaturas del pantano lejos de él.",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} ocupa la torre con unos cuantos desertores. Se vuelve contra ti: golpéalo hasta que se rinda.",

	-- Step 8: Darkmist Cavern
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Las arañas Niebla Negra anidan alrededor de la Cueva Niebla Negra, en el noroeste del pantano; todas las arañas sueltan ojos.",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "Cabalga al sur hasta la choza del gigante en medio del pantano.",

	-- Step 10: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "La posada quemada está en el camino al oeste, hacia {zone:1413}; la insignia del guardia está entre las cenizas y las huellas de cascos, en el barro junto a la posada.",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Sigue el camino al este de vuelta a Theramore. Tervosh, Lady Jaina y los oficiales están en la torre y en {area:514}.",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Múrlocs Ancalodo",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Los múrlocs Ancalodo llenan la costa norte pasada {area:497}; termina las lenguas con las tortugas de al lado.",

	-- Step 13: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "solo si llevas una {item:3853} (una creación de herrero)",

	-- Step 15: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Los desertores acampan al sur del camino, al oeste de la choza de {npc:4503}.",

	-- Step 17: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "De camino al norte a {area:392}, {area:720} está frente a {area:391}, al sur del pueblo: cruza vadeando los bajíos del banco de arena. {npc:6236} te envía cuatro retadores y luego a {npc:6238} (nivel 33), de uno en uno.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Derrota a los retadores y a {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236} ofrece después El Vigía del viento (1791): la cadena del arma de Torbellino, con un élite al final, está en la guía de clase de guerrero Arma Torbellino.",

	-- Step 18: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:16227} Bragok · {area:35} Booty Bay
	["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Cabalga desde Theramore al oeste por el camino de Revolcafango hacia {zone:1413} y al norte hasta {area:392}, en la costa. Consigue la ruta de vuelo con {npc:16227} y luego toma el barco a {area:35} en el muelle.",
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",

	-- Step 19: Booty Bay
	-- {object:56910} The Salty Sailor Tavern
	["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} es el edificio alto sobre el puerto; la mayoría de los asignadores de misiones están en sus pisos o en los muelles de abajo.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it"] = "para Stoley en {zone:1446}: guárdalo",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: para {quest:2864} en {zone:1446}, guárdalo",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "para {npc:770} en {area:99}, en el circuito norte",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, piso superior",
	["Seahorn's next errand goes back to Arathi: skip it."] = "El siguiente encargo de Seahorn vuelve a Arathi: omítelo.",

	-- Step 20: Bloodsail camp
	["Bloodsail camp"] = "Campamento Velasangre",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "Sal del pueblo por el túnel y sigue la costa al norte; la carta está en el campamento Velasangre de la playa, donde camina \"El Guapo\" Duncan.",

	-- Step 21: Booty Bay
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} nada frente a la costa noroeste, en el circuito norte",

	-- Step 22: Bloodsail pirates
	["Bloodsail pirates"] = "Piratas Velasangre",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "Todos los Velasangre sueltan tabaco rapé y uno de ellos lleva el ojo de {npc:2493}; los espadachines recorren la orilla justo al norte del pueblo. Las cartas y las órdenes están en el campamento pirata de {area:43}, al sur de {area:35}.",

	-- Step 24: The Bloodsail captains
	["The Bloodsail captains"] = "Los capitanes Velasangre",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Los capitanes están en los barcos anclados frente a {area:43}, cada uno con una tripulación de piratas de nivel 42-45: Aguasmansas (45) y Sinquilla (46) en las cubiertas más cercanas, {npc:2546} (48) en el buque insignia. A nivel 42 es una pelea para un grupo o para el final de la guía; si vas, limpia antes cada cubierta. El pergamino de Cortello está en el naufragio junto a la orilla.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "para {zone:1435}, más adelante",

	-- Step 26: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Expedicionarios naga",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Los nagas recorren las playas al norte del campamento Velasangre; sueltan los juncos.",

	-- Step 27: Gorilla hills
	["Gorilla hills"] = "Colinas de los gorilas",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Cabalga tierra adentro hasta las colinas de gorilas del Valle del Velo de Bruma. Los gorilas Velo de Bruma ancianos sueltan las menudencias; {npc:1449} está sentado entre ellos.",

	-- Step 28: Unbagwa's ritual
	["Unbagwa's ritual"] = "El ritual de Unbagwa",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Entrega los colmillos y quédate: llegan tres oleadas de gorilas, {npc:1514} al final. Pelea con la salud completa.",

	-- Step 29: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "Cabalga de vuelta al pueblo; el Trémulo está en la boca del túnel.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "para {npc:2616} en Theramore: guárdalo",

	-- Step 30: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} y {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Cabalga al norte hasta las colinas al oeste del camino. {npc:2535} y {npc:2536} están juntos justo al norte del poblado de Zanzil.",

	-- Step 31: Zanzil's village
	["Zanzil's village"] = "Poblado de Zanzil",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Cualquier seguidor de Zanzil puede soltar la mezcla; {npc:2537} recorre el sur del campamento.",

	-- Step 32: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Sigue el camino al noreste hasta el campamento de Ventura y Cía. en {area:310}; los canteros, peritos y supervisores sueltan los cristales.",

	-- Step 33: Skullsplitter ruins
	["Skullsplitter ruins"] = "Ruinas Machacacráneos",
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Los trols Machacacráneos ocupan las ruinas justo al este de la mina; cualquiera de ellos puede soltar colmillos, y sus panteras siempre lo hacen.",

	-- Step 34: Cold Eye Basilisks
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Cold Eye Basilisks"] = "Basiliscos Ojogélido",
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Los basiliscos Ojogélido descansan en las rocas al oeste de la mina.",

	-- Step 35: The north-west coast
	["The north-west coast"] = "La costa noroeste",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Cabalga al noroeste desde la mina hasta la bahía de la costa noroeste. Las almejas gigantes ({object:2744}) están en su fondo y guardan las perlas; {npc:2624} nada entre ellas y suelta {item:4034}.",

	-- Step 36: Rebel Camp
	-- {npc:217588} Arbor Tarantula
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Cabalga al noreste pasando el campamento de Nesingwary y sigue el camino al norte hasta el campamento en lo alto de la vega. Por el camino, una {npc:217588} se arrastra por la jungla al sureste del campamento de Nesingwary: atrapa una con el Entomology Starter Kit y luego márcala.",
	-- {npc:217588} Arbor Tarantula · {quest:93176} My Little Friends
	["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: atrápala, para {quest:93176}",

	-- Step 37: Booty Bay
	["MacKinley's next task sends you after elite ogres: skip it."] = "La siguiente tarea de MacKinley te envía tras ogros élite: omítela.",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "El siguiente encargo de {npc:2498} sobre Zanzil empieza en {zone:1441}: omítelo.",

	-- Step 38: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} cocina en {object:2169}; {npc:5384} está en {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {area:1438} Nethergarde Keep
	["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: para {area:1438}, guárdalo",
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, en la Biblioteca Real de {object:2117}",

	-- Step 39: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4732} enseña a los humanos en {area:88}, en el este de {zone:1429}, junto a los caballos de {npc:384}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar). Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: otros colores, 20g",

	-- Step 40: Riding at 40
	-- {spell:1285849} Galestrider Riding · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {zone:1453} Stormwind · {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. No se conoce ningún instructor de equitación Cielonato; el cliente de Forever incluye {spell:1285849} en la única habilidad de Equitación, así que {npc:4732} en {area:88}, en el este de {zone:1429}, el instructor más cercano a {zone:1453}, debería enseñarla (sin confirmar). Los Zancavientos los vende {npc:265756} en {area:16638}, en la Isla Zephras; Coleccionables, Monturas · Nivel 40 los incluye.",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Zancavientos: {npc:265756}, en {area:16638}, en la Isla Zephras.",

	-- Step 41: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4753} enseña a los elfos de la noche en {zone:1457}, junto a los sables de {npc:4730}: el barco de {area:17203} a {area:442} y luego el vuelo a {area:702}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar), como {npc:4732} en {area:88}, en {zone:1429}. Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: otros colores, 20g",

	-- Step 42: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Paladín: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, en la Catedral de la Luz",

	-- Step 43: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Brujo: {quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, en {object:2164}: {npc:6251} en {area:392} la recibe al final de la siguiente guía",

	-- Step 44: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:5476} Watcher Biggs
	["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Vuela a {area:42} y cabalga al este por {zone:1430} hasta {zone:1435}; {npc:5476} está junto al camino, justo pasada la frontera.",

	-- Step 45: A Soggy Scroll
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "El pergamino está en el pantano al norte de Biggs. Los caminalodos al norte de él pueden soltar los ensayos de Khadgar.",
	["The riddle's next scroll lies in western Dustwallow: skip it."] = "El siguiente pergamino del enigma está en el oeste de Revolcafango: omítelo.",

	-- Step 46: The sunken temple
	["The sunken temple"] = "El templo sumergido",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Cabalga al este; los horrores enredados del camino también sueltan los ensayos. Busca en el borde de {area:74}, donde las ruinas del templo asoman del agua.",

	-- Step 47: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "La madera a la deriva llega a lo largo de la orilla este.",

	-- Step 48: Watcher Biggs
	-- {npc:217412} Amaryllis Webb
	["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Cabalga de vuelta al oeste por el camino; {npc:217412} está un poco al norte de Biggs.",
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "para {area:1438}: guárdalo",
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, de 30-40/05-arathi-highlands",

	-- Step 49: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "para {npc:5635} en {area:348}: guárdalo",

	-- Step 50: Ironforge
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:1356} Prospector Stormpike · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern · {area:144} Thelsamar
	["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "Toma el {area:2257} desde {object:28027}. {npc:5637} está en la sala de los Reclamadores junto a {object:32356}, {npc:1356} en la propia sala, {npc:2786} en {object:32383}. La siguiente guía sigue volando a {area:144}.",
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: para {npc:1344} en {zone:1432}, guárdalo",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} no tiene instructor de chamanes",

	-- Step 51: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4772} enseña a los enanos en {area:803}, al este de {area:131}, en el camino a {zone:1432}, junto a los carneros de {npc:1261}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar). Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: otros colores, 20g",

	-- Step 52: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:7954} enseña a los gnomos en {area:189}, justo al este de {area:131}, junto a los mecazancudos de {npc:7955}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar). Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: otros colores, 20g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Klannoc ofrece después El Vigía del viento (1791): la cadena del arma de {spell:1680}, con un élite al final, está en la guía de clase de guerrero Arma Torbellino.",
}
