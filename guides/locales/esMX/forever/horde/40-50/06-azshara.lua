-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "Maestro de vuelo de {area:75}",

	-- Step 3: Booty Bay
	-- {area:75} Stonard · {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["The flight from {area:75} lands on {area:35}'s upper deck. {npc:7406} has his workshop on the upper ring of the bay."] = "El vuelo desde {area:75} aterriza en la plataforma superior de {area:35}. {npc:7406} tiene su taller en el anillo superior de la bahía.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}, adentro",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}, en la posada",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "{npc:2487}, en el balcón del mismo edificio",

	-- Step 4: The Bloodsail ships
	["The Bloodsail ships"] = "Los barcos Velasangre",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "Al sur de Bahía del Botín, tres barcos Velasangre están frente a {area:43}: {npc:2550}, {npc:2548} y {npc:2546} están cada uno en una cubierta con su tripulación. Nada hasta ellos y ve de barco en barco.",

	-- Step 6: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {quest:8552} necesita un grupo de 2. Omítela si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 12: Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp · {npc:2497} Nimboya · {object:2076} Bubbling Cauldron
	["The flight lands at {area:117}; {npc:2497} stands by the {object:2076}."] = "El vuelo aterriza en {area:117}; {npc:2497} está junto a {object:2076}.",

	-- Step 13: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "De vuelta a {object:3202}",

	-- Step 14: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:818} (élite de nivel 47) necesita un grupo de 2. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.\nCuidado: Dos guardias lanzadores de hechizos élite, de nivel 45 más o menos, están con {npc:818} y se unen a la pelea junto con él.",
	["Below ground"] = "Bajo tierra",

	-- Step 18: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 19: Zilzibin Drumlore
	-- {zone:1454} Orgrimmar · {npc:7010} Zilzibin Drumlore · {zone:1446} Tanaris · {zone:1447} Azshara
	["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}, and its experience shortens the top-up to 50 in {zone:1447}."] = "De camino por {zone:1454} hacia el maestro de vuelo, pasa por la Calle Mayor: {npc:7010} recibe el informe de insectos de {zone:1446}, y su experiencia acorta lo que falta para llegar a 50 en {zone:1447}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, la Calle Mayor",

	-- Step 20: Dran Droffers
	["The Droffers' shop is a few steps further into the Drag."] = "La tienda de los Droffers está unos pasos más adentro de la Calle Mayor.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, calle comercial de Orgrimmar",

	-- Step 22: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Cabalga hacia {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Cabalga al este por el camino desde Puesto del Hachazo. {npc:11548} espera en {area:1235}, a un lado del camino, a unos pasos al oeste de {area:3137} de la Alianza: llega desde el oeste y mantente lejos de los Centinelas de Azshara ({npc:11276}) y de Jarrodenus (élite).",

	-- Step 23: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}: mata a estos según te los encuentres",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Los fantasmas Altonato rondan las ruinas justo al norte del santuario; los sátiros Haldarr acampan un poco más al norte.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117} da vueltas por {area:1235}: búscalo dentro del círculo del mapa",

	-- Step 24: Level 50
	["Level 50"] = "Nivel 50",
	-- {quest:4493} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it."] = "Completa aquí hasta el nivel 50: {quest:4493}, de {npc:7010} en {zone:1454} al final de {zone:1447}, lo necesita.",
	-- {npc:6125} Haldarr Satyr
	["grind on {npc:6125}"] = "sube de nivel con {npc:6125}",

	-- Step 25: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Regresa con {npc:11548} al santuario; mantente al oeste de los guardias de {area:3137}.",

	-- Step 26: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Sigue el camino al norte hasta {area:1237}, el campamento de la Horda.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, en el borde este del campamento: no da experiencia, solo un teletransporte a una torre de Azshara",

	-- Step 28: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Plumas de hipogrifo sin estropear",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Los Hipogrifos Tronatesta vuelan sobre las colinas justo al sur de {area:1237}.",

	-- Step 30: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Cabalga al noreste hasta el campamento del goblin en los acantilados sobre {area:1227}.",

	-- Step 31: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "El campamento de los elfos de sangre está justo al sur de {npc:8420}. Sus cuatro piezas de equipo están en las cajas alrededor del campamento.",

	-- Step 33: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: mata a estos según te los encuentres",
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Cabalga al suroeste hasta las ruinas. Las cuatro tablillas están entre las ruinas, custodiadas por nagas Látigo de Ira; cualquier Sirena o Mirmidón puede llevar la runa de {npc:8420}.",

	-- Step 34: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Regresa al noreste con {npc:8420}.",

	-- Step 35: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Cabalga al oeste de vuelta a {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Guarda las entregas para {npc:4046}, {npc:8659} y {npc:6522}: pasas por {zone:1456}, {zone:1454} y {zone:1458} más adelante.",

	-- Step 36: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "La torre de Xylem está en el acantilado justo al norte de {area:1237}; el sendero sube serpenteando por su lado norte.",
	["Upstairs"] = "Arriba",

	-- Step 38: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Maestro de vuelo de {area:1237}",

	-- Step 39: Orgrimmar
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag: if you still carry it"] = "{npc:7010}, la Calle Mayor: si aún lo llevas",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, en {object:172960}",

	-- Step 40: Orgrimmar
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Guarda el pago de {npc:8659} y {quest:3504} de Ag'tor: vuelven a {area:1237} en una visita posterior.",

	-- Step 41: Paladin trainer
	["Paladin trainer"] = "Instructor de paladines",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} en {zone:1456}; {zone:1454} no tiene instructor de paladines",

	-- Step 42: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 43: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Vuela a {zone:1456}; está camino a {area:1099}. ¿Aún no tienes esa ruta de vuelo? Vuela a {area:378} y cabalga al oeste por {zone:1412}. Hamuul y {npc:4046} están en {area:1639}; los druidas y paladines entrenan aquí ({npc:3033}, {npc:246344}).",
	-- {npc:6746} Innkeeper Pala
	["{npc:6746}, at the inn: for Hamuul"] = "{npc:6746}, en la posada: para Hamuul",
	-- {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{npc:5769}, on the {area:1639}"] = "{npc:5769}, en {area:1639}",

	-- Step 44: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 45: Thunder Bluff
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} se reúne en la siguiente guía; el pago de {npc:4046} vuelve a {npc:8587} más adelante.",

	-- Step 46: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 47: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: los osos están en {zone:1448}",

	-- Step 48: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Hipogrifos Plumavieja",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Los hipogrifos anidan en las colinas al suroeste del campamento. Mata uno y usa la Vasija de muisek de hipogrifo sobre su cuerpo.",

	-- Step 49: Hippogryph nests
	["Hippogryph nests"] = "Nidos de hipogrifo",
	-- {area:2522} Ruins of Isildien · {object:142071} Egg-O-Matic
	["The hippogryph nests are on the hills to the south, around the {area:2522}; each holds an egg for the {object:142071}."] = "Los nidos de hipogrifo están en las colinas al sur, alrededor de {area:2522}; cada uno contiene un huevo para {object:142071}.",

	-- Step 51: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Duendes dardo",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Los dragones feéricos revolotean por el bosque justo al oeste del campamento. Usa la vasija en cada uno que mates.",

	-- Step 53: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Caminabosques deambulantes",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Los antárboles deambulan por los caminos del bosque entre el campamento y el centro de {zone:1444}; hay pocos, así que búscalos por los senderos.",

	-- Step 56: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: mata a estos según te los encuentres",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray · Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Los elementales marinos y las espumas marinas recorren la orilla alrededor del muelle.\nLos caminantes terrestres y los gigantes del acantilado recorren las colinas al norte del muelle. Primero dale a cada uno con {item:18904}: reducidos, ya no son élite. Cada gigante reducido suelta residuo; usa también la Vasija Muisek sobre su cuerpo.",

	-- Step 58: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "De vuelta a {area:1099}",

	-- Step 59: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maestro de vuelo de {area:1099}",

	-- Step 60: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, adentro",

	-- Step 62: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, junto al maestro de jinetes del viento",
	-- {object:142071} Egg-O-Matic
	["The {object:142071}, in the middle of town"] = "{object:142071}, en el centro del pueblo",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "El alquitrán de {npc:7876} y las muestras de Morterozugg vienen de {zone:1449}.",

	-- Step 63: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Cabalga al sur por el camino hasta {area:1938}; {npc:7771} acampa al lado. Desde aquí, el camino al oeste baja a {zone:1449}, donde empieza la siguiente guía.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Guarda {quest:3444}: el cofre de {npc:7771} se abre en una visita posterior.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Vuela de {area:1237} a {zone:1454}, sal por la puerta principal hacia las torres de zepelín y toma el zepelín a {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Sigue el camino al sur; los basiliscos toman el sol en las rocas al este, en medio de la selva. Sus fragmentos caen a menudo.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "Desde el maestro de vuelo de {area:3317}, vuela a {area:1497}.",
	-- ["Highborne and Haldarr satyrs"] = "Altonato y sátiros Haldarr",
	-- ["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Guarda {area:1417} para {npc:7771} en {zone:1446}.",
	-- ["Only once all three robots are home"] = "Solo cuando los tres robots estén en casa",
	-- ["Ride into {area:16}"] = "Cabalga hacia {area:16}",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Cabalga al noroeste hasta {area:1108}; {npc:14637} espera en el muelle.",
	-- ["Sea elementals"] = "Elementales de mar",
	-- ["Take the zeppelin back to {zone:1454}."] = "Toma el zepelín de vuelta a {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Toma el zepelín a {zone:1454} en la torre fuera de {zone:1458} y luego vuela a {area:431}.",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Los Caminatierras y los Gigantes del risco recorren las colinas al norte del muelle. Primero dispárales con {item:18904}: encogidos, ya no son élite. Cada gigante encogido suelta residuo; usa también la Vasija de muisek de gigante montés sobre su cuerpo.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Los Elementales de mar y los Rocíos del mar recorren la orilla alrededor del muelle.",
	-- ["The {object:2076} beside {npc:2519}"] = "El {object:2076} junto a {npc:2519}",
	-- ["To {object:3202}"] = "A {object:3202}",
	-- ["Zapped giants"] = "Gigantes encogidos",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: los osos están en {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} está en {object:36082}.",
	-- ["{object:3202} flight master"] = "Maestro de vuelo de {object:3202}",
}
