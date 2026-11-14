-- Spanish (Spain) (esES): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Vuelve al oeste hasta el camino y síguelo hacia el sur, fuera de {zone:1432}, por el paso hasta {zone:1418}. {npc:2910} y {npc:2860} acampan juntos en la excavación.",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Los enanos Forjatiniebla acampan justo al norte de la excavación; el Mapa arrugado está entre sus tiendas. Los Tuneladores y los Tejeoscuros llevan el Pico de la suerte de Ryedol. Los Coyotes del risco recorren las laderas de alrededor.",

	-- Step 5: The excavation crate
	["The excavation crate"] = "El cajón de la excavación",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Ve al noreste hasta la excavación abandonada; el Cajón de provisiones de excavación está allí, entre los ogros Rotapolvo.",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "El siguiente encargo del Prospector Ryedol es en {area:1517}: omítelo.",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} y {npc:2817} acampan juntos en {area:1877}, en el centro de {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Las almejas están en la costa noroeste de la Vega de Tuercespina, en la siguiente guía: guárdala",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "El esqueleto maltrecho está justo al este de los ogros, al borde del campamento de los troggs Grutacanto; los Partehuesos y los Chamanes de alrededor sueltan las escamas. Theldurin el Perdido está sentado junto al campamento en ruinas, más al sur.",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "",

	-- Step 10: Theldurin the Lost
	-- {area:1517} Uldaman
	["Theldurin sits by the ruined camp south of the trogg camp. His tablet lies just inside {area:1517}'s cave mouth, beside level 38 elites: a quest for a group."] = "Theldurin está sentado junto al campamento en ruinas al sur del campamento trogg. Su tablilla está justo dentro de la boca de la cueva de {area:1517}, junto a élites de nivel 38: una misión para grupo.",

	-- Step 11: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Ve al oeste hasta {area:1878}; {npc:2921} Veriatus trabaja junto a sus máquinas en el centro.",

	-- Step 12: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementales de piedra inferiores",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "Los Elementales de piedra inferiores deambulan por {area:1878}, al oeste de {npc:2921}; cualquier elemental de piedra puede soltar los Fragmentos de elemental de piedra de {npc:1470}.",

	-- Step 14: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {area:1517} Uldaman · {zone:1418} Badlands · {npc:2932} Magregan Deepshadow
	-- plural, as words: Obsidian Golems = {npc:4872} Obsidian Golem · Shadowforge Diggers = {npc:4846} Shadowforge Digger
	["Head north to {area:1517}'s entrance, in the north of the {zone:1418}: the chest lies just inside the cave mouth. {npc:2932} and the Obsidian Golems (38) stand beside it and Shadowforge Diggers (35-36) work the tunnel, all elite: keep your group together."] = "Ve al norte hasta la entrada de {area:1517}, en el norte de {zone:1418}: el cofre está justo dentro de la boca de la cueva. {npc:2932} y los Gólems de obsidiana (38) están a su lado y los Excavadores Forjatiniebla (35-36) trabajan en el túnel, todos élite: mantén unido a tu grupo.",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "",

	-- Step 15: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:1517} Uldaman · {area:345} Agmond's End
	["{npc:4618} and {npc:2817} camp in the {area:1877}, on the road between {area:1517} and {area:345}."] = "{npc:4618} y {npc:2817} acampan en {area:1877}, en el camino entre {area:1517} y {area:345}.",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "Para {npc:4454} en {area:2240}: la guía de {zone:1446} pasa por allí a nivel 45, guárdala",

	-- Step 16: Sigrun Ironhew
	-- {area:1877} Valley of Fangs · {area:346} Hammertoe's Digsite · {npc:2860} Sigrun Ironhew
	["East from the {area:1877} to {area:346}: {npc:2860} takes the scrap metal."] = "Al este desde {area:1877} hasta {area:346}: {npc:2860} recoge la chatarra.",

	-- Step 17: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "Ve al sur hasta {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "para {npc:2786} en {zone:1455}: guárdala",

	-- Step 18: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementales de piedra",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Los elementales de piedra ({npc:92}) recorren el sureste de {npc:2921}; las águilas ratoneras gigantes ({npc:2831}) y los coyotes del risco mayores ({npc:2729}) comparten la llanura al oeste.",

	-- Step 19: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "",

	-- Step 20: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "",

	-- Step 22: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, junto a {npc:2921} Veriatus",

	-- Step 23: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "A {area:2101}",

	-- Step 24: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "Un {npc:217590} se arrastra por {area:596}: atrapa uno con la herramienta del kit de entomología de {npc:217412}.",
	-- ["Fly to Theramore"] = "Vuela a Theramore",
	-- ["Follow the road north to {area:608}."] = "Sigue el camino hacia el norte hasta {area:608}.",
	-- ["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Sigue el camino hacia el norte hasta {area:608}: {npc:5396} está en el extremo sur, {npc:5638} en el centro y {npc:1182} al norte.",
	-- ["Follow the road south to {area:2407}."] = "Sigue el camino hacia el sur hasta {area:2407}.",
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Sigue el camino hacia el oeste por el norte de {zone:1443} hasta las ruinas de {area:2405}. La torre de {npc:11863} está en la colina de allí, de camino al naufragio.",
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Sigue el camino hacia el oeste por el norte de {zone:1443} hasta las ruinas de {area:2405}; el cofre del barco naufragado está en la orilla, justo al oeste.",
	-- ["Greater Rock Elementals"] = "Elementales de piedra mayores",
	-- ["Lesser Rock Elementals"] = "Elementales de piedra inferiores",
	-- ["Maraudine centaurs"] = "Centauros Maraudine",
	-- ["Ogres and buzzards"] = "Ogros y águilas ratoneras",
	-- ["Rackmore's chest lies just south-east of the {object:177673}."] = "El cofre de Rackmore está justo al sureste de {object:177673}.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Cabalga al noreste hasta las ruinas enanas del norte de {zone:1418}; el cofre está entre los enanos Forjatiniebla. {npc:2745}, cerca, es élite: mantén la distancia.",
	-- ["Shadowforge camp"] = "Campamento Forjatiniebla",
	-- ["Take the boat to Theramore from the far pier."] = "Toma el barco a Theramore en el muelle del fondo.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Los ogros Rotapolvo acampan justo al sur del valle; cualquiera suelta chatarra. Las águilas ratoneras sobrevuelan la llanura al este.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Los Elementales de piedra mayores (nivel 42) recorren el extremo suroeste, por debajo de {area:342}; atráelos de uno en uno. Los Cazavermis Rotapolvo y los Destructores de {area:342} también sueltan chatarra.",
	-- ["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Los centauros Maraudine ocupan {area:607}, al oeste del cementerio; todos sueltan los tótems.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Las nagas Filozante ocupan la costa noroeste, al norte de la torre de {npc:11863}; la cartera de Karnitol está en el fondo del mar frente a ella, y cualquier naga puede soltar la llave dorada de Rackmore. Nada hasta {area:2406}, frente al extremo norte, y usa {item:15766} en {object:177673}: surge {npc:12369} (38); mátalo para {quest:6027}.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Las nagas Filozante ocupan la costa noroeste, al norte de la torre de {npc:11863}; la cartera de Karnitol está en el fondo del mar frente a ella. Nada hasta {area:2406}, frente al extremo norte, y usa {item:15766} en {object:177673}: surge {npc:12369} (38); mátalo para {quest:6027}.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "El esqueleto maltrecho está justo al este de los ogros, al borde del campamento de los troggs Grutacanto; los Partehuesos y los Chamanes de alrededor sueltan las escamas. Theldurin el Perdido está sentado junto al campamento en ruinas, más al sur.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Los demonios se reúnen en {area:602}, al sur de {zone:1443}: canes manáfagos (Devoradores de maná, Cazadores de magos y Cazadores Ley), Doncellas infernales y Hermanas infernales, y Capitanes Guardiavil alrededor del foso.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "El maestro de vuelo está junto a la puerta de {area:514}; {npc:5083} y {npc:4964} están dentro de la ciudadela.",
	-- ["The next guide starts in Theramore."] = "La siguiente guía empieza en Theramore.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "La siguiente tarea del esqueleto, Murdaloc, espera a la guía posterior de {zone:1418}, a nivel 43.",
	-- ["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "El cofre del barco naufragado está justo al suroeste de la torre de {npc:11863}.",
	-- ["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "El cofre del barco naufragado está en la orilla, justo al oeste de la torre de {npc:11863}.",
	-- ["The {area:2657}"] = "{area:2657}",
	-- ["Theramore"] = "Theramore",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Los Devastadores no-muertos recorren los campos de huesos al sur del Poblado Magram, al este del aquelarre; en el extremo sureste, usa el {item:15848} para atraer a los Espectros Magrami.",
	-- ["escort {npc:12277} back toward the graveyard"] = "escolta a {npc:12277} de vuelta hacia el cementerio",
	-- ["for the Dustwallow loop in the next guide"] = "para la vuelta por Marjal Revolcafango de la siguiente guía",
	-- ["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} en {area:271}: guárdala",
	-- ["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} en {zone:1455}: guárdala",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "solo si llevas {item:2868} (los fabrica un herrero)",
	-- ["{area:144} flight master"] = "Maestro de vuelo de {area:144}",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766}, en {object:177673}",
	-- ["{item:15881}, from the Slitherblade naga"] = "{item:15881}, de las nagas Filozante",
	-- ["{item:7337} Elementals roam south-east of Lotwil; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Los elementales de {item:7337} recorren el sureste de Lotwil Veriatus; las Águilas ratoneras gigantes y los Coyotes del risco mayores comparten la llanura al oeste.",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "La caravana de {npc:11626} se detiene en el camino al este de {area:606}. Acepta la misión y acompaña a los kodos pasando {area:602}, matando a los demonios que los asaltan; después habla con {npc:11596} en su campamento al este de {area:596}.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "La torre de {npc:11863} Aldamort está en la colina al este del naufragio.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} está presa en el campamento centauro al oeste del cementerio. Libérala y mantenla con vida al salir; se detiene junto al cementerio.",
	-- ["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, un jefe centauro, acampa en la costa noroeste, al norte de la torre de {npc:11863} Aldamort.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, en la posada",
	-- ["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: atrápalo, para My Little Friends",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "La siguiente prueba de {npc:2921} Veriatus requiere equipo fabricado: omítela.",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "La siguiente tarea de {npc:5638} Ungor, {item:6245}, se consigue en la costa lejana: omítela.",
	-- ["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, si 30-40/02 no la aceptó: el naufragio está bajo la torre de {npc:11863}",
	-- ["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} está al borde de {area:596}, al suroeste de {area:2407}; {object:176751} están entre los esqueletos.",
	-- ["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} está al borde de {area:596}, al suroeste de {area:2407}; {object:176751} están entre los esqueletos. Un {npc:217590} se arrastra por el cementerio: atrapa uno con el Entomology Starter Kit y márcalo.",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} está junto a {object:35251}. Su llave de plata la sueltan los cangrejos Partidoseco alrededor del naufragio; la dorada la sueltan las nagas Filozante de la costa noroeste, a continuación.",
}
