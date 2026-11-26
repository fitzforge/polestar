-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:35} Booty Bay · {zone:1447} Azshara · {zone:1444} Feralas · {zone:1446} Tanaris
	["{area:35} first, then {zone:1447}, {zone:1444} and {zone:1446}."] = "Primero {area:35}, luego {zone:1447}, {zone:1444} y {zone:1446}.",

	-- Step 2: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",

	-- Step 3: Booty Bay
	-- {area:75} Stonard · {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["The flight from {area:75} lands on {area:35}'s upper deck. {npc:7406} has his workshop on the upper ring of the bay."] = "El vuelo desde {area:75} aterriza en la plataforma superior de {area:35}. {npc:7406} tiene su taller en el anillo superior de la bahía.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}, adentro",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley, on the top floor: Stoley's shipment from {zone:1446}"] = "MacKinley «Lobo de Mar», en el piso superior: el cargamento de Stoley de {zone:1446}",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "{npc:2487}, en el balcón del mismo edificio",

	-- Step 4: Whiskey Slim
	-- {npc:2491} Whiskey Slim · {area:35} Booty Bay
	["{npc:2491} sits in the {area:35} inn."] = "{npc:2491} está sentado en la posada de {area:35}.",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}, en la posada",

	-- Step 5: The Bloodsail ships
	["The Bloodsail ships"] = "Los barcos Velasangre",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "Al sur de Bahía del Botín, tres barcos Velasangre están frente a {area:43}: {npc:2550}, {npc:2548} y {npc:2546} están cada uno en una cubierta con su tripulación. Nada hasta ellos y ve de barco en barco.",

	-- Step 7: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {quest:8552} necesita un grupo de 2. Omítela si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",

	-- Step 12: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 13: Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp · {npc:2497} Nimboya · {object:2076} Bubbling Cauldron
	["The flight lands at {area:117}; {npc:2497} stands by the {object:2076}."] = "El vuelo aterriza en {area:117}; {npc:2497} está junto a {object:2076}.",

	-- Step 14: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "De vuelta a {object:3202}",

	-- Step 15: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:818} (élite de nivel 47) necesita un grupo de 2. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.\nCuidado: Dos guardias lanzadores de hechizos élite, de nivel 45 más o menos, están con {npc:818} y se unen a la pelea junto con él.",
	["Below ground"] = "Bajo tierra",

	-- Step 17: Saving Yenniku
	["while he is alive: the gem fills; don't kill him"] = "mientras esté vivo: la gema se llena; no lo mates",
	-- {item:3912} Soul Gem
	["Use the {item:3912} on Yenniku"] = "Usa {item:3912} en Yenniku",

	-- Step 19: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 20: Zilzibin Drumlore
	-- {zone:1454} Orgrimmar · {npc:7010} Zilzibin Drumlore · {zone:1446} Tanaris
	["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}."] = "De camino por {zone:1454} hacia el maestro de vuelo, pasa por la Calle Mayor: {npc:7010} recibe el informe de insectos de {zone:1446}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, la Calle Mayor",

	-- Step 21: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1447} Azshara · {area:1237} Valormok
	["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, it waits: if you reach 50 in {zone:1447}, this guide brings you back for it from {area:1237}; else the {zone:1447} guide at 55 offers it again."] = "{quest:4494} requiere nivel 50: {npc:7010}, en la Calle Mayor, la da a partir de entonces. Si tienes menos de 50, espera: si llegas a 50 en {zone:1447}, esta guía te trae de vuelta por ella desde {area:1237}; si no, la guía de {zone:1447} a nivel 55 la ofrece de nuevo.",

	-- Step 22: Dran Droffers
	["The Droffers' shop is a few steps further into the Drag."] = "La tienda de los Droffers está unos pasos más adentro de la Calle Mayor.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, calle comercial de Orgrimmar",

	-- Step 23: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172959} The Drag · {quest:4300} Bone-Bladed Weapons · {zone:1447} Azshara
	["{npc:8659}, in {object:172959}, upstairs in one of its tallest buildings, has {quest:4300} for later; then your class trainer before you leave for {zone:1447}."] = "",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 24: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {object:172957} Valley of Wisdom · {npc:4791} Nazeer Bloodpike · {zone:1445} Dustwallow Marsh
	["{npc:4047} stands in the {object:172957}: {npc:4791}'s report from {zone:1445}."] = "{npc:4047} está en el {object:172957}: el informe de {npc:4791} desde {zone:1445}.",

	-- Step 26: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Cabalga hacia {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Cabalga al este por el camino desde Puesto del Hachazo. {npc:11548} espera en {area:1235}, a un lado del camino, a unos pasos al oeste de {area:3137} de la Alianza: llega desde el oeste y mantente lejos de los Centinelas de Azshara ({npc:11276}) y de Jarrodenus (élite).",

	-- Step 27: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}: mata a estos según te los encuentres",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Los fantasmas Altonato rondan las ruinas justo al norte del santuario; los sátiros Haldarr acampan un poco más al norte.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117} da vueltas por {area:1235}: búscalo dentro del círculo del mapa",

	-- Step 28: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Regresa con {npc:11548} al santuario; mantente al oeste de los guardias de {area:3137}.",

	-- Step 29: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Sigue el camino al norte hasta {area:1237}, el campamento de la Horda.",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {zone:1447} Azshara · {area:1637} Orgrimmar · {quest:4493} March of the Silithid · {zone:1456} Thunder Bluff
	["You reached 50 in {zone:1447}: fly back to {area:1637} for {quest:4493} and your level 50 training, then on to {zone:1456}."] = "Llegaste a 50 en {zone:1447}: vuela de vuelta a {area:1637} por {quest:4493} y tu entrenamiento de nivel 50, y luego sigue a {zone:1456}.",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Maestro de vuelo de {area:1237}",

	-- Step 31: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} is in the Drag; your class trainer next."] = "{npc:7010} está en la Calle Mayor; luego tu instructor de clase.",

	-- Step 32: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 34: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and Magatha are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Vuela a {zone:1456}; está camino a {area:1099}. ¿Aún no tienes esa ruta de vuelo? Vuela a {area:378} y cabalga al oeste por {zone:1412}. Hamuul y Magatha están en {area:1639}; los druidas y paladines entrenan aquí ({npc:3033}, {npc:246344}).",
	-- {npc:6746} Innkeeper Pala
	["{npc:6746}, at the inn: for Hamuul"] = "{npc:6746}, en la posada: para Hamuul",
	-- {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{npc:5769}, on the {area:1639}"] = "{npc:5769}, en {area:1639}",

	-- Step 35: Thunder Bluff
	-- {quest:3761} Un'Goro Soil
	["{quest:3761} is gathered in the next guide."] = "{quest:3761} se recolecta en la siguiente guía.",

	-- Step 36: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 38: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i
	["{npc:8115}, if you don't carry it yet: the materials come on this loop"] = "{npc:8115}, si todavía no la llevas: los materiales vienen en este recorrido",
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: los osos están en {zone:1448}",
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}: the Northspring harpies, at the far end of this loop"] = "{npc:7776}: las arpías Nortearroyo, en el otro extremo de este recorrido",

	-- Step 39: Talo Thornhoof
	-- {quest:3062} Dark Heart · {npc:8075} Edana Hatetalon
	["{quest:3062}: {npc:8075} (level 50, elite) roosts above the Northspring harpies this loop ends at. Grouping up is advised: skip it if you are alone."] = "{quest:3062}: {npc:8075} (nivel 50, élite) anida sobre las arpías Nortearroyo donde termina este recorrido. Se recomienda ir en grupo: omítela si vas solo.",

	-- Step 40: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Hipogrifos Plumavieja",
	-- {quest:3128} Natural Materials
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body. Nearly every one also drops the sinew and metallic fragments for {quest:3128}."] = "Los hipogrifos anidan en las colinas al suroeste del campamento. Mata uno y usa la vasija Muisek sobre su cuerpo. Casi todos también sueltan el tendón y los trozos metálicos para {quest:3128}.",

	-- Step 41: Hippogryph nests
	["Hippogryph nests"] = "Nidos de hipogrifo",
	-- {area:2522} Ruins of Isildien · {object:142071} Egg-O-Matic
	["The hippogryph nests are on the hills to the south, around the {area:2522}; each holds an egg for the {object:142071}."] = "Los nidos de hipogrifo están en las colinas al sur, alrededor de {area:2522}; cada uno contiene un huevo para {object:142071}.",

	-- Step 43: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Duendes dardo",
	-- {item:9589} Encrusted Minerals
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill; they carry the {item:9589} too."] = "Los dragones feéricos revolotean por el bosque justo al oeste del campamento. Usa la vasija en cada uno que mates; también llevan los {item:9589}.",

	-- Step 45: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Caminabosques deambulantes",
	-- {zone:1444} Feralas · {npc:272401} Vale Screamer
	-- plural, as words: Splintered Logs = {item:9590} Splintered Log
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths. They carry the Splintered Logs too.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "Los antárboles deambulan por los caminos del bosque entre el campamento y el centro de {zone:1444}; hay pocos, así que búscalos por los senderos. También llevan los troncos astillados.\nCuidado: un {npc:272401} (nivel 60) vuela sobre el bosque al oeste del campamento: mantente lejos de él.",

	-- Step 47: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Cabalga al noroeste hasta {area:1108}; {npc:14637} espera en el muelle.",

	-- Step 48: Forgotten Coast: the water and the shore
	-- {area:1108} Forgotten Coast
	["{area:1108}: the water and the shore"] = "{area:1108}: el agua y la orilla",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-48) wash along the shore just south of the dock and drop the Water Elemental Cores, as the Sea Elementals (47-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: {npc:14637} has a second round once these are done."] = "Los rocíos del mar (46-48) recorren la orilla justo al sur del muelle y sueltan los núcleos de elemental de agua, igual que los elementales de mar (47-49). Los asaltaolas y los zancaprofundas (47-49) andan en el agua frente a la misma playa: primero dispárales con el {item:18904}, y encogidos pierden su fuerza de élite.\nEl Ultra-reductor dura dos horas: {npc:14637} tiene una segunda ronda cuando termines estos.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, de los Rocíos del mar",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, en los Zancaolas y Zancaprofundas del agua",

	-- Step 50: Forgotten Coast: the giants' hills
	-- {area:1108} Forgotten Coast
	["{area:1108}: the giants' hills"] = "{area:1108}: las colinas de los gigantes",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too.\nThe Sea Elementals and Sea Sprays along the shore have the last cores."] = "Los caminatierras y los gigantes del risco recorren las colinas al norte del muelle. Primero dispárale a cada uno con el {item:18904}: encogidos, ya no son élite. Cada gigante encogido suelta residuo; usa también la vasija Muisek sobre su cuerpo.\nLos elementales de mar y los rocíos del mar de la orilla tienen los últimos núcleos.",

	-- Step 52: Northspring harpies
	["Northspring harpies"] = "Arpías Nortearroyo",
	["The Northspring harpies nest on the ridges in the far north-west, past the giants' hills. The Windcallers heal, so kill them first and pull one at a time."] = "Las arpías Fuenteboreal anidan en las lomas del extremo noroeste, pasando las colinas de los gigantes. Las clamavientos curan, así que mátalas primero y atráelas de una en una.",

	-- Step 53: Edana Hatetalon
	-- {npc:8075} Edana Hatetalon
	["{npc:8075} (level 50, elite) roosts on the cliff just north of the harpies' nests. Clear the harpies around her first."] = "{npc:8075} (nivel 50, élite) anida en el acantilado justo al norte de los nidos de las arpías. Limpia primero las arpías a su alrededor.",

	-- Step 54: Rage Scar yetis
	["Rage Scar yetis"] = "Yetis Cicatriz de Rabia",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east towards the camp, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "De vuelta al sureste hacia el campamento, los yetis Cicatriz de Rabia viven alrededor de las cuevas en las colinas junto al camino. Cualquiera de ellos también puede soltar una {quest:7738}, que inicia una misión propia.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, botín raro",

	-- Step 55: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "De vuelta a {area:1099}",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, adentro",

	-- Step 57: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maestro de vuelo de {area:1099}",

	-- Step 58: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, adentro",

	-- Step 61: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} (Chasing {npc:9623}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "La casa de subastas de {area:976} es la última antes de Un'Goro. Allí {npc:9623} (En busca de {npc:9623}) pide un {item:10561}, un objeto de {skill:202}, antes de su escolta: compra uno aquí si quieres esa cadena.",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, junto al maestro de jinetes del viento",

	-- Step 62: The Egg-O-Matic
	-- {object:142071} Egg-O-Matic
	["The {object:142071}"] = "El {object:142071}",
	-- {object:142071} Egg-O-Matic
	["The {object:142071}, in the middle of town"] = "{object:142071}, en el centro del pueblo",

	-- Step 63: Marin Noggenfogger
	-- {zone:1449} Un'Goro Crater
	["Pestlezugg's samples come from {zone:1449}."] = "Las muestras de Morterozugg vienen de {zone:1449}.",

	-- Step 64: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Cabalga al sur por el camino hasta {area:1938}; {npc:7771} acampa al lado. Desde aquí, el camino al oeste baja a {zone:1449}, donde empieza la siguiente guía.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Guarda {quest:3444}: el cofre de {npc:7771} se abre en una visita posterior.",

	-- Step 65: The Dunemaul Compound
	-- {area:1938} Broken Pillar · {npc:12046} Gor'marok the Ravager · {npc:11758} Andi Lynn · {zone:1446} Tanaris
	["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, if you still carry it from {zone:1446}."] = "Al sur de {area:1938}, los ogros Machacaduna tienen su recinto, con {npc:12046} en su extremo este: la misión de {npc:11758}, si todavía la llevas desde {zone:1446}.",

	-- Step 66: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley · {npc:7876} Tran'rek · {zone:1446} Tanaris · {area:976} Gadgetzan
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (49-50) are {npc:7876}'s, carried from your second {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop."] = "Al oeste del recinto, de camino a la rampa de Un'Goro: los cardizales nudosos y los enraizadores (49-50) de {quest:3362} son de {npc:7876}, que llevas desde tu segunda visita a {zone:1446}. Deambulan mucho: atráelos de uno en uno. {npc:7876} los recibe en la parada de {area:976} de la siguiente guía.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",
	-- ["Back north-east to {npc:8420}."] = "Regresa al noreste con {npc:8420}.",
	-- ["Class trainer"] = "Instructor de clase",
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Vuela de {area:1237} a {zone:1454}, sal por la puerta principal hacia las torres de zepelín y toma el zepelín a {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- ["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Vuela a {zone:1456}; está camino a {area:1099}. ¿Aún no tienes esa ruta de vuelo? Vuela a {area:378} y cabalga al oeste por {zone:1412}. Hamuul y {npc:4046} están en {area:1639}; los druidas y paladines entrenan aquí ({npc:3033}, {npc:246344}).",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Sigue el camino al sur; los basiliscos toman el sol en las rocas al este, en medio de la selva. Sus fragmentos caen a menudo.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "Desde el maestro de vuelo de {area:3317}, vuela a {area:1497}.",
	-- ["Highborne and Haldarr satyrs"] = "Altonato y sátiros Haldarr",
	-- ["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- ["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Guarda las entregas para {npc:4046}, {npc:8659} y {npc:6522}: pasas por {zone:1456}, {zone:1454} y {zone:1458} más adelante.",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Guarda {area:1417} para {npc:7771} en {zone:1446}.",
	-- ["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Guarda el pago de {npc:8659} y {quest:3504} de Ag'tor: vuelven a {area:1237} en una visita posterior.",
	-- ["Level 50"] = "Nivel 50",
	-- ["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}, and its experience shortens the top-up to 50 in {zone:1447}."] = "De camino por {zone:1454} hacia el maestro de vuelo, pasa por la Calle Mayor: {npc:7010} recibe el informe de insectos de {zone:1446}, y su experiencia acorta lo que falta para llegar a 50 en {zone:1447}.",
	-- ["Only once all three robots are home"] = "Solo cuando los tres robots estén en casa",
	-- ["Paladin trainer"] = "Instructor de paladines",
	-- ["Ride into {area:16}"] = "Cabalga hacia {area:16}",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Cabalga al noreste hasta el campamento del goblin en los acantilados sobre {area:1227}.",
	-- ["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Cabalga al suroeste hasta las ruinas. Las cuatro tablillas están entre las ruinas, custodiadas por nagas Látigo de Ira; cualquier Sirena o Mirmidón puede llevar la runa de {npc:8420}.",
	-- ["Ride west back to {area:1237}."] = "Cabalga al oeste de vuelta a {area:1237}.",
	-- ["Sea elementals"] = "Elementales de mar",
	-- ["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, carried from your first {zone:1446} visit."] = "Al sur de {area:1938}, los ogros Mazoduna tienen su recinto, con {npc:12046} en su extremo este: la misión de {npc:11758}, que llevas desde tu primera visita a {zone:1446}.",
	-- ["Take the zeppelin back to {zone:1454}."] = "Toma el zepelín de vuelta a {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Toma el zepelín a {zone:1454} en la torre fuera de {zone:1458} y luego vuela a {area:431}.",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Los Caminatierras y los Gigantes del risco recorren las colinas al norte del muelle. Primero dispárales con {item:18904}: encogidos, ya no son élite. Cada gigante encogido suelta residuo; usa también la Vasija de muisek de gigante montés sobre su cuerpo.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Los Elementales de mar y los Rocíos del mar recorren la orilla alrededor del muelle.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Los elementales marinos y las espumas marinas recorren la orilla alrededor del muelle.\nLos caminantes terrestres y los gigantes del acantilado recorren las colinas al norte del muelle. Primero dale a cada uno con {item:18904}: reducidos, ya no son élite. Cada gigante reducido suelta residuo; usa también la Vasija Muisek sobre su cuerpo.",
	-- ["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Los Hipogrifos Tronatesta vuelan sobre las colinas justo al sur de {area:1237}.",
	-- ["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "El campamento de los elfos de sangre está justo al sur de {npc:8420}. Sus cuatro piezas de equipo están en las cajas alrededor del campamento.",
	-- ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Los dragones feéricos revolotean por el bosque justo al oeste del campamento. Usa la vasija en cada uno que mates.",
	-- ["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Los hipogrifos anidan en las colinas al suroeste del campamento. Mata uno y usa la Vasija de muisek de hipogrifo sobre su cuerpo.",
	-- ["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Los antárboles deambulan por los caminos del bosque entre el campamento y el centro de {zone:1444}; hay pocos, así que búscalos por los senderos.",
	-- ["The {object:2076} beside {npc:2519}"] = "El {object:2076} junto a {npc:2519}",
	-- ["To {object:3202}"] = "A {object:3202}",
	-- ["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it."] = "Completa aquí hasta el nivel 50: {quest:4493}, de {npc:7010} en {zone:1454} al final de {zone:1447}, lo necesita.",
	-- ["Undamaged Hippogryph Feathers"] = "Plumas de hipogrifo sin estropear",
	-- ["Upstairs"] = "Arriba",
	-- ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "Al oeste del recinto, de camino a la rampa de Un'Goro: los Cardizales nudosos y los Formarraíces (48-50) de {quest:3362} son de {npc:7876}, que llevas desde tu primera visita a {zone:1446}. Deambulan mucho: atráelos de uno en uno. {npc:7876} la recibe en la parada de {area:976} de la siguiente guía, junto con la de {npc:11758}.",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "La torre de Xylem está en el acantilado justo al norte de {area:1237}; el sendero sube serpenteando por su lado norte.",
	-- ["Zapped giants"] = "Gigantes encogidos",
	-- ["grind on {npc:6125}"] = "sube de nivel con {npc:6125}",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: mata a estos según te los encuentres",
	-- ["{area:1221}: kill these as you meet them"] = "{area:1221}: mata a estos según te los encuentres",
	-- ["{area:75} flight master"] = "Maestro de vuelo de {area:75}",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} en {zone:1456}; {zone:1454} no tiene instructor de paladines",
	-- ["{npc:7010}, the Drag: if you still carry it"] = "{npc:7010}, la Calle Mayor: si aún lo llevas",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: los osos están en {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} está en {object:36082}.",
	-- ["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "El alquitrán de {npc:7876} y las muestras de Morterozugg vienen de {zone:1449}.",
	-- ["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, en el borde este del campamento: no da experiencia, solo un teletransporte a una torre de Azshara",
	-- ["{npc:8659}, in the {object:172960}, has {quest:4300} for later; then your class trainer before you leave for {zone:1447}."] = "{npc:8659}, en la {object:172960}, tiene {quest:4300} para más adelante; luego tu instructor de clase antes de salir hacia {zone:1447}.",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- ["{object:3202} flight master"] = "Maestro de vuelo de {object:3202}",
	-- ["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} se reúne en la siguiente guía; el pago de {npc:4046} vuelve a {npc:8587} más adelante.",
	-- ["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, the {zone:1447} guide at 55 offers it again."] = "{quest:4494} requiere nivel 50: {npc:7010}, en la Calle Mayor, la da a partir de entonces. Si tienes menos de 50, la guía de {zone:1447} a nivel 55 la ofrece de nuevo.",
}
