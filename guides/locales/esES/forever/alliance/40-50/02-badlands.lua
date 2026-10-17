-- Spanish (Spain) (esES): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",

	-- Step 2: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Cabalga al sur, fuera de {zone:1432}, por el paso hasta {zone:1418}; {npc:2860} acampa en la excavación.",

	-- Step 3: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} acampa solo en {area:1898}, al sureste de la excavación.",

	-- Step 4: Agmond's End
	-- {quest:739} Murdaloc
	["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "El esqueleto maltrecho está al borde del campamento de los troggs Grutacanto; {quest:739}, el asesino de Agmond, anda entre los Partehuesos.",

	-- Step 5: Rigglefuzz
	-- {area:1877} Valley of Fangs · {zone:1418} Badlands · {npc:2817} Rigglefuzz
	["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Cabalga al oeste hasta {area:1877}, en el centro de {zone:1418}; {npc:2817} acampa junto a Martek el Exiliado.",
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["Blue Pearls from Stranglethorn"] = "Perlas azules de la Vega de Tuercespina",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "La siguiente misión de {npc:2817} no da experiencia: omítela.",

	-- Step 6: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Cabalga al oeste por {zone:1418} hasta el campamento Rotapolvo de {area:342}. {npc:2944} está en el centro, rodeado de Cazavermis y Destructores.",

	-- Step 7: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Vuelve al este hasta {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "La siguiente tarea de {npc:2888} es una caza élite: omítela.",

	-- Step 8: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Las Crías hirvientes anidan en el barranco al este de {npc:2888}; deja en paz a los Guardianes abrasados (élite). El {item:4612} cae muy pocas veces: cógelo si sale mientras subes de nivel.",
	-- {npc:2725} Scalding Whelp · {area:339} Lethlor Ravine · {zone:1418} Badlands
	["grind on {npc:2725} at {area:339}, {zone:1418}"] = "sube de nivel con {npc:2725} en {area:339}, {zone:1418}",

	-- Step 10: Southshore
	-- {area:144} Thelsamar · {area:271} Southshore · {npc:3980} Raleigh the Devout
	["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Cabalga al norte hasta {area:144} y vuela a {area:271}. {npc:3980} predica junto a la posada.",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "El siguiente encargo de Raleigh el Devoto es en {area:796}: omítelo.",

	-- Step 11: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Cabalga al noreste, fuera de {area:271}, por el camino hacia {zone:1425}; {area:348} está justo pasada la frontera. {npc:5635} recibe en lo alto, {quest:1450} cuida del aviario y {npc:7884} está junto a la posada.",

	-- Step 12: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} acampa en el camino al este de {area:348}.",
	-- {npc:5634} Rhapsody Shindigger
	["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "El cubata de {npc:5634} requiere ingredientes de Kalimdor: omítelo.",

	-- Step 13: Witherbark villages
	["Witherbark villages"] = "Poblados Secacorteza",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "Las dos primeras jaulas están juntas en el poblado Secacorteza al sur de {npc:5634}; la tercera, en el siguiente poblado al este. Cualquier trol Secacorteza puede soltar un collar.",

	-- Step 14: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} sigue pagando por los collares: entrega los que te sobren",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, junto al maestro de vuelo, en lo alto",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "La siguiente tarea del Maestro de grifos Garracha espera a una guía posterior de {zone:1425}.",

	-- Step 15: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Toma el barco a Theramore en el muelle del fondo.",

	-- Step 16: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} está en los muelles donde atraca el barco.",

	-- Step 17: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Brujo: {quest:3631}",
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Vuela a {area:392}; {npc:6251} enseña en la casa junto al banco. Después vuelve volando a Theramore.",

	-- Step 18: On to Feathermoon
	["On to Feathermoon"] = "Rumbo a Bastión Plumaluna",
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Vuela a {area:608}, cabalga al sur por {zone:1443} hasta {zone:1444} y sigue el camino hasta el muelle de {area:1108}; el barco cruza hasta {area:1116}, donde empieza la siguiente guía.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Cabalga al noreste, fuera de {area:271}, por el camino hacia {zone:1425}; {area:348} está justo pasada la frontera. Falstad Martillo Salvaje recibe en lo alto, {quest:1450} cuida del aviario y {npc:7884} está junto a la posada.",
	-- ["Talonaxe's next task waits for a later {zone:1425} guide."] = "La siguiente tarea del Maestro de grifos Garracha espera a una guía posterior de {zone:1425}.",
}
