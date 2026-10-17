-- Spanish (Latin America) (esMX): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Toma el barco de {area:17203} a {area:442}. Une las dos mitades del colgante en el {item:15885} y lanza {spell:18960}: {npc:11802} está en {area:2361}. Luego vuela a {area:702} (pasando por {area:442}).",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885}: une las dos mitades",

	-- Step 2: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Toma el portal para subir a {area:1658} y luego vuela de vuelta a {area:442}.",

	-- Step 3: Elune's Grace
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:11401} Priestess Alathea
	["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Toma el barco de {area:17203} a {area:442} y vuela a {area:702}; {npc:11401} está en el templo de la Luna. Luego vuela de vuelta a {area:442}.",

	-- Step 4: Boat to Auberdine
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "Desde {area:17203} toma el barco a {area:442}; {npc:3649} está en el extremo norte del pueblo. Luego cabalga al sur por el camino a través de {zone:1439}.",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}: Alexston's reply"] = "{npc:3649}: la respuesta de Alexston",

	-- Step 5: Kerlonian Evershade
	-- {area:448} Grove of the Ancients · {zone:1439} Darkshore · {item:13536} Horn of Awakening · {zone:1440} Ashenvale · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Kerlonian duerme en {area:448}, al sur de {zone:1439}. Usa el {item:13536} para despertarlo y llévalo al sur por el camino hasta {zone:1440}, con {npc:11219} en {area:413}; vuelve a tocar el cuerno cada vez que se duerma.",
	-- {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Escort Kerlonian to {area:413} in {zone:1440}."] = "Escolta a Kerlonian hasta {area:413}, en {zone:1440}.",

	-- Step 7: Bathran's Haunt
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Al norte de Atalaya de Maestra hay manojos de plantas alrededor de las ruinas de {area:411}. Los cultores de la Facción Oscura ocupan las ruinas justo al sur: cualquiera puede soltar la {item:5366}.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, de los manojos de plantas",

	-- Step 9: Astranaar
	-- {area:415} Astranaar
	["Follow the road south-east to {area:415}, on the island in the lake."] = "Sigue el camino al sureste hasta {area:415}, en la isla del lago.",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, en la posada",

	-- Step 10: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Cabalga al oeste hasta la orilla de {area:441}. Teronis yace entre los múrlocs Gapo Salino; cualquier múrloc puede soltar la {item:5463}.",

	-- Step 11: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Al sur de los múrlocs, {npc:3585} espera en {area:416}.",

	-- Step 12: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} y sus abisarios ocupan {area:412}, al sur del santuario. Atrae primero a sus guardias.",

	-- Step 13: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Sigue la costa al norte hasta {area:414}. {npc:3846} acampa en la playa; las nagas Colafuria llenan la orilla.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, en las ruinas de la orilla",

	-- Step 15: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} recorre el extremo norte de {area:414} con guardias Colafuria.",

	-- Step 19: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) dirige a los gnolls en el campamento al norte de {area:415}. Acaba primero con sus guardias, de uno en uno.",

	-- Step 20: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "Las lágrimas brillan en el islote al este de {area:415}.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Sigue el camino al este hasta {area:419}; {npc:3916} está junto al pozo de la luna.",

	-- Step 23: The Foulweald
	["The Foulweald"] = "Los Maderiza",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Los fúrbolgs Maderiza viven en el bosque al sur del camino, al sureste de {area:415}. El Vigía del cubil y las Ursas protegen la guarida.",

	-- Step 24: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} está en {area:420}, en la orilla este de {area:421}; {npc:210995} acampa en la orilla oeste. Los Elementales de agua podrida ({npc:3917}) vadean el lago entre ambos.",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Mata a los elementales hasta tener 5 Brazales elementales intactos ({item:12220}) y luego usa el {item:5456}",

	-- Step 25: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "Al oeste del Lago Mystral, los arbustos de polvo estelar crecen entre las ruinas.",

	-- Step 27: Windshear Crag
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Cabalga al sur pasando {area:421} hasta el túnel de {area:1276}; sale en {area:461}, en la Sierra Espolón. {npc:4080} y {npc:4077} acampan en {area:1076}, al suroeste del risco.",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, in the hut north of them"] = "{npc:4201}, en la choza al norte de ellos",

	-- Step 28: Venture Co. loggers
	["Venture Co. loggers"] = "Madereros de Ventura y Cía.",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "Ventura y Cía. tala el bosque de {area:461}. Madereros y Deforestadores trabajan por todas partes; los Operadores manejan las trituradoras y uno lleva los planos.",

	-- Step 29: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} extrae mineral en {area:2160}, en el extremo este del risco. Habla con él y rechaza a los asaltantes de Ventura y Cía. mientras trabaja.",

	-- Step 31: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "A {area:150}",
	-- {area:1276} Talondeep Path
	["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "¿Tu piedra de hogar está en tiempo de reutilización? Cabalga de vuelta al norte por {area:1276}.",
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",

	-- Step 32: Menethil Harbor
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, en el muelle al norte de la posada",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, en la posada",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep"] = "{npc:2086}, junto al castillo",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}, junto a la puerta norte",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}, junto a la puerta norte",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, junto a la puerta norte",

	-- Step 33: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Hay pilas de madera y de hierro alrededor del castillo y a lo largo de las murallas del puerto.",

	-- Step 35: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Sigue la costa al norte saliendo de Menethil. Los Múrlocs Branquiazul ({npc:1024}) llenan el pantano; {npc:1259} camina con un grupo en medio de él.",

	-- Step 37: The Bluegill hovels
	["The Bluegill hovels"] = "Las chozas Branquiazul",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Tres contenedores en las chozas múrloc, de sur a norte: {object:261}, luego {object:142151} y luego {object:259}, en el extremo norte.",

	-- Step 38: Karl Boran
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: para {npc:2104}, en el castillo",

	-- Step 39: Captain Stoutfist
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} está en {area:2103}, a poca distancia de {npc:1242}.",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Para Bolvar Fordragón en {object:2117}: guárdalo",

	-- Step 40: Young crocolisks
	["Young crocolisks"] = "Crocoliscos jóvenes",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Sigue el camino al este. Los Crocoliscos jóvenes de Los Humedales ({npc:1417}) acechan en las charcas al norte de la excavación.",

	-- Step 41: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "La excavación está en la colina al sur del camino.",

	-- Step 42: The raptor hills
	["The raptor hills"] = "Las colinas de los raptores",
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor
	["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Los Raptores jaspeados ({npc:1020}) y los Estridadores jaspeados recorren las colinas al oeste de la excavación.",

	-- Step 44: Raptor valley
	["Raptor valley"] = "El valle de los raptores",
	["The bigger raptors hunt in the valley just west of the dig."] = "Los raptores más grandes cazan en el valle justo al oeste de la excavación.",

	-- Step 46: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Los Acechadores de cuevas ({npc:4040}) y los Acechadores sanguijuela ({npc:1111}) llenan {area:1021}, la cueva al sureste de la excavación.",

	-- Step 47: Black Oozes
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes"] = "Mocos negros ({npc:1032})",
	-- {area:1025} Green Belt · {npc:2093} Einar Stonegrip · {npc:2111} Sida
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Los Mocos negros ({npc:1032}) se arrastran por el pantano al norte del camino de {area:1025}, al oeste del campamento de {npc:2093}. Cualquier moco puede tener la bolsa de {npc:2111}.",

	-- Step 48: Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} acampa junto al camino; {npc:1244} está más al este, junto al río.",

	-- Step 49: The Mosshide gnolls
	["The Mosshide gnolls"] = "Los gnolls Pellejomusgo",
	-- {area:1025} Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Los Gnolls Pellejomusgo ({npc:1007}) y los Bastardos Pellejomusgo ocupan las colinas al sureste de {area:1025}.",

	-- Step 51: Crude Flint
	-- {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Los Correpantanos Pellejomusgo ({npc:1010}) y los Tejebruma Pellejomusgo recorren las orillas del río justo al oeste y al sur de {npc:1244}; casi todos sueltan pedernal.",

	-- Step 53: Fen Creepers
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers"] = "Trepadores del pantano ({npc:1040})",
	-- {area:1025} Green Belt
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Los Trepadores del pantano ({npc:1040}) se esconden en las charcas al noroeste de {area:1025}.",

	-- Step 54: Dun Modr
	-- {area:205} Dun Modr · {area:881} Thandol Span · {npc:1071} Longbraid the Grim
	["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Sigue el camino al norte hasta {area:205}, al pie de {area:881}. {npc:1071} está en el campamento de los enanos.",

	-- Step 56: Dragonmaw camp
	["Dragonmaw camp"] = "Campamento Faucedraco",
	-- {area:1025} Green Belt · {npc:2092} Pilot Longbeard · {zone:1426} Dun Morogh
	["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "El campamento Faucedraco está al sur del camino, justo al oeste de {area:1025}: Asaltantes, Correpantanos y Guardahuesos. La misión de {npc:2092} en {zone:1426} requiere nivel 28.",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Raiders = {npc:1034} Dragonmaw Raider
	["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "mata Asaltantes Faucedraco ({npc:1034}) y Correpantanos en el campamento Faucedraco, {zone:1437}",

	-- Step 57: Hearth to Menethil
	["Hearth to Menethil"] = "Piedra de hogar a Menethil",
	["For the giant crocolisks of the north coast, on your next visit"] = "Para los crocoliscos gigantes de la costa norte, en tu próxima visita",

	-- Step 58: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Cabalga al este por el camino de {zone:1437}, al sur por {area:836} hasta {zone:1432} y al oeste por el túnel hasta {zone:1426}, hasta {area:1537}.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, en {object:32372}",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Solo con {item:5352} de {zone:1439}: {npc:2786}, {object:32383}",

	-- Step 59: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Sacerdotes de {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} y {npc:258785} están en {object:32386}, en {object:32362}.",

	-- Step 60: Cathedral of Light
	["Cathedral of Light"] = "La catedral",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Toma {area:2257} desde {object:171524} hasta {object:28027} de {zone:1453} y luego camina hasta {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, en la catedral",
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}, en {object:2098}",

	-- Step 61: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}, en la biblioteca real",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Solo si obtuviste {quest:337} en {zone:1431}",

	-- Step 62: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "De vuelta a la catedral: {npc:928} está dentro.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Para {npc:2228} en {area:271}: guárdalo",

	-- Step 63: Mage Quarter
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164} está en {object:2101}.",

	-- Step 64: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} y {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la quesería de {object:2096}",

	-- Step 65: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Siguiente: vuela a {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Sigue la costa al norte hasta {area:414}. {npc:3846} acampa en la playa; las nagas Colafuria llenan la orilla.",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} recorre el extremo norte de {area:414} con guardias Colafuria.",
}
