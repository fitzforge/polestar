-- Spanish (Spain) (esES): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1454} Orgrimmar · {area:1099} Camp Mojache · {area:511} Wyrmbog · {area:496} Brackenwall Village
	["{zone:1454}'s hand-ins, {area:1099}'s Muisek vessel, then Dustwallow's {area:511} and {area:496}."] = "Las entregas de {zone:1454}, la vasija muisek de {area:1099} y luego {area:511} y {area:496} en el Marjal Revolcafango.",
	["Takes you to level 47"] = "Te lleva al nivel 47",
	-- {zone:1446} Tanaris
	["Then on to {zone:1446}"] = "Después, a {zone:1446}",
	["Stays on the main route"] = "Sigue en la ruta principal",
	-- {zone:2652} Shen'dralas · {zone:1446} Tanaris
	["Skips {zone:2652}: about a dozen fewer quests, a third of a level lower into {zone:1446}"] = "Se salta {zone:2652}: una docena de misiones menos, un tercio de nivel más bajo al llegar a {zone:1446}",

	-- Step 1: Orgrimmar
	-- {object:172960} Cleft of Shadow · {object:172958} Valley of Honor
	["From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Desde el maestro de vuelo: el {object:172960}, luego la Calle Mayor y después el {object:172958}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, La Calada",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, La Calle Mayor",
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425}, around level 50"] = "para {zone:1425}, hacia el nivel 50"
	["for the {zone:1425}, around level 49"] = "",

	-- Step 3: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache
	["Your trainer is in {area:1638}, on the way to {area:1099}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 5: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 6: Fly to Camp Mojache
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {zone:1446} Tanaris
	["Fly to {area:1099} (or hearth there, if your hearthstone is ready: it is still bound there from the {zone:1444} & {zone:1446} guide)."] = "",

	-- Step 7: Camp Mojache
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425} owlbeasts, around level 48"] = "para las lechubestias de {zone:1425}, hacia el nivel 48"
	["for the {zone:1425} owlbeasts, around level 49"] = "",

	-- Step 8: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "Vuela a {area:496}",
	-- {zone:1444} Feralas · {zone:1446} Tanaris · {area:496} Brackenwall Village
	["No Muisek vessel to bring Uzer'i (you didn't take the {zone:1444} & {zone:1446} guide's chain): fly from here straight to {area:496}."] = "",

	-- Step 9: Fly to Brackenwall Village
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maestro de vuelo de {area:1099}",

	-- Step 10: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}, bajo tierra",

	-- Step 11: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "{object:2555}",

	-- Step 12: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "Dentro de {area:498}",

	-- Step 13: The Musty Scroll
	-- {object:2555} Musty Scroll
	["The {object:2555} lies to the south-west."] = "{object:2555} está al suroeste.",

	-- Step 14: Mudsprocket
	["Mudsprocket"] = "Barroñuela",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle · {item:280092} Wyrmtail
	["South-east from the {object:2555} to Mudsprocket, the goblin camp at the {area:511}'s western edge: {npc:270723} and {npc:270727} stand together in the camp. Their whelps, scales and {item:280092} come on the same {area:511} loop as Brackenwall's quests."] = "Al sureste desde {object:2555} hasta Barroñuela, el campamento goblin en el borde oeste de {area:511}: {npc:270723} y {npc:270727} están juntos en el campamento. Sus dragonantes, escamas y {item:280092} vienen en la misma vuelta por {area:511} que las misiones de Murohelecho.",

	-- Step 15: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510}: mátalos según te los encuentres",
	-- {area:511} Wyrmbog · {item:280092} Wyrmtail
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps. The {item:280092} grows in the bog just east of Mudsprocket."] = "Al este por {area:511}: los exploradores Crin de Fuego y colas de ceniza recorren su borde norte con las crías y dragonantes abrasadores; los rompescamas guardan las cuevas de dragones más al sureste. El rapé, el grog y la caja fuerte de Mok'Morokk están en los campamentos de dracónidos. {item:280092} crece en la ciénaga justo al este de Barroñuela.",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "",
	["Below ground"] = "Bajo tierra",

	-- Step 16: Mudsprocket
	["Back to Mudsprocket before you ride north."] = "Vuelve a Barroñuela antes de cabalgar al norte.",

	-- Step 17: Brackenwall Village
	["Ride back north to Brackenwall."] = "Vuelve cabalgando al norte, a Murohelecho.",

	-- Step 18: Onyxia's eggs
	["Onyxia's eggs"] = "Huevos de Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Los Huevos de Onyxia están en las cuevas de dragones del sureste de {area:511}, guardados por los Horrocrustos; destroza cinco.",

	-- Step 19: Muckshell crabs
	["Muckshell crabs"] = "",
	-- plural, as words: Muckshell Razorclaws = {npc:4405} Muckshell Razorclaw
	["On the way back north from the dragon caves, the Muckshell Razorclaws and Pincers (41-44) crowd the shallows just north of the caves; about one in twenty carries the Jeweled Pendant Marg Speaks asks for."] = "",

	-- Step 20: Level 45.37
	["Level 45.37"] = "Nivel 45.37",
	-- {npc:4500} Overlord Mok'Morokk · {area:511} Wyrmbog · {area:978} Zul'Farrak
	["{npc:4500}'s challenge, back in Brackenwall, needs a group of three. Alone, grind the Firemane scouts here on the {area:511}'s northern edge to level 45.37 before you ride back north, so you don't come back down for it. Or, with a group, run the {area:978} dungeon instead."] = "El desafío de {npc:4500}, de vuelta en Murohelecho, requiere un grupo de tres. Si vas solo, mata Exploradores Pirocabello aquí, en el borde norte de {area:511}, hasta el nivel 45.37 antes de volver cabalgando al norte, para no tener que bajar otra vez a por ello. O bien, con un grupo, haz en su lugar la mazmorra de {area:978}.",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "mata {npc:4329}",

	-- Step 21: Brackenwall Village
	-- {npc:4791} Nazeer Bloodpike · {item:5942} Jeweled Pendant
	["{npc:4791}: the {item:5942}"] = "",
	-- {npc:4047} Zor Lonetree · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["for {npc:4047} in {zone:1454}, on the {zone:1447} guide's {zone:1454} stop"] = "",
	-- {quest:3128} Natural Materials · {zone:1444} Feralas
	["Keep {quest:3128} and Improved Quality: {zone:1444}' sprites, hippogryphs, Zorbin's coast and the Rage Scar yetis come on your {zone:1444} loop at about 51, with the Muisek chain."] = "",

	-- Step 22: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Vuelve al este pasando {area:75}: los artefactos Atal'ai están en el agua y en las orillas de {quest:1424}.",
	-- ["Back to {npc:14637} on the dock."] = "Vuelve con {npc:14637}, en el muelle.",
	-- ["Dragon caves"] = "Cuevas de dragones",
	-- ["Fly to {area:75}"] = "Vuela a {area:75}",
	-- ["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- ["Forest walkers"] = "Caminabosques",
	-- ["Frayfeather hippogryphs"] = "Hipogrifos Plumavieja",
	-- ["Hearth to {area:1099}: your hearthstone is still bound there from the {zone:1444} & {zone:1446} guide."] = "Usa la piedra de hogar para ir a {area:1099}: sigue vinculada allí desde la guía de {zone:1444} y {zone:1446}.",
	-- ["Monstrous Crawlers"] = "Reptadores monstruosos",
	-- ["Murlocs of the Misty Reed"] = "Múrlocs de Juncobruma",
	-- ["No flight path to {area:75} yet (the {zone:2548} skip the {zone:1435}): ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "Aún no tienes la ruta de vuelo a {area:75} ({zone:2548} se saltan {zone:1435}): cabalga al noreste desde {object:3202} por {zone:1431} y {zone:1430} hasta el pantano; luego al este por el camino hasta {area:75}, y aprende su ruta de vuelo.",
	-- ["Northspring harpies"] = "Arpías Nortearroyo",
	-- ["On the way back south-east from the coast, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "De vuelta al sureste desde la costa, los Yetis Estigmodio viven alrededor de las cuevas de las colinas junto al camino. Cualquiera puede soltar también un {quest:7738}, que inicia su propia misión.",
	-- ["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "De vuelta al sureste desde las arpías, los Yetis Estigmodio viven alrededor de las cuevas de las colinas junto al camino. Cualquiera puede soltar también una {quest:7738}, que inicia su propia misión.",
	-- ["Rage Scar yetis"] = "Yetis Estigmodio",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Vuelve cabalgando al este hasta el campamento. Quédate aquí: la siguiente guía empieza con el vuelo a {area:976}.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Cabalga hacia el noroeste hasta {area:1108}; {npc:14637} espera en el muelle.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Cabalga hacia el suroeste hasta {object:2555} y luego al este por {area:511}. Los Exploradores y Ceniazotes Pirocabello recorren su borde norte con las Proles y Crías abrasadoras; los Horrocrustos guardan las cuevas de dragones más al sureste. El rapé, el grog y la caja fuerte de Mok'Morokk están en los campamentos de los dragonantes.",
	-- ["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Cabalga hacia el oeste por el camino; el pergamino está a la orilla del agua, en el extremo oeste del pantano.",
	-- ["Riding at 40"] = "Equitación a nivel 40",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "La equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. Cada raza la aprende con el instructor de su propia raza: el tuyo es {npc:4773} en {area:159}, a poca distancia al norte de las torres de zepelín, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Vuelve a las torres para el zepelín a {object:3202}.",
	-- ["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all."] = "Rogue Vale se abre justo al norte del muelle de {npc:14637}. Mata a un {npc:5308}, usa {item:10699} sobre su cuerpo antes de despojarlo y luego habla con el espíritu que se alza: es amistoso. Son tres espíritus en total.",
	-- ["Rogue Vale screechers"] = "Pícaros estridadores del valle",
	-- ["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- ["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Elementales marinos y Rocíos del mar recorren la orilla alrededor del muelle. Dispara primero a los gigantes con {item:18904}: encogidos, pierden su fuerza de élite. Los Zancacostas vadean en el agua; los Caminantes de la tierra y los Gigantes del risco recorren las colinas más al norte.",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Caballos esqueléticos: {npc:4731}, junto a {npc:4773}, en {area:159}.",
	-- ["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Al sur del valle, los Hipogrifos Plumavieja anidan en las laderas; casi todos sueltan tendones y fragmentos metálicos.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Al suroeste, los yetis tienen su guarida en {area:1105}; cualquier yeti de allí puede soltar una piel gruesa.",
	-- ["Sprite darters and forest walkers"] = "Duendes dardo y Caminabosques",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Los Múrlocs del pantano viven en la playa al sur del puesto; los Vomitatintas están en la orilla al este y los Comecarnes más al oeste, alrededor de las chozas de la orilla oeste.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Los Reptadores monstruosos recorren las playas de la costa este, pocos y dispersos: mata a todos los que veas de camino al sur.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Las Arpías Nortearroyo anidan en las crestas del extremo noroeste. Son de nivel 48-50, unos niveles por encima de ti: las Clamavientos curan, así que mátalas primero y atráelas de una en una.",
	-- ["The Sea Sprays (47-48) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (48-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength. Leave the Land Walkers and Cliff Giants (48-50) of the northern hills for your next {zone:1444} visit.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "Los Rocíos marinos (47-48) recorren la orilla justo al sur del muelle: sueltan Núcleos elementales de Agua igual que los Elementales marinos (48-49). Los Zancaolas y Zancaprofundas (47-49) vadean el agua frente a la misma playa: dispárales primero con el {item:18904} y, encogidos, pierden su fuerza de élite. Deja los Caminantes de la tierra y Gigantes del risco (48-50) de las colinas del norte para tu próxima visita a {zone:1444}.\nEl Ultra-reductor dura dos horas: entrega ambas misiones a {npc:14637} antes de dejar la costa.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Los mismos múrlocs otra vez, más los Oráculos, que se quedan cerca de las chozas de la orilla oeste.",
	-- ["The small Horde post on the southern shore."] = "El pequeño puesto de la Horda en la orilla sur.",
	-- ["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "Los duendes dardo revolotean sobre la arboleda justo al oeste del campamento y llevan los {item:9589}; los Caminabosques deambulantes, un poco más al oeste, llevan los Troncos astillados.\nCuidado: un {npc:272401} (nivel 60) sobrevuela el bosque al oeste del campamento: no te acerques a él.",
	-- ["The zeppelin lands at {object:3202}: Stranglethorn's errands are done (40-50/02), so fly straight on to {area:75}."] = "El zepelín aterriza en {object:3202}: los encargos de Tuercespina ya están hechos (40-50/02), así que vuela directamente a {area:75}.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "El zepelín a {zone:1454} sale de la torre junto a {object:3202}; aterriza justo al noreste de la puerta principal de {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["Three zones, lots of travel"] = "Tres zonas, muchos viajes",
	-- ["To {area:1099}"] = "A {area:1099}",
	-- ["To {area:75}"] = "A {area:75}",
	-- ["Underwater"] = "Bajo el agua",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Empiezas en {area:75}. Vincula aquí tu Piedra de hogar: volverás con ella después de la costa.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Tu instructor está en {area:1638}: vuela allí (¿aún no tienes esa ruta de vuelo? vuela a {area:378} y cabalga hacia el oeste por {zone:1412}) y luego sigue hasta {area:496}.",
	-- ["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["for the {npc:5598} in the {zone:1425}, around level 48"] = "para {npc:5598} en {zone:1425}, hacia el nivel 48",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "para {object:2555} en {area:15}, más adelante en esta guía",
	-- ["for the {object:2555} in {zone:1445}, later in this guide"] = "para {object:2555} en {zone:1445}, más adelante en esta guía",
	-- ["for the {zone:1425} owlbeasts, around level 48"] = "para las lechubestias de {zone:1425}, hacia el nivel 48",
	-- ["for the {zone:1425}, around level 50"] = "para {zone:1425}, hacia el nivel 50",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: mátalos según te los encuentres",
	-- ["{area:2403}: kill these as you meet them"] = "{area:2403}: mátalos según te los encuentres",
	-- ["{area:496} flight master"] = "Maestro de vuelo de {area:496}",
	-- ["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, sobre los Zancaolas y Zancaprofundas del agua",
	-- ["{item:18958}, from the Sea Sprays"] = "{item:18958}, de los Rocíos marinos",
	-- ["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, de camino de vuelta a Zinge",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} es élite: se recomienda ir en grupo. Golpéalo hasta que se rinda y luego informa a {npc:4501}.",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",
	-- ["{npc:5591}, inside"] = "{npc:5591}, dentro",
	-- ["{npc:7776}'s Northspring harpies (48-50) wait for your {zone:1444} visit at about 51: keep the quest."] = "Las arpías Fuenteboreal (48-50) de {npc:7776} esperan a tu visita a {zone:1444} hacia el nivel 51: conserva la misión.",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- ["{npc:7854}, inside"] = "{npc:7854}, dentro",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: para {npc:7010} en {zone:1454}, hacia el nivel 50",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, luego {object:172960} y {object:172961}.",
	-- ["{object:3202} flight master"] = "Maestro de vuelo de {object:3202}",
	-- ["{quest:7738}, a rare drop"] = "{quest:7738}, botín raro",
	-- ["{zone:1435} and Dustwallow first, then {zone:1444}."] = "Primero {zone:1435} y Marjal Revolcafango, luego {zone:1444}.",
}
