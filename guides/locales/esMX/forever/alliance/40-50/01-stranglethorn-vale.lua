-- Spanish (Latin America) (esMX): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "{quest:1260}, adentro",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "{npc:4964}, en el piso de arriba de {area:514}",
	-- {npc:271167} Guard Jameson · {quest:98233} Sword in the Slime
	["{npc:271167}: {quest:98233}, from the oozes on the way back east"] = "{npc:271167}: {quest:98233}, de los mocos de camino de vuelta al este",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para \"Ojolodo\" Jarl",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point · {npc:4967} Archmage Tervosh
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\n{npc:4967} waits at the foot of the tower: once you have looked around, hand the quest in to him there, not in Theramore."] = "Sigue el camino al noroeste desde Theramore hasta la atalaya de {area:503}. Los hurgadores Fangorroca deambulan por el pantano a su alrededor.\n{npc:4967} espera al pie de la torre: cuando hayas echado un vistazo, entrégale la misión ahí mismo, no en Theramore.",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the tower"] = "{npc:4967}, en la torre",

	-- Step 3: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "Toma el camino al norte hasta la mansión en ruinas; Jarl vive en la choza de al lado y la tierra suelta está en la esquina de la casa. Jarl quiere tres {quest:1218}: si pasaste por {npc:4897}, cómpraselas primero en Theramore.",
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["{quest:1218}: {npc:4897} in Theramore, if you left without them"] = "{quest:1218}: {npc:4897} en Isla Theramore, si te fuiste sin ellas",
	["with the spices from Theramore"] = "con las especias de Theramore",

	-- Step 4: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "\"Apestoso\" Ignatz",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Apestoso espera al oeste de la mansión, en el pantano bajo {area:504}. Llévalo hasta sus hojas de frijol de pantano y mantén a las criaturas del pantano lejos de él.",

	-- Step 5: North Point Tower
	-- {npc:4966} Private Hendel · {npc:4967} Archmage Tervosh · {npc:4968} Lady Jaina Proudmoore
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders.\n{npc:4967} and {npc:4968} wait beside the tower: once he yields, hand in to both on the spot."] = "{npc:4966} ocupa la torre con unos cuantos desertores. Se vuelve contra ti: golpéalo hasta que se rinda.\nCuidado: Hendel tiene dos guardias que se unen a la pelea cuando se vuelve hostil. Los guardias huyen en cuanto él se rinde.\n{npc:4967} y {npc:4968} esperan junto a la torre: cuando se rinda, entrega a ambos ahí mismo.",

	-- Step 6: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Las arañas Niebla Negra anidan alrededor de la cueva del noroeste del pantano; todas las arañas sueltan ojos.\nCuidado: Los acechadores Niebla Negra se mueven en sigilo y usan veneno en combate. Las arañas están muy juntas, así que es común atraer de más; atraer objetivos sueltos desde el borde exterior lo reduce.",

	-- Step 7: Mudcrush Durtfeet
	["Head south to the giant's hut in the middle of the marsh."] = "Ve al sur hasta la choza del gigante en medio del pantano.",

	-- Step 8: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes."] = "La posada quemada está en el camino al oeste, hacia {zone:1413}; la insignia del guardia está entre las cenizas.",

	-- Step 9: Corrosive Swamp Oozes
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze
	["Corrosive Swamp Oozes"] = "Mocos corrosivos del pantano",
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze · Elder Daggermaws = {npc:272384} Elder Daggermaw · Bubbling Swamp Oozes = {npc:4394} Bubbling Swamp Ooze
	["On the way back east, the Corrosive Swamp Oozes (38-40) creep through the marsh south of the road, between the middle of the marsh and Theramore: one of them carries Jameson's training sword. Careful: Elder Daggermaws (48-49) lurk in the water among them, and the larger Bubbling Swamp Oozes (39-40) are elite: leave both alone."] = "De vuelta al este, los mocos corrosivos del pantano (38-40) se arrastran por el pantano al sur del camino, entre el centro del pantano e Isla Theramore: uno lleva la espada de entrenamiento de Jameson. Cuidado: los bocadagas ancianos (48-49) acechan en el agua entre ellos, y los mocos de pantano burbujeantes, más grandes (39-40), son élite: evita a ambos.",

	-- Step 10: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. The officers are in {area:514}."] = "Sigue el camino al este de vuelta a Theramore. Los oficiales están en {area:514}.",
	["On the top floor"] = "En el piso superior",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "{npc:4948}, en el piso de arriba",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, adentro",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "{npc:4794}: los reptadores están en la orilla de {zone:1435}, guárdala",

	-- Step 11: Mirefin murlocs
	["Mirefin murlocs"] = "Múrlocs Ancalodo",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}."] = "Los múrlocs Ancalodo llenan la costa norte pasada {area:497}.",

	-- Step 12: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "solo si llevas una {item:3853} (una creación de herrero)",

	-- Step 14: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Los desertores acampan al sur del camino, al oeste de la choza de {npc:4503}.",

	-- Step 16: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the way north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "De camino al norte a {area:392}, {area:720} está frente a {area:391}, al sur del pueblo: cruza vadeando los bajíos del banco de arena. {npc:6236} te envía cuatro retadores y luego a {npc:6238} (nivel 33), de uno en uno.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Derrota a los retadores y a {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236} ofrece después El Vigía del viento (1791): la cadena del arma de Torbellino, con un élite al final, está en la guía de clase de guerrero Arma Torbellino.",

	-- Step 17: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "El barco sale de Theramore: preséntate ante {npc:4944}, en el piso de arriba de {area:514}, de camino a los muelles.",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, en el piso de arriba",

	-- Step 18: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",

	-- Step 19: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maestro de vuelo de {area:150}",

	-- Step 21: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4732} enseña a los humanos en {area:88}, en el este de {zone:1429}, junto a los caballos de {npc:384}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar). Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: otros colores, 20g",

	-- Step 22: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y aprenderlo te da una montura. Los Celestes lo aprenden con {npc:265756}, el maestro de establos e instructor de equitación de {area:17684} en {area:16638}, en la isla Zephras, que también vende los zancavientos: el barco celeste a la isla sale del lado norte de {area:279} más o menos cada cinco minutos. Coleccionables, Monturas · Nivel 40 muestra los zancavientos.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Montar y Galestriders: {npc:265756}, en {area:17684}, en {area:16638}, en la Isla Zephras.",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "Barco celeste a la isla Zephras: el lado norte de {area:279}, más o menos cada cinco minutos.",

	-- Step 23: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {area:35} Booty Bay
	["Head north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "Ve al noroeste hacia {zone:1413} y sube por la costa hasta {area:392}: el barco a {area:35} sale de su muelle, y el maestro de grifos de {area:392} está justo arriba.",

	-- Step 24: Boat to Booty Bay
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["Level 40 with 100 gold later on? {npc:4732} teaches riding at {area:88} in {zone:1429}: Collectibles, Mounts · Level 40 has the trip."] = "¿Nivel 40 y 100 de oro más adelante? {npc:4732} enseña equitación en {area:88}, en {zone:1429}: Coleccionables, Monturas · Nivel 40 tiene el viaje.",

	-- Step 26: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "Maestro de vuelo de {area:42}",

	-- Step 27: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, en el piso de arriba",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "para {npc:770} en {area:99}, en el circuito norte",
	-- {npc:2494} Privateer Bloads · {area:35} Booty Bay
	["{npc:2494}: keep it, its naga (43-44) wait for the level-48 {area:35} stop"] = "{npc:2494}: guárdala, sus nagas (43-44) esperan a la parada de nivel 48 en {area:35}",
	-- {npc:2487} Fleet Master Seahorn · {quest:669} Sunken Treasure · {area:327} Faldir's Cove
	["{npc:2487}, top floor: {quest:669}, if you did {area:327} with a group"] = "{npc:2487}, último piso: {quest:669}, si hiciste {area:327} en grupo",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "{npc:737}, arriba: los trols Machacacráneos, en el circuito del norte",
	-- {npc:2498} Crank Fizzlebub · {area:35} Booty Bay
	["{npc:2498}, inside: keep it, Zanzil's village (43-44) waits for the level-48 {area:35} stop"] = "{npc:2498}, adentro: guárdala, la aldea de Zanzil (43-44) espera a la parada de nivel 48 en {area:35}",
	["Seahorn's next errand goes back to Arathi: skip it."] = "El siguiente encargo de Seahorn vuelve a Arathi: omítelo.",
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "{npc:2542}, arriba",
	["Upstairs"] = "Arriba",

	-- Step 28: Bloodsail camp
	["Bloodsail camp"] = "Campamento Velasangre",
	-- plural, as words: Bloodsail Mages = {npc:1562} Bloodsail Mage
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks.\nCareful: the Bloodsail Mages and Warlocks here are level 40-43 and cast from range: pull one at a time and fight with your back to the open beach."] = "Sal del pueblo por el túnel y sigue la costa al norte; la carta está en el campamento Velasangre de la playa, donde camina \"El Guapo\" Duncan.\nCuidado: los magos y brujos Velasangre de aquí son de nivel 40-43 y lanzan hechizos a distancia: atráelos de uno en uno y pelea de espaldas a la playa abierta.",

	-- Step 29: Booty Bay
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["keep it: the {area:43} camp's charts and Swashbucklers (41-43) wait for the level-48 {area:35} stop"] = "guárdala: las cartas de navegación y los espadachines (41-43) del campamento de {area:43} esperan a la parada de nivel 48 en {area:35}",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, en el piso superior",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} nada frente a la costa noroeste, en el circuito norte",

	-- Step 30: Bloodsail pirates: kill these as you meet them
	["Bloodsail pirates: kill these as you meet them"] = "Piratas Velasangre: mata a estos según te los encuentres",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit."] = "Todos los Velasangre sueltan rapé y uno de ellos lleva el ojo de {npc:2493}: consíguelos de los asaltantes y magos (39-41) del campamento Velasangre de la playa, justo al norte del pueblo, donde encontraste la carta. Deja el campamento de {area:43}, al sur del pueblo (brujos y espadachines 41-43), para la visita de nivel 48.",

	-- Step 31: Booty Bay
	-- {npc:2486} Fin Fizracket · {npc:1514} Mokk the Savage · {area:35} Booty Bay
	["{npc:2486}'s Stranglethorn Fever ({npc:1514}) waits for the level-48 {area:35} stop: leave it for now."] = "La Fiebre de Tuercespina de {npc:2486} ({npc:1514}) espera a la parada de nivel 48 en {area:35}: déjala por ahora.",
	-- {area:35} Booty Bay · {area:43} Wild Shore
	["Seahorn's Bloodsail Buccaneers: keep it for the level-48 {area:35} stop, with the {area:43} camp."] = "Bucaneros Velasangre de Seahorn: guárdala para la parada de nivel 48 en {area:35}, junto con el campamento de {area:43}.",

	-- Step 32: Booty Bay
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "No hiciste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",

	-- Step 33: Gorilla hills
	["Gorilla hills"] = "Colinas de los gorilas",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Head inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets."] = "Ve tierra adentro hasta las colinas de gorilas del Valle del Velo de Bruma. Los gorilas Velo de Bruma ancianos sueltan las menudencias.",

	-- Step 34: Booty Bay
	["Head back down to town; Shaky stands at the tunnel mouth."] = "Vuelve al pueblo; el Trémulo está en la boca del túnel.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it; on the top floor"] = "para Stoley en {zone:1446}: guárdala; en el piso de arriba",
	-- {area:35} Booty Bay
	["\"Sea Wolf\" MacKinley: keep it, for the level-48 {area:35} stop, with Zanzil's village"] = "\"Lobo de Mar\" MacKinley: guárdala para la parada de nivel 48 en {area:35}, junto con el poblado de Zanzil",

	-- Step 35: Cortello's scroll
	["Cortello's scroll"] = "El pergamino de Cortello",
	-- {area:35} Booty Bay
	["Optional: Cortello's scroll lies inside one of the three Bloodsail ships anchored off the coast just south of {area:35}, on a middle or lower deck, and is not always on the same ship. Their crews are 42-45 pirates: clear your way from the edge, one at a time, and leave the captains (45-48), whom the route comes back for at 48."] = "Opcional: el pergamino de Cortello está dentro de uno de los tres barcos Velasangre anclados frente a la costa, justo al sur de {area:35}, en una cubierta media o inferior, y no siempre en el mismo barco. Sus tripulaciones son piratas de nivel 42-45: ábrete paso desde el borde, uno a uno, y deja a los capitanes (45-48), a quienes la ruta vuelve a buscar a nivel 48.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "para {zone:1435}, más adelante",

	-- Step 36: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Acechadores de la selva",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "Los acechadores de la selva recorren las laderas al oeste de la mina.",

	-- Step 37: Zul'Mamwe's Mystics and the Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Zul'Mamwe's Mystics and the Shadowmaw Panthers"] = "Los místicos de Zul'Mamwe y las panteras Faucesombría",
	-- {npc:739} Brother Nimetz
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["East from the stalkers' slopes to the ruins of Zul'Mamwe: the Skullsplitter Mystics (39-40) in its northern half carry {npc:739}'s fetishes. Careful: the Witch Doctors, Berserkers and Headhunters (41-44) hold the ruins' southern half: stay north. Then north-west toward the coast: the Shadowmaw Panthers (37-38) prowl the jungle west of the ruins, often stealthed."] = "Al este de las laderas de los acechadores, hasta las ruinas de Zul'Mamwe: los místicos Machacacráneos (39-40) de su mitad norte llevan los fetiches de {npc:739}. Cuidado: los médicos brujos, rabiosos y cazacabezas (41-44) ocupan la mitad sur de las ruinas: quédate al norte. Luego ve al noroeste hacia la costa: las panteras Faucesombría (37-38) merodean por la selva al oeste de las ruinas, a menudo en sigilo.",
	-- {item:2466} Skullsplitter Fetish
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic
	["{item:2466}, from the Skullsplitter Mystics"] = "{item:2466}, de los místicos Machacacráneos",

	-- Step 38: The north-west coast
	["The north-west coast"] = "La costa noroeste",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Go on north-west to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Sigue al noroeste hasta la bahía de la costa noroeste. Las almejas gigantes están en su fondo y guardan las perlas; {npc:2624} nada entre ellas y suelta {item:4034}.",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "{item:4611}; bajo el agua",

	-- Step 39: Sin'Dall
	-- {npc:729} Sin'Dall
	["North-east from the bay toward Nesingwary's camp: {npc:729}, the great tiger (37), lairs on the hilltop just south-west of the camp."] = "Al noreste de la bahía, hacia el campamento de Nesingwary: {npc:729}, el gran tigre (37), tiene su guarida en la cima de la colina justo al suroeste del campamento.",

	-- Step 40: Hemet Nesingwary
	-- {npc:718} Sir S. J. Erlgadin
	["{npc:718}, beside him"] = "{npc:718}, a su lado",
	-- {npc:717} Ajeck Rouack
	["{npc:717}, beside them"] = "{npc:717}, a su lado",

	-- Step 43: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Una {npc:217588} anda por la jungla al sureste del campamento de Nesingwary, de camino a {area:99}: atrapa una con la herramienta de {item:213565} de {npc:217412}.",

	-- Step 44: Rebel Camp
	["Head north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "Ve al noreste pasando el campamento de Nesingwary y sigue el camino al norte hasta el campamento de lo alto de la vega.",

	-- Step 45: Brother Nimetz
	-- {npc:739} Brother Nimetz · {area:301} Savage Coast · {npc:2277} Loremaster Dibbs · {area:271} Southshore · {zone:1418} Badlands · {zone:1425} Hinterlands
	["{npc:739}: the {area:301} report bundle for {npc:2277} in {area:271}, on the {zone:1418} & {zone:1425} guide: keep it"] = "{npc:739}: el paquete de informes de {area:301} para {npc:2277} en {area:271}, en la Guía de {zone:1418} y {zone:1425}: guárdalo",

	-- Step 46: Kurzen's Compound
	-- {area:99} Rebel Camp · {area:101} Kurzen's Compound · {npc:218230} Wendel Mathers · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Subchiefs = {npc:978} Kurzen Subchief
	["East from the {area:99} to {area:101}: {npc:218230} is caged at its western edge. The Kurzen Subchiefs (35-36) and Elites (36-37) carry his cage key; the fighter's uniform lies in a supply crate in the compound's eastern part.\nCareful: {npc:813}, an elite of 39-40, stands at the compound's north end beside three of the Subchiefs: take the key from the Subchiefs and Elites further south and leave him be."] = "Al este de {area:99} hasta {area:101}: {npc:218230} está enjaulado en su borde oeste. Los subjefes de Kurzen (35-36) y los élites (36-37) llevan la llave de su jaula; el uniforme de luchador está en una caja de suministros en la parte este de la base.\nCuidado: {npc:813}, un élite de nivel 39-40, está en el extremo norte de la base junto a tres de los subjefes: consigue la llave de los subjefes y élites más al sur y déjalo en paz.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage, if you didn't take it on the 30-40 loop"] = "{npc:218230}, en su jaula, si no la aceptaste en el circuito 30-40",
	-- {item:216616} Compound Cage Key
	["{item:216616}, from the Subchiefs (or the Elites)"] = "{item:216616}, de los subjefes (o de los élites)",
	-- {item:216617} Kurzen Fighter's Uniform
	["{item:216617}, in the supply crate"] = "{item:216617}, en la caja de suministros",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, back at his cage on the way out"] = "{npc:218230}, de vuelta en su jaula al salir",
	-- {npc:218229} Captain Aransas · {area:35} Booty Bay
	["For {npc:218229} in {area:35}, at the end of the jungle loop"] = "Para {npc:218229} en {area:35}, al final del circuito por la selva",

	-- Step 47: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:728} es élite de nivel 40: la mayoría de las clases lo hacen solas a nivel 42, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",

	-- Step 48: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "{area:103}: mata a estos según te los encuentres",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Los trols Machacacráneos ocupan las ruinas justo al este de la mina; cualquiera puede soltar colmillos, y sus panteras siempre los sueltan.\nSigue el camino al noreste hasta el campamento de Ventura y Cía. en {area:310}; los mineros, agrimensores y capataces sueltan los cristales.\nCuidado: Las panteras Faucesombría y las tigresas de Tuercespina recorren en sigilo la zona alrededor del campamento.",

	-- Step 49: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:730} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",

	-- Step 53: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:731} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.\nCuidado: Tigres y panteras Fauceumbría en sigilo rondan cerca de él. Despéjalos antes de atraerlo. Cuando lo atraes, {npc:731} pide ayuda a las criaturas en 20 m.",

	-- Step 55: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road south to {area:35}."] = "Sigue el camino al sur hasta {area:35}.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: para {quest:2864} en {zone:1446}, guárdalo",

	-- Step 56: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 57: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} cocina en {object:2169}; {npc:5384} está en {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "{npc:5694}: para {npc:5464} en {area:42}, de camino al pantano",

	-- Step 58: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, en la Biblioteca Real de {object:2117}",

	-- Step 60: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Paladín: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, en la Catedral de la Luz",

	-- Step 61: Stormwind City
	["Stormwind City"] = "Ciudad de Ventormenta",

	-- Step 62: Warlock: Summon Felsteed
	-- {quest:4488} Summon Felsteed
	["Warlock: {quest:4488}"] = "Brujo: {quest:4488}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, en {object:2164}: {npc:6251} en {area:392} la recibe al final de la siguiente guía",

	-- Step 64: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Vuela a {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maestro de vuelo de {area:442}",

	-- Step 67: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4753} enseña a los elfos de la noche en {zone:1457}, junto a los sables de {npc:4730}: el barco de {area:17203} a {area:442} y luego el vuelo a {area:702}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar), como {npc:4732} en {area:88}, en {zone:1429}. Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: otros colores, 20g",

	-- Step 69: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Vuela a {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maestro de vuelo de {area:702}",

	-- Step 70: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Barco al {area:17203}",

	-- Step 71: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Vuela a {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maestro de vuelo de {zone:1453}",

	-- Step 72: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "{npc:5464}, junto al maestro de vuelo",

	-- Step 74: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "El pergamino está en el pantano al norte de Biggs. Los caminalodos al norte de él pueden soltar los ensayos de Khadgar.",

	-- Step 76: Cortello's Riddle
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, de 30-40/05-arathi-highlands",

	-- Step 77: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "{npc:5476} está junto al cruce de caminos en el oeste del pantano.",

	-- Step 78: The sunken temple
	["The sunken temple"] = "El templo sumergido",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Head east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Ve al este; los horrores enredados del camino también sueltan los ensayos. Busca en el borde de {area:74}, donde las ruinas del templo asoman del agua.",

	-- Step 79: Misty Reed Strand
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler · Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Silt Crawlers (40-41) crowd the north end of the eastern shore, and the driftwood washes up along it from there.\nCareful: the big Monstrous Crawlers (43-44) further south on the shore are over you: take the legs at the north end and pick up the driftwood without pulling them."] = "Los reptadores de cieno (40-41) llenan el extremo norte de la orilla este, y la madera a la deriva llega a la orilla desde ahí.\nCuidado: los grandes reptadores monstruosos (43-44), más al sur en la orilla, te superan: consigue las patas en el extremo norte y recoge la madera sin atraerlos.",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers"] = "{item:5938}, de los reptadores de cieno",

	-- Step 80: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "para {area:1438}: guárdalo",

	-- Step 83: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "para {npc:5635} en {area:348}: guárdalo",

	-- Step 84: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tranvía a {zone:1455}",

	-- Step 87: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "{npc:5637} está en la sala de los Reclamadores, junto a {object:32356}, y {npc:2786} en {object:32383}.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} no tiene instructor de chamanes",

	-- Step 89: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4772} enseña a los enanos en {area:803}, al este de {area:131}, en el camino a {zone:1432}, junto a los carneros de {npc:1261}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar). Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: otros colores, 20g",

	-- Step 91: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:7954} enseña a los gnomos en {area:189}, justo al este de {area:131}, junto a los mecazancudos de {npc:7955}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar). Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: otros colores, 20g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alone, you skip Nesingwary's three elite hunts: take their experience from the Skullsplitter trolls of Zul'Mamwe instead, just east of the mine, so every kill also counts for {npc:737}'s tusks. Or, with a group, run the {area:1517} dungeon instead."] = "Si vas solo, te saltas las tres cacerías élite de Nesingwary: consigue esa experiencia de los trols Machacacráneos de Zul'Mamwe, justo al este de la mina, así cada muerte también cuenta para los colmillos de {npc:737}. O, con un grupo, haz en su lugar la mazmorra {area:1517}.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. No se conoce ningún instructor de equitación Cielonato; el cliente de Forever incluye {spell:1285849} en la única habilidad de Equitación, así que {npc:4732} en {area:88}, en el este de {zone:1429}, el instructor más cercano a {zone:1453}, debería enseñarla (sin confirmar). Los Zancavientos los vende {npc:265756} en {area:16638}, en la Isla Zephras; Coleccionables, Monturas · Nivel 40 los incluye.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4732} enseña a los humanos en {area:88}, en el este de {area:12}, junto a los caballos de {npc:384}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar). Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "A nivel 40 y con 100 de oro puedes aprender a montar, y al aprenderlo recibes una montura. {npc:4753} enseña a los elfos de la noche en {zone:1457}, junto a los sables de {npc:4730}: el barco de {area:17203} a {area:442} y luego el vuelo a {area:702}. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar), como {npc:4732} en {area:88}, en {area:12}. Coleccionables, Monturas · Nivel 40 muestra todos los colores.",
	-- ["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "De vuelta en Theramore: Tervosh espera con Lady Jaina en la torre de {area:514}.",
	-- ["Bloodsail pirates"] = "Piratas Velasangre",
	-- ["Cold Eye Basilisks"] = "Basiliscos Ojogélido",
	-- ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}.\nCareful: the {area:43} camp's Warlocks and Swashbucklers are level 41-43, a level or more above you, and stand close together: pull them singly from the edge."] = "Todos los Velasangre sueltan tabaco rapé y uno de ellos lleva el ojo de {npc:2493}; los espadachines recorren la orilla justo al norte del pueblo. Las cartas y las órdenes están en el campamento pirata de {area:43}, al sur de {area:35}.\nCuidado: los brujos y espadachines del campamento de {area:43} son de nivel 41-43, uno o más niveles por encima de ti, y están muy juntos: atráelos de uno en uno desde la orilla.",
	-- ["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Cualquier seguidor de Zanzil puede soltar la mezcla; {npc:2537} recorre el sur del campamento.",
	-- ["Fly to {area:144}"] = "Vuela a {area:144}",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Vuela a {area:42} y cabalga al este por {zone:1430} hasta {zone:1435}; {npc:5476} está junto al camino, justo pasada la frontera.",
	-- ["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Sigue el camino al este de vuelta a Theramore. Tervosh, Lady Jaina y los oficiales están en la torre y en {area:514}.",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Sigue el camino al noreste hasta el campamento de Ventura y Cía. en {area:310}; los canteros, peritos y supervisores sueltan los cristales.",
	-- ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Sigue el camino al noroeste desde Theramore hasta la atalaya de {area:503}. Los hurgadores Fangorroca deambulan por el pantano a su alrededor.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Zancavientos: {npc:265756}, en {area:16638}, en la Isla Zephras.",
	-- ["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Entrega los colmillos y quédate: llegan tres oleadas de gorilas, {npc:1514} al final. Pelea con la salud completa.",
	-- ["If you skipped {quest:543}, grind here to level 42.46 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Si te saltaste {quest:543}, mata enemigos aquí hasta el nivel 42.46 para seguir el plan de la ruta. O, con un grupo, haz en su lugar la mazmorra {area:1517}.",
	-- ["Inside"] = "Adentro",
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Klannoc ofrece después El Vigía del viento (1791): la cadena del arma de {spell:1680}, con un élite al final, está en la guía de clase de guerrero Arma Torbellino.",
	-- ["Level 42.16"] = "Nivel 42.16",
	-- ["Level 42.16 at Zul'Mamwe"] = "Nivel 42.16 en Zul'Mamwe",
	-- ["Level 42.46"] = "Nivel 42.46",
	-- ["MacKinley's next task sends you after elite ogres: skip it."] = "La siguiente tarea de MacKinley te envía tras ogros élite: omítela.",
	-- ["Mudrock tortoises"] = "Tortugas Fangorroca",
	-- ["Naga Explorers"] = "Expedicionarios naga",
	-- ["No flight path to {area:144} yet: ride out of {zone:1455}'s gates, east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "Aún no tienes ruta de vuelo a {area:144}: sal a caballo por las puertas de {zone:1455}, al este por {zone:1426} y el túnel hasta {zone:1432}, y sigue por el camino hasta {area:144}.",
	-- ["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "De camino al norte a {area:392}, {area:720} está frente a {area:391}, al sur del pueblo: cruza vadeando los bajíos del banco de arena. {npc:6236} te envía cuatro retadores y luego a {npc:6238} (nivel 33), de uno en uno.",
	-- ["Ride back down to town; Shaky stands at the tunnel mouth."] = "Cabalga de vuelta al pueblo; el Trémulo está en la boca del túnel.",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Cabalga de vuelta al oeste por el camino; {npc:217412} está un poco al norte de Biggs.",
	-- ["Ride east out of {zone:1426} through the tunnel into {zone:1432} and on along the road to {area:144}."] = "Cabalga al este saliendo de {zone:1426} por el túnel hasta {zone:1432} y sigue por el camino hasta {area:144}.",
	-- ["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Cabalga al este; los horrores enredados del camino también sueltan los ensayos. Busca en el borde de {area:74}, donde las ruinas del templo asoman del agua.",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Cabalga desde Theramore al oeste por el camino de Revolcafango hacia {zone:1413} y al norte hasta {area:392}, en la costa. Consigue la ruta de vuelo con {npc:16227} y luego toma el barco a {area:35} en el muelle.",
	-- ["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Cabalga tierra adentro hasta las colinas de gorilas del Valle del Velo de Bruma. Los gorilas Velo de Bruma ancianos sueltan las menudencias; {npc:1449} está sentado entre ellos.",
	-- ["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Cabalga al norte hasta las colinas al oeste del camino. {npc:2535} y {npc:2536} están juntos justo al norte del poblado de Zanzil.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "Cabalga al noreste pasando el campamento de Nesingwary y sigue el camino al norte hasta el campamento de lo alto de la vega.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Cabalga al noreste pasando el campamento de Nesingwary y sigue el camino al norte hasta el campamento en lo alto de la vega. Por el camino, una {npc:217588} se arrastra por la jungla al sureste del campamento de Nesingwary: atrapa una con el Entomology Starter Kit y luego márcala.",
	-- ["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Cabalga al noroeste desde la mina hasta la bahía de la costa noroeste. Las almejas gigantes ({object:2744}) están en su fondo y guardan las perlas; {npc:2624} nada entre ellas y suelta {item:4034}.",
	-- ["Ride north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "Cabalga al noroeste hacia {zone:1413} y sube por la costa hasta {area:392}: el barco a {area:35} sale de su muelle, y el maestro de grifos de {area:392} está justo arriba.",
	-- ["Ride south down the road to {area:35}."] = "Cabalga al sur por el camino hasta {area:35}.",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "Cabalga hacia el sur, fuera de {zone:1432}, por el paso hasta {area:3}; {npc:2860} acampa en la excavación.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Cabalga hacia el sur, fuera de {zone:1432}, por el paso hasta {zone:1418}; {npc:2860} acampa en la excavación.",
	-- ["Ride south to the giant's hut in the middle of the marsh."] = "Cabalga al sur hasta la choza del gigante en medio del pantano.",
	-- ["Seahorn now offers {quest:604}: leave it. Its three captains are level 45-48 with crews around them, and the route brings you back to Seahorn at 48 for it."] = "Cuernomar ahora ofrece {quest:604}: déjala. Sus tres capitanes son de nivel 45-48 con tripulaciones alrededor, y la ruta te trae de vuelta con Cuernomar a nivel 48 para ella.",
	-- ["Skullsplitter ruins"] = "Ruinas Machacacráneos",
	-- ["Still short of level 42.16 after the hunts you did? Make up the rest on the Cold Eye Basilisks by the {area:310}, on your way south to {area:35}. Or, with a group, run the {area:1517} dungeon instead."] = "¿Todavía no llegas al nivel 42.16 después de las cacerías que hiciste? Completa el resto con los basiliscos Ojogélido junto a {area:310}, de camino al sur hacia {area:35}. O, con un grupo, haz en su lugar la mazmorra {area:1517}.",
	-- ["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Toma el camino al norte hasta la mansión en ruinas; Jarl vive en la choza de al lado y la tierra removida está en la esquina de la casa.",
	-- ["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "Toma el {area:2257} desde {object:28027}. {npc:5637} está en la sala de los Reclamadores junto a {object:32356}, {npc:1356} en la propia sala, {npc:2786} en {object:32383}. La siguiente guía sigue volando a {area:144}.",
	-- ["The Bloodsail captains"] = "Los capitanes Velasangre",
	-- ["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Los basiliscos Ojogélido descansan en las rocas al oeste de la mina.",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Las arañas Niebla Negra anidan alrededor de la Cueva Niebla Negra, en el noroeste del pantano; todas las arañas sueltan ojos.",
	-- ["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Los múrlocs Ancalodo llenan la costa norte pasada {area:497}; termina las lenguas con las tortugas de al lado.",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Las tortugas y caparapicos Fangorroca toman el sol en la orilla al noreste de la mansión.",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Los trols Machacacráneos ocupan las ruinas justo al este de la mina; cualquiera de ellos puede soltar colmillos, y sus panteras siempre lo hacen.",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "La posada quemada está en el camino al oeste, hacia {zone:1413}; la insignia del guardia está entre las cenizas y las huellas de cascos, en el barro junto a la posada.",
	-- ["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Los capitanes están en los barcos anclados frente a {area:43}, cada uno con una tripulación de piratas de nivel 42-45: Aguasmansas (45) y Sinquilla (46) en las cubiertas más cercanas, {npc:2546} (48) en el buque insignia. A nivel 42 es una pelea para un grupo o para el final de la guía; si vas, limpia antes cada cubierta. El pergamino de Cortello está en el naufragio junto a la orilla.",
	-- ["The driftwood washes up along the eastern shore."] = "La madera a la deriva llega a lo largo de la orilla este.",
	-- ["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Los nagas recorren las playas al norte del campamento Velasangre; sueltan los juncos.",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "El siguiente pergamino del enigma está en el oeste de Revolcafango: omítelo.",
	-- ["Unbagwa's ritual"] = "El ritual de Unbagwa",
	-- ["Warlock: {quest:3631}"] = "Brujo: {quest:3631}",
	-- ["Zanzil's village"] = "Poblado de Zanzil",
	-- ["for Stoley in {zone:1446}: keep it"] = "para Stoley en {zone:1446}: guárdalo",
	-- ["for the flight back to {npc:6251} at 43"] = "para el vuelo de vuelta con {npc:6251} a nivel 43",
	-- ["for the {area:8} later"] = "para {area:8}, más adelante",
	-- ["for {npc:2616} in Theramore: keep it"] = "para {npc:2616} en Theramore: guárdalo",
	-- ["grind on {npc:667}"] = "sube de nivel con {npc:667}",
	-- ["grind on {npc:690}"] = "farmea {npc:690}",
	-- ["grind on {npc:766}"] = "farmea {npc:766}",
	-- ["{area:43}: kill these as you meet them"] = "{area:43}: mata a estos según te los encuentres",
	-- ["{item:5938}, from the Silt Crawlers on the same shore"] = "{item:5938}, de los reptadores del cieno de la misma orilla",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: para {npc:1344} en {zone:1432}, guárdalo",
	-- ["{npc:1449}, inside {area:1742}"] = "{npc:1449}, dentro de {area:1742}",
	-- ["{npc:1470} is below ground in {area:144}, by the inn. His mushrooms grow in the {area:1517} dig in the {zone:1418}; the next guide takes you there and back through {area:144}."] = "{npc:1470} está bajo tierra en {area:144}, junto a la posada. Sus champiñones crecen en la excavación de {area:1517}, en {zone:1418}; la guía siguiente te lleva allí y te trae de vuelta por {area:144}.",
	-- ["{npc:1470}, below ground"] = "{npc:1470}, bajo tierra",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: atrápala, para {quest:93176}",
	-- ["{npc:2487}, top floor"] = "{npc:2487}, piso superior",
	-- ["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "El siguiente encargo de {npc:2498} sobre Zanzil empieza en {zone:1441}: omítelo.",
	-- ["{npc:2535} and {npc:2536}"] = "{npc:2535} y {npc:2536}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} acampa solo en {area:1898}, al sureste de la excavación.",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} ocupa la torre con unos cuantos desertores. Se vuelve contra ti: golpéalo hasta que se rinda.",
	-- ["{npc:4968}, on the top floor"] = "{npc:4968}, en el piso de arriba",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: para {area:1438}, guárdalo",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}: Actitud rabiosa",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} es el edificio alto sobre el puerto; la mayoría de los asignadores de misiones están en sus pisos o en los muelles de abajo.",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}, para \"Ojolodo\" Jarl",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} está cerca de la posada; {npc:4897}, una proveedora de comercio a pocos pasos al sur, vende las especias que quiere Jarl.",
	-- ["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}: su {item:4612} cae rara vez, así que el trabajo y la entrega también son opcionales",
	-- ["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",
}
