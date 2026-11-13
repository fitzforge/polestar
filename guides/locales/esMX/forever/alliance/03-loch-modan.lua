-- Spanish (Latin America) (esMX): the guide forever/alliance/03-loch-modan (forever/alliance/03-loch-modan.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",
	-- {area:442} Auberdine
	["Sell and repair in {area:442} first: the next stretch is a long one."] = "Vende y repara primero en {area:442}: el siguiente tramo es largo.",

	-- Step 2: Menethil Harbor
	-- {zone:1437} Wetlands
	["Off the boat, walk up the pier to the flight master by the inn. Nothing to take here yet: Menethil's quests are for your {zone:1437} visit at about 22."] = "Al bajar del barco, sube por el muelle hasta el maestro de vuelo, junto a la posada. Todavía no hay nada que tomar aquí: las misiones de Menethil son para tu visita a {zone:1437}, cerca del nivel 22.",

	-- Step 3: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "A {zone:1432}",
	-- {area:836} Dun Algaz · {zone:1437} Wetlands
	["Follow the road east out of Menethil and south through the {area:836} pass. Keep to the road: the {zone:1437} crocolisks and raptors beside it are over your level."] = "Sigue el camino al este saliendo de Menethil y al sur por el paso de {area:836}. No te salgas del camino: los crocoliscos y raptores de {zone:1437} que hay a los lados te superan en nivel.",

	-- Step 4: Algaz Station
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	["{npc:1343} stands at the {area:925}, at the south end of the pass."] = "{npc:1343} está en {area:925}, en el extremo sur del paso.",

	-- Step 5: Mountaineer Stormpike
	-- {npc:1343} Mountaineer Stormpike · {npc:1416} Grimand Elmore
	["{npc:1343}: {npc:1416}'s package"] = "{npc:1343}: el paquete de {npc:1416}",

	-- Step 6: Silver Stream Mine
	["East along the hills to the mine: the Miners' League crates sit in its tunnels among the Tunnel Rat kobolds."] = "Al este por las colinas hasta la mina: las cajas de la Liga de Mineros están en sus túneles, entre los kóbolds Rata del Túnel.",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates; below ground"] = "{item:2640}, de las cajas; bajo tierra",

	-- Step 7: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "De vuelta a {area:925}",

	-- Step 8: Stonewrought Dam
	["Chief Engineer Hinderweir stands on top of the dam, up the ramp at its west end."] = "El ingeniero jefe Hinderweir está en lo alto de la presa, subiendo la rampa de su extremo oeste.",

	-- Step 9: The Suspicious Barrel
	-- {object:257} Suspicious Barrel
	["The {object:257}"] = "{object:257}",
	-- plural, as words: Dark Iron Sappers = {npc:1222} Dark Iron Sapper
	["Walk east along the dam, down its eastern ramp, then back west along the foot of the dam on the land side: two Dark Iron Sappers guard the barrel. Kill them, then open the barrel: it ends this quest and starts the next."] = "Camina al este por la presa, baja por su rampa este y luego vuelve al oeste por el pie de la presa, del lado de tierra: dos zapadores Hierro Negro vigilan el barril. Mátalos y luego abre el barril: termina esta misión y empieza la siguiente.",

	-- Step 11: The loch
	["The loch"] = "El lago",
	-- {object:665289} Discarded Fishing Toolbox (no name in this language: may be words) · {area:144} Thelsamar · {item:278051} Monogrammed Silver Hair Clip
	["South along the west shore. The {object:665289} lies on the loch bed at one of several places: east of {area:144} (48.1,39.7), a little south-west of there (45.7,43.4), or at the south end of the loch (48.7,54.4 or 50.6,53.3). If it isn't at the arrow, try the next place. Click it for the quest; the {item:278051} comes with it."] = "Al sur por la orilla oeste. {object:665289} está en el fondo del lago en uno de varios lugares: al este de {area:144} (48.1,39.7), un poco al suroeste de ahí (45.7,43.4), o en el extremo sur del lago (48.7,54.4 o 50.6,53.3). Si no está en la flecha, prueba el siguiente lugar. Haz clic en ella para la misión; {item:278051} viene con ella.",
	-- {object:665289} Discarded Fishing Toolbox (no name in this language: may be words)
	["{object:665289}; underwater"] = "{object:665289}; bajo el agua",

	-- Step 12: Thelsamar
	-- {npc:1684} Khara Deepwater · {npc:1105} Jern Hornhelm
	["{npc:1684} stands on the shore north-east of town, {npc:1105} by the inn."] = "{npc:1684} está en la orilla al noreste del pueblo, {npc:1105} junto a la posada.",

	-- Step 13: Ironband's Excavation
	-- {npc:1345} Magmar Fellhew · {npc:1344} Prospector Ironband
	["Round the south end of the loch and head east to the dig. {npc:1345} and {npc:1344} stand together at its west edge."] = "Rodea el extremo sur del lago y ve al este hasta la excavación. {npc:1345} y {npc:1344} están juntos en su borde oeste.",

	-- Step 14: The dig site
	["The dig site"] = "La excavación",
	-- {item:2636} Carved Stone Idol · {quest:86613} Excavation Tools
	-- plural, as words: Stonesplinter Diggers = {npc:1167} Stonesplinter Digger · Berserk Troggs = {npc:1393} Berserk Trogg
	["Stonesplinter Diggers, Geomancers and Berserk Troggs hold the dig east of Ironband; any of them can drop a {item:2636}. Piles of Excavation Tools lie around the dig: open one and right-click the tools to start {quest:86613}, then gather six.\nCareful: Berserk Troggs (19-20) enrage below 40% health."] = "Los excavadores y geomantes Rompecantos y los troggs rabiosos ocupan la excavación al este de Ironband; cualquiera puede soltar un {item:2636}. Hay pilas de herramientas de excavación por toda la excavación: abre una y haz clic derecho en las herramientas para empezar {quest:86613}, luego junta seis.\nCuidado: Los troggs rabiosos (19-20) se enfurecen por debajo del 40% de salud.",
	-- {quest:86613} Excavation Tools
	["{quest:86613}: open a pile at the dig"] = "{quest:86613}: abre una pila en la excavación",
	-- {quest:86613} Excavation Tools
	["Right-click the {quest:86613}"] = "Haz clic derecho en {quest:86613}",

	-- Step 16: The Farstrider Lodge
	-- {npc:1154} Marek Ironheart · {npc:1187} Daryl the Youngling
	["North-east to the lodge on the hill. {npc:1154} stands inside, {npc:1187} outside."] = "Al noreste hasta el refugio de la colina. {npc:1154} está adentro, {npc:1187} afuera.",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}, inside"] = "{npc:1154}, adentro",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}: the loch crocolisks below the lodge"] = "{npc:1154}: los crocoliscos del lago debajo del refugio",
	-- {npc:1187} Daryl the Youngling
	["{npc:1187}: 15 minutes"] = "{npc:1187}: 15 minutos",

	-- Step 17: Mountain Buzzards
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards"] = "Zopilotes montañeses",
	-- {quest:257} A Hunter's Boast
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards circle the hills west and south of the lodge, back toward the dig. {quest:257} runs for 15 minutes."] = "Los zopilotes montañeses sobrevuelan las colinas al oeste y al sur del refugio, de vuelta hacia la excavación. {quest:257} dura 15 minutos.",

	-- Step 18: Daryl the Youngling
	["12 minutes"] = "12 minutos",

	-- Step 19: Elder Mountain Boars
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["Elder Mountain Boars"] = "Jabalíes monteses mayores",
	-- {quest:258} A Hunter's Challenge
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["The Elder Mountain Boars roam the hills north-west of the lodge, along the east shore. {quest:258} runs for 12 minutes: kill five and go straight back to Daryl; the crocolisks come after."] = "Los jabalíes monteses mayores recorren las colinas al noroeste del pabellón, a lo largo de la orilla este. {quest:258} dura 12 minutos: mata cinco y regresa directo con Daryl; los crocoliscos van después.",

	-- Step 21: Daggerfang and the loch crocolisks
	-- {npc:270693} Daggerfang
	["{npc:270693} and the loch crocolisks"] = "{npc:270693} y los crocoliscos del lago",
	-- {npc:270693} Daggerfang
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["Back down to the east shore below the boars' hills: {npc:270693}, a crocolisk, patrols it among the Loch Crocolisks."] = "Baja de nuevo a la orilla este, debajo de las colinas de los jabalíes: {npc:270693}, un crocolisco, la patrulla entre los crocoliscos del lago.",
	-- {item:2924} Crocolisk Meat
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["{item:2924}: Loch Crocolisks"] = "{item:2924}: crocoliscos del lago",

	-- Step 23: Thelsamar
	-- {area:144} Thelsamar · {npc:1105} Jern Hornhelm · {npc:1572} Thorgrum Borrelson
	["Back west along the south shore to {area:144}: {npc:1105} by the inn, then {npc:1572} with the gryphons on the west side of town, on the way south."] = "De vuelta al oeste por la orilla sur hasta {area:144}: {npc:1105} junto a la posada, luego {npc:1572} con los grifos en el lado oeste del pueblo, de camino al sur.",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}"] = "Para {npc:1356} en {zone:1455}",

	-- Step 24: Mountaineer Ylva
	-- {npc:269185} Headsplitter
	["South of Thelsamar, Ylva lies dead in the mouth of a trogg cave. Take her banner, raise it beside her and hold the spot: troggs come in waves from both sides, then {npc:269185}."] = "Al sur de Thelsamar, Ylva yace muerta en la entrada de una cueva de troggs. Toma su estandarte, levántalo a su lado y defiende el lugar: los troggs llegan en oleadas desde ambos lados, y luego {npc:269185}.",

	-- Step 25: The tunnel post
	["The tunnel post"] = "El puesto del túnel",
	-- {zone:1426} Dun Morogh
	["West to the dwarven post at the tunnel to {zone:1426}."] = "Al oeste hasta el puesto enano del túnel a {zone:1426}.",

	-- Step 26: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:1537} Ironforge · {zone:1426} Dun Morogh · {area:144} Thelsamar
	["You have the {area:1537} flight path from {zone:1426}: back north to {area:144}'s gryphons, quicker than walking through the tunnel and across {zone:1426}."] = "Ya tienes la ruta de vuelo de {area:1537} desde {zone:1426}: regresa al norte a los grifos de {area:144}, es más rápido que caminar por el túnel y atravesar {zone:1426}.",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maestro de vuelo de {area:144}",

	-- Step 27: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "A {zone:1426}",
	-- {zone:1455} Ironforge · {area:144} Thelsamar
	["Through the South Gate tunnel and west along the road to {zone:1455}. Know the {zone:1455} flight path already? Fly from {area:144} instead: these two waypoints drop once you are in the city."] = "Atraviesa el túnel de la Puerta Sur y sigue el camino al oeste hasta {zone:1455}. ¿Ya conoces la ruta de vuelo de {zone:1455}? Mejor vuela desde {area:144}: estos dos puntos de ruta desaparecen en cuanto estés en la ciudad.",

	-- Step 28: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "A {zone:1455}",

	-- Step 29: Ironforge
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words) · {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers (no name in this language: may be words) · {object:171524} Tinker Town
	["{npc:1573} keeps the gryphons in the {object:32372}; {npc:1356} is in the {object:32356}, north-east of it, on the way to the tram in {object:171524}."] = "{npc:1573} cuida los grifos en {object:32372}; {npc:1356} está en {object:32356}, al noreste, de camino al tranvía en {object:171524}.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, en {object:32372}",

	-- Step 30: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tranvía a {zone:1453}",

	-- Step 31: Elwynn Forest
	-- {zone:1453} Stormwind · {area:87} Goldshire
	["From the tram, leave {zone:1453} by the main gate and follow the road through {area:87} and east through Elwynn to Redridge."] = "Desde el tranvía, sal de {zone:1453} por la puerta principal y sigue el camino por {area:87} y al este por Elwynn hasta Crestagrana.",
	["The road east to Redridge"] = "El camino al este hacia Crestagrana",

	-- Step 32: Guard Thomas
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora · {npc:240} Marshal Dughan · {quest:35} Further Concerns · {area:87} Goldshire
	["{npc:261} guards the bridge on this road east, past the {area:91}: {npc:240}'s {quest:35}, from your walk through {area:87}, goes to him."] = "{npc:261} vigila el puente de este camino al este, pasando {area:91}: {quest:35} de {npc:240}, de tu paso por {area:87}, va para él.",
	-- {npc:261} Guard Thomas
	["{npc:261}, on the bridge"] = "{npc:261}, en el puente",

	-- Step 33: Henze Faulk
	-- {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["From the bridge, head north to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Desde el puente, ve al norte hasta {area:86}. {npc:6172} yace al sur del lago: usa {item:6866} sobre él. Los magos renegados Defias de alrededor llevan {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Usa {item:6866} en {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Zahoríes bribones de Defias",

	-- Step 34: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker
	["The road crosses into Redridge at {area:1002}. {npc:464} walks around the crossroads."] = "El camino entra a Crestagrana por {area:1002}. {npc:464} recorre el cruce.",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "{npc:464} recorre {area:1002}: busca dentro del círculo del mapa",

	-- Step 35: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} stands by the road next to her."] = "Sigue el camino por la orilla sur de {area:68} hasta la maestra de grifos. {npc:1070} está junto al camino, a su lado.",

	-- Step 36: Lakeshire
	-- {npc:8965} Shawn · {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:415} Verner Osgood · {npc:344} Magistrate Solomon · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:379} Darcy · {npc:343} Chef Breanna
	["Cross the long bridge north into town: {npc:8965} and {npc:8962} play by the shore at its north end, {npc:341} and {npc:382} stand there too, {npc:415} by the smithy, {npc:344} in the town hall, {npc:381} on the docks, {npc:266} upstairs in the inn and {npc:379} and {npc:343} inside it."] = "Cruza el puente largo al norte hacia el pueblo: {npc:8965} y {npc:8962} juegan en la orilla, en su extremo norte, {npc:341} y {npc:382} también están ahí, {npc:415} junto a la herrería, {npc:344} en el ayuntamiento, {npc:381} en los muelles, {npc:266} arriba en la posada y {npc:379} y {npc:343} adentro.",
	-- {npc:382} Marshal Marris
	["{npc:382}: the Blackrock camps are for your next Redridge visit, at about 24"] = "{npc:382}: los campamentos Roca Negra son para tu próxima visita a Crestagrana, cerca del nivel 24",
	-- {npc:415} Verner Osgood · {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:415}: for {npc:514} in {area:87}"] = "{npc:415}: para {npc:514} en {area:87}",
	-- {npc:344} Magistrate Solomon · {npc:466} General Marcus Jonathan · {zone:1453} Stormwind
	["{npc:344}, in the town hall: for {npc:466} in {zone:1453}"] = "{npc:344}, en el ayuntamiento: para {npc:466} en {zone:1453}",
	-- {npc:266} Wiley the Black
	["{npc:266}, in the inn; upstairs"] = "{npc:266}, en la posada; arriba",
	-- {npc:379} Darcy
	["{npc:379}, inside"] = "{npc:379}, adentro",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "{npc:343}, adentro",

	-- Step 37: Guard Parker
	-- {area:1002} Three Corners
	["West along the road to {area:1002} first; the gnolls are on the way back east."] = "Primero al oeste por el camino hasta {area:1002}; los gnolls están en el camino de vuelta al este.",

	-- Step 38: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "{area:1001}: mata a estos según te los encuentres",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Great Goretusks = {npc:547} Great Goretusk · Dire Condors = {npc:428} Dire Condor
	["Redridge Mongrels and Thrashers hold the hills east of {area:1002}, north of the road; Poachers camp south of the road. Great Goretusks root around the same hills and Dire Condors circle south of the lake; Tarantulas crawl round {area:1002}."] = "Los bastardos y descarnadores de Crestagrana ocupan las colinas al este de {area:1002}, al norte del camino; los furtivos acampan al sur del camino. Los grandes dentosangre hozan por las mismas colinas y los cóndores temibles sobrevuelan el sur del lago; las tarántulas andan alrededor de {area:1002}.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: Descarnadores de Crestagrana ({npc:712})",
	-- {item:1081} Crisp Spider Meat
	["{item:1081}: Tarantulas"] = "{item:1081}: tarántulas",

	-- Step 39: Deputy Feldon
	-- {npc:1070} Deputy Feldon
	["East along the road to the gryphon master; {npc:1070} stands beside her."] = "Al este por el camino hasta la maestra de grifos; {npc:1070} está a su lado.",

	-- Step 40: Sunken Chest
	-- {area:68} Lake Everstill · {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Back toward town, swim east from the bridge into {area:68}; the chest lies on the lake bed beside a sunken boat. Murloc Flesheaters and Tidecallers line the south shore around it: any of them can carry a {item:1467}."] = "De vuelta hacia el pueblo, nada al este desde el puente hasta {area:68}; el cofre está en el fondo del lago junto a un bote hundido. Los comecarne y clamamareas múrloc ocupan la orilla sur alrededor: cualquiera puede llevar un {item:1467}.",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "{item:1309}; bajo el agua",

	-- Step 41: Hilary's Necklace
	-- {object:154357} Glinting Mud
	["Then west under the bridge: a {object:154357} mound on the lake bed beside town holds the necklace. Only one mound shows at a time, anywhere from under the dock to past the bridge."] = "Luego al oeste por debajo del puente: un montículo de {object:154357} en el fondo del lago junto al pueblo tiene el collar. Solo aparece un montículo a la vez, en cualquier lugar desde debajo del muelle hasta más allá del puente.",
	-- {quest:3741} Hilary's Necklace
	["{quest:3741}; underwater"] = "{quest:3741}; bajo el agua",

	-- Step 42: Lakeshire
	-- {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren · {npc:342} Martie Jainrose · {npc:379} Darcy · {npc:343} Chef Breanna
	["Through town east to west: {npc:8962} and {npc:341} at the north end of the bridge, {npc:381} on the docks, then {npc:342}'s garden at the west end; {npc:379} and {npc:343} are in the inn."] = "Por el pueblo de este a oeste: {npc:8962} y {npc:341} en el extremo norte del puente, {npc:381} en los muelles, luego el huerto de {npc:342} en el extremo oeste; {npc:379} y {npc:343} están en la posada.",
	-- {zone:1436} Westfall
	["Its pikes and rivets come from the gnolls north of the lake, on the loop after {zone:1436}"] = "Sus picas y remaches salen de los gnolls al norte del lago, en el circuito después de {zone:1436}",

	-- Step 43: Dockmaster Baren
	-- {npc:381} Dockmaster Baren · {quest:150} Murloc Poachers · {area:69} Lakeshire
	["From level 20 {npc:381} gives {quest:150}: take it now if he offers it (otherwise on the last {area:69} stop). Its murlocs are for your next Redridge visit, at about 24."] = "Desde el nivel 20 {npc:381} da {quest:150}: tómala ahora si te la ofrece (si no, en la última parada en {area:69}). Sus múrlocs son para tu próxima visita a Crestagrana, cerca del nivel 24.",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks"] = "{npc:381}, en los muelles",

	-- Step 44: Goldshire
	-- {area:1002} Three Corners · {area:87} Goldshire
	["West out of Redridge by {area:1002} and along the road through Elwynn to {area:87}."] = "Al oeste saliendo de Crestagrana por {area:1002} y por el camino a través de Elwynn hasta {area:87}.",

	-- Step 45: Smith Argus
	-- {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:514} works at the {area:87} smithy."] = "{npc:514} trabaja en la herrería de {area:87}.",

	-- Step 46: Stormwind's gate
	-- {zone:1453} Stormwind
	["{zone:1453}'s gate"] = "La puerta de {zone:1453}",
	-- {npc:234} Gryan Stoutmantle · {zone:1436} Westfall · {area:87} Goldshire · {zone:1453} Stormwind · {npc:466} General Marcus Jonathan · {object:2096} Trade District · {area:69} Lakeshire
	["No Defias Brotherhood from Wiley (it starts with {npc:234}'s letter in {zone:1436}): skip {zone:1436}. North along the road from {area:87} to {zone:1453}: {npc:466} sits on his horse at the far end of the bridge outside the main gate. Then the gryphons in the {object:2096}, back to {area:69}."] = "Wiley no da la Hermandad Defias (empieza con la carta de {npc:234} en {zone:1436}): sáltate {zone:1436}. Al norte por el camino desde {area:87} hasta {zone:1453}: {npc:466} está montado en su caballo al final del puente, afuera de la puerta principal. Luego los grifos de {object:2096}, de vuelta a {area:69}.",
	-- {npc:466} General Marcus Jonathan
	["{npc:466}, outside the main gate"] = "{npc:466}, afuera de la puerta principal",

	-- Step 47: Westfall
	-- {zone:1436} Westfall
	["West through Westbrook into {zone:1436}."] = "Al oeste por Arroyoeste hasta {zone:1436}.",

	-- Step 48: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Down the road to {area:108}. {npc:234} stands at the top of the stone tower."] = "Baja por el camino hasta {area:108}. {npc:234} está en lo alto de la torre de piedra.",
	-- {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["For {npc:332} in {zone:1453}"] = "Para {npc:332} en {zone:1453}",

	-- Step 49: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "Maestro de vuelo de {area:108}",

	-- Step 50: Stormwind
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:466} General Marcus Jonathan · {object:2096} Trade District
	["{npc:332} is upstairs in the SI:7 building in {object:2100}: the stairs are hard to see at first. {npc:466} sits on his horse at the far end of the bridge outside the main gate, then back to the gryphons in the {object:2096}."] = "{npc:332} está arriba en el edificio del IV:7 en {object:2100}: al principio cuesta ver la escalera. {npc:466} está montado en su caballo al final del puente, afuera de la puerta principal; luego de vuelta a los grifos de {object:2096}.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7; upstairs"] = "{npc:332}, IV:7; arriba",

	-- Step 51: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["{npc:234}, at the top of the tower"] = "{npc:234}, en lo alto de la torre",

	-- Step 52: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} y las colinas Defias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "Los acechacaminos y nudillos Defias recorren {area:20}; los bandoleros Defias (nivel 17) patrullan de a dos las colinas al sur y al este: sepáralos. La entrada de {area:1581}, en la herrería, es una mazmorra de grupo.\nCuidado: Los campamentos de las colinas tienen grupos mixtos de Defias, así que es fácil atraer a más de uno a la vez si eres de nivel bajo.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, de las cajas alrededor de {area:20}",

	-- Step 53: The Defias Messenger
	-- {npc:550} Defias Messenger
	["The {npc:550}"] = "{npc:550}",
	-- {area:20} Moonbrook · {npc:550} Defias Messenger · {area:113} Gold Coast Quarry · {area:111} Jangolode Mine
	["South along the road to {area:20}. The {npc:550} starts in front of the {area:20} smithy and walks north to the {area:113} and the back of the {area:111}, then back: look along his road. Slow him when he runs at 30% health."] = "Al sur por el camino hasta {area:20}. {npc:550} sale de frente a la herrería de {area:20} y camina al norte hasta {area:113} y el fondo de {area:111}, y luego vuelve: búscalo a lo largo de su camino. Ralentízalo cuando huya al 30% de salud.",
	-- {item:1381} A Mysterious Message · {npc:550} Defias Messenger
	["{item:1381}: the {npc:550}"] = "{item:1381}: {npc:550}",

	-- Step 54: Westfall Lighthouse
	-- {area:20} Moonbrook · {npc:392} Captain Grayson · {npc:391} Old Murk-Eye
	["South-west from {area:20} to the lighthouse on the point: {npc:392} waits on its steps. {npc:391} walks the beach and the shallows north-east of it among the murlocs: pull him away from the Oracles."] = "Al suroeste desde {area:20} hasta el faro de la punta: {npc:392} espera en sus escalones. {npc:391} recorre la playa y las aguas bajas al noreste, entre los múrlocs: apártalo de los oráculos.",
	-- {item:3636} Scale of Old Murk-Eye · {npc:391} Old Murk-Eye
	["{item:3636}: {npc:391}, on the beach north-east of the lighthouse"] = "{item:3636}: {npc:391}, en la playa al noreste del faro",

	-- Step 55: Captain Grayson
	-- {zone:1436} Westfall · {npc:392} Captain Grayson
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Kept five Flasks of Oil from {zone:1436}'s Harvest Watchers? {npc:392} takes them for his lighthouse fire."] = "¿Guardaste cinco frascos de aceite de los vigías de la cosecha de {zone:1436}? {npc:392} los recibe para el fuego de su faro.",

	-- Step 56: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:467} The Defias Traitor
	["Back north up the road to {area:108}. {npc:467} waits at the foot of the tower ramp; if he is missing, someone is escorting him and he is back within minutes."] = "De vuelta al norte por el camino hasta {area:108}. {npc:467} espera al pie de la rampa de la torre; si no está, alguien lo está escoltando y vuelve en unos minutos.",

	-- Step 57: The Defias Traitor
	-- {area:20} Moonbrook
	["Stay with the traitor as he walks south to {area:20}; he does not stop for fights, so clear what follows him. His walk ends at the Defias hideout below {area:20}."] = "Quédate con el traidor mientras camina al sur hasta {area:20}; no se detiene a pelear, así que despeja lo que lo siga. Su caminata termina en el escondite Defias debajo de {area:20}.",
	-- {npc:467} The Defias Traitor
	["{npc:467}, at the foot of the tower ramp"] = "{npc:467}, al pie de la rampa de la torre",

	-- Step 58: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["Back north to {npc:234} and the gryphons."] = "De vuelta al norte con {npc:234} y los grifos.",

	-- Step 59: Lakeshire
	-- {npc:415} Verner Osgood · {npc:344} Magistrate Solomon
	["From the gryphons, over the bridge into town: {npc:415} by the smithy, {npc:344} in the town hall."] = "Desde los grifos, cruza el puente hacia el pueblo: {npc:415} junto a la herrería, {npc:344} en el ayuntamiento.",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, en el ayuntamiento",

	-- Step 60: Redridge Canyons
	-- {spell:133} Fireball
	-- plural, as words: Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["Redridge Brutes and Mystics hold the hills north and north-west of town; both carry the Iron Pikes and Rivets. Black Dragon Whelps nest in the same hills.\nCareful: The whelps cast {spell:133} from range, and the gnolls run for help at low health."] = "Los brutos y místicos de Crestagrana ocupan las colinas al norte y noroeste del pueblo; ambos llevan las picas de hierro y los remaches. Las crías de dragón negro anidan en las mismas colinas.\nCuidado: Las crías lanzan {spell:133} a distancia, y los gnolls huyen a pedir ayuda con poca salud.",
	-- {item:1221} Underbelly Whelp Scale
	-- plural, as words: Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["{item:1221}: Black Dragon Whelps"] = "{item:1221}: crías de dragón negro",

	-- Step 61: Lakeshire
	-- {npc:415} Verner Osgood · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren
	["Back down into town: {npc:415} by the smithy, {npc:341} at the north end of the bridge, {npc:381} on the docks."] = "De vuelta abajo al pueblo: {npc:415} junto a la herrería, {npc:341} en el extremo norte del puente, {npc:381} en los muelles.",
	-- {npc:341} Foreman Oslow · {quest:98386} Alther's Mill
	["{npc:341}: {quest:98386}, for your next Redridge visit"] = "{npc:341}: {quest:98386}, para tu próxima visita a Crestagrana",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks: the murlocs are for your next Redridge visit"] = "{npc:381}, en los muelles: los múrlocs son para tu próxima visita a Crestagrana",

	-- Step 62: Fly to Stormwind
	-- {area:442} Auberdine · {zone:1439} Darkshore · {zone:1453} Stormwind
	["Back to {area:442} for {zone:1439}'s southern loops: the gryphon to {zone:1453}, then the boat from the harbour."] = "De vuelta a {area:442} para los circuitos del sur de {zone:1439}: el grifo a {zone:1453} y luego el barco desde el puerto.",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "Maestro de vuelo de {area:69}",

	-- Step 64: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:28027} Dwarven District
	["{npc:1646} stands at the east side of {object:2098}, on the way from the {object:28027} to the harbour."] = "{npc:1646} está en el lado este de {object:2098}, de camino desde {object:28027} al puerto.",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: la Carta de Thundris de {area:442}",
	-- {npc:3649} Thundris Windweaver
	["For {npc:3649}, where the boat lands"] = "Para {npc:3649}, donde atraca el barco",

	-- Step 65: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {object:2098} Cathedral Square
	["{npc:6173} and {npc:6171} are in the Cathedral of Light, on {object:2098}, on the way to the harbour."] = "{npc:6173} y {npc:6171} están en la Catedral de la Luz, en {object:2098}, de camino al puerto.",
	["Cathedral of Light"] = "Cathedral of Light",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Redención",
}
