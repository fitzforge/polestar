-- Spanish (Latin America) (esMX): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Vuela de {area:2408} a {area:1638} y entrena con {npc:3033} en {area:1639}; desde allí vuela a {zone:1454}.",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "De vuelta a {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

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
	["{area:35} first: the goblins' boat sails there from {area:392}, and every {area:35} quest is for the north of the vale, which you then walk up into."] = "Primero {area:35}: el barco de los goblins zarpa hacia allá desde {area:392}, y todas las misiones de {area:35} son para el norte de la vega, hacia donde luego subes a pie.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 7: Ratchet
	-- {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["{npc:3391} waits upstairs in the house by the flight master; {quest:1111} stands on the docks, beside the boat."] = "{npc:3391} espera en el piso de arriba de la casa junto al maestro de vuelo; {quest:1111} está en los muelles, junto al barco.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, arriba",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631} in {area:35}, where the boat goes"] = "{npc:3391}: para {npc:4631} en {area:35}, adonde va el barco",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}, en los muelles",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "Las piezas de Dizzywig se entregan a Kravel en {area:439}, fuera de la ruta: déjalas.",

	-- Step 8: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",

	-- Step 9: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil · {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:2858} Gringer
	["{npc:4631} stands on the pier where the boat docks. {npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs, {npc:2858} the flight master on the upper deck."] = "{npc:4631} está en el muelle donde atraca el barco. La tienda de {npc:2495} está en el edificio al este de la posada; {npc:2498} está en la planta baja de la posada, {npc:2496}, {npc:737} y {npc:773} arriba, y {npc:2858}, el maestro de vuelo, en la cubierta superior.",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the pier"] = "{npc:4631}, en el muelle",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "{npc:2498}, adentro, en el piso inferior",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}, arriba",
	-- {npc:2496} Baron Revilgaz · {area:37} Lake Nazferiti
	["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496}: el baúl de Cozzle está en {area:37}, más adelante en esta guía",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",

	-- Step 10: Grom'gol
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Leave {area:35} through the tunnel and follow the road north to {object:3202}, the orc camp on the west side of the vale. Stay on the road: the jungle beside it is above your level."] = "Sal de {area:35} por el túnel y sigue el camino al norte hasta {object:3202}, el campamento orco en el lado oeste de la vega. No salgas del camino: la selva a los lados está por encima de tu nivel.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: para Tierras Altas de Arathi, más adelante en la ruta",

	-- Step 11: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Nesingwary",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:773} Krazek · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. {npc:773} wants it investigated: walk among its tents. From here on, keep every page of {quest:338} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "Sigue el camino al norte desde {object:3202}; el campamento de caza de Nesingwary está en la colina al noreste del río. {npc:773} quiere que lo investigues: camina entre sus tiendas. Desde aquí, guarda cada página de {quest:338} que saquees: {npc:716} las recibe en tu próxima visita a Tuercespina.",

	-- Step 12: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}: mátalos cuando te los encuentres",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Los Crocoliscos fluviales están a lo largo del río bajo el campamento. Los Tigres de Tuercespina jóvenes merodean al oeste del campamento y las Panteras jóvenes al este. Ve al oeste pasando el campamento. Los Raptores de Tuercespina (33-34) cazan en los claros, y los trols Sangrapellejo ocupan las ruinas de la costa: cualquier Sangrapellejo puede soltar un colmillo. El {item:4614} es un botín muy raro de ellos: si te cae, léelo. Cuidado: los campamentos trols tienen muchos enemigos patrullando, así que otros trols suelen unirse a la pelea.",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp."] = "Los Tigres de Tuercespina (32) rondan las colinas alrededor del campamento y al sur de él, las Panteras (32) los claros al oeste y suroeste. Los Geólogos de Ventura y Cía., que llevan los Cristales caídos, trabajan en los campamentos junto a {area:37}, al sureste del campamento.",

	-- Step 15: Cozzle's Footlocker
	-- {npc:4723} Foreman Cozzle · {area:37} Lake Nazferiti · {object:20691} Cozzle's Footlocker · {npc:2496} Baron Revilgaz
	["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}."] = "{npc:4723} (38) está dentro de la casa de Ventura y Cía. en la orilla oeste de {area:37}, entre los geólogos: su llave abre {object:20691} en la misma casa, que contiene los planos para {npc:2496}.",
	-- {npc:4723} Foreman Cozzle
	["from {npc:4723}"] = "de {npc:4723}",
	-- {item:5852} Fuel Regulator Blueprints · {object:20691} Cozzle's Footlocker
	["{item:5852}, in {object:20691}"] = "{item:5852}, en {object:20691}",

	-- Step 16: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Las panteras Faucesombría llegan mucho más tarde, junto a {object:3202}",

	-- Step 17: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "Tigres de Tuercespina mayores",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "Los Tigres de Tuercespina mayores (34-35) rondan las colinas al suroeste del campamento. Cuidado: hay campamentos de trols cerca de la zona de los tigres, y los trols pueden unirse a la pelea si atraes sin cuidado.",

	-- Step 18: Nesingwary's camp
	["Back north to the camp."] = "Regresa al norte, al campamento.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Al oeste, pasando el campamento, los Basiliscos Espina de Cristal (34-35) descansan en las rocas; cada Cuero Sangriento de la aldea más allá puede soltar una oreja.\n{npc:729}, un tigre de nivel 37, ronda la cima de la colina al suroeste del campamento.\nCuidado: el nido de raptores tiene raptores jóvenes que se unen a la pelea cuando atacas a los adultos.",

	-- Step 21: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Raptores colazote",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}."] = "De regreso al sur hacia {object:3202}, los Raptores colazote (35-36) cazan en la jungla entre el campamento y {object:3202}: cuentan para Hemet y para {npc:2464}.",

	-- Step 22: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464} está en el centro de {object:3202}, {npc:2497} cerca de la torre del zepelín y {npc:2465} junto al maestro de vuelo.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "{npc:2465}: las garras de Faucesombra y el colmillo de la tigresa se entregan al final de esta guía",

	-- Step 23: Level 35
	["Level 35"] = "Nivel 35",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words) · {area:796} Scarlet Monastery
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{area:35}'s and {object:3202}'s next quests are 35-38. Still below 35 after Aggro'gosh's hand-in? The Lashtail Raptors (35) hunt the jungle just north of {object:3202}: kill them until level 35. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "Las siguientes misiones de {area:35} y {object:3202} son de nivel 35-38. ¿Aún menos de 35 después de la entrega de Aggro'gosh? Los Raptores colazote (35) cazan en la jungla justo al norte de {object:3202}: mátalos hasta el nivel 35. O, con un grupo, haz el calabozo {area:796} (Biblioteca o Armería).",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "mata criaturas para subir de nivel con {npc:686}",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "",

	-- Step 25: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "La tienda de {npc:2495} está en el edificio al este de la posada; {npc:2498} está en la planta baja de la posada, y {npc:2496}, {npc:737} y {npc:773} arriba, junto al maestro de vuelo.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496}: para Pozzik en {area:2240}, de camino a {zone:1446} alrededor del nivel 43",

	-- Step 26: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 27: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Al noroeste de Campamento Grom'gol, {area:104} está bajo el agua frente a la costa. El {item:4094} descansa en el fondo del mar junto a las ruinas hundidas; cuida tu respiración y a los múrlocs.",
	["Underwater"] = "",

	-- Step 28: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}: mátalos cuando te los encuentres",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Los Rebanacabezas Sangrapellejo (36-37) en la aldea de la costa llevan las cabezas reducidas.\nLos trols Cuero Sangriento ocupan las ruinas costa arriba al norte del arrecife y la aldea más allá; cualquiera puede soltar {item:3915}. Sigue saqueando páginas de {quest:338}.",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "Al este de las colinas Mosh'Ogg, las Panteras Faucesombría (37-38) acechan la jungla hacia el lago; las Tigresas de Tuercespina rondan el mismo terreno y de vez en cuando sueltan un colmillo impecable. Los Crocoliscos Quijaforte se alinean en el río justo al oeste de la jungla; guarda sus pieles para {npc:2495}. Cuidado: las Panteras Faucesombría (nivel 37-38) y las Panteras Faucesombría viejas (nivel 42-43) usan Sigilo fuera de combate, así que permanecen ocultas hasta que te acercas.",

	-- Step 31: Green Hills pages
	["Green Hills pages"] = "Páginas de Las verdes colinas",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters on your next Stranglethorn visit, at about 40."] = "Las páginas de {item:2755} caen aproximadamente al 1% cada una de los trols Cuero Sangriento y Rompecráneos; guarda cada página que saquees y busca el resto en la casa de subastas. {npc:716} recibe los capítulos en tu próxima visita a Vega de Tuercespina, a nivel 40 aproximadamente.",

	-- Step 32: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Campamento Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "Los ogros Mosh'Ogg acampan en las colinas justo al este de {object:3202}, de camino de regreso. Mata 10 Brutos y 5 Brujos (36-37); atráelos de uno en uno.",

	-- Step 33: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "De vuelta a {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2465}: para forever/horde/40-50/01-stranglethorn-vale",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2497}: para forever/horde/40-50/01-stranglethorn-vale",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "La siguiente guía toma el zepelín a {zone:1454} desde la torre en el lado oeste del campamento.",

	-- Step 34: Level 36
	["Level 36"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Mosh'Ogg Brutes and Witch Doctors camp in the hills just east of the camp: kill them until level 36, pulling one at a time, then walk back to the zeppelin tower. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "Las misiones de Marjal Revolcafango son de nivel 35-38. ¿Aún menos de 36 después de las entregas de {object:3202}? Los Toscos Mosh'Ogg y Brujos acampan en las colinas justo al este del campamento: mátalos hasta el nivel 36, atrayéndolos de uno en uno, y luego regresa a pie a la torre del zepelín. O, con un grupo, haz el calabozo {area:796} (Armería) o el calabozo {area:1316}.",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "mata criaturas para subir de nivel con {npc:1142}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Elder tigers and Lashtail raptors"] = "Tigres mayores y raptores colazote",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Sigue el camino al norte desde {object:3202}; el campamento de caza de Nesingwary está en la colina al noreste del río. Desde aquí, guarda cada página de {quest:338} que saquees: {npc:716} te las pide después.",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Sigue el camino al sur hasta {area:35}, en la punta sur de la vega, y entra por el túnel de los acantilados. No salgas del camino: la selva a los lados está muy por encima de tu nivel. {npc:2858}, el maestro de vuelo de la Horda, espera en la cubierta superior.",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Las páginas de {item:2755} caen con un 1% cada una de los trols Sangrapellejo y Machacacráneos; guarda cada página que saquees y busca el resto en la casa de subastas. {npc:716} recibe los capítulos más adelante en esta guía.",
	-- ["Shadowmaw panthers"] = "Panteras Faucesombría",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Los Raptores colazote (35-36) cazan en la selva justo al noreste de {object:3202}.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Los ogros Mosh'Ogg acampan en las colinas justo al este de {object:3202}. Mata a un Tosco y a un Médico brujo (36-37); atráelos de uno en uno.",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Las Panteras Faucesombría (37-38) acechan en la selva al este de las colinas Mosh'Ogg y al noreste hacia el lago; atacan desde el sigilo. Saquea toda página de Las verdes colinas que encuentres en el camino.",
	-- ["The camp by the river"] = "El campamento junto al río",
	-- ["The zeppelin lands at the tower on the west side of the camp."] = "El zepelín aterriza en la torre del lado oeste del campamento.",
	-- ["Venture Co. camp"] = "Campamento de Ventura y Cía.",
	-- ["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "El campamento de los cazadores desaparecidos de {npc:773} es el de Nesingwary: camina entre sus tiendas y la investigación se completa. Los Crocoliscos fluviales están a lo largo del río bajo el campamento.",
}
