-- Spanish (Spain) (esES): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} es tu base en esta guía. Todos los que necesitas están a pocos pasos de la posada.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, el maestro de jinetes del viento",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: las arpías vienen más tarde, en {area:383}",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Zancudos y raptores",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Los zancudos y los raptores solescama recorren las llanuras alrededor de {area:380}, sobre todo al norte.",

	-- Step 4: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "Los Galopadores astacebra pastan al norte y al este del pueblo.",
	["Zhevra"] = "Astacebras",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Campamento Crines de Acero",
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Los Merodeadores de la savana cazan en las llanuras entre el pueblo y el campamento Crines de Acero, al este. En el campamento, los buscadores de agua y los tejespinas ocupan la mitad oeste y los cazadores el centro; las cajas de suministros están en el extremo este.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} está en la loma al norte del campamento Crines de Acero.",

	-- Step 8: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Sigue el camino al este hasta el puesto sobre {area:814}.",

	-- Step 9: Thunder lizards across the river
	["Thunder lizards across the river"] = "Truenagartos al otro lado del río",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Los Truenagartos y los Lomorrayos pastan justo al otro lado del puente, bajo {area:379}.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} espera en la orilla al sur de {area:379}, al otro lado del puente.",

	-- Step 12: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Fanáticos de {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Los Fanáticos Filo Ardiente ocupan {area:1898}, en el norte de {zone:1411}; sueltan {item:6652}. {item:5026} lo sueltan los Crines de Acero en tu próxima visita a su campamento.",

	-- Step 13: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} acampa junto al camino de {area:380} a {area:392}. {object:58369} está en el sur del campamento Crines de Acero, justo al norte de él.",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Sigue el camino al sureste hasta {area:392}, en la costa.",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: la consola está en {area:382}, más tarde",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, en el muelle",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Playa del Mar del Sur",
	-- {area:392} Ratchet
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Los piratas acampan en la playa al sur de {area:392}. Los montones de piezas complicadas están en la arena entre ellos.",

	-- Step 17: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Vuelve por la playa, pasando el campamento pirata: la caja de botas y la caja frágil con la lente están en su extremo sur.",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads
	["Walk back west along the road to the {area:380}."] = "Vuelve al oeste por el camino hasta {area:380}.",

	-- Step 20: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Vuelve al campamento Crines de Acero. Los geomantes y los defensores ocupan su mitad este; {npc:3438} camina entre ellos.",

	-- Step 21: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} hace {item:6636} con el alquitrán y la bolsa. Úsalo junto al brasero a su lado para revelar a {npc:5893}, mátalo para conseguir {item:6655} y luego pon la ascua en el brasero.",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, tu {item:5176} y {item:263412}",

	-- Step 23: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, un león blanco, merodea por las llanuras al norte del campamento Crines de Acero.",

	-- Step 24: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141} está en el puesto de investigación de Ventura y Cía., al oeste de {area:382}. Cierra las tres válvulas alrededor de la perforadora, vuelve a usar la consola y luego quítale {item:5089} a {npc:3471}, que está al lado.",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} en {area:392}: más tarde, de camino",

	-- Step 25: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "Ve al oeste, a {area:383}. Las arpías Alabruja anidan por todas partes; cualquiera puede soltar una garra. {quest:819} está en sus colinas.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "Ve al sur, al puesto de vigilancia de {npc:3389} en la frontera Kolkar.",

	-- Step 27: The Forgotten Pools
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Las pozas están justo al norte de {npc:3389}. Entra en el agua para explorarlas; los Champiñones cargados para Helbrim crecen a su alrededor. Mata a todo Kolkar que encuentres para conseguir brazales.",

	-- Step 28: Kolkar camps
	["Kolkar camps"] = "Campamentos Kolkar",
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Kolkar Wranglers = {npc:3272} Kolkar Wrangler
	["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Los Vaqueros Kolkar y los clamatormentas ocupan los campamentos al sur de {npc:3389}.",

	-- Step 31: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Al sureste de {area:380}. Prueba las semillas en la fisura burbujeante de la orilla este del oasis.",

	-- Step 32: Raptor nests
	["Raptor nests"] = "Nidos de raptores",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Los tres nidos están juntos en {area:1697}, al suroeste del oasis; los Segadores solescama los vigilan.",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "Ve al este, a {area:392}, en la costa.",

	-- Step 34: The Crossroads
	["Back west along the road."] = "Vuelve al oeste por el camino.",

	-- Step 35: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Los Quijafortes del oasis se arrastran por {area:387}, al suroeste de {area:380}, y por {area:388}.",

	-- Step 36: The Crossroads
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} en {zone:1421}, en la próxima guía",

	-- Step 37: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Los Destripadores Alabruja ocupan el oeste de {area:383}; llevan los anillos.",

	-- Step 38: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "Ve al este, a {area:1703}; {npc:9316} está en el campamento justo al sur.",

	-- Step 39: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Los cubos de herramientas con las babosas están alrededor de la perforadora de Ventura y Cía. en {area:382}, al este de {npc:9316}.",

	-- Step 40: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar
	["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Guárdalo: {quest:3923} está fuera de {zone:1454}; una guía posterior lo entrega",

	-- Step 41: The Crossroads
	-- {area:380} The Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Vuelve al sur hasta {area:380}. La próxima guía empieza aquí y te lleva a {zone:1454} y al zepelín a {zone:1420}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Los Quijafortes del oasis se arrastran por {area:387}, al suroeste de {area:380}, y por {area:388}.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Los zancudos y los raptores solescama recorren las llanuras alrededor de {area:380}, sobre todo al norte.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Al sureste de {area:380}. Prueba las semillas en la fisura burbujeante de la orilla este del oasis.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Thun'grim acampa junto al camino de {area:380} a {area:392}. {object:58369} está en el sur del campamento Crines de Acero, justo al norte de él.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Vuelve al sur hasta {area:380}. La próxima guía empieza aquí y te lleva a {zone:1454} y al zepelín a {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Vuelve al oeste por el camino hasta {area:380}.",
}
