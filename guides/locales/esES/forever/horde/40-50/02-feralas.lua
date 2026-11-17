-- Spanish (Spain) (esES): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
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
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1454} Orgrimmar · {object:2076} Bubbling Cauldron
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "El vuelo aterriza en {object:3202}. Las tareas más duras de Tuercespina, pendientes de tu primera visita, ya son de tu nivel: el jefe Partecráneos, los campamentos de Zanzil, los piratas de {area:35}, la costa de los nagas y {npc:1514}, antes del zepelín a {zone:1454}. La {object:2076} junto a Nimboya tiene la misión del jefe Partecráneos.",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}: {quest:586}",

	-- Step 4: Zul'Mamwe
	["Zul'Mamwe"] = "Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "Ve al este, a las ruinas Partecráneos al este de la mina de la Compañía Ventura. Los cazadores de cabezas, rabiosos y cazadores recorren las ruinas.\n{npc:1059} (45) lleva la Armadura rota para {quest:586}: recorre las ruinas del suroeste con dos guardias y a veces está en una pequeña cueva allí. Atrae primero a los guardias.\nCuidado: {npc:1060}, un trol élite (nivel 44), está en las ruinas del sur, hacia 47.7,44.3: aleja de él a los cazadores de cabezas y rabiosos.",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} da vueltas por aquí: búscalo dentro del círculo del mapa",

	-- Step 5: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back west to {object:3202}."] = "Vuelve al oeste a {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "{object:2076} otra vez: el destino de Yenniku",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}: los basiliscos toman el sol junto al camino del sur, de camino a {area:35}",

	-- Step 6: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Ve al sur por el camino hacia {area:35}; los basiliscos toman el sol en las rocas al este, en plena selva. Sus fragmentos caen a menudo.",
	["Below ground"] = "Bajo tierra",

	-- Step 7: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "Fantasmas piratas y campamentos de Zanzil",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Sigue al suroeste hasta la selva al noreste de Vallebruma: los tres piratas fantasmales rondan junto a los campamentos de Zanzil. {npc:2535} y {npc:2536} están juntos, {npc:2537} más al este. Cualquier seguidor de Zanzil puede llevar la mezcla.\nCuidado: los Médicos brujos Zanzil (44) lanzan hechizos y los campamentos están abarrotados: atráelos desde el borde, de uno en uno. El propio {npc:2534} (46) está en el campamento del sur, hacia 39.6,58.6, a pocos pasos del fantasma de {npc:2537}: aleja a {npc:2537} hacia el norte o el este antes de luchar con él.",

	-- Step 8: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Al oeste, en Vallebruma: {npc:1449} está entre los gorilas. Cualquier gorila puede soltar un colmillo: entrégale diez y quédate a su lado; invoca tres oleadas de gorilas y luego a {npc:1514}.\nCuidado: las tres oleadas de gorilas llegan una tras otra con poco respiro, y luego {npc:1514}. Empieza con la salud y el maná al máximo y quédate cerca de Unbagwa. A algunas clases les cuesta en solitario: con un amigo es fácil.",

	-- Step 9: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}: mátalos según te los encuentres",
	-- {object:759} Holy Spring · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "Al oeste, hasta la costa: los exploradores nagas vadean la orilla y llevan los haces de juncos; {object:759} burbujea en las colinas justo al este. Después sigue la costa al sur hasta {area:35}.",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2486} Fin Fizracket · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "En {area:35}: {npc:2494} en los muelles, {npc:2486} junto a la posada, {npc:2498} dentro, MacKinley, {npc:737} y {npc:773} en el piso de arriba.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, dentro",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "{npc:773}, arriba: para {quest:2864} en {area:976}, más adelante en esta guía",

	-- Step 11: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Al sur de Bahía del Botín, los aventureros Velasangre acampan en {area:43}; las cartas y las órdenes están en sus tiendas y en el bote de remos junto al campamento más grande. Cualquier Velasangre puede llevar tabaco y el Ojo de {npc:2493}, así que sigue matando hasta tener ambos.",

	-- Step 12: Booty Bay
	["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "Vuelve al pueblo. Los capitanes de barco, el siguiente encargo de Cuernomar, son para tu parada en Tuercespina hacia el nivel 50.",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, en el piso superior",

	-- Step 13: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 14: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "El vuelo aterriza en {object:3202}: {npc:2519} y {npc:2465}, luego la torre del zepelín.",

	-- Step 15: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 16: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "El centro de {zone:1454}",

	-- Step 18: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. {npc:4752} entrena a los orcos en {object:172958}, junto a la perrera de {npc:3362}. Los cielonatos la aprenden con {npc:265756} en {area:17684}, en {area:16638}, en la Isla de Zephras, con un zancavendavales: el barco celeste a la isla sale de los acantilados al sur de {area:17045}, al norte de {zone:1456}, cada cinco minutos aprox. Las demás monturas de tu raza cuestan 20 de oro cada una: Coleccionables, Monturas · Nivel 40 tiene una guía para cada una.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Lobos: {npc:3362}, junto a {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Equitación y Zancavendavales: {npc:265756}, en {area:17684}, en {area:16638}, en la Isla de Zephras.",

	-- Step 20: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "Montar requiere nivel 40 y cuesta 100 de oro; al aprenderlo recibes una montura. Cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:7953} en {area:367}, a poca distancia al sur de {zone:1454} por el camino de {zone:1411}, con los raptores de Zjolnir (20 de oro cada uno) a su lado. Luego vuelve al maestro de vuelo de {zone:1454}.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instructor de equitación",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptores: Zjolnir, junto a {npc:7953}, en {area:367}.",

	-- Step 21: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 23: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "Tu instructor está en {zone:1456}: {npc:3033} (druidas) en {area:1639}, {npc:246344} (paladines).",

	-- Step 25: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. Cada raza la aprende del instructor de su raza: el tuyo es {npc:3690}, en {area:222}, con los kodos de {npc:3685} (20 de oro cada uno) a su lado. Después vuelve a subir al maestro de vuelo de {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instructor de equitación",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, junto a {npc:3690}, en {area:222}.",

	-- Step 26: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Vuela a {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 27: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",

	-- Step 30: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392}, por el Corcel vil",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "Vuela de {zone:1454} a {area:392}; {npc:6251} está en la colina sobre los muelles.",

	-- Step 31: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maestro de vuelo de {area:392}",

	-- Step 37: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "Al llegar volando: primero las misiones de {area:976}, junto al maestro de vuelo; luego {area:2240} está a poca distancia al norte, cruzando la frontera de {zone:1446}.",

	-- Step 38: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "Para tu incursión en {area:978}, en la siguiente guía: {quest:2864} quiere caparazones de escarabajo, y {npc:7804}, a poca distancia del maestro de vuelo, {quest:3042} de los trols Furiarena.",

	-- Step 39: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "Si llegaste volando a {area:976}: el circuito de carreras está a poca distancia a caballo al norte, cruzando la frontera de {zone:1446}.\nEl camino de {area:484} a {zone:1446} pasa por {area:2240} en {area:439}: {npc:4454} está en el campamento de los gnomos junto a la pista, {npc:4630} y {npc:4709} junto al campamento de los goblins. Primero {npc:4630}, luego {npc:4709}, que sale corriendo a entretener a Rizzle; después toma los planos de Rizzle del campamento de los gnomos y llévaselos a {npc:4630}.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}: {quest:1137}, de parte de Martek en {zone:1418}",

	-- Step 40: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "A {area:976}",

	-- Step 41: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} es el pueblo goblin amurallado justo pasada la frontera de {zone:1446}.",

	-- Step 43: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}: mátalos según te los encuentres",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Los bandidos y ladrones acampan en las dunas al este de {area:976}. Cualquier Deambulador puede llevar una bolsa de agua: Luglunket quiere cinco.\nCuidado: los Pícaros Deambuladores (nivel 43-44) se mueven en sigilo, así que pueden acercarse sin que los veas.",

	-- Step 45: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Cabalga hacia el noreste hasta Puerto Bonvapor, el puerto goblin de la costa.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, dentro",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, dentro",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}: los Pícaros estridadores del valle viven en {zone:1444}, en la próxima visita a {zone:1444}",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}, en el muelle: el encargo de Friz de {zone:2548}, si lo llevas",

	-- Step 46: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}: mátalos según te los encuentres",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Al sur por la costa, los piratas del Mar del Sur ocupan la cala. {npc:7883} y el cargamento robado están en los muelles del fondo. Cualquier pirata puede soltar un sombrero; los secuestradores, más a menudo.\nCuidado: dos o tres piratas acompañan a {npc:7883} (45), y muchos más piratas del pueblo se unen a la pelea en cuanto empieza: aleja primero a sus guardias de él.",
	["Upstairs"] = "Piso de arriba",

	-- Step 47: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}: mátalos según te los encuentres",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Los magos de las sombras, pícaros y asesinos acampan al sureste de {area:976}.\nAl sureste de Gadgetzan, los bandidos Erramundos acampan en las dunas; {npc:7847} está en el campamento del este.\nCuidado: Los pícaros Erramundos mantienen Acechar fuera de combate, así que pícaros ocultos pueden unirse a una pelea que empieces en un campamento.\nCuidado: Dos pícaros Erramundos en sigilo lo acompañan a donde vaya. En su campamento de aparición, dos magos de las sombras y sus esbirros están lo bastante cerca para unirse a la pelea. Fuera, junto a las torres, puedes pelear con él sin ellos.",

	-- Step 48: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "Vuelve al noreste, al puerto: {npc:7881}, {npc:15165} y el Jefe de seguridad reciben lo que te dio {area:1336}. {area:976} está al oeste.",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "para {area:35}, hacia el nivel 51 (40-50/06)",

	-- Step 50: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 52: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777} da vueltas por {area:1099}: búscalo dentro del círculo del mapa",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}: el encargo de {npc:263190} de {zone:2548}, si lo llevas",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, hacia el nivel 45",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, dentro",

	-- Step 53: Gordunni Outpost
	-- {npc:222233} Ohk'zi
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Al norte de los gnolls, los ogros ocupan un puesto en lo alto de una colina; atrae hacia ti a los magos ogros. El cobalto está en los montículos de tierra alrededor del puesto, y el pergamino está en el suelo, dentro.\nCuidado: {npc:222233} (nivel 43, élite) está en el puesto: atrae a los ogros hacia ti, lejos de él.",

	-- Step 54: Woodpaw north camp
	["Woodpaw north camp"] = "Campamento Zarpaleña del norte",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "Los gnolls Zarpaleña acampan en las colinas justo al noroeste de Mojache; cualquiera puede soltar una crin.\nCuidado: todos los gnolls Zarpaleña salvo el Alfa huyen a pedir ayuda al 15 % de salud, lo que puede atraer más gnolls al combate.",

	-- Step 55: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: dentro de una hora",

	-- Step 56: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}: mata a estos según te los encuentres",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "Los duendes dardo revolotean sobre la arboleda justo al oeste de Mojache; casi todos sueltan un ala. Los Alfas Zarpaleña dirigen los campamentos al suroeste: mátalos antes de una hora.\nCuidado: la mayoría de los Alfas están en pequeños campamentos de tiendas con 2-4 gnolls más que se unen al combate, y otros gnolls patrullan entre los campamentos.",

	-- Step 58: Grimtotem camp
	["Grimtotem camp"] = "Campamento Tótem Siniestro",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "Los tauren Tótem Siniestro acampan junto a la arboleda de los duendes dardo; asaltantes, naturalistas y chamanes llevan cuernos.\nCuidado: {npc:222286} (nivel 43, élite) está en el campamento: atrae a los asaltantes y chamanes lejos de ella.",

	-- Step 59: Woodpaw battle map
	["Woodpaw battle map"] = "Mapa de batalla Zarpaleña",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "El mapa de batalla está en el campamento Zarpaleña al sur de Mojache.",

	-- Step 60: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "para {zone:1454}, hacia el nivel 45",

	-- Step 61: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "La colmena Zukk'ash excava en las colinas al sureste del campamento; {quest:7731} espera en su cámara más profunda.\nCuidado: {quest:7731} es de nivel 47: limpia la colmena a su alrededor y atráelo solo, con la salud al máximo.",

	-- Step 62: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}: mátalos según te los encuentres",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "Cabalga hacia el oeste desde la colmena hasta las ruinas de ogros bajo {area:1105}. Están llenas de chamanes, brujos y destructores; los Señores de la Magia del extremo sur llevan el orbe.\nCuidado: los Señores de la Magia (45-46) y los chamanes lanzan hechizos a distancia y las ruinas están abarrotadas: atráelos de uno en uno desde el borde.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234} da vueltas por {area:2522}: búscalo dentro del círculo del mapa",

	-- Step 63: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "Yetis de {area:1105}",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Al noroeste de las ruinas, los yetis tienen su guarida en {area:1105}; cualquier yeti de ahí puede soltar un pellejo grueso.",

	-- Step 64: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "Solo con la baliza de socorro: cualquier bestia, gnoll u ogro de {zone:1444} puede soltarla, más o menos una vez cada cien; úsala para empezar la misión. El robot está en una pequeña cueva en el lado norte de {area:1105}, justo al noroeste de las ruinas. Escóltalo hasta el muelle de {area:1108}; yetis y gorilas te emboscan en el camino. Su recompensa espera en {area:35} para una visita posterior.\nCuidado: Aparecen tres emboscadas durante la escolta, y el robot te avisa antes de cada una. La primera son 3 yetis, justo después de que el robot sale de la cueva y sube hacia el camino. La segunda son 3 gorilas, en el sendero que corre junto al acantilado. La tercera son unos 4 gnolls, uno de ellos lanzador de hechizos, donde la ruta se desvía hacia el muelle.",

	-- Step 65: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "los yetis Cicatriz de Ira, en la próxima visita a {zone:1444}",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}: para {npc:7010} en {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "para {zone:1454}, después de {zone:2652}",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "{zone:2652} es lo siguiente, cabalgando al norte desde {area:1099} hasta {zone:1443}: guarda tus entregas de {zone:1454} (Neeru, Zilzibin, {npc:4485}, {npc:7311}) para el vuelo hasta allí después.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Eastern Wastewander camps"] = "Campamentos Deambulador del este",
	-- ["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Vuela a {area:1637}. Los hermanos Droffers tienen su tienda en La Calle Mayor.",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the {object:172959}."] = "Vuela a {area:1637}. Los hermanos Droffers tienen su tienda en {object:172959}.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Vuela a {area:484}, baja por el ascensor al este del puesto, cruza los llanos salados y sigue hacia el sur hasta {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Vuela a {area:484} y cabalga hacia el oeste por los cañones, pasando {area:2237}; el camino sube a la jungla de {zone:1444} y sigue hasta {area:1099}.",
	-- ["Fly to {area:75}"] = "Vuela a {area:75}",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Vuela a {zone:1454}. Desde el maestro de vuelo: {object:172960}, luego La Calada, luego {object:172958}.",
	-- ["Hearth to {area:1099}"] = "Piedra de hogar a {area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Sigue cabalgando hacia el oeste hasta la costa. Los Videnistas y Quebradores Reptacostas de las playas sueltan la baliza de socorro de OOX-22/FE aproximadamente una de cada cuarenta muertes: si cae, úsala para empezar la misión.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Solo con la baliza de socorro: el robot está en una cueva pequeña en el lado norte de {area:1105}. Escóltalo hasta el muelle de {area:1108}; yetis y gorilas te tienden emboscadas por el camino. Su recompensa te espera en {area:35} para una visita posterior.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Vuelve cabalgando hacia el noroeste desde {area:1978} hasta {area:75} y vuela a {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Vuelve cabalgando hacia el oeste hasta {area:976}.",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Cabalga hacia el oeste desde la colmena hasta las ruinas de ogros bajo {area:1105}. Están llenas de chamanes, brujos y destructores; los Señores de la Magia del extremo sur llevan el orbe.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Cabalga hacia el oeste hasta el centro de {zone:1444}. Mata a un {npc:5308}, usa {item:10699} en su cuerpo y mata al espíritu que surge.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. En Classic cada raza la aprende del instructor de su raza: la tuya es {npc:4773}, en {area:159}, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Puede que en Forever cualquier raza aprenda de cualquier instructor de equitación (sin confirmar): prueba primero con {npc:4752} en {object:172958} de {zone:1454}, que es el más cercano, y sáltate este paso si te entrena.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. En Classic cada raza la aprende del instructor de su raza: el tuyo es {npc:7953}, en {area:367}, en la costa de {zone:1411}, con los raptores de Zjolnir (20 de oro cada uno) a su lado. Puede que en Forever cualquier raza aprenda de cualquier instructor de equitación (sin confirmar): prueba primero con {npc:4752} en {object:172958} de {zone:1454}, que es el más cercano, y sáltate este paso si te entrena.",
	-- ["Rogue Vale screechers"] = "Pícaros estridadores del valle",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Caballos esqueléticos: {npc:4731}, junto a {npc:4773}, en {area:159}.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Al sur por la costa, los piratas del Mar del Sur ocupan la cala. {npc:7883} y el cargamento robado están en los muelles del fondo. Cualquier pirata puede soltar un sombrero; los secuestradores, más a menudo.\nCuidado: dos o tres piratas acompañan a {npc:7883}, y muchos más piratas del pueblo se unen a la pelea en cuanto empieza.",
	-- ["Southern Gordunni ruins"] = "Ruinas Gordunni del sur",
	-- ["Southern Wastewander camps"] = "Campamentos Deambulador del sur",
	-- ["Sprite darters and Woodpaw alphas"] = "Duendes dardo y Alfas Zarpaleña",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "La colmena Zukk'ash excava en las colinas al sureste del campamento; {quest:7731} espera en su cámara más profunda.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Los bandidos y ladrones acampan en las dunas al este de {area:976}. Cualquier Deambulador puede llevar una bolsa de agua: guarda diez, cinco para cada una de las recompensas de Luglunket.\nCuidado: los Pícaros Vagayermo (nivel 43-44) se mueven en sigilo, así que pueden acercarse sin que los veas.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Los magos oscuros, pícaros y asesinos acampan al sureste de {area:976}.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "El zepelín a {object:3202} sale de la torre justo al noreste de la puerta principal de {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "El zepelín a {zone:1454} sale de la torre junto a {object:3202}; aterriza justo fuera de la puerta principal de {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, la maestra de vuelo, está justo al este de la torre del zepelín. Vuela a {area:75}: allí empieza la siguiente guía.",
	-- ["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["for the {zone:1425}, around level 48"] = "para {zone:1425}, hacia el nivel 48",
	-- ["for {area:35}, around level 50"] = "para {area:35}, hacia el nivel 50",
	-- ["the {object:150075} in the square"] = "{object:150075} de la plaza",
	-- ["water pouches in your bags"] = "bolsas de agua en tus bolsas",
	-- ["{area:1099} flight master"] = "Maestro de vuelo de {area:1099}",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} es el pueblo goblin amurallado justo pasada la frontera de {area:440}.",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}: {item:5852} de {npc:2496}, si los llevas",
	-- ["{npc:4706}, beside {npc:4630}"] = "{npc:4706}, junto a {npc:4630}",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}, La Calle Mayor",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}, La Calada",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, instructor de equitación",
}
