-- Spanish (Spain) (esES): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Freewind Post
	-- {area:484} Freewind Post
	["Hearth to {area:484}"] = "",

	-- Step 2: To Freewind Post
	-- {area:484} Freewind Post
	["To {area:484}"] = "",

	-- Step 3: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 4: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} espera en La Calle Mayor; {npc:5640} está en {object:172961}, en el lado oeste de la ciudad. Cielonato: {npc:4949} espera en el Fuerte Grommash, en {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Fuerte Grommash, si la llevas",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Misiones de clase en {zone:1454}",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} está en {object:172957}.",

	-- Step 6: Train
	["Train"] = "Entrena",
	["Train your new spells."] = "Entrena tus nuevos hechizos.",

	-- Step 7: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short walk south of the town."] = "",

	-- Step 8: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "Vuela a {area:484}. {npc:5905} se esconde en una pequeña cueva en la pared del cañón, al noreste del poblado.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: tu {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} también inicia Elemental Aid ({area:1717}), la cadena de 33-40 hasta las armas de la Tempestad: forever/class/shaman/call-of-air-horde.",

	-- Step 9: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",

	-- Step 10: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Vuela a {area:460}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 13: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} está en el campamento; {npc:5641} y {npc:4498} esperan en la loma al oeste, sobre {area:596}.",

	-- Step 14: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "Usa el {item:13892} de {npc:11596} en un Kodo envejecido, moribundo o {npc:4702} del cementerio y lleva el kodo domado de vuelta con {npc:11596}. Cinco kodos, de uno en uno.",

	-- Step 15: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Head north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "",

	-- Step 16: Sargeron
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "",

	-- Step 17: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Head west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "",

	-- Step 18: Ghost Walker Post
	["Head back south to the post."] = "",

	-- Step 19: Ghost Walker Post
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "La siguiente misión de {npc:5641}, {quest:1431}, te manda de vuelta a {zone:1454} para nada: déjala.",

	-- Step 20: Kolkar ears
	["Kolkar ears"] = "Orejas kolkar",
	-- {area:609} Kolkar Village
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["Back at {area:609}, every Kolkar can drop an ear.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "",

	-- Step 21: Shadowstalker scalp
	["Shadowstalker scalp"] = "Cabellera Acechasombras",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "Los Acechasombras Odio Feroz de {area:603} caminan invisibles hasta que atacan; más o menos uno de cada tres lleva una cabellera.",

	-- Step 23: Shadowprey Village
	-- {area:606} Gelkis Village
	["Head south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}: para {npc:715} en Tuercespina",

	-- Step 25: On the way
	["On the way"] = "",

	-- Step 26: Clam beds
	["Clam beds"] = "Lechos de almejas",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "",
	["Underwater"] = "",

	-- Step 27: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "Oráculos Filozante",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "Sigue al norte hasta {area:598}. Los oráculos están entre las otras nagas en su extremo norte; atráelos de uno en uno.",

	-- Step 28: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863} espera en la torre en ruinas de {area:2405}, tierra adentro al sureste.",

	-- Step 29: Ghost Walker Post
	["Head south-east to the post."] = "",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "El siguiente encargo de {npc:5641} te manda a por un señor demoníaco con escolta élite: omítelo.",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 32: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 34: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "Vuela a {area:1638} desde la Aldea Cazasombras y entrena con {npc:3033} en {area:1639}; luego sigue volando a {zone:1454}.",

	-- Step 35: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",

	-- Step 36: Back to Orgrimmar
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 38: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 39: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 40: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}: para {zone:1413}, más adelante en la ruta",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}: para {area:321} en Arathi, más adelante en la ruta",

	-- Step 41: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 42: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 43: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515} necesita un {item:3388}, un objeto de {skill:171}: compra uno aquí en la casa de subastas si puedes (o pídeselo a un alquimista). Sin poción: omite los pasos del elixir en {area:287}.",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: casa de subastas o un alquimista, para {quest:515}.",

	-- Step 44: Brazier of Everfount
	-- {zone:1458} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {zone:1458} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "para {npc:5901}: desde Tuercespina, siguiente guía",

	-- Step 45: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "De vuelta a {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 47: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",

	-- Step 48: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Sigue el camino al norte desde {area:272} hacia las laderas de las Montañas de Alterac. {quest:535} espera junto al campamento del Sindicato; dale la cerveza.",

	-- Step 49: Syndicate missives
	["Syndicate missives"] = "Misivas del Sindicato",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Los Asaltantes de caminos y Ladrones del Sindicato (32-33) de los campamentos al oeste del camino llevan las misivas; más o menos uno de cada tres suelta una.",

	-- Step 51: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinadaga",
	-- {area:271} Southshore
	["Head south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "",
	["Daggerspine shore"] = "Orilla Espinadaga",

	-- Step 52: Torn Fin murlocs
	["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "Sigue la orilla al oeste, pasada la bahía de {area:271}; los múrlocs Rompeanca acampan en las playas de más allá.",
	["Torn Fin beach"] = "Playa Rompeanca",

	-- Step 53: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Head back north to {area:272}, keeping west of {area:271}."] = "",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",

	-- Step 54: Shindigger keg
	["Shindigger keg"] = "Barril Machacacanillas",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "El barril está con otros en el campamento del Sindicato de la costa sureste de {area:287}.",
	["Below ground"] = "",

	-- Step 55: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Head back north to {area:272}."] = "",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "",

	-- Step 56: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "Al suroeste, los Yetis de cuevas y Yetis feroces (30-31) llenan las cuevas de las colinas al oeste de {area:272}; más o menos uno de cada dieciséis lleva la vara.",

	-- Step 58: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "Los traidores de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens.\nCareful: Many guards stand in linked pairs and others patrol alone around the camp."] = "",

	-- Step 59: Hearth to Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth to {area:272}"] = "",

	-- Step 60: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "La siguiente tarea del Novicio Thaivand termina en el cementerio de {area:271} y el magus ofrece un encargo de mazmorra: deja ambas.",

	-- Step 62: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "",
	["Inside"] = "",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "",

	-- Step 65: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back south to {area:272}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back at {area:609}, every Kolkar can drop an ear."] = "De vuelta en {area:609}, cualquier kolkar puede soltar una oreja.",
	-- ["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Haz primero tus compras en {area:1497} y luego vuela a {area:228}. {object:113791} está en la colina justo al suroeste: derrota a la Manifestación menor de agua corrupta que hay a su lado, coloca sus brazales en el blandón, habla con la {npc:5895} y guarda el {item:7813} para {npc:5901}. Desde {area:228}, sigue volando a {area:272}.",
	-- ["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- ["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "Vuela a {area:392}. {npc:5901} acampa en la costa, a poca distancia al sur del pueblo.",
	-- ["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "Sigue el camino al suroeste desde el Refugio Roca del Sol hacia {zone:1443} y continúa al sur, pasado {area:608}. La caravana de kodos de {npc:11625} espera junto al camino al norte de {area:609}; si ya se ha ido, sigue adelante.",
	-- ["From {area:484}, fly to {area:1637}."] = "Desde {area:484}, vuela a {area:1637}.",
	-- ["Gizelton caravan"] = "Caravana de Gizelton",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "Ve al oeste por el pie de las montañas hasta la cúpula violeta de {area:279}. {npc:2411}, {npc:2412} y {npc:2413} (33-34) están juntos dentro del borde este del cráter, y {npc:2414} (35), un poco al oeste de ellos; cada uno lleva una pieza de Petrosangre. Los Guardias escuderos y Teurgistas Dalaran (31-32) de su alrededor sueltan las Muestras de piedra desgastada.",
	-- ["Hearth back (or ride north if it is on cooldown)."] = "Usa la piedra de hogar para volver (o ve a caballo al norte si está en tiempo de reutilización).",
	-- ["His next errand is not on this route."] = "Su siguiente encargo no está en esta ruta.",
	-- ["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "Sal de {zone:1454} por la puerta principal; la torre de zepelín está justo al noreste. Toma el zepelín de {area:1497}.",
	-- ["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "Al norte, por las colinas del este, los sátiros ocupan las ruinas de {area:603}. Los acechasombras caminan invisibles; los cuatro tipos que necesitas, no.",
	-- ["Place the {object:1729} on the {object:1728} beside the inn"] = "Coloca el {object:1729} sobre la {object:1728} junto a la posada",
	-- ["Ride back east to {area:272}."] = "Vuelve al este a {area:272}.",
	-- ["Ride back north to {area:272}, keeping west of {area:271}."] = "Vuelve al norte a {area:272}, manteniéndote al oeste de {area:271}.",
	-- ["Ride back south to the post."] = "Vuelve al sur al campamento.",
	-- ["Ride back south to {area:272}."] = "Vuelve al sur a {area:272}.",
	-- ["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Ve al norte, pasado el campamento de {quest:535}, hasta {area:280}, el pueblo en manos del Sindicato (35-37). {npc:2431} lleva la {item:3704}; {quest:503} está en una jaula en la casa del lado norte.",
	-- ["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Sube al norte por la costa. Las Almejas blandas gigantes están en las aguas poco profundas y los Reptadores Correarrecifes iracundos recorren la playa; abre cada almeja en tus bolsas para sacar su carne.",
	-- ["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Ve al noreste hasta {area:609}. {quest:1365} (35) camina entre las tiendas del lado este con uno o dos Señores de Batalla Kolkar (32-33): despeja su alrededor y atráelo solo, con la salud al máximo.",
	-- ["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Ve al sur, al este de {area:271}, hasta la costa. Las nagas Espinadaga ocupan la orilla al sureste del pueblo.",
	-- ["Ride south-east to the post."] = "Ve al sureste hasta el campamento.",
	-- ["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Ve al suroeste hasta el poblado trol de la costa, sin acercarte a {area:606} por el camino.",
	-- ["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Ve al suroeste hacia la Aldea Cazasombras. Los centauros Gelkis (32-35) alrededor de su poblado son un buen sitio para subir; lucha contra ellos hasta el nivel 32.",
	-- ["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Ve al oeste hasta {area:599}. Debilita a un fiel de Filo Ardiente y usa la {item:6436} sobre él antes de que muera para llenar una {item:6435}. A veces también sueltan una {item:20310} (1-5%); si cae, léela.",
	-- ["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "El Vidente está en el lado sur de {area:599}, al este de {area:2405}. Despeja antes a los fieles que lo rodean.",
	-- ["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "La caravana avanza al sur, pasado {area:609}. Los asaltantes kolkar la emboscan en oleadas: mátalos antes de que lleguen a {npc:11625}. Se detiene junto a {area:2617}, al este de {area:597}.",
	-- ["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "La siguiente guía empieza en {area:1497}, en el zepelín de {object:3202}.",
	-- ["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "Tu instructor está en {area:1638}, a un vuelo: {npc:3033} (druidas), en {area:1639}; {npc:246344} (paladines). Desde allí, sigue volando a {area:460}.",
	-- ["Zeppelin to the {area:1497}"] = "Zepelín a {area:1497}",
	-- ["Zeppelin tower"] = "Torre de zepelín",
	-- ["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "mata Timbradores y Cazavientos Gelkis en {area:606}, {zone:1443}",
	-- ["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093} entrena a los paladines en {area:1497}.",
	-- ["{npc:4551}, the bat handler"] = "{npc:4551}, el cuidador de murciélagos",
}
