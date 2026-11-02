-- Spanish (Spain) (esES): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {area:3} Badlands
	["Into {area:3}"] = "",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {area:3} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {area:3}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Los enanos Forjatiniebla acampan justo al norte de la excavación; el Mapa arrugado está entre sus tiendas. Los Tuneladores y los Tejeoscuros llevan el Pico de la suerte de Ryedol. Los Coyotes del risco recorren las laderas de alrededor.",

	-- Step 5: The excavation crate
	["The excavation crate"] = "El cajón de la excavación",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "El siguiente encargo del Prospector Ryedol es en {area:1517}: omítelo.",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:3} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Las almejas están en la costa noroeste de la Vega de Tuercespina, en la siguiente guía: guárdala",

	-- Step 8: Indurium Flake on the way
	-- {item:5797} Indurium Flake
	["{item:5797} on the way"] = "",

	-- Step 9: Agmond's End
	-- {quest:739} Murdaloc
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "",

	-- Step 10: Stonevault Bonesnapper on the way
	-- {npc:2893} Stonevault Bonesnapper
	["{npc:2893} on the way"] = "",

	-- Step 11: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "",

	-- Step 12: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "",
	-- {quest:739} Murdaloc · {area:3} Badlands
	["The skeleton's next task, {quest:739}, waits until the later {area:3} guide at 43."] = "",

	-- Step 14: Camp Kosh
	-- {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["Careful: Dustbelcher Lords are level 44-45. They use Battle Shout and Demoralizing Shout, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "",

	-- Step 15: Lucien Tosselwrench
	-- {npc:2921} Lotwil Veriatus
	["{npc:2921}'s next test needs crafted gear: skip it."] = "La siguiente prueba de {npc:2921} Veriatus requiere equipo fabricado: omítela.",

	-- Step 16: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {area:3} Badlands · {npc:2745} Ambassador Infernus
	["Head north-east to the dwarven ruins in the north of the {area:3}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "",

	-- Step 17: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "para {npc:2786} en {zone:1455}: guárdala",

	-- Step 18: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementales de piedra",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Los elementales de piedra ({npc:92}) recorren el sureste de {npc:2921}; las águilas ratoneras gigantes ({npc:2831}) y los coyotes del risco mayores ({npc:2729}) comparten la llanura al oeste.",

	-- Step 20: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, junto a {npc:2921} Veriatus",
	-- {item:2868} Patterned Bronze Bracers
	["only if you carry {item:2868} (a blacksmith's craft)"] = "solo si llevas {item:2868} (los fabrica un herrero)",

	-- Step 21: Hearth to Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["Hearth to {area:2101}"] = "",

	-- Step 22: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 23: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "",

	-- Step 24: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 26: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul · {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel.\n{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "",
	["for the Dustwallow loop in the next guide"] = "para la vuelta por Marjal Revolcafango de la siguiente guía",
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "",

	-- Step 27: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "",

	-- Step 28: Theramore
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "",

	-- Step 29: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "",
	["Upstairs"] = "",

	-- Step 31: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Sigue el camino hacia el sur hasta {area:2407}.",

	-- Step 32: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} está al borde de {area:596}, al suroeste de {area:2407}; {object:176751} están entre los esqueletos. Un {npc:217590} se arrastra por el cementerio: atrapa uno con el Entomology Starter Kit y márcalo.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: atrápalo, para My Little Friends",

	-- Step 33: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Los centauros Maraudine ocupan {area:607}, al oeste del cementerio; todos sueltan los tótems.",

	-- Step 34: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolta a {npc:12277} de vuelta hacia el cementerio",

	-- Step 35: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "",

	-- Step 36: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Los Devastadores no-muertos recorren los campos de huesos al sur del Poblado Magram, al este del aquelarre; en el extremo sureste, usa el {item:15848} para atraer a los Espectros Magrami.",

	-- Step 39: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Sigue el camino hacia el oeste por el norte de {zone:1443} hasta las ruinas de {area:2405}. La torre de {npc:11863} está en la colina de allí, de camino al naufragio.",

	-- Step 40: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "El cofre del barco naufragado está en la orilla, justo al oeste de la torre de {npc:11863}.",

	-- Step 41: Claim Rackmore's Treasure!
	["Underwater"] = "",

	-- Step 42: Ranazjar Isle: kill these as you meet them
	-- {area:2406} Ranazjar Isle
	["{area:2406}: kill these as you meet them"] = "",
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, un jefe centauro, acampa en la costa noroeste, al norte de la torre de {npc:11863} Aldamort.",

	-- Step 45: Fly to Theramore
	["Fly to Theramore"] = "Vuela a Theramore",
	-- {area:608} Nijel's Point
	["{area:608} flight master"] = "",

	-- Step 47: Fly to Nijel's Point
	-- {area:608} Nijel's Point
	["Fly to {area:608}"] = "",

	-- Step 48: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Sigue el camino hacia el norte hasta {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} en {zone:1455}: guárdala",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} en {area:271}: guárdala",

	-- Step 51: Hearth to Nijel's Point
	-- {area:608} Nijel's Point
	["Hearth to {area:608}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Sigue el camino hacia el oeste por el norte de {zone:1443} hasta las ruinas de {area:2405}; el cofre del barco naufragado está en la orilla, justo al oeste.",
	-- ["Greater Rock Elementals"] = "Elementales de piedra mayores",
	-- ["Lesser Rock Elementals"] = "Elementales de piedra inferiores",
	-- ["Ogres and buzzards"] = "Ogros y águilas ratoneras",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Vuelve al oeste hasta el camino y síguelo hacia el sur, fuera de {zone:1432}, por el paso hasta {zone:1418}. {npc:2910} y {npc:2860} acampan juntos en la excavación.",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Cabalga al noreste hasta la excavación abandonada; el Cajón de provisiones de excavación está allí, entre los ogros Rotapolvo.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Cabalga al noreste hasta las ruinas enanas del norte de {zone:1418}; el cofre está entre los enanos Forjatiniebla. {npc:2745}, cerca, es élite: mantén la distancia.",
	-- ["Ride south to {area:345}."] = "Cabalga al sur hasta {area:345}.",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Cabalga al oeste hasta {area:1878}; {npc:2921} Veriatus trabaja junto a sus máquinas en el centro.",
	-- ["Shadowforge camp"] = "Campamento Forjatiniebla",
	-- ["Take the boat to Theramore from the far pier."] = "Toma el barco a Theramore en el muelle del fondo.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Los ogros Rotapolvo acampan justo al sur del valle; cualquiera suelta chatarra. Las águilas ratoneras sobrevuelan la llanura al este.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Los Elementales de piedra mayores (nivel 42) recorren el extremo suroeste, por debajo de {area:342}; atráelos de uno en uno. Los Cazavermis Rotapolvo y los Destructores de {area:342} también sueltan chatarra.",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Los Elementales de piedra inferiores deambulan por {area:1878}, al oeste de {npc:2921} Veriatus.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "El esqueleto maltrecho está justo al este de los ogros, al borde del campamento de los troggs Grutacanto; los Partehuesos y los Chamanes de alrededor sueltan las escamas. Theldurin el Perdido está sentado junto al campamento en ruinas, más al sur.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Los demonios se reúnen en {area:602}, al sur de {zone:1443}: canes manáfagos (Devoradores de maná, Cazadores de magos y Cazadores Ley), Doncellas infernales y Hermanas infernales, y Capitanes Guardiavil alrededor del foso.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "El maestro de vuelo está junto a la puerta de {area:514}; {npc:5083} y {npc:4964} están dentro de la ciudadela.",
	-- ["The next guide starts in Theramore."] = "La siguiente guía empieza en Theramore.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "La siguiente tarea del esqueleto, Murdaloc, espera a la guía posterior de {zone:1418}, a nivel 43.",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "para {npc:4454} en {area:439}: la guía de {zone:1446} pasa por allí a nivel 45, guárdala",
	-- ["{item:7337} Elementals roam south-east of Lotwil; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Los elementales de {item:7337} recorren el sureste de Lotwil Veriatus; las Águilas ratoneras gigantes y los Coyotes del risco mayores comparten la llanura al oeste.",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "La caravana de {npc:11626} se detiene en el camino al este de {area:606}. Acepta la misión y acompaña a los kodos pasando {area:602}, matando a los demonios que los asaltan; después habla con {npc:11596} en su campamento al este de {area:596}.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "La torre de {npc:11863} Aldamort está en la colina al este del naufragio.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} está presa en el campamento centauro al oeste del cementerio. Libérala y mantenla con vida al salir; se detiene junto al cementerio.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, en la posada",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} y {npc:2817} acampan juntos en {area:1877}, en el centro de {zone:1418}.",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "La siguiente tarea de {npc:5638} Ungor, {item:6245}, se consigue en la costa lejana: omítela.",
}
