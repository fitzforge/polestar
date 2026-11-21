-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "Si vienes de {zone:2548}: el maestro de vuelo de {area:340} está al pie de la fortaleza.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maestro de vuelo de {area:340}",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "Maestro de vuelo de {area:75}",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1435} Swamp of Sorrows · {zone:1458} Undercity · {object:2076} Bubbling Cauldron
	-- was: ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "El vuelo aterriza en {object:3202}. Los encargos más difíciles de Tuercespina, pendientes de tu primera visita, ya son para ti: el jefe Partecráneos, los campamentos de Zanzil, los piratas de {area:35}, la costa de los naga y {npc:1514}, antes del zepelín a {zone:1454}. La {object:2076} junto a Nimboya tiene la misión del jefe Partecráneos."
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the {zone:1435} and the {zone:1458}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}: {quest:586}",

	-- Step 4: Tusks and necklaces on the Skullsplitter hunt
	["Tusks and necklaces on the Skullsplitter hunt"] = "",
	-- {npc:737} Kebok · {npc:2519} Kin'weelay
	["The hunters also drop {npc:737}'s tusks and {npc:2519}'s necklaces. Collect any you still need during the cauldron hunt."] = "",

	-- Step 5: Zul'Mamwe
	["Zul'Mamwe"] = "Ruinas de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "Cabalga al este hasta las ruinas Partecráneos, al este de la mina de la Ventura y Cía. Los cazacabezas, rabiosos y cazadores recorren las ruinas.\n{npc:1059} (45) lleva la Armadura rota para {quest:586}: recorre las ruinas del suroeste con dos guardias y a veces se queda en una pequeña cueva ahí. Atrae primero a los guardias.\nCuidado: {npc:1060}, un trol élite (nivel 44), está en las ruinas del sur alrededor de 47.7,44.3: aleja de él a los cazacabezas y rabiosos.",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} da vueltas por aquí: búscalo dentro del círculo del mapa",

	-- Step 6: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back west to {object:3202}."] = "Regresa al oeste a {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "{object:2076} otra vez: el destino de Yenniku",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}: los basiliscos toman el sol junto al camino al sur, en la ruta a {area:35}",

	-- Step 8: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Cabalga al sur por el camino hacia {area:35}; los basiliscos toman el sol en las rocas al este, en medio de la jungla. Sus fragmentos caen a menudo.",
	["Below ground"] = "Bajo tierra",

	-- Step 9: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "Fantasmas piratas y campamentos de Zanzil",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	-- was: ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Sigue al suroeste hasta la jungla al noreste de Vallebruma: los tres piratas fantasmales la rondan junto a los campamentos de Zanzil. {npc:2535} y {npc:2536} están juntos, {npc:2537} más al este. Cualquier seguidor de Zanzil puede llevar el brebaje.\nCuidado: los médicos brujos Zanzil (44) lanzan hechizos y los campamentos están llenos: atráelos desde el borde, uno a la vez. El propio {npc:2534} (46) está en el campamento del sur alrededor de 39.6,58.6, a unos pasos del fantasma de {npc:2537}: lleva a {npc:2537} al norte o al este antes de pelear con él."
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and Jon-Jon stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "",

	-- Step 10: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Al oeste, en Vallebruma: {npc:1449} está entre los gorilas. Cualquier gorila puede soltar un colmillo: entrégale diez y quédate a su lado; invoca tres oleadas de gorilas y luego a {npc:1514}.\nCuidado: las tres oleadas de gorilas llegan una tras otra con poco descanso, y luego {npc:1514}. Empieza con la salud y el maná llenos, y quédate cerca de Unbagwa. A algunas clases se les hace difícil solas: con un amigo es fácil.",

	-- Step 11: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}: mata a estos según te los encuentres",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 12: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:35} Booty Bay
	["From the north, take the outer shore east of the {area:35} tunnel. Work south-west through the swashbucklers (41-43) into the camp; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Stay ashore."] = "",

	-- Step 13: Bloodsail tents and rowboat
	["Bloodsail tents and rowboat"] = "",
	["Search the tents and the rowboat for both papers; if one place is empty, try the next. Neither paper is on a ship."] = "",

	-- Step 16: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2486} Fin Fizracket · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "En {area:35}: {npc:2494} en los muelles, {npc:2486} junto a la posada, {npc:2498} dentro, MacKinley, {npc:737} y {npc:773} arriba.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, adentro",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",

	-- Step 17: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "",
	-- {area:35} Booty Bay · {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["Under 40 on your first {area:35} visit? {npc:2491}, in the inn, {npc:2486}, beside it, and \"Sea Wolf\" MacKinley, on the top floor, have their quests for you now."] = "",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, en la posada: sus botellas llegan a la costa de {zone:1425}, alrededor del nivel 48",
	-- {quest:2872} Stoley's Debt · {npc:7881} Stoley · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for {npc:7881} in {zone:1446} on this guide"] = "",

	-- Step 18: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["North into Mistvale, a short ride from {area:35}: {npc:1449} sits among the gorillas. Hand him ten gorilla fangs and stay by him: three waves of gorillas, then {npc:1514}. Start at full health and mana."] = "",

	-- Step 19: Fin Fizracket
	-- {npc:2486} Fin Fizracket
	["{npc:2486}, by the inn"] = "",

	-- Step 20: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",

	-- Step 21: Krazek
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "{npc:773}, arriba: para {quest:2864} en {area:976}, más adelante en esta guía",

	-- Step 24: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 28: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 29: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then back to the flight master."] = "",

	-- Step 32: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Vuela a {area:75}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:75} Stonard · {area:1978} Misty Reed Post
	["Stranglethorn's errands are done: from {object:3202}'s flight master, fly on to {area:75} for the swamp's coast and {area:1978}, which fit you now."] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maestro de vuelo de {object:3202}",

	-- Step 33: To Stonard
	-- {area:75} Stonard
	["To {area:75}"] = "A {area:75}",
	-- {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1431} Duskwood · {zone:1430} Deadwind Pass
	["No flight path to {area:75} yet: ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "",

	-- Step 34: Stonard
	-- {quest:698} Lack of Surplus · {quest:1424} Pool of Tears · {quest:1430} Fresh Meat · {npc:5593} Katar · {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["The Stranglethorn & Swamp guide already finished {quest:698}' first part and the {quest:1424} with you; its {quest:1430} and {npc:5593}'s murlocs are in your log. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, adentro",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, en el piso superior",

	-- Step 35: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Cabalga al oeste por el camino; el pergamino está a la orilla del agua, en el extremo oeste del pantano.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, on the Dustwallow guide"] = "",

	-- Step 36: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "Los crocoliscos se revuelcan en las pozas alrededor del antiguo campamento de Galen, justo al norte de {area:75}, de camino de vuelta al este; más o menos uno de cada cuatro suelta un flanco.",

	-- Step 37: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "De vuelta al este pasando {area:75}: los artefactos Atal'ai están en el agua y en las orillas de {quest:1424}.",

	-- Step 38: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} and {npc:5593}."] = "",

	-- Step 39: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403}: mata a estos según te los encuentres",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "Los mordedores ocupan la playa al sur del puesto.\nLos reptadores monstruosos recorren las playas de la costa este, pocos y dispersos: mata a todos los que veas, también los del camino de bajada desde la poza.\nCuidado: un {npc:272377} (nivel 60) recorre la playa del sureste: mantente bien lejos de él.",
	["Underwater"] = "Bajo el agua",

	-- Step 41: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Múrlocs de Juncobruma",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Los Múrlocs de marisma ({npc:747}) viven en la playa al sur del puesto; los Vomitatintas están en la orilla al este y los Comecarnes más al oeste, alrededor de las chozas de la orilla oeste.",

	-- Step 43: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "La misma orilla de múrlocs otra vez: escupetintas al este del puesto, devoracarnes alrededor de las chozas del oeste y los oráculos entre ambos.",

	-- Step 45: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 49"] = "",

	-- Step 46: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity · {area:340} Kargath · {npc:5204} Apothecary Zinge · {zone:1454} Orgrimmar
	["From {area:75}'s flight master, fly to the {area:1497} (by way of {area:340}): {npc:5204}'s errands and your {area:1497} training, then the zeppelin from the towers outside the city to {zone:1454}."] = "",

	-- Step 47: Apothecary Zinge
	-- {npc:2934} Keeper Bel'dugur
	["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, de camino de regreso con Zinge",
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "{item:8523} de estos encargos: guárdalo, Muestreo de campo de Tanaris lo devuelve en {area:976}",

	-- Step 48: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",

	-- Step 49: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {zone:1454} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Caballos esqueléticos: {npc:4731}, junto a {npc:4773} en {area:159}.",

	-- Step 50: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 51: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "El centro de {zone:1454}",

	-- Step 52: Orgrimmar
	-- {zone:1458} Undercity
	["the {zone:1458}'s classes trained there on the way"] = "",

	-- Step 53: Riding at 40
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Montar requiere nivel 40 y cuesta 100 de oro; al aprenderlo recibes una montura. {npc:4752} enseña a los orcos en {object:172958}, junto a la perrera de {npc:3362}. Los Skyborne lo aprenden con {npc:265756} en {area:17684}, en {area:16638}, en la Isla Zephras, con un Galestrider: el barco aéreo a la isla sale de los acantilados al sur de {area:17045}, al norte de {zone:1456}, más o menos cada cinco minutos. Las otras monturas de tu raza cuestan 20 de oro cada una: Coleccionables, Monturas · Nivel 40 tiene una guía para cada una.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Lobos: {npc:3362}, junto a {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Montar y Galestriders: {npc:265756}, en {area:17684}, en {area:16638}, en la Isla Zephras.",

	-- Step 55: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "Montar requiere nivel 40 y cuesta 100 de oro; al aprenderlo recibes una montura. Cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:7953} en {area:367}, a poca distancia al sur de {zone:1454} por el camino de {zone:1411}, con los raptores de Zjolnir (20 de oro cada uno) a su lado. Luego vuelve al maestro de vuelo de {zone:1454}.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instructor de equitación",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptores: Zjolnir, junto a {npc:7953} en {area:367}.",

	-- Step 56: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 58: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "Tu instructor está en {zone:1456}: {npc:3033} (druidas) en {area:1639}, {npc:246344} (paladines).",

	-- Step 60: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "Montar requiere nivel 40 y cuesta 100 de oro; al aprenderlo recibes una montura. Cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:3690} en {area:222}, con los kodos de {npc:3685} (20 de oro cada uno) a su lado. Luego vuelve a subir al maestro de vuelo de {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instructor de equitación",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, junto a {npc:3690} en {area:222}.",

	-- Step 61: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Vuela a {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 62: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",

	-- Step 65: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} para el corcel vil",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "Vuela de {zone:1454} a {area:392}; {npc:6251} está en la colina sobre los muelles.",

	-- Step 66: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maestro de vuelo de {area:392}",

	-- Step 72: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "Si llegaste volando: primero las misiones de {area:976}, junto al maestro de vuelo; luego {area:2240} está a poca distancia a caballo al norte, cruzando la frontera de {zone:1446}.",
	-- {npc:7407} Chief Engineer Bilgewhizzle · {npc:5204} Apothecary Zinge · {item:8523} Field Testing Kit · {zone:1458} Undercity
	["{npc:7407}: {npc:5204}'s {item:8523}, from the {zone:1458}"] = "",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}: the water pouches come from the same Wastewander camps"] = "",

	-- Step 73: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "Para tu recorrido por {area:978}, en la siguiente guía: {quest:2864} quiere caparazones de escarabajo, y {npc:7804}, a poca distancia del maestro de vuelo, {quest:3042} de los trols Furiarena.",

	-- Step 74: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "Si llegaste volando a {area:976}: el circuito de carreras está a poca distancia a caballo al norte, cruzando la frontera de {zone:1446}.\nEl camino de {area:484} a {zone:1446} pasa por {area:2240} en {area:439}: {npc:4454} está en el campamento de los gnomos junto a la pista, {npc:4630} y {npc:4709} junto al campamento de los goblins. Primero {npc:4630}, luego {npc:4709}, que sale corriendo a entretener a Rizzle; después toma los planos de Rizzle del campamento de los gnomos y llévaselos a {npc:4630}.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}: {quest:1137}, de parte de Martek en {zone:1418}",
	-- {npc:4630} Pozzik · {npc:2496} Baron Revilgaz · {area:35} Booty Bay
	["{npc:4630}: {npc:2496}'s word, from {area:35}"] = "",
	-- {npc:4706} Razzeric · {npc:4630} Pozzik
	["{npc:4706}, beside {npc:4630}"] = "{npc:4706}, junto a {npc:4630}",

	-- Step 75: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Hacia {area:976}",

	-- Step 76: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} es el pueblo goblin amurallado justo después de la frontera de {zone:1446}.",

	-- Step 78: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}: mata a estos según te los encuentres",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	-- was: ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Los bandidos y ladrones acampan en las dunas al este de {area:976}. Cualquier Vagayermo puede llevar una bolsa de agua: Luglunket quiere cinco.\nCuidado: Los pícaros Vagayermo (nivel 43-44) se mueven en sigilo, así que pueden acercarse sin que los veas."
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five, and Bilgewhizzle five more.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",

	-- Step 79: Gadgetzan
	-- {zone:1446} Tanaris
	["Keep the Model 4711-FTZ Power Source Bilgewhizzle gave you: it starts Tanaris Field Sampling, a two-hour timer, for the {zone:1446} guide at about 48, on the way back north from Scrimshank's hive."] = "",

	-- Step 80: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Cabalga al noreste hasta el puerto goblin de la costa.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, adentro",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, adentro",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on this guide's west sweep"] = "",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}, en el muelle: el encargo de Friz de {zone:2548}, si lo llevas",

	-- Step 81: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}: mata a estos según te los encuentres",
	-- {npc:7883} Andre Firebeard · {item:9276} Pirate's Footlocker · {item:9250} Ship Schedule · {area:977} Steamwheedle Port
	-- was: ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Al sur por la costa, los piratas de los Mares del Sur ocupan la cala. {npc:7883} y la carga robada están en los muelles del extremo. Cualquier pirata puede soltar un sombrero, los secuestradores con más frecuencia.\nCuidado: Dos o tres piratas están con {npc:7883} (45), y muchos más piratas del pueblo se unen a la pelea cuando empieza: primero aleja a sus guardias de él."
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first.\nThe cove's pirates sometimes drop a {item:9276}: open it, and if it holds a {item:9250}, read it to start a quest for the Security Chief in {area:977}."] = "",
	["Upstairs"] = "Arriba",
	-- {item:9250} Ship Schedule · {item:9276} Pirate's Footlocker
	["{item:9250}, from a {item:9276}"] = "",

	-- Step 82: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}: mata a estos según te los encuentres",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Los magos de las sombras, pícaros y asesinos acampan al sureste de {area:976}.\nAl sureste de Gadgetzan, los bandidos Erramundos acampan en las dunas; {npc:7847} está en el campamento del este.\nCuidado: Los pícaros Erramundos mantienen Acechar fuera de combate, así que pícaros ocultos pueden unirse a una pelea que empieces en un campamento.\nCuidado: Dos pícaros Erramundos en sigilo lo acompañan a donde vaya. En su campamento de aparición, dos magos de las sombras y sus esbirros están lo bastante cerca para unirse a la pelea. Afuera, junto a las torres, puedes pelear con él sin ellos.",

	-- Step 83: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "Vuelve al noreste, al puerto: {npc:7881}, {npc:15165} y el Jefe de seguridad reciben lo que te dio {area:1336}. {area:976} está al oeste.",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "para {area:35}, alrededor del nivel 51 (40-50/06)",
	-- {npc:7882} Security Chief Bilgewhizzle · {item:9250} Ship Schedule
	["{npc:7882}: the {item:9250}, if the cove gave you one"] = "",

	-- Step 85: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 87: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777} da vueltas por {area:1099}: búscalo dentro del círculo del mapa",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}: el encargo de {npc:263190} de {zone:2548}, si lo llevas",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	-- was: ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, alrededor del nivel 45"
	["{npc:8115}: for {zone:1454}, around level 47"] = "",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, adentro",

	-- Step 88: Gordunni Outpost
	-- {npc:222233} Ohk'zi · {item:9466} Orwin's Shovel · {object:144064} Gordunni Dirt Mound
	-- was: ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Al norte de los gnolls, los ogros ocupan una avanzada en una colina; atrae a los ogros magos hacia ti. El cobalto está en los montículos de tierra alrededor de la avanzada y el pergamino está en el suelo, adentro.\nCuidado: {npc:222233} (nivel 43, élite) está en la avanzada: atrae a los ogros hacia ti, lejos de él."
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him.\nUse {item:9466} on each {object:144064} around the outpost: the arrow goes from mound to mound."] = "",

	-- Step 89: Woodpaw north camp
	["Woodpaw north camp"] = "Campamento norte Zarpaleña",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "Los gnolls Zarpaleña acampan en las colinas justo al noroeste de Mojache; cualquiera puede soltar una melena.\nCuidado: Todos los gnolls Zarpaleña, salvo el alfa, huyen a pedir ayuda al 15 % de salud, lo que puede atraer más gnolls a la pelea.",

	-- Step 90: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: una hora a partir de ahora",

	-- Step 91: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}: mata a estos según te los encuentres",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "Los dardos duende revolotean sobre la arboleda justo al oeste de Mojache; casi todos sueltan un ala. Los alfas Zarpaleña dirigen los campamentos al suroeste: mátalos antes de que pase la hora.\nCuidado: La mayoría de los alfas están en pequeños campamentos de tiendas con 2-4 gnolls más que se unen a la pelea, y otros gnolls patrullan entre los campamentos.",

	-- Step 93: Grimtotem camp
	["Grimtotem camp"] = "Campamento Tótem Siniestro",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "El campamento tauren Tótem Siniestro, junto a la arboleda de los duendes dardo; los asaltantes, naturalistas y chamanes llevan cuernos.\nCuidado: {npc:222286} (nivel 43, élite) está en el campamento: atrae a los asaltantes y chamanes lejos de ella.",

	-- Step 94: Woodpaw battle map
	["Woodpaw battle map"] = "Mapa de batalla Zarpaleña",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "El mapa de batalla está en el campamento Zarpaleña al sur de Mojache.",

	-- Step 95: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 47"] = "",

	-- Step 96: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "La colmena Zukk'ash se adentra en las colinas al sureste del campamento; {quest:7731} espera en su cámara más profunda.\nCuidado: {quest:7731} es de nivel 47: limpia la colmena a su alrededor y atráelo solo con la salud completa.",

	-- Step 97: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}: mata a estos según te los encuentres",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "Ve al oeste desde la colmena hasta las ruinas de los ogros debajo de {area:1105}. Están llenas de chamanes, brujos y machacadores; los señores mago del extremo sur llevan el orbe.\nCuidado: los señores mago (45-46) y los chamanes atacan a distancia y las ruinas están repletas: atráelos de uno en uno desde el borde.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234} da vueltas por {area:2522}: búscalo dentro del círculo del mapa",

	-- Step 98: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "Yetis de {area:1105}",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Al noroeste de las ruinas, los yetis tienen su guarida en {area:1105}; cualquier yeti de ahí puede soltar un pellejo grueso.",

	-- Step 99: Rogue Vale screechers
	["Rogue Vale screechers"] = "Estridadores del valle huido",
	-- {area:1099} Camp Mojache · {area:1105} Feral Scar Vale · {item:10699} Yeh'kinya's Bramble · {npc:8579} Yeh'kinya · {area:977} Steamwheedle Port · {zone:1446} Tanaris
	-- plural, as words: Rogue Vale Screechers = {npc:5308} Rogue Vale Screecher
	["On the way back north-east towards {area:1099}, the Rogue Vale Screechers (44-46) hunt the open ground north of {area:1105}. Kill one, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all; {npc:8579} takes them in {area:977} on your next {zone:1446} visit."] = "",

	-- Step 100: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "Solo con la baliza de socorro: cualquier bestia, gnoll u ogro de {zone:1444} puede soltarla, más o menos una vez cada cien; úsala para empezar la misión. El robot está en una pequeña cueva en el lado norte de {area:1105}, justo al noroeste de las ruinas. Escóltalo hasta el muelle de {area:1108}; yetis y gorilas te emboscan en el camino. Su recompensa espera en {area:35} para una visita posterior.\nCuidado: Aparecen tres emboscadas durante la escolta, y el robot te avisa antes de cada una. La primera son 3 yetis, justo después de que el robot sale de la cueva y sube hacia el camino. La segunda son 3 gorilas, en el sendero que corre junto al acantilado. La tercera son unos 4 gnolls, uno de ellos lanzador de hechizos, donde la ruta se desvía hacia el muelle.",

	-- Step 101: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "los yetis Cicatriz de Ira, en la próxima visita a {zone:1444}",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}: para {npc:7010} en {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "para {zone:1454}, después de {zone:2652}",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "Sigue {zone:2652}, cabalgando al norte desde {area:1099} hacia {zone:1443}: guarda tus entregas de {zone:1454} (Neeru, Zilzibin, {npc:4485}, {npc:7311}) para el vuelo hacia allá después.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "Regresa al pueblo. Los capitanes de los barcos, el siguiente encargo de Seahorn, son para tu parada en Tuercespina hacia el nivel 50.",
	-- ["Eastern Wastewander camps"] = "Campamentos Vagayermo del este",
	-- ["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Vuela a {area:1637}. Los hermanos Droffers atienden su tienda en la calle comercial de la ciudad.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Vuela a {area:484}, baja en el elevador al este del poblado y cruza el desierto de sal; luego ve al sur hacia {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Vuela a {area:484} y luego cabalga al oeste por los cañones pasando {area:2237}; el camino sube a la selva de {zone:1444} y sigue hasta {area:1099}.",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Vuela a {zone:1454}. Desde el maestro de vuelo: {object:172960}, luego la Calle Mayor, luego {object:172958}.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Zancavientos: {npc:265756}, en {area:16638}, en la Isla Zephras.",
	-- ["Hearth to {area:1099}"] = "Usa tu piedra de hogar para ir a {area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Sigue cabalgando al oeste hasta la costa. Los Videnistas Reptacostas ({npc:5328}) y Quebradores de las playas sueltan el localizador de emergencia de OOX-22/FE en una de cada cuarenta muertes: si cae, úsalo para iniciar la misión.",
	-- ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Al norte de los gnolls, los ogros ocupan una avanzada en una colina; atrae a los ogros magos hacia ti. El cobalto está en los montículos de tierra alrededor de la avanzada y el pergamino está en el suelo, adentro.\nCuidado: {npc:222233} (nivel 43, élite) está en la avanzada: atrae a los ogros hacia ti, lejos de él.",
	-- ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Sigue al suroeste hasta la jungla al noreste de Vallebruma: los tres piratas fantasmales la rondan junto a los campamentos de Zanzil. {npc:2535} y {npc:2536} están juntos, {npc:2537} más al este. Cualquier seguidor de Zanzil puede llevar el brebaje.\nCuidado: los médicos brujos Zanzil (44) lanzan hechizos y los campamentos están llenos: atráelos desde el borde, uno a la vez. El propio {npc:2534} (46) está en el campamento del sur alrededor de 39.6,58.6, a unos pasos del fantasma de {npc:2537}: lleva a {npc:2537} al norte o al este antes de pelear con él.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Solo con el localizador de emergencia: el robot está en una pequeña cueva en el lado norte de {area:1105}. Escóltalo hasta el muelle de {area:1108}; los yetis y gorilas te emboscan en el camino. Su recompensa te espera en {area:35} para una visita posterior.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Regresa cabalgando al noroeste desde {area:1978} hasta {area:75} y vuela a {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Regresa cabalgando al oeste a {area:976}.",
	-- ["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Cabalga al suroeste hasta las ruinas ogras bajo {area:1105}. Están llenas de chamanes, brujos y aplastadores; los Señores de la magia del extremo sur llevan el orbe.",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Ve al oeste desde la colmena hasta las ruinas de los ogros debajo de {area:1105}. Están llenas de chamanes, brujos y machacadores; los señores mago del extremo sur llevan el orbe.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Cabalga al oeste hacia el centro de {zone:1444}. Mata a un {npc:5308}, usa {item:10699} en su cuerpo y mata al espíritu que surge.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Para montar necesitas nivel 40 y 100 de oro; al aprenderlo recibes una montura. En Classic cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:3690} en {area:222}, con los kodos de {npc:3685} (20 de oro cada uno) a su lado. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar): primero prueba con {npc:4752} en {object:172958} de {zone:1454}, ya que es el más cercano, y omite este paso si te enseña.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Para montar necesitas nivel 40 y 100 de oro; al aprenderlo recibes una montura. En Classic cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:4773} en {area:159}, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar): primero prueba con {npc:4752} en {object:172958} de {zone:1454}, ya que es el más cercano, y omite este paso si te enseña.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Para montar necesitas nivel 40 y 100 de oro; al aprenderlo recibes una montura. En Classic cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:7953} en {area:367}, en la costa de {zone:1411}, con los raptores de Zjolnir (20 de oro cada uno) a su lado. Forever podría dejar que cualquier raza aprenda con cualquier instructor de equitación (sin confirmar): primero prueba con {npc:4752} en {object:172958} de {zone:1454}, ya que es el más cercano, y omite este paso si te enseña.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Para montar necesitas nivel 40 y 100 de oro; al aprenderlo recibes una montura. {npc:4752} enseña a los orcos en {object:172958}, junto a la perrera de {npc:3362}; no se conoce instructor de equitación Cielonato, así que los Cielonatos también deben probar con {npc:4752}. Las otras monturas de tu raza cuestan 20 de oro cada una: Coleccionables, Monturas · Nivel 40 tiene una guía para cada una.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Al sur por la costa, los piratas de los Mares del Sur ocupan la cala. {npc:7883} y la carga robada están en los muelles del fondo. Cualquier pirata puede soltar un sombrero, sobre todo los secuestradores.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Al sur por la costa, los piratas de los Mares del Sur ocupan la cala. {npc:7883} y la carga robada están en los muelles del extremo. Cualquier pirata puede soltar un sombrero, los secuestradores con más frecuencia.\nCuidado: Dos o tres piratas están con {npc:7883} (45), y muchos más piratas del pueblo se unen a la pelea cuando empieza: primero aleja a sus guardias de él.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Al sur por la costa, los piratas de los Mares del Sur ocupan la cala. {npc:7883} y la carga robada están en los muelles del extremo. Cualquier pirata puede soltar un sombrero, los secuestradores con más frecuencia.\nCuidado: Dos o tres piratas están con {npc:7883}, y muchos más piratas del pueblo se unen a la pelea cuando empieza.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Al sur de Bahía del Botín, los espadachines Velasangre acampan en {area:43}; las cartas y las órdenes están en sus tiendas y en el bote de remos junto al campamento más grande. Cualquier Velasangre puede llevar tabaco rapé y el ojo de {npc:2493}, así que sigue matando hasta tener ambos.",
	-- ["Southern Gordunni ruins"] = "Ruinas Gordunni del sur",
	-- ["Southern Wastewander camps"] = "Campamentos Vagayermo del sur",
	-- ["Sprite darters and Woodpaw alphas"] = "Duendes dardo y alfas Zarpaleña",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Los gnolls Zarpaleña acampan en las colinas justo al noroeste de Mojache; cualquiera puede soltar una melena.",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "La colmena Zukk'ash se adentra en las colinas al sureste del campamento; {quest:7731} espera en su cámara más profunda.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Los bandidos y ladrones acampan en las dunas al este de {area:976}. Cualquier Vagayermo puede llevar una bolsa de agua: Luglunket quiere cinco.\nCuidado: Los pícaros Vagayermo (nivel 43-44) se mueven en sigilo, así que pueden acercarse sin que los veas.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Los bandidos y ladrones acampan en las dunas al este de {area:976}. Cualquier Vagayermo puede llevar una faltriquera de agua: guarda diez, cinco para cada una de las recompensas de Llantalunket.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Los bandidos y ladrones acampan en las dunas al este de {area:976}. Cualquier Erramundos puede llevar una bolsa de agua: guarda diez, cinco para cada recompensa de Luglunket.\nCuidado: Los pícaros Erramundos (nivel 43-44) se mueven en sigilo, así que pueden acercarse sin que los veas.",
	-- ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "El vuelo aterriza en {object:3202}. Los encargos más difíciles de Tuercespina, pendientes de tu primera visita, ya son para ti: el jefe Partecráneos, los campamentos de Zanzil, los piratas de {area:35}, la costa de los naga y {npc:1514}, antes del zepelín a {zone:1454}. La {object:2076} junto a Nimboya tiene la misión del jefe Partecráneos.",
	-- ["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "El vuelo aterriza en {object:3202}: {npc:2519} y {npc:2465}, luego la torre del zepelín.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Los magos oscuros, pícaros y asesinos acampan al sureste de {area:976}.",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Los duendes dardo revolotean sobre la arboleda justo al oeste de Mojache; casi todos sueltan un ala. Los alfas Zarpaleña dirigen los campamentos al suroeste: mátalos antes de que pase la hora.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "El zepelín a {object:3202} sale de la torre justo al noreste de la puerta principal de {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "El zepelín a {zone:1454} sale de la torre junto a {object:3202}; aterriza justo afuera de la puerta principal de {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, la maestra de vuelo, está justo al este de la torre de zepelín. Vuela a {area:75}: la siguiente guía empieza allí.",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "Al oeste hasta la costa: los exploradores naga recorren la orilla y llevan los haces de juncos; {object:759} burbujea en las colinas justo al este. Luego sigue la costa al sur hasta {area:35}.",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Tu instructor está en {area:1638}: {npc:3033} (druidas) en {area:1639}, {npc:246344} (paladines). Vuela allí desde {zone:1454} y luego a {area:484}.",
	-- ["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["for the {zone:1425}, around level 48"] = "para {zone:1425}, alrededor del nivel 48",
	-- ["for {area:35}, around level 50"] = "para {area:35}, alrededor del nivel 50",
	-- ["for {zone:1454}, around level 45"] = "para {zone:1454}, alrededor del nivel 45",
	-- ["the {object:150075} in the square"] = "{object:150075} en la plaza",
	-- ["water pouches in your bags"] = "faltriqueras de agua en tus bolsas",
	-- ["{area:1099} flight master"] = "Maestro de vuelo de {area:1099}",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} es el pueblo goblin amurallado justo después de la frontera de {area:440}.",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, en el piso superior",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}: los {item:5852} de {npc:2496}, si los llevas",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}, calle comercial de Orgrimmar",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}, la Calle Mayor",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, instructor de equitación",
	-- ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, alrededor del nivel 45",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: los estridadores viven en {zone:1444}",
	-- ["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}: los chilladores viven en {zone:1444}, en la próxima visita a {zone:1444}",
}
