-- Spanish (Latin America) (esMX): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "Reputación con la Prole de Nozdormu",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "El anillo del Vuelo Bronce, mejorado en cada nivel de reputación; una subida larga desde Odiado, sobre todo en bandas.",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "Cadena de misiones de {item:21175}",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "Baristolth en {area:3425}",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{faction:910} no aparece en tu lista de reputación hasta que conoces a {npc:15192}. {npc:15180}, en el edificio principal de {area:3425}, te manda con él. Conocerlo te pone en Odiado, 0 de 36.000: Neutral está a 42.000 de reputación, y casi toda sale de bandas. {area:2677} y {area:16076} no están entre las primeras bandas que Blizzard anunció para Forever: hasta que abra alguna de ellas, los 100 de la primera misión de Baristolth son toda la reputación con la Prole que hay. La ventaja Diplomático del Legado suma hasta un 10% a cada ganancia; los números de esta guía son sin ella.",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "{npc:15192} en {area:2300}",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "{npc:15192}, un dragón bronce con forma de elfo, está en la entrada de {area:2300}, en el este de {zone:1446}, al sureste de {area:976}. Acércate a él.",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "Conoce a {npc:15192}",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "De vuelta con Baristolth",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "{quest:8288} pide la cabeza de {npc:12017}, el tercer jefe de {area:2677} (una banda de 40 jugadores en {area:254}). Todo lo que sigue requiere la cabeza, incluidas las entregas de fragmentos: hasta que la tengas, {quest:8286} es toda la reputación con la Prole que hay, solo o en grupo.",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "{area:2677} es una banda de 40 jugadores en lo alto de {area:254}. {npc:12017} siempre suelta su cabeza.",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "{item:20383}: banda de 40",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "{quest:8301} pide 200 fragmentos de caparazón silítido. Cada silítido de colmena suelta de uno a tres en la mayoría de las muertes: las obreras, aguijoneros, enjambradores y defensores de Colmen'Ashi al norte y noroeste de {area:3425}, y los de {area:2743} en el oeste y {area:2744} en el sur. Casi todos son élites de nivel 57 a 60: de a uno solo, más rápido en grupo.",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "De Odiado a Neutral",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "Después de La senda, Baristolth acepta 200 fragmentos más para {quest:8302}: 200 de reputación, una y otra vez, pero solo hasta Neutral. Desde Odiado 500 son 208 entregas, 41.600 fragmentos, de 20.000 a 30.000 muertes de élites: la única forma sin el Templo, y muy larga. Con {area:16076} abierto (una banda de 40 jugadores) es mucho más rápido: cada enemigo menor del Templo da 100 hasta 2.999 de 3.000 en Neutral, unos 9.500 por pasada completa, así que con cuatro o cinco pasadas llegas a Neutral. Guarda cada {item:21230} y {item:21229} que saquees hasta que los enemigos menores dejen de contar: pagan lo mismo después.",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "{quest:8302}: 200 fragmentos, 200",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "Las misiones de {quest:8303}",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "Neutral abre el resto de la cadena del Cetro de las Arenas Movedizas. Baristolth te manda de vuelta con {quest:8303}.",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "La {object:180633}",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "La {object:180633} es un cristal rojo pequeño en el suelo, justo afuera de las puertas de {area:3428}, en el extremo suroeste de {zone:1451}. Haz clic en ella y quédate a ver la visión de la Guerra de las Arenas Movedizas hasta el final. Si se corta, abandona la misión y vuelve a hacer clic en la Lágrima.",
	["Watch the vision"] = "Mira la visión",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "{npc:15192} ahora ofrece el {item:21200} en tres versiones: la Senda del Protector (tanques), del Conquistador (cuerpo a cuerpo) o del Invocador (lanzadores de hechizos). Elige una: las otras dos se cierran. Cada nivel de reputación desde Amistoso hasta Exaltado trae una mejora del mismo anillo, 100 de reputación cada una. {quest:8555} te manda tras los tres fragmentos del Cetro de las Arenas Movedizas.",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "Elige una: la Senda del Protector, del Conquistador o del Invocador, 100",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "El fragmento rojo: Vaelastrasz",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "El fragmento rojo: {npc:13020}, el segundo jefe de {area:2677}, da {quest:8730} antes de su pelea; Nefarian, el último jefe, suelta el {item:21138} para un miembro de la banda con la misión en cada muerte. La misión dura cinco horas.",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "{npc:13020}, {area:2677}: banda de 40",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "{item:21138}, Nefarian",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "El fragmento azul: el libro de cuentas de Azuregos",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "El {npc:15481} está en la costa sur de {zone:1447}. Su libro de cuentas inicia la larga cadena de {npc:11811} en {zone:1446}.",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "{npc:11811}, un vidente goblin, vive en una choza al noreste de {area:976}. Te manda a tres lugares a la vez: a la caja de Stewvul en {zone:1421}, a una isla frente a la costa sur de {zone:1446} y con {npc:8125} en {area:976}.",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "La caja de Stewvul",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "La {object:180642} está apoyada en {area:230}, en el extremo sur de {zone:1421}, a la izquierda de la puerta cerrada.",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "La {object:180652} está en la más lejana de dos islas al sur de {area:987}, pasando la línea de fatiga. {npc:15526}, en el fondo del mar al sur del girocóptero estrellado de la playa, da {quest:8599} y una bendición de velocidad de nado de tres minutos que te permite cruzar.",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "La isla frente a {area:987}",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "De vuelta con {npc:11811}",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "{quest:8606} te manda, disfrazado con el turbante de {npc:11811}, a un punto de entrega al sur de {area:2255}, en {zone:1452}. Deja ahí la bolsa de oro: {npc:15554}, un élite de nivel 61, viene por ella (grupo de 3 a 5).",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "{npc:15554}, élite: grupo de 3 a 5",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "{npc:8125} cocina en {area:976}. Te manda a {area:1121}, frente al sur de {zone:1444}, por un festín de quimerok.",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "{area:1121}",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "{npc:12803} y los quimerok de {area:1121} son élites de nivel 60 a 62 que reaparecen cada diez minutos: trabajo para una banda. Los quimerok sueltan un solomillo más o menos la mitad de las veces, Lakmaeran de dos a cuatro de vez en cuando.",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "{item:21027}, {npc:12803}: banda",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "{quest:8597}, volumen II",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "{quest:8620} necesita los ocho capítulos de {quest:8597}, volumen II: de {npc:15552} en su casa de {area:2079} (un élite de nivel 63 con guardias, banda), los guardias viles de élite, comandantes de la Guardia Apocalíptica y señores del terror de {zone:1419}, las Hederine al sur de {area:2255} y un libro en {zone:1458}. {npc:11811} te da la encuadernación cuando aceptas.",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "{quest:8597}: volumen II",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "Las chuletas de {npc:8125}",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom (no name in this language: may be words) · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "{npc:8125} quiere 20 {item:9061} y 20 {item:8150} con la carne. Luego {npc:11811} quiere 20 barras de arcanita, 10 {item:18562}, 10 diamantes azerothianos y 10 zafiros azules, y te da un {item:21136}: colocado en el {object:180669} de {area:1227}, en {zone:1447}, invoca a {npc:15571}, un jefe de nivel 63 para una banda. {npc:15571} suelta el {item:21137} para un miembro de la banda con la misión en cada muerte.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "{item:12360}: alquimistas, o la casa de subastas",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "{item:18562}: {area:2677}, o la casa de subastas",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "{item:21137}, {npc:15571}: banda",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "El fragmento verde: Eranikus",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "{npc:15362} aparece junto a la {npc:5709} en el fondo de {area:1477} (una mazmorra de cinco jugadores). Te manda con un {npc:15624} afuera de {zone:1457} (los jugadores de la Horda pasan junto a los guardias de la ciudad), y luego con {npc:11832} en {zone:1450}.",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "{npc:15362}, dentro de {area:1477}",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "El {npc:15624}",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "{npc:15624}: 25 (y 25 con el Círculo Cenarion)",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {npc:235289} Dragons of Nightmare · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four {npc:235289} portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "",
	["10 (and 100 Cenarion Circle)"] = "10 (y 100 con el Círculo Cenarion)",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "El portal de {zone:1440}",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "Los cuatro portales del sueño están en arboledas vigiladas por dragonantes élite de nivel 60 a 62 que reaparecen cada 30 minutos; cada uno suelta el fragmento del portal una vez de cada veinte. Contenido de banda.",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "El portal de {zone:1431}",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "El {npc:15625} (jefe de nivel 63) siempre suelta su fragmento.",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "El portal de {zone:1444}",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "Portal de {zone:1425}",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "Un evento de banda: sigue a {npc:11832} hacia {area:2361} y mantenlo con vida contra Eranikus y sus esbirros de pesadilla hasta que llegue Tyrande y redima a Eranikus. No mates a Eranikus.",
	["100 (and 100 Cenarion Circle)"] = "100 (y 100 con el Círculo Cenarion)",
	["The Redemption of Eranikus: raid"] = "La redención de Eranikus: banda",
	["200 (and 200 Cenarion Circle)"] = "200 (y 200 con el Círculo Cenarion)",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "Con los tres fragmentos, {npc:15192} hace el Cetro de las Arenas Movedizas. En Classic, su primer portador toca el {object:180717} una sola vez para todo el reino, abriendo las puertas de {area:3428}, y los que terminan en diez horas ganan la montura de cristal qiraji negro; no se sabe si los reinos de Forever tendrán ese evento.",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "El {object:180717} cuelga ante las puertas de {area:3428}. {npc:15693} aparece a su lado una vez que se ha tocado el gong, con {quest:8745}: un arma y 200 de reputación.",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "De Neutral a Amistoso en el Templo",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "De Neutral a Amistoso son 3.000 de reputación. Cada enemigo menor de {area:16076} (una banda de 40 jugadores detrás de {area:2737}) da 100, y los Emperadores Gemelos 210 cada uno, hasta 2.999 de 3.000 en Neutral, a un punto de Amistoso; ahí dejan de contar. Luego entrega un {item:21230} guardado (1.000, a {npc:15502}) o una {item:21229} (500, a {npc:15503}) para pasar. Los canjes de hombreras y botas del conjunto de tier del Templo no requieren reputación: la ficha, dos ídolos y diez escarabajos a {npc:15502} (hombreras) o {npc:15503} (botas) pagan 200 cada uno. {area:3454} (20 jugadores) dan un poco por jefe: Kurinnaxx, Moam, Buru y Ayamiss 50 cada uno, Rajaxx 34, Osirian 100, hasta Exaltado.",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "{item:21229}, jefes del Templo",
	-- {npc:15503} Kandrostrasz
	["{npc:15503}: 500, handed in from his window"] = "{npc:15503}: 500, se entrega desde su ventana",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "El anillo en Amistoso",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "En Amistoso, {npc:15192} mejora el anillo de la senda que elegiste: la Senda del Protector, del Conquistador o del Invocador. Lleva el anillo que tengas puesto; 100 de reputación.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "{npc:15192}: la misión del anillo de Amistoso de tu senda",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "De Amistoso a Honorable: las entregas",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "Ahora entrega lo que guardaste. Cada {item:21230} (cualquier enemigo menor del Templo, del 1% al 9%) inicia {quest:8784}: 1.000 de reputación con {npc:15502}, uno de los tres dragones bronce dentro del Templo. Cada {item:21229} (casi todos los jefes del Templo) va a {npc:15503} para {quest:8595}: 500 aquí y 100 con el Círculo Cenarion. {npc:15727} da 2.500, hasta Exaltado. De Amistoso a Honorable son 6.000: seis artefactos o doce insignias. Amistoso también abre los canjes de yelmo y piernas del conjunto de tier del Templo (200 de reputación cada uno) con {npc:15502} y {npc:15503}.",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "{item:21230}: haz clic derecho en él, luego {npc:15502}",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "{quest:8595}: 1 insignia, 500",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "El anillo en Honorable",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "En Honorable, {npc:15192} mejora el anillo de la senda que elegiste: la Senda del Protector, del Conquistador o del Invocador. Lleva el anillo que tengas puesto; 100 de reputación.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "{npc:15192}: la misión del anillo de Honorable de tu senda",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "De Honorable a Reverenciado",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "De Honorable a Reverenciado son 12.000: doce artefactos, 24 insignias, o una combinación con {npc:15727} (2.500). Después de la primera, cada insignia es la repetible {quest:8595}. Cada jefe del Templo a veces suelta un {quest:8789} o Atuendo (más o menos una vez de cada veinte): {npc:15380} y {npc:15378}, dentro del Templo una vez muerto {npc:15727}, lo aceptan con 3 {item:18562} por 200 y un arma. Honorable abre el canje de pechera del conjunto de tier (200).",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "{item:18562}, {area:2677} o la casa de subastas",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "{npc:15380}: armamento y 3 {item:18562}, 200",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "{npc:15378}: atuendo y 3 {item:18562}, 200",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "El anillo en Reverenciado",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "En Reverenciado, {npc:15192} mejora el anillo de la senda que elegiste: la Senda del Protector, del Conquistador o del Invocador. Lleva el anillo que tengas puesto; 100 de reputación.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "{npc:15192}: la misión del anillo de Reverenciado de tu senda",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "De Reverenciado a Exaltado son 21.000: 21 artefactos o 42 insignias, con los 2.500 de {npc:15727} por semana. El ojo de {npc:15727} inicia {quest:8801} para {npc:15379} (200, y 200 con el Círculo Cenarion). En Exaltado, Anachronos da el último anillo: el Protector de Kalimdor, el Conquistador qiraji o el Gran Invocador.",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "El anillo de Exaltado",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "En Exaltado, {npc:15192} da el último anillo de tu senda: el Protector de Kalimdor, el Conquistador qiraji o el Gran Invocador. Lleva el anillo de Reverenciado; 100 de reputación.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "{npc:15192}: la misión del anillo de Exaltado de tu senda",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{quest:8735} wants a fragment from each of the four Dragons of Nightmare portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "{quest:8735} pide un fragmento de cada uno de los cuatro portales de los Dragones de la Pesadilla: dragonantes élite en los portales de {zone:1440}, {zone:1444} y {zone:1425} (5% cada uno) y el {npc:15625} en {zone:1431}. Contenido de banda.",
}
