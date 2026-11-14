-- Spanish (Latin America) (esMX): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instructores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entrena mientras estás en {zone:1458}: los instructores están en {object:36070}, {object:36073} y {object:36082} (paladines: {npc:260093}).",

	-- Step 3: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 4: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside the inn"] = "{npc:2229}, dentro de la posada",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "El cartel de {object:1763} junto a la posada",

	-- Step 6: Gol'dir
	-- {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Ve al norte pasando el campamento de Valik hasta {area:280}, la aldea tomada por el Sindicato (35-37). {npc:2431} lleva {item:3704}; {quest:503} está en una jaula en la casa del lado norte.\nCuidado: hay espías sigilosos del Sindicato en {area:280}, y los edificios albergan muchas criaturas del Sindicato, magos entre ellas.",
	["Inside"] = "",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Encuentra dónde tienen a {quest:503}, en el piso superior",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, en el piso superior",

	-- Step 8: Tarren Mill
	-- {npc:2229} Krusk · {area:272} Tarren Mill
	["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} espera dentro de la posada de {area:272}, de regreso al sur por el camino.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",

	-- Step 9: Baron Vardus
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad · {quest:503} Gol'dir
	["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) lleva la cabeza. Aparece en un solo lugar a la vez: el sótano de la posada de {area:280}, o uno de los campamentos de tiendas del Sindicato en las tierras altas al norte y noroeste de la aldea, que quedan de camino a la mansión Perenolde. Si ya lo encontraste al liberar a {quest:503}, este paso está hecho.",

	-- Step 10: Alterac Mountains
	["Perenolde manor"] = "Mansión Perenolde",

	-- Step 11: Lord Aliden Perenolde
	-- {area:1339} Lordamere Lake · {quest:507} Lord Aliden Perenolde · {npc:2317} Elysa
	["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Ve al noroeste por las montañas hasta la mansión Perenolde, en la orilla norte de {area:1339}. {quest:507} (41) espera en una habitación del piso de arriba: se protege con escudo, te duerme y se cura por debajo de la mitad de salud. {npc:2317} está a su lado.",

	-- Step 12: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}: mátalos cuando te los encuentres",
	-- {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave
	["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves."] = "Al sur por la orilla del lago hasta las ruinas alrededor del cráter de {area:279}. Los Invocadores de Dalaran dirigen Esclavos elementales; los brazales caen de los esclavos.",

	-- Step 14: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "Regresa al este hacia {area:272}.",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	["The magus offers a dungeon errand next: leave it."] = "El magus ofrece a continuación un encargo de calabozo: déjalo.",

	-- Step 15: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "El camino al este por {area:1057}",

	-- Step 16: Northfold Manor
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Ve al este saliendo de {area:272} por {area:1057}. El Sindicato ocupa la mansión amurallada y su granja al norte del camino; sus Salteadores, Mercenarios y Acechasendas llevan los Amuletos de sangrita.\nCuidado: los Salteadores (nivel 30-31) pueden estar en Sigilo, así que pueden estar ocultos cuando te acerques.",

	-- Step 17: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Sigue el camino al este. Los fragmentos violeta brillan justo al lado del camino, a poca distancia al oeste de {area:321}.",

	-- Step 18: Hammerfall
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "",

	-- Step 19: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Misiones de Stromgarde para un grupo",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "{quest:639} de {npc:2703} cae de los élite del Sindicato (35-38) en las ruinas de Stromgarde, al oeste de las tierras altas. Excelentes PX si tienes un grupo: la ruta pasa por Stromgarde camino al círculo interior.",

	-- Step 20: Foul Magics with a group
	-- {quest:671} Foul Magics
	["{quest:671} with a group"] = "{quest:671} en grupo",
	-- {npc:2706} Tor'gan · {quest:671} Foul Magics · {npc:2783} Marez Cowl
	["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "La siguiente {quest:671} de {npc:2706} es {npc:2783}, un brujo élite de nivel 40 en el barrio del Sindicato de Stromgarde.",

	-- Step 21: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Al noreste de Sentencia, los kobolds Bigotesecos extraen mineral en la garganta; los Kobolds de la entrada y los Excavadores y Topógrafos más adentro sueltan las Motas de Myzrael.\nCuidado: todos los tipos de kobold huyen a pedir ayuda con poca salud (los Kobolds al 30%, los Topógrafos y Excavadores al 15%), lo que puede atraer a más.",

	-- Step 22: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} están en el extremo del cañón.",
	["Below ground"] = "Bajo tierra",

	-- Step 23: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Cada {object:180105} es un anillo de piedras erguidas; la llave está en la piedra de su centro. El círculo del este está en las colinas al noroeste de {area:321}.\nCuidado: cada piedra central está custodiada por unos tres elementales de nivel 39 aproximadamente que atacan juntos si haces clic en la piedra sin eliminarlos: Exiliados ardientes en el Oeste, Exiliados tronadores en el Exterior, Exiliados acuosos en el Este.",

	-- Step 24: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Los Toscos Puño de Roca acampan fuera del salón de los ogros, muy al suroeste de {area:321}; los Magus están entre ellos. Atráelos de uno en uno.",

	-- Step 25: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptores acechacarne",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Los acechacarnes de las Tierras Altas (36-37) cazan en las tierras altas del sur, una manada al norte de {area:316} y otra en la llanura al oeste. Atráelos de uno en uno.",

	-- Step 26: Go'shek Farm
	["Go'shek Farm"] = "Granja Go'shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "La cabaña laboratorio de {npc:2733} está en la Granja Go'shek, al noreste de la llanura de los raptores, de camino de regreso a {area:321}; el estuche de {item:278462} está adentro.",

	-- Step 27: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "De vuelta a {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "De regreso al noreste hacia {area:321}.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, junto a la puerta",

	-- Step 28: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Misiones de Puñopedrusco para un grupo",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "La siguiente {quest:678} de {npc:2771} y {quest:680} de {npc:2772} son los ogros élite (38-40) en el barrio de los ogros de Stromgarde, en el mismo viaje de grupo que el Sello.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, a su lado",

	-- Step 29: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Ve al oeste; el círculo exterior está en medio de las tierras altas.",

	-- Step 30: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "El círculo del oeste está cerca de {area:1057}, al noroeste del exterior.",

	-- Step 31: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "El círculo interior está al sur del círculo del oeste, al este de Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "La siguiente tarea de la piedra requiere a Fozruk, una élite de nivel 42 que ronda al oeste de {area:321}: déjala.",

	-- Step 32: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {npc:2783} Marez Cowl · {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "Al oeste del círculo interior, las ruinas de Stromgarde: el Sindicato ocupa la mitad este (el Sello cae de sus Conjuradores, Merodeadores y Magos; {npc:2783} está entre ellos), los Puñopedrusco la mitad oeste junto a {area:325} ({npc:2773} espera en una de las casas sin techo a su lado).",

	-- Step 33: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Ve al sur hacia la cala de los goblins en la costa sur. {npc:2766} vigila desde el acantilado sobre ella.",

	-- Step 34: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 36: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "Al oeste de la cala, los asaltantes y hechiceras Espinadaga (38-40) ocupan la orilla: atráelos de uno en uno. Los dos naufragios están en los bajíos frente a ella, con las cartas y los diarios dentro; las gemas están en el fondo del mar alrededor de los naufragios.",
	["Underwater"] = "",

	-- Step 37: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "para {npc:2487} en {area:35}, alrededor del nivel 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "La siguiente guía cruza {area:880} hacia {zone:1437} y se dirige a {zone:1418}.",

	-- Step 38: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Solo si hiciste Stromgarde en grupo: regresa a {area:321} para sus entregas y luego continúa hacia {area:880}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Los toscos Puño de Roca acampan fuera de la sala de los ogros al sur de {area:321}; los magus están entre ellos. Atráelos de uno en uno.",
}
