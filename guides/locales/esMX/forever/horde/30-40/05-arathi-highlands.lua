-- Spanish (Latin America) (esMX): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instructores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entrena mientras estás en {zone:1458}: los instructores están en {object:36070}, {object:36073} y {object:36082} (paladines: {npc:260093}).",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038} está en la botica real.",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038}: el corazón de Stormheart de {zone:1441}",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {npc:4486} Genavie Callow · {area:340} Kargath
	["Warriors, Paladins, Rogues, Priests, Mages and Warlocks (not Hunters, Shamans or Druids): {npc:4486} stands beside the flight master. The Dabyrie family's farm lies on the road east through Arathi later in this guide, and your level 40 training brings you back to this flight master from {area:340}: she takes the heads then."] = "Guerreros, paladines, pícaros, sacerdotes, magos y brujos (no cazadores, chamanes ni druidas): {npc:4486} está junto al maestro de vuelo. La granja de la familia Dabyrie está en el camino al este por Arathi, más adelante en esta guía, y tu entrenamiento de nivel 40 te trae de vuelta a este maestro de vuelo desde {area:340}: entonces recibe las cabezas.",
	-- {npc:4486} Genavie Callow
	["{npc:4486}, beside the flight master"] = "{npc:4486}, junto al maestro de vuelo",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Maestro de vuelo de {zone:1458}",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk · {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow
	["{npc:2229}, {npc:2410} and {npc:2437} are inside the inn; {npc:2770} stands outside it."] = "{npc:2229}, {npc:2410} y {npc:2437} están dentro de la posada; {npc:2770} está afuera.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, adentro",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, adentro",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}: {quest:93680}, {item:279469} está junto a los traidores",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, adentro",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide"] = "{npc:2770}: para {npc:2771} en {area:321}, más adelante en esta guía",

	-- Step 6: Southshore Stout
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",

	-- Step 7: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["Follow the road north out of {area:272} into the Alterac foothills: {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Sigue el camino al norte desde {area:272} hacia las colinas de Alterac: {quest:535} espera junto al campamento de la Hermandad. Solo ofrece su encargo mientras llevas Infiltración de {npc:2229}: entrégale la cerveza negra de inmediato, y su recompensa es la misiva de la Hermandad que quiere Krusk. Una misiva de la Hermandad de aquí sirve igual: si tienes una en tus bolsas, la guía omite {quest:535}.",

	-- Step 8: Syndicate missives
	["Syndicate missives"] = "Misivas de la Hermandad",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one."] = "Solo si no conseguiste la misiva de {quest:535}: los asaltantes de caminos y los ladrones de la Hermandad (32-34) de los campamentos al oeste del camino también llevan misivas; más o menos uno de cada tres suelta una.",

	-- Step 9: Alterac Mountains
	-- {npc:246848} Kirin Tor Guard
	["West along the foot of the hills, south of the road: a {npc:246848} (55) walks that road from the north-east down into the traitors' camp."] = "Al oeste por el pie de las colinas, al sur del camino: un {npc:246848} (55) recorre ese camino desde el noreste hasta el campamento de los traidores.",
	-- {area:279} Dalaran
	["South of the {area:279} crater's camp"] = "Al sur del campamento del cráter de {area:279}",

	-- Step 10: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "El cráter de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard · Kirin Tor Enforcers = {npc:276215} Kirin Tor Enforcer
	["From the south, walk up into the camp below the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together in the camp, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens: the ones on the camp's west side are furthest from the Guard's road.\nCareful: Kirin Tor Guards (55) attack the Horde on sight, and one of them patrols the road that comes down into the camp from the north-east and walks right up to the traitors: he has killed many players here. Watch for him, let him walk back up the road, then pull the traitors. Many of the camp's guards stand in linked pairs and others patrol alone. Arcane Sentries (55, elite) and Kirin Tor Enforcers (55) stand around the violet dome itself: keep to the camp below the rim."] = "Desde el sur, sube al campamento bajo la cúpula violeta de {area:279}. {npc:2411}, {npc:2412} y {npc:2413} (33-34) están juntos en el campamento, y {npc:2414} (35) un poco al oeste; cada uno lleva un fragmento de piedra de sangre. Los guardias escudo y los teúrgos (31-33) de alrededor sueltan las muestras de piedra desgastada: los del lado oeste del campamento son los más alejados del camino del guardia.\nCuidado: Los guardias del Kirin Tor (55) atacan a la Horda en cuanto la ven, y uno de ellos patrulla el camino que baja al campamento desde el noreste y llega hasta los traidores: ha matado a muchos jugadores aquí. Vigílalo, deja que vuelva a subir por el camino y luego atrae a los traidores. Muchos guardias del campamento están en parejas vinculadas y otros patrullan solos. Los centinelas arcanos (55, élite) y los ejecutores del Kirin Tor (55) están alrededor de la cúpula violeta: quédate en el campamento bajo el borde.",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "{item:279469}: un objeto para saquear, junto a los traidores",
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Worn Stone Tokens, from the Shield Guards and Theurgists on the camp's west side"] = "Muestras de piedra desgastada, de los guardias escudo y los teúrgos del lado oeste del campamento",

	-- Step 12: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east along the foothills to {area:272}: everything from the first loop is handed in inside the inn."] = "Vuelve al este por las colinas hasta {area:272}: todo lo de la primera vuelta se entrega dentro de la posada.",

	-- Step 14: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north up the road past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Dirígete al norte por el camino pasando el campamento de {quest:535} hasta {area:280}, el pueblo ocupado por la Hermandad (35-37). {npc:2431} lleva {item:3704}; {quest:503} está en una jaula en la casa del lado norte.\nCuidado: Espías de la Hermandad en sigilo rondan {area:280}, y los edificios tienen muchos enemigos de la Hermandad, magos entre ellos.",
	["Inside"] = "Adentro",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Encuentra dónde tienen a {quest:503}, en el piso superior",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, en el piso superior",
	-- {npc:2229} Krusk · {npc:2423} Lord Aliden Perenolde · {area:1339} Lordamere Lake
	["{npc:2229} will offer {npc:2423} (41, in his manor far up {area:1339}) for this: leave it, he is over your level."] = "{npc:2229} te ofrecerá a {npc:2423} (41, en su mansión, muy al norte de {area:1339}) por esto: omítelo, tiene más nivel que tú.",

	-- Step 15: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}: mata a estos según te los encuentres",
	-- {area:280} Strahnbrad · {area:1357} Gallows' Corner · {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["From {area:280} follow the road south-west to {area:1357} and on west to the ruins north of the {area:279} crater, along the lake shore. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Desde {area:280}, sigue el camino al suroeste hasta {area:1357} y luego al oeste hasta las ruinas al norte del cráter de {area:279}, por la orilla del lago. Los invocadores de Dalaran guían a esclavos elementales; los brazales los sueltan los esclavos. Cuidado: Los centinelas arcanos (55, élite) y los guardias del Kirin Tor (55) protegen la cúpula misma y atacan a la Horda: trabaja el borde exterior de las ruinas y no subas a la cúpula.",

	-- Step 16: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "De vuelta a {area:272}",
	-- {area:272} Tarren Mill
	["Hearth back to {area:272} (your hearthstone is bound there), or walk back south-east along the road out of Alterac."] = "Usa tu Piedra de hogar para volver a {area:272} (está vinculada ahí), o regresa a pie al sureste por el camino que sale de Alterac.",

	-- Step 17: Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth back to {area:272}: your hearthstone is bound there."] = "Usa tu Piedra de hogar para volver a {area:272}: está vinculada ahí.",
	["The magus offers a dungeon errand next: leave it."] = "Después, el magus ofrece un encargo de mazmorra: déjalo.",

	-- Step 18: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "El camino al este por {area:1057}",

	-- Step 19: Boulderfist camp
	["Boulderfist camp"] = "Campamento Puño de Roca",
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Sal de {area:272} hacia el este por {area:1057} y sigue el camino al este. Los ogros y ejecutores Puño de Roca (32-34) acampan al sur del camino, al sur de {area:313}; los ejecutores se quedan en la cueva de ahí.",
	["Below ground"] = "Bajo tierra",

	-- Step 20: Dabyrie's Farmstead
	-- {npc:4481} Marcel Dabyrie · {npc:4479} Fardel Dabyrie · {npc:4480} Kenata Dabyrie
	["On along the road east: the Dabyrie farm lies just north of it. {npc:4481} (34) and {npc:4479} (33) Dabyrie walk the farm's western yard among their Laborers and Militia (30-32); {npc:4480} (35) stands at the farm's north-eastern edge."] = "Sigue por el camino al este: la granja Dabyrie está justo al norte de él. {npc:4481} (34) y {npc:4479} (33) Dabyrie recorren el patio oeste de la granja entre sus jornaleros y milicianos (30-32); {npc:4480} (35) está en el borde noreste de la granja.",
	-- {item:5832} Marcel's Head · {npc:4481} Marcel Dabyrie
	["{item:5832}, from {npc:4481}"] = "{item:5832}, de {npc:4481}",
	-- {item:5831} Fardel's Head · {npc:4479} Fardel Dabyrie
	["{item:5831}, from {npc:4479}"] = "{item:5831}, de {npc:4479}",
	-- {item:5830} Kenata's Head · {npc:4480} Kenata Dabyrie
	["{item:5830}, from {npc:4480}"] = "{item:5830}, de {npc:4480}",

	-- Step 21: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Sigue el camino al este. Los fragmentos violeta brillan justo al lado del camino, un poco al oeste de {area:321}.",

	-- Step 22: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "El bastión orco al extremo este del camino. {npc:2851}, la maestra de jinetes del viento, está junto a la puerta.\n{npc:15126} solo ofrece {quest:8263} cuando eres Amistoso con los Rapiñadores ({zone:1461}): omítela si no te la ofrece.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, junto a la puerta",
	-- {npc:12920} Doctor Gregory Victor · {skill:129} First Aid
	["{npc:12920}, at the south gate. If {npc:12920} offers nothing, another player may be running his {skill:129} quest Triage: he can be busy for a few minutes. Wait, then talk to him again."] = "{npc:12920}, en la puerta sur. Si {npc:12920} no ofrece nada, puede que otro jugador esté haciendo su misión de {skill:129} Triaje: puede estar ocupado unos minutos. Espera y vuelve a hablar con él.",

	-- Step 23: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Misiones de Stromgarde en grupo",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "{quest:639} de {npc:2703} lo suelta el Sindicato élite (35-38) de las ruinas de Stromgarde, en el oeste de las tierras altas. Da mucha XP si tienes grupo para hacerla: la ruta pasa por Stromgarde de camino al círculo interior.",

	-- Step 24: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Al noreste de Sentencia, los kóbolds Mostacho Seco excavan en el cañón; los kóbolds de la entrada y los cavadores y peritos de más adentro sueltan las Motas de Myzrael.\nCuidado: Todos los tipos de kóbold huyen en busca de ayuda cuando tienen poca salud (los kóbolds al 30%, los peritos y los cavadores al 15%), lo que puede atraer a más.",

	-- Step 25: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} están en el extremo del cañón.",

	-- Step 26: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Cada {object:180105} es un anillo de piedras erguidas; la llave está en la piedra del centro. El círculo del este está en las colinas al noroeste de {area:321}.\nCuidado: Cada piedra central está vigilada por unos tres elementales de nivel 39 más o menos que atacan juntos si haces clic en la piedra sin despejarlos: exiliados ardientes en el Oeste, exiliados tronadores en el Exterior, exiliados acuosos en el Este.",

	-- Step 27: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Al sur de Sentencia, los trols Secacorteza ocupan la aldea en las colinas. Los lanzahachas vigilan las chozas exteriores; los médicos brujos y los cazacabezas ocupan el centro de la aldea. Cuidado: Los tres tipos de trol huyen a pedir ayuda al 15 % de salud, lo que puede atraer más trols de los campamentos cercanos.",

	-- Step 28: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "Raptores de las tierras altas y reptadores de llanura",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "De regreso al norte, los zancudos de las Tierras Altas recorren las colinas alrededor de {area:321} y sueltan los ojos, y al sur los reptadores de llanura (32-33) tejen sus telarañas en la hierba; ellos llevan la seda de araña.",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "{item:278225}, de los reptadores de llanura",

	-- Step 29: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}: the doctor stands at the south gate."] = "De vuelta al norte a {area:321}: el doctor está en la puerta sur.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate. If he won't take the silk, another player may be running Triage: wait a few minutes and talk to him again."] = "{npc:12920}, en la puerta sur. Si no acepta la seda, puede que otro jugador esté haciendo Triaje: espera unos minutos y vuelve a hablar con él.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, en la puerta sur",

	-- Step 30: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Los toscos Puño de Roca acampan fuera de la sala de los ogros, lejos al suroeste de {area:321}; los magus están entre ellos. Atráelos de uno en uno.",

	-- Step 31: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptores acechacarne",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Los acechacarnes de las Tierras Altas (36-37) cazan en las tierras altas del sur, una manada al norte de {area:316} y otra en la llanura al oeste. Atráelos de uno en uno.",

	-- Step 32: Go'shek Farm
	["Go'shek Farm"] = "Granja Go'shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "La choza laboratorio de {npc:2733} está en la Granja Go'shek, al noreste de la llanura de los raptores, de camino de vuelta a {area:321}; la caja de {item:278462} está adentro.",

	-- Step 33: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "De vuelta a {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "De vuelta al noreste, a {area:321}.",

	-- Step 34: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Misiones de los Puño de Roca en grupo",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "Las siguientes misiones, {quest:678} de {npc:2771} y {quest:680} de {npc:2772}, son los ogros élite (38-40) del barrio ogro de Stromgarde, en la misma salida en grupo que el Sigilo.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, a su lado",

	-- Step 35: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Dirígete al oeste; el círculo exterior está en medio de las tierras altas.",

	-- Step 36: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "El círculo del oeste está cerca de {area:1057}, al noroeste del exterior.",

	-- Step 37: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "El círculo interior está al sur del círculo del oeste, al este de Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "La siguiente tarea de la piedra requiere a Fozruk, un élite de nivel 42 que ronda al oeste de {area:321}: déjala.",

	-- Step 38: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "Al oeste del círculo interior, las ruinas de Stromgarde: el Sindicato ocupa la mitad este (el Sigilo lo sueltan sus conjuradores, merodeadores y magos), y los Puño de Roca la mitad oeste, junto a {area:325} ({npc:2773} espera en una de las casas sin techo a su lado).",

	-- Step 39: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Dirígete al sur, a la cala de los goblins en la costa sur. {npc:2766} vigila desde el acantilado que está encima.",

	-- Step 40: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Escolta al profesor colina arriba hasta la cueva sobre la cala y protégelo mientras trabaja. Dos elementales de agua de nivel 40 lo emboscan ahí, y son inmunes a la escarcha. Retenlos en la entrada de la cueva, lejos de él: si la pelea es dentro de la cueva, él se une en lugar de trabajar y siguen llegando más elementales.",

	-- Step 42: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: mata a estos según te los encuentres",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["Careful: west of the cove the Daggerspine Raiders and Sorceresses (38-40) stand close together on the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks.\nCareful: the charts and logs lie deep inside the wrecks: watch your breath bar and come up between them; a water breathing potion makes it easy."] = "Cuidado: al oeste de la cala, los asaltantes y hechiceras Espinadaga (38-40) están muy juntos en la orilla: atráelos de uno en uno. Los dos naufragios están en los bajíos frente a ella, con las cartas y los diarios dentro; las gemas están en el fondo del mar alrededor de los naufragios.\nCuidado: las cartas y los diarios están en lo profundo de los naufragios: vigila tu barra de respiración y sube a respirar entre uno y otro; una poción de respiración acuática lo hace fácil.",
	["Underwater"] = "Bajo el agua",

	-- Step 43: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "para {npc:2487} en {area:35}, alrededor del nivel 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "La siguiente guía cruza {area:880} hacia {zone:1437} y se dirige a {zone:1418}.",

	-- Step 44: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Solo si hiciste Stromgarde en grupo: de vuelta a {area:321} para sus entregas, y luego sigue hasta {area:880}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Head back east to {area:272}."] = "Regresa al este a {area:272}.",
	-- ["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Dirígete al este desde {area:272} pasando por {area:1057}. El Sindicato ocupa la mansión amurallada y su granja al norte del camino; sus salteadores, mercenarios y acechacaminos llevan los Amuletos de sangrita.\nCuidado: Los salteadores (nivel 30-31) pueden estar en Sigilo, así que puede que estén ocultos cuando te acerques.",
	-- ["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Dirígete al norte pasando el campamento de Valik hasta {area:280}, el pueblo ocupado por el Sindicato (35-37). {npc:2431} lleva {item:3704}; {quest:503} está en una jaula en la casa del lado norte.\nCuidado: Espías del Sindicato en sigilo rondan {area:280}, y los edificios tienen muchos enemigos del Sindicato, magos entre ellos.",
	-- ["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Dirígete al noroeste por las montañas hasta la mansión Perenolde, en la orilla norte de {area:1339}. {quest:507} (41) espera en una habitación del piso de arriba: se escuda, te duerme y se cura cuando baja de la mitad de su salud. {npc:2317} está a su lado.",
	-- ["Perenolde manor"] = "Mansión Perenolde",
	-- ["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Al sur por la orilla del lago hasta las ruinas alrededor del cráter de {area:279}. Los invocadores de Dalaran guían a esclavos elementales; los brazales los sueltan los esclavos. Cuidado: Los centinelas arcanos (55, élite) y los guardias del Kirin Tor (55) protegen la cúpula misma y atacan a la Horda: trabaja el borde exterior de las ruinas y no subas a la cúpula.",
	-- ["The {object:1763} poster by the inn"] = "El cartel de {object:1763} junto a la posada",
	-- ["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "Al oeste de la cala, los asaltantes y hechiceras Espinadaga (38-40) ocupan la orilla: atráelos de uno en uno. Los dos naufragios están en los bajíos frente a ella, con las cartas y los diarios dentro; las gemas están en el fondo del mar alrededor de los naufragios.",
	-- ["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "Al oeste del círculo interior, las ruinas de Stromgarde: el Sindicato ocupa la mitad este (el Sigilo lo sueltan sus conjuradores, merodeadores y magos; {npc:2783} está entre ellos), y los Puño de Roca la mitad oeste, junto a {area:325} ({npc:2773} espera en una de las casas sin techo a su lado).",
	-- ["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} espera dentro de la posada de {area:272}, de vuelta al sur por el camino.",
	-- ["{npc:2229}, inside the inn"] = "{npc:2229}, dentro de la posada",
	-- ["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) lleva la cabeza. Aparece en un solo lugar a la vez: el sótano de la posada de {area:280}, o uno de los campamentos de tiendas del Sindicato en las tierras altas al norte y noroeste del pueblo, que están de camino a la mansión Perenolde. Si ya te lo encontraste al liberar a {quest:503}, este paso está hecho.",
	-- ["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "La siguiente misión de {npc:2706}, {quest:671}, es {npc:2783}, un brujo élite de nivel 40 en el barrio del Sindicato de Stromgarde.",
	-- ["{quest:671} with a group"] = "{quest:671} en grupo",
}
