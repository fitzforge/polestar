-- Spanish (Spain) (esES): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "",

	-- Step 2: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "",

	-- Step 3: Aerie Peak
	["Inside"] = "",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "para {quest:2990} en {area:1438}, más adelante",

	-- Step 4: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 5: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "Cabalga hacia el este por la orilla sur del lago hasta la Excavación de Vetaferro.",

	-- Step 7: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "La excavación de {area:1517}",
	-- {area:3} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "",

	-- Step 8: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Vuelve al norte hasta la Excavación de Vetaferro.",

	-- Step 10: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 11: Class trainer
	["Class trainer"] = "",

	-- Step 12: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 16: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "",

	-- Step 17: Into Duskwood
	-- {area:10} Duskwood
	["Into {area:10}"] = "",

	-- Step 18: Into Deadwind Pass
	-- {zone:1430} Deadwind Pass
	["Into {zone:1430}"] = "",

	-- Step 19: Into Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into {zone:1435}"] = "",

	-- Step 20: Into Blasted Lands
	-- {zone:1419} Blasted Lands
	["Into {zone:1419}"] = "",

	-- Step 21: Nethergarde Keep flight master
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "",

	-- Step 22: The bloodmages
	["The bloodmages"] = "Los magos de sangre",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "",

	-- Step 23: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Sigue primero por el camino hacia el este hasta el bastión: la {item:6091} caduca una hora después de {area:42}, y las bestias de los magos de sangre llevan más tiempo.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, en lo alto del bastión",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "La siguiente tarea de {npc:8022}, {item:9471}, es una misión de {area:978}: omítela.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "",

	-- Step 26: The Captain's Chest
	-- {npc:1492} Gorlash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1492} is a level 51 elite: most classes solo it at level 53, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 27: The Captain's Chest
	-- {npc:1492} Gorlash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1492} is a level 47 elite: most classes solo it at level 49, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 30: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 31: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "",
	-- {npc:8301} Clack the Reaver
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use Venom Sting; {npc:8301} adds Knockdown."] = "",

	-- Step 32: Level 47.07
	["Level 47.07"] = "",
	-- {quest:614} The Captain's Chest
	["If you skipped {quest:614}, grind here to level 47.07 to stay on the route's plan."] = "",
	-- {npc:5992} Ashmane Boar
	["grind on {npc:5992}"] = "",

	-- Step 33: Dreadmaul Hold: kill these as you meet them
	-- {area:1437} Dreadmaul Hold
	["{area:1437}: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Cabalga hacia el oeste: las Hienas risitas hambrientas deambulan por las colinas secas justo al sur del campamento de los magos de sangre; los Aguijoneros Scorpok (nivel 50) corretean por el centro del norte. Los buitres {npc:5982} vuelan en círculos sobre todo ello. Atráelos de uno en uno.",

	-- Step 34: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "La segunda ronda de los magos de sangre paga las mismas partes con un objeto de mejora y sin experiencia: omítela.",

	-- Step 35: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",

	-- Step 37: Boat to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Boat to {area:702}"] = "",

	-- Step 38: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: guárdala, las plumas llegan al final de la guía de {zone:1428}",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "El siguiente encargo de {npc:7907} va a {zone:1446}: omítelo.",
	["the book on her table"] = "el libro de su mesa",

	-- Step 39: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "",

	-- Step 42: Temple of the Moon
	["Temple of the Moon"] = "Templo de la Luna",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Cruza el portal hasta {zone:1457}. El Templo de la Luna está en el sur de la ciudad.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, a su lado",

	-- Step 45: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, en lo alto del árbol",

	-- Step 47: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "la tierra viene de {zone:1449}, más adelante",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Jabalíes Cenicrín y Basiliscos Rocarroja comparten las laderas al suroeste del bastión. Evita a los Jabinfernos más al sur: son de nivel 52.",
	-- ["Back to {area:144}"] = "De vuelta a {area:144}",
	-- ["Boars and basilisks"] = "Jabalíes y basiliscos",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Vuela de {area:144} a {area:150}, toma el barco a {area:442} y vuela a {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Vuela de {area:348} a {area:42}.",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Usa la piedra de hogar para ir a {area:144}. La guía de {zone:1427} empieza en {area:1446}: desde aquí, cabalga hacia el sur hasta {zone:1418}, al oeste más allá del pueblo de la Horda de {area:340}, y sube por el sendero hasta la garganta.",
	-- ["Hearth to {area:348}."] = "Usa la piedra de hogar para ir a {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "¿Piedra de hogar en reutilización? Vuelve cabalgando al noroeste.",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Vuelve al este hasta {area:1438} y vuela a {area:144}.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Cabalga hacia el este por {zone:1430} hasta {zone:1435} y baja por el camino hacia el sur hasta {zone:1419}. El campamento de los magos de sangre es la primera parada junto al camino.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Cabalga hacia el norte hasta {area:351}, en el centro de {zone:1425}. Barrosos verdes y mocos de jade se arrastran por todo el lugar.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and {item:1529} Oozes crawl all around it."] = "Cabalga hacia el norte hasta {area:351}, en el centro de {zone:1425}. Barrosos verdes y Mocos de {item:1529} se arrastran por todo el lugar.",
	-- ["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Cabalga hacia el sur por el paso hasta el borde norte de {zone:1418}: allí los troggs Grutacanto excavan fuera de {area:1517}. Las urnas talladas y los grupos de champiñones magenta están en sus cuevas y túneles, fuera de la propia mazmorra.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Cabalga hacia el sureste hasta {area:355}, el templo escalonado Vilrama del sur de {zone:1425}, y sube hasta arriba. Qiaga el Vigilante y {npc:8636} (élite, 50) están allí: toca la cima y baja enseguida.",
	-- ["Scorpoks and snickerfangs"] = "Scorpoks e hienas risitas",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Los instructores de druidas están en el Enclave; {zone:1455} no tiene",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
}
