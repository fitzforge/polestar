-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Acampa junto a {area:202}, al sureste de {area:200}.",
	["Inside"] = "Adentro",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "Lobos malsanos",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "Los lobos deambulan por los campos entre Andorhal, {area:200} y {area:202}. Termínalos en el camino de vuelta al este. Cuidado: los más grandes son de nivel 54: atráelos de uno en uno.",

	-- Step 3: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Granja de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "El diario está en la granja, el armario está dentro y el retrete está detrás. Un {npc:10816} lleva la llave del retrete; {npc:10836} sale cuando abres el retrete y lleva la llave del armario.",

	-- Step 4: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands guide's sweep at about 55."] = "",

	-- Step 6: High Executor Derrington
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "No hiciste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.\nToma una {object:176092} del cajón junto a Derrington para {quest:5096}.",

	-- Step 7: Scarlet forward camp
	["Scarlet forward camp"] = "Campamento avanzado Escarlata",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Desde {area:152}, sigue el camino al este hacia {zone:1422}. Las tiendas de la Cruzada Escarlata están justo pasando la Granja Piedramácula, entre {area:199} y {area:200}. Quema la tienda de mando con {object:176092} y planta el estandarte de la Plaga. Cuidado: los Escarlata alrededor de las tiendas llegan al nivel 54 y los invocadores lanzan hechizos: entra por el lado más cercano a la tienda de mando y deja en paz a los demás.",

	-- Step 8: The Bulwark
	-- {area:152} The Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Cabalga al suroeste pasando la granja de Piedramácula y sigue el camino al oeste de vuelta a {area:152}.",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "Las atalayas de Derrington y la caldera de Vandis se hacen en una visita posterior: guárdalas.",

	-- Step 10: Paladin trainer
	["Paladin trainer"] = "Instructor de paladines",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152} en {zone:1420}; {zone:1454} no tiene instructor de paladines",

	-- Step 11: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 12: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "El centro de {zone:1454}",

	-- Step 13: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659} recibe las garras de ravasaurio de Un'Goro; está en {object:172960}, a poca distancia del centro de la ciudad.",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 14: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Vuela a {area:1237}",
	-- {zone:1447} Azshara · {zone:1454} Orgrimmar
	["{zone:1447} is a short flight from {zone:1454}: its quests are 51-55, at your level now."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 15: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, una varita de los arcanistas elfos de sangre",

	-- Step 16: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: mata a estos según te los encuentres",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Cabalga al este hasta las ruinas de la costa. Las cuatro tablillas están entre las ruinas, custodiadas por nagas Látigo de Ira (52-55): atráelos de uno en uno.",

	-- Step 17: Ruins of Eldarath
	-- {area:1231} Southridge Beach
	["Fill Cuely's four vials at the tide pools on the shore, from {area:1231} north up the coast; Spitelash naga patrol between them."] = "",
	-- {item:10691} Filled Vial Labeled #1 · {area:1231} Southridge Beach
	["{item:10691}: the tide pool on {area:1231}"] = "",
	["#2, north along the shore"] = "",

	-- Step 18: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Excavadores Makrinni",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Los Excavadores Makrinni (50-51) cavan en la arena justo al este de las ruinas, de camino al noreste; ellos y los alijos enterrados allí sueltan los Fragmentos de tesoro Altonato.",

	-- Step 19: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Sigue al noreste por el centro de {zone:1447}: {npc:235903} acampa junto al camino.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, los sátiros al norte del campamento de los elfos de sangre",

	-- Step 20: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Cabalga al noreste hasta el campamento del goblin en los acantilados sobre {area:1227}, justo al norte de los elfos de sangre.",

	-- Step 21: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Los elfos de sangre acampan en los acantilados del noreste, junto a {area:1227}. Las cuatro piezas de equipo de {npc:8420} están en las cajas alrededor del campamento; los Arcanistas elfos de sangre llevan la varita de {npc:247473}.\nCuidado: un {npc:250023}, élite de nivel 55-57, está en el borde oeste del campamento: encárgate de los elfos de sangre desde su lado este.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, de los Arcanistas elfos de sangre",

	-- Step 22: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Campamento de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "El campamento de Rimtori está en el extremo este del campamento base. Lee {object:151286} allí: en Forever, el Tomo sin'dorei de al lado te pide luego los sellos de los tres oficiales del campamento.",

	-- Step 23: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Cada uno de los tres oficiales del campamento (53) lleva un sello: {npc:247006} en el centro del campamento, {npc:247013} en su extremo este y {npc:246991}, que patrulla su mitad oeste: enfréntalo en el lado este de su recorrido, donde apunta la Flecha.\nCuidado: el {npc:250023}, élite de nivel 55-57, está en el borde oeste del campamento, cerca del extremo del recorrido de Hawkhelm: espera a que Hawkhelm vuelva al este.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, de {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, de {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, de {npc:247013}",

	-- Step 24: Magus Rimtori
	-- {npc:8578} Magus Rimtori
	["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Rimtori is level 55, and which crystal is linked to him is random: each of the other two summons a hostile infernal instead. Start at full health."] = "",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: para {npc:8587} en {area:1237}",

	-- Step 25: The Legashi satyrs
	["The Legashi satyrs"] = "Los sátiros Legashi",
	-- {npc:235903} Ekkal · {npc:235892} Prince Halanox
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind.\nCareful: {npc:235892} (55, elite) stands among the satyrs at the north-east end of their hills, around 67,19: take the satyrs nearer the camp and leave him be."] = "",

	-- Step 26: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "Regresa al noroeste con {npc:8420}.",

	-- Step 27: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Cabalga al sur hasta el borde norte de {area:1221}. Las sirenas y los mirmidones Látigo de Ira (50-52) de ahí llevan la runa de {npc:8420}; no cae seguido, así que avanza por el borde hasta conseguirla.",

	-- Step 28: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "Regresa al norte con {npc:8420} con la runa y luego ve al suroeste por el camino.",

	-- Step 29: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "Al suroeste por el camino: {npc:235903} recibe lo de los sátiros.",

	-- Step 30: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Regresa cabalgando al oeste a {area:1237}.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, para {npc:4485} en {zone:1454}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: el tomo va para {npc:3326} en {zone:1454}",
	-- {npc:8659} Jes'rimon · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {npc:6522} Andron Gant · {zone:1458} Undercity
	["Keep the deliveries: {npc:8659}, {npc:4485} and {npc:3326} are in {zone:1454} next, Magatha in {zone:1456} and {npc:6522} in the {zone:1458} on the next guides."] = "",

	-- Step 31: Sanath Lim-yo
	-- {area:1237} Valormok · {npc:8379} Archmage Xylem
	["Ride east from {area:1237} to Sanath's camp at the foot of the cliff and get off your mount: he teleports you up to {npc:8379}'s tower."] = "",

	-- Step 32: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "El aprendiz de lo alto de la torre te manda de vuelta abajo.",
	["Upstairs"] = "Arriba",

	-- Step 34: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Maestro de vuelo de {area:1237}",

	-- Step 35: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- {npc:8659} Jes'rimon · {npc:8587} Jediga
	["{npc:8659}: his payment goes back to {npc:8587}, on the flight out"] = "",

	-- Step 36: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 37: Druid trainer
	["Druid trainer"] = "Instructor de druidas",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} en {zone:1412}; {zone:1454} no tiene instructor de druidas",

	-- Step 38: Fly to Valormok
	-- {zone:1448} Felwood · {area:1237} Valormok · {npc:8587} Jediga · {npc:8659} Jes'rimon · {area:431} Splintertree Post
	["{zone:1448} is next: fly by way of {area:1237}, where {npc:8587} takes {npc:8659}'s payment, then on to {area:431}."] = "",

	-- Step 40: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Vuela a {area:431}",

	-- Step 42: Emerald Sanctuary
	["The druids' camp is just past the border."] = "El campamento de los druidas está justo pasada la frontera.",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}, junto a {npc:10921}: {quest:86577}, los órganos de los osos y lobos de {zone:1448}",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, en el borde sur del campamento",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}, en el lado oeste del campamento",

	-- Step 43: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "La aldea de los fúrbolgs Muertobosque está justo al sur del Santuario. Cada Muertobosque que mates también sube tu reputación con {area:1769}; guarda las plumas de penacho.",

	-- Step 44: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Sur de {area:1763}",
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: pull the cultists and hounds away from him."] = "",

	-- Step 46: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "El pozo de la luna de {area:1763}",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "De vuelta al norte a {area:1763}. Llena la cantimplora de Greta en el pozo de la luna corrupto en medio del campamento sur.",

	-- Step 47: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "El campamento de la Horda justo al norte de {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: las lechubestias están en {zone:1452}",

	-- Step 48: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "Al este de Puesto del Veneno, la cañada de cráteres donde deambulan las bestias entrópicas ({npc:9878}) y los horrores. Mata dos de cada uno y luego camina hasta cada uno de los tres cráteres de agua vil.",
	["Southern crater"] = "Cráter sur",
	["Western crater"] = "Cráter oeste",
	["Northern crater"] = "Cráter norte",

	-- Step 49: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "La {object:661778} está justo al sur del valle, junto al camino al norte: su chuchería inicia una misión para {npc:9996} en {area:1997}.",

	-- Step 50: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber · {npc:10920} Kelek Skykeeper
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	-- was: ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Sigue el camino al noreste hasta {area:1767}. Los arrancamusgos y machacadores Alabeo del lado este del bosque llevan cada uno un {item:11503}; los pardos Zarpira y los devastadores Zarpayel deambulan por el mismo bosque para Talo."
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958}, de los osos Zarpaira",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959}, de los lobos Zarpayel",

	-- Step 51: Irontree Woods
	["Below ground"] = "Bajo tierra",

	-- Step 52: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {quest:6031} Runecloth · {area:1769} Timbermaw Hold
	["Only from Friendly with the Timbermaw: {npc:11557}, in the tunnel near its {zone:1448} mouth, gives {quest:6031} then (the {area:1769} reputation guide gets you there)."] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; below ground"] = "",

	-- Step 53: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "El camino termina en {npc:15395}, fuera del túnel de {area:1769}, en el extremo noreste.",

	-- Step 54: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nIf one drops a {quest:8470} (about one kill in thirty), right-click it; don't stay to farm one. {npc:11558} in {area:1769} takes it only from Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): now if they already are, or on the last guide's pass of the cave."] = "",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop from the Deadwood furbolgs"] = "",

	-- Step 55: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Guarda {quest:8465} para {zone:1452}.",

	-- Step 56: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She speaks to you only from Neutral with the Timbermaw."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} da vueltas por aquí: búscala dentro del círculo del mapa",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "Te salió {item:13140}: úsala para empezar la misión y luego libera a {npc:11018} de su jaula en {area:1770}, la cueva en el extremo norte de {area:1763}.",
	-- ["Back at the {area:2479}."] = "De vuelta en {area:2479}.",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "De vuelta en {area:1762}, los fúrbolgs Muertobosque (53-54) están cerca del túnel y cada muerte sube tu reputación con los Fauces de Madera.",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Cuidado: Los vigías del cubil son de nivel 53-54 y los Vengadores Muertobosque de 54-55; llaman a los aliados cercanos en 25 m al bajar del 50 % de salud y huyen a pedir ayuda por debajo del 15 %.\nSigue matándolos hasta que uno suelte {quest:8470}, más o menos una vez de cada treinta, y haz clic derecho sobre él: {npc:11558} en {area:1769} lo recibe cuando seas Neutral con los Fauces de Madera, ahora si ya lo eres, o cuando la última guía vuelva a pasar por la cueva a nivel 59.",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Cuidado: Los vigías de la guarida son de nivel 53-54; llaman a los aliados cercanos en 25 m al bajar del 50 % de salud y huyen a pedir ayuda por debajo del 15 %.\nPor debajo del nivel 54.54, sigue peleando con los Muertobosque aquí después del conteo de {npc:15395}: las entregas en {area:1769} y {area:2479} te llevan al nivel 55. O, en grupo, haz la mazmorra {area:1584} o la mazmorra {area:1417}.\nSigue matándolos hasta que uno suelte {quest:8470}, más o menos una vez de cada treinta, y haz clic derecho sobre él: {npc:11558} en {area:1769} lo recibe cuando seas Neutral con los Fauces de Madera, ahora si ya lo eres, o cuando la última guía vuelva a pasar por la cueva a nivel 59.",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "Cruza el río al este hacia {area:2627}, el pueblo en ruinas del noroeste de {zone:1423}. {npc:12384} está sentado en una choza en su borde.",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "Las atalayas de Derrington, la caldera de Vandis y la barrica de {npc:11615} se hacen en una visita posterior: guárdalas.",
	-- ["Diseased Grizzlies"] = "Osos pardos malsanos",
	-- ["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- ["Fly to {area:272}"] = "Vuela a {area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Sigue el camino al noreste hasta {area:1767}. Los Arrancamusgos Alabeo y los trituradores del lado este del bosque llevan cada uno {item:11503}; los osos pardos Zarpaira y los Devastadores Zarpayel recorren el mismo bosque para Talo, y sus órganos son para {npc:10920}.\nLuego vienen los Vigías del cubil Muertobosque (53-54) y los vengadores (54-55) de {area:1762}: por debajo del nivel 54, sigue cazando osos y devastadores (51-52) aquí hasta el 54. Las entregas siguientes en {area:1769}, {area:2479} y {area:1997} te llevan casi hasta el 55. O, en grupo, haz el calabozo {area:1417} o el calabozo {area:1584}.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Sigue el camino al noreste hasta {area:1767}. Los arrancamusgos y machacadores Alabeo del lado este del bosque llevan cada uno un {item:11503}; los pardos Zarpira y los devastadores Zarpayel deambulan por el mismo bosque para Talo.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Sigue el camino al noreste hasta {area:1767}. Los desolladores y trituradores de musgo Madeguerra del lado este del bosque llevan cada uno {item:11503}; los osos pardos Zarpaira y los devastadores Zarpavil recorren el mismo bosque para Talo. Por debajo del nivel 54.21, sigue cazando osos y devastadores: las entregas en {area:1997} y {area:2479} te llevan al nivel 55. O, en grupo, haz la mazmorra {area:1584} o la mazmorra {area:1417}.",
	-- ["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Sigue el camino al noroeste. El sur de {area:1763}, alrededor de su pozo de la luna corrupto, lo ocupan sectarios, adeptos, guardias y canes del Consejo de la Sombra.",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "Desde el maestro de vuelo de {area:2268}, vuela a {area:1497}.",
	-- ["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "Su siguiente cacería, los osos pardos enfermos (55-56), espera a la visita a las Tierras de la Peste hacia el nivel 58.",
	-- ["Jadefire moonwell"] = "Pozo de la luna Fuego de Jade",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "Guarda La pequeña Pamela: Pamela está en {area:2262}, que visitarás de nuevo más adelante.",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "Guarda la rama: {npc:5770} está en {zone:1456}.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Guarda el paquete: {npc:10781} está en {area:1497}.",
	-- ["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Guarda {quest:5158}: {npc:5901} está en {zone:1413}.",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "Guarda {quest:6164}: {npc:12384} lo recibe de vuelta en la parada de {area:2627} de la guía de {zone:1423}.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Los caballeros y magus trabajan en {area:192}; los médicos y cazadores acampan al sur.",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Sal de {area:1497} y cabalga al este por el camino a través de {zone:1420}, pasando {area:152}. La granja de Piedramácula es la primera granja del camino; {npc:10778} espera en la casa.",
	-- ["Level 52.63"] = "Nivel 52.63",
	-- ["Level 53"] = "Nivel 53",
	-- ["Level 53.34"] = "Nivel 53.34",
	-- ["Level 54.7"] = "Nivel 54.7",
	-- ["Level 54.87"] = "Nivel 54.87",
	-- ["Level 55"] = "Nivel 55",
	-- ["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "Solo si cayó una {item:13140}: úsala para iniciar la misión, luego libera a {npc:11018} de su jaula en {area:1770}, la cueva del extremo norte de {area:1763}, y escóltala afuera.",
	-- ["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Solo si rescataste a {npc:11018}: la súcubo {npc:9518} espera en medio de {area:1763}, junto a {npc:11020}.",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "Solo con 5 plumas de penacho de Muertobosque",
	-- ["Radley and Durgen"] = "Radley y Durgen",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Cabalga de vuelta al sur pasando {area:1763} hasta el pozo de la luna corrupto de los sátiros Fuego de Jade y llena allí el frasquito de {npc:9996}.",
	-- ["Ride back south-east to the Sanctuary."] = "Cabalga de vuelta al sureste hasta el Santuario.",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Cabalga de vuelta a {area:1497}, toma el zepelín a {zone:1454} y vuela a {area:431}. Sigue el camino al oeste fuera del Puesto del Hachazo y toma el desvío al norte hacia {zone:1448}.",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Cabalga de vuelta al oeste cruzando el río y sigue hasta {area:192}; {npc:11610} se esconde en la colina al noreste.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Cabalga al este hasta las ruinas de la costa. Llena los cuatro viales de Cuely en las pozas de marea a lo largo de la orilla; las nagas Látigo de Ira patrullan entre ellas.",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Cabalga al norte por las colinas del este; {npc:1855} vive en una casita junto a {area:2619}, en la frontera con {zone:1423}.",
	-- ["Ride north up the road again."] = "Cabalga otra vez al norte por el camino.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cabalga al noroeste hacia Andorhal. {npc:10667} espera en la posada en ruinas del lado oeste del pueblo; los esqueletos de dentro son de nivel 54-57, así que no te alejes de los bordes.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Cabalga al sur pasando {area:202} hasta {area:197}; la casa de {npc:10927} está junto al camino, y el monumento de {npc:10936} está en el cementerio detrás. Mata los lobos malsanos que encuentres en los campos por el camino.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "Cabalga al sur por el camino a través de {area:361} hasta el Santuario.",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "Cabalga al sur por el camino a través de {zone:1448} hasta el Santuario.",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Cabalga al oeste hasta {area:192}; {npc:11610} se esconde en la colina al noreste.",
	-- ["Ror stands at the far south end of {area:1761}."] = "Ror está en el extremo sur de {area:1761}.",
	-- ["Scarlet Crusade"] = "Cruzada Escarlata",
	-- ["Scarlet forward camp"] = "Campamento avanzado Escarlata",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Entra a la cueva: {npc:11558} está justo en la entrada.",
	-- ["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Lleva al gatito al mismo pozo de la luna y suéltalo allí con {item:12565}; cuando se haya convertido en un {npc:10042}, llévaselo a {npc:9996} y haz clic en él para entregarlo.",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Lleva al gatito al mismo pozo de la luna y suéltalo allí; cuando se haya convertido en un {npc:10042}, llévaselo a {npc:9996} y haz clic en él para entregarlo.",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Las Crónicas están entre los libros enmohecidos del ayuntamiento de Andorhal; ábrelos hasta encontrar el correcto.",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "La aldea de los fúrbolgs Muertobosque justo al oeste del túnel. {npc:9462} (56) está entre ellos. {npc:11557}, un fúrbolg amistoso, está sentado en el extremo norte de la aldea.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "La aldea de los fúrbolgs Muertobosque está justo al sur del Santuario. Cada Muertobosque que mates también sube tu reputación con {area:1769}; guarda las plumas de penacho.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "La aldea de los fúrbolgs Muertobosque está justo al sur del Santuario. Cada Muertobosque que matas también sube tu reputación con {area:1769}; guarda las plumas de los tocados. Sigue matándolos hasta el nivel 53.92: las siguientes entregas del Santuario y {area:1763} lo piden. O, en grupo, haz la mazmorra {area:1417} o la mazmorra {area:1584}.",
	-- ["The Jadefire moonwell"] = "El pozo de la luna Fuego de Jade",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Los sátiros Legashi (51-52) ocupan las colinas al norte del campamento de los elfos de sangre: {npc:235903} quiere cinco de cada tipo.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Las tiendas de la Cruzada Escarlata están entre {area:199} y {area:200}. Quema la tienda de mando con {object:176092} y planta el estandarte de la Plaga.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "Los osos deambulan por las colinas al norte y al este de {area:202}.",
	-- ["The bears roam the hills north and east of the {area:202}. Below level 53.02, keep hunting them after the eighth: the hand-ins at the {area:202} take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Los osos recorren las colinas al norte y al este de {area:202}. Por debajo del nivel 53.02, sigue cazándolos después del octavo: las entregas en {area:202} te llevan al nivel 54. O, en grupo, haz la mazmorra {area:1417} o la mazmorra {area:1584}.",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "El libro está en la posada en ruinas de {area:2627}; los no-muertos del pueblo son de nivel 54-56, así que atráelos de uno en uno.\nLos Grandes Montículos de Termitas están por todas las colinas al este de {area:2627}. Usa el {item:15042} en cada montículo por el que pases.",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "La súcubo {npc:9518} espera en el centro de {area:1763}, junto a {npc:11020}.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Los lobos deambulan por los campos entre Andorhal, {area:200} y {area:202}. Termínalos en el camino de vuelta al este.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "A través de {area:1769}",
	-- ["To {zone:1448}"] = "A {zone:1448}",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Completa aquí hasta el nivel 52.63 antes de las entregas en {area:200}: te llevan al nivel 53. Los acechadores carroñeros (52-53) al oeste del campamento Escarlata tienen tu nivel; los magos y caballeros Escarlata (54-56) son de nivel más alto. O, en grupo, haz la mazmorra {area:1417} o la mazmorra {area:2100}.",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Completa aquí hasta el nivel 53 antes de que {npc:10739} te mande por los osos pardos malsanos (55-56): los acechadores carroñeros (52-53) del camino de {area:200} a {area:202} tienen tu nivel. O, en grupo, haz la mazmorra {area:1417} o la mazmorra {area:1584}.",
	-- ["Top up here to level 53.34 before the hand-ins at {area:1763}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Completa aquí hasta el nivel 53.34 antes de las entregas en {area:1763}: te llevan al nivel 54. O, en grupo, haz la mazmorra {area:1417} o la mazmorra {area:1584}.",
	-- ["Top up here to level 54.7 before the hand-ins at {area:1997} : they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Completa aquí hasta el nivel 54.7 antes de las entregas en {area:1997}: te llevan al nivel 55. O, en grupo, haz la mazmorra {area:1584} o la mazmorra {area:1417}.",
	-- ["Top up here to level 54.87 before the hand-ins in {zone:1452}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Completa aquí hasta el nivel 54.87 antes de las entregas en {zone:1452}: te llevan al nivel 55. O, en grupo, haz la mazmorra {area:1584} o la mazmorra {area:1417}.",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Entra en el túnel de {area:1769} junto a {npc:15395} y nunca ataques a los fúrbolgs Fauces de Madera de dentro. El túnel sale a {zone:1452}; sigue el camino al este hasta {area:2255}, el pueblo goblin donde empieza la siguiente guía.",
	-- ["Walk {npc:11018} out of {area:1770} and keep her alive until she is out of the cave."] = "Saca a {npc:11018} de {area:1770} y mantenla con vida hasta que salga de la cueva.",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "farmea vengadores Muertobosque en {area:1762}, {zone:1448}",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "farmea caballeros Escarlata en {area:192}, {zone:1422}",
	-- ["grind on {npc:10605}"] = "sube de nivel con {npc:10605}",
	-- ["grind on {npc:1816}"] = "sube de nivel con {npc:1816}",
	-- ["grind on {npc:1821}"] = "sube de nivel con {npc:1821}",
	-- ["grind on {npc:7101}"] = "sube de nivel con {npc:7101}",
	-- ["grind on {npc:7125}"] = "sube de nivel con {npc:7125}",
	-- ["grind on {npc:7153}"] = "sube de nivel con {npc:7153}",
	-- ["grind on {npc:7155}"] = "sube de nivel con {npc:7155}",
	-- ["grind on {npc:7156}"] = "sube de nivel con {npc:7156}",
	-- ["grind on {npc:7157}"] = "sube de nivel con {npc:7157}",
	-- ["grind on {npc:8957}"] = "sube de nivel con {npc:8957}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Los Escarlata de {area:190} son de nivel 58-60. Entra cabalgando hasta el punto alto marcado en tu mapa, observa el pueblo y sal.",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}: mátalos cuando te los encuentres",
	-- ["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, en el pozo de la luna Fuego de Jade",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, en el extremo sur del cementerio",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, bajo tierra",
	-- ["{npc:11018}, below ground"] = "{npc:11018}, bajo tierra",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, bajo tierra",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: guárdale 30 {quest:6031}; solo comercia a partir de Neutral con los Fauces de Madera",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}: guarda 30 {quest:6031} para él; solo comercia si eres Neutral con los Fauces de Madera; bajo tierra",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, en la entrada del túnel",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: los Fauces de Madera solo te hablan desde Neutral; da vueltas por aquí: búscala dentro del círculo del mapa",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "La última tarea de {npc:11610} requiere nivel 53. Los caballeros y magus Escarlata (54-55) que trabajan en el aserradero justo al suroeste de ella son el campamento más cercano.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} está al este del aserradero; {npc:11611} vigila el camino al noreste de {npc:11610}, hacia {area:190}.",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "Las cacerías de {npc:1855} están en {zone:1423}: guárdalas para más adelante.",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}, justo al oeste del campamento",
	-- ["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, en el lado oeste del Santuario",
	-- ["{npc:9996}'s kitten"] = "El gatito de {npc:9996}",
	-- ["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- ["{object:175894}, beside the house"] = "{object:175894}, junto a la casa",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} va a {area:2268}: guárdala para más adelante.",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}: los no-muertos de {area:2627} las sueltan mientras llevas puesta {item:12846}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, botín raro",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Las misiones de {zone:1452} son de nivel 55-58. ¿Por debajo del 55 tras las entregas de {npc:9996}? Los fúrbolgs Muertobosque de {area:1762} (53-55) son de tu nivel y están de camino al norte hacia el túnel de {area:1769}: mátalos hasta el nivel 55. Cada muerte también sube tu reputación con los Fauces de Madera. Cuidado: los vigías y vengadores llaman a aliados cercanos al bajar de la mitad de salud y huyen a pedir ayuda casi muertos: atráelos de uno en uno desde el borde del poblado. Es un relleno largo si solo sigues esta ruta. O, en grupo, haz el calabozo {area:1584} o el calabozo {area:1417}.",
}
