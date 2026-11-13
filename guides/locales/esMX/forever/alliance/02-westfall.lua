-- Spanish (Latin America) (esMX): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Goldshire
	-- {zone:1453} Stormwind · {zone:1436} Westfall · {area:87} Goldshire · {npc:241} Remy "Two Times" · {npc:240} Marshal Dughan · {quest:40} A Fishy Peril · {quest:35} Further Concerns · {quest:109} Report to Gryan Stoutmantle
	["On the road from {zone:1453} to {zone:1436}, {area:87} is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "En el camino de {zone:1453} a {zone:1436}, {area:87} es la primera parada: {npc:241} está afuera de la posada, {npc:240} a su lado. {quest:40} de {npc:241} va directo a Dughan, que luego da {quest:35}; su {quest:109} viene contigo a {zone:1436}.",
	-- {npc:240} Marshal Dughan · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:240}: for {npc:234} at {area:108}"] = "{npc:240}: para {npc:234} en {area:108}",

	-- Step 2: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {area:18} Crystal Lake · {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["East along the road past {area:18}: {npc:248242} and {npc:248248} stand at the foot of the tower."] = "Al este por el camino, pasando {area:18}: {npc:248242} y {npc:248248} están al pie de la torre.",

	-- Step 3: The bridge
	["The bridge"] = "El puente",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "{npc:261} vigila el puente del camino al este; {npc:248265} está justo del otro lado. Sus herramientas y los merodeadores y osos de Thomas están al sur del puente, en el camino de vuelta.",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "El campamento está al noreste del puente. Los Fardos de madera están alrededor del campamento y en el bosque al norte.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "{npc:278}, adentro",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Está junto al río, al noroeste del campamento maderero.",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Los Zahoríes bribones de Defias acampan en las orillas de {area:86}; también sueltan los Pañuelos de lino rojo. {object:56} está en la aldea múrloc de la orilla noreste.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Pañuelos de lino rojo",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "Los campamentos gnoll",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Los gnolls Zarparrío acampan en las colinas al oeste de {area:86}; {quest:91725} están en sus campamentos.",

	-- Step 8: The Jasperlode Mine's entrance
	-- {area:54} Jasperlode Mine
	["The {area:54}'s entrance"] = "Entrada de {area:54}",

	-- Step 9: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "{area:54}: mata a estos según te los encuentres",
	-- {item:247816} Mining Tools · {npc:471} Mother Fang · {npc:248474} Geosculptor Yip
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer · Mine Spiders = {npc:43} Mine Spider
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels.\nCareful: {npc:471} (7-10), the Mine Spiders (7-9) and {npc:248474} (7) are elites deep in the mine: pull the kobolds one at a time near the entrance and back out if an elite comes; they're easier with a friend."] = "La mina está al suroeste de los campamentos gnoll. {item:247816} están cerca de la entrada; los Geománticos kóbold ocupan los túneles.\nCuidado: {npc:471} (7-10), las Arañas de mina (7-9) y {npc:248474} (7) son élites en lo profundo de la mina: atrae a los kóbolds de uno en uno cerca de la entrada y retírate si viene un élite; son más fáciles con un amigo.",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "{npc:476} recorre {area:54}: busca dentro del círculo del mapa",

	-- Step 10: The Tower of Azora
	["Follow the hills south to the tower."] = "Sigue las colinas hacia el sur hasta la torre.",

	-- Step 11: Downstream
	-- {item:247813} Waterlogged Saw
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["East along the road, then into the river south of the bridge: the {item:247813}, Axe and Toolbox lie in it. Prowlers and Young Forest Bears roam its banks."] = "Al este por el camino, luego al río al sur del puente: {item:247813}, el hacha y la caja de herramientas están en él. Los merodeadores y osos del bosque jóvenes recorren sus orillas.",

	-- Step 14: Goldshire
	-- {area:87} Goldshire · {zone:1436} Westfall · {npc:240} Marshal Dughan
	["Follow the road west to {area:87}, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "Sigue el camino al oeste hasta {area:87}, de camino a {zone:1436}: {npc:240} está afuera de la posada.",

	-- Step 15: The Jansen Stead
	-- {zone:1436} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "Sigue el camino desde Elwynn hasta {zone:1436}: los Cejade están junto a su granja quemada, la primera del camino. Recoge avena de cualquier {object:2724} que encuentres en el circuito: el resto se junta en los campos de aquí, en el camino de vuelta.",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}: Humans may have it already from {npc:963} in Elwynn"] = "{npc:237}: puede que los Humanos ya la tengan de {npc:963} en Elwynn",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Solo si saqueaste {item:1972} en Elwynn: haz clic derecho en ella",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "Al sur por el camino, más allá del cruce. {npc:233} está fuera, {npc:235} en la casa, {npc:253395} en el granero al oeste. Jóvenes Colmillos y Desgarradores merodean los campos de la granja: empieza con los hígados y la carne del guiso de camino.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "{npc:235}, adentro",

	-- Step 19: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "Hocicos de Dentosangre",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "Los Dentosangre jóvenes hozan en los campos a lo largo del camino al sur desde lo de Saldean hasta {area:108}: consigue sus hocicos por el camino.",

	-- Step 20: Sentinel Hill's tower and Thor
	-- {area:108} Sentinel Hill · {npc:523} Thor
	["{area:108}'s tower and {npc:523}"] = "La torre de {area:108} y {npc:523}",
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:523} Thor · {npc:878} Scout Galiaan · {npc:1323} Osric Strang · {zone:1453} Stormwind · {npc:279} Morgan Pestle · {object:2096} Trade District · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town · {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {npc:352} Dungar Longdrink
	["{npc:234} and {npc:821} stand at the top of the stone tower, {npc:491} inside it, {npc:523} the gryphon master on the south side of the hill with {npc:878} beside him. {npc:523} gives you Lewis' note for {npc:1323} with a free flight to {zone:1453}: take it now. In {zone:1453}, {npc:279}'s shop is in the {object:2096} by the gryphons, {npc:1323}'s shop, {object:2156}, in {object:2100}; {npc:1646} stands in {object:2098} on the way back to {npc:352}, the gryphon master."] = "{npc:234} y {npc:821} están en lo alto de la torre de piedra, {npc:491} adentro, {npc:523}, el maestro de grifos, en el lado sur de la colina con {npc:878} a su lado. {npc:523} te da la nota de Lewis para {npc:1323} con un vuelo gratis a {zone:1453}: tómalo ahora. En {zone:1453}, la tienda de {npc:279} está en {object:2096}, junto a los grifos, y la de {npc:1323}, {object:2156}, en {object:2100}; {npc:1646} está en {object:2098}, de camino de vuelta a {npc:352}, el maestro de grifos.",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "{npc:491}, adentro",
	-- {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:878}, beside {npc:523}"] = "{npc:878}, junto a {npc:523}",
	-- {npc:523} Thor · {zone:1453} Stormwind
	["{npc:523}: the free flight he offers goes to {zone:1453}"] = "{npc:523}: el vuelo gratis que ofrece va a {zone:1453}",

	-- Step 21: Osric Strang
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, {object:2096}, by the gryphons"] = "{npc:279}, {object:2096}, junto a los grifos",
	-- {npc:1323} Osric Strang · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town
	["{npc:1323}, {object:2156} in {object:2100}"] = "{npc:1323}, {object:2156} en {object:2100}",

	-- Step 22: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:1323} Osric Strang · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["{npc:5480} trains warriors in {object:2100}, near {npc:1323}'s shop; the tram from {zone:1455} arrives in the {object:28027}, north of it. {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "{npc:5480} entrena a los guerreros en {object:2100}, cerca de la tienda de {npc:1323}; el tranvía de {zone:1455} llega a {object:28027}, al norte. {npc:6089} y {npc:6090} están juntos ahí, junto a {object:2152}. {npc:6090} pelea contigo por su tarro. Si {npc:5480} no te ofrece {quest:1638}, ve directo con {npc:6089}: te da {quest:1639} sin ella.",

	-- Step 23: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646}, {object:2098}: his compass is in his old house in {zone:1436}"] = "{npc:1646}, {object:2098}: su brújula está en su vieja casa de {zone:1436}",

	-- Step 25: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["{npc:376} is in the Cathedral of Light, across {object:2098} from {npc:1646}."] = "{npc:376} está en la Catedral de la Luz, al otro lado de {object:2098} frente a {npc:1646}.",

	-- Step 26: Dungar Longdrink
	-- {npc:352} Dungar Longdrink
	["{npc:352}, the gryphon master"] = "{npc:352}, el maestro de grifos",

	-- Step 27: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} y {npc:821} están en lo alto de la torre de piedra. {npc:491} está en la torre; {npc:878}, en el lado sur de la colina, junto a la posada y {npc:523}, el maestro de grifos.",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "{npc:491}, adentro: de vuelta de {zone:1453}",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, junto a {npc:878}",

	-- Step 29: Goretusk Livers as you go
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Goretusk Livers as you go"] = "Hígados de Dentosangre sobre la marcha",
	-- plural, as words: Goretusks = {npc:157} Goretusk · Young Goretusks = {npc:454} Young Goretusk
	["Goretusks and Young Goretusks root along every leg of this loop: kill the ones you pass for the pie's livers."] = "Los Dentosangre y Dentosangre jóvenes hozan en cada tramo de este circuito: mata los que encuentres para los hígados del pastel.",

	-- Step 30: Stringy Vulture Meat as you go
	-- {item:729} Stringy Vulture Meat
	["{item:729} as you go"] = "{item:729} sobre la marcha",
	["Fleshrippers circle the fields along this loop: kill the ones you pass for the stew's meat."] = "Los desgarradores sobrevuelan los campos de este circuito: mata los que encuentres para la carne del guiso.",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Desgarradores",

	-- Step 31: Red Leather Bandanas as you go
	-- {quest:153} Red Leather Bandanas
	["{quest:153} as you go"] = "{quest:153} sobre la marcha",
	-- {item:829} Red Leather Bandana · {object:290} Furlbrow's Wardrobe
	["Every Defias on this loop can drop a {item:829}: the Trappers and Smugglers, and the guards at {object:290}."] = "Cualquier Defias de este circuito puede soltar un {item:829}: los tramperos y contrabandistas, y los guardias de {object:290}.",

	-- Step 32: Defias Trappers and Smugglers
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Defias Trappers and Smugglers"] = "Tramperos y contrabandistas Defias",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North-west from {area:108} toward {area:918}: Defias Trappers and Smugglers camp in the fields between them."] = "Al noroeste desde {area:108} hacia {area:918}: los tramperos y contrabandistas Defias acampan en los campos entre ambos.",

	-- Step 33: Molsen Farm's well
	-- {area:918} Molsen Farm
	["{area:918}'s well"] = "El pozo de {area:918}",
	["Fill the vial at the farm's well"] = "Llena el vial en el pozo de la granja",

	-- Step 34: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "Los vigías de la cosecha de {area:918}",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "Los vigías de la cosecha y los gólems trabajan los campos alrededor de {area:918}; sueltan los isorresortes, los giroestabilizadores, {item:732} y a veces un {item:255155}. {npc:573}, un raro de nivel 20, anda por aquí: déjalo en paz.",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Vigías de la cosecha",
	-- {item:814} Flask of Oil · {npc:392} Captain Grayson · {area:115} Westfall Lighthouse
	["{item:814}: keep five for {npc:392} at the {area:115}, later on the route"] = "{item:814}: guarda cinco para {npc:392} en {area:115}, más adelante en la ruta",

	-- Step 35: The gnoll hills
	["The gnoll hills"] = "Las colinas de los gnolls",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "Al norte, a las colinas sobre {area:111}: allí andan los gnolls y exploradores Zarparrío (nivel 11-13), al este hacia {area:916}. Los gnolls más al sur y al oeste son de nivel 13-19: quédate en las colinas del norte.\nCuidado: Los gnolls que están muy juntos suelen sumarse a la pelea en grupo. Atraerlos de a uno es más seguro.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Garras gnoll",

	-- Step 36: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "Los múrlocs de {area:2}",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "Los correcostas y asaltantes múrloc ocupan la costa norte desde encima de la mina al este hacia {area:916}: avanza por la playa hacia el este. Huyen con poca salud: atráelos de a uno.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Agallas de múrloc de Playa Larga",

	-- Step 37: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "{object:290} está en la casa en ruinas al este de la mina, de camino a {area:916}.\nCuidado: Dos Defias montan guardia adentro, uno de ellos {npc:502}, con nombre propio y de nivel 15. Están vinculados, así que atacar a uno trae a los dos.",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "{object:290}; adentro",

	-- Step 38: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "Sacos de avena en los campos alrededor de la granja",
	["Fill the vial at the well"] = "Llena el vial en el pozo",

	-- Step 39: Finish the Goretusk Livers
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Finish the Goretusk Livers"] = "Termina los hígados de Dentosangre",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Still short of eight? Young Goretusks root in the fields just west of {area:107}."] = "¿Todavía te faltan para los ocho? Los Dentosangre jóvenes hozan en los campos justo al oeste de {area:107}.",

	-- Step 40: Finish the Stringy Vulture Meat
	-- {item:729} Stringy Vulture Meat
	["Finish the {item:729}"] = "Termina {item:729}",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Fleshrippers = {npc:199} Young Fleshripper
	["Still short of three? Young Fleshrippers circle the fields north-west of {area:107}."] = "¿Todavía te faltan para los tres? Los desgarradores jóvenes sobrevuelan los campos al noroeste de {area:107}.",

	-- Step 42: Finish the Red Leather Bandanas
	-- {quest:153} Red Leather Bandanas
	["Finish the {quest:153}"] = "Termina {quest:153}",
	-- {area:108} Sentinel Hill
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Still short of fifteen? Defias Trappers camp in the fields just west of {area:108}."] = "¿Todavía te faltan para los quince? Los tramperos Defias acampan en los campos justo al oeste de {area:108}.",

	-- Step 43: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Para {npc:266} en {area:69}, Montañas Crestagrana",

	-- Step 44: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "De regreso al norte, más allá de {area:918}, hasta la mina: los Cavadores kóbold trabajan adentro.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Cavadores kóbold",

	-- Step 45: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Al suroeste, hacia la costa, al oeste de {area:918}. Los Mineros Zarparrío trabajan la cantera.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineros Zarparrío",

	-- Step 46: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "{area:20}: mata a estos según te los encuentres",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {object:1166} Alexston's Chest · {area:219} Alexston Farmstead · {npc:1646} Baros Alexston · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}. {object:1166} stands in the farmhouse at the {area:219}, among them: {npc:1646}' compass is inside.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "Los saqueadores y desvalijadores Defias ocupan las granjas al oeste de {area:108}, entre el camino de la costa y {area:20}. {object:1166} está en la casa de {area:219}, entre ellos: la brújula de {npc:1646} está adentro.\nCuidado: La cueva de {area:113} tiene muchos Defias muy juntos, así que es fácil atraer a varios a la vez ahí.",
	-- {item:2998} A Simple Compass · {object:1166} Alexston's Chest
	["{item:2998}, from {object:1166}"] = "{item:2998}, de {object:1166}",

	-- Step 49: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Camina hasta {zone:1453}. {npc:376} está en la Catedral de la Luz.",

	-- Step 51: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "{npc:6171} y {npc:6173} están en la Catedral de la Luz; {npc:6174} está en {object:2096} y pide diez {item:2589} (la sueltan los humanoides; la casa de subastas la vende).",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "Haz clic derecho en {item:6775} que te da",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "{npc:6172}, junto a {area:86} en Elwynn, en el camino a Crestagrana",

	-- Step 52: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "{object:28027} de {zone:1453}",

	-- Step 53: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tranvía a {zone:1455}",

	-- Step 54: Shaman training
	["Shaman training"] = "Instrucción de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Ve a {zone:1453}. No tiene instructor de chamán: toma el {area:2257} desde el {object:28027} hasta {zone:1455}, entrena con {npc:258098}, luego toma el tren de vuelta para el barco.",

	-- Step 55: Stormwind
	-- {area:1519} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Walk to {area:1519}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "Camina hasta {area:1519}, o vuela si conoces su ruta de vuelo. Instructores: {object:2100} (guerreros, pícaros), la Catedral (paladines, sacerdotes), {object:2101} (magos, brujos), {object:28027} (cazadores), el Parque (druidas).",
	["In through the main gate (already done if you are in the city)"] = "Entra por la puerta principal (ya hecho si estás en la ciudad)",
	["Level 12, 14 and 16 spells"] = "Hechizos de nivel 12, 14 y 16",

	-- Step 56: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "De vuelta a {zone:1453}",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "Vuelve en el tranvía: sale en {object:28027} de {zone:1453}, donde empiezan los encargos de abajo.",

	-- Step 57: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} para Reunir los ingredientes del remedio (6123) en {zone:1439}: {npc:1313}, suministros de alquimia; los herboristas la recogen allá",
	-- {npc:1416} Grimand Elmore · {npc:1343} Mountaineer Stormpike · {zone:1432} Loch Modan
	["{npc:1416}: his package for {npc:1343} in {zone:1432}, later on the route"] = "{npc:1416}: su paquete para {npc:1343} en {zone:1432}, más adelante en la ruta",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "{npc:7232}, {object:28027}: para su hermano en {area:442}",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, Wizard's Sanctum: {quest:1861}",

	-- Step 59: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Ya que estás aquí: aprende {spell:202} con {npc:11867} ({object:2096}, 10 de plata); con armas de dos manos un guerrero sube de nivel más rápido.",

	-- Step 60: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "Ya que estás aquí: aprende {spell:202} con {npc:11867} ({object:2096}, 10 de plata); con armas de dos manos un paladín sube de nivel más rápido.",

	-- Step 61: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Ya que estás aquí: aprende Bastones con {npc:11867} ({object:2096}, 10 de plata); en un cazador, el arma cuerpo a cuerpo vale sobre todo por sus estadísticas, y las de dos manos son las que más tienen.",

	-- Step 62: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Ya que estás aquí: aprende Espadas con {npc:11867} ({object:2096}, 10 de plata); una espada en la mano principal hace subir de nivel a un pícaro a buen ritmo.",

	-- Step 63: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Ya que estás aquí: aprende Bastones con {npc:11867} ({object:2096}, 10 de plata); un bastón tiene más estadísticas de hechizo que un arma de una mano mientras subes de nivel.",

	-- Step 65: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vende suministros de pesca junto al canal, justo al oeste de {object:2096}; {npc:267118} pesca en el puerto, de camino al barco.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, de {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:108}"] = "De vuelta a {area:108}",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Los Acechacaminos Defias y los Nudillos Defias recorren {area:20}; los Bandoleros Defias (nivel 17) patrullan en parejas las colinas al sur y al este: sepáralos. La entrada a {area:1581}, en la herrería, es un calabozo de grupo.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Los Saqueadores Defias y los Despojadores Defias ocupan las granjas al oeste de {area:108}, entre el camino de la costa y {area:20}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Vuela o cabalga a {zone:1453}. Instructores: {object:2100} (guerreros, pícaros), la catedral (paladines, sacerdotes), {object:2101} (magos, brujos), el parque (druidas).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Vuela o cabalga a {zone:1453}. Instructores: {object:2100} (guerreros, pícaros), la catedral (paladines, sacerdotes), {object:2101} (magos, brujos), el parque (druidas). {npc:11026} trabaja en {object:28027}; {npc:279}, en {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Vuela o cabalga a {zone:1453}. {npc:376} está en la Cathedral of Light.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Vuela o cabalga a {zone:1453}. {npc:5480} instruye a los guerreros en {object:2100}; {npc:6089} y {npc:6090} están juntos junto a {object:2152}. {npc:6090} pelea contigo por su jarra.",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Vuela o camina hasta {zone:1453}. Instructores: {object:2100} (Guerreros, Pícaros), la Catedral (Paladines, Sacerdotes), {object:2101} (Magos, Brujos), el Parque (Druidas).",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Vuela o camina hasta {zone:1453}. {npc:376} está en la Catedral de la Luz.",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Vuela o camina hasta {zone:1453}. {npc:5480} entrena guerreros en {object:2100}; {npc:6089} y {npc:6090} están juntos junto a {object:2152} allí. {npc:6090} luchará contigo por su jarra.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Sigue el camino de Elwynn hasta {zone:1436}: los Furlbrow están sentados junto a su granja quemada, la primera al borde del camino. Recoge la avena de los Sacos de avena de los campos mientras avanzas.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Sigue el camino hacia el norte. {npc:233} está afuera, {npc:235} en la casa y {npc:253395} en el granero, al oeste.",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Para {npc:11026} en {object:28027}, {zone:1453}",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Más al norte por el camino. Los Cejade están sentados junto a su granja quemada. Recoge la avena de los Sacos de avena en los campos mientras avanzas y llena el vial en el pozo de la finca.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Más al norte por el camino. Los Cejade están sentados junto a su granja quemada. Recoge la avena de los Sacos de avena en los campos mientras avanzas.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "¿La piedra de hogar está en tiempo de reutilización? Sigue el camino hacia el noreste.",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Los Correcostas múrloc y los Asaltantes múrloc ocupan la playa al norte de la mina. Huyen con poca salud: atráelos de uno en uno.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Al norte de La Granja de Molsen. Los Tramperos Defias ({npc:504}) y los Contrabandistas Defias acampan afuera de la mina; los Cavadores kóbold ({npc:1236}) trabajan adentro. {object:290} está junto a la casa en ruinas al este de la mina.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Al norte de La Granja de Molsen. Los Tramperos Defias y los Contrabandistas Defias acampan afuera de la mina. {object:290} está junto a la casa en ruinas al este de la mina.",
	-- ["Only if he takes the isosprings alone"] = "Solo si acepta los isorresortes solos",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Cabalga a {zone:1453}. No tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y luego regresa en el tranvía para tomar el barco.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Los Gnomos de la Garra del Río y sus Exploradores (nivel 11-13) merodean por las colinas al sur de la costa, desde encima de {area:111} hasta el {area:916} hacia el este. Los gnomos más al sur y al oeste son de nivel 13-19: quédate en las colinas del norte.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Los Gnolls Zarparrío ({npc:117}) y los Exploradores Zarparrío recorren las colinas entre la costa y {area:916}.",
	-- ["Sacks of Oats"] = "Sacos de avena",
	-- ["The gnoll hills"] = "Las colinas de los gnolls",
	-- ["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "La mina está al suroeste de los campamentos gnoll. {item:247816} están cerca de la entrada; los Geománticos kóbold ocupan los túneles.",
	-- ["The north coast"] = "La costa norte",
	-- ["The western farms"] = "Las granjas del oeste",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "Al oeste de La Granja de Molsen, hacia la costa. Los Mineros Zarparrío ({npc:1426}) trabajan la cantera.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "Al oeste de la de Saldean. Los Vigías de la cosecha y los Gólems de la cosecha trabajan los campos; sueltan los isorresortes, los giroestabilizadores, {item:732} y a veces {item:255155}. {npc:573}, un raro de nivel 20, anda por aquí: déjalo en paz. Sigue matando Dentosangre y Desgarradores en cada tramo de este circuito.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Los Dentosangre jóvenes y los Desgarradores recorren los campos alrededor de la granja: empieza a reunir los hígados y la carne del estofado a la vuelta.",
	-- ["{area:20} and the Defias hills"] = "{area:20} y las colinas Defias",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}, de las cajas alrededor de {area:20}",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} y {npc:821} están en lo alto de la torre de piedra. {npc:491} está en la torre; {npc:878} y {npc:253092}, en el lado sur de la colina, junto a la posada y {npc:523}, el maestro de grifos.",
	-- ["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}; los Humanos se lo quitaron a {npc:963} en Elwynn",
	-- ["{npc:523}; skip the free flight it offers"] = "{npc:523}; omite el vuelo gratis que ofrece",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}: todos los Defias las sueltan",
}
