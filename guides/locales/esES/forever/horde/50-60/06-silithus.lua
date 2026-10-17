-- Spanish (Spain) (esES): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "El paso desde Un'Goro sale en {area:3077}, el cementerio del noreste de {zone:1451}. {npc:13220} está entre las tumbas.",

	-- Step 2: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. El {object:179565} para {npc:11801} está dentro de una de las casas en ruinas.",

	-- Step 4: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Vuelve a Viento del Sur y sube a la torre. Al remover la colmena de la cima salen Emboscadores Colmen'Ashi; uno lleva el {item:17346}.",

	-- Step 5: Cenarion Hold
	["Ride west to the walled hold in the middle of the desert."] = "Cabalga al oeste hasta el fuerte amurallado del centro del desierto.",

	-- Step 6: Dredge and scorpids
	["Dredge and scorpids"] = "Arrastres y escórpidos",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Los Artilleros de arrastre, los Escórpidos Latigosólido y los Arácnidos de arena comparten la arena justo al norte del fuerte.",

	-- Step 7: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Los fragmentos de tablilla brillantes están alrededor del campamento Crepuscular del extremo noroeste; los Sirocosos y Estruendores del desierto de allí también los sueltan.",

	-- Step 9: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Cabalga al sureste hasta {area:3447}, bajo los acantilados de Un'Goro.",

	-- Step 10: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Cabalga al oeste hasta el campamento de la Horda al norte de {area:2744}.",

	-- Step 11: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Los Géiseres de silitista brotan por todo el desierto del sur. Pisa el silitista que deja uno y llévalo al extractor de silitista de la Horda, en el campamento de la General Kirika; si luchas o montas, lo sueltas.",

	-- Step 12: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Cazadores y Acechadores de piedra",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Los Cazadores Latigosólido y los Acechadores de piedra recorren las dunas al suroeste del campamento de Kirika.",

	-- Step 13: Twilight Vanguard
	["Twilight Vanguard"] = "Vanguardia Crepuscular",
	-- {npc:11803} Twilight Keeper Exeter · {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} recorre el campamento de la Vanguardia del extremo suroeste. Todos los fieles de aquí sueltan Textos crepusculares codificados, tengas la misión o no: reúne veinte, diez para {npc:15306} y diez para el Ermitaño Ortell.",

	-- Step 14: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Trituradores y Tenazarios",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Ve al norte por las dunas del oeste; los Trituradores de arrastre y los Tnazarios Latigosólido se extienden desde aquí hasta el fuerte.",

	-- Step 15: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} ocupa el campamento del oeste.",

	-- Step 16: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} está en el puesto al oeste de {area:3425}. Completa hasta veinte Textos crepusculares codificados con los fieles de aquí.",

	-- Step 17: Cenarion Hold
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, en el lado oeste del Fuerte",

	-- Step 18: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "La bolsa está en las montañas del extremo sur, pasado el Campamento Barbabronce. Pinzamorten, un escórpido élite, patrulla cerca: cógela cuando se aleje.",

	-- Step 19: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Cabalga al noreste hasta {area:3447}.",
	["The spare texts from the cultists"] = "Los textos sobrantes de los fieles",

	-- Step 20: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Vuelve a {area:3425}",
	-- {area:2744} Hive'Regal
	["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Queridísima Natalia, de Mar'alith, requiere nivel 58 y te lleva a {area:2744} entre élites. Sáltatela.",

	-- Step 21: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Cabalga al noreste hasta {area:3077}; sales de {zone:1451} por el paso que hay al lado.",

	-- Step 22: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Cruza el paso y ve al este por los acantilados del norte hasta {area:541}. {npc:8737} está junto a la cueva; {npc:9117} está dentro.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Usa {npc:10980} con {npc:10977}",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Guarda {quest:3942}: {npc:9116} está en {area:2479}, de camino por {zone:1448} en la siguiente guía.",

	-- Step 23: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Vuela a {area:976}. El {object:142071} está en el centro del pueblo.",

	-- Step 24: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} and train."] = "Vuela a {area:1637} y entrena.",

	-- Step 25: The Undercity
	-- {area:1637} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Toma el zepelín de la torre de las afueras de {area:1637} a {zone:1420} y cabalga hasta {zone:1458}. Lady Sylvanas Brisaveloz está en el {object:36126}.",

	-- Step 26: The Bulwark
	-- {area:152} The Bulwark
	["Ride east along the road to the {area:152} on the border."] = "Cabalga al este por el camino hasta {area:152}, en la frontera.",

	-- Step 27: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La granja de {npc:10778} es la primera al este de {area:152}. Los Necrófagos farfullantes de la granja llevan la otra mitad de su amuleto; {npc:11075} vigila la caldera del campo.",

	-- Step 28: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Atalayas y silos de Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Cabalga al sur hasta Andorhal. {npc:10667} espera en la posada en ruinas del oeste del pueblo. Ponte en la entrada de cada una de las cuatro torres con la {item:12815} para marcarla; ve por los bordes del pueblo. Usa el {item:12627} junto a los silos del centro del pueblo para hacer salir a los Parásitos temporales.",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca {npc:10904} con la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca {npc:10903} con la {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca {npc:10902} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca {npc:10905} con la {item:12815}",

	-- Step 29: The Bulwark
	-- {item:14619} Skeletal Fragments · {quest:838} Scholomance
	["Dithers offers {item:14619} ({quest:838}). Skip it."] = "El Boticario Dithers ofrece {item:14619} ({quest:838}). Sáltatela.",

	-- Step 30: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Al este por el camino, {npc:11077} vigila la caldera de {area:200}.",

	-- Step 31: Northridge Lumber Camp
	["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Al norte, hasta el campamento maderero; deja el barril de termitas en el centro del aserradero.",

	-- Step 32: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "El libram está más al norte, de camino a {area:190}.",

	-- Step 33: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Cabalga al este hasta la cabaña de {npc:1855} junto al {area:2619} y escúchalo.",

	-- Step 34: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "El escudo está en {area:201}, al sur de la cabaña de {npc:1855}.",

	-- Step 35: Light's Hope Chapel
	["Ride east across the plaguelands to the chapel."] = "Cabalga al este cruzando las Tierras de la Peste hasta la capilla.",

	-- Step 36: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeones de la Plaga",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Los Campeones de la Plaga recorren {area:2270}, al norte de la capilla. Pasa el {item:13156} de {npc:11063} sobre cada uno que mates: las calaveras que resuenan son las que quiere.",

	-- Step 38: Pamela Redpath and the Undercroft
	-- {npc:10926} Pamela Redpath · {area:2261} Undercroft
	["{npc:10926} and the {area:2261}"] = "{npc:10926} y {area:2261}",
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Cabalga hasta {area:2262}, al suroeste; {npc:10926} juega entre las casas. {npc:11886} acecha en {area:2261}, la cripta justo al oeste del pueblo.",
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s own errand is not on this route. Skip it."] = "El encargo propio de {npc:10926} no está en esta ruta. Sáltatelo.",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}.",
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}' errands are not on this route. Skip them."] = "Los encargos de {npc:11878} no están en esta ruta. Sáltatelos.",

	-- Step 40: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Cabalga al noroeste hasta la cabaña de {npc:1855}.",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "La siguiente tarea de {npc:1855}, Del honor perdido, no está en esta ruta. Sáltatela.",

	-- Step 41: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Cabalga al suroeste hasta {npc:10667}, en Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "La Batalla de Villa Darrow, de {npc:10667}, termina contra élites. Sáltatela.",

	-- Step 42: The Bulwark
	-- {area:152} The Bulwark · {zone:1458} Undercity
	["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Al oeste, hasta {area:152}. La siguiente guía empieza en {zone:1458}, a poca distancia al oeste.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride east along the road to the {area:152} on the border."] = "Cabalga al este por el camino hasta {area:152}, en la frontera.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Al oeste, hasta {area:152}. La siguiente guía empieza en {zone:1458}, a poca distancia al oeste.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La granja de {npc:10778} es la primera al este de {area:152}. Los Necrófagos farfullantes de la granja llevan la otra mitad de su amuleto; {npc:11075} vigila la caldera del campo.",
}
