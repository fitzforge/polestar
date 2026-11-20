-- Spanish (Latin America) (esMX): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "Para personajes de nivel 49 a 50, pero la mayoría de las misiones de aquí son de nivel 51-53: a propósito, por su experiencia. Esta primera visita se limita a la mitad este del cráter, donde las bestias son de nivel 48-52, así que atráelas de una en una; los pilones, los huesos y la colmena esperan a la siguiente visita a Un'Goro, hacia el nivel 56.",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",

	-- Step 3: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} está en los muelles donde llega el barco.",

	-- Step 4: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	["Theramore flight master"] = "Maestro de vuelo de Theramore",

	-- Step 5: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "El vuelo desde Theramore aterriza en {area:976}.",

	-- Step 6: Marin Noggenfogger
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "No hiciste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",

	-- Step 8: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "Cabalga al oeste hasta la colmena Centipaar en las dunas. Cualquier Centipaar puede soltar partes de insecto.\nCuidado: los enjambristas Centipaar lanzan {npc:4196} dentro y fuera de combate, lo que atrae pequeños enemigos que te interrumpen.",

	-- Step 9: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Cabalga al sur hasta el complejo ogro. Está lleno de brutos y déspotas (46-48); {npc:12046} (49) está en el centro rodeado de guardias: despéjalos primero.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}, bajo tierra",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}: mata a estos según te los encuentres",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "Cabalga al oeste hasta {quest:3362}. Los recolectores de rocío sueltan las glándulas; solo algunas están llenas, así que guarda la cargada. Los cardizales nudosos y los formarraíces comparten el valle.\nCuidado: los cardizales deambulan mucho, así que puedes atraer enemigos de más con facilidad.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "Cabalga de vuelta al noreste hasta {area:976}: {npc:11758} está en el lado este del pueblo.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, adentro",

	-- Step 12: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Cabalga al sur más allá de {area:1938} hasta {area:981}, los túneles Hazzali; el equipo de Scrimshank está en lo más profundo.\nCuidado: Un insecto vigila el equipo. Muchos insectos patrullan los túneles, algunos de nivel 50, así que las peleas suelen atraer enemigos de más.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593}; bajo tierra",

	-- Step 13: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1428} Burning Steppes
	["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "Para {npc:7740} en {zone:1457}, al final de la guía de {zone:1428}: guárdalo",

	-- Step 15: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Cabalga al oeste desde {area:976} hasta la larga rampa que baja a {zone:1449}. {npc:9619} acampa al pie de la rampa, en la esquina sureste del cráter.",

	-- Step 16: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "El threshadon muerto yace junto al agua al norte de {npc:9619}.\nCuidado: los ravasaurios Pellejo Venenoso (50-51) cazan junto al agua allí: atráelos de uno en uno antes de saquear el cadáver.\nCualquier ravasaurio puede soltar una {item:280459}: haz clic derecho en ella, {npc:9619} la recibe.",

	-- Step 17: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}, si un ravasaurio soltó la escama",
	-- {area:1943} Ironstone Plateau
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "Los gorilas de {area:1943} llevan las pieles: guárdala para la segunda visita a Un'Goro, alrededor del nivel 56",

	-- Step 18: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Compañeras de Lar'korwi ({npc:9683}) y la balsa",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Las Compañeras de Lar'korwi ({npc:9683}) merodean por la jungla al oeste de {npc:9619}. La balsa destrozada está en la orilla del lago de allí; la mochila pequeña está en el agua a su lado. Guarda la brújula, el mapa y la llave para {npc:8737}. Cualquier bestia del cráter puede soltar {item:11116}: haz clic derecho en él.",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "{object:161504}, bajo el agua",

	-- Step 19: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "De vuelta al este con {npc:9619} con las glándulas.",

	-- Step 20: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Cabalga al noroeste hasta el refugio.\nMantente bien lejos de los demosaurios y estegodones élite. Recoge cada {npc:271301} y {object:157936} que encuentres de aquí en adelante.",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998}: sus escamas salen de las bestias jóvenes de la jungla del este",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, al fondo del refugio",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Termina con {npc:9298} en {zone:1452}: guárdala",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, al fondo de la cueva; bajo tierra",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}, {npc:9271}, {npc:9270} y {npc:9618} tienen misiones entre enemigos de nivel 51-55: déjalas para la segunda visita a Un'Goro, alrededor del nivel 56.",

	-- Step 21: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} y la jungla del este",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "Cabalga al este hacia la jungla del este: los Azotadores y Trilladores Sangrepétalo (48-50) sueltan los pétalos y {quest:3764}. Hay grupos de cristales por todo el cráter, muchos al pie de {area:537}: toma algunos de más de cada color.\nCuidado: las Llamaradas vivientes (54-55) recorren la cima de {area:537}, y los Despellejadores y Tramperos Sangrepétalo (51-53) ocupan el sur de la jungla: toma tus cristales al pie de la cresta y tus pétalos en el norte.\nEscamas para {npc:9998}: los {npc:9165} (48-50) planean sobre el noreste de la jungla y los Diemetradones jóvenes (49-50) pastan a su lado. Solo hay diez de ellos: los Diemetradones (51) del borde oeste de la jungla, un poco al oeste de los Trilladores, también sueltan las escamas. Te superan por un nivel: enfréntalos de uno en uno.",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316}, de los Azotadores y Trilladores",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764}, de los Trilladores y los montones de tierra",

	-- Step 22: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "Hay grupos de cristales por todo el cráter. Los Señores de alquitrán de los pozos (53-54) y los mocos a su alrededor (50-54) te superan: toma los cristales del borde noreste de la jungla, entre los Azotadores y las bestias jóvenes (48-50).",

	-- Step 23: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, bajo tierra",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Para {npc:7775} en {zone:1444}: guárdala",

	-- Step 24: Level 49.79
	["Level 49.79"] = "Nivel 49.79",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "¿Todavía no llegas al nivel 49.79 después de las entregas del refugio? Sube de nivel con los Azotadores y Trilladores Sangrepétalo (48-50) de la jungla del este, donde tomaste los pétalos, antes de salir del cráter.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "sube de nivel con {npc:6511}",

	-- Step 25: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Vuela a {area:415}",
	-- {zone:1455} Ironforge · {zone:1427} Searing Gorge · {zone:1440} Ashenvale · {zone:1447} Azshara
	["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "Las misiones de {zone:1455} se tomaron al final de la guía de {zone:1427}: vuela directo a {zone:1440} para ir a {zone:1447}.",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Maestro de vuelo de {area:541}",

	-- Step 26: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "A {zone:1455}",

	-- Step 27: Mystic Ward
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: para Ogtinc en {zone:1447}, guárdala",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "{npc:7312}, el instructor de magos: para {npc:8395} en {zone:1447}, guárdala",

	-- Step 30: Fly to Astranaar
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maestro de vuelo de {area:442}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus está junto al rey Magni en {object:171709}.",
	-- ["Below ground"] = "Bajo tierra",
	-- ["Bind and train"] = "Vincúlate y entrena",
	-- ["Bones and equipment"] = "Huesos y equipo",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Cruza el sur del cráter hasta {npc:9619}, junto a la rampa.",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Los huesos de dinosaurio están en el suelo del suroeste, entre los estegodones: son élite, recoge los huesos a su alrededor y consigue el resto de los diemetradones. {item:11112} de la expedición está en la jungla del suroeste.",
	-- ["Eastern Pylon"] = "Pilón este",
	-- ["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "Vuela de {area:144} a {area:1537}.",
	-- ["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "Para personajes de nivel 49 a 50, pero la mayoría de las misiones de aquí son de nivel 51-53: a propósito, por su experiencia. Las bestias del cráter son de nivel 48-55 y los silítidos Gorishi, de 51-54, así que atráelos de uno en uno.",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "Cuatro calcos de runas en {zone:1447}: guárdala",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Desde {area:144} vuela a {area:150}, toma el barco a Theramore y sigue volando a {area:976}. La primera misión de {npc:9619} en el cráter requiere nivel 48: si te falta, termina el nivel aquí.",
	-- ["Grind to 50"] = "Farmea hasta el 50",
	-- ["Grind to 51"] = "Farmea hasta el 51",
	-- ["Gryfe"] = "Gryfe",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Lleva a {npc:9999} al norte hasta {area:541}. Cuando se desmaye, usa {item:11804} en él para despertarlo.",
	-- ["Level 50.4"] = "Nivel 50.4",
	-- ["Northern Pylon"] = "Pilón norte",
	-- ["Pterrordax"] = "Pterrordáctilo",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Baja por la rampa al cráter: {npc:9619} acampa al pie.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Cabalga al este hasta {area:1943}, donde el robot está entre los gorilas. No entres en la cueva profunda de allí.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Cabalga al este hasta {area:537}, súbela y usa {npc:10541} en las grietas de lava cerca de la cima.",
	-- ["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Cabalga al norte por el lado este del cráter hasta {area:541}, el campamento en las cuevas del acantilado norte. Aléjate bien de los demosaurios y estegodones élite. Desde aquí, recoge todos los cristales de poder y cada {object:157936} que encuentres.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Cabalga al norte por el lado este hasta la meseta de los gorilas. {npc:9622}, un gorila de nivel 55, está en su cueva más profunda: limpia antes los gorilas de la boca de la cueva.",
	-- ["Ride north along the western jungle back to the refuge."] = "Cabalga al norte por la jungla del oeste de vuelta al refugio.",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Cabalga al norte hasta {area:1943}, donde el robot está entre los gorilas. No entres en la cueva profunda de allí.",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Cabalga al sur por los acantilados del este hasta {npc:9619}, al pie de la rampa.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Cabalga al sur por el lado este. Los diemetradones jóvenes pastan en la jungla del este y los {npc:9165} vuelan cerca de los acantilados del este; ambos sueltan las escamas para {npc:9998}.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "Cabalga al sur por el lado este. Los diemetradones jóvenes pastan en la jungla del este y {npc:9165} vuela cerca de los acantilados del este; ambos sueltan las escamas de {npc:9998}. La caja está en el campamento abandonado de la jungla del este.",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Cabalga al sur hasta {area:537}, en medio del cráter, y luego al este hacia la jungla del este. Hay grupos de cristales por todo el cráter, muchos alrededor de {area:537}: toma algunos de más de cada color. Los Azotadores Sangrepétalo ({npc:6509}) y los Trilladores Sangrepétalo sueltan los pétalos; {item:11113} de la expedición está en un campamento abandonado en la jungla del este.",
	-- ["Ride south-west past {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; Pterrordax nest on the southern cliffs if you still need kills.\nCareful: Gorishi silithids are level 51-54 and cast {spell:8137} or {spell:14120} in melee; Gorishi Workers have a 50% chance to call for help within 25 yd once they fall below 45% health."] = "Cabalga al suroeste pasando a {npc:9619}: la colmena de silítidos llena el sur del cráter. Usa el vial raspador en un criadero, una cámara con larvas colgantes. Las avispas y obreras Gorishi sueltan {quest:3764}; los pterrordáctilos anidan en los acantilados del sur si todavía te faltan muertes.\nCuidado: Los silítidos Gorishi son de nivel 51-54 y lanzan {spell:8137} o {spell:14120} cuerpo a cuerpo; las obreras Gorishi tienen un 50% de probabilidad de pedir ayuda a menos de 25 m cuando bajan del 45% de salud.",
	-- ["Ride west back to the refuge."] = "Cabalga al oeste de vuelta al refugio.",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Cabalga al oeste de vuelta al refugio.\nMantente bien lejos de los demosaurios y estegodones élite. Recoge cada {npc:271301} y {object:157936} que encuentres de aquí en adelante.",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Cabalga al oeste desde {npc:9619}: la colmena silítida ocupa el sur del cráter. Usa el vial de raspadura en un criadero, una cámara con larvas colgantes. Las avispas y trabajadores Gorishi sueltan {quest:3764}; los {npc:9166} anidan en los acantilados del sur si aún te faltan muertes.",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Cabalga al oeste desde {area:976} hasta la larga rampa que baja a {area:490}. {npc:9619} acampa al pie de la rampa, en la esquina sureste del cráter.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Cabalga al oeste pasando {area:541} y al sur por el lado oeste hasta {area:543}: {npc:10302}, el goblin, está sentado junto al agua.",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Hacer {area:1417} en vez de farmear te lleva allí más rápido en grupo. Omite este paso para farmear solo.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Hacer {area:978} en vez de farmear te lleva allí más rápido en grupo. La ciudad trol está en el noroeste de {zone:1446}, justo al norte de {area:976}.",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "¿Todavía no llegas al nivel 49.79 después de las entregas del refugio? Sube de nivel con los pterrordáctilos en las laderas al este de {area:541} antes de salir del cráter.",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Los silítidos Centipaar se arrastran alrededor de {area:982}, en el oeste de {zone:1446}, justo al este de la rampa del cráter. Los trabajadores son los más fáciles de atraer.",
	-- ["The Gorishi hive"] = "La colmena Gorishi",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "El trillanodonte muerto está junto al agua, al norte de {npc:9619}.",
	-- ["The east side"] = "El lado este",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Los gorilas viven en {area:1943}, al este de {area:541}. Guarda sus pieles para {npc:9619}. No entres en la cueva más profunda: {npc:9622} es de nivel 55.",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Los gorilas de {area:1943} vienen en grupos pequeños y aún no te sueltan nada; la misión de las pieles de {npc:9619} viene después. No entres en la cueva más profunda: {npc:9622} es de nivel 55.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Las pieles vienen después del circuito 2, en la meseta de los gorilas",
	-- ["The pylon stands on the eastern cliffs."] = "El pilón está en los acantilados del este.",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "El pilón está en la ladera al este del refugio. Los pterrordáctilos sobrevuelan las laderas a su alrededor: cuentan para Spraggle y sueltan las escamas de {npc:9998}.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "El pilón está en la ladera al este del refugio. Los {npc:9166} vuelan en círculos por las laderas a su alrededor: cuentan para {npc:9997} y sueltan las escamas para {npc:9998}.",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "El pilón está en los acantilados del oeste. Los {npc:9167} vuelan sobre todo el lado oeste.",
	-- ["The relics are in the {zone:1428}: keep it"] = "Las reliquias están en {zone:1428}: guárdala",
	-- ["The wooden sign beside {npc:9997}"] = "El letrero de madera junto a {npc:9997}",
	-- ["Top up here to level 49.51 before the hand-ins at {area:541}: they take you to level 50. Or, with a group, run the {area:2100} dungeon instead."] = "Completa aquí hasta el nivel 49.51 antes de las entregas de {area:541}: te llevan al nivel 50. O, con un grupo, haz en su lugar la mazmorra {area:2100}.",
	-- ["Top up here to level 50.4 before the hand-ins at {area:3137}: they take you to level 51."] = "Completa aquí hasta el nivel 50.4 antes de las entregas de {area:3137}: te llevan al nivel 51.",
	-- ["Western Pylon"] = "Pilón oeste",
	-- ["Xiggs waits in the {object:32359}."] = "Xiggs espera en {object:32359}.",
	-- ["grind on Pterrordax"] = "sube de nivel con pterrordáctilos",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "farmea Vagayermos u ogros Machacaduna alrededor de {area:976}",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "farmea {npc:5458} en {area:982}, {zone:1446}",
	-- ["grind on {npc:6116}"] = "farmea {npc:6116}",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "farmea {npc:6514} en {area:1943}, {zone:1449}",
	-- ["grind on {npc:9164}"] = "farmea {npc:9164}",
	-- ["grind on {npc:9167}"] = "farmea {npc:9167}",
	-- ["{area:144} flight master"] = "Maestro de vuelo de {area:144}",
	-- ["{area:978} (optional)"] = "{area:978} (opcional)",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: la guía anterior te trae aquí con la piedra de hogar, así que esto suele marcarse de inmediato",
	-- ["{npc:7564}, once he has brewed the elixir: a few seconds"] = "{npc:7564}, cuando haya preparado el elixir: unos segundos",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, al fondo de la cueva",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: los mocos están en {zone:1448}, guárdala",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618} está justo afuera del refugio.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "La guarida de {npc:9684} está en la jungla al norte de {npc:9619}, bajo los acantilados del este: usa {item:11568} allí. {npc:9684} es de nivel 56: empieza con la salud completa.",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9999}, el amigo de {npc:9997}, ha desaparecido.",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998}, en la entrada del refugio",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, en la entrada del refugio",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado en la ladera sureste de {area:537}, en medio del cráter.",
}
