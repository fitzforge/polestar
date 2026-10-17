-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stonard
	-- {area:75} Stonard
	["You start in {area:75}. Bind here: you hearth back after the coast."] = "Empiezas en {area:75}. Vincula tu piedra de hogar aquí: volverás con ella después de la costa.",

	-- Step 2: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Cabalga al oeste por el camino; el pergamino está a la orilla del agua, en el extremo oeste del pantano.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "para {object:2555} en {zone:1445}, más adelante en esta guía",

	-- Step 3: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "De vuelta al este pasando {area:75}: los artefactos Atal'ai están en el agua y en las orillas de {quest:1424}.",

	-- Step 4: Monstrous Crawlers
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["Monstrous Crawlers"] = "Reptadores monstruosos ({npc:1088})",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Los Reptadores monstruosos ({npc:1088}) caminan por las playas de la costa este, pocos y dispersos: mata a todos los que veas de camino al sur.",

	-- Step 5: Misty Reed Post
	["The small Horde post on the southern shore."] = "El pequeño puesto de la Horda en la orilla sur.",

	-- Step 6: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Múrlocs de Juncobruma",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Los Múrlocs de marisma ({npc:747}) viven en la playa al sur del puesto; los Vomitatintas están en la orilla al este y los Comecarnes más al oeste, alrededor de las chozas de la orilla oeste.",

	-- Step 8: Continued Threat
	["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Los mismos múrlocs otra vez, más los Oráculos, que se quedan cerca de las chozas de la orilla oeste.",

	-- Step 10: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "para el {npc:5598} en {zone:1425}, alrededor del nivel 48",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "El zepelín a {zone:1454} sale de la torre junto a {object:3202}; aterriza justo al noreste de la puerta principal de {zone:1454}.",
	["Zeppelin tower"] = "Torre del zepelín",

	-- Step 13: Orgrimmar
	-- {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, luego {object:172960} y {object:172961}.",

	-- Step 14: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:496} Brackenwall Village
	["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Tu instructor está en {area:1638}: vuela allí (¿aún sin esa ruta de vuelo? vuela a {area:378} y cabalga al oeste por {zone:1412}) y luego a {area:496}.",

	-- Step 16: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog
	["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Cabalga al suroeste hasta {object:2555} y luego al este por {area:511}. Los exploradores y ceniazotes Pirocabello recorren su borde norte con las proles y crías abrasadoras; los horrocrustos custodian las cuevas de dragones más al sureste. El tabaco, el grog y la caja fuerte de Mok'Morokk están en los campamentos de dragonantes.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",

	-- Step 17: Brackenwall Village
	["Ride back north to Brackenwall."] = "Regresa cabalgando al norte a Poblado Murohelecho.",

	-- Step 18: Onyxia's eggs
	["Onyxia's eggs"] = "Huevos de Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Los Huevos de Onyxia están en las cuevas de dragones del sureste de {area:511}, custodiados por los horrocrustos; destruye cinco.",
	["Dragon caves"] = "Cuevas de dragones",

	-- Step 20: Challenge Overlord Mok'Morokk
	-- {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} es élite: se recomienda ir en grupo. Golpéalo hasta que se rinda y luego informa a {npc:4501}.",

	-- Step 21: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "para los lechúcicos de {zone:1425}, alrededor del nivel 48",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: para {npc:7010} en {zone:1454}, alrededor del nivel 50",

	-- Step 22: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Duendes dardo y caminabosques",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Los duendes dardo revolotean sobre la arboleda justo al oeste del campamento y llevan {item:9589}; los Caminabosques deambulantes ({npc:7584}), un poco más al oeste, llevan los Troncos astillados ({item:9590}).",
	["Forest walkers"] = "Caminabosques",

	-- Step 23: Feral Scar Vale
	-- {area:1105} Feral Scar Vale
	["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Al suroeste, los yetis tienen su guarida en {area:1105}; cualquier yeti de allí puede soltar un pellejo grueso.",

	-- Step 24: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Hipogrifos Plumavieja",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Al sur del valle, los hipogrifos Plumavieja anidan en las laderas; casi todos sueltan tendones y fragmentos metálicos.",

	-- Step 25: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Cabalga al noroeste hasta {area:1108}; {npc:14637} espera en el muelle.",

	-- Step 26: Forgotten Coast
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Los elementales de mar y rocíos del mar recorren la orilla alrededor del muelle. Primero dispara a los gigantes con {item:18904}: al encogerse, pierden su fuerza de élite. Los zancaorillas vadean en el agua; los caminatierras y gigantes del risco recorren las colinas más al norte.",

	-- Step 28: Northspring harpies
	["Northspring harpies"] = "Arpías Nortearroyo",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Las arpías Nortearroyo anidan en las lomas del extremo noroeste. Son de nivel 48-50, unos niveles más que tú: las Clamavientos curan, así que mátalas primero y atráelas de una en una.",

	-- Step 30: Rage Scar yetis
	["Rage Scar yetis"] = "Yetis Cicatriz de Rabia",
	-- {quest:7738} Perfect Yeti Hide
	["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Al noroeste por el camino, los yetis Cicatriz de Rabia viven alrededor de las cuevas de las colinas. Cualquiera de ellos también puede soltar {quest:7738}, que inicia una misión propia.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, botín raro",

	-- Step 31: Camp Mojache
	-- {area:976} Gadgetzan
	["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Regresa cabalgando al este al campamento. Quédate aquí: la siguiente guía empieza con el vuelo a {area:976}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
