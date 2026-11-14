-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows · {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay · {area:75} Stonard
	["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} y {zone:1435} a nivel 40-43: {object:3202}, los piratas de {area:35}, las cacerías de Nesingwary y {area:75}.",

	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Tu entrenamiento de nivel 40 está en {area:1497}: vuela ahí desde {area:340}, entrena y toma el zepelín desde las torres de afuera de la ciudad hasta {object:3202}.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maestro de vuelo de {area:340}",

	-- Step 2: Undercity trainers
	-- {area:1497} Undercity
	["{area:1497} trainers"] = "Instructores de {area:1497}",

	-- Step 3: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Montar requiere nivel 40 y cuesta 100 de oro; al aprenderlo recibes una montura. Cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:4773} en {area:159}, a poca distancia al norte de las torres del zepelín, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Vuelve a las torres para el zepelín a {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Caballos esqueléticos: {npc:4731}, junto a {npc:4773} en {area:159}.",

	-- Step 4: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",

	-- Step 5: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",

	-- Step 6: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "{npc:2519}: la leyenda está en Zul'Kunda, adonde va esta guía para {npc:1061}",

	-- Step 7: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Los Acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.",

	-- Step 9: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maestro de vuelo de {object:3202}",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Gringer, el maestro de vuelo, espera en la cubierta superior de {area:35}. Los que dan misiones están en los muelles alrededor del puerto y en la posada.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495}: las pieles Bocaquebrada que juntaste antes; adentro",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: el {npc:2635} toma el sol en la costa entre Zul'Kunda y {object:3202}, más adelante en este recorrido",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, en los muelles: la carta de Gazlowe, si la llevas",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, en el balcón junto a MacKinley",
	["Inside"] = "Adentro",

	-- Step 11: Baron Revilgaz
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496}, en el balcón junto a MacKinley, tiene un encargo más: los planos del regulador de combustible del baúl de Cozzle van para Pozzik en {area:2240}, de camino a {zone:1446} cerca del nivel 43.",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Sal del pueblo por el túnel; la nota está en la cala de los piratas justo al norte de {area:35}.",

	-- Step 14: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas Velo de Bruma",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Los gorilas deambulan por el valle alrededor de Unbagwa. Los ancianos sueltan las menudencias; cualquiera puede soltar un colmillo.",

	-- Step 15: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Entrega los colmillos a Unbagwa y quédate a su lado: invoca tres oleadas de gorilas y luego a {npc:1514}. Pelea con ellos de uno en uno.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "Dentro de {area:1742}",

	-- Step 17: Venture Co. mine
	["Venture Co. mine"] = "Mina de Ventura y Cía.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Más al norte, los goblins de Ventura y Cía. excavan en la mina al este del camino; mineros, capataces, topógrafos y manitas sueltan los cristales.\nCuidado: Panteras Fauceumbría y tigresas de Tuercespina en sigilo rondan la zona alrededor del campamento.",

	-- Step 19: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Nesingwary",
	["Head north up the road; the hunters camp on the hill above the river."] = "Sube al norte por el camino; los cazadores acampan en la colina sobre el río.",

	-- Step 21: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} colecciona las páginas de {quest:338}: los trols del valle las sueltan de vez en cuando. Toma su misión; recibe cada capítulo una vez que tengas todas sus páginas.",

	-- Step 22: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo I",

	-- Step 23: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo II",

	-- Step 24: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo III",

	-- Step 25: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo IV",

	-- Step 26: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: los cuatro capítulos",

	-- Step 27: Zul'Kunda
	["Zul'Kunda"] = "Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "Al oeste de la expedición, los jefes Sangrapellejo {npc:1061} y {npc:1062} están juntos en las ruinas de Zul'Kunda. Limpia antes sus guardias y luego atráelos. Quédate con los Sangrapellejo aquí hasta el nivel 41: {quest:586}, en el caldero a continuación, te envía contra Machacacráneos de nivel 41-43.\nEn la costa entre Zul'Kunda y {object:3202}, un {npc:2635} (élite de nivel 38) comparte los puntos de aparición de los crocoliscos normales: mátalo si está presente y toma su piel para {npc:2495}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "de {object:52}, en las ruinas",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "sube de nivel con los Sangrapellejo de aquí: {quest:586}, en el caldero a continuación, te manda a por Partecráneos de 41-43",

	-- Step 28: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: para {zone:1425}, alrededor del nivel 48",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}: los cráneos trofeo están en las ruinas Partecráneos, más adelante en este recorrido",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: la entrada de la caverna bajo {area:104}, al oeste del campamento",

	-- Step 29: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol (no name in this language: may be words) · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: al oeste de {object:3202}, nada sobre {area:104} y bucea hasta la entrada de la caverna en el arrecife; la misión se completa al encontrarla. Deja la caverna por ahora: los acechadores de la selva están al sur, a lo largo de la costa.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "la entrada de {area:16550}, bajo el agua",

	-- Step 30: Jungle stalkers
	["Jungle stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Los raptores acechadores cazan en la jungla al sur de {object:3202}, hacia la costa oeste.",

	-- Step 31: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}: mata a estos según te los encuentres",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Sigue la costa al sur. Los expedicionarios naga vadean por la orilla y llevan los fardos de juncos; {object:759} burbujea en las colinas justo al este de ellos.",

	-- Step 32: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Ve al sur, hasta {area:35}. Phillipe el Tembloroso espera en los muelles.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, en la posada: sus botellas llegan a la costa de {zone:1425}, alrededor del nivel 48",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "{npc:737}, en el piso de arriba: los colmillos los sueltan los Partecráneos, más adelante en este recorrido",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "MacKinley, en el piso superior: para Stoley en {zone:1446}",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, adentro: {item:4105}",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, en el piso superior",

	-- Step 33: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Al sur de Bahía del Botín, los espadachines Velasangre acampan en {area:43}; las cartas y las órdenes están en sus tiendas y en el bote de remos junto al campamento más grande. Cualquier Velasangre puede llevar tabaco rapé y el ojo de {npc:2493}, así que sigue matando hasta tener ambos.",

	-- Step 35: The Bloodsail ships
	["The Bloodsail ships"] = "Los barcos Velasangre",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Opcional, y difícil a nivel 42: el pergamino, {quest:624}, está en las cubiertas de los tres barcos frente a {area:43}, con tripulaciones de piratas de 42-45 que van en parejas. Tómala solo si puedes atraer a la tripulación a la borda de a uno, o con un amigo; su cadena sigue por {zone:1435}, {zone:1445} y {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para una parada posterior en {zone:1435}",

	-- Step 36: Zanzil's camps
	["Zanzil's camps"] = "Campamentos de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Al noreste del Velo de Bruma, los seguidores de Zanzil acampan en la jungla; cualquiera de ellos puede llevar la mezcla.",

	-- Step 37: Pirate ghosts
	["Pirate ghosts"] = "Piratas fantasma",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Los tres piratas fantasmales rondan la jungla al norte de {area:35}, cerca de los campamentos de Zanzil: {npc:2535} y {npc:2536} están juntos, y {npc:2537}, más al este.",

	-- Step 38: Zul'Mamwe
	["Zul'Mamwe"] = "Ruinas de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Ve al norte hasta las ruinas Partecráneos al este de la mina de Ventura y Cía.; atrae a los cazacabezas y rabiosos de a uno. {npc:1059} custodia las ruinas del suroeste, y una pila de cráneos trofeo está en el lado norte de las ruinas. Cualquier Partecráneos puede soltar un colmillo o un collar: los collares son lo lento, así que sigue matando en el campamento de los guerreros al norte de las ruinas hasta tenerlos todos.",
	["Skullsplitter warriors"] = "Guerreros Machacacráneos",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} da vueltas por aquí: búscalo dentro del círculo del mapa",
	["Below ground"] = "Bajo tierra",

	-- Step 39: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "{area:127}: mata a estos según te los encuentres",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Los siguientes cráneos trofeo están en las pequeñas ruinas justo al norte del campamento de los guerreros.\nLos últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",

	-- Step 40: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Ve al oeste, hasta {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "{object:2076} otra vez: el destino de Yenniku",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "{npc:2519}: los basiliscos pastan junto al camino de vuelta desde {area:35}",

	-- Step 42: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, adentro",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, en el piso de arriba: para {quest:2864} en {area:976}",

	-- Step 43: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "Sal de {area:35} hacia el norte por el camino; los basiliscos toman el sol en las rocas al este del camino, en medio de la selva, de camino de vuelta a {object:3202}. Sus fragmentos caen seguido.",

	-- Step 44: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride on north to {object:3202}."] = "Sigue al norte hasta {object:3202}.",

	-- Step 46: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Sube al norte por el camino hasta el campamento de los cazadores.",

	-- Step 48: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:730} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",

	-- Step 49: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:728} es élite de nivel 40: la mayoría de las clases lo hacen solas a nivel 42, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",

	-- Step 53: Level 42.68
	["Level 42.68"] = "Nivel 42.68",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "Si omitiste {quest:192} o {quest:195}, sube de nivel aquí hasta 42.68 para seguir el plan de la ruta.",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "sube de nivel con {npc:667}",

	-- Step 54: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:731} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.\nCuidado: Tigres y panteras Fauceumbría en sigilo rondan cerca de él. Despéjalos antes de atraerlo. Cuando lo atraes, {npc:731} pide ayuda a las criaturas en 20 m.",

	-- Step 56: Level 42.74
	["Level 42.74"] = "Nivel 42.74",
	-- {quest:208} Big Game Hunter
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "Si omitiste {quest:208}, sube de nivel aquí hasta 42.74 para seguir el plan de la ruta.",

	-- Step 60: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "A {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Sigue el camino al este desde {zone:1431} por {zone:1430} hasta el pantano. {npc:1776} espera en {area:657}, el campamento draenei justo al lado del camino donde entra desde {zone:1430}.",

	-- Step 61: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Ve al este hasta {area:75}, entre los juncos al sur del camino.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, adentro",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, en el piso de arriba",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, en el piso superior",

	-- Step 62: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Los crocoliscos se revuelcan en los charcos alrededor del campamento de {npc:5391} y al sur hacia {area:75}; más o menos uno de cada cuatro suelta un flanco.",

	-- Step 63: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru deambula por el claro al suroeste de {area:76}; su garrote inicia una misión.",

	-- Step 64: Draenethyst crystals
	["Draenethyst crystals"] = "Cristales draenetistas",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cabalga al noreste hasta {area:76}. Los cristales están a lo largo del camino que sube a la jaula de {npc:5391}.",

	-- Step 65: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está prisionero en {area:76}, en el noreste del pantano. Libéralo y síguelo hacia afuera, rechazando a las criaturas del pantano que lo persiguen.",

	-- Step 66: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "Su caja fuerte espera en su antiguo campamento al norte de {area:75}, de camino de vuelta al oeste.",

	-- Step 67: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Ve al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}. {quest:698} va para {npc:5592} en {area:1978} en la próxima visita al pantano: guarda los flancos.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Barco a {area:35}",
	-- ["Fly to {area:392}"] = "Vuela a {area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "Desde {area:2408} vuela a {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Más al norte, los goblins de Ventura y Cía. excavan en la mina al este del camino; los canteros, supervisores, peritos y manitas sueltan los cristales.",
	-- ["Hearth to {area:35}"] = "Usa la piedra de hogar para ir a {area:35}",
	-- ["Hearth to {object:3202}"] = "Usa la piedra de hogar para ir a {object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "Su caja fuerte espera en su antiguo campamento al norte de {area:75}.",
	-- ["Into the {area:8}"] = "A {area:8}",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Sigue cabalgando al norte hacia {zone:1431} y luego al este por el camino a través de {zone:1430} hasta el pantano. {npc:1776} espera en {area:657}, el campamento draenei cerca de la entrada desde {zone:1430}.",
	-- ["Naga shore and the {object:759}"] = "Orilla de los nagas y {object:759}",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Cabalga de vuelta al este pasando {area:75} y sigue el camino al sureste hasta el pequeño puesto de la Horda en la orilla.",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "Cabalga al este hasta {area:75}, entre los juncos al sur del camino.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Cabalga al norte hasta las ruinas Machacacráneos al este de la mina de Ventura y Cía.; atrae a los rebanacabezas y rabiosos de uno en uno. {npc:1059} protege las ruinas del suroeste, y un montón de cráneos trofeo está en el lado norte de las ruinas. Cualquier Machacacráneos puede soltar un colmillo o un collar: los collares son la parte lenta, así que sigue matando en el campamento de guerreros al norte de las ruinas hasta tenerlos todos.",
	-- ["Ride north up the road to the hunters' camp."] = "Cabalga al norte por el camino hasta el campamento de los cazadores.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Cabalga al norte por el camino; los cazadores acampan en la colina sobre el río.",
	-- ["Ride north-west to {object:3202}."] = "Cabalga al noroeste hasta {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Cabalga al sur hasta {area:35}. Phillipe el Trémulo espera en los muelles.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Cabalga al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}.",
	-- ["Ride west to {object:3202}."] = "Cabalga al oeste hasta {object:3202}.",
	-- ["Sawtooth snappers"] = "Sacudidores Denteserra",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Toma el camino al norte desde {area:35}; Unbagwa está en una colina en {area:1737}, al este del camino.",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "El barco llega al puerto de {area:35}. Los asignadores de misiones están en los paseos de madera alrededor del puerto y en la posada.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "El barco a {area:35} atraca al final del muelle de {area:392}.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Los últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "La siguiente guía empieza aquí y te lleva a {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Los siguientes cráneos trofeo están en las pequeñas ruinas justo al norte del campamento de guerreros.",
	-- ["The snappers line the strand south of the post."] = "Los sacudidores bordean la playa al sur del puesto.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Los tres barcos están frente a {area:43}. Las tripulaciones son de nivel 42-45, Aguasmansas 45, Sinquilla 46 y {npc:2546} 48: a nivel 41 es una pelea para un grupo o para el final de la guía. Si vas, nada hasta allí y atrae a la tripulación a la borda de uno en uno. Un pergamino, {quest:624}, está en las cubiertas de los barcos: tómalo.",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "Al oeste de la expedición, los jefes Sangrapellejo {npc:1061} y {npc:1062} están juntos en las ruinas de Zul'Kunda. Limpia antes sus guardias y luego atráelos.",
	-- ["for Stoley in {zone:1446}"] = "para Stoley en {zone:1446}",
	-- ["for a later stop in the {area:8}"] = "para una parada posterior en {area:8}",
	-- ["for later: the {zone:1425}, around level 48"] = "para más adelante: {zone:1425}, alrededor del nivel 48",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- ["{area:392} pier"] = "Muelle de {area:392}",
	-- ["{npc:6807}, upstairs"] = "{npc:6807}, en el piso de arriba",
	-- ["{npc:6930}, upstairs"] = "{npc:6930}, en el piso de arriba",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: para {quest:2864} en {area:976}",
}
