-- Spanish (Latin America) (esMX): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn, where the flight lands. His mushrooms grow in the {area:1517} dig at the {zone:1418}' northern edge, on this guide's loop back north."] = "{npc:1470} está bajo tierra en {area:144}, junto a la posada, donde aterriza el vuelo. Sus champiñones crecen en la excavación de {area:1517}, en el borde norte de {zone:1418}, en el regreso al norte de esta guía.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, bajo tierra",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Cabalga hacia el sur, fuera de {zone:1432}, por el paso hasta {zone:1418}; {npc:2860} acampa en la excavación.",
	-- {quest:706} Fiery Blaze Enchantments · {item:4612} Black Drake's Heart
	["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}: su {item:4612} cae rara vez, así que el trabajo y la entrega también son opcionales",

	-- Step 4: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} acampa solo en {area:1898}, al sureste de la excavación.",

	-- Step 5: Agmond's End
	-- {npc:269577} Dorgaron · {item:278404} Pristine Mattock · {quest:739} Murdaloc
	["{npc:269577}'s {item:278404} lies in the middle of the Stonevault trogg camp, where {quest:739} walks."] = "El {item:278404} de {npc:269577} está en medio del campamento trogg Bóveda Pétrea, donde camina {quest:739}.",

	-- Step 6: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "{npc:2817}: perlas azules de Tuercespina",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "La siguiente misión de {npc:2817} no da experiencia: omítela.",

	-- Step 7: Boss Tho'grun
	-- {npc:2944} Boss Tho'grun · {area:342} Camp Boff · {zone:1418} Badlands
	["{npc:2944} does not stay at {area:342}: he walks a long loop around the {zone:1418} with his guards, from the camp in the west along the south of the zone to about 61,69, north to about 49,49 and back west to the camp. The arrow follows his loop west from here until you meet him."] = "{npc:2944} no se queda en {area:342}: recorre un largo circuito por {zone:1418} con sus guardias, desde el campamento en el oeste por el sur de la zona hasta aproximadamente 61,69, al norte hasta aproximadamente 49,49 y de vuelta al oeste hasta el campamento. La flecha sigue su circuito hacia el oeste desde aquí hasta que lo encuentres.",

	-- Step 8: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Cabalga de vuelta al este hasta {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "La siguiente tarea de {npc:2888} es una cacería de élite: omítela.",

	-- Step 9: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Las Crías hirvientes anidan en el barranco al este de {npc:2888}; deja en paz a los Guardianes abrasados (élite). {item:4612} cae rara vez: tómalo si aparece mientras cazas.",

	-- Step 11: Dorgaron
	-- {npc:269577} Dorgaron · {zone:1432} Loch Modan
	["{npc:269577} camps at the foot of the pass into {zone:1432}, on the way north."] = "{npc:269577} acampa al pie del paso hacia {zone:1432}, de camino al norte.",

	-- Step 12: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "A {zone:1432}",

	-- Step 13: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "Cabalga al norte por el paso hasta {zone:1432} y al este por la orilla sur hasta el campamento de Ironband.",

	-- Step 14: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "A {zone:1418}",

	-- Step 15: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "La excavación de {area:1517}",

	-- Step 16: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "De vuelta por el paso: los troggs Grutacanto cavan afuera de {area:1517}, en el borde norte de {zone:1418}. Las urnas talladas y los grupos de champiñones magenta están en sus cuevas y túneles, fuera de la propia mazmorra.",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "{item:8047}; bajo tierra",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "{object:2743}; bajo tierra",

	-- Step 17: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "De vuelta a {zone:1432}",

	-- Step 18: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Cabalga de vuelta al norte hasta la Excavación de Vetaferro.",

	-- Step 19: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "Cabalga al oeste por el lago hasta {area:144}.",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maestro de vuelo de {area:144}",

	-- Step 21: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "{npc:3980} predica junto a la posada.",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}, arriba",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "El siguiente encargo de Raleigh es en {area:796}: omítelo.",

	-- Step 22: Loremaster Dibbs
	-- {npc:2277} Loremaster Dibbs · {area:271} Southshore
	["{npc:2277} stands in {area:271}, by the inn."] = "{npc:2277} está en {area:271}, junto a la posada.",

	-- Step 24: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Cabalga hacia el noreste fuera de {area:271} por el camino hacia {zone:1425}; {area:348} está justo pasando la frontera. {npc:5635} recibe en la cima, {quest:1450} cuida el aviario y {npc:7884} está junto a la posada.",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}, adentro",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, adentro",

	-- Step 25: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} acampa en el camino al este de {area:348}.",

	-- Step 26: Witherbark villages
	["Witherbark villages"] = "Aldeas Secacorteza",
	-- {npc:5634} Rhapsody Shindigger · {npc:270772} Witch Doctor Ti'ik
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace.\nCareful: {npc:270772} (49) and his Hexed Larvae (45) keep to the huts of the western village, around 25,64: take the necklaces from the trolls outside."] = "Las dos primeras jaulas están juntas en la aldea Secacorteza al sur de {npc:5634}; la tercera está en la siguiente aldea al este. Cualquier trol Secacorteza puede soltar un collar.\nCuidado: {npc:270772} (49) y sus Larvas embrujadas (45) se quedan en las chozas de la aldea del oeste, alrededor de 25,64: consigue los collares de los trols de afuera.",

	-- Step 27: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}, junto al maestro de vuelo de arriba; adentro",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "La siguiente tarea de Talonaxe espera a una guía posterior de {zone:1425}.",

	-- Step 28: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maestro de vuelo de {area:348}",

	-- Step 30: Theramore
	["Theramore"] = "Isla Theramore",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, en el piso de arriba",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, adentro",

	-- Step 31: Cortello's Riddle
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "Dentro de {area:498}",

	-- Step 32: Mudsprocket
	["Mudsprocket"] = "Fangoengranaje",
	-- {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle
	["Take the road south-west out of Theramore to Mudsprocket, the goblin camp at the edge of the {area:511}. {npc:270723} and {npc:270727} stand together in the camp."] = "Toma el camino al suroeste desde Theramore hasta Fangoengranaje, el campamento goblin al borde de {area:511}. {npc:270723} y {npc:270727} están juntos en el campamento.",

	-- Step 33: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {item:280092} Wyrmtail
	-- plural, as words: Searing Hatchlings = {npc:4323} Searing Hatchling · Firemane Scalebanes = {npc:4328} Firemane Scalebane
	["The {item:280092} grows in the bog east of the camp: gather it first. Then the Searing Hatchlings and Whelps (41-43) and the Firemane dragonkin nest in the bog north and west of Mudsprocket, on the way back; all of them drop the shed scales.\nCareful: the Firemane Scalebanes and Flamecallers are 43-44 and cast fire: pull them one at a time."] = "La {item:280092} crece en la ciénaga al este del campamento: recógela primero. Luego las Proles abrasadoras y los vástagos (41-43) y los dragonantes Pirocabello anidan en la ciénaga al norte y al oeste de Fangoengranaje, de regreso; todos sueltan las escamas mudadas.\nCuidado: los Horrocrustos Pirocabello y los Clamafuegos son de nivel 43-44 y lanzan fuego: atráelos de uno en uno.",

	-- Step 34: Mudsprocket
	["Then ride back north-east to Theramore's flight master."] = "Luego cabalga de vuelta al noreste hasta el maestro de vuelo de Theramore.",

	-- Step 35: Theramore flight master
	["Theramore flight master"] = "Maestro de vuelo de Theramore",

	-- Step 37: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Brujo: {quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "Desde Theramore, cabalga al norte por {zone:1413} hasta {area:392}, o vuela si conoces su ruta de vuelo. {npc:6251} enseña en la casa junto al banco.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blue Pearls from Stranglethorn"] = "Perlas azules de Vega de Tuercespina",
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Vuela a {area:392}; {npc:6251} enseña en la casa junto al banco. Después, vuela de regreso a Isla Theramore.",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Vuela a {area:608}, cabalga hacia el sur por {zone:1443} hasta {zone:1444} y sigue el camino hasta el muelle de {area:1108}; el barco cruza a {area:1116}, donde empieza la siguiente guía.",
	-- ["On to Feathermoon"] = "Rumbo a Bastión Plumaluna",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Cabalga hacia el norte hasta {area:144} y vuela a {area:271}. {npc:3980} predica junto a la posada.",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Cabalga hacia el noreste fuera de {area:271} por el camino hacia {area:47}; {area:348} está justo pasando la frontera. {npc:5635} recibe en la cima, {quest:1450} cuida el aviario y {npc:7884} está junto a la posada.",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Cabalga hacia el noreste fuera de {area:271} por el camino hacia {zone:1425}; {area:348} está justo pasando la frontera. Falstad recibe en la cima, {quest:1450} cuida el aviario y {npc:7884} está junto a la posada.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Cabalga hacia el sur, fuera de {zone:1432}, por el paso hasta {zone:1418}; {npc:2860} acampa en la excavación.",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Cabalga hacia el oeste a través de {area:3} hasta el campamento Rotapolvo de {area:342}. {npc:2944} está en el centro, rodeado de Cazavermis y Aplastadores.",
	-- ["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Cabalga hacia el oeste a través de {zone:1418} hasta el campamento Rotapolvo de {area:342}. {npc:2944} está en el centro, rodeado de Cazavermis y Aplastadores.",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Cabalga hacia el oeste hasta {area:1877}, en el centro de {zone:1418}; {npc:2817} acampa junto a Martek.",
	-- ["Take the boat to Theramore from the far pier."] = "Toma el barco a Isla Theramore desde el muelle más lejano.",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "La siguiente tarea de Talonaxe espera a una guía posterior de {area:47}.",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "El esqueleto maltrecho está en el borde del campamento de troggs Grutacanto; {quest:739}, el asesino de Agmond, camina entre los Cascahuesos.",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "caza {npc:2725} en {area:339}, {zone:1418}",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- ["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} está en los muelles donde llega el barco.",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} acampa solo en {area:1898}, al sureste de la excavación.",
	-- ["{npc:4968}, on the top floor"] = "{npc:4968}, en el piso de arriba",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "El cóctel de {npc:5634} requiere piezas de Kalimdor: omítelo.",
	-- ["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, junto al maestro de vuelo en la cima",
	-- ["{npc:7744}; below ground"] = "{npc:7744}; bajo tierra",
	-- ["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} sigue pagando por collares: entrega los que te sobren",
}
