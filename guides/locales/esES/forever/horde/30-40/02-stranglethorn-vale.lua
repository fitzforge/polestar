-- Spanish (Spain) (esES): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",
	-- {zone:1458} Undercity · {object:3202} Grom'gol (no name in this language: may be words)
	["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "Sal de {zone:1458} por el ascensor y sube por las ruinas hasta las torres de los zepelines; el zepelín de {object:3202} es el de la torre suroeste.",
	["Zeppelin towers"] = "Torres de los zepelines",

	-- Step 2: Grom'gol Base Camp
	["The zeppelin lands at the tower on the west side of the camp."] = "El zepelín aterriza en la torre del lado oeste del campamento.",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "Toma el zepelín a {zone:1454} en la torre del lado oeste de {object:3202} y entrena en la ciudad antes de seguir volando.",

	-- Step 4: Islen Waterseer
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "Toma el zepelín a {zone:1454} en la torre del lado oeste de {object:3202} y vuela a {area:392}. {npc:5901} acampa en la costa, a poca distancia al sur.",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} y tu {item:5177}",

	-- Step 5: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "De vuelta a {object:3202}",

	-- Step 6: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Hemet Decautela",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Sigue el camino hacia el norte desde {object:3202}; el campamento de caza de Hemet Decautela está en la colina al noreste del río. A partir de aquí, guarda cada página de {quest:338} que consigas: {npc:716} te las pedirá más adelante.",

	-- Step 7: Young tigers and panthers
	["Young tigers and panthers"] = "Tigres jóvenes y panteras",
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "Los tigres jóvenes de Tuercespina merodean al oeste del campamento; las panteras jóvenes, al sur y al este.",

	-- Step 9: Tigers and panthers
	["Tigers and panthers"] = "Tigres y panteras",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "Los tigres de Tuercespina y las panteras (32-33) recorren las colinas al este del campamento, junto a la orilla del lago.",

	-- Step 10: Raptors and the Bloodscalp trolls
	["Raptors and the Bloodscalp trolls"] = "Raptores y trols Cabellesangre",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "Ve al oeste pasando el campamento. Los raptores de Tuercespina (33-34) cazan en los claros y los trols Cabellesangre ocupan las ruinas de la costa: cualquier Cabellesangre puede soltar un Colmillo Sangrapellejo. {item:4614} es un botín muy raro de ellos: si te cae, léelo.",

	-- Step 11: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Las Panteras Faucesombría llegan mucho más tarde, junto a {object:3202}",

	-- Step 12: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Tigres mayores y raptores colazote",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "Los tigres de Tuercespina mayores (34-35) recorren las colinas al suroeste del campamento; los raptores colazote (35-36) cazan más al sur, hacia {object:3202}.",

	-- Step 13: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the road south to {object:3202}."] = "Sigue el camino hacia el sur hasta {object:3202}.",

	-- Step 14: Nesingwary's camp
	["Back north to the camp."] = "Vuelve al norte, al campamento.",

	-- Step 15: Sin'Dall
	-- {npc:729} Sin'Dall
	["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}, un tigre de nivel 37, merodea por la cima de la colina al suroeste del campamento.",

	-- Step 17: Bloodscalp headhunters
	["Bloodscalp headhunters"] = "Rebanacabezas Cabellesangre",
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "Los rebanacabezas Cabellesangre (36-37) del poblado de la costa llevan las cabezas reducidas.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Hearth to {object:3202}"] = "Piedra de hogar a {object:3202}",

	-- Step 19: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Sigue el camino hacia el sur hasta {area:35}, en el extremo sur de la vega, y entra por el túnel de los acantilados. No te salgas del camino: la selva de alrededor está muy por encima de tu nivel. {npc:2858}, el maestro de vuelo de la Horda, espera en la plataforma superior.",

	-- Step 20: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",

	-- Step 21: The camp by the river
	["The camp by the river"] = "El campamento junto al río",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "El campamento de los cazadores desaparecidos de {npc:773} es el de Hemet Decautela: camina entre sus tiendas y la investigación se completa. Los crocoliscos fluviales están a lo largo del río, bajo el campamento.",

	-- Step 22: Basilisks and the Bloodscalp village
	["Basilisks and the Bloodscalp village"] = "Basiliscos y el poblado Cabellesangre",
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "Al oeste, pasado el campamento, los basiliscos Espina de Cristal (34-35) descansan en las rocas; cualquier Cabellesangre del poblado de más allá puede soltar una Oreja Sangrapellejo.",

	-- Step 23: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Ride south down the coast to {object:3202} and fly to {area:35}."] = "Cabalga hacia el sur por la costa hasta {object:3202} y vuela a {area:35}.",

	-- Step 24: Fly to Grom'gol
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: para las Tierras Altas de Arathi, más adelante en la ruta",

	-- Step 25: Lashtail raptors
	["Lashtail raptors"] = "Raptores colazote",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Los raptores colazote (35-36) cazan en la selva justo al noreste de {object:3202}.",

	-- Step 27: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Campamento Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Los ogros Mosh'Ogg acampan en las colinas justo al este de {object:3202}. Mata a un tosco Mosh'Ogg y a un médico brujo Mosh'Ogg (36-37); atráelos de uno en uno.",

	-- Step 28: Shadowmaw jungle and the Snapjaw river
	["Shadowmaw jungle and the Snapjaw river"] = "Selva Faucesombría y río Quijaforte",
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "Al este de los ogros, las panteras Faucesombría (37-38) acechan sin ser vistas hasta que atacan; las tigresas de Tuercespina recorren la misma zona y de vez en cuando sueltan un Colmillo de tigre prístino. Los crocoliscos Quijaforte bordean el río justo al oeste de la selva; guarda sus pieles para {npc:2495}.",

	-- Step 29: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "De vuelta a {object:3202}.",

	-- Step 30: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Al noroeste de Campamento Grom'gol, {area:104} está bajo el agua, frente a la costa. {item:4094} reposa en el fondo del mar junto a las ruinas hundidas; vigila tu respiración y a los múrlocs.",

	-- Step 31: Bloodscalp ruins
	["Bloodscalp ruins"] = "Ruinas Cabellesangre",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Los trols Cabellesangre ocupan las ruinas de la costa al norte del arrecife y el poblado de más allá; cualquiera puede soltar {item:3915}. Sigue recogiendo páginas de {quest:338}.",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride back south to {object:3202}."] = "Cabalga de vuelta al sur, a {object:3202}.",

	-- Step 33: Green Hills pages
	["Green Hills pages"] = "Páginas de Las verdes colinas",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Las páginas de {item:2755} caen con un 1% aprox. cada una de los trols Cabellesangre y Machacacráneos; guarda cada página que consigas y busca el resto en la casa de subastas. {npc:716} recoge los capítulos más adelante en esta guía.",

	-- Step 34: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panteras Faucesombría",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Las panteras Faucesombría (37-38) acechan en la selva al este de las colinas Mosh'Ogg y al noreste, hacia el lago; atacan desde el sigilo. Recoge cada página de Las verdes colinas de Tuercespina que encuentres por el camino.",

	-- Step 35: Green Hills pages
	-- {item:2755} Green Hills of Stranglethorn
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "Las páginas de {item:2755} caen con un 1% aprox. cada una de los trols Cabellesangre y Machacacráneos; recoge lo que caiga y busca el resto en la casa de subastas.",

	-- Step 38: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Los acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.",

	-- Step 40: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas Velo de Bruma",
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Toma el camino hacia el sur, hacia {area:35}. Los gorilas del Valle Velo de Bruma viejos (40-41) viven en {area:1737}, al este del camino; uno de cada veinte, más o menos, lleva un Tendón de gorila mayor.",

	-- Step 41: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road on south into {area:35}."] = "Sigue el camino hacia el sur hasta {area:35}.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}: las pieles de crocolisco Quijaforte reunidas antes",

	-- Step 43: Venture Co. camp
	["Venture Co. camp"] = "Campamento de Ventura y Cía.",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Cabalga hacia el norte pasando el campamento de Hemet Decautela hasta el lago. Los geólogos de Ventura y Cía. (34-36) trabajan en los campamentos de su orilla oeste; llevan los cristales caídos.",

	-- Step 44: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Piedra de hogar a {area:35}",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "La siguiente guía te lleva volando al norte hasta {area:272} y a {zone:1417}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the camp."] = "Sigue el camino hacia el norte hasta el campamento.",
}
