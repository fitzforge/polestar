-- Spanish (Spain) (esES): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Vuelve al oeste hasta el camino y síguelo hacia el sur, fuera de {zone:1432}, por el paso hasta {zone:1418}. {npc:2910} y {npc:2860} acampan juntos en la excavación.",

	-- Step 2: Shadowforge camp
	["Shadowforge camp"] = "Campamento Forjatiniebla",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Los enanos Forjatiniebla acampan justo al norte de la excavación; el Mapa arrugado está entre sus tiendas. Los Tuneladores y los Tejeoscuros llevan el Pico de la suerte de Ryedol. Los Coyotes del risco recorren las laderas de alrededor.",

	-- Step 3: The excavation crate
	["The excavation crate"] = "El cajón de la excavación",
	["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Cabalga al noreste hasta la excavación abandonada; el Cajón de provisiones de excavación está allí, entre los ogros Rotapolvo.",

	-- Step 4: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "El siguiente encargo del Prospector Ryedol es en {area:1517}: omítelo.",

	-- Step 5: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} y {npc:2817} acampan juntos en {area:1877}, en el centro de {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Las almejas están en la costa noroeste de la Vega de Tuercespina, en la siguiente guía: guárdala",

	-- Step 6: Ogres and buzzards
	["Ogres and buzzards"] = "Ogros y águilas ratoneras",
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Los ogros Rotapolvo acampan justo al sur del valle; cualquiera suelta chatarra. Las águilas ratoneras sobrevuelan la llanura al este.",

	-- Step 7: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "El esqueleto maltrecho está justo al este de los ogros, al borde del campamento de los troggs Grutacanto; los Partehuesos y los Chamanes de alrededor sueltan las escamas. Theldurin el Perdido está sentado junto al campamento en ruinas, más al sur.",
	-- {zone:1418} Badlands
	["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "La siguiente tarea del esqueleto, Murdaloc, espera a la guía posterior de {zone:1418}, a nivel 43.",

	-- Step 8: Valley of Fangs
	-- {npc:4454} Fizzle Brassbolts · {area:439} Shimmering Flats · {zone:1446} Tanaris
	["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "para {npc:4454} en {area:439}: la guía de {zone:1446} pasa por allí a nivel 45, guárdala",

	-- Step 9: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Cabalga al oeste hasta {area:1878}; {npc:2921} Veriatus trabaja junto a sus máquinas en el centro.",

	-- Step 10: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementales de piedra inferiores",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Los Elementales de piedra inferiores deambulan por {area:1878}, al oeste de {npc:2921} Veriatus.",

	-- Step 12: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementales de piedra",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Los elementales de piedra ({npc:92}) recorren el sureste de {npc:2921}; las águilas ratoneras gigantes ({npc:2831}) y los coyotes del risco mayores ({npc:2729}) comparten la llanura al oeste.",

	-- Step 14: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Elementales de piedra mayores",
	-- {area:342} Camp Boff
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental · Dustbelcher Wyrmhunters = {npc:2716} Dustbelcher Wyrmhunter
	["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Los Elementales de piedra mayores (nivel 42) recorren el extremo suroeste, por debajo de {area:342}; atráelos de uno en uno. Los Cazavermis Rotapolvo y los Destructores de {area:342} también sueltan chatarra.",

	-- Step 15: Lotwil Veriatus
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, junto a {npc:2921} Veriatus",
	-- {item:2868} Patterned Bronze Bracers
	["only if you carry {item:2868} (a blacksmith's craft)"] = "solo si llevas {item:2868} (los fabrica un herrero)",
	-- {npc:2921} Lotwil Veriatus
	["{npc:2921}'s next test needs crafted gear: skip it."] = "La siguiente prueba de {npc:2921} Veriatus requiere equipo fabricado: omítela.",

	-- Step 16: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Cabalga al noreste hasta las ruinas enanas del norte de {zone:1418}; el cofre está entre los enanos Forjatiniebla. {npc:2745}, cerca, es élite: mantén la distancia.",

	-- Step 18: Theldurin the Lost
	-- {area:345} Agmond's End
	["Ride south to {area:345}."] = "Cabalga al sur hasta {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "para {npc:2786} en {zone:1455}: guárdala",

	-- Step 19: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn"] = "{npc:1470}, en la posada",

	-- Step 20: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Toma el barco a Theramore en el muelle del fondo.",

	-- Step 21: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "El maestro de vuelo está junto a la puerta de {area:514}; {npc:5083} y {npc:4964} están dentro de la ciudadela.",
	["for the Dustwallow loop in the next guide"] = "para la vuelta por Marjal Revolcafango de la siguiente guía",

	-- Step 23: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "",

	-- Step 24: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "",

	-- Step 25: Lord Kragaru
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, un jefe centauro, acampa en la costa noroeste, al norte de la torre de {npc:11863} Aldamort.",

	-- Step 27: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {item:6245} Karnitol's Satchel
	["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "La siguiente tarea de {npc:5638} Ungor, {item:6245}, se consigue en la costa lejana: omítela.",

	-- Step 28: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Sigue el camino hacia el sur hasta {area:2407}.",

	-- Step 29: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} está al borde de {area:596}, al suroeste de {area:2407}; {object:176751} están entre los esqueletos. Un {npc:217590} se arrastra por el cementerio: atrapa uno con el Entomology Starter Kit y márcalo.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: atrápalo, para My Little Friends",

	-- Step 30: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Los centauros Maraudine ocupan {area:607}, al oeste del cementerio; todos sueltan los tótems.",

	-- Step 31: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} está presa en el campamento centauro al oeste del cementerio. Libérala y mantenla con vida al salir; se detiene junto al cementerio.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolta a {npc:12277} de vuelta hacia el cementerio",

	-- Step 33: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:606} Gelkis Village · {area:602} Mannoroc Coven · {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "La caravana de {npc:11626} se detiene en el camino al este de {area:606}. Acepta la misión y acompaña a los kodos pasando {area:602}, matando a los demonios que los asaltan; después habla con {npc:11596} en su campamento al este de {area:596}.",

	-- Step 34: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Los demonios se reúnen en {area:602}, al sur de {zone:1443}: canes manáfagos (Devoradores de maná, Cazadores de magos y Cazadores Ley), Doncellas infernales y Hermanas infernales, y Capitanes Guardiavil alrededor del foso.",

	-- Step 35: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Los Devastadores no-muertos recorren los campos de huesos al sur del Poblado Magram, al este del aquelarre; en el extremo sureste, usa el {item:15848} para atraer a los Espectros Magrami.",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Sigue el camino hacia el norte hasta {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} en {zone:1455}: guárdala",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} en {area:271}: guárdala",

	-- Step 39: Fly to Theramore
	["Fly to Theramore"] = "Vuela a Theramore",
	["The next guide starts in Theramore."] = "La siguiente guía empieza en Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Sigue el camino hacia el oeste por el norte de {zone:1443} hasta las ruinas de {area:2405}; el cofre del barco naufragado está en la orilla, justo al oeste.",
	-- ["{item:7337} Elementals roam south-east of Lotwil; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Los elementales de {item:7337} recorren el sureste de Lotwil Veriatus; las Águilas ratoneras gigantes y los Coyotes del risco mayores comparten la llanura al oeste.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "La torre de {npc:11863} Aldamort está en la colina al este del naufragio.",
}
