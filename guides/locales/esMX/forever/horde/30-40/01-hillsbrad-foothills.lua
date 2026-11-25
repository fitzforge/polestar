-- Spanish (Latin America) (esMX): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "Para personajes de nivel 29 a 31: {quest:527}, los encargos de {area:272} y los gnolls de las laderas, todo a tu nivel o por debajo.",

	-- Step 1: Camp Taurajo flight master
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "Maestro de vuelo de {area:378}",
	-- {zone:1441} Thousand Needles · {area:378} Camp Taurajo
	["Coming from the {zone:1441} guide, you stand beside {area:378}'s flight master: this guide flies on from here."] = "Si vienes de la guía de {zone:1441}, estás junto al maestro de vuelo de {area:378}: esta guía sigue en vuelo desde aquí.",

	-- Step 2: Ratchet
	-- {area:392} Ratchet · {area:378} Camp Taurajo · {zone:1441} Thousand Needles · {npc:5901} Islen Waterseer
	["Fly to {area:392} (from {area:378} if you come from the {zone:1441} guide, else from the flight master nearest you). {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "Vuela a {area:392} (desde {area:378} si vienes de la guía de {zone:1441}; si no, desde el maestro de vuelo más cercano). {npc:5901} acampa en la costa, a poca distancia al sur del pueblo; sigue en vuelo hasta el Cruce desde {area:392}.",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "{npc:5901}: tu {item:6637}, para el brasero",

	-- Step 3: Fly to the Crossroads
	["Fly to the Crossroads"] = "Vuela al Cruce",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maestro de vuelo de {area:392}",

	-- Step 4: Fly to the Crossroads
	-- {area:378} Camp Taurajo · {zone:1441} Thousand Needles
	["Fly to the Crossroads: from {area:378} if you come from the {zone:1441} guide, else from the flight master nearest you."] = "Vuela al Cruce: desde {area:378} si vienes de la guía de {zone:1441}; si no, desde el maestro de vuelo más cercano.",

	-- Step 5: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29."] = "{npc:3428} está junto al maestro de vuelo del Cruce. {quest:1145} está disponible desde el nivel 29.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428}: para {npc:4485} en {zone:1454}",

	-- Step 6: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	["Crossroads flight master"] = "Maestro de vuelo del Cruce",

	-- Step 7: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:4949} espera en el Bastión Grommash, en {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, en la fortaleza de Thrall, si la llevas",

	-- Step 8: Train
	["Train"] = "Entrenar",
	["Train your new spells."] = "Entrena tus nuevos hechizos.",

	-- Step 9: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "{npc:4485} está en {object:172958}, de camino a la puerta principal.",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "para {npc:4483} en {area:439}, en la siguiente guía",

	-- Step 10: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 11: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "{npc:260093} entrena a los paladines en {zone:1458}.",

	-- Step 12: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Maestro de vuelo de {zone:1458}",

	-- Step 13: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Vuela a {area:228}. {object:113791} está en la colina justo al suroeste: vence a la Manifestación de agua corrupta que está a su lado, pon sus brazales en el brasero, habla con {npc:5895} y guarda {item:7813} para {npc:5901}. Sigue en vuelo hasta {area:272} desde {area:228}.",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "{item:6637}: bébelo junto a la piedra erguida para ver al elemental",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "para {npc:5901}, en la siguiente guía",

	-- Step 14: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "Maestro de vuelo de {area:228}",

	-- Step 16: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "El cartel de {quest:567} cuelga junto a la posada; {npc:2216} está dentro. {npc:2393}, el cocinero junto a la posada, quiere carne de tortuga y vende las especias para ella.",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "{quest:567}, el cartel junto a la posada",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, adentro",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393}: {quest:7321}, las Tortugas Mordedoras del río al sur del pueblo",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{item:3713}, de {npc:2393}",

	-- Step 17: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 23-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "No hiciste los primeros encargos de Darthalia, de la guía de {area:287} 23-25: ahora van primero. Están unos niveles por debajo de ti y son rápidos, y abren el resto de {quest:527} en esta guía.",

	-- Step 18: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229} quiere que liberes a sus dos exploradores de {area:275}.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, adentro",

	-- Step 19: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "Al oeste, pasando las colinas, hasta las granjas al este del pueblo de {area:287}. {npc:232} trabaja el campo junto a la casa de la granja del norte, y {npc:2403}, el que está más al sureste; hay Mozos de labranza y Granjeros por todas partes.\nCuidado: los Guardias del Kirin Tor (55) patrullan los campos y caminos de {area:287} y atacan a la Horda: mantente atento y quítate de su camino.",

	-- Step 20: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "De vuelta al este, a {area:272}.",

	-- Step 21: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "Campesinos de Trabalomas",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "Regresa a los campos: los Campesinos trabajan al sur de las casas de la granja. Cuidado: un campesino que huye y llega al ayuntamiento puede volver con refuerzos; las ralentizaciones o los enraizamientos evitan que escapen.",

	-- Step 24: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings, and each lock needs its key: {npc:2427} carries the {item:3467} for Drull's, {npc:2428} the {item:3499} for {npc:2238}'s, both in the keep. Kill them first, then open both locks."] = "Al sureste del Molino Tarren. Drull y {npc:2238} están encadenados en los edificios de la corte del castillo, y cada cerradura necesita su llave: {npc:2427} lleva el {item:3467} para la de Drull, {npc:2428} el {item:3499} para la de {npc:2238}, ambos en el castillo. Mátalos primero y luego abre las dos cerraduras.",
	-- {item:3467} Dull Iron Key · {npc:2427} Jailor Eston
	["{item:3467}, from {npc:2427}"] = "{item:3467}, de {npc:2427}",
	-- {item:3499} Burnished Gold Key · {npc:2428} Jailor Marlgen
	["{item:3499}, from {npc:2428}"] = "{item:3499}, de {npc:2428}",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Bola y cadena de {npc:2238}",
	["Drull's ball and chain"] = "Bola y cadena de Drull",

	-- Step 25: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "Regresa a {area:272}.",

	-- Step 26: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "El río al sur de {area:272}: mata a estos a medida que los encuentres",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29-31) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "Al sur de {area:272} siguiendo el río: los Quijaforte (29-31) toman el sol en sus orillas hasta las colinas sobre {area:271}. Algunos llevan {item:3712}.",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "{item:3712}, de las Tortugas Mordedoras",

	-- Step 27: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "Al sur del recodo del río, los gnolls Morrobarro (26-28) acampan en las colinas sobre {area:290}; las flores crecen entre sus tiendas. Los Chamanes curan y llaman a sus compañeros: atráelos primero.",

	-- Step 28: North of Southshore
	["North of Southshore"] = "Al norte de Costasur",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "Desde las flores, vuelve al norte por el río y luego al oeste hasta el pueblo de {area:287}, bastante al norte de {area:271} (sus guardias son de nivel 55).",

	-- Step 29: The smithy
	["The smithy"] = "La herrería",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the west side of the town; {npc:2451} works the field south-east of the town."] = "Al oeste, por las estribaciones, hasta el pueblo de {area:287}: la herrería está en el centro. {npc:2404} y sus aprendices trabajan en la forja; el {object:1736} está apilado junto a ella. {npc:2449} camina por el lado oeste del pueblo; {npc:2451} trabaja el campo al sureste del pueblo.",
	["Inside"] = "Adentro",
	-- {npc:2449} Citizen Wilkes
	["{npc:2449}, on the west side of the town"] = "{npc:2449}, en el lado oeste del pueblo",

	-- Step 30: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "para {npc:2055}, en la parada en {zone:1458} al final de esta guía",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "{npc:2429}, en el pueblo: {item:3708}, de los yetis de camino al ayuntamiento",
	-- {npc:2418} Deathguard Samsa · {npc:2393} Christoph Jeffcoat
	-- plural, as words: Hillsbrad Human Skulls = {item:3692} Hillsbrad Human Skull
	["{npc:2418}, beside {npc:2393}: Hillsbrad Human Skulls, from the townsfolk and miners this guide fights next"] = "{npc:2418}, junto a {npc:2393}: cráneos humanos de Trabalomas, de los aldeanos y mineros con los que pelea esta guía a continuación",

	-- Step 31: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "Al oeste del Molino Tarren, los Yetis de las cuevas y los Yetis feroces (30-32) llenan {area:277}, en las colinas; más o menos uno de cada dieciséis lleva la vara. Quédate en estas cavernas: los Yetis monteses y Yetis gigantes (32-34) de la cueva más al norte también la llevan, pero pegan fuerte y van en parejas.",

	-- Step 32: Town hall
	["Town hall"] = "Ayuntamiento",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town. Every {area:287} human you kill from here on can drop a skull for Samsa: keep them."] = "Sigue hasta el pueblo de {area:287}, al suroeste de las cuevas de los yetis. El ayuntamiento está en el lado oeste del pueblo: {npc:2335} (30) y {npc:2448} están adentro con el Registro del pueblo; la Proclama está clavada a su lado. Los concejales recorren el pueblo. Cualquier humano de {area:287} que mates de aquí en adelante puede soltar un cráneo para Samsa: guárdalos.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, adentro",

	-- Step 33: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "El siguiente encargo de Thaivand, las llamas, te manda entre los Yetis monteses y Yetis gigantes (32-34) y a la tumba de Helcular dentro de {area:271}: omítelo.",

	-- Step 34: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "Para tu recorrido por Ciudad de Dalaran, más adelante en esta guía: {npc:2278} está en {area:272}, a poca distancia al este de {npc:2410}.",

	-- Step 35: City of Dalaran
	["City of Dalaran"] = "Ciudad de Dalaran",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "Ciudad de Dalaran es una mazmorra para un grupo de cinco, de nivel 28 a 33 más o menos, bajo la cúpula violeta. Sin {item:277507}, entra por la tubería de la alcantarilla al noroeste del cráter: la flecha te lleva ahí.\nAdentro: {npc:247126} es de {npc:2278}. {npc:268743}, en la alcantarilla, da “Opportunistic Education” y la recibe de vuelta ahí.",
	-- {quest:96986} The Grave Knight
	["{quest:96986}: Atrexis, inside"] = "{quest:96986}: Atrexis, adentro",

	-- Step 36: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. The miners work inside the {area:288}, below the hill: go in at its mouth on the west side, where the arrow leads first. Miners (26-27) work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside. Keep killing Miners until Samsa's thirty skulls are in your bags: most {area:287} humans drop one."] = "Ve al suroeste pasando el pueblo de {area:287} hasta {area:288}. Los mineros trabajan dentro de {area:288}, bajo la colina: entra por su boca del lado oeste, adonde la flecha lleva primero. Los mineros (26-27) trabajan en los túneles; {npc:2305} (30) y {npc:2450} (29) están al fondo. Sigue matando mineros hasta tener en las bolsas las treinta calaveras de Samsa: la mayoría de los humanos de {area:287} sueltan una.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "Dentro de {area:288}",
	-- {item:3692} Hillsbrad Human Skull · {area:287} Hillsbrad
	["{item:3692}, from the Miners and every {area:287} human"] = "{item:3692}, de los mineros y de cualquier humano de {area:287}",

	-- Step 37: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "Termina la {item:3712}",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river just east of {area:272}, a short way from town."] = "¿Aún no tienes diez de {item:3712}? Los Quijaforte bordean el río justo al este de {area:272}, a poca distancia del pueblo.",

	-- Step 38: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "Vuelve al noreste a {area:272}, pasando bien al norte de {area:271} (sus guardias son de nivel 55).",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}: su siguiente {quest:539} y la espada de {npc:2419} son misiones de grupo élite en {area:290}: tómalas solo con un grupo",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "{npc:2229}, adentro: Infiltration, se hace en la visita de 38-39 (su Sindicato es de 32-35)",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "Guarda Infiltration en tu registro: su Sindicato (32-35) está por encima de ti ahora, y la guía de 38-39 (Alterac y Arathi) la hace en su primera vuelta por {area:272}.",

	-- Step 39: Level 30
	["Level 30"] = "Nivel 30",
	-- {npc:2410} Magus Wordeen Voidglare · {zone:1454} Orgrimmar · {area:272} Tarren Mill · {zone:1437} Wetlands
	["{npc:2410}'s quests in the inn and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Still short of 30 after these hand-ins? The Snapjaws (29-31) line the river just east and south of {area:272}: kill them until level 30, then walk back into town. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "Las misiones de {npc:2410} en la posada y Las relaciones de la Alianza en {zone:1454}, la primera parada de la siguiente guía, están disponibles desde el nivel 30. ¿Todavía no llegas a 30 después de estas entregas? Los Quijaforte (29-31) bordean el río justo al este y al sur de {area:272}: mátalos hasta el nivel 30 y luego vuelve caminando al pueblo. O, en grupo, haz la mazmorra del Sitio de excavación (en {zone:1437}).",
	["Snapjaws"] = "Quijafortes",
	["grind on Snapjaw"] = "sube de nivel con los Quijaforte",

	-- Step 40: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "Vacuamirada, Bel'varil y {npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410} y {npc:2437} están dentro de la posada, y {npc:2770} justo afuera. Sus misiones se ofrecen desde el nivel 30; si no lo tienes, la primera parada en {area:272} de la guía de 38-39 las toma.",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "{npc:2410}, adentro: {quest:544}, para la visita de 38-39 (los traidores del cráter de {area:279} son de 33-35)",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410}: {quest:93680}, con {quest:544} en la visita de 38-39",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "{npc:2437}, adentro: {quest:556}, con el cráter en la visita de 38-39",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "{npc:2770}, afuera de la posada: los ogros Puño de Roca (32-34) en la visita de 38-39 a Arathi",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "Guarda estas en tu registro: sus campamentos están de dos a cuatro niveles por encima de ti ahora, y la guía de 38-39 las hace en su primera vuelta por {area:272} y en {area:321}.",

	-- Step 41: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "{quest:96986} de tu recorrido por Ciudad de Dalaran: {npc:2278}, a poca distancia al este de {npc:2410}.",

	-- Step 42: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "{quest:539} en grupo",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "La última batalla de Darthalia es en {area:290}, la fortaleza enana al sureste de {area:271}: todos los enanos de ahí son élite (28-32), también {npc:2304}. Mucha experiencia si tienes grupo para ello.",

	-- Step 43: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "{quest:547} en grupo",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "La espada de {npc:2419} la sueltan los mismos enanos de {area:290} (más o menos uno de cada doce).",

	-- Step 44: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "Despeja {area:290} desde la puerta hacia adentro; los enanos huyen a pedir ayuda al 30 % de salud.",

	-- Step 45: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "para {npc:2425} en {zone:1458}, al final de esta guía",

	-- Step 47: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Vuela a {area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Maestro de vuelo de {area:272}",

	-- Step 48: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055} está en el Boticarium, en {object:36126}.",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "La siguiente misión de Faranell, {quest:513}, requiere un {item:3388} ({skill:171}) y la costa de {area:287}: déjala.",

	-- Step 49: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "{npc:2425} está junto a Sylvanas en {object:36126}.",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "{npc:2425}: el elogio de Darthalia",

	-- Step 50: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038} está en la botica real. Su {quest:97985} es para Stormheart, un élite de nivel 30 que recorre el cañón al este de {area:484}, en el camino de la siguiente guía hacia {area:439}.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}: vuelve con él en la siguiente parada en {zone:1458}, cerca del nivel 38",

	-- Step 51: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instructores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entrena mientras estás en {zone:1458}: los instructores están en {object:36070}, {object:36073} y {object:36082} (paladines: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "De vuelta a las cuevas de los yetis al oeste de {area:272} con {item:3710}. El camino se divide justo al entrar: {object:1768} arde en el nivel superior a la derecha, {object:1769} en el nivel inferior a la izquierda, pasando más yetis.",
	-- ["Back north to {area:321}."] = "De vuelta al norte, a {area:321}.",
	-- ["Back to {area:272}"] = "De vuelta a {area:272}",
	-- ["Below ground"] = "Bajo tierra",
	-- ["Boulderfist camp"] = "Campamento Puño de Roca",
	-- ["Daggerspine naga"] = "Nagas Espinadaga",
	-- ["Daggerspine shore"] = "Costa Espinadaga",
	-- ["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "Vuela de {area:484} a {area:1638} y entrena con {npc:3033} en {area:1639}; desde ahí sigue en vuelo hasta el Cruce.",
	-- ["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "Vuela de {area:484} a {area:392}. {npc:5901} acampa en la costa, a poca distancia al sur del pueblo; sigue en vuelo hasta el Cruce desde {area:392}.",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Sigue el camino al norte desde {area:272} hacia las faldas de Alterac. {quest:535} espera junto al campamento de la Hermandad; entrégale la cerveza.",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "Para personajes de nivel 29 a 33, pero la mayoría de las misiones de aquí son de nivel 32-34, y algunas de hasta 36: a propósito, por su experiencia. La Hermandad, los guardias de {area:279} y los ogros Puño de Roca son de nivel 31-35, así que atráelos de uno en uno.",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Desde {area:271}, ve al norte pasando {area:272} y sigue el camino hasta las estribaciones de Alterac. {quest:535} espera junto al campamento de la Hermandad. Solo ofrece su encargo mientras lleves “Infiltración” de {npc:2229}: dale la cerveza de inmediato, y su recompensa es la Misiva de la Hermandad que quiere Krusk. Una misiva de la Hermandad de aquí sirve igual: con una en tus bolsas, la guía omite a {quest:535}.",
	-- ["Head back north to {area:272}."] = "Regresa al norte, a {area:272}.",
	-- ["Head back south down the road to {area:272}."] = "Regresa al sur por el camino hasta {area:272}.",
	-- ["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Sal de {area:272} hacia el este por {area:1057} y sigue el camino al este. Los ogros y ejecutores Puño de Roca (32-34) acampan al sur del camino, al sur de {area:313}; los ejecutores se quedan en la cueva de ahí.",
	-- ["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north, down the slope above the town. Southshore Guards (55) stand at the graveyard's north-west corner and south-east of the grave: walk in between them, hand the quest in and leave the way you came."] = "Ve al este hasta el cementerio de {area:271}, en el borde noreste del pueblo: la tumba de Helcular está entre las demás. Llega desde el norte, bajando por la ladera que está sobre el pueblo. Los Guardias de Costasur (55) están en la esquina noroeste del cementerio y al sureste de la tumba: pasa entre ellos, entrega la misión y vete por donde llegaste.",
	-- ["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Ve al sur pasando el pueblo de {area:287} hasta {area:288}. Los mineros trabajan en los túneles; {npc:2305} (30) y {npc:2450} (29) están en lo profundo.",
	-- ["Head south-west past {area:287} town to the {area:288}. Miners (26-27) work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside. Keep killing Miners until Samsa's thirty skulls are in your bags: most {area:287} humans drop one."] = "Ve al suroeste pasando el pueblo de {area:287} hasta {area:288}. Los mineros (26-27) trabajan en los túneles; {npc:2305} (30) y {npc:2450} (29) están en lo profundo. Sigue matando mineros hasta tener en tus bolsas los treinta cráneos de Samsa: casi todos los humanos de {area:287} sueltan uno.",
	-- ["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Ve al suroeste pasando el pueblo de {area:287} hasta {area:288}. Los mineros trabajan en los túneles; {npc:2305} (30) y {npc:2450} (29) están en lo profundo.",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp. Arcane Sentries (55, elite) and Kirin Tor Guards (55) stand around the violet dome itself: keep to the camp below the rim."] = "Ve al oeste por el pie de las montañas hasta la cúpula violeta de {area:279}. {npc:2411}, {npc:2412} y {npc:2413} (33-34) están juntos dentro del borde este del cráter, {npc:2414} (35) un poco al oeste de ellos; cada uno lleva un trozo de piedra de sangre. Los guardias escudo y los teurgos (31-33) que los rodean sueltan las Fichas de piedra gastadas. Cuidado: Muchos guardias están en parejas vinculadas y otros patrullan solos alrededor del campamento. Hay Centinelas arcanos (55, élite) y Guardias del Kirin Tor (55) alrededor de la propia cúpula violeta: quédate en el campamento bajo el borde.",
	-- ["Highland raptors and Plains Creepers"] = "Raptores de las tierras altas y reptadores de llanura",
	-- ["Level 31"] = "Nivel 31",
	-- ["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "El siguiente encargo de Lydon es un barril de cerveza Shindigger del sótano de {area:290}, la fortaleza enana de élites al sureste de {area:271}: tómalo solo si vas allí con un grupo.",
	-- ["North of Southshore's graveyard"] = "Al norte del cementerio de Costasur",
	-- ["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "De regreso al norte, los zancudos de las Tierras Altas recorren las colinas alrededor de {area:321} y sueltan los ojos, y al sur los reptadores de llanura (32-33) tejen sus telarañas en la hierba; ellos llevan la seda de araña.",
	-- ["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Sigue hasta el pueblo de {area:287}, al suroeste de las cuevas de los yetis. El ayuntamiento está en el lado oeste del pueblo: {npc:2335} (30) y {npc:2448} están adentro con el Registro del pueblo; la Proclama está clavada a su lado. Los concejales recorren el pueblo.",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "Solo si no conseguiste la misiva de {quest:535}: los Asaltantes de caminos de la Hermandad ({npc:2240}) y Ladrones (32-34) alrededor de los campamentos al oeste del camino también llevan misivas; uno de cada tres suelta una. Cuidado: a nivel 31-32 todavía están por encima de ti y están muy juntos, con Zahoríes (34-35) entre ellos: atráelos de uno en uno desde el borde del campamento.",
	-- ["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "Pon {object:1729} sobre {object:1728} junto a la posada; en el piso de arriba",
	-- ["Shindigger keg"] = "Barril Machacacanillas",
	-- ["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "Al sur de {area:272} siguiendo el río: las Tortugas Mordedoras (29) toman el sol en sus orillas hasta las colinas sobre {area:271}. Algunas llevan {item:3712}.",
	-- ["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Al sur de Sentencia, los trols Secacorteza ocupan la aldea en las colinas. Los lanzahachas vigilan las chozas exteriores; los médicos brujos y los cazacabezas ocupan el centro de la aldea. Cuidado: Los tres tipos de trol huyen a pedir ayuda al 15 % de salud, lo que puede atraer más trols de los campamentos cercanos.",
	-- ["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "Al sureste del Molino Tarren. Drull y {npc:2238} están encadenados en los edificios del patio de la fortaleza: {npc:2427} lleva la {item:3467} y {npc:2428}, la {item:3499}, ambos dentro de la fortaleza. Mátalos y luego abre ambos candados.",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "Al suroeste, los Yetis de las cuevas y los Yetis feroces (30-32) llenan {area:277}, en las colinas al oeste de {area:272}; más o menos uno de cada dieciséis lleva la vara. Quédate en estas cavernas: los Yetis monteses y Yetis gigantes (32-34) de la cueva más al norte también la llevan, pero a nivel 29-30 pegan fuerte y van en parejas.",
	-- ["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "¿Aún no tienes diez de {item:3712}? Los Bocadientes bordean el río al este de {area:272}, de camino de vuelta desde la mina.",
	-- ["Syndicate missives"] = "Misivas de la Hermandad",
	-- ["The Daggerspine naga line the shore south-east of the town."] = "Los nagas Espinadaga ocupan la orilla al sureste del pueblo.",
	-- ["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "Los barriles de cerveza Shindigger están en el sótano de {area:290}, la fortaleza enana al sureste de {area:271}, junto a {npc:2304} (32); todos los enanos de ahí son élite (28-32).",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Los Asaltantes de caminos de la Hermandad ({npc:2240}) y Ladrones (32-33) alrededor de los campamentos al oeste del camino llevan las misivas; uno de cada tres suelta una.",
	-- ["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "Los múrlocs Aleta Rasgada acampan en las playas al suroeste de la bahía de {area:271}, debajo de la mina.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "El barril está con algunos otros en el campamento de la Hermandad, en la costa sureste de {area:287}.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "La fortaleza orca del extremo este del camino. {npc:2851}, la maestra de jinetes del viento, está junto a la puerta.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "El bastión orco al extremo este del camino. {npc:2851}, la maestra de jinetes del viento, está junto a la puerta.\n{npc:15126} solo ofrece {quest:8263} cuando eres Amistoso con los Rapiñadores ({zone:1461}): omítela si no te la ofrece.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "La tercera llama arde en la cueva más pequeña, arriba en las colinas al norte de las cavernas.\nCuidado: Yetis gigantes y Yetis monteses (32-34) rodean la llama, a menudo en parejas, y Faucehielo, un yeti raro (37), deambula cerca. A nivel 30-31 están por encima de tu nivel: atrae a los yetis de uno en uno desde la boca de la cueva antes de usar la Vara, y ubica a Faucehielo antes de entrar.",
	-- ["The {area:279} crater"] = "El cráter de {area:279}",
	-- ["The {area:279} crater's eastern rim"] = "El borde oriental del cráter de {area:279}",
	-- ["Torn Fin beach"] = "Playa Rompeanca",
	-- ["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "Al oeste por las laderas hasta el pueblo de {area:287}: la herrería está en el centro. {npc:2404} y sus aprendices trabajan en la forja; el {object:1736} está apilado a su lado.",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "Al oeste por las laderas hasta el pueblo de {area:287}: la herrería está en el centro. {npc:2404} y sus aprendices trabajan en la forja; el {object:1736} está apilado a su lado. {npc:2449} camina junto a la herrería; {npc:2451} trabaja el campo al sureste del pueblo.",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "Con un {item:3388} en tus bolsas, {npc:2055} ofrece {quest:513} en la botica real; {npc:2216} recibe el elixir en {area:272}.",
	-- ["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "No hiciste los primeros encargos de Darthalia, de la guía de {area:287} 22-25: ahora van primero. Están unos niveles por debajo de ti y son rápidos, y abren el resto de {quest:527} en esta guía.",
	-- ["grind on {npc:2248}"] = "sube de nivel con {npc:2248}",
	-- ["grind on {npc:2375}"] = "mata {npc:2375} para subir de nivel",
	-- ["grind on {npc:2562}"] = "sube de nivel con {npc:2562}",
	-- ["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the City of Dalaran dungeon instead."] = "{quest:544}, {quest:556} y {quest:676} de {area:272} se ofrecen desde el nivel 30. ¿Estás por debajo? Sigue matando a los yetis de estas cuevas hasta el nivel 30. O, en grupo, haz la mazmorra Ciudad de Dalaran.",
	-- ["{area:321} flight master"] = "Maestro de vuelo de {area:321}",
	-- ["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the City of Dalaran dungeon instead."] = "Las misiones de {area:321} son de 32-36. ¿Por debajo de 31? Sigue matando a los ogros y ejecutores Puño de Roca de este campamento hasta el nivel 31. O, en grupo, haz la mazmorra Ciudad de Dalaran.",
	-- ["{area:484} flight master"] = "Maestro de vuelo de {area:484}",
	-- ["{item:278225}, from Plains Creepers"] = "{item:278225}, de los reptadores de llanura",
	-- ["{item:279469}: an object to loot, by the traitors"] = "{item:279469}: un objeto para saquear, junto a los traidores",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}: casa de subastas o un alquimista, para {quest:513}.",
	-- ["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",
	-- ["{npc:12920}, at the south gate"] = "{npc:12920}, en la puerta sur",
	-- ["{npc:2229} now offers {npc:2316} (level 36), Bel'varil Bracers of Binding and Voidglare Dalaran Patrols: leave them for the 38-39 visit, which takes them on its first {area:272} stop."] = "{npc:2229} ahora ofrece {npc:2316} (nivel 36), “Bel'varil Bracers of Binding” y “Voidglare Dalaran Patrols”: déjalas para la visita en el nivel 38-39, que las toma en su primera parada en {area:272}.",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229} quiere que liberes a sus dos exploradores de {area:275} antes de confiarte “Infiltración”.",
	-- ["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "Las misiones de {npc:2410} en la siguiente parada en {area:272} y Alliance Relations en {zone:1454}, la primera parada de la siguiente guía, se ofrecen desde el nivel 30. ¿Te falta para el 30? Los Habitabostas y Correcostas Rompeanca (28-30) llenan la costa al sur de {area:288}, a poca distancia: mátalos hasta el nivel 30. Sus Oráculos (30-31) lanzan hechizos desde la orilla más al este. O, con un grupo, haz mejor el calabozo de la Excavación (en {zone:1437}).",
	-- ["{npc:2410}, inside"] = "{npc:2410}, adentro",
	-- ["{npc:2410}, inside: offered from level 30"] = "{npc:2410}, adentro: se ofrece desde el nivel 30",
	-- ["{npc:2410}: for the 38-39 visit to Alterac"] = "{npc:2410}: para la visita a Alterac en el nivel 38-39",
	-- ["{npc:2410}: he offers {quest:545} after it"] = "{npc:2410}: ofrece {quest:545} después de esta",
	-- ["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}: {quest:93680}, {item:279469} está junto a los traidores",
	-- ["{npc:2437}, inside"] = "{npc:2437}, adentro",
	-- ["{npc:2437}, inside: offered from level 30"] = "{npc:2437}, adentro: se ofrece desde el nivel 30",
	-- ["{npc:2437}: for the 38-39 visit to Alterac"] = "{npc:2437}: para la visita a Alterac en el nivel 38-39",
	-- ["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "Astucia del raptor de {npc:2706}, la siguiente {quest:677} de {npc:2771} y Reabastecer las guardas del doctor esperan a la visita del nivel 38-39.",
	-- ["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "{npc:2706}: los del Sindicato están junto al camino que llega desde {area:272}, en la visita del nivel 38-39",
	-- ["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "{npc:2770}: para {npc:2771} en {area:321}, más adelante en esta guía (desde el nivel 30)",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}, junto a la puerta",
	-- ["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} está junto al maestro de vuelo del Cruce.",
	-- ["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428} está junto al maestro de vuelo de El Cruce. {quest:1145} está disponible desde el nivel 29; si aún no lo tienes, la parada en {zone:1454} de la siguiente guía la recoge.",
	-- ["{quest:513} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "{quest:513} necesita {item:3388}, un objeto de {skill:171}: compra uno en la casa de subastas si puedes (o pídeselo a un alquimista). El texto de la misión dice Fuerte, pero lleva {item:3388}. ¿Sin elixir? Omite los pasos del elixir en {area:287}.",
	-- ["{quest:515} with a group"] = "{quest:515} en grupo",
	-- ["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}: {npc:247126}, adentro",
	-- ["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",
}
