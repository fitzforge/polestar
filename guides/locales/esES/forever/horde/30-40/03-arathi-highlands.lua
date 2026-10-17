-- Spanish (Spain) (esES): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words) · {object:1661} The Undercity
	["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "Desde {area:35}, vuela a {object:3202}. El zepelín de {object:1661} sale de la torre del lado oeste del campamento.",
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661} no tiene instructor de cazadores ni de chamanes: toma en su lugar el zepelín de {zone:1454} en la misma torre y entrena en la ciudad; luego toma el zepelín de {zone:1458} en la torre de fuera de la puerta principal de {zone:1454}.",

	-- Step 3: Thunder Bluff
	-- {spell:18960} Teleport: Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Lanza {spell:18960} y toma el vuelo de {npc:11798} a {area:1638}; {npc:3033} te entrena en {area:1639}. Luego vuela a {zone:1454} y toma el zepelín de {zone:1458} en la torre de fuera de la puerta principal.",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instructores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entrena mientras estés en {zone:1458}: los instructores están en {object:36070}, {object:36073} y {object:36082} (paladines: {npc:260093}).",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {zone:1458} Undercity · {area:272} Tarren Mill
	["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "El zepelín llega a las torres de fuera de {zone:1458}: baja a la ciudad y vuela a {area:272}.",

	-- Step 6: Boulderfist camp
	["Boulderfist camp"] = "Campamento Puño de Roca",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Cabalga al este desde {area:272} por {area:1857} y sigue el camino al este. Los Ogros Puño de Roca y los ejecutores (32-34) acampan al sur del camino, al sureste de {area:313}.",

	-- Step 7: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "Los fragmentos violetas brillan junto al camino, un poco al oeste de {area:321}.",

	-- Step 8: Hammerfall
	["The orc stronghold at the eastern end of the road. Urda, the wind rider master, stands by the gate."] = "La fortaleza orca al final del camino por el este. Urda, la maestra de jinetes del viento, está junto a la puerta.",

	-- Step 9: Highland raptors
	["Highland raptors"] = "Raptores de las Tierras Altas",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "Los Zancudos de las Tierras Altas recorren las colinas alrededor de {area:321}; tanto ellos como los vapuleadores más al oeste sueltan los ojos.",

	-- Step 11: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "Al noreste de Sentencia, los kobolds Mostacho Seco excavan la garganta; los kobolds de la entrada y los excavadores y topógrafos del fondo sueltan las Motas de Myzrael.",

	-- Step 12: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} están al fondo de la garganta.",

	-- Step 13: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "Cada {object:180105} es un anillo de menhires; la llave está en la piedra del centro. El círculo este está en las colinas al noroeste de {area:321}.",

	-- Step 14: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "Los trols Secacorteza ocupan la aldea de las colinas del sureste. Los lanzahachas vigilan las chozas exteriores; los médicos brujos y los cazadores de cabezas ocupan el centro de la aldea.",

	-- Step 15: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptores acechacarne",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Los Acechacarnes de las Tierras Altas (36-37) cazan en las tierras altas del sur: una manada al norte de {area:316} y otra en la llanura al oeste. Atráelos de uno en uno.",

	-- Step 16: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Cabalga al suroeste hasta la cala de los goblins en la costa sur. {npc:2766} vigila desde el acantilado de encima.",

	-- Step 17: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "Escolta al profesor hasta la orilla. Dos nagas Espinadaga le tienden una emboscada por el camino: no te alejes.",

	-- Step 19: Daggerspine shore
	["Daggerspine shore"] = "Orilla Espinadaga",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "Al oeste de la cala, los Asaltantes Espinadaga y las hechiceras (38-40) ocupan la orilla: atráelos de uno en uno. Los dos naufragios están en las aguas poco profundas, con las cartas y los diarios dentro; las gemas están en el fondo del mar alrededor de los naufragios.",

	-- Step 20: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "para {npc:2487} en {area:35}, sobre el nivel 44",

	-- Step 21: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Ride north; the outer circle stands in the middle of the highlands."] = "Cabalga al norte; el círculo exterior está en el centro de las tierras altas.",

	-- Step 22: Northfold Manor
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "El Sindicato ocupa la mansión amurallada y su granja en el noroeste; sus salteadores, mercenarios y acechasendas llevan los Amuletos de Petrosangre.",

	-- Step 23: The Stone of West Binding
	-- {object:2689} Stone of West Binding
	["The {object:2689}"] = "{object:2689}",
	-- {area:1857} Thoradin's Wall
	["The western circle is near {area:1857}, where you rode in."] = "El círculo oeste está cerca de {area:1857}, por donde entraste.",

	-- Step 24: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "El círculo interior está al sur del círculo oeste, al este de Stromgarde.",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "La siguiente tarea de la piedra requiere a Fozruk, un élite de nivel 42: déjala.",

	-- Step 25: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Vuelve a {area:321}",

	-- Step 26: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Los Toscos Puño de Roca acampan fuera de la sala de los ogros al sur de {area:321}; los magos están entre ellos. Atráelos de uno en uno.",

	-- Step 27: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "La siguiente {quest:678} de {npc:2771} es contra élites Puño de Roca: déjala.",

	-- Step 28: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Hacia {zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Sal de Arathi al suroeste por {area:880}, ve al sur por {zone:1437} (mantente lejos de {area:150}) y al este hasta {zone:1432}; el camino sale de {zone:1432} por el sur hacia {zone:1418}. Síguelo al sur hasta el campamento goblin de {area:1877}.",

	-- Step 29: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: la carta de Fizzle desde {area:439}",

	-- Step 30: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Cabalga al oeste por el camino; el campamento de {npc:2921} está en {area:1878}, a medio camino de {area:340}.",

	-- Step 31: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340} es la fortaleza de la Horda excavada en los acantilados del borde oeste de la zona.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "para Helgrum en {area:75}, sobre el nivel 42",

	-- Step 32: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementales de piedra inferiores",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "Los elementales pequeños vagan por la llanura justo al oeste del campamento de {npc:2921}. Cualquier elemental de roca de la zona puede soltar los Fragmentos de roca elemental de {npc:6868}: guárdalos.",

	-- Step 34: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementales de piedra",
	-- {area:1878} The Dustbowl
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Los Elementales de piedra más grandes están en las laderas al noroeste de {area:1878}; cada uno suelta una losa.",

	-- Step 36: Coyotes and buzzards
	["Coyotes and buzzards"] = "Coyotes y águilas ratoneras",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Los Coyotes del risco mayores y las Águilas ratoneras gigantes recorren la cuenca al sur de {area:1878}. Los coyotes sueltan tanto las mandíbulas como los colmillos; solo las águilas ratoneras sueltan alas y mollejas.",

	-- Step 37: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Elementales de piedra mayores",
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Los Elementales de piedra mayores (42-44, muy por encima de ti) vagan por los barrancos del suroeste; los brazales caen más o menos en una de cada cinco muertes. Atráelos de uno en uno y descansa entre combates, o déjalos. Sigue matando por el camino los coyotes y águilas ratoneras que aún necesites.",

	-- Step 38: Kargath
	-- {area:340} Kargath
	["Ride north back to {area:340}."] = "Vuelve al norte hasta {area:340}.",

	-- Step 39: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: solo si llevas {item:2868} ({skill:164} o la casa de subastas)",

	-- Step 41: Stonevault troggs
	["Stonevault troggs"] = "Troggs Grutacanto",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Los troggs Grutacanto excavan alrededor de las bocas de cueva al sur de {area:1877}, de camino a {area:345}; los rompehuesos y los chamanes sueltan las escamas.",

	-- Step 42: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin está entre las ruinas enanas de {area:345}, al sur de {area:1877}.",

	-- Step 43: Valley of Fangs
	-- {npc:4618} Martek the Exiled
	["Follow the road north; {npc:4618}'s camp is on the way."] = "Sigue el camino al norte; el campamento de {npc:4618} está de camino.",

	-- Step 44: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Sigue al norte por el camino; el cofre está en la excavación de {area:1517}, al pie de las ruinas al noroeste del camino.",

	-- Step 45: Agmond's End
	-- {area:1877} Valley of Fangs
	["Ride back south down the road, past the {area:1877}."] = "Vuelve al sur por el camino, pasando {area:1877}.",

	-- Step 46: Hearth to Kargath
	-- {area:340} Kargath
	["Hearth to {area:340}"] = "Usa la piedra de hogar para ir a {area:340}",

	-- Step 47: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "Toma el zepelín de {zone:1454} en la torre del lado oeste de {object:3202}.",
	["Zeppelin tower"] = "Torre del zepelín",

	-- Step 49: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "Tu instructor está en {area:1638}, a un vuelo de {zone:1454}: {npc:3033} (druidas) en {area:1639}, {npc:246344} (paladines). Desde allí, vuela a {area:380}.",

	-- Step 51: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Cabalga al norte por el camino desde {area:380} hasta {area:386}; {npc:3389} vigila desde la loma sobre el agua.",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace
	["for {npc:5395} in {zone:1443}, in the next guide"] = "para {npc:5395} en {zone:1443}, en la próxima guía",

	-- Step 52: Ratchet
	-- {area:380} Crossroads · {area:392} Ratchet
	["Ride back south to the {area:380} and fly to {area:392}."] = "Vuelve al sur hasta {area:380} y vuela a {area:392}.",
	-- {item:3713} Soothing Spices · {zone:1445} Dustwallow Marsh
	["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}, para Jarl \"Ojo de Pantano\" en {zone:1445}",
	-- {zone:1445} Dustwallow Marsh
	["The next guide heads into {zone:1445}."] = "La próxima guía va a {zone:1445}.",

	-- Step 53: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Cabalga al sur por la costa desde {area:392} hasta {area:720}. {npc:6236} está junto a la arena: pisa la rejilla para empezar el combate; los aspirantes llegan de uno en uno y luego {npc:6238} (33).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Lanza Teletransporte: {zone:1450} y toma el vuelo de {npc:11798} a {area:1638}; {npc:3033} te entrena en {area:1639}. Luego vuela a {zone:1454} y toma el zepelín de {zone:1458} en la torre de fuera de la puerta principal.",
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "Cabalga al oeste por el camino; el campamento de Lotwil está en {area:1878}, a medio camino de {area:340}.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Los Coyotes del risco mayores y las Águilas ratoneras gigantes recorren la cuenca al sur de {area:1878}. Los coyotes sueltan tanto las mandíbulas como los colmillos; solo las águilas ratoneras sueltan alas y mollejas.",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Los Elementales de piedra más grandes están en las laderas al noroeste de {area:1878}; cada uno suelta una losa.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}: Actitud rabiosa",
}
