-- Spanish (Spain) (esES): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 2: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",

	-- Step 3: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	["The zeppelin lands at the tower on the west side of the camp."] = "El zepelín aterriza en la torre del lado oeste del campamento.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: para las Tierras Altas de Arathi, más adelante en la ruta",

	-- Step 4: Bloody Bone Necklace on the way
	-- {item:3915} Bloody Bone Necklace
	["{item:3915} on the way"] = "",

	-- Step 5: Islen Waterseer
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {area:1637} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short walk south of it."] = "",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} y tu {item:5177}",

	-- Step 6: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Hemet Decautela",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Sigue el camino hacia el norte desde {object:3202}; el campamento de caza de Hemet Decautela está en la colina al noreste del río. A partir de aquí, guarda cada página de {quest:338} que consigas: {npc:716} te las pedirá más adelante.",

	-- Step 9: Young Panther on the way
	-- {npc:683} Young Panther
	["{npc:683} on the way"] = "",

	-- Step 10: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "",

	-- Step 11: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Sigue el camino hacia el sur hasta {area:35}, en el extremo sur de la vega, y entra por el túnel de los acantilados. No te salgas del camino: la selva de alrededor está muy por encima de tu nivel. {npc:2858}, el maestro de vuelo de la Horda, espera en la plataforma superior.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	["Upstairs"] = "",

	-- Step 12: Bloodscalp Ear on the way
	-- {item:1519} Bloodscalp Ear
	["{item:1519} on the way"] = "",

	-- Step 13: Tumbled Crystal on the way
	-- {item:4106} Tumbled Crystal
	["{item:4106} on the way"] = "",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 15: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the road south to {object:3202}."] = "Sigue el camino hacia el sur hasta {object:3202}.",

	-- Step 17: The camp by the river
	["The camp by the river"] = "El campamento junto al río",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "El campamento de los cazadores desaparecidos de {npc:773} es el de Hemet Decautela: camina entre sus tiendas y la investigación se completa. Los crocoliscos fluviales están a lo largo del río, bajo el campamento.",

	-- Step 19: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "Los tigres de Tuercespina y las panteras (32-33) recorren las colinas al este del campamento, junto a la orilla del lago.",

	-- Step 20: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Las Panteras Faucesombría llegan mucho más tarde, junto a {object:3202}",

	-- Step 21: Shadowmaw Panther on the way
	-- {npc:684} Shadowmaw Panther
	["{npc:684} on the way"] = "",

	-- Step 22: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Tigres mayores y raptores colazote",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 23: Nesingwary's camp
	["Back north to the camp."] = "Vuelve al norte, al campamento.",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 26: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Piedra de hogar a {area:35}",

	-- Step 27: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Head south down the coast to {object:3202} and fly to {area:35}."] = "",

	-- Step 29: Lashtail Raptor on the way
	-- {npc:686} Lashtail Raptor
	["{npc:686} on the way"] = "",
	-- {npc:686} Lashtail Raptor · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:686} along the way to {object:3202}"] = "",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Los raptores colazote (35-36) cazan en la selva justo al noreste de {object:3202}.",

	-- Step 31: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Al noroeste de Campamento Grom'gol, {area:104} está bajo el agua, frente a la costa. {item:4094} reposa en el fondo del mar junto a las ruinas hundidas; vigila tu respiración y a los múrlocs.",
	["Underwater"] = "",

	-- Step 32: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "",

	-- Step 33: Grom'gol
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "",

	-- Step 34: Mosh'Ogg Brute on the way
	-- {npc:1142} Mosh'Ogg Brute
	["{npc:1142} on the way"] = "",

	-- Step 35: Mosh'Ogg Witch Doctor on the way
	-- {npc:1144} Mosh'Ogg Witch Doctor
	["{npc:1144} on the way"] = "",

	-- Step 36: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 37: Green Hills pages
	["Green Hills pages"] = "Páginas de Las verdes colinas",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Las páginas de {item:2755} caen con un 1% aprox. cada una de los trols Cabellesangre y Machacacráneos; guarda cada página que consigas y busca el resto en la casa de subastas. {npc:716} recoge los capítulos más adelante en esta guía.",

	-- Step 38: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panteras Faucesombría",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Las panteras Faucesombría (37-38) acechan en la selva al este de las colinas Mosh'Ogg y al noreste, hacia el lago; atacan desde el sigilo. Recoge cada página de Las verdes colinas de Tuercespina que encuentres por el camino.",
	-- {npc:684} Shadowmaw Panther
	["grind on {npc:684}"] = "",

	-- Step 39: Venture Co. camp
	["Venture Co. camp"] = "Campamento de Ventura y Cía.",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "",

	-- Step 40: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "",

	-- Step 41: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "De vuelta a {object:3202}.",

	-- Step 42: Level 36
	["Level 36"] = "",
	-- {area:321} Hammerfall
	["Top up here to level 36 before the hand-ins at {area:321}: they take you to level 37."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {object:3202}"] = "De vuelta a {object:3202}",
	-- ["Basilisks and the Bloodscalp village"] = "Basiliscos y el poblado Cabellesangre",
	-- ["Bloodscalp headhunters"] = "Rebanacabezas Cabellesangre",
	-- ["Bloodscalp ruins"] = "Ruinas Cabellesangre",
	-- ["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "Al este de los ogros, las panteras Faucesombría (37-38) acechan sin ser vistas hasta que atacan; las tigresas de Tuercespina recorren la misma zona y de vez en cuando sueltan un Colmillo de tigre prístino. Los crocoliscos Quijaforte bordean el río justo al oeste de la selva; guarda sus pieles para {npc:2495}.",
	-- ["Follow the road north to the camp."] = "Sigue el camino hacia el norte hasta el campamento.",
	-- ["Follow the road on south into {area:35}."] = "Sigue el camino hacia el sur hasta {area:35}.",
	-- ["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "Ve al oeste pasando el campamento. Los raptores de Tuercespina (33-34) cazan en los claros y los trols Cabellesangre ocupan las ruinas de la costa: cualquier Cabellesangre puede soltar un Colmillo Sangrapellejo. {item:4614} es un botín muy raro de ellos: si te cae, léelo.",
	-- ["Hearth to {object:3202}"] = "Piedra de hogar a {object:3202}",
	-- ["Jungle Stalkers"] = "Acechadores de la selva",
	-- ["Lashtail raptors"] = "Raptores colazote",
	-- ["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "Sal de {zone:1458} por el ascensor y sube por las ruinas hasta las torres de los zepelines; el zepelín de {object:3202} es el de la torre suroeste.",
	-- ["Mistvale gorillas"] = "Gorilas Velo de Bruma",
	-- ["Mosh'Ogg camp"] = "Campamento Mosh'Ogg",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "Las páginas de {item:2755} caen con un 1% aprox. cada una de los trols Cabellesangre y Machacacráneos; recoge lo que caiga y busca el resto en la casa de subastas.",
	-- ["Raptors and the Bloodscalp trolls"] = "Raptores y trols Cabellesangre",
	-- ["Ride back south to {object:3202}."] = "Cabalga de vuelta al sur, a {object:3202}.",
	-- ["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Cabalga hacia el norte pasando el campamento de Hemet Decautela hasta el lago. Los geólogos de Ventura y Cía. (34-36) trabajan en los campamentos de su orilla oeste; llevan los cristales caídos.",
	-- ["Ride south down the coast to {object:3202} and fly to {area:35}."] = "Cabalga hacia el sur por la costa hasta {object:3202} y vuela a {area:35}.",
	-- ["Shadowmaw jungle and the Snapjaw river"] = "Selva Faucesombría y río Quijaforte",
	-- ["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Toma el camino hacia el sur, hacia {area:35}. Los gorilas del Valle Velo de Bruma viejos (40-41) viven en {area:1737}, al este del camino; uno de cada veinte, más o menos, lleva un Tendón de gorila mayor.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "Toma el zepelín a {zone:1454} en la torre del lado oeste de {object:3202} y vuela a {area:392}. {npc:5901} acampa en la costa, a poca distancia al sur.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "Toma el zepelín a {zone:1454} en la torre del lado oeste de {object:3202} y entrena en la ciudad antes de seguir volando.",
	-- ["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "Los rebanacabezas Cabellesangre (36-37) del poblado de la costa llevan las cabezas reducidas.",
	-- ["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Los trols Cabellesangre ocupan las ruinas de la costa al norte del arrecife y el poblado de más allá; cualquiera puede soltar {item:3915}. Sigue recogiendo páginas de {quest:338}.",
	-- ["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "Los tigres de Tuercespina mayores (34-35) recorren las colinas al suroeste del campamento; los raptores colazote (35-36) cazan más al sur, hacia {object:3202}.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Los acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Los ogros Mosh'Ogg acampan en las colinas justo al este de {object:3202}. Mata a un tosco Mosh'Ogg y a un médico brujo Mosh'Ogg (36-37); atráelos de uno en uno.",
	-- ["The next guide flies you north to {area:272} and into the {zone:1417}."] = "La siguiente guía te lleva volando al norte hasta {area:272} y a {zone:1417}.",
	-- ["Tigers and panthers"] = "Tigres y panteras",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "Al oeste, pasado el campamento, los basiliscos Espina de Cristal (34-35) descansan en las rocas; cualquier Cabellesangre del poblado de más allá puede soltar una Oreja Sangrapellejo.",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "Los tigres jóvenes de Tuercespina merodean al oeste del campamento; las panteras jóvenes, al sur y al este.",
	-- ["Young tigers and panthers"] = "Tigres jóvenes y panteras",
	-- ["Zeppelin towers"] = "Torres de los zepelines",
	-- ["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}: las pieles de crocolisco Quijaforte reunidas antes",
	-- ["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}, un tigre de nivel 37, merodea por la cima de la colina al suroeste del campamento.",
}
