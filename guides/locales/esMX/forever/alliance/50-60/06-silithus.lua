-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} y las Tierras de la Peste",

	-- Step 1: Astranaar
	-- {area:392} Ratchet · {area:415} Astranaar
	["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Empiezas en {area:392}, donde la guía anterior te llevó con la piedra de hogar. Vuela a {area:415}.",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:415} Astranaar · {zone:1448} Felwood
	["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Cabalga al norte desde {area:415} hacia {zone:1448} hasta el campamento de los druidas en el camino, justo pasada la frontera.",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Espera un momento a {npc:9116}",
	-- {npc:10924} Ivy Leafrunner · {zone:1452} Winterspring
	["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: termina en {zone:1452}, guárdala",

	-- Step 3: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} es la cueva al fondo de {area:1763}, al oeste del camino. Usa {item:12906} en los cuatro braseros del interior. Mata los osos Zarpira y lobos Zarpayel que encuentres para conseguir {item:11172}.",
	["Angerclaw bears and Felpaw wolves"] = "Osos Zarpira y lobos Zarpayel",

	-- Step 5: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "De vuelta en {area:1770}: {npc:9861} y {npc:9860} protegen a {npc:9517} en su cámara más profunda.",

	-- Step 6: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Sigue el camino al norte hasta {area:1767}. Los vapuleadores Troncoferro llevan el corazón; termina las garras con los pardos Zarpira y los devastadores Zarpayel del norte.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Vapuleadores Troncoferro",

	-- Step 7: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} espera en {area:1767}. Escóltala fuera del bosque y mantenla con vida.",

	-- Step 8: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Cabalga al norte hasta la aldea de los fúrbolgs Muertobosque junto a la entrada de la cueva de {area:1769}.",
	-- {object:176091} Deadwood Cauldron · {zone:1452} Winterspring
	["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, si encontraste el frasco de aguardiente en {zone:1452}",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} en {zone:1452}, guárdala",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, justo dentro de la cueva: solo a partir de Neutral con los Fauces de Madera",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, si tienes treinta {quest:6031}",

	-- Step 9: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Cabalga de vuelta al sur por el camino hasta el Santuario.",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Guarda {item:11169}, las garras y el corazón que te devuelve",

	-- Step 10: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Usa la piedra de hogar para ir a {area:392} y vuela a {area:976}. Compra aquí dos barras de torio en la casa de subastas para {quest:5801}.",

	-- Step 11: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Cabalga al este hacia las colinas. Usa {item:11169} para invocar a {quest:4005} y luego derrótalo para obtener el tótem.",

	-- Step 12: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en {area:1938}.",

	-- Step 13: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Toma el camino al oeste que baja al cráter y cabalga hasta {area:540}, la cueva silítida del sur. {npc:10041} espera en su cámara más profunda.",

	-- Step 14: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Sube a {area:537}, en medio del cráter, y usa {item:14644} junto al lago de lava de la cima, con dos barras de torio en tus bolsas. Llena los tarros de muestras puras vacíos de {npc:9616} con los mocos primigenios de los charcos alrededor de la cresta.",
	["Use the jars on slain oozes"] = "Usa los tarros en los mocos muertos",

	-- Step 15: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Cabalga al norte hasta {area:541}. Usa {npc:10980} junto a {npc:10977}.",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, al fondo del refugio",

	-- Step 16: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "Hacia {zone:1451}",
	-- {zone:1451} Silithus
	["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Cabalga al oeste junto a la pared norte del cráter hasta el paso de la esquina noroeste que sube a {zone:1451}.",
	["Toward the north-west pass"] = "Hacia el paso del noroeste",

	-- Step 17: Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Follow the road south-west out of the pass to {area:3425}."] = "Sigue el camino al suroeste desde el paso hasta {area:3425}.",
	-- {npc:15174} Calandrath
	["{npc:15174}, the innkeeper"] = "{npc:15174}, el tabernero",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}, en las tiendas de la Alianza",

	-- Step 18: The Twilight Base Camp
	-- {area:2739} Twilight Base Camp
	["The {area:2739}"] = "{area:2739}",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "La excavación del Martillo Crepuscular ocupa la esquina noroeste: hay fragmentos de tablilla en el suelo, y los agitadores sirocosos y estruendores del desierto también los llevan. Cualquier sectario puede soltar un {item:20404}: guarda veinte, diez para {npc:15306} y diez para {npc:15194} más adelante.",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "{item:20378}",
	["Twilight's Hammer cultists"] = "Sectarios del Martillo Crepuscular",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Diez más para {quest:8323}",

	-- Step 19: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} acampa fuera de {area:2743}, la colmena del oeste. Recoge una silitista en uno de los géiseres rojos cercanos y llévala al extractor de la Alianza en su campamento.",

	-- Step 20: Grind to 58
	["Grind to 58"] = "Farmea hasta el 58",
	-- {area:2743} Hive'Zora · {area:3425} Cenarion Hold · {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Los trituradores deslizantes deambulan por las dunas entre {area:2743} y {area:3425}, de camino de vuelta. {npc:15181} solo ofrece {quest:8304} a partir del nivel 58.",
	-- {npc:11741} Dredge Crusher · {area:2743} Hive'Zora · {zone:1451} Silithus
	["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "farmea {npc:11741} en las dunas al este de {area:2743}, {zone:1451}",

	-- Step 22: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Cabalga al este hasta las ruinas de {area:2738}. {object:179565} está entre los edificios en ruinas, vigilado por centinelas torturadas.",

	-- Step 23: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "El ermitaño se esconde entre las rocas al sureste de {area:2738}.",

	-- Step 24: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Campamento Barbabronce",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Cabalga al suroeste hasta el campamento de los enanos cerca de las montañas del sur e interroga a {npc:15171} y {npc:15170}. La cartera de {npc:15190} está en la arena justo al sureste del campamento.",

	-- Step 25: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} ocupa el campamento de los sectarios en el extremo suroeste.",

	-- Step 26: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Cabalga al norte por el lado oeste hasta el pequeño campamento de Mayna.",

	-- Step 27: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "El campamento de Havunth está justo al oeste de {area:3425}.",

	-- Step 29: Hermit Ortell
	["Ride back south-east to the hermit."] = "Cabalga de vuelta al sureste hasta el ermitaño.",
	["Hand him the ten texts you kept"] = "Entrégale los diez textos que guardaste",

	-- Step 31: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Vuela a {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} en {zone:1457}: guárdala",

	-- Step 32: Forest Song
	-- {area:3137} Talrendis Point · {zone:1447} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Vuela a {area:3137} en {zone:1447} y cabalga al oeste por el camino hasta {area:2358}, justo pasada la frontera de {zone:1440}.",

	-- Step 33: Everlook
	-- {area:3137} Talrendis Point · {area:2255} Everlook
	["Ride back to {area:3137} and fly to {area:2255}."] = "Cabalga de vuelta a {area:3137} y vuela a {area:2255}.",

	-- Step 34: Ranshalla
	-- {area:2250} Owl Wing Thicket · {npc:10300} Ranshalla · {object:177404} Altar of Elune (no name in this language: may be words)
	["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Cabalga al sur hasta {area:2250}. Protege a {npc:10300} mientras enciende las antorchas camino de {object:177404}.",

	-- Step 35: Dire Maul (optional)
	-- {area:2577} Dire Maul
	["{area:2577} (optional)"] = "{area:2577} (opcional)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Hacer {area:2577} en {zone:1444} en vez de farmear te lleva allí más rápido en grupo. Omite este paso para farmear solo.",
	-- {area:2577} Dire Maul · {npc:7446} Rabid Shardtooth
	["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} es para niveles 55 a 60; farmear {npc:7446}, abajo, te lleva solo hasta el 59.",

	-- Step 36: Grind to 59
	["Grind to 59"] = "Farmea hasta el 59",
	-- {npc:7446} Rabid Shardtooth · {area:2250} Owl Wing Thicket
	["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Los osos {npc:7446} deambulan por el valle nevado al sur de {area:2250}.",
	-- {npc:7446} Rabid Shardtooth · {area:2250} Owl Wing Thicket · {zone:1452} Winterspring
	["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "farmea {npc:7446} en el valle al sur de {area:2250}, {zone:1452}",

	-- Step 37: Starfall Village
	-- {area:2255} Everlook
	["Ride back north to {area:2255} and west along the road to the night elf village."] = "Cabalga de vuelta al norte hasta {area:2255} y al oeste por el camino hasta la aldea elfa de la noche.",

	-- Step 38: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Sigue al oeste por el camino hasta el campamento de {npc:9298} junto a las aguas termales.",

	-- Step 39: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Toma el túnel de {area:1769} desde su entrada en {zone:1452}, al oeste de {npc:9298}, y sigue el ramal de {area:493} hasta {area:2361}. {npc:11939} estudia junto a la orilla del lago.",

	-- Step 40: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "La casa de {npc:11801} está en {area:2361}, al este de {npc:11939}.",

	-- Step 42: Nighthaven
	-- {area:2361} Nighthaven · {area:442} Auberdine
	["Take the flight path in {area:2361} and fly to {area:442}."] = "Toma la ruta de vuelo en {area:2361} y vuela a {area:442}.",

	-- Step 43: Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["Take the boat from {area:442} to {area:702}."] = "Toma el barco de {area:442} a {area:702}.",

	-- Step 44: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Toma el portal para subir a {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, en el Templo de la Luna",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, en el banco",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, en lo alto de {area:1658}",

	-- Step 45: Stormwind
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {item:14047} Runecloth · {npc:14722} Clavicus Knavingham
	["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Baja de vuelta a {area:702}, toma el barco a {area:442} y luego el barco a {area:17203}. Lleva sesenta de paño de seda, sesenta de paño de tejido mágico y sesenta de {item:14047} para {npc:14722}: compra lo que te falte en la casa de subastas.",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District (no name in this language: may be words)
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, en {object:2096}",

	-- Step 46: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Toma el {area:2257} a {zone:1455}. {npc:14724} y {npc:14723} quieren cada uno sesenta de paño de lana, sesenta de paño de seda y sesenta de paño de tejido mágico, y luego sesenta de {item:14047}: 120 de cada uno en total, de tus bolsas o de la casa de subastas.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} no tiene instructor de chamanes",

	-- Step 47: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} es un élite de nivel 61",

	-- Step 48: Andorhal
	["Andorhal"] = "Ruinas de Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} espera en la posada en ruinas del lado oeste de las Ruinas de Andorhal, la ciudad en ruinas al norte del campamento. {npc:1852} protege su filacteria en medio del pueblo.",
	["Araj is elite: grouping up is advised."] = "Araj es élite: se recomienda ir en grupo.",

	-- Step 49: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "El fantasma de {npc:10778} deambula junto a la granja de {area:199}, al oeste de Andorhal. Los necrófagos farfullantes del campo llevan la otra mitad del amuleto: combina las dos mitades.",

	-- Step 50: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Cabalga al norte por el camino hasta el Aserradero Crestanorte y deja la barrica de termitas en medio.",

	-- Step 51: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (opcional)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} vive en una pequeña choza junto al río fronterizo, al noreste del aserradero. Entrega {quest:5781} si la terminaste.",

	-- Step 52: Scholomance (optional)
	-- {area:2057} Scholomance
	["{area:2057} (optional)"] = "{area:2057} (opcional)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Hacer {area:2057} ({area:2298}, sureste de {zone:1422}) o {area:2279} en vez de farmear te lleva allí más rápido en grupo. Omite este paso para farmear solo.",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} es para niveles 58 a 60; {quest:5505} se entrega en {area:3197}, más abajo.",

	-- Step 53: Grind to 60
	["Grind to 60"] = "Farmea hasta el 60",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Cruza el río al este de {npc:1855} hacia {area:2627}. Los Espíritus del Valle del Terror ({npc:14564}) rondan el bosque de allí.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "farmea {npc:14564} en {area:2627}, {zone:1423}",

	-- Step 54: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Cabalga de vuelta al suroeste hasta {area:3197}.",

	-- Step 55: Level 60
	["Level 60"] = "Nivel 60",
	-- {area:1519} Stormwind
	["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Usa la piedra de hogar para ir a {area:1519} y entrena tus hechizos de nivel 60. Aquí termina la ruta de subida de nivel: consulta a continuación las guías de reputación y de calabozos.",

	-- Step 56: Shaman training
	["Shaman training"] = "Entrenamiento de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District (no name in this language: may be words) · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} no tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455} y entrena tus hechizos de nivel 60 con {npc:258098}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Toma el camino al oeste que baja al cráter y cabalga hasta {area:540}, la cueva silítida del sur. {npc:10041} espera en su cámara más profunda.",
}
