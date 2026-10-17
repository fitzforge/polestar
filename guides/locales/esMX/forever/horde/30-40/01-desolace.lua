-- Spanish (Latin America) (esMX): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:484} Freewind Post · {area:1637} Orgrimmar
	["From {area:484}, fly to {area:1637}."] = "Desde {area:484}, vuela a {area:1637}.",

	-- Step 2: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} espera en la calle comercial de la ciudad; {npc:5640} está en {object:172961}, en el lado oeste de la ciudad. Cielonatos: {npc:4949} espera en la fortaleza de Thrall, en {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, en la fortaleza de Thrall, si la llevas",

	-- Step 3: Train
	["Train"] = "Entrenar",
	["Train your new spells."] = "Entrena tus nuevos hechizos.",

	-- Step 4: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:460} Sun Rock Retreat
	["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "Tu instructor está en {area:1638}, a un vuelo de distancia: {npc:3033} (druidas) en {area:1639}, {npc:246344} (paladines). Desde allí, vuela a {area:460}.",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Misiones de clase en {zone:1454}",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} está en {object:172957}.",

	-- Step 6: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "Vuela a {area:392}. {npc:5901} acampa en la costa, a poca distancia al sur del pueblo.",

	-- Step 7: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "Vuela a {area:484}. {npc:5905} se esconde en una pequeña cueva en la pared del cañón, al noreste del poblado.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: tu {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} también inicia Elemental Aid ({area:1717}), la cadena de nivel 33-40 hacia The Tempest's Weapons: forever/class/shaman/call-of-air-horde.",

	-- Step 8: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Vuela a {area:460}",

	-- Step 9: Gizelton caravan
	["Gizelton caravan"] = "Caravana de Gizelton",
	-- {zone:1443} Desolace · {area:608} Nijel's Point · {npc:11625} Cork Gizelton · {area:609} Kolkar Village
	["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "Sigue el camino al suroeste desde Refugio Roca del Sol hacia {zone:1443} y continúa al sur pasando {area:608}. La caravana de kodos de {npc:11625} espera junto al camino al norte de {area:609}; si ya se fue, sigue adelante.",

	-- Step 10: Bodyguard for Hire
	-- {area:609} Kolkar Village · {npc:11625} Cork Gizelton · {area:2617} Scrabblescrew's Camp · {area:597} Ghost Walker Post
	["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "La caravana avanza al sur pasando {area:609}. Los asaltantes Kolkar la emboscan en oleadas: mátalos antes de que lleguen a {npc:11625}. Se detiene junto a {area:2617}, al este de {area:597}.",

	-- Step 12: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} está en el poblado; {npc:5641} y {npc:4498} esperan en la elevación al oeste, sobre {area:596}.",

	-- Step 13: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "Usa {item:13892} de {npc:11596} en un Kodo envejecido, un Kodo moribundo o un {npc:4702} del cementerio y lleva el kodo domado con {npc:11596}. Cinco kodos, de uno en uno.",

	-- Step 14: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Cabalga al noreste hasta {area:609}. {quest:1365} (35) camina entre las tiendas del lado este con uno o dos Señores de batalla (32-33): limpia a su alrededor y luego atráelo solo, con la salud completa.",

	-- Step 15: Sargeron
	-- {area:603} Sargeron
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "Al norte por las colinas del este, los sátiros ocupan las ruinas de {area:603}. Los Acechasombras son invisibles; los cuatro tipos que necesitas no lo son.",

	-- Step 16: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Cabalga al oeste hasta {area:599}. Debilita a un sectario de Filo Ardiente y usa {item:6436} sobre él antes de que muera para llenar una {item:6435}. A veces también sueltan {item:20310} (1-5%); si cae una, léela.",

	-- Step 17: Ghost Walker Post
	["Ride back south to the post."] = "Regresa cabalgando al sur al poblado.",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "La siguiente misión de {npc:5641}, {quest:1431}, te manda de vuelta a {zone:1454} para nada: déjala.",

	-- Step 18: Kolkar ears
	["Kolkar ears"] = "Orejas Kolkar",
	-- {area:609} Kolkar Village
	["Back at {area:609}, every Kolkar can drop an ear."] = "De vuelta en {area:609}, cualquier Kolkar puede soltar una oreja.",

	-- Step 19: Shadowstalker scalp
	["Shadowstalker scalp"] = "Cuero cabelludo de Acechasombras",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "Los Acechasombras Odio Feroz ({npc:4674}) de {area:603} son invisibles hasta que atacan; uno de cada tres lleva un cuero cabelludo.",

	-- Step 21: Shadowprey Village
	-- {area:606} Gelkis Village
	["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Cabalga al suroeste hasta el poblado trol de la costa, manteniéndote lejos de {area:606} en el camino.",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}: para {npc:715} en Vega de Tuercespina",

	-- Step 22: Clam beds
	["Clam beds"] = "Bancos de almejas",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Cabalga al norte por la costa. Las Almejas gigantes de concha blanda ({object:177784}) están en las aguas poco profundas y los Reptadores Correarrecifes iracundos ({npc:12347}) caminan por la playa; abre cada almeja en tus bolsas para obtener su carne.",

	-- Step 23: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "Oráculos Filozante ({npc:4718})",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "Sigue al norte hasta {area:598}. Los Oráculos están entre las otras nagas en su extremo norte; atráelos de uno en uno.",

	-- Step 24: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863} espera en la torre en ruinas de {area:2405}, tierra adentro al sureste.",

	-- Step 25: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "El Vidente está en el lado sur de {area:599}, al este de {area:2405}. Primero acaba con los sectarios a su alrededor.",

	-- Step 26: Ethel Rethor
	["His next errand is not on this route."] = "Su siguiente encargo no está en esta ruta.",

	-- Step 27: Ghost Walker Post
	["Ride south-east to the post."] = "Cabalga al sureste hasta el poblado.",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "El siguiente encargo de {npc:5641} te manda tras un señor demonio con una guardia élite: omítelo.",

	-- Step 28: Gelkis Village
	["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Cabalga al suroeste hacia Aldea Cazasombras. Los centauros Gelkis (32-35) alrededor de su poblado son un buen lugar para farmear; pelea con ellos hasta el nivel 32.",
	-- {area:606} Gelkis Village · {zone:1443} Desolace
	-- plural, as words: Gelkis Stampers = {npc:4648} Gelkis Stamper
	["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "farmea Coceadores Gelkis ({npc:4648}) y Cazavientos en {area:606}, {zone:1443}",

	-- Step 30: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "Vuela a {area:1638} desde Aldea Cazasombras y entrena con {npc:3033} en {area:1639}; luego vuela a {zone:1454}.",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 32: Zeppelin to the Undercity
	-- {area:1497} Undercity
	["Zeppelin to the {area:1497}"] = "Zepelín a {area:1497}",
	-- {zone:1454} Orgrimmar · {area:1497} Undercity
	["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "Sal de {zone:1454} por la puerta principal; la torre de zepelín está justo al noreste. Toma el zepelín a {area:1497}.",
	["Zeppelin tower"] = "Torre del zepelín",

	-- Step 33: Garen Largo
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093} entrena a los paladines en {area:1497}.",

	-- Step 34: Brazier of Everfount
	-- {area:1497} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Primero haz tus compras en {area:1497} y luego vuela a {area:228}. {object:113791} está en la colina justo al suroeste: derrota a la Manifestación de agua corrupta a su lado, coloca sus brazales en el brasero, habla con la {npc:5895} y guarda el {item:7813} para {npc:5901}. Desde {area:228}, vuela a {area:272}.",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "para {npc:5901}: desde Vega de Tuercespina, siguiente guía",

	-- Step 35: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515} necesita una {item:3388}, un objeto de {skill:171}: compra una en la casa de subastas de aquí si puedes (o pídesela a un alquimista). ¿Sin poción? Omite los pasos del elixir en {area:287}.",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: casa de subastas o un alquimista, para {quest:515}.",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}, el cuidador de murciélagos",

	-- Step 36: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}: para {area:321} en Arathi, más adelante en la ruta",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}: para {zone:1413}, más adelante en la ruta",

	-- Step 37: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinadaga",
	-- {area:271} Southshore
	["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Cabalga al sur, al este de {area:271}, hasta la costa. Las nagas Espinadaga se alinean en la orilla al sureste del pueblo.",
	["Daggerspine shore"] = "Costa Espinadaga",

	-- Step 38: Torn Fin murlocs
	["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "Sigue la orilla al oeste pasando la bahía de {area:271}; los múrlocs Rompeanca acampan en las playas más allá.",
	["Torn Fin beach"] = "Playa Rompeanca",

	-- Step 39: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Ride back north to {area:272}, keeping west of {area:271}."] = "Regresa cabalgando al norte a {area:272}, manteniéndote al oeste de {area:271}.",

	-- Step 40: Shindigger keg
	["Shindigger keg"] = "Barril Machacacanillas",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "El barril está con algunos otros en el campamento de la Hermandad, en la costa sureste de {area:287}.",

	-- Step 41: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "De vuelta a {area:272}",
	["Hearth back (or ride north if it is on cooldown)."] = "Usa tu piedra de hogar para volver (o cabalga al norte si está en tiempo de reutilización).",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn"] = "Coloca {object:1729} sobre {object:1728}, junto a la posada",

	-- Step 42: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Sigue el camino al norte desde {area:272} hacia las faldas de Alterac. {quest:535} espera junto al campamento de la Hermandad; entrégale la cerveza.",

	-- Step 43: Syndicate missives
	["Syndicate missives"] = "Misivas de la Hermandad",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Los Asaltantes de caminos de la Hermandad ({npc:2240}) y Ladrones (32-33) alrededor de los campamentos al oeste del camino llevan las misivas; uno de cada tres suelta una.",

	-- Step 44: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "Al suroeste, los Yetis de las cuevas y Yetis feroces ({npc:2249}) (30-31) llenan las cuevas en las colinas al oeste de {area:272}; uno de cada dieciséis lleva la vara.",

	-- Step 45: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "Los traidores de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "Ve al oeste por el pie de las montañas hasta la cúpula violeta de {area:279}. {npc:2411}, {npc:2412} y {npc:2413} (33-34) están juntos dentro del borde este del cráter, y {npc:2414} (35) un poco al oeste; cada uno lleva una pieza de sangrita. Los Guardias escuderos y Teúrgos (31-32) a su alrededor sueltan las Muestras de piedra desgastada ({item:3714}).",

	-- Step 46: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back east to {area:272}."] = "Regresa cabalgando al este a {area:272}.",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "La siguiente tarea de Thaivand termina en el cementerio de {area:271}, y el magus ofrece un encargo de calabozo: deja ambas.",

	-- Step 47: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Cabalga al norte pasando el campamento de {quest:535} hasta {area:280}, la aldea tomada por la Hermandad (35-37). {npc:2431} lleva la {item:3704}; {quest:503} está en una jaula en la casa del lado norte.",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back south to {area:272}."] = "Regresa cabalgando al sur a {area:272}.",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:1497} Undercity · {object:3202} Grom'gol (no name in this language: may be words)
	["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "La siguiente guía empieza en {area:1497}, en el zepelín a {object:3202}.",
}
