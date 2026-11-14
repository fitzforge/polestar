-- Spanish (Spain) (esES): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 2: Apothecary Zinge
	-- {npc:2934} Keeper Bel'dugur
	["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, de camino de vuelta a Zinge",
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "La equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. Cada raza la aprende con el instructor de su propia raza: el tuyo es {npc:4773} en {area:159}, a poca distancia al norte de las torres de zepelín, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Vuelve a las torres para el zepelín a {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Caballos esqueléticos: {npc:4731}, junto a {npc:4773}, en {area:159}.",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Vuela a {area:75}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "",

	-- Step 7: To Stonard
	-- {area:75} Stonard
	["To {area:75}"] = "A {area:75}",
	-- {area:75} Stonard · {zone:2548} Riverglades · {zone:1435} Swamp of Sorrows · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1431} Duskwood · {zone:1430} Deadwind Pass
	["No flight path to {area:75} yet (the {zone:2548} skip the {zone:1435}): ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "Aún no tienes la ruta de vuelo a {area:75} ({zone:2548} se saltan {zone:1435}): cabalga al noreste desde {object:3202} por {zone:1431} y {zone:1430} hasta el pantano; luego al este por el camino hasta {area:75}, y aprende su ruta de vuelo.",

	-- Step 8: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 9: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Cabalga hacia el oeste por el camino; el pergamino está a la orilla del agua, en el extremo oeste del pantano.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "para {object:2555} en {zone:1445}, más adelante en esta guía",

	-- Step 10: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "",

	-- Step 11: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Vuelve al este pasando {area:75}: los artefactos Atal'ai están en el agua y en las orillas de {quest:1424}.",

	-- Step 12: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "",

	-- Step 13: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "",
	["Underwater"] = "Bajo el agua",

	-- Step 15: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Múrlocs de Juncobruma",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Los Múrlocs del pantano viven en la playa al sur del puesto; los Vomitatintas están en la orilla al este y los Comecarnes más al oeste, alrededor de las chozas de la orilla oeste.",
	["Below ground"] = "Bajo tierra",

	-- Step 17: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "",

	-- Step 19: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "para {npc:5598} en {zone:1425}, hacia el nivel 48",

	-- Step 20: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "",

	-- Step 21: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "para las lechubestias de {zone:1425}, hacia el nivel 48",

	-- Step 22: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maestro de vuelo de {area:1099}",

	-- Step 23: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "",

	-- Step 24: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "",

	-- Step 25: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "",

	-- Step 26: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "",

	-- Step 27: Brackenwall Village
	["Ride back north to Brackenwall."] = "Vuelve cabalgando al norte, a Murohelecho.",

	-- Step 28: Onyxia's eggs
	["Onyxia's eggs"] = "Huevos de Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Los Huevos de Onyxia están en las cuevas de dragones del sureste de {area:511}, guardados por los Horrocrustos; destroza cinco.",
	["Dragon caves"] = "Cuevas de dragones",

	-- Step 29: Level 45.37
	["Level 45.37"] = "Nivel 45.37",
	-- {npc:4500} Overlord Mok'Morokk · {area:511} Wyrmbog · {area:978} Zul'Farrak
	["{npc:4500}'s challenge, back in Brackenwall, needs a group of three. Alone, grind the Firemane scouts here on the {area:511}'s northern edge to level 45.37 before you ride back north, so you don't come back down for it. Or, with a group, run the {area:978} dungeon instead."] = "El desafío de {npc:4500}, de vuelta en Murohelecho, requiere un grupo de tres. Si vas solo, mata Exploradores Pirocabello aquí, en el borde norte de {area:511}, hasta el nivel 45.37 antes de volver cabalgando al norte, para no tener que bajar otra vez a por ello. O bien, con un grupo, haz en su lugar la mazmorra de {area:978}.",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "",

	-- Step 31: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "",

	-- Step 32: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 33: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Duendes dardo y Caminabosques",
	-- {item:9589} Encrusted Minerals · {npc:272401} Vale Screamer
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "Los duendes dardo revolotean sobre la arboleda justo al oeste del campamento y llevan los {item:9589}; los Caminabosques deambulantes, un poco más al oeste, llevan los Troncos astillados.\nCuidado: un {npc:272401} (nivel 60) sobrevuela el bosque al oeste del campamento: no te acerques a él.",

	-- Step 34: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Hipogrifos Plumavieja",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Al sur del valle, los Hipogrifos Plumavieja anidan en las laderas; casi todos sueltan tendones y fragmentos metálicos.",

	-- Step 35: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Cabalga hacia el noroeste hasta {area:1108}; {npc:14637} espera en el muelle.",

	-- Step 36: Rogue Vale screechers
	["Rogue Vale screechers"] = "Pícaros estridadores del valle",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all."] = "Rogue Vale se abre justo al norte del muelle de {npc:14637}. Mata a un {npc:5308}, usa {item:10699} sobre su cuerpo antes de despojarlo y luego habla con el espíritu que se alza: es amistoso. Son tres espíritus en total.",

	-- Step 37: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Elementales marinos y Rocíos del mar recorren la orilla alrededor del muelle. Dispara primero a los gigantes con {item:18904}: encogidos, pierden su fuerza de élite. Los Zancacostas vadean en el agua; los Caminantes de la tierra y los Gigantes del risco recorren las colinas más al norte.",

	-- Step 38: Northspring harpies
	["Northspring harpies"] = "Arpías Nortearroyo",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Las Arpías Nortearroyo anidan en las crestas del extremo noroeste. Son de nivel 48-50, unos niveles por encima de ti: las Clamavientos curan, así que mátalas primero y atráelas de una en una.",

	-- Step 39: Rage Scar yetis
	["Rage Scar yetis"] = "Yetis Estigmodio",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "De vuelta al sureste desde las arpías, los Yetis Estigmodio viven alrededor de las cuevas de las colinas junto al camino. Cualquiera puede soltar también una {quest:7738}, que inicia su propia misión.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, botín raro",

	-- Step 40: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- ["Forest walkers"] = "Caminabosques",
	-- ["Monstrous Crawlers"] = "Reptadores monstruosos",
	-- ["Murlocs of the Misty Reed"] = "Múrlocs de Juncobruma",
	-- ["Northspring harpies"] = "Arpías Nortearroyo",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Vuelve cabalgando al este hasta el campamento. Quédate aquí: la siguiente guía empieza con el vuelo a {area:976}.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Cabalga hacia el suroeste hasta {object:2555} y luego al este por {area:511}. Los Exploradores y Ceniazotes Pirocabello recorren su borde norte con las Proles y Crías abrasadoras; los Horrocrustos guardan las cuevas de dragones más al sureste. El rapé, el grog y la caja fuerte de Mok'Morokk están en los campamentos de los dragonantes.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Al suroeste, los yetis tienen su guarida en {area:1105}; cualquier yeti de allí puede soltar una piel gruesa.",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Los Múrlocs del pantano viven en la playa al sur del puesto; los Vomitatintas están en la orilla al este y los Comecarnes más al oeste, alrededor de las chozas de la orilla oeste.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Los Reptadores monstruosos recorren las playas de la costa este, pocos y dispersos: mata a todos los que veas de camino al sur.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Las Arpías Nortearroyo anidan en las crestas del extremo noroeste. Son de nivel 48-50, unos niveles por encima de ti: las Clamavientos curan, así que mátalas primero y atráelas de una en una.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Los mismos múrlocs otra vez, más los Oráculos, que se quedan cerca de las chozas de la orilla oeste.",
	-- ["The small Horde post on the southern shore."] = "El pequeño puesto de la Horda en la orilla sur.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "El zepelín a {zone:1454} sale de la torre junto a {object:3202}; aterriza justo al noreste de la puerta principal de {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Empiezas en {area:75}. Vincula aquí tu Piedra de hogar: volverás con ella después de la costa.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Tu instructor está en {area:1638}: vuela allí (¿aún no tienes esa ruta de vuelo? vuela a {area:378} y cabalga hacia el oeste por {zone:1412}) y luego sigue hasta {area:496}.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "para {object:2555} en {area:15}, más adelante en esta guía",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} es élite: se recomienda ir en grupo. Golpéalo hasta que se rinda y luego informa a {npc:4501}.",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: para {npc:7010} en {zone:1454}, hacia el nivel 50",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, luego {object:172960} y {object:172961}.",
}
