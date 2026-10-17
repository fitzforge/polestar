-- Spanish (Latin America) (esMX): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Cabalga al sureste hasta {area:355}, el templo escalonado Vilrama en el sur de {zone:1425}, y sube a la cima. Qiaga la Vigilante y {npc:8636} (élite, 50) están allí arriba: toca la cima y baja enseguida.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Cabalga al norte hasta {area:351}, en el centro de {zone:1425}. Los Lodos verdes ({npc:2655}) y los Mocos de jade ({npc:2656}) se arrastran por todo el lugar.",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "Usa la Piedra de hogar para volver a {area:348}.",
	["Hearthstone on cooldown? Ride back north-west."] = "¿Piedra de hogar en tiempo de reutilización? Cabalga de vuelta al noroeste.",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "para {quest:2990} en {area:1438}, más adelante",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "Vuela de {area:348} a {area:42}.",

	-- Step 6: The bloodmages
	["The bloodmages"] = "Los magos de sangre",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Cabalga al este por {zone:1430} hasta {zone:1435} y baja al sur por el camino hasta {zone:1419}. El campamento de los magos de sangre es la primera parada junto al camino.",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Primero sigue al este por el camino hasta el castillo: la {item:6091} caduca una hora después de {area:42}, y las bestias de los magos de sangre llevan más tiempo.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, en lo alto del castillo",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "La siguiente tarea de {npc:8022}, {item:9471}, es una misión de {area:978}: omítela.",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "Jabalíes y basiliscos",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Los jabalíes Cenicrín y basiliscos Rocarroja comparten las laderas al suroeste del castillo. Aléjate de los jabinfernos más al sur: son de nivel 52.",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "Scorpoks e hienas risitas",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Cabalga al oeste: las hienas risitas famélicas rondan las colinas secas justo al sur del campamento de los magos de sangre; los aguijoneros Scorpok (nivel 50) corretean por el centro del norte. Los buitres {npc:5982} vuelan en círculos por toda la zona. Atráelos de uno en uno.",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "El segundo nivel de los magos de sangre paga las mismas partes con un objeto de beneficio y sin experiencia: omítelo.",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "Cabalga de vuelta al este hasta {area:1438} y vuela a {area:144}.",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "Cabalga al este por la orilla sur del lago hasta la Excavación de Vetaferro.",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "La excavación de {area:1517}",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Cabalga al sur por el paso hasta el borde norte de {zone:1418}: allí los troggs Grutacanto excavan fuera de {area:1517}. Las urnas talladas y los racimos de champiñones magenta están en sus cuevas y túneles, fuera del calabozo.",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Cabalga de vuelta al norte hasta la Excavación de Vetaferro.",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Vuela de {area:144} a {area:150}, toma el barco a {area:442} y vuela a {area:702}.",
	["the book on her table"] = "el libro de su mesa",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "El siguiente encargo de {npc:7907} va a {zone:1446}: omítelo.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: guárdala, las plumas llegan al final de la guía de {zone:1428}",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Templo de la Luna",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Cruza el portal hacia {zone:1457}. El Templo de la Luna está en el sur de la ciudad.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, a su lado",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, en lo alto del árbol",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "la tierra viene de {zone:1449}, más adelante",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Los instructores de druida están en el Enclave Cenarion; {zone:1455} no tiene",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "De vuelta a {area:144}",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Usa la Piedra de hogar para volver a {area:144}. La guía de {zone:1427} empieza en {area:1446}: desde aquí, cabalga al sur hacia {zone:1418}, al oeste pasando el pueblo de la Horda de {area:340} y sube por el sendero hasta la garganta.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Cabalga al norte hasta {area:351}, en el centro de {zone:1425}. Los Lodos verdes ({npc:2655}) y los Mocos de jade ({npc:2656}) se arrastran por todo el lugar.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Cabalga al sureste hasta {area:355}, el templo escalonado Vilrama en el sur de {zone:1425}, y sube a la cima. Qiaga la Vigilante y {npc:8636} (élite, 50) están allí arriba: toca la cima y baja enseguida.",
}
