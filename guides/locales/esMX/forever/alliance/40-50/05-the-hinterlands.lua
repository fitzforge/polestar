-- Spanish (Latin America) (esMX): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "Cabalga al sureste hasta {area:355}, el templo escalonado Vilrama en el sur de {zone:1425}, y sube a la cima. Qiaga y {npc:8636} (élite, 50) están allí arriba: toca la cima y baja enseguida.\nCuidado: Trols élite vigilan la plataforma de arriba, entre ellos {npc:7996} y {npc:8636}, junto con varios adivinos Vilrama. Los adivinos lanzan hechizos y están vinculados al resto del grupo.",

	-- Step 2: Vilebranch Soothsayers
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Vilebranch Soothsayers"] = "Veritas Vilrama",
	-- {area:355} Altar of Zul · {npc:7996} Qiaga the Keeper · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "Los Veritas Vilrama (46-47) recorren el terreno al pie de {area:355}: sus tótems son para Maret Firetend. Cuidado: {npc:7996} y {npc:8636} (50, élites) están en el lado sureste del altar: ataca a los Veritas del lado oeste, lejos de ellos, y no subas al altar.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "Cabalga al norte hasta {area:351}, en el centro de {zone:1425}. Los lodos verdes y los mocos de jade se arrastran por todo el lugar.\nCuidado: Las panteras se mueven por la zona en sigilo.",

	-- Step 4: Wildkin feathers
	["Wildkin feathers"] = "Plumas de lechúcico salvaje",
	-- {npc:7916} Erelas Ambersky · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {area:351} Skulk Rock
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["{npc:7916}'s Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam: pick them up as you ride between the altar and {area:351}."] = "Las plumas de lechúcico salvaje de {npc:7916} están en el suelo por todo {zone:1425}, al sur y al este de {area:348}, donde deambulan las lechubestias: recógelas mientras cabalgas entre el altar y {area:351}.",

	-- Step 5: Lost Gryphon Eggs
	-- plural, as words: Lost Gryphon Eggs = {item:279229} Lost Gryphon Egg
	["Lost Gryphon Eggs"] = "Huevos de grifo perdidos",
	-- {area:348} Aerie Peak
	["On the way back to {area:348}: the lost gryphon eggs lie in the hills just east of the aviary."] = "De regreso a {area:348}: los huevos de grifo perdidos están en las colinas justo al este del aviario.",

	-- Step 6: Aerie Peak
	["Inside"] = "Adentro",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "{npc:5636}, adentro",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "para {quest:2990} en {area:1438}, más adelante",
	-- {npc:270263} Farseer Maret Firetend
	["{npc:270263}, just east of the aviary"] = "{npc:270263}, justo al este del aviario",

	-- Step 7: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maestro de vuelo de {area:348}",

	-- Step 8: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 9: Ironforge inn
	-- {area:1537} Ironforge
	["{area:1537} inn"] = "Posada de {area:1537}",
	-- {object:26486} Stonefire Tavern (no name in this language: may be words) · {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth at the {object:26486}: the {zone:1427} guide starts with the hearth back here and the gryphon to {area:144}."] = "Vincula tu piedra de hogar en {object:26486}: la guía de {zone:1427} empieza con la piedra de hogar de vuelta aquí y el grifo a {area:144}.",

	-- Step 10: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tranvía a {zone:1453}",

	-- Step 12: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Vuela a {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maestro de vuelo de {zone:1453}",

	-- Step 15: The bloodmages
	["The bloodmages"] = "Los magos de sangre",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "El campamento de los magos de sangre es la primera parada junto al camino a {zone:1419}, al noroeste de {area:1438}.",
	-- {npc:7505} Bloodmage Drazial · {zone:1419} Blasted Lands
	["{npc:7505}: keep the five, their beasts (48-53) wait for the level-52 {zone:1419} stop"] = "{npc:7505}: guarda las cinco, sus bestias (48-53) esperan a la parada de nivel 52 en {zone:1419}",

	-- Step 16: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}."] = "Primero sigue al este por el camino hasta el castillo: el {item:6091} caduca una hora después de {area:42}.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, en lo alto del castillo",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "La siguiente tarea de {npc:8022}, {item:9471}, es una misión de {area:978}: omítela.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}, arriba",

	-- Step 17: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "Maestro de vuelo de {area:1438}",

	-- Step 18: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",
	["\"Sea Wolf\" MacKinley, if the Stranglethorn guide didn't give it"] = "MacKinley «Lobo de Mar», si la guía de Tuercespina no te la dio",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor, if the Stranglethorn guide didn't give it"] = "{npc:2487}, último piso, si la guía de Tuercespina no te la dio",
	-- {npc:2494} Privateer Bloads
	["{npc:2494}, if the Stranglethorn guide didn't give it"] = "{npc:2494}, si la guía de Tuercespina no te la dio",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, if the Stranglethorn guide didn't give it"] = "{npc:2498}, adentro, si la guía de Tuercespina no te la dio",

	-- Step 19: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "{area:43}: mata a estos según te los encuentres",
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["The charts and orders lie in the pirate camp on the {area:43}, just south of {area:35}; its Swashbucklers walk the shore. The Warlocks and Swashbucklers (41-43) are under you now."] = "Las cartas y órdenes están en el campamento pirata de {area:43}, justo al sur de {area:35}; sus espadachines recorren la orilla. Los brujos y espadachines (41-43) ya están por debajo de tu nivel.",

	-- Step 20: Booty Bay
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, piso superior",

	-- Step 21: The Bloodsail captains
	["The Bloodsail captains"] = "Los capitanes Velasangre",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "Los tres barcos Velasangre están anclados frente a la costa justo al sur de {area:35}: {npc:2550} (45) y {npc:2548} (46) en las cubiertas más cercanas, {npc:2546} (48) en el buque insignia, cada uno con una tripulación de piratas de nivel 42-45. Nada hasta ellos, despeja cada cubierta desde el borde y atráelos de a uno.",

	-- Step 23: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Expedicionarios naga",
	["Leave town by the tunnel and ride north along the coast past the Bloodsail camp: the naga comb the beaches beyond it and drop the reeds."] = "Sal del pueblo por el túnel y cabalga al norte por la costa pasando el campamento Velasangre: las nagas recorren las playas más allá y sueltan los juncos.",

	-- Step 24: Zanzil's village
	["Zanzil's village"] = "Poblado de Zanzil",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Ride on north along the coast to Zanzil's village. Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Sigue al norte por la costa hasta la aldea de Zanzil. Cualquier seguidor de Zanzil puede soltar la mezcla; {npc:2537} recorre el sur del campamento.",

	-- Step 25: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} y {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536} stand together in the hills just north of Zanzil's village."] = "{npc:2535} y {npc:2536} están juntos en las colinas justo al norte de la aldea de Zanzil.",

	-- Step 26: Gorilla hills
	["Gorilla hills"] = "Colinas de los gorilas",
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Gorilla Fangs = {item:2799} Gorilla Fang · Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride back south-east to the Mistvale gorilla hills above {area:35}. {npc:1449} sits among the gorillas: take ten Gorilla Fangs from the Elder Mistvale Gorillas first."] = "Regresa al sureste a las colinas de gorilas Velo de Bruma sobre {area:35}. {npc:1449} está entre los gorilas: primero consigue diez Colmillos de gorila de los Gorilas Velo de Bruma ancianos.",

	-- Step 27: Unbagwa's ritual
	["Unbagwa's ritual"] = "El ritual de Unbagwa",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Entrega los colmillos y quédate: vienen tres oleadas de gorilas, {npc:1514} al final.\nCuidado: tres oleadas de gorilas llegan una tras otra con poco descanso entre ellas, y luego {npc:1514}. Empieza con la salud y el maná al máximo, y quédate cerca de Unbagwa. A algunas clases les cuesta solas: con un amigo es fácil.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "{npc:1449}, dentro de {area:1742}",

	-- Step 29: Booty Bay
	["Ride back down to town."] = "Cabalga de vuelta abajo hasta el pueblo.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it, the Un'Goro guide lands there"] = "para {npc:2616} en Theramore: guárdalo, la guía de Un'Goro termina allí",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "El siguiente encargo de {npc:2498} sobre Zanzil empieza en {zone:1441}: omítelo.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, adentro",
	["MacKinley's next task sends you after elite ogres: skip it."] = "La siguiente tarea de MacKinley te envía tras ogros élite: omítela.",

	-- Step 30: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {quest:8552} necesita un grupo de 2. Omítela si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",

	-- Step 34: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente con quien hacerlo. {npc:1494} (élite de nivel 52) requiere un grupo de 2. Sáltalo si vas solo: la ruta te hace recuperar la experiencia matando enemigos.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Los jabalíes Cenicrín y basiliscos Rocarroja comparten las laderas al suroeste del castillo. Aléjate de los jabinfernos más al sur: son de nivel 52.",
	-- ["Back to {area:144}"] = "De vuelta a {area:144}",
	-- ["Boars and basilisks"] = "Jabalíes y basiliscos",
	-- ["Boat to {area:17203}"] = "Barco al {area:17203}",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Vuela de {area:144} a {area:150}, toma el barco a {area:442} y vuela a {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Vuela de {area:348} a {area:42}.",
	-- ["Fly to {area:144}"] = "Vuela a {area:144}",
	-- ["Fly to {area:150}"] = "Vuela a {area:150}",
	-- ["Fly to {area:442}"] = "Vuela a {area:442}",
	-- ["Fly to {area:69}"] = "Vuela a {area:69}",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Usa la Piedra de hogar para volver a {area:144}. La guía de {zone:1427} empieza en {area:1446}: desde aquí, cabalga al sur hacia {zone:1418}, al oeste pasando el pueblo de la Horda de {area:340} y sube por el sendero hasta la garganta.",
	-- ["Hearth to {area:348}."] = "Usa la Piedra de hogar para volver a {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "¿Piedra de hogar en tiempo de reutilización? Cabalga de vuelta al noroeste.",
	-- ["Portal to {zone:1438}"] = "Portal a {zone:1438}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Cabalga de vuelta al este hasta {area:1438} y vuela a {area:144}.",
	-- ["Ride back north to Ironband's camp."] = "Cabalga de vuelta al norte hasta la Excavación de Vetaferro.",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "Cabalga al este por la orilla sur del lago hasta la Excavación de Vetaferro.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Cabalga al este por {zone:1430} hasta {zone:1435} y baja al sur por el camino hasta {zone:1419}. El campamento de los magos de sangre es la primera parada junto al camino.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Cabalga al norte hasta {area:351}, en el centro de {zone:1425}. Los Lodos verdes ({npc:2655}) y los Mocos de jade ({npc:2656}) se arrastran por todo el lugar.",
	-- ["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Primero sigue al este por el camino hasta el castillo: la {item:6091} caduca una hora después de {area:42}, y las bestias de los magos de sangre llevan más tiempo.",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Cabalga al sur por el paso hasta el borde norte de {area:3}: allí los troggs Grutacanto excavan fuera de {area:1517}. Las urnas talladas y los racimos de champiñones magenta están en sus cuevas y túneles, fuera del calabozo.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Cabalga al sureste hasta {area:355}, el templo escalonado Vilrama en el sur de {zone:1425}, y sube a la cima. Qiaga la Vigilante y {npc:8636} (élite, 50) están allí arriba: toca la cima y baja enseguida.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Cabalga al oeste: las hienas risitas famélicas rondan las colinas secas justo al sur del campamento de los magos de sangre; los aguijoneros Scorpok (nivel 50) corretean por el centro del norte. Los buitres {npc:5982} vuelan en círculos por toda la zona. Atráelos de uno en uno.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time.\nAshmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Cabalga al oeste: las hienas risitas famélicas rondan las colinas secas justo al sur del campamento de los magos de sangre; los aguijoneros Scorpok (nivel 50) corretean por el centro del norte. Los buitres {npc:5982} vuelan en círculos por toda la zona. Atráelos de a uno.\nLos jabalíes Cenicrín y basiliscos Rocarroja comparten las laderas al suroeste del bastión. Mantente lejos de los jabinfernos más al sur: son de nivel 52.\nCuidado: Los aguijoneros Scorpok usan {spell:5416}; {npc:8301} además derriba.\nCuidado: dos élites rondan por aquí: {npc:221740} (50) en el centro de la zona, alrededor de 44,34, y {npc:247015} (55) en la cresta, alrededor de 39,32. Cuando veas uno, caza en otro lado.",
	-- ["Scorpoks and snickerfangs"] = "Scorpoks e hienas risitas",
	-- ["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Cruza el portal hacia {zone:1457}. El Templo de la Luna está en el sur de la ciudad.",
	-- ["Temple of the Moon"] = "Templo de la Luna",
	-- ["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "El segundo nivel de los magos de sangre paga las mismas partes con un objeto de beneficio y sin experiencia: omítelo.",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Los instructores de druida están en el Enclave Cenarion; {zone:1455} no tiene",
	-- ["The {area:1517} dig"] = "La excavación de {area:1517}",
	-- ["the book on her table"] = "el libro de su mesa",
	-- ["the soil comes from {zone:1449}, later"] = "la tierra viene de {zone:1449}, más adelante",
	-- ["{area:144} flight master"] = "Maestro de vuelo de {area:144}",
	-- ["{area:2418} flight master"] = "Maestro de vuelo de {area:2418}",
	-- ["{area:702} flight master"] = "Maestro de vuelo de {area:702}",
	-- ["{npc:3516}, at the top of the tree"] = "{npc:3516}, en lo alto del árbol",
	-- ["{npc:7740}, beside her"] = "{npc:7740}, a su lado",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: la guía anterior te vincula aquí, así que esto suele marcarse de inmediato",
	-- ["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} está arriba, encima de {npc:7916}: sube por adentro, la flecha no distingue los pisos.",
	-- ["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "El siguiente encargo de {npc:7907} va a {zone:1446}: omítelo.",
	-- ["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: guárdala, las plumas llegan al final de la guía de {zone:1428}",
	-- ["{zone:1419}: kill these as you meet them"] = "{zone:1419}: mata a estos según te los encuentres",
}
