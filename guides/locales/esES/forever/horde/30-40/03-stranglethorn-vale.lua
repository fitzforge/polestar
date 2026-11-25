-- Spanish (Spain) (esES): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Vuela de {area:2408} a {area:1638} y entrena con {npc:3033} en {area:1639}; desde allí, sigue volando a {zone:1454}.",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "Vuelve a {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "{npc:5640} está en {object:172961}, en el lado oeste de la ciudad.",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Instructores de {zone:1454}",
	["Train while you are in the city."] = "Entrena mientras estás en la ciudad.",

	-- Step 6: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["{area:35} first: the goblins' boat sails there from {area:392}, and every {area:35} quest is for the north of the vale, which you then walk up into."] = "Primero {area:35}: el barco de los goblins zarpa hacia allí desde {area:392}, y todas las misiones de {area:35} son para el norte de la vega, hacia donde luego subes a pie.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 7: Ratchet
	-- {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["{npc:3391} waits upstairs in the house by the flight master; {quest:1111} stands on the docks, beside the boat."] = "{npc:3391} espera en el piso de arriba de la casa junto al maestro de vuelo; {quest:1111} está en los muelles, junto al barco.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, en el piso de arriba",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631} in {area:35}, where the boat goes"] = "{npc:3391}: para {npc:4631} en {area:35}, adonde va el barco",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}, en los muelles",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "Las piezas de Dizzywig vuelven a Kravel en {area:439}, fuera de la ruta: déjalas.",

	-- Step 8: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",

	-- Step 9: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil · {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:2858} Gringer
	["{npc:4631} stands on the pier where the boat docks. {npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs, {npc:2858} the flight master on the upper deck."] = "{npc:4631} está en el embarcadero donde atraca el barco. La tienda de {npc:2495} está en el edificio al este de la posada; {npc:2498} está en la planta baja de la posada, {npc:2496}, {npc:737} y {npc:773} en el piso de arriba, y {npc:2858}, el maestro de vuelo, en la plataforma superior.",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the pier"] = "{npc:4631}, en el embarcadero",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, dentro",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "{npc:2498}, adentro, en la planta baja",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}, en el piso de arriba",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, en el piso de arriba",

	-- Step 10: Grom'gol
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Leave {area:35} through the tunnel and follow the road north to {object:3202}, the orc camp on the west side of the vale. Stay on the road: the jungle beside it is above your level."] = "Sal de {area:35} por el túnel y sigue el camino hacia el norte hasta {object:3202}, el campamento orco en el lado oeste de la vega. No te salgas del camino: la selva de alrededor está por encima de tu nivel.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: para las Tierras Altas de Arathi, más adelante en la ruta",

	-- Step 11: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Hemet Decautela",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:773} Krazek · {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. {npc:773} wants it investigated: walk among its tents. From here on, keep every page of The {item:2755} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "Sigue el camino hacia el norte desde {object:3202}; el campamento de caza de Hemet Decautela está en la colina al noreste del río. {npc:773} quiere que lo investigues: camina entre sus tiendas. A partir de aquí, guarda cada página de {item:2755} que consigas: {npc:716} las recoge en tu próxima visita a Tuercespina.",

	-- Step 12: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}: mátalos según te los encuentres",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Los crocoliscos fluviales están a lo largo del río, bajo el campamento. Los tigres de Tuercespina jóvenes merodean al oeste del campamento, y las panteras jóvenes al este. Ve hacia el oeste pasado el campamento. Los raptores de Tuercespina (33-34) cazan en los claros, y los trols Cabellesangre ocupan las ruinas de la costa: cualquier Cabellesangre puede soltar un colmillo. Un {item:4614} es un botín muy raro de ellos: si te sale uno, léelo. Cuidado: los campamentos trols tienen muchos enemigos patrullando, así que a menudo se unen otros trols al combate.",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: mata a estos según te los encuentres",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent
	["Stranglethorn Tigers (32) roam the hills west of the camp and east of it toward the lake: the arrow takes the eastern ones, on your way to the geologists. Panthers (32) roam the clearings west and south-west of the camp. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "Los tigres de Tuercespina (32) recorren las colinas al oeste del campamento y al este de este hacia el lago: la flecha lleva a los del este, de camino a los geólogos. Las panteras (32) recorren los claros al oeste y suroeste del campamento. Los geólogos de la Compañía de Ventura (34-36), que llevan los cristales caídos, trabajan en los campamentos de {area:37}, al sureste del campamento. Cuidado: los agentes de la Compañía de Ventura (39) están entre los geólogos de los campamentos del oeste, junto a la casa de la Compañía: trabaja en los campamentos del este, lejos de ellos.",
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["Tumbled Crystals, from the geologists of the eastern camps"] = "Cristales caídos, de los geólogos de los campamentos del este",

	-- Step 15: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Las Panteras Faucesombría llegan mucho más tarde, junto a {object:3202}",

	-- Step 16: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "Tigres de Tuercespina mayores",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "Los Tigres de Tuercespina mayores (34-35) recorren las colinas al suroeste del campamento. Cuidado: los campamentos trols están cerca de la zona de los tigres, y los trols pueden unirse a la pelea si atraes sin cuidado.",

	-- Step 17: Nesingwary's camp
	["Back north to the camp."] = "Vuelve al norte, al campamento.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}: {npc:729} (37) comes at the end of this guide, from level 36"] = "",

	-- Step 18: Thoroughly Scavenged Supplies
	-- {object:661516} Thoroughly Scavenged Supplies (no name in this language: may be words) · {quest:97328} Anything of Value · {area:102} Ruins of Zul'Kunda
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["On the walk west from Nesingwary's camp, a pile of {object:661516} lies by the path: it starts {quest:97328}, whose Stolen Shipments lie in the {area:102} on the coast ahead."] = "De camino al oeste desde el campamento de Nesingwary, hay un montón de {object:661516} junto al camino: inicia {quest:97328}, cuyos envíos robados están en {area:102}, en la costa más adelante.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}: mátalos según te los encuentres",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	-- was: ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and the 40-50 Stranglethorn guide comes back to him.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Al oeste pasado el campamento, hay basiliscos Espina de Cristal (34-35) sobre las rocas; cualquier Cabellesangre del poblado de más allá puede soltar una oreja.\nDeja por ahora a {npc:729}, el tigre de nivel 37 en la colina al suroeste del campamento: aquí te saca dos niveles, y la guía de Tuercespina 40-50 vuelve a por él.\nCuidado: el nido de raptores tiene raptores jóvenes que se unen al combate cuando atacas a los adultos."
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and this guide comes back to him at its end, from level 36.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 20: Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark · {area:102} Ruins of Zul'Kunda · {item:277957} Primitive Key · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Scouts = {npc:588} Bloodscalp Scout · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["{npc:268992} is held at the east edge of the {area:102}; the Stolen Shipments lie among the ruins around him. The Bloodscalp Scouts, Hunters and Mystics (34-35) there carry his {item:277957}: {npc:4631} in {area:35} takes the shipments.\nCareful: Bloodscalp Berserkers and Headhunters (36-37) and Witch Doctors (37, casters) hold the ruins north and west of {npc:268992}, close to the northern shipments (around 24.9,9.6): pick the shipments in the southern ruins by {npc:268992} first, and pull one at a time if you go north."] = "{npc:268992} está retenido en el borde este de {area:102}; los cargamentos robados están entre las ruinas a su alrededor. Los exploradores, cazadores y místicos Cabellera Sangrienta (34-35) de allí llevan su {item:277957}: {npc:4631} en {area:35} recibe los cargamentos.\nCuidado: los rabiosos y cazacabezas Cabellera Sangrienta (36-37) y los médicos brujos (37, lanzadores) ocupan las ruinas al norte y al oeste de {npc:268992}, cerca de los cargamentos del norte (hacia 24.9,9.6): recoge primero los cargamentos de las ruinas del sur junto a {npc:268992}, y atrae de uno en uno si vas al norte.",
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["Stolen Shipments, in the ruins"] = "Envíos robados, en las ruinas",
	-- {item:277957} Primitive Key
	-- plural, as words: Bloodscalp Scouts = {npc:588} Bloodscalp Scout
	["{item:277957}, from the Bloodscalp Scouts, Hunters and Mystics"] = "{item:277957}, de los exploradores, cazadores y místicos Cabellesangre",

	-- Step 21: Escort Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992}"] = "Escolta a {npc:268992}",
	-- {npc:268992} Zimmix Sputterspark
	["Lead {npc:268992} out of the ruins and keep him alive: Lozgil takes the news once he is safe."] = "Saca a {npc:268992} de las ruinas y mantenlo con vida: Lozgil recibe la noticia cuando esté a salvo.",
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992} out of the ruins and keep him alive: Lozgil takes the news once he is safe."] = "Escolta a {npc:268992} fuera de las ruinas y mantenlo con vida: Lozgil recibe la noticia cuando esté a salvo.",

	-- Step 23: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Raptores colazote",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor · Carnivorous Weeds = {npc:269175} Carnivorous Weed
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}. Careful: the 36s can be two over you: pull them one at a time. Carnivorous Weeds (36-38) are rooted in the jungle south of the raptors: walk around them."] = "De vuelta al sur hacia {object:3202}, los raptores colazote (35-36) cazan en la selva entre el campamento y {object:3202}: cuentan para Hemet y para {npc:2464}. Cuidado: los de 36 pueden sacarte dos niveles: atráelos de uno en uno. Las malas hierbas carnívoras (36-38) están enraizadas en la selva al sur de los raptores: rodéalas.",

	-- Step 24: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464} está en el centro de {object:3202}, {npc:2497} cerca de la torre del zepelín y {npc:2465} junto al maestro de vuelo.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "{npc:2465}: las garras de Faucesombría y el colmillo de tigresa vienen al final de esta guía",

	-- Step 25: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maestro de vuelo de {object:3202}",

	-- Step 26: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:4631} Wharfmaster Lozgil
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master. {npc:4631} stands on the pier."] = "La tienda de {npc:2495} está en el edificio al este de la posada; {npc:2498} está en la planta baja de la posada, y {npc:2496}, {npc:737} y {npc:773} en el piso de arriba, junto al maestro de vuelo. {npc:4631} está en el muelle.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, dentro",
	-- {npc:4631} Wharfmaster Lozgil
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{npc:4631}, on the pier: the Stolen Shipments"] = "{npc:4631}, en el muelle: los envíos robados",
	-- {npc:4631} Wharfmaster Lozgil · {npc:268992} Zimmix Sputterspark
	["{npc:4631}: {npc:268992} is safe"] = "{npc:4631}: {npc:268992} está a salvo",

	-- Step 27: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 28: Level 35
	["Level 35"] = "Nivel 35",
	-- {quest:629} The Vile Reef · {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter · Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:629}'s and Zul'Kunda's quests are next, with Bloodscalp Headhunters of 36-37. Still below 35 after {area:35}'s hand-ins? The Elder Stranglethorn Tigers (34-35) roam the hills north of {object:3202}, below Nesingwary's camp: kill them until level 35. The Lashtail Raptors (35-36) beside them are a level higher."] = "Ahora tocan {quest:629} y las misiones de Zul'Kunda, con Rebanacabezas Cabellesangre de nivel 36-37. ¿Sigues por debajo del 35 tras las entregas de {area:35}? Los tigres de Tuercespina mayores (34-35) merodean por las colinas al norte de {object:3202}, bajo el campamento de Hemet: mátalos hasta el nivel 35. Los raptores colazote (35-36) de al lado son un nivel más altos.",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "mata {npc:1085}",

	-- Step 29: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Al noroeste de Campamento Grom'gol, {area:104} está bajo el agua, frente a la costa. {item:4094} reposa en el fondo del mar junto a las ruinas hundidas; vigila tu respiración y a los múrlocs.",
	["Underwater"] = "Bajo el agua",

	-- Step 30: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}: mátalos según te los encuentres",
	-- {item:3915} Bloody Bone Necklace · {item:2755} Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads. Careful: the 37s can be two over you: pull them one at a time from the village's edge, never into the middle with the Witch Doctors.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of The {item:2755}."] = "Los Rebanacabezas Cabellesangre (36-37) del poblado de la costa llevan las cabezas reducidas. Cuidado: los de nivel 37 pueden estar dos niveles por encima de ti: atráelos de uno en uno desde el borde del poblado, nunca al centro con los médicos brujos.\nLos trols Cabellesangre ocupan las ruinas costa arriba, al norte del arrecife, y el poblado de más allá; cualquiera puede soltar un {item:3915}. Sigue guardando páginas de {item:2755}.",

	-- Step 32: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them; the 38s can be two over you: pull them one at a time and leave the Elders alone."] = "Al este de las colinas Mosh'Ogg, las panteras Faucesombría (37-38) acechan en la selva hacia el lago; las tigresas de Tuercespina merodean por la misma zona y a veces sueltan un colmillo impecable. Los crocoliscos Quijaforte bordean el río justo al oeste de la selva; guarda sus pieles para {npc:2495}. Cuidado: las panteras Faucesombría (nivel 37-38) y las panteras Faucesombría viejas (nivel 42-43) usan Acechar fuera de combate, así que están ocultas hasta que te acercas; las de 38 pueden estar dos niveles por encima de ti: atráelas de una en una y deja en paz a las viejas.",

	-- Step 33: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Campamento Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time. Careful: the 37s can be two over you: take them from the camp's western edge, never two together."] = "Los ogros Mosh'Ogg acampan en las colinas justo al este de {object:3202}, de camino de vuelta. Mata a 10 toscos y 5 médicos brujos (36-37); atráelos de uno en uno. Cuidado: los de nivel 37 pueden estar dos niveles por encima de ti: atácalos desde el borde oeste del campamento, nunca dos a la vez.",

	-- Step 34: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "De vuelta a {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["{npc:2465}: for the {zone:1434} & {zone:1435} guide, at about 40"] = "",
	-- {npc:2497} Nimboya · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["{npc:2497}: for the {zone:1434} & {zone:1435} guide, at about 40"] = "",
	-- {npc:729} Sin'Dall · {zone:1454} Orgrimmar
	-- was: ["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "La siguiente guía toma el zepelín a {zone:1454} desde la torre del lado oeste del campamento."
	["After {npc:729}, back here: the next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "",

	-- Step 35: Level 36
	["Level 36"] = "Nivel 36",
	-- {npc:729} Sin'Dall · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	-- was: ["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36, then walk back to the zeppelin tower. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "Las misiones de Marjal Revolcafango son de nivel 35-38. ¿Sigues por debajo del 36 tras las entregas de {object:3202}? Los crocoliscos Quijaforte (35-36) bordean el río justo al este del campamento, bajo las colinas Mosh'Ogg: mátalos hasta el nivel 36 y luego vuelve a pie a la torre del zepelín. Deja en paz a los ogros Mosh'Ogg (36-37) de arriba."
	["Dustwallow's quests are 35-38, and {npc:729} (37) is next. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Crocoliscos Quijaforte",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "mata {npc:1152}",

	-- Step 36: Sin'Dall
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:729} Sin'Dall
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["North from {object:3202} to the hilltop just south-west of Nesingwary's camp: {npc:729} prowls there alone.\nCareful: {npc:729} (37) is a level over you: pull him at full health, clear of the Elder Stranglethorn Tigers (34-35) on the hill's slopes."] = "",

	-- Step 37: Nesingwary's camp
	-- {npc:717} Ajeck Rouack · {object:3202} Grom'gol (no name in this language: may be words)
	["North to {npc:717} in Nesingwary's camp, then back south to {object:3202}'s zeppelin tower."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36, then walk back to the zeppelin tower. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "Las misiones de Marjal Revolcafango son de nivel 35-38. ¿Sigues por debajo del 36 tras las entregas de {object:3202}? Los crocoliscos Quijaforte (35-36) bordean el río justo al este del campamento, bajo las colinas Mosh'Ogg: mátalos hasta el nivel 36 y luego vuelve a pie a la torre del zepelín. Deja en paz a los ogros Mosh'Ogg (36-37) de arriba.",
	-- ["Elder tigers and Lashtail raptors"] = "Tigres mayores y raptores colazote",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Sigue el camino hacia el norte desde {object:3202}; el campamento de caza de Hemet Decautela está en la colina al noreste del río. A partir de aquí, guarda cada página de {quest:338} que consigas: {npc:716} te las pedirá más adelante.",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Sigue el camino hacia el sur hasta {area:35}, en el extremo sur de la vega, y entra por el túnel de los acantilados. No te salgas del camino: la selva de alrededor está muy por encima de tu nivel. {npc:2858}, el maestro de vuelo de la Horda, espera en la plataforma superior.",
	-- ["Green Hills pages"] = "Páginas de Las verdes colinas",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Las páginas de {item:2755} caen con un 1% aprox. cada una de los trols Cabellesangre y Machacacráneos; guarda cada página que consigas y busca el resto en la casa de subastas. {npc:716} recoge los capítulos más adelante en esta guía.",
	-- ["Shadowmaw panthers"] = "Panteras Faucesombría",
	-- ["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "Los tigres de Tuercespina (32) merodean por las colinas alrededor del campamento y al sur, y las panteras (32) por los claros al oeste y suroeste. Los geólogos de Ventura y Cía. (34-36), que llevan los cristales caídos, trabajan en los campamentos junto a {area:37}, al sureste del campamento. Cuidado: hay agentes de Ventura y Cía. (39) entre los geólogos de los campamentos occidentales, junto a la casa de Ventura y Cía.: ve a los campamentos del este, lejos de ellos.",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Los raptores colazote (35-36) cazan en la selva justo al noreste de {object:3202}.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "Los ogros Mosh'Ogg acampan en las colinas justo al este de {object:3202}, de camino de vuelta. Mata a 10 toscos Mosh'Ogg y 5 médicos brujos Mosh'Ogg (36-37); atráelos de uno en uno.",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Las panteras Faucesombría (37-38) acechan en la selva al este de las colinas Mosh'Ogg y al noreste, hacia el lago; atacan desde el sigilo. Recoge cada página de Las verdes colinas de Tuercespina que encuentres por el camino.",
	-- ["The camp by the river"] = "El campamento junto al río",
	-- ["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "La siguiente guía toma el zepelín a {zone:1454} desde la torre del lado oeste del campamento.",
	-- ["Venture Co. camp"] = "Campamento de Ventura y Cía.",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and the 40-50 Stranglethorn guide comes back to him.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Al oeste pasado el campamento, hay basiliscos Espina de Cristal (34-35) sobre las rocas; cualquier Cabellesangre del poblado de más allá puede soltar una oreja.\nDeja por ahora a {npc:729}, el tigre de nivel 37 en la colina al suroeste del campamento: aquí te saca dos niveles, y la guía de Tuercespina 40-50 vuelve a por él.\nCuidado: el nido de raptores tiene raptores jóvenes que se unen al combate cuando atacas a los adultos.",
	-- ["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",
	-- ["from {npc:4723}"] = "de {npc:4723}",
	-- ["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",
	-- ["{item:5852}, in {object:20691}"] = "{item:5852}, en {object:20691}",
	-- ["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2465}: para forever/horde/40-50/01-stranglethorn-vale",
	-- ["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "La tienda de {npc:2495} está en el edificio al este de la posada; {npc:2498} está en la planta baja de la posada, y {npc:2496}, {npc:737} y {npc:773} en el piso de arriba, junto al maestro de vuelo.",
	-- ["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496}: el baúl de Cozzle está en {area:37}, más adelante en esta guía",
	-- ["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496}: para Pozzik en {area:2240}, de camino a {zone:1446} hacia el nivel 43",
	-- ["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2497}: para forever/horde/40-50/01-stranglethorn-vale",
	-- ["{npc:268992} is held at the east edge of the {area:102}; the Stolen Shipments lie among the ruins around him. The Bloodscalp Scouts, Hunters and Mystics (34-35) there carry his {item:277957}. Then lead him out of the ruins: {npc:4631} in {area:35} takes the news and the shipments.\nCareful: Bloodscalp Berserkers and Headhunters (36-37) and Witch Doctors (37, casters) hold the ruins north and west of {npc:268992}, close to the northern shipments (around 24.9,9.6): pick the shipments in the southern ruins by {npc:268992} first, and pull one at a time if you go north."] = "{npc:268992} está retenido en el borde este de {area:102}; los envíos robados están entre las ruinas a su alrededor. Los exploradores, cazadores y místicos Cabellesangre (34-35) de allí llevan su {item:277957}. Después sácalo de las ruinas: {npc:4631}, en {area:35}, recibe la noticia y los envíos.\nCuidado: los rabiosos y cazacabezas Cabellesangre (36-37) y los médicos brujos (37, lanzadores) ocupan las ruinas al norte y oeste de {npc:268992}, cerca de los envíos del norte (hacia 24.9,9.6): recoge primero los envíos de las ruinas del sur junto a {npc:268992}, y atrae de uno en uno si vas al norte.",
	-- ["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}. Careful: Venture Co. Agents (39) stand in and around the house: clear the doorway before you go in."] = "{npc:4723} (38) está dentro de la casa de Ventura y Cía. en la orilla oeste de {area:37}, entre los geólogos: su llave abre {object:20691} en la misma casa, que contiene los planos para {npc:2496}. Cuidado: hay agentes de Ventura y Cía. (39) dentro y alrededor de la casa: despeja la entrada antes de entrar.",
	-- ["{npc:717}: {npc:729} (37) waits for your next Nesingwary stop, at about 40 in forever/horde/40-50/01-stranglethorn-vale"] = "{npc:717}: {npc:729} (37) espera a tu próxima parada con Nesingwary, hacia el nivel 40 en forever/horde/40-50/01-stranglethorn-vale",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "El campamento de los cazadores desaparecidos de {npc:773} es el de Hemet Decautela: camina entre sus tiendas y la investigación se completa. Los crocoliscos fluviales están a lo largo del río, bajo el campamento.",
}
