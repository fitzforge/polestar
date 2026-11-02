-- Spanish (Spain) (esES): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "",

	-- Step 2: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "",

	-- Step 3: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Cabalga hacia el oeste por el camino; el pergamino está a la orilla del agua, en el extremo oeste del pantano.",

	-- Step 4: A Soggy Scroll
	-- {object:2555} Musty Scroll · {area:15} Dustwallow Marsh
	["for the {object:2555} in {area:15}, later in this guide"] = "",

	-- Step 6: Marsh Inkspewer on the way
	-- {npc:750} Marsh Inkspewer
	["{npc:750} on the way"] = "",
	-- {npc:750} Marsh Inkspewer · {area:1978} Misty Reed Post
	["{npc:750} along the way to {area:1978}"] = "",

	-- Step 7: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc · Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "",
	["Below ground"] = "",

	-- Step 8: Atal'ai Artifact on the way
	-- {item:6175} Atal'ai Artifact
	["{item:6175} on the way"] = "",
	-- {item:6175} Atal'ai Artifact · {area:75} Stonard
	["{item:6175} along the way to {area:75}"] = "",

	-- Step 11: Stonard
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "para {npc:5598} en {zone:1425}, hacia el nivel 48",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",

	-- Step 12: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "",

	-- Step 13: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "",

	-- Step 14: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "para las lechubestias de {zone:1425}, hacia el nivel 48",

	-- Step 15: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 17: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog
	["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Cabalga hacia el suroeste hasta {object:2555} y luego al este por {area:511}. Los Exploradores y Ceniazotes Pirocabello recorren su borde norte con las Proles y Crías abrasadoras; los Horrocrustos guardan las cuevas de dragones más al sureste. El rapé, el grog y la caja fuerte de Mok'Morokk están en los campamentos de los dragonantes.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",

	-- Step 18: The Wyrmbog
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "",

	-- Step 19: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "",

	-- Step 20: Brackenwall Village
	["Ride back north to Brackenwall."] = "Vuelve cabalgando al norte, a Murohelecho.",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "",

	-- Step 21: Onyxia's eggs
	["Onyxia's eggs"] = "Huevos de Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Los Huevos de Onyxia están en las cuevas de dragones del sureste de {area:511}, guardados por los Horrocrustos; destroza cinco.",
	["Dragon caves"] = "Cuevas de dragones",

	-- Step 23: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "",

	-- Step 24: Level 45.28
	["Level 45.28"] = "",
	-- {quest:1173} Challenge Overlord Mok'Morokk
	["If you skipped {quest:1173}, grind here to level 45.28 to stay on the route's plan."] = "",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "",

	-- Step 25: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 27: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}"] = "",

	-- Step 29: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 33: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Duendes dardo y Caminabosques",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Los duendes dardo revolotean sobre la arboleda justo al oeste del campamento y llevan los {item:9589}; los Caminabosques deambulantes, un poco más al oeste, llevan los Troncos astillados.",
	["Forest walkers"] = "Caminabosques",

	-- Step 34: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Hipogrifos Plumavieja",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Al sur del valle, los Hipogrifos Plumavieja anidan en las laderas; casi todos sueltan tendones y fragmentos metálicos.",

	-- Step 36: High Wilderness: kill these as you meet them
	-- {area:1136} High Wilderness
	["{area:1136}: kill these as you meet them"] = "",
	-- {area:1105} Feral Scar Vale
	["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Al suroeste, los yetis tienen su guarida en {area:1105}; cualquier yeti de allí puede soltar una piel gruesa.",

	-- Step 37: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Cabalga hacia el noroeste hasta {area:1108}; {npc:14637} espera en el muelle.",

	-- Step 38: Rogue Vale screechers
	["Rogue Vale screechers"] = "",
	-- {zone:1444} Feralas · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "",

	-- Step 39: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Elementales marinos y Rocíos del mar recorren la orilla alrededor del muelle. Dispara primero a los gigantes con {item:18904}: encogidos, pierden su fuerza de élite. Los Zancacostas vadean en el agua; los Caminantes de la tierra y los Gigantes del risco recorren las colinas más al norte.",

	-- Step 40: Ruins of Ravenwind: kill these as you meet them
	-- {area:1114} Ruins of Ravenwind
	["{area:1114}: kill these as you meet them"] = "",
	-- {npc:8075} Edana Hatetalon
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time.\nCareful: Wait until an earlier {npc:8075}'s corpse has fully despawned before you blow the horn. If you use it too soon, the horn is lost and {npc:8075} does not appear."] = "",

	-- Step 41: Ruins of Ravenwind: kill these as you meet them
	-- {npc:8075} Edana Hatetalon
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:8075} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 43: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- Step 45: Level 47.19
	["Level 47.19"] = "",
	-- {quest:3062} Dark Heart
	["If you skipped {quest:3062}, grind here to level 47.19 to stay on the route's plan."] = "",
	-- {npc:7584} Wandering Forest Walker
	["grind on {npc:7584}"] = "",

	-- Step 46: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "",
	-- {area:1417} Sunken Temple · {area:440} Tanaris
	["Keep {area:1417} for Marvon in {area:440}."] = "",

	-- Step 47: Rage Scar yetis
	["Rage Scar yetis"] = "Yetis Estigmodio",
	-- {quest:7738} Perfect Yeti Hide
	["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Al noroeste por el camino, los Yetis Estigmodio viven alrededor de las cuevas de las colinas. Cualquiera puede soltar también una {quest:7738}, que inicia su propia misión.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, botín raro",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Vuelve al este pasando {area:75}: los artefactos Atal'ai están en el agua y en las orillas de {quest:1424}.",
	-- ["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- ["Monstrous Crawlers"] = "Reptadores monstruosos",
	-- ["Murlocs of the Misty Reed"] = "Múrlocs de Juncobruma",
	-- ["Northspring harpies"] = "Arpías Nortearroyo",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Vuelve cabalgando al este hasta el campamento. Quédate aquí: la siguiente guía empieza con el vuelo a {area:976}.",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Los Múrlocs del pantano viven en la playa al sur del puesto; los Vomitatintas están en la orilla al este y los Comecarnes más al oeste, alrededor de las chozas de la orilla oeste.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Los Reptadores monstruosos recorren las playas de la costa este, pocos y dispersos: mata a todos los que veas de camino al sur.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Las Arpías Nortearroyo anidan en las crestas del extremo noroeste. Son de nivel 48-50, unos niveles por encima de ti: las Clamavientos curan, así que mátalas primero y atráelas de una en una.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Los mismos múrlocs otra vez, más los Oráculos, que se quedan cerca de las chozas de la orilla oeste.",
	-- ["The small Horde post on the southern shore."] = "El pequeño puesto de la Horda en la orilla sur.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "El zepelín a {zone:1454} sale de la torre junto a {object:3202}; aterriza justo al noreste de la puerta principal de {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Empiezas en {area:75}. Vincula aquí tu Piedra de hogar: volverás con ella después de la costa.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Tu instructor está en {area:1638}: vuela allí (¿aún no tienes esa ruta de vuelo? vuela a {area:378} y cabalga hacia el oeste por {zone:1412}) y luego sigue hasta {area:496}.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["for the {object:2555} in {zone:1445}, later in this guide"] = "para {object:2555} en {zone:1445}, más adelante en esta guía",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} es élite: se recomienda ir en grupo. Golpéalo hasta que se rinda y luego informa a {npc:4501}.",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: para {npc:7010} en {zone:1454}, hacia el nivel 50",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, luego {object:172960} y {object:172961}.",
}
