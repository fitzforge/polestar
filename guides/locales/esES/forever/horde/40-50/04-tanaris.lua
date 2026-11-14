-- Spanish (Spain) (esES): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:976} Gadgetzan · {zone:1427} Searing Gorge · {npc:5955} Tooga · {area:1446} Thorium Point
	["{area:976} and the {zone:1427} at 46-48: the Wastewander camps, {npc:5955}'s escort and {area:1446}."] = "{area:976} y {zone:1427} a nivel 46-48: los campamentos Wastewander, la escolta de {npc:5955} y {area:1446}.",

	-- Step 2: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maestro de vuelo de {area:1099}",

	-- Step 3: Gadgetzan
	-- {npc:7876} Tran'rek · {area:979} Sandsorrow Watch
	["The flight lands beside {npc:7876}. Take the town's quests before riding west to {area:979}."] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, junto al maestro de jinetes del viento",

	-- Step 4: Gadgetzan
	-- {area:978} Zul'Farrak · {area:979} Sandsorrow Watch · {npc:7407} Chief Engineer Bilgewhizzle · {quest:2768} Divino-matic Rod · {quest:2864} Tran'rek
	["For your {area:978} run, after {area:979}: {npc:7407}, by the water tower, wants his {quest:2768} back; {quest:2864} his scarab shells and Trenton Lighthammer Troll Temper, if you have not taken those yet."] = "Para tu incursión en {area:978}, después de {area:979}: {npc:7407}, junto a la torre de agua, quiere que le devuelvas su {quest:2768}; {quest:2864}, sus caparazones de escarabajo, y Trenton Lighthammer, Temple de trol, si aún no las has aceptado.",

	-- Step 6: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "Al oeste de Gadgetzan, usa la {item:8584} junto a la charca del campamento trol.",

	-- Step 7: Zul'Farrak
	-- {area:978} Zul'Farrak · {quest:3042} Troll Temper · {npc:7604} Sergeant Bly · {quest:2768} Divino-matic Rod
	["{area:978} is a dungeon for a group of five; its quests here are level 45 to 47. Its gate lies about 400 yards north of the troll camp's water hole.\nInside: the Scarabs drop the shells, every Sandfury troll can drop {quest:3042}, and {npc:7604} carries the {quest:2768}."] = "{area:978} es una mazmorra para un grupo de cinco; sus misiones de aquí son de nivel 45 a 47. Su puerta está a unos 400 metros al norte de la charca del campamento trol.\nDentro: los Escarabajos sueltan los caparazones, cualquier trol Furiarena puede soltar {quest:3042} y {npc:7604} lleva {quest:2768}.",
	-- {quest:2865} Scarab Shells
	["{quest:2865}: the Scarabs, inside"] = "{quest:2865}: los Escarabajos, dentro",
	-- {quest:3042} Troll Temper
	["{quest:3042}: the Sandfury trolls, inside"] = "{quest:3042}: los trols Furiarena, dentro",
	-- {quest:2768} Divino-matic Rod · {npc:7604} Sergeant Bly
	["{quest:2768}: {npc:7604}, inside"] = "{quest:2768}: {npc:7604}, dentro",

	-- Step 8: Senior Surveyor Fizzledowser
	-- {area:976} Gadgetzan · {npc:7771} Marvon Rivetseeker
	["Back east to Fizzledowser on the west side of {area:976}; {npc:7771} is south from there."] = "",

	-- Step 9: Tran'rek
	-- {area:978} Zul'Farrak · {npc:7876} Tran'rek
	["Your {area:978} scarab shells: {npc:7876}, beside the wind rider master."] = "Tus caparazones de escarabajo de {area:978}: {npc:7876}, junto al maestro de jinetes del viento.",

	-- Step 10: Chief Engineer Bilgewhizzle
	-- {quest:2768} Divino-matic Rod · {npc:7407} Chief Engineer Bilgewhizzle
	["The {quest:2768}: {npc:7407}, by the water tower."] = "{quest:2768}: {npc:7407}, junto a la torre de agua.",

	-- Step 11: Trenton Lighthammer
	-- {quest:3042} Troll Temper · {npc:7804} Trenton Lighthammer
	["The {quest:3042}: {npc:7804}, a short walk from the flight master."] = "{quest:3042}: {npc:7804}, a poca distancia del maestro de vuelo.",

	-- Step 12: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "Ve al oeste por el camino del sur; {npc:7771} acampa junto a las ruinas de {area:1938}. Ponte su {item:9978}: muestra los adornos enterrados, aquí y alrededor de {area:983}.",

	-- Step 13: Broken Pillar: kill these as you meet them
	-- {area:1938} Broken Pillar
	["{area:1938}: kill these as you meet them"] = "",
	-- {area:982} Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "Al sur de {area:982}, los ogros Machacaduna ocupan su base, con {npc:12046} en el extremo este. Desentierra adornos de {quest:3161} entre combate y combate.",
	["Below ground"] = "Bajo tierra",

	-- Step 14: Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["West, the Centipaar insects swarm around their hives; any of them drops the parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "",

	-- Step 15: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "Al oeste de la base, las criaturas cactus llenan el valle; solo los Colectores de rocío Cardizal llevan una glándula de rocío. Casi todos los enemigos de {zone:1446} pueden soltar, rara vez, el Localizador de emergencia OOX-17/TN: guárdalo si te sale uno.\nCuidado: los demás cardizales de la zona son de nivel 49-50 y deambulan mucho, así que es fácil atraer enemigos de más.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, botín poco común",

	-- Step 16: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Escolta de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} espera en el valle. Acompáñalo hasta su esposa, {npc:6015}, en {area:977}, al noreste cruzando el desierto: no te alejes, ve despacio para que te siga y defiéndelo de lo que le ataque. No montes ni uses la piedra de hogar lejos de él. {npc:8579} también está en el puerto.",

	-- Step 18: Slake That Thirst
	-- {spell:686} Shadow Bolt
	["Careful: Shadow Mages (level 42-43) call a Voidwalker while out of combat and attack with Immolate and {spell:686}. Thieves can Disarm you, Rogues move around in Sneak, and Assassins use Execute once you are at 20% health or less."] = "",

	-- Step 19: Gadgetzan
	-- {quest:654} Tanaris Field Sampling
	["Keep the Model 4711-FTZ Power Source Bilgewhizzle gave you: it starts {quest:654}, a two-hour timer, so use it on the way back north from Scrimshank's hive."] = "Guarda la Fuente de energía modelo 4711-FTZ que te dio Bilgewhizzle: inicia {quest:654}, con un temporizador de dos horas, así que úsala al volver al norte desde la colmena de Patagolpe.",

	-- Step 20: Gadgetzan
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "el {item:8526} crece en {zone:1425}, hacia el nivel 48",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 22: Scrimshank's gear
	["Scrimshank's gear"] = "Equipo de análisis de Patagolpe",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "",

	-- Step 23: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}.\nCareful: The escort has two ambushes. Three level 47 scorpids attack near the start. Near the end, by the beach, three Wastewander humans attack: one mage and two assassins, around level 44."] = "Solo con el localizador de emergencia: OOX-17/TN está al sureste de la colmena de Patagolpe. Escóltalo al norte hasta {area:977}; su recompensa te espera con Oglethorpe Obnoticus en {area:35}.\nCuidado: la escolta tiene dos emboscadas. Tres escórpidos de nivel 47 atacan cerca del inicio. Cerca del final, junto a la playa, atacan tres humanos Vagayermo: un mago y dos asesinos, de nivel 44 más o menos.",

	-- Step 24: Tanaris Field Sampling
	-- {area:976} Gadgetzan · {item:8524} Model 4711-FTZ Power Source
	-- plural, as words: Blisterpaw Hyenas = {npc:5426} Blisterpaw Hyena · Glasshide Basilisks = {npc:5419} Glasshide Basilisk · Scorpid Hunters = {npc:5422} Scorpid Hunter
	["Back north, just south of {area:976}, use the {item:8524} now: the two-hour timer starts. The Blisterpaw Hyenas, Glasshide Basilisks and Scorpid Hunters share the dunes here. Each can drop an untested sample: use it, and it either passes as an acceptable one or is lost. Keep killing until you have eight of each."] = "De vuelta al norte, justo al sur de {area:976}, usa ahora la {item:8524}: empieza el temporizador de dos horas. Las Hienas Zarpampolla, los Basiliscos Pielvidrio y los Cazadores escórpidos comparten aquí las dunas. Cada uno puede soltar una muestra sin analizar: úsala y, o bien resulta aceptable, o bien se pierde. Sigue matando hasta tener ocho de cada.",
	-- {item:8524} Model 4711-FTZ Power Source
	["Use the {item:8524}"] = "Usa la {item:8524}",

	-- Step 25: Gadgetzan
	-- {npc:5204} Apothecary Zinge · {zone:1458} Undercity
	["for {npc:5204} in the {zone:1458}, around level 52"] = "",
	-- {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["for {npc:7010} in {zone:1454}, around level 50"] = "para {npc:7010} en {zone:1454}, hacia el nivel 50",

	-- Step 26: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",

	-- Step 27: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "",

	-- Step 28: Searing Gorge
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",

	-- Step 29: The Grimesilt Dig Site
	-- {area:16727} Powderfuse Port · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:16727}, ride into the {zone:1427} by its eastern pass, then west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Desde {area:16727}, entra en {zone:1427} por su paso del este y luego cabalga al oeste hasta la excavación. El {object:173265} está en su extremo sur; los Geólogos Hierro Negro excavan justo al norte. Lleva 15 {item:4306} (se vende en la casa de subastas).",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "el {object:173265}",

	-- Step 31: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Cabalga al noroeste cruzando la garganta; {area:1446} es el campamento con andamios del noroeste.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "El tablón {object:179827}",

	-- Step 32: The Cauldron's slavers and golems
	-- {area:246} The Cauldron
	["{area:246}'s slavers and golems"] = "",
	-- {area:1446} Thorium Point
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Heavy War Golems = {npc:5854} Heavy War Golem
	["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below Velarok."] = "",

	-- Step 33: Velarok Windblade
	["Velarok Windblade"] = "Velarok Windblade",
	-- {area:1446} Thorium Point
	["Velarok stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Velarok está solo al sur de {area:1446}, al borde de La Caldera. Escucha su historia.",

	-- Step 36: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "",
	-- {item:11818} Grimesilt Outhouse Key · {area:1443} The Slag Pit
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Searing Lava Spiders = {npc:5857} Searing Lava Spider · Incendosaurs = {npc:9318} Incendosaur · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Heavy War Golems patrol the Cauldron below Velarok and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Searing Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, botín poco común",
	-- {area:1443} The Slag Pit
	["Below ground: the plans, on the {area:1443}'s upper ledge"] = "Bajo tierra: los planos, en la cornisa superior de {area:1443}",

	-- Step 38: Thorium Point
	-- {area:1446} Thorium Point
	["Ride back north to {area:1446}, just past Velarok."] = "",

	-- Step 39: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "Los hornos de los Vapoherreros",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Los Vapoherreros Hierro Negro trabajan en los hornos del centro de La Caldera; la mitad lleva una {item:10551} y uno de cada diez la {item:18959}. Los esclavos, Esclavistas y Capataces también llevan dagas.",

	-- Step 40: Velarok Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "Su siguiente encargo pide el {item:10552} de fieles élite: déjalo.",

	-- Step 41: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Vigías Hierro Negro",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Los Vigías Hierro Negro vigilan las crestas alrededor de las torres de guardia al sur de La Caldera; uno de cada diez, más o menos, lleva el {item:18960}.",

	-- Step 42: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Solo con la {item:11818}: vuelve al este hasta el {object:173265} de la excavación.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Barco a {area:35}",
	-- ["Dark Iron Lookouts"] = "Vigías Hierro Negro",
	-- ["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Vuela a {area:1637} y entrena: la siguiente parada de entrenamiento de la guía es {zone:1458}, que no tiene instructor de cazadores ni de chamanes. Luego vuela a {area:392}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Vuela a {area:1638} y entrena con {npc:3033} en {area:1639}; luego vuela a {area:392}.",
	-- ["Fly to {area:340}"] = "Vuela a {area:340}",
	-- ["Fly to {area:392}"] = "Vuela a {area:392}",
	-- ["From the {area:35} flight master, above the harbour."] = "Desde el maestro de vuelo de {area:35}, sobre el puerto.",
	-- ["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Más al sur, el equipo de análisis de Patagolpe está en la entrada de una colmena Centipaar.",
	-- ["Greater Lava Spiders"] = "Arañas de lava abrasadoras",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Los Gólems de guerra pesados patrullan La Caldera bajo Kalaran y sueltan el aceite; los Elementales de magma y los Elementales de fuego que vagan entre ellos sueltan los corazones. Los Capataces Hierro Negro y los Esclavistas Hierro Negro arrean a los esclavos por los caminos; un Esclavista puede soltar la {item:11818}: guárdala.",
	-- ["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Vuelve al norte hasta {area:1446}. Quédate aquí: la siguiente guía empieza con el vuelo a {area:75}.",
	-- ["Ride south-west to {area:976}."] = "Cabalga al suroeste hasta {area:976}.",
	-- ["South down the road again."] = "Vuelve al sur por el camino.",
	-- ["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "Al sureste de Gadgetzan acampan los Bandidos Deambuladores en las dunas; {npc:7847} está en el campamento del este.",
	-- ["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Los Vigías Hierro Negro vigilan las crestas alrededor de las torres de guardia al sur de La Caldera; uno de cada diez, más o menos, lleva el {item:18960}.",
	-- ["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Los Vapoherreros Hierro Negro trabajan en los hornos del centro de La Caldera; la mitad lleva una {item:10551} y uno de cada diez la {item:18959}. Los esclavos, Esclavistas y Capataces también llevan dagas.",
	-- ["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Las Arañas de lava abrasadoras recorren las mesetas y pozas de lava del suroeste de la garganta.",
	-- ["The Steamsmiths' furnaces"] = "Los hornos de los Vapoherreros",
	-- ["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "El barco a {area:35} atraca en el muelle de {area:392}, bajo la colina del maestro de vuelo.",
	-- ["The {object:142071} machine, in the middle of town: the egg is in southern {zone:1444}, around level 50"] = "La máquina {object:142071}, en el centro del pueblo: el huevo está en el sur de {zone:1444}, hacia el nivel 50",
	-- ["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "Al oeste, los insectos Centipaar pululan alrededor de sus colmenas; cualquiera de ellos suelta los trozos.",
	-- ["the {object:150075} in the square"] = "el {object:150075} de la plaza",
	-- ["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} se abre al norte de La Caldera. Los Incendosaurios nadan en sus pozas de lava: atráelos hasta el borde. Los planos secretos están en la cornisa superior de la fosa.",
	-- ["{area:392} pier"] = "Muelle de {area:392}",
}
