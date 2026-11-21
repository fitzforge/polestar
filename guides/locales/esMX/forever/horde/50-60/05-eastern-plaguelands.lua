-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands · {zone:1448} Felwood · {zone:1452} Winterspring
	["Western & {zone:1423}, {zone:1448} & {zone:1452}"] = "",

	-- Step 1: The Bulwark
	-- {area:199} Felstone Field · {area:152} The Bulwark · {npc:11055} Shadow Priestess Vandis
	["Back west along the road from {area:199} to the {area:152}: {npc:11055} takes the cauldron's report."] = "",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: his termites are in {area:2627}, later in this guide"] = "",

	-- Step 2: Dalson's Tears
	-- {area:199} Felstone Field · {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road past {area:199}, {npc:11077} guards the cauldron at {area:200}: kill him for the key, then use the cauldron."] = "",

	-- Step 4: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Torres de vigilancia y silos de Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord
	["Ride south-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites (55-57): fight them one at a time and let the biggest go.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room.\nCareful: Skeletal Warlords, level 56-57 elites, stand by the first and second towers (the south-western and the western one): mark those towers from the far side of the doorway once the Warlord has turned away, and never pull one. Putridius (58, rare) walks among the silos."] = "",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, en el piso de arriba",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "",

	-- Step 5: Chromie
	["Upstairs"] = "Arriba",

	-- Step 6: Counting Out Time
	-- {npc:10667} Chromie · {npc:1805} Flesh Golem
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth. A {npc:1805}, a level 56-57 elite, stands among the houses just east of the inn: take the boxes on the west side first and keep clear of it."] = "",

	-- Step 9: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "Al oeste, hasta {area:152}.",

	-- Step 10: Apothecary Dithers
	-- {quest:838} Scholomance · {area:152} The Bulwark
	["Derrington's {quest:838} is offered from level 55: still under 55 here, the next {area:152} stop offers it again."] = "",

	-- Step 11: Skeletal Fragments
	-- {area:152} The Bulwark
	["The skeletons on the fields east of the {area:152} drop the fragments: take them on the ride east."] = "",

	-- Step 12: Target: Writhing Haunt
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt · {npc:11076} Cauldron Lord Razarch
	["East past {area:200} to the {area:202}: {npc:11076} guards its cauldron."] = "",
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark · {zone:1423} Eastern Plaguelands
	["from the cauldron, for {npc:11055} at the {area:152}: on the way back west, after the {zone:1423}"] = "",

	-- Step 13: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "No hiciste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",
	["Inside"] = "Adentro",

	-- Step 16: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it."] = "",

	-- Step 17: Diseased Grizzlies
	["Diseased Grizzlies"] = "Osos pardos malsanos",
	["Careful: the grizzlies are 55-56: pull them one at a time."] = "",

	-- Step 19: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Hacia {zone:1423}",

	-- Step 20: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "Cabalga al este por el camino hasta {zone:1423}. {npc:1855} vive en una casita junto a {area:2619}, justo al norte del camino en la frontera; sus tres cacerías están en el territorio de esta guía.",

	-- Step 22: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "Sigue el camino al este desde {zone:1422}, cruza el río y atraviesa todas {zone:1423} hasta la capilla de {object:92525}, en el extremo este.",

	-- Step 23: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "El fantasma de {npc:10926} está en las ruinas de {area:2262}, al suroeste.",

	-- Step 24: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "La cabeza de la muñeca y sus dos lados están en las casas alrededor de {npc:10926}; únelos desde tus bolsas.",

	-- Step 25: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "un mensaje para {npc:11063} en {area:2268}",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Guarda {quest:5152}: {npc:10927} vive en {area:197}, en {zone:1422}.",

	-- Step 26: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "Zaeldarr acecha justo al oeste de {area:2262}.",
	["Below ground"] = "Bajo tierra",

	-- Step 27: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: {npc:10411} se vuelve invisible fuera de combate y llama a Gárgolas Alarroca en cuanto empieza una pelea. Solo existen 3 y reaparecen cada 15 min.",

	-- Step 28: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "De vuelta a {area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "Los espíritus de {quest:5211} llegan con la parada en {area:2264} más adelante en esta guía: guárdala.",

	-- Step 29: Caretaker Alen
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls · {spell:437801} Light's Hope
	["{npc:11038} offers {quest:5281} from level 55; under it, the next {spell:437801} stop offers it again."] = "",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}: for {npc:11140} in {area:2627} later in this guide"] = "",

	-- Step 30: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Maestro de vuelo de {area:2268}",

	-- Step 31: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "Hacia {area:197}",

	-- Step 32: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Cabalga al norte por el camino desde {area:272}. La casa de {npc:10927} está junto al camino en {area:197}, y el monumento de {npc:10936} está en el cementerio detrás de ella.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, en el piso de arriba",

	-- Step 33: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cabalga al noroeste hacia Andorhal. {npc:10667} espera en la posada en ruinas del lado oeste del pueblo; los esqueletos de adentro son de nivel 54-57, así que mantente en las orillas.",

	-- Step 34: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "Los Anales están entre los Libros enmohecidos del ayuntamiento de Andorhal; ábrelos hasta encontrar el correcto.\nCuidado: un {npc:10996}, élite de nivel 58-59, puede estar en Andorhal, como en muchos otros puntos de {zone:1422}: mantén tu distancia.",

	-- Step 36: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Vuela a {area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "Cabalga de vuelta al sur hasta {area:272} y vuela a {area:2268}.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Maestro de vuelo de {area:272}",

	-- Step 37: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls
	["{npc:11038}, if you didn't take {quest:5281} on the last stop"] = "",
	-- {npc:11063} Carlin Redpath · {area:190} Hearthglen
	["{npc:11063}'s Heroes of Darrowshire needs a group in {area:190} and a ride back here at the end: leave it."] = "",

	-- Step 38: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: mata a estos según te los encuentres",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "Los Canes de peste y sus cachorros recorren las orillas del lago al suroeste de la capilla; los Murcipestes y las Larvas carroñeras comparten el terreno. Cuidado: los Canes de peste más grandes son de nivel 56, atráelos de uno en uno.\nLa espada rota está en el suelo al noroeste del lago.",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His Ranger hunt (Rangers 59-60, in the north) is above you on this trip: leave it."] = "",

	-- Step 40: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Los Cachorros de can de peste ({npc:8596}) y los Murcipestes ({npc:8600}) recorren las colinas al norte de {area:2260}, y las Larvas carroñeras ({npc:8603}) se arrastran entre ellos; avanza al norte hacia {area:2627}.",

	-- Step 41: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "El fantasma {npc:11140} está junto a una choza en {area:2627}, en la esquina noroeste; {npc:12384} está sentado dentro de la choza.",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}, adentro",

	-- Step 42: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}: mátalos cuando te los encuentres",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "El libro está en la posada en ruinas de {area:2627}; los no-muertos del pueblo son de nivel 54-56, así que atráelos de uno en uno.\nLos Montículos grandes de termitas están por todas las colinas al este de {area:2627}. Usa el {item:15042} en cada montículo que pases.\nCuidado: los Protectores Ziggurat (58, élite) están junto a los zigurats al este y noreste del pueblo: toma los montículos más cercanos al pueblo y mantente lejos de ellos.",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}: los no-muertos de {area:2627} las sueltan mientras llevas puesta la {item:12846}",

	-- Step 43: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Keep the termites: {npc:11615} at the {area:152} takes them on this guide's ride back west."] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: mata a estos según te los encuentres",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the Monstrous Plaguebats up to 58: take the 57s one at a time and leave the 58s."] = "",

	-- Step 45: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "El cráneo está en {area:2622}, entre Horrores contagiados ({npc:8521}) y Monstruosidades de peste.",
	["Underwater"] = "Bajo el agua",

	-- Step 46: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Cabalga hacia el sur hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con el {item:15454} de inmediato.\nCuidado: los Sirvientes ocultos piden ayuda en un radio de 25 m cuando bajan al 40% de salud. Fuera de combate también se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, muchos enemigos pueden unirse a la pelea. Luchar en las afueras reduce ese riesgo.\nCon {quest:5211} en tu registro (de {npc:11063} al inicio de esta guía), la Plaga alrededor del pueblo deja Espíritus de Villa Darrow: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libera a los Espíritus de Darrowshire: habla con ellos",

	-- Step 47: Carlin Redpath
	-- {area:2268} Light's Hope Chapel
	["Ride east along the road to {area:2268}."] = "",

	-- Step 48: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride back west along the road to the {area:2260}."] = "",

	-- Step 49: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride north-west to {npc:1855}'s hut by the {area:2619} and hear him out."] = "",

	-- Step 50: Undercroft
	-- {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft · {area:2260} Marris Stead
	["{npc:11886} lurks in the {area:2261}, the crypt just south of the {area:2260}.\nCareful: about four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 51: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Back north-west to {npc:1855}'s hut."] = "",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next errand, Of Lost Honor, leads into the Mossflayer trolls (57-59) of the far north-east: leave it."] = "",

	-- Step 52: Kirsta Deepshadow
	-- {npc:1855} Tirion Fordring · {zone:1422} Western Plaguelands · {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp · {area:152} The Bulwark
	["Ride west from {npc:1855}'s hut into the {zone:1422}: {npc:11610} hides on the hill north-east of the {area:192}, on the way to the {area:152}."] = "",
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Her Scarlets wait until {npc:11615} has given you the termite barrel at the {area:152}: the barrel goes down in the same lumber mill."] = "",

	-- Step 54: The Bulwark
	-- {area:152} The Bulwark
	["On west to the {area:152}."] = "",

	-- Step 56: High Executor Derrington
	-- {area:152} The Bulwark · {quest:838} Scholomance · {quest:964} Skeletal Fragments · {area:201} Gahrron's Withering
	["Under 55 on the first {area:152} stop? Derrington's {quest:838} is offered now: Dithers' {quest:964} come from the skeletons on the ride back west from {area:201}."] = "",

	-- Step 58: Scarlet Crusade
	["Scarlet Crusade"] = "Cruzada Escarlata",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Back north-east to the {area:192}: knights and magi work the camp, the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "",

	-- Step 60: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} está al este del campamento maderero; {npc:11611} custodia el camino al noreste de {npc:11610}, hacia {area:190}.\nCuidado: Hay guardias en la base de la torre y otro más la rodea patrullando. Despéjalos antes de enfrentar a Durgen para que no se unan a la pelea.",

	-- Step 61: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11610}'s last errand looks over {area:190}, among Scarlets of 58-60: leave it."] = "",

	-- Step 62: Target: Gahrron's Withering
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south-east to {area:201}, the farm under the eastern hills: {npc:11078} (58) guards its cauldron. Kill him for the key, then use the cauldron.\nCareful: Soulwrath is about two levels over you here: clear the ghouls around the cauldron first, start at full health and use your cooldowns on him."] = "",

	-- Step 63: Skeletal Fragments
	-- {area:200} Dalson's Tears · {area:199} Felstone Field
	["On the ride back west, the skeletons on the fields around {area:200} and {area:199} (50-53) drop the fragments."] = "",

	-- Step 64: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "Al oeste, hasta {area:152}, por última vez.",

	-- Step 66: Class trainer
	["Class trainer"] = "Instructor de clase",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Train before the flight."] = "",

	-- Step 67: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {area:1638} Thunder Bluff · {quest:1000} The New Frontier · {zone:1452} Winterspring · {quest:1123} Rabine Saturna · {zone:1450} Moonglade · {zone:1451} Silithus
	["Only if {area:1638}'s {quest:1000} is still open for you (the {zone:1452} guide's stop offers it from level 54): it opens {quest:1123} in {zone:1450} and her {zone:1451} chain, so fly there first."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 68: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Vuela a {area:431}",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Then the flight master."] = "",

	-- Step 69: Fly to Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop. Then the flight master."] = "",

	-- Step 70: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033} (druidas) entrena en {area:1639}, y {npc:246344} (paladines) también en la ciudad.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} en {area:1639}; {npc:246344}",

	-- Step 71: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {area:1641} Hunter Rise
	["{npc:10881} stands on {area:1641}."] = "",

	-- Step 72: Arch Druid Hamuul Runetotem
	-- {area:1639} Elder Rise
	["Hamuul is on {area:1639}."] = "",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} is in {zone:1450}, later in this guide."] = "",

	-- Step 73: Fly to Splintertree Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 74: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "",
	-- {npc:10922} Greta Mosshoof · {zone:1413} Barrens
	["{npc:10922}: the Cleansed Water from Islen in the {zone:1413}"] = "",

	-- Step 75: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in linked groups, many with stuns: pull them one group at a time."] = "",

	-- Step 76: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Regresa al sur al Santuario, a poca distancia.",

	-- Step 77: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} (57) wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9529} Maybess Riverbreeze
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["Corrupted Soul Shards from the cultists, for {npc:9529}' Salve via Hunting"] = "",

	-- Step 78: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Enforcers = {npc:7114} Jaedenar Enforcer
	["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Te cayó una {item:13140}: los Déspotas Jaedenar, Tejeoscuros, Brujos y Legionarios del Bastión de las Sombras la llevan de vez en cuando. Úsala para iniciar la misión y luego libera a {npc:11018} de su jaula en el extremo sur de la cueva al salir.",

	-- Step 79: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "{npc:11016}, bajo tierra",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}: lead her out of {area:1770}"] = "",

	-- Step 80: Rescue From Jaedenar
	-- {npc:11018} Arko'narin · {npc:11019} Jessir Moonbow · {area:2479} Emerald Sanctuary
	["Lead {npc:11018} out through the cave: she fights beside you, and the cultists you didn't clear on the way in come at you both. {npc:11019} takes her report at the {area:2479}, next."] = "",
	-- {area:1770} Shadow Hold
	["out of {area:1770}, at its mouth"] = "",

	-- Step 81: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["Back south to the Sanctuary: {npc:9529} takes the shards on the west side of the camp."] = "",

	-- Step 83: Jessir Moonbow
	-- {npc:11019} Jessir Moonbow · {npc:11018} Arko'narin
	["{npc:11019}, at the Sanctuary's east side, takes {npc:11018}'s report."] = "",
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {area:1763} Jaedenar · {zone:1448} Felwood
	["{npc:11019}: {npc:9518}, in {area:1763}, on the last guide's ride north through {zone:1448}"] = "",

	-- Step 84: Deadwood Cauldron
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	-- was: ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Sube al norte por el camino. El caldero está en {area:1762}, justo al suroeste de {area:1769}; los fúrbolgs Muertobosque de ahí son hostiles."
	["Ride north up the whole {zone:1448} road, past {area:1997}. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 85: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {area:1769} Timbermaw Hold · {npc:11558} Kernda · {zone:1448} Felwood
	["Only if a {quest:8471} dropped for you and you are Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): {npc:11558} waits at the {zone:1448} entrance of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} da vueltas por aquí: búscala dentro del círculo del mapa",

	-- Step 87: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {quest:5527} A Reliquary of Purity · {area:2577} Dire Maul
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}.\n{npc:11801} offers {quest:5527} only after you have been inside {area:2577} once: if he doesn't offer it, carry on without it."] = "",

	-- Step 88: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Ambas misiones llevan a {zone:1451}: guárdalas.",

	-- Step 90: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "Desde la salida del túnel a {zone:1452}, cabalga al sur hasta {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086} están en {zone:1448}, en un viaje posterior: guárdala.",

	-- Step 91: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Lechubestias lunadón ({npc:7453})",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Cabalga al este hasta {area:2255} y sal al norte; las Lechubestias lunadón recorren las colinas de las laderas sur de {area:2241}. Cuidado: son de nivel 57-58: atráelas de una en una.\nCuidado: los Hailspite, élites de nivel 60, se reúnen en los campos nevados al sureste de {area:2255}, donde también rondan algunas Lechubestias lunadón: quédate en las laderas al norte del pueblo.",

	-- Step 92: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cuernos prístinos de yeti ({item:12367})",
	-- {area:2255} Everlook
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "Los cuernos de Umi, traídos desde tu última parada en {area:2255}: las colinas de los yetis empiezan justo al sureste de {area:2255}. Solo las Matriarcas y los Patriarcas sueltan cuernos, y los Patriarcas llegan a nivel 58: atráelos de uno en uno.",

	-- Step 93: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook · {zone:2482} Mount Hyjal · {zone:1451} Silithus
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it. {zone:2482} is next: its way in starts here in {area:2255}; {area:976}, Linken's sword and {zone:1451} follow it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Un pergamino roto está en la entrada de {area:2261}, la cripta al sur de {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Regresa por el túnel y toma la salida a {area:618}; luego cabalga al sur hasta {area:2246}.",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "Regresa por el túnel y toma la salida a {zone:1452}: {npc:11556} está justo donde sale.",
	-- ["Back to {area:1638}"] = "De vuelta a {area:1638}",
	-- ["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Bebe el {item:11243} en el cementerio justo al este de {area:976}: te mata, y solo como fantasma puedes ver a {npc:9299}, en una grieta rocosa en las colinas justo al norte de allí. Habla con él allí, luego corre de vuelta a tu cuerpo y resucita: la Lápida llamativa a la que te envía está en ese cementerio.",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Vuela a {zone:1458}, toma el zepelín a {zone:1454} y luego vuela a {area:1638}.",
	-- ["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Vuela a {area:1099}. Los nidos de hipogrifo están en el sur de {zone:1444}; cada uno tiene un huevo para {object:142071}.",
	-- ["Fly to {area:1497}"] = "Vuela a {area:1497}",
	-- ["Fly to {area:1997}"] = "Vuela a {area:1997}",
	-- ["Fly to {area:541}"] = "Vuela a {area:541}",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Vuela a {area:541} y luego cabalga al suroeste por Un'Goro hasta el paso hacia {zone:1451}. La siguiente guía empieza en {area:3077}, donde sale el paso.",
	-- ["Fly to {area:976}"] = "Vuela a {area:976}",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Los Canes de peste demenciados ({npc:8598}) y los Murcipestes monstruosos ({npc:8602}) comparten los campos alrededor de {area:2272} y {area:2271}, al sur de {area:2273}.",
	-- ["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "Los Canes de peste demenciados comparten los campos alrededor de {area:2272} y {area:2271}, al sur de {area:2273}; los Murcipestes nocivos vuelan sobre los campos del norte, y los Murcipestes monstruosos alrededor de {area:2272} y {area:2271}. Cuidado: los canes son de nivel 57-58 y los Murcipestes monstruosos más grandes de 58: atráelos de uno en uno.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atraviesa {area:1769} y toma el ramal del túnel hacia {area:493}. {npc:11801} está en {area:2361}.",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atraviesa {area:1769} y toma el ramal del túnel hacia {zone:1450}. {npc:11801} está en {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya se esconde entre los trols Fustamusgo de {area:2273}, en la esquina noreste.",
	-- ["Hameya's mound"] = "El montículo de Hameya",
	-- ["Hameya's scroll"] = "El pergamino de Hameya",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "Usa la piedra de hogar para ir a {zone:1454}: sigue vinculada ahí desde la guía de {zone:1447} (los magos se teletransportan). Luego el maestro de vuelo.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "Usa la piedra de hogar para ir a {zone:1454}: sigue vinculada ahí desde la guía de {zone:1447} (los magos se teletransportan). Entrena antes del vuelo.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "Usa la piedra de hogar para ir a {zone:1454}: sigue vinculada ahí desde la guía de {zone:1447}. Luego el maestro de vuelo.",
	-- ["Hippogryph eggs"] = "Huevos de hipogrifo",
	-- ["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Adentro: {quest:4493}, si la aceptaste en {zone:1454} en la guía de {zone:1447}",
	-- ["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "Guarda las termitas: {npc:11615}, en {area:813}, las recibe cuando la siguiente guía vaya a {zone:1422}.",
	-- ["Level 56"] = "Nivel 56",
	-- ["On to {zone:1451}"] = "Rumbo a {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "En {area:1641}. Lleva el paño de lana, de seda y de tejido mágico en tus bolsas.",
	-- ["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Solo si te salió un {quest:8471}: {npc:11558} espera en la entrada de {area:1769} del lado de {zone:1448}, y solo te habla si eres Neutral con los Fauces de Madera.",
	-- ["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Solo si encontraste un frasco de {item:12820} en {area:618}: cabalga al norte por el camino. El caldero está en {area:1762}, justo al suroeste de {area:1769}; los furbolgs Muertobosque de allí son hostiles.",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "Solo si todavía llevas {quest:2741}: cabalga al sur desde {area:1099}; los nidos de hipogrifo están en el sur de {zone:1444}, y cada uno tiene un huevo para el Huevomático.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Los Canes de peste ({npc:8597}) y sus cachorros recorren las orillas del lago al suroeste de la capilla.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "Los canes de la peste y sus crías recorren las orillas del lago al suroeste de la capilla; los murciélagos de la peste y las larvas carroñeras comparten el terreno.\nLa espada rota está en el suelo al noroeste del lago.",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Cabalga al este hasta {area:2255} y sal al norte; las Lechubestias lunadón recorren las colinas de las laderas sur de {area:2241}. Atráelas de una en una.\nCuidado: los Hailspite, élites de nivel 60, se reúnen en los campos nevados al sureste de {area:2255}, donde también rondan algunas Lechubestias lunadón: quédate en las laderas al norte del pueblo.",
	-- ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Sube al norte por el camino. El caldero está en {area:1762}, justo al suroeste de {area:1769}; los fúrbolgs Muertobosque de ahí son hostiles.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Cabalga hacia el sur desde el refugio hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con el {item:15454} de inmediato.\nCuidado: los Sirvientes invisibles piden ayuda en un radio de 25 m cuando bajan al 40% de salud. Fuera de combate también se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, muchos enemigos pueden unirse a la pelea. Luchar en las afueras reduce ese riesgo.\nCon {quest:5211} en tu registro (de {npc:11063} al final de la guía de Un'Goro), la Plaga alrededor del pueblo deja Espíritus de Darrowshire: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Cabalga hacia el sur desde el refugio hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con el {item:15454} de inmediato.\nCuidado: los Sirvientes invisibles piden ayuda en un radio de 25 m cuando bajan al 40% de salud. Fuera de combate también se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, muchos enemigos pueden unirse a la pelea. Luchar en las afueras reduce ese riesgo.\nCon {quest:5211} en tu registro (de {npc:11063} al inicio de esta guía), la Plaga alrededor del pueblo deja Espíritus de Darrowshire: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Cabalga al sur desde {area:1099}: los nidos de hipogrifo están en el sur de {zone:1444}; cada uno tiene un huevo para {object:142071}.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "Ve al suroeste hasta las ruinas de {area:2738}. {object:179565} para {quest:1123} está dentro de una de las casas en ruinas.",
	-- ["Ride west to the {area:2260}."] = "Cabalga al oeste hasta {area:2260}.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Asusta a {npc:7583} con {item:12928}",
	-- ["Sword of Marduk"] = "Espada de Marduk",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Los Anales están entre los Tomos mohosos del ayuntamiento de Andorhal; ábrelos hasta encontrar el correcto.",
	-- ["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "El vuelo aterriza en {area:541}: {npc:9997} está junto al maestro de vuelo, y {npc:8737} junto a la cueva, a pocos pasos. El trabajo de {npc:9997} está en Un'Goro, en el camino de vuelta al norte de la siguiente guía.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Los Forestales ({npc:8564}) altos elfos, los Zancaminos ({npc:8565}) y los Trabajadores forestales custodian el refugio junto a {area:2275}; el registro está adentro. Los Forestales llegan a nivel 60: atráelos de uno en uno. Los Murcipestes nocivos ({npc:8601}) vuelan sobre los campos en el camino.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Los forestales, batidores y leñadores altos elfos custodian el pabellón junto a {area:2275}; el Registro está adentro. Los forestales llegan a nivel 60: atráelos de a uno. Los murciélagos de la peste nocivos sobrevuelan los campos en el camino.\nEl cráneo está en {area:2622}, entre horrores infectados y monstruosidades de la peste.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "El paso desde Un'Goro sale en {area:3077}, el cementerio del noreste de {zone:1451}. {npc:13220} está entre las tumbas.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "La espada destrozada está en el suelo al noroeste del lago.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "El cráneo está en {area:2622}, entre Horrores contagiados ({npc:8521}) y Monstruosidades de peste.",
	-- ["The western hills"] = "Las colinas del oeste",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "La máquina {object:142071}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} está justo detrás de {area:2261}.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:11897} es élite de nivel 60: la mayoría de las clases lo hacen solas a nivel 62, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",
	-- ["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "Sube aquí a nivel 56 antes de los Canes de peste demenciados de Northdale (57-58): los Murcipestes nocivos (54-56) sobre los campos camino al este son de tu nivel, y {npc:11878} quiere veinte de ellos. O, con un grupo, haz el calabozo {area:1583} (inferior) en su lugar.",
	-- ["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "La tercera broma de Umi va contra los goblins de {area:976}, Un'Goro y {area:2255}: guárdala para después.",
	-- ["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Usa {item:12928} en {npc:7583}, la niña goblin de {area:976}. {npc:10977} y {npc:10978} se asustan más adelante en la ruta.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["grind on {npc:8601}"] = "farmea {npc:8601}",
	-- ["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "guárdala: los Forestales (59-60) quedan para la segunda incursión al norte de la siguiente guía",
	-- ["{area:2255} flight master"] = "Maestro de vuelo de {area:2255}",
	-- ["{area:976} flight master"] = "Maestro de vuelo de {area:976}",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con {item:15454} de inmediato.",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880} recorre {object:172982} y las calles que salen de allí: búscalo de camino a la torre del maestro de vuelo; el círculo en el mapa es su recorrido.",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}: para {npc:7776} en {quest:7492}, al final de esta guía",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "El fantasma {npc:11140} está junto a una choza en {area:2627}, en la esquina noroeste.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}. Su cacería de {npc:8564}, en el norte de la zona, queda para el viaje a las Tierras de la Peste de la siguiente guía.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}.",
	-- ["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto al camino de {area:1336}, al sur de {area:976}.",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} da vueltas por {area:2276}: búscalo dentro del círculo del mapa",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} es un fantasma en el cementerio justo al norte de {area:976}; la lápida llamativa está al sur, afuera de la muralla del pueblo.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "El maestro de vuelo de {object:1661} está en la torre oeste de {object:36078}, afuera de las murallas.",
	-- ["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} regresa con {npc:8737} en Un'Goro: guárdala.",
	-- ["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "{quest:3941} va para {npc:9117}, en la cueva de aquí, cuando la siguiente guía vuelva a {area:541}: guárdala.",
	-- ["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} están en {zone:1448}, en un viaje posterior: guárdala si la tienes.",
	-- ["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Los objetos de {quest:5168} están en las siguientes zonas de las Tierras de la Peste: guárdala.",
}
