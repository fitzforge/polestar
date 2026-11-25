-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451}: {area:3425}'s quests, to 60."] = "{zone:1451}: las misiones de {area:3425}, hasta el 60.",

	-- Step 1: Innkeeper Vizzie
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {npc:11118} Innkeeper Vizzie
	["Back from {zone:2482} in {area:2255}: {npc:11118}'s mail went astray in the hills east of town, where the Ice Thistle yetis carry it off."] = "De vuelta de {zone:2482} en {area:2255}: el correo de {npc:11118} se perdió en las colinas al este del pueblo, donde se lo llevan los yetis Cardo Nevado.",

	-- Step 2: Missing Mail
	-- {area:2255} Everlook · {item:258323} Missing Mail
	["The Ice Thistle yetis (53-57) in the hills east of {area:2255} carry the {item:258323}: take it from the ones at the edge of the hills."] = "Los yetis Cardo Nevado (53-57) de las colinas al este de {area:2255} llevan el {item:258323}: tómalo de los del borde de las colinas.",

	-- Step 4: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Vuela a {area:541}",
	-- {area:541} Marshal's Refuge · {zone:1449} Un'Goro Crater · {zone:1451} Silithus
	["Fly to {area:541} in {zone:1449}, the way into {zone:1451}."] = "Vuela a {area:541} en {zone:1449}, el camino hacia {zone:1451}.",
	["Maethrya, the Alliance flight master"] = "Maethrya, la maestra de vuelo de la Alianza",

	-- Step 5: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "Hacia {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Ride west from {area:541} to the crater's north-western pass into {zone:1451}."] = "Cabalga al oeste desde {area:541} hasta el paso noroeste del cráter que sube a {zone:1451}.",

	-- Step 6: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["{npc:13220} stands at {area:3077}, where the pass comes out."] = "{npc:13220} está en {area:3077}, donde sale el paso.",

	-- Step 9: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Sigue cabalgando al oeste hasta {area:3425}. {npc:15189} está en el piso de arriba de su edificio: sube por adentro, la flecha no distingue los pisos.",
	-- {npc:15183} Geologist Larksbane
	["{npc:15183}: the tablet fragments come from the Twilight dig"] = "{npc:15183}: los fragmentos de tablilla salen de la excavación Crepuscular",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: his Twilight texts come from the dig"] = "{npc:15306}: sus textos Crepusculares salen de la excavación",

	-- Step 10: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: mata a estos según te los encuentres",
	-- {npc:15185} Brood of Nozdormu
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around.\nCareful: {npc:15185} (62, elite) guard the Caverns of Time's mouth in the south-west, around 21,82: stay out of there."] = "Los asediadores deslizantes excavan en las dunas al noroeste del bastión; los escórpidos Latipiedra y los arácnidos de arena andan por todas partes.\nCuidado: los {npc:15185} (62, élite) custodian la entrada de las Cavernas del Tiempo en el suroeste, alrededor de 21,82: no te acerques ahí.",

	-- Step 11: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "De vuelta a {area:3425}. {npc:15189} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189}, upstairs"] = "{npc:15189}, en el piso de arriba",

	-- Step 12: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["From the hold, west into the sands: Dredge Crushers dig there; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Desde el bastión, al oeste hacia las arenas: allí excavan los trituradores deslizantes; los tenazarios latipiedra, desolladores y acecharrocas cazan en las mismas arenas.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} recorre esta zona: busca dentro del círculo del mapa",

	-- Step 13: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "{npc:15190}, arriba junto a {npc:15189}",
	-- {npc:15181} Commander Mar'alith
	["{npc:15181} (from level 58): Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181} (desde el nivel 58): el campamento de Barbabronce viene después, de camino al sur",

	-- Step 14: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "{area:2742}: mata a estos según te los encuentres",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell · {area:2742} Hive'Ashi · {quest:8308} Brann Bronzebeard's Lost Letter
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Twilight Avengers = {npc:11880} Twilight Avenger · Twilight Flamereavers = {npc:15201} Twilight Flamereaver
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait.\nThe {area:2742} silithids sometimes drop {quest:8308}: keep it for Bronzebeard's Encampment in the south."] = "La excavación del Martillo Crepuscular ocupa la esquina noroeste: hay fragmentos de tablilla en el suelo, y los agitadores sirocosos y estruendores del desierto también los llevan. Cualquier sectario puede soltar un {item:20404}: guarda veinte, diez para {npc:15306} y diez para {npc:15194} más adelante.\nCuidado: consigue los textos de los vengadores Crepusculares y los geoseñores; deja a los flamatracadores Crepusculares (60) y no te acerques a la entrada de la colmena, donde esperan los élites de {area:2742} (59-60).\nLos silítidos de {area:2742} a veces sueltan {quest:8308}: guárdala para el campamento de Barbabronce en el sur.",
	["Twilight's Hammer cultists"] = "Sectarios del Martillo Crepuscular",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "{item:20378}",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Diez más para {quest:8323}",

	-- Step 16: Southwind Village
	["The tortured druids and sentinels haunt the ruined village east of the hold."] = "Los druidas y centinelas torturados rondan el pueblo en ruinas al este del bastión.",

	-- Step 17: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride north-east to {npc:13220} at {area:3077}."] = "Cabalga al noreste hasta {npc:13220} en {area:3077}.",

	-- Step 18: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "La torre de {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga de vuelta al suroeste hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",

	-- Step 19: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {zone:1450} Moonglade
	["{npc:13220}'s next task goes to {zone:1450}: skip it."] = "La siguiente tarea de {npc:13220} va a {zone:1450}: omítela.",

	-- Step 20: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "El ermitaño se esconde entre las rocas al sureste de {area:2738}.",
	["Below ground"] = "Bajo tierra",

	-- Step 21: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Campamento Barbabronce",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "Cabalga al suroeste hasta el campamento de los enanos cerca de las montañas del sur e interroga a {npc:15171} y {npc:15170}. La cartera de {npc:15190} está en la arena al sureste del campamento, donde patrulla Pinzamorten, un escórpido élite: tómala mientras esté lejos.",

	-- Step 22: Brann Bronzebeard's Lost Letter
	-- {area:2742} Hive'Ashi · {npc:15170} Rutgar Glyphshaper
	["From a {area:2742} silithid: for {npc:15170} at Bronzebeard's Encampment"] = "De un silítido de {area:2742}: para {npc:15170} en el campamento de Barbabronce",

	-- Step 24: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["Careful: the Twilight Keepers are level 60: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "Cuidado: los guardianes Crepusculares son de nivel 60: limpia primero a los sectarios alrededor de cada uno y pelea con el guardián con la salud llena.\n{npc:11803} ocupa el campamento de los sectarios en el extremo suroeste.",

	-- Step 25: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp.\nCareful: Mayna is level 60: clear her camp first and fight her at full health."] = "Cabalga al norte por el lado oeste hasta el pequeño campamento de Mayna.\nCuidado: Mayna es de nivel 60: limpia primero su campamento y pelea con ella con la salud al máximo.",

	-- Step 26: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}.\nCareful: Havunth is level 60: clear his camp first and fight him at full health."] = "El campamento de Havunth está justo al oeste de {area:3425}.\nCuidado: Havunth es de nivel 60: limpia primero su campamento y pelea con él con la salud al máximo.",

	-- Step 27: Hermit Ortell
	["Ride back south-east to the hermit."] = "Cabalga de vuelta al sureste hasta el ermitaño.",
	["Hand him the ten texts you kept"] = "Entrégale los diez textos que guardaste",

	-- Step 28: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",

	-- Step 29: Level 60
	["Level 60"] = "Nivel 60",
	-- {area:3425} Cenarion Hold · {area:2057} Scholomance · {area:2279} Stratholme · {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel · {zone:1451} Silithus
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger · Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["{area:3425}'s last hand-ins can leave a player who followed only this route short of 60 (up to about a level for the slowest; most players less).\nWith a group: run the {area:2057} dungeon or the {area:2279} dungeon, in the Plaguelands by {area:3197} and {area:2268}.\nAlone: the Twilight's Hammer camps of {zone:1451}'s north-west (Twilight Avengers 57-59 and Geolords 58-60; leave the Flamereavers, 60) and the Stonelash Flayers and Rock Stalkers (57-59) around {area:3425} are at your level. {area:3425}'s repeatable quests open only at 60."] = "Las últimas entregas de {area:3425} pueden dejar a un jugador que siguió solo esta ruta por debajo de 60 (hasta un nivel para los más lentos; a la mayoría, menos).\nEn grupo: haz la mazmorra {area:2057} o la mazmorra {area:2279}, en las Tierras de la Peste, junto a {area:3197} y {area:2268}.\nSolo: los campamentos del Martillo Crepuscular del noroeste de {zone:1451} (vengadores Crepusculares de 57-59 y geoseñores de 58-60; deja a los flamatracadores, de 60) y los despellejadores Latipiedra y acecharrocas (57-59) alrededor de {area:3425} son de tu nivel. Las misiones repetibles de {area:3425} se abren solo a nivel 60.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal"] = "Ruinas de Andorhal",
	-- ["Angerclaw bears and Felpaw wolves"] = "Osos Zarpira y lobos Zarpayel",
	-- ["Araj is elite: grouping up is advised."] = "Araj es élite: se recomienda ir en grupo.",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "De vuelta en {area:1770}: {npc:9861} y {npc:9860} protegen a {npc:9517} en su cámara más profunda.",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "De vuelta a {area:1770}: {npc:9861} y {npc:9860} protegen a {npc:9517} en su cámara más profunda. La súcubo {npc:9518} espera por el camino, con los restos de Trey Lightforge a su lado.\nCuidado: Los tres jefes pelean en grupo. Mata primero a los enemigos cercanos para no atraer de más.",
	-- ["Boat to {area:150}"] = "Barco a {area:150}",
	-- ["Bring a Silithyst to the Alliance extractor"] = "Lleva un silitista al extractor de la Alianza",
	-- ["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Cuidado: los Caminantes ancestrales Troncoferro, élites de nivel 59, están entre {quest:5086}: encárgate de los Horrores en la punta noreste del campamento (alrededor de 50.6,22.4), de uno en uno, y busca un caminante antes de cada atracción.",
	-- ["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "Cuidado: los guardianes Crepusculares son de nivel 60, uno o dos niveles por encima de ti: limpia primero a los sectarios alrededor de cada uno y pelea con el guardián con la salud al máximo.\n{npc:11803} ocupa el campamento de los sectarios en el extremo suroeste.",
	-- ["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Sube a la colina al oeste de {area:190} para mirar el pueblo desde arriba.\nCuidado: Los centinelas apostados en la puerta pueden detectar a los jugadores en sigilo. Hay más centinelas dentro del pueblo, y un élite patrulla cerca.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Sube a {area:537}, en medio del cráter, y usa {item:14644} junto al lago de lava de la cima, con dos barras de torio en tus bolsas. Llena los tarros de muestras puras vacíos de {npc:9616} con los mocos primigenios de los charcos alrededor de la cresta.",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Cruza el río al este de {npc:1855} hacia {area:2627}. Los Espíritus del Valle del Terror ({npc:14564}) rondan el bosque de allí.",
	-- ["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "Cruza el río al este de la choza de {npc:1855} hasta {area:2627}: {npc:11140} está junto a la choza en ruinas de Augustus.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Los trituradores deslizantes deambulan por las dunas entre {area:2743} y {area:3425}, de camino de vuelta. {npc:15181} solo ofrece {quest:8304} a partir del nivel 58.",
	-- ["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "La siguiente tarea de Flint va a {zone:1453}: ya eres nivel 60, sáltala.",
	-- ["Fly from {area:541} to {area:392}."] = "Vuela desde {area:541} hasta {area:392}.",
	-- ["Fly to {area:150}"] = "Vuela a {area:150}",
	-- ["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- ["Fly to {area:2255}"] = "Vuela a {area:2255}",
	-- ["Fly to {area:271}"] = "Vuela a {area:271}",
	-- ["Fly to {area:3137}"] = "Vuela a {area:3137}",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Vuela a {area:3137} en {area:16} y cabalga al oeste por el camino hasta {area:2358}, justo pasada la frontera de {zone:1440}.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Vuela a {area:3137} en {zone:1447} y cabalga al oeste por el camino hasta {area:2358}, justo pasada la frontera de {zone:1440}.",
	-- ["Fly to {area:3425}"] = "Vuela a {area:3425}",
	-- ["Fly to {area:442}"] = "Vuela a {area:442}",
	-- ["Fly to {area:702}"] = "Vuela a {area:702}",
	-- ["Fly to {area:976}"] = "Vuela a {area:976}",
	-- ["Fly to {area:976}."] = "Vuela a {area:976}.",
	-- ["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Vuela a {area:976}. Compra aquí, en la casa de subastas, dos barras de torio para {quest:5801}.",
	-- ["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- ["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "Sigue el camino al norte hasta {area:1767}. Los vapuleadores Troncoferro llevan el corazón; termina las garras con los pardos Zarpira y los devastadores Zarpayel del norte.\nCuidado: los Caminantes ancestrales Troncoferro, élites de nivel 59, están entre los ents en el centro de {area:1767}: enfréntate a los vapuleadores del lado norte (alrededor de 48,21).",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Sigue el camino al suroeste desde el paso hasta {area:3425}.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Sigue las indicaciones de {npc:9298} hasta la entrada de {area:2256}, pasando a los gigantes Machacahielo: pásalos de uno en uno.",
	-- ["For {npc:10778}: keep it"] = "Para {npc:10778}: guárdala",
	-- ["For {npc:11053} at {area:3197}, at the end of this guide"] = "Para {npc:11053} en {area:3197}, al final de esta guía",
	-- ["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "Desde {area:3137} cabalga hasta {zone:1448}: {area:2479} es el campamento de los druidas en el camino, justo pasando la frontera con {zone:1440}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Baja de vuelta a {area:702}, toma el barco a {area:442} y luego el barco a {area:17203}. Lleva sesenta de paño de seda, sesenta de paño de tejido mágico y sesenta de {item:14047} para {npc:14722}: compra lo que te falte en la casa de subastas.",
	-- ["Grind to 58"] = "Farmea hasta el 58",
	-- ["Grind to 59"] = "Farmea hasta el 59",
	-- ["Grind to 60"] = "Farmea hasta el 60",
	-- ["Havunth's camp sits just west of {area:3425}."] = "El campamento de Havunth está justo al oeste de {area:3425}.",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Usa la piedra de hogar para ir a {area:1519} y entrena tus hechizos de nivel 60. Aquí termina la ruta de subida de nivel: consulta a continuación las guías de reputación y de calabozos.",
	-- ["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Usa la piedra de hogar para ir a {area:392} y vuela a {area:976}. Compra aquí dos barras de torio en la casa de subastas para {quest:5801}.",
	-- ["Inside"] = "Adentro",
	-- ["Irontree Stompers"] = "Vapuleadores Troncoferro",
	-- ["Its jars are filled on the Un'Goro visit"] = "Sus tarros se llenan en la visita a Un'Goro",
	-- ["Keep the {item:11169}, the claws and the heart he hands back"] = "Guarda {item:11169}, las garras y el corazón que te devuelve",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Sigue al oeste por el camino hasta el campamento de {npc:9298} junto a las aguas termales.",
	-- ["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Llévala fuera de {area:1770} y mantenla con vida hasta que esté afuera de la cueva: despeja antes el camino de vuelta.",
	-- ["Learn the flight path in {area:2361}."] = "Aprende la ruta de vuelo en {area:2361}.",
	-- ["Level 59.85"] = "Nivel 59.85",
	-- ["Lots of flying between zones"] = "Muchos vuelos entre zonas",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Recoge los suministros alrededor de la carreta y recupera el amuleto de {npc:10301} de las lechubestias cercanas.",
	-- ["Portal to {zone:1438}"] = "Portal a {zone:1438}",
	-- ["Radley and Durgen"] = "Radley y Durgen",
	-- ["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cabalga de vuelta al este pasando {area:2255} y al sureste valle abajo hasta la caja dañada de {npc:10301}, en la nieve de {area:2245}, con su carromato destrozado justo al este.",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Cabalga de vuelta al norte hasta {area:2255} y al oeste por el camino hasta la aldea elfa de la noche.",
	-- ["Ride back south along the road to the Sanctuary."] = "Cabalga de vuelta al sur por el camino hasta el Santuario.",
	-- ["Ride back south-west to {area:3197}."] = "Cabalga de vuelta al suroeste hasta {area:3197}.",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "Cabalga de vuelta a {area:3137} y vuela a {area:2255}.",
	-- ["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Cabalga al este hacia las colinas. Usa {item:11169} para invocar a {quest:4005} y luego derrótalo para obtener el tótem.",
	-- ["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Cabalga al este hasta las ruinas de {area:2738}. {object:179565} está entre los edificios en ruinas, vigilado por centinelas torturadas.",
	-- ["Ride north along the west side to Mayna's small camp."] = "Cabalga al norte por el lado oeste hasta el pequeño campamento de Mayna.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Cabalga al norte desde {area:415} hacia {zone:1448} hasta el campamento de los druidas en el camino, justo pasada la frontera.",
	-- ["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Cabalga al norte hasta la aldea de los fúrbolgs Muertobosque junto a la entrada de la cueva de {area:1769}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Cabalga al norte hasta el borde noreste de {area:2277}.\nCuidado: Los trols del camino a {area:2273} son de nivel 57-59. Huyen con poca salud y piden ayuda, así que suelen traer enemigos de más.",
	-- ["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Cabalga al norte hasta {area:541}. Usa {npc:10980} junto a {npc:10977}.",
	-- ["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Cabalga al norte por el camino hasta el Aserradero Crestanorte y deja la barrica de termitas en medio.",
	-- ["Ride north up the valley, past {area:2255}, to {area:2253}."] = "Cabalga al norte valle arriba, pasando {area:2255}, hasta {area:2253}.",
	-- ["Ride north-west up the road to {area:2253}."] = "Cabalga al noroeste por el camino hasta {area:2253}.",
	-- ["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "Cabalga al sur saliendo de {zone:1448} hacia {area:3137}: el campamento de {npc:3848} en {area:2358} está justo pasando la frontera de {zone:1440}, de camino.",
	-- ["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "Cabalga al sur hasta {area:2260}, la granja al noroeste de {area:2262}. Los restos de los tres agentes son siluetas de huesos en el suelo: uno junto al camino al sur de la granja, uno en la colina al este de la casa y uno en el montículo frente a ella. Acercarte lo suficiente para ver al Clamañublo frente a la casa completa el reconocimiento.\nCuidado: {npc:11878} (élite de nivel 62) y sus canes élite están frente a la casa: toma los restos del montículo desde un costado y no lo atraigas. No hace falta pelear con él.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Cabalga al sur hasta {area:2250}. Protege a {npc:10300} mientras enciende las antorchas camino de {object:177404}.",
	-- ["Ride south-east from the lake to the chapel."] = "Cabalga al sureste desde el lago hasta la capilla.",
	-- ["Ride south-east to {area:201}: {npc:11078} guards the cauldron, and {item:12955} lies east of the barn."] = "Cabalga al sureste hasta {area:201}: {npc:11078} vigila el caldero, y {item:12955} está al este del granero.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cabalga al suroeste hasta {area:2261}. El montículo de tierra está adentro. {npc:11886} es élite: se recomienda agruparse.\nCuidado: Unos cuatro enemigos no élite vienen con Mercutio. Caminan hasta la tumba en lugar de aparecer en el acto.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en {area:1938}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Cabalga al oeste junto a la pared norte del cráter hasta el paso de la esquina noroeste que sube a {zone:1451}.",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Hacer {area:2057} ({area:2298}, sureste de {area:28}) o {area:2279} en vez de farmear te lleva allí más rápido en grupo. Omite este paso para farmear solo.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Hacer {area:2057} ({area:2298}, sureste de {zone:1422}) o {area:2279} en vez de farmear te lleva allí más rápido en grupo. Omite este paso para farmear solo.",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Hacer {area:2577} en {zone:1444} en vez de farmear te lleva allí más rápido en grupo. Omite este paso para farmear solo.",
	-- ["Scare {npc:10977} with {npc:10980}"] = "Asusta a {npc:10977} con {npc:10980}",
	-- ["Scourge Champions"] = "Campeones de la Plaga ({npc:8529})",
	-- ["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Los campeones de la Plaga (59) deambulan por {area:2270}, al norte de {area:2268}. Pasa el {item:13156} de {npc:11063} sobre cada uno que mates: los cráneos que resuenan son los que quiere. Atráelos de uno en uno.",
	-- ["Shaman training"] = "Entrenamiento de chamán",
	-- ["Stays on the main route"] = "Se mantiene en la ruta principal",
	-- ["Take the boat from {area:442} to {area:702}."] = "Toma el barco de {area:442} a {area:702}.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "Toma la ruta de vuelo en {area:2361} y vuela a {area:442}.",
	-- ["Take the portal up to {zone:1457}."] = "Toma el portal para subir a {zone:1457}.",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Toma el camino al oeste que baja al cráter y cabalga hasta {area:540}, la cueva silítida del sur. {npc:10041} espera en su cámara más profunda.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Toma el túnel de {area:1769} desde su entrada en {area:618}, al oeste de {npc:9298}, y sigue el ramal de {area:493} hasta {area:2361}. {npc:11939} estudia junto a la orilla del lago.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Toma el túnel de {area:1769} desde su entrada en {zone:1452}, al oeste de {npc:9298}, y sigue el ramal de {area:493} hasta {area:2361}. {npc:11939} estudia junto a la orilla del lago.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "Toma el {area:2257} hasta {zone:1455}. {npc:14724} y {npc:14723} aceptan cada uno sesenta de lana, sesenta de seda y sesenta de tejido mágico, y luego sesenta de {item:14047}: entrega lo que tengas (o cómpralo en la casa de subastas) y sáltate el resto.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Toma el {area:2257} a {zone:1455}. {npc:14724} y {npc:14723} quieren cada uno sesenta de paño de lana, sesenta de paño de seda y sesenta de paño de tejido mágico, y luego sesenta de {item:14047}: 120 de cada uno en total, de tus bolsas o de la casa de subastas.",
	-- ["Takes you all the way to 60"] = "Te lleva hasta el nivel 60",
	-- ["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "El tótem Muertobosque de {area:1762}, si {npc:11558} no lo aceptó entonces.",
	-- ["The Terrordale Spirits haunt the woods around {npc:11140}. Top up here to level 59.85 while you stand in {area:2627}: the hand-ins still to come (the {area:2261}, {area:2298}, {npc:10667} and {area:3197}) take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Los espíritus del Valle del Terror rondan el bosque alrededor de {npc:11140}. Completa aquí hasta el nivel 59.85 mientras estés en {area:2627}: las entregas que aún faltan ({area:2261}, {area:2298}, {npc:10667} y {area:3197}) te llevan al nivel 60. O, con un grupo, haz en su lugar la mazmorra {area:2057} o la mazmorra {area:2279}.",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "La excavación del Martillo Crepuscular ocupa la esquina noroeste: hay fragmentos de tablilla en el suelo, y los agitadores sirocosos y estruendores del desierto también los llevan. Cualquier sectario puede soltar un {item:20404}: guarda veinte, diez para {npc:15306} y diez para {npc:15194} más adelante.",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "La excavación del Martillo Crepuscular ocupa la esquina noroeste: hay fragmentos de tablilla en el suelo, y los agitadores sirocosos y estruendores del desierto también los llevan. Cualquier sectario puede soltar un {item:20404}: guarda veinte, diez para {npc:15306} y diez para {npc:15194} más adelante.\nCuidado: consigue los textos de los vengadores Crepusculares y geoseñores; deja a los flamatracadores Crepusculares (60) y no te acerques a la entrada de la colmena, donde esperan los élites de {area:2742} (59-60).",
	-- ["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "El vuelo aterriza en {area:702}. {npc:7916} está a un paseo corto al noroeste del maestro de vuelo.",
	-- ["The lake for {quest:5845}"] = "El lago para {quest:5845}",
	-- ["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "La ruta principal hasta 60: {zone:1451}, {zone:1448}, {zone:1452} y las Tierras de la Peste, con las entregas en {zone:1453}, {zone:1455} y {spell:437801} por el camino.",
	-- ["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Los fúrbolgs Nevada del oeste sueltan las cuentas.\nCuidado: Al entregar aparecen tres o cuatro emboscadores Nevada de nivel 56-57 que te atacan; puedes escaparte montado, en sigilo o con {spell:5384}, y luego se juntan junto al lago para que puedas tomar la siguiente misión.",
	-- ["The {area:2479}"] = "{area:2479}",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Los osos {npc:7446} deambulan por el valle nevado al sur de {area:2250}.",
	-- ["The {quest:5086}"] = "{quest:5086}",
	-- ["Theramore flight master"] = "Maestro de vuelo de Theramore",
	-- ["To {area:392}"] = "A {area:392}",
	-- ["Toward the north-west pass"] = "Hacia el paso del noroeste",
	-- ["Tram to {zone:1455}"] = "Tranvía a {zone:1455}",
	-- ["Underwater"] = "Bajo el agua",
	-- ["Upstairs"] = "Arriba",
	-- ["Use the jars on slain oozes"] = "Usa los tarros en los mocos muertos",
	-- ["Wait a moment for {npc:9116}"] = "Espera un momento a {npc:9116}",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Empiezas en {area:392}, donde la guía anterior te llevó con la piedra de hogar. Vuela a {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "farmea {npc:11741} en las dunas al este de {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "farmea {npc:14564} en {area:2627}, {area:139}",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "farmea {npc:14564} en {area:2627}, {zone:1423}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "farmea {npc:7446} en el valle al sur de {area:2250}, {zone:1452}",
	-- ["{area:150} flight master"] = "Maestro de vuelo de {area:150}",
	-- ["{area:1770} braziers"] = "Braseros de {area:1770}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} es la cueva al fondo de {area:1763}, al oeste del camino. Usa {item:12906} en los cuatro braseros del interior. Mata los osos Zarpira y lobos Zarpayel que encuentres para conseguir {item:11172}.",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "{area:1770} es la cueva del fondo de {area:1763}, al oeste del camino. Usa {item:12906} en los cuatro braseros de adentro. Mata los osos Zarpira y lobos Zarpayel que encuentres para las {item:11172}.\nCuidado: La cueva está llena de enemigos del Consejo de la Sombra de nivel 53-55, que suelen venir en grupos grandes vinculados, muchos con aturdimientos. Se recomienda un grupo de 2-3 jugadores.\nLos tejeoscuros, brujos y déspotas de Jaedenar de aquí sueltan una {item:13140}, más o menos uno de cada treinta: sigue matándolos hasta que caiga. Abre la celda de {npc:11018}, la elfa de la noche retenida en la cueva.",
	-- ["{area:190} overlook"] = "Mirador de {area:190}",
	-- ["{area:2057} (optional)"] = "{area:2057} (opcional)",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} es para niveles 58 a 60; {quest:5505} se entrega en {area:3197}, más abajo.",
	-- ["{area:2255} flight master"] = "Maestro de vuelo de {area:2255}",
	-- ["{area:2577} (optional)"] = "{area:2577} (opcional)",
	-- ["{area:2577} fits levels 55 to 60; alone, the {area:2627} grind at the end of this guide gets you to 60."] = "{area:2577} es para niveles 55 a 60; si vas solo, el farmeo en {area:2627} al final de esta guía te lleva a 60.",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} es para niveles 55 a 60; farmear {npc:7446}, abajo, te lleva solo hasta el 59.",
	-- ["{area:3137} flight master"] = "Maestro de vuelo de {area:3137}",
	-- ["{area:392} flight master"] = "Maestro de vuelo de {area:392}",
	-- ["{area:493} flight path on the way"] = "Ruta de vuelo de {area:493} en el camino",
	-- ["{area:541} flight master"] = "Maestro de vuelo de {area:541}",
	-- ["{area:702} flight master"] = "Maestro de vuelo de {area:702}",
	-- ["{area:976} flight master"] = "Maestro de vuelo de {area:976}",
	-- ["{item:12954}; inside"] = "{item:12954}; adentro",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, de los campeones de la Plaga",
	-- ["{item:14047}, from your bags"] = "{item:14047}, de tus bolsas",
	-- ["{item:2592}, from your bags"] = "{item:2592}, de tus bolsas",
	-- ["{item:4306}, from your bags"] = "{item:4306}, de tus bolsas",
	-- ["{item:4338}, from your bags"] = "{item:4338}, de tus bolsas",
	-- ["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300} espera en {area:2250}, al sur de {area:2255}.\nProtege a {npc:10300} mientras enciende las antorchas de camino a {object:177404}.",
	-- ["{npc:10301}'s camp"] = "El campamento de {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Los suministros de {npc:10301}",
	-- ["{npc:10667} in Andorhal: keep it"] = "{npc:10667} en Andorhal: guárdala",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} espera en la posada en ruinas del lado oeste de las Ruinas de Andorhal, la ciudad en ruinas al norte del campamento. {npc:1852} protege su filacteria en medio del pueblo.",
	-- ["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667} espera en el piso de arriba de la posada en ruinas del lado oeste de Andorhal, de camino de vuelta a {area:3197}.",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}, en el piso de arriba",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "El fantasma de {npc:10778} deambula junto a la granja de {area:199}, al oeste de Andorhal. Los necrófagos farfullantes del campo llevan la otra mitad del amuleto: combina las dos mitades.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn."] = "{npc:10897}, el maestro de vuelo de {area:493}, está al sur del lago, fuera de {area:2361}: aprende la ruta de vuelo con él. La maestra de vuelo de {area:2361} solo lleva a druidas, desde su diálogo, y no tiene ruta de vuelo que aprender.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: termina en {zone:1452}, guárdala",
	-- ["{npc:11016}, in her cell; below ground"] = "{npc:11016}, en su celda; bajo tierra",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, bajo tierra",
	-- ["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "{npc:11038}, junto a las tumbas al sur de la capilla: {npc:11140} está en {area:2627}, guárdala",
	-- ["{npc:11053}: {area:201}'s cauldron, on this loop"] = "{npc:11053}: el caldero de {area:201}, en este recorrido",
	-- ["{npc:11556}'s {quest:8464} waited for this visit: the furbolg village lies just east of {area:2255}, with Shaman (56-57), Den Watchers (55-56) and Ursa (57-58). Kill the Shaman first, they heal. {npc:10738} in the cave at the back is elite: stay out."] = "{quest:8464} de {npc:11556} esperaba esta visita: el poblado furbolg está justo al este de {area:2255}, con chamanes (56-57), vigías de la guarida (55-56) y ursas (57-58). Mata primero a los chamanes, que curan. {npc:10738}, en la cueva del fondo, es élite: no entres.",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, si tienes treinta {quest:6031}",
	-- ["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "{npc:11557}, justo al entrar a la cueva junto a {npc:11558}, acepta treinta {quest:6031} desde Amistoso con los Fauces de Madera: completar nivel en {zone:1452} con los fúrbolgs Nevada te da ambas cosas.",
	-- ["{npc:11557}; below ground"] = "{npc:11557}; bajo tierra",
	-- ["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "{npc:11558} está justo al entrar a la cueva de {area:1769}: te habla desde Neutral con los Fauces de Madera, a lo que te llevaron los fúrbolgs Nevada que mataste en {zone:1452}.",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, justo dentro de la cueva: solo a partir de Neutral con los Fauces de Madera",
	-- ["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}, justo al entrar a la cueva: recorre esta zona: busca dentro del círculo del mapa",
	-- ["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: recorre esta zona: busca dentro del círculo del mapa",
	-- ["{npc:11610} hides at the Northridge lumber camp's edge."] = "{npc:11610} se esconde en el borde del campamento maderero de Crestanorte.",
	-- ["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} se esconde en el borde del campamento maderero.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} recorre el campamento de Crestanorte al este de {npc:11610}; {npc:11611} vigila la torre del acceso sur a {area:190}.\nCuidado: Hay guardias en la base de la torre y uno más da vueltas a su alrededor patrullando. Despéjalos antes de enfrentar a Durgen para que no se sumen.",
	-- ["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "La casa de {npc:11801} está en {area:2361}, al este de {npc:11939}.",
	-- ["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} ocupa el campamento de los sectarios en el extremo suroeste.",
	-- ["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} da vueltas por {area:2361}: búscalo dentro del círculo del mapa",
	-- ["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} acepta sesenta de paño de seda, sesenta de tejido mágico y sesenta de {item:14047}: entrega lo que tengas (o cómpralo en la casa de subastas) y sáltate el resto.",
	-- ["{npc:14722}, in the {object:2096}"] = "{npc:14722}, en {object:2096}",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, el tabernero",
	-- ["{npc:15181}: Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181}: el Campamento de Barbabronce viene después, de camino al sur",
	-- ["{npc:15306}: his Twilight texts come from the dig after the next stop here"] = "{npc:15306}: sus textos Crepusculares salen de la excavación, después de la siguiente parada aquí",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} acampa fuera de {area:2743}, la colmena del oeste. Recoge una silitista en uno de los géiseres rojos cercanos y llévala al extractor de la Alianza en su campamento.",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080} acampa afuera de {area:2743}, la colmena del oeste. Recoge una silitista en uno de los géiseres rojos cercanos y llévala al extractor de la Alianza de su campamento.\nCuidado: Pierdes la silitista si montas, entras en sigilo o usas {spell:642}, {spell:5384} o Desvanecerse. Traslación y {spell:17} no la hacen caer.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, en las tiendas de la Alianza",
	-- ["{npc:17082}, at the Alliance tents: for {npc:17080} at {area:2743}"] = "{npc:17082}, en las tiendas de la Alianza: para {npc:17080} en {area:2743}",
	-- ["{npc:1852} is a level 61 elite"] = "{npc:1852} es un élite de nivel 61",
	-- ["{npc:1855} (optional)"] = "{npc:1855} (opcional)",
	-- ["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} vive en una pequeña choza junto al río fronterizo, al noreste del aserradero. Entrega {quest:5781} si la terminaste.",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, en el IV:7",
	-- ["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, en lo alto de {area:1658}",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, que recorre los canales",
	-- ["{npc:4155}, in the bank"] = "{npc:4155}, en el banco",
	-- ["{npc:5594}, inside"] = "{npc:5594}, adentro",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: la guía anterior te trae aquí con la piedra de hogar, así que esto suele marcarse de inmediato",
	-- ["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} en {zone:1457}: guárdala",
	-- ["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, en el Templo de la Luna",
	-- ["{npc:8496}, inside"] = "{npc:8496}, adentro",
	-- ["{npc:8737}, at the back of the refuge"] = "{npc:8737}, al fondo del refugio",
	-- ["{npc:9116}, inside"] = "{npc:9116}, adentro",
	-- ["{npc:9117}, below ground"] = "{npc:9117}, bajo tierra",
	-- ["{npc:9517}; below ground"] = "{npc:9517}; bajo tierra",
	-- ["{npc:9518}, below ground"] = "{npc:9518}, bajo tierra",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} espera en {area:1767}. Escóltala fuera del bosque y mantenla con vida.",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598} espera en {area:1767}. Escóltala fuera del bosque y mantenla con vida.\nCuidado: Tres {quest:5086} te emboscan poco después de empezar la escolta.",
	-- ["{npc:9616}'s jars went to {zone:1455} on the {zone:1452} guide's {zone:1455} stop: fly straight to {area:976}."] = "Los frascos de {npc:9616} se entregaron en {zone:1455} durante la parada en {zone:1455} de la guía de {zone:1452}: vuela directo a {area:976}.",
	-- ["{npc:9860}, below ground"] = "{npc:9860}, bajo tierra",
	-- ["{npc:9861}, below ground"] = "{npc:9861}, bajo tierra",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}, si encontraste el frasco de aguardiente en {area:618}",
	-- ["{object:176158}, below ground"] = "{object:176158}, bajo tierra",
	-- ["{object:176159}, below ground"] = "{object:176159}, bajo tierra",
	-- ["{object:176160}, below ground"] = "{object:176160}, bajo tierra",
	-- ["{object:176161}, below ground"] = "{object:176161}, bajo tierra",
	-- ["{object:179565}; inside"] = "{object:179565}; adentro",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}: {npc:9298} en {area:618}, guárdala",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} en {zone:1452}, guárdala",
	-- ["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845}: la ruta la toma y consigue el Símbolo, así que su entrega se mantiene",
	-- ["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} en {area:3197}: guárdala",
	-- ["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "{quest:6184}: los restos de los agentes están en {area:2260}, en {zone:1423}",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}, {area:361}, {area:618} y las Tierras de la Peste",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} y las Tierras de la Peste",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands."] = "{zone:1451}, {zone:1448}, {zone:1452} y las Tierras de la Peste.",
	-- ["{zone:1452}: kill these as you meet them"] = "{zone:1452}: mata a estos según te los encuentres",
	-- ["{zone:1453} has no shaman trainer"] = "{zone:1453} no tiene instructor de chamanes",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} no tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455} y entrena tus hechizos de nivel 60 con {npc:258098}.",
	-- ["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",
}
