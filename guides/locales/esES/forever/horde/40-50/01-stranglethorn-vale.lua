-- Spanish (Spain) (esES): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Tu entrenamiento de nivel 40 está en {area:1497}: vuela allí desde {area:340}, entrena y toma el zepelín de las torres de fuera de la ciudad hasta {object:3202}.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maestro de vuelo de {area:340}",

	-- Step 2: Undercity trainers
	-- {area:1497} Undercity
	["{area:1497} trainers"] = "Instructores de {area:1497}",

	-- Step 3: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "La equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. Cada raza la aprende con el instructor de su propia raza: el tuyo es {npc:4773} en {area:159}, a poca distancia al norte de las torres de zepelín, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Vuelve a las torres para el zepelín a {object:3202}.",
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
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 7: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:730} Tethis · {quest:195} Raptor Mastery
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights.\nCareful: {npc:730}, a level 43 elite raptor, roams among the stalkers: leave him for {quest:195}'s group step."] = "Los Acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.\nCuidado: {npc:730}, un raptor élite de nivel 43, ronda entre los acechadores: déjalo para el paso de grupo de {quest:195}.",

	-- Step 9: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Gringer, el maestro de vuelo, espera en la cubierta superior de {area:35}. Los que dan misiones están en las pasarelas alrededor del puerto y en la posada.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: {npc:2635} toma el sol en la costa entre Zul'Kunda y {object:3202}, más adelante en este recorrido",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, en los muelles: la carta de Gazlowe, si la llevas",
	-- {npc:4631} Wharfmaster Lozgil · {quest:97332} Twice Misplaced Trust · {npc:259961} Wharfmaster Whizzbuzz · {area:16727} Powderfuse Port · {zone:2548} Riverglades
	["{npc:4631}: {quest:97332}, after Zimmix's rescue; the package goes to {npc:259961} at {area:16727}, in the {zone:2548} guide"] = "{npc:4631}: {quest:97332}, tras el rescate de Zimmix; el paquete va para {npc:259961} en {area:16727}, en la guía de {zone:2548}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, en el balcón junto a MacKinley",
	["Inside"] = "",

	-- Step 11: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs, has his next errand now: the Skullsplitter tusks come from the trolls of Zul'Mamwe, later on this loop."] = "{npc:737}, en el piso de arriba, ya tiene su siguiente encargo: los colmillos Machacacráneos los sueltan los trols de Zul'Mamwe, más adelante en este recorrido.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Sal del pueblo por el túnel; la nota está en la cala pirata justo al norte de {area:35}.",

	-- Step 14: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas de Velo de Bruma",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Los gorilas recorren el valle alrededor de Unbagwa. Los ancianos sueltan las asaduras; cualquiera puede soltar un colmillo: guarda diez para Unbagwa, cuyo Mokk (44) espera a tu parada en Tuercespina hacia el nivel 45.\nCuidado: los Gorilas Velo de Bruma ancianos (40-41) están muy juntos en el valle: atráelos de uno en uno.",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "Mina de Ventura y Cía.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Más al norte, los goblins de Ventura y Cía. excavan en la mina al este del camino; mineros, supervisores, peritos y manitas sueltan los cristales.\nCuidado: Panteras Faucesombría y Tigresas de Tuercespina en sigilo rondan la zona alrededor del campamento.",

	-- Step 18: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Hemet Decautela",
	["Head north up the road; the hunters camp on the hill above the river."] = "Ve al norte por el camino; los cazadores acampan en la colina sobre el río.",

	-- Step 19: Sin'Dall
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["{npc:729}, the tiger {npc:717} sent you after on your last visit, prowls the hilltop just south-west of the camp."] = "{npc:729}, el tigre tras el que te envió {npc:717} en tu última visita, ronda la cima de la colina justo al suroeste del campamento.",

	-- Step 22: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} colecciona las páginas de {quest:338}: los trols del valle las sueltan de vez en cuando. Acepta su misión; cada capítulo te lo recoge cuando tengas todas sus páginas.",

	-- Step 23: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: todas las páginas del capítulo I están en tus bolsas",

	-- Step 24: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: todas las páginas del capítulo II están en tus bolsas",

	-- Step 25: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: todas las páginas del capítulo III están en tus bolsas",

	-- Step 26: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: todas las páginas del capítulo IV están en tus bolsas",

	-- Step 27: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: los cuatro capítulos",

	-- Step 28: Zul'Kunda
	["Zul'Kunda"] = "Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "Al oeste de la expedición, los jefes Cabellesangre {npc:1061} y {npc:1062} están juntos en las Ruinas de Zul'Kunda. Limpia antes a sus guardias y luego atráelos.\nEn la costa entre Zul'Kunda y {object:3202}, un {npc:2635} (élite de nivel 38) comparte los puntos de aparición de los crocoliscos normales: mátalo si está y coge su piel para {npc:2495}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",

	-- Step 29: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: para {zone:1425}, alrededor del nivel 48",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: la entrada de la caverna bajo {area:104}, al oeste del campamento",

	-- Step 30: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina se hacen muy largas a pie. Toma el zepelín de la torre de {object:3202} hasta {zone:1454}: {npc:4752} enseña a los orcos en {object:172958}, junto a la perrera de {npc:3362} (lobos a 20 de oro cada uno). Luego vuelve en zepelín a {object:3202}. ¿Te falta oro? Salta este paso: la guía de {zone:1444} vuelve a pasar por {zone:1454} hacia el nivel 45.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",

	-- Step 31: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:367} Sen'jin Village · {npc:7953} Xar'Ti · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina se hacen muy largas a pie. Toma el zepelín de la torre de {object:3202} hasta {zone:1454} y baja al sur por el camino de {zone:1411} hasta {area:367}: allí {npc:7953} enseña a los trols, con los raptores de Zjolnir (20 de oro cada uno). Luego vuelve al zepelín hacia {object:3202}. ¿Te falta oro? Salta este paso: la guía de {zone:1444} vuelve a pasar por {zone:1454} hacia el nivel 45.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instructor de equitación",

	-- Step 32: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina se hacen muy largas a pie. Toma el zepelín de la torre de {object:3202} hasta {zone:1454}, vuela a {zone:1456} y baja hasta {area:222}: allí {npc:3690} enseña a los tauren, con los kodos de {npc:3685} (20 de oro cada uno). Luego vuela de vuelta a {zone:1454} para el zepelín de {object:3202}. ¿Te falta oro? Salta este paso: la guía de {zone:1444} vuelve a pasar por {zone:1456} hacia el nivel 45.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instructor de equitación",

	-- Step 33: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes un Galestrider, y {zone:2548} después de Tuercespina se hacen muy largas a pie. Toma el zepelín de la torre de {object:3202} hasta {zone:1454} y vuela a {zone:1456}: la aeronave a {zone:2521} sale de los acantilados al sur de {area:17045}, al norte de {zone:1456}, cada cinco minutos más o menos, y {npc:265756} enseña a los Skyborne en {area:17684}, en {area:16638}. Luego vuelve a {zone:1454} para el zepelín de {object:3202}. ¿Te falta oro? Salta este paso: la guía de {zone:1444} vuelve a pasar por {zone:1454} hacia el nivel 45.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756}, riding trainer, at the {area:17684} in {area:16638}"] = "{npc:265756}, instructor de equitación, en {area:17684}, en {area:16638}",

	-- Step 34: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {area:1497} Undercity · {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1435} Swamp of Sorrows
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina se hacen muy largas a pie. Toma el zepelín de la torre de {object:3202} hasta las torres de {area:1497}: {npc:4773} enseña a los Renegados en {area:159}, a poca distancia al norte, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno). Luego vuelve en zepelín a {object:3202}. ¿Te falta oro? Salta este paso: la guía de {zone:1435} vuelve a pasar por {area:1497} hacia el nivel 47.",

	-- Step 35: Your mount at 40
	["Your mount at 40"] = "Tu montura a nivel 40",
	-- {zone:1454} Orgrimmar · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Warlocks don't buy riding: your mount is the Felsteed, from your class quest. Zevrost in {zone:1454}'s {object:172960} starts it and {npc:6251} in {area:392} teaches it, both on the {zone:1444} guide's {zone:1454} stop at about 45."] = "Los brujos no compran equitación: su montura es el Corcel vil, de la misión de clase. Zevrost, en el {object:172960} de {zone:1454}, la inicia y {npc:6251}, en {area:392}, la enseña; ambos están en la parada de {zone:1454} de la guía de {zone:1444}, sobre el nivel 45.",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Felsteed: Zevrost in {zone:1454}, then {npc:6251} in {area:392}, on the {zone:1444} guide's {zone:1454} stop."] = "Corcel vil: Zevrost en {zone:1454}, luego {npc:6251} en {area:392}, en la parada de {zone:1454} de la guía de {zone:1444}.",

	-- Step 36: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol (no name in this language: may be words) · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: al oeste de {object:3202}, nada sobre {area:104} y bucea hasta la entrada de la caverna en el arrecife; la misión se completa al encontrarla. Deja la caverna por ahora: los acechadores de la selva están al sur, a lo largo de la costa.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "la entrada de {area:16550}, bajo el agua",

	-- Step 37: Jungle stalkers
	["Jungle stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast.\nCareful: the Jungle Stalkers (40-41) are thick here: pull one at a time and rest between fights."] = "Los acechadores de la selva cazan en la jungla al sur de {object:3202}, hacia la costa oeste.\nCuidado: aquí hay muchos Acechadores de la selva (40-41): atráelos de uno en uno y descansa entre combates.",
	["The naga explorers on the coast south of here (43-44) are for Bloads and Mok'thardin: keep both quests for your Stranglethorn stop at about 45."] = "Los exploradores naga de la costa al sur de aquí (43-44) son para Bloads y Mok'thardin: guarda ambas misiones para tu parada en Tuercespina sobre el nivel 45.",

	-- Step 38: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Ve al sur hasta {area:35}. \"Trémulo\" Phillipe espera en los muelles.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:2486} Fin Fizracket · {quest:348} Stranglethorn Fever · {zone:1444} Feralas · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2486}: {quest:348} (offered from 40), Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}: {quest:348} (disponible desde 40), la parte de Unbagwa en la parada de {object:3202} de la guía de {zone:1444}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "",
	["MacKinley: keep it, the ghost pirates (43-44) wait for your Stranglethorn stop at about 45"] = "MacKinley: guárdala, los piratas fantasma (43-44) esperan a tu parada en Tuercespina sobre el nivel 45",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, dentro: {item:4105}",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["{npc:2493}: keep it for the {area:43} at about 45"] = "{npc:2493}: guárdala para {area:43} sobre el nivel 45",
	-- {npc:2487} Fleet Master Seahorn · {area:43} Wild Shore
	["{npc:2487}: keep it for the {area:43} at about 45"] = "{npc:2487}: guárdala para {area:43} sobre el nivel 45",
	-- {npc:2488} Deeg · {area:43} Wild Shore
	["{npc:2488}, on the top floor: keep it for the {area:43} at about 45"] = "{npc:2488}, en el piso superior: guárdala para {area:43} sobre el nivel 45",

	-- Step 39: The Bloodsail ships
	["The Bloodsail ships"] = "Los barcos Velasangre",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["The scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs, with captains of 45-48: take it with a group. Its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "El pergamino, {quest:624}, está en las cubiertas de los tres barcos frente a {area:43}, tripulados por piratas de nivel 42-45 que van en parejas, con capitanes de 45-48: hazlo en grupo. Su cadena continúa por {zone:1435}, {zone:1445} y {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para una parada posterior en {zone:1435}",

	-- Step 40: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly back to {object:3202}: Zul'Mamwe's Skullsplitters are just east of it."] = "Vuela de vuelta a {object:3202}: los Partecráneos de Zul'Mamwe están justo al este.",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 41: Zul'Mamwe
	["Zul'Mamwe"] = "Zul'Mamwe",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:1059} Ana'thek the Cruel · {npc:1061} Gan'zulah
	["From {object:3202} head east to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. One pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all. Careful: {npc:1059} (45) walks the south-western ruins with two guards; Speaking with {npc:1061}'s last piece, his Broken Armor, waits for your Stranglethorn stop at about 45."] = "Desde {object:3202} ve al este hasta las ruinas Partecráneos, al este de la mina de Ventura y Cía.; atrae a los cazacabezas y rabiosos de uno en uno. Un montón de cráneos trofeo está en el lado norte de las ruinas. Cualquier Partecráneos puede soltar un colmillo o un collar: los collares son lo lento, así que sigue matando en el campamento de guerreros al norte de las ruinas hasta tenerlos todos. Cuidado: {npc:1059} (45) patrulla las ruinas del suroeste con dos guardias; la última pieza de {npc:1061}, su Armadura rota, espera a tu parada en Tuercespina sobre el nivel 45.",
	["Skullsplitter warriors"] = "Guerreros Machacacráneos",

	-- Step 42: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Los siguientes cráneos trofeo están en las pequeñas ruinas justo al norte del campamento de guerreros.\nLos últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",

	-- Step 43: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Ve al oeste hasta {object:3202}.",
	-- {npc:2464} Commander Aggro'gosh · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {zone:2548} Riverglades
	["{npc:2464}: for {npc:256418} in {area:16743}, the {zone:2548}' Horde fort, in the next guide"] = "{npc:2464}: para {npc:256418} en {area:16743}, el fuerte de la Horda en {zone:2548}, en la siguiente guía",
	-- {quest:571} Mok'thardin's Enchantment · {quest:621} Zanzil's Secret · {npc:737} Kebok · {area:35} Booty Bay · {zone:2548} Riverglades
	["Keep {quest:571}, {quest:621} and {npc:737}'s tusks: the Skullsplitter chief, Zanzil's camps, the naga coast and {area:35} come on your Stranglethorn stop at about 45, after the {zone:2548}."] = "Guarda {quest:571}, {quest:621} y los colmillos de {npc:737}: el jefe Partecráneos, los campamentos de Zanzil, la costa naga y {area:35} llegan en tu parada en Tuercespina sobre el nivel 45, después de {zone:2548}.",

	-- Step 45: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Ve al norte por el camino hasta el campamento de los cazadores.",

	-- Step 47: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone."] = "Son enemigos élite: se recomienda ir en grupo, busca gente con quien hacerlo. {npc:730} es un élite de nivel 43: la mayoría de clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Sáltalo si vas solo.",

	-- Step 48: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone."] = "Son enemigos élite: se recomienda ir en grupo, busca gente con quien hacerlo. {npc:728} es un élite de nivel 40: la mayoría de clases lo hacen solas a nivel 42, pero puede que necesites ayuda. Sáltalo si vas solo.",

	-- Step 52: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Son enemigos élite: se recomienda ir en grupo, busca gente con quien hacerlo. {npc:731} es un élite de nivel 43: la mayoría de clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Sáltalo si vas solo.\nCuidado: tigres y panteras Faucesombría en sigilo rondan cerca de él. Límpialos antes de atraerlo. Al atraerlo, {npc:731} pide ayuda a las criaturas a menos de 20 m.",

	-- Step 57: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Hacia {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Sigue el camino al este desde {zone:1431} a través de {zone:1430} hasta el pantano. {npc:1776} espera en {area:657}, el campamento draenei justo al lado del camino, donde entra desde {zone:1430}.",

	-- Step 58: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Ve al este hasta {area:75}, entre los juncos al sur del camino.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 59: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Los crocoliscos se revuelcan en las charcas alrededor del campamento de {npc:5391} y hacia el sur hasta {area:75}; uno de cada cuatro, más o menos, suelta un flanco.",

	-- Step 60: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru el Garrote deambula por el claro al suroeste de {area:76}; su garrote inicia una misión.",

	-- Step 61: Draenethyst crystals
	["Draenethyst crystals"] = "Cristales de draenetista",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Head north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Ve al noreste hasta {area:76}. Los cristales están a lo largo de la subida hasta la jaula de {npc:5391}.",

	-- Step 62: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está preso en {area:76}, al noreste del pantano. Libéralo y síguelo, defendiéndolo de las criaturas del pantano que lo persiguen.",

	-- Step 63: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "Su caja fuerte espera en su antiguo campamento al norte de {area:75}, de camino de vuelta al oeste.",

	-- Step 64: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Ve al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}. {quest:698} va para {npc:5592} en {area:1978} en la próxima visita al pantano: guarda los flancos.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Below ground"] = "Bajo tierra",
	-- ["Boat to {area:35}"] = "Barco a {area:35}",
	-- ["Fly to {area:392}"] = "Vuela a {area:392}",
	-- ["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Sigue la costa hacia el sur. Los exploradores naga vadean la orilla y llevan los fardos de juncos; {object:759} burbujea en las colinas justo al este.",
	-- ["From {area:2408} fly to {area:392}."] = "Desde {area:2408}, vuela a {area:392}.",
	-- ["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Dale los colmillos a Unbagwa y quédate a su lado: llama a tres oleadas de gorilas y luego a {npc:1514}. Lucha contra ellos de uno en uno.",
	-- ["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Ve al norte hasta las Ruinas de Zul'Mamwe, de los Machacacráneos, al este de la mina de Ventura y Cía.; atrae a los rebanacabezas y rabiosos de uno en uno. {npc:1059} guarda las ruinas del suroeste, y una pila de cráneos trofeo está en el lado norte de las ruinas. Cualquier Machacacráneos puede soltar un colmillo o un collar: los collares son lo lento, así que sigue matando en el campamento de guerreros al norte de las ruinas hasta tenerlos todos.",
	-- ["Hearth to {area:35}"] = "Piedra de hogar a {area:35}",
	-- ["Hearth to {object:3202}"] = "Piedra de hogar a {object:3202}",
	-- ["Into the {area:8}"] = "Hacia {area:8}",
	-- ["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- ["Naga shore and the {object:759}"] = "Costa de los naga y {object:759}",
	-- ["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Al noreste de Velo de Bruma, los seguidores de Zanzil acampan en la jungla; cualquiera de ellos puede llevar la mezcla.",
	-- ["Pirate ghosts"] = "Fantasmas piratas",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Vuelve al este pasando {area:75} y sigue el camino al sureste hasta el pequeño puesto de la Horda en la orilla.",
	-- ["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cabalga al noreste hasta {area:76}. Los cristales están a lo largo de la subida hasta la jaula de {npc:5391}.",
	-- ["Ride on north to {object:3202}."] = "Sigue cabalgando al norte hasta {object:3202}.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Cabalga al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}. {quest:698} va para {npc:5592} en {area:1978} en la próxima visita al pantano: guarda los flancos.",
	-- ["Sawtooth snappers"] = "Sacudidores Denteserra",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Al sur de Bahía del Botín, los aventureros Velasangre acampan en {area:43}; las cartas y las órdenes están en sus tiendas y en el bote de remos junto al campamento más grande. Cualquier Velasangre puede llevar tabaco y el Ojo de {npc:2493}, así que sigue matando hasta tener ambos.",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Toma el camino al norte desde {area:35}; Unbagwa está sentado en una colina en {area:1737}, al este del camino.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Los acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "El barco a {area:35} atraca al final del muelle de {area:392}.",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Los gorilas deambulan por el valle alrededor de Unbagwa. Los ancianos sueltan las tripas; cualquiera puede soltar un colmillo.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Los últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "La siguiente guía empieza aquí y te lleva a {zone:1446}.",
	-- ["The snappers line the strand south of the post."] = "Los sacudidores recorren la playa al sur del puesto.",
	-- ["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Los acechadores de la selva cazan en la jungla al sur de {object:3202}, hacia la costa oeste.",
	-- ["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Los tres piratas fantasmales rondan la jungla al norte de {area:35}, cerca de los campamentos de Zanzil: {npc:2535} y {npc:2536} están juntos, {npc:2537} más al este.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Los tres barcos están frente a {area:43}. Las tripulaciones son de nivel 42-45, Aguasmansas 45, Sinquilla 46 y {npc:2546} 48: a nivel 41 es un combate para grupo o para el final de la guía. Si vas, nada hasta ellos y atrae a la tripulación a la borda de uno en uno. Un pergamino, {quest:624}, está en la cubierta de los barcos: cógelo.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "Al oeste de la expedición, los jefes Cabellesangre {npc:1061} y {npc:1062} están juntos en las Ruinas de Zul'Kunda. Limpia antes a sus guardias y luego atráelos.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "Al oeste de la expedición, los jefes Cabellesangre {npc:1061} y {npc:1062} están juntos en las Ruinas de Zul'Kunda. Limpia antes a sus guardias y luego atráelos. Quédate con los Cabellesangre aquí hasta el nivel 41: {quest:586}, en el caldero a continuación, te envía a por Machacacráneos de nivel 41-43.\nEn la costa entre Zul'Kunda y {object:3202}, un {npc:2635} (élite de nivel 38) comparte los puntos de aparición de los crocoliscos normales: mátalo si está y coge su piel para {npc:2495}.",
	-- ["Zanzil's camps"] = "Campamentos de Zanzil",
	-- ["for Stoley in {zone:1446}"] = "para Stoley en {zone:1446}",
	-- ["for a later stop in the {area:8}"] = "para una parada posterior en {area:8}",
	-- ["the {object:2076}"] = "{object:2076}",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- ["{area:392} pier"] = "Muelle de {area:392}",
	-- ["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496}, en el balcón junto a MacKinley, tiene un encargo más: los planos del regulador de combustible del baúl de Cozzle van para Pozzik en {area:2240}, de camino a {zone:1446} hacia el nivel 43.",
	-- ["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, en el piso de arriba: para {quest:2864} en {area:976}",
	-- ["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} y {zone:1435} a nivel 40-43: {object:3202}, los piratas de {area:35}, las cacerías de Nesingwary y {area:75}.",
}
