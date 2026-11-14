-- Spanish (Latin America) (esMX): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "Reputación: Darnassus",
	-- {item:11040} Morrowgrain · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["Cloth, {item:11040} and the {zone:1438} and {zone:1439} hubs: the quests pay most while you level."] = "Paño, {item:11040} y los centros de {zone:1438} y {zone:1439}: las misiones pagan más mientras subes de nivel.",
	-- {faction:69} Darnassus
	["Exalted with {faction:69}: in Classic, other races may buy the nightsabers"] = "Exaltado con {faction:69}: en Classic, otras razas pueden comprar los sables de la noche",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain
	["{quest:3803}: 50 reputation for every 10 {item:11040}, as often as you like"] = "{quest:3803}: 50 de reputación por cada 10 {item:11040}, cuantas veces quieras",
	-- {faction:69} Darnassus · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439}"] = "Unos 3.700 de reputación con {faction:69} de misiones de nivel bajo en {zone:1438} y {zone:1439}",

	-- Step 1: Raedon Duskstriker, the cloth quartermaster
	-- {npc:14725} Raedon Duskstriker
	["{npc:14725}, the cloth quartermaster"] = "{npc:14725}, el intendente de paño",
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {area:1659} Craftsmen's Terrace · {item:14047} Runecloth · {quest:7801} Additional Runecloth · {area:1662} Tradesmen's Terrace · {zone:1438} Teldrassil · {zone:1439} Darkshore · {zone:1440} Ashenvale · {quest:4183} The True Masters · {zone:1428} Burning Steppes · {item:11040} Morrowgrain · {area:188} Shadowglen · {area:186} Dolanaar · {area:442} Auberdine · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{npc:14725} takes cloth for {faction:69}; he stands in the {area:1659}, in the north-east of {faction:69}, by the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7801} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the {area:1662} is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1438} (levels 1-12), {zone:1439} (11-20) and {zone:1440} (18-30) while you level through them. After the donations come {quest:4183} in the {zone:1428} and {item:11040}, a second repeatable turn-in; then the optional hubs, best rate first: {area:188} (about 35 a minute at full value), {area:186} (28), {area:442} (23). Every {faction:69} gain also gives a quarter as much to {zone:1453}, {zone:1455} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14725} acepta paño para {faction:69}; está en {area:1659}, en el noreste de {faction:69}, junto a los sastres. Cada primera donación de 60 de lana, seda, tejido mágico y {item:14047} paga 150 de reputación una sola vez; después de la de {item:14047}, {quest:7801} paga 50 por cada 20 {item:14047}, cuantas veces quieras. La casa de subastas de {area:1662} es la forma más rápida de conseguir paño. En Classic, las misiones pagan la reputación completa mientras estén como mucho 5 niveles por debajo de ti, así que haz {zone:1438} (niveles 1-12), {zone:1439} (11-20) y {zone:1440} (18-30) mientras subes por ellas. Después de las donaciones vienen {quest:4183} en {zone:1428} y {item:11040}, una segunda entrega repetible; luego los centros opcionales, del mejor ritmo al peor: {area:188} (unos 35 por minuto a valor completo), {area:186} (28), {area:442} (23). Cada ganancia con {faction:69} también da un cuarto a {zone:1453}, {zone:1455} y los Exiliados de Gnomeregan, salvo las misiones de las zonas iniciales de nivel 1-10. El Diplomático del Legado suma hasta un 10% a cada ganancia.",
	-- {item:2592} Wool Cloth · {zone:1439} Darkshore · {zone:1440} Ashenvale
	["{item:2592}: furbolgs, satyrs and naga in {zone:1439} and {zone:1440}"] = "{item:2592}: fúrbolgs, sátiros y nagas en {zone:1439} y {zone:1440}",

	-- Step 2: Shadowglen
	-- {zone:1438} Teldrassil · {area:256} Aldrassil
	["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation in 30 minutes at 60. The givers stand around {area:256}, the great tree. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: el claro inicial de los elfos de la noche en el noreste de {zone:1438}, unos 1.050 de reputación en 30 minutos a nivel 60. Los que dan misiones están alrededor de {area:256}, el gran árbol. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 3: Shadowglen: the glade and the spider den
	-- {area:188} Shadowglen
	["{area:188}: the glade and the spider den"] = "{area:188}: el claro y la guarida de arañas",
	-- {area:256} Aldrassil · {item:3297} Fel Moss · {npc:8584} Iverron
	["The nightsabers and boars roam the glade; the grells around {area:256} drop the {item:3297}; the totems stand in the furbolg camp north-west of the tree; the Webwood spiders live in the cave north of the glade. {npc:8584} waits outside that cave."] = "Los sables de la noche y los jabalíes recorren el claro; los grells alrededor de {area:256} sueltan el {item:3297}; los tótems están en el campamento de fúrbolgs al noroeste del árbol; las arañas Tejemadera viven en la cueva al norte del claro. {npc:8584} espera afuera de esa cueva.",

	-- Step 4: Shadowglen: first hand-in
	-- {area:188} Shadowglen
	["{area:188}: first hand-in"] = "{area:188}: primera entrega",

	-- Step 5: Shadowglen: the egg and the antidote
	-- {area:188} Shadowglen
	["{area:188}: the egg and the antidote"] = "{area:188}: el huevo y el antídoto",
	-- {quest:917} Webwood Egg · {item:10640} Webwood Ichor
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["The {quest:917} lies at the back of the spider cave; the mushrooms grow by the trees, the lilies by the pools, and the {item:10640} drops from the Webwood Lurkers."] = "{quest:917} está al fondo de la cueva de arañas; los champiñones crecen junto a los árboles, los lirios junto a los estanques, y el {item:10640} lo sueltan los acechadores Tejemadera.",

	-- Step 6: Shadowglen: last hand-in
	-- {area:188} Shadowglen
	["{area:188}: last hand-in"] = "{area:188}: última entrega",
	-- {npc:8584} Iverron
	["{npc:8584}, outside the spider cave"] = "{npc:8584}, afuera de la cueva de arañas",

	-- Step 7: Dolanaar
	-- {faction:69} Darnassus · {npc:2151} Moon Priestess Amara
	["Optional: the village on the road to {faction:69}, about 1,250 reputation in 45 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub.\n{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "",
	-- {faction:69} Darnassus
	["Optional: the village on the road to {faction:69}, about 1,250 reputation in 45 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: la aldea del camino a {faction:69}, unos 1.250 de reputación en 45 minutos a nivel 60. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 8: Dolanaar: Denalan and the lake
	-- {area:186} Dolanaar · {npc:2080} Denalan
	["{area:186}: {npc:2080} and the lake"] = "{area:186}: {npc:2080} y el lago",
	-- {npc:2080} Denalan · {area:259} Lake Al'Ameth · {npc:2107} Gaerolas Talvethren · {area:260} Starbreeze Village · {area:186} Dolanaar
	["{npc:2080} tends his garden on the south-east shore of {area:259}; {npc:2107} stands upstairs in a house in {area:260}, east of {area:186}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2080} cuida su huerto en la orilla sureste de {area:259}; {npc:2107} está arriba en una casa de {area:260}, al este de {area:186}: sube por adentro, la flecha no distingue los pisos.",

	-- Step 9: Dolanaar: the woods around the village
	-- {area:186} Dolanaar
	["{area:186}: the woods around the village"] = "{area:186}: el bosque alrededor de la aldea",
	-- {faction:69} Darnassus · {npc:2038} Lord Melenas · {area:258} Fel Rock · {npc:2107} Gaerolas Talvethren
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["The timberlings by the lake drop seeds and sprouts; the Gnarlpine Ambushers lurk on the road west to {faction:69}; {npc:2038} waits deep in {area:258}, north-west of the village; the dreamcatcher lies in the furbolg camp east of the village, by {npc:2107}; the Nightsabers west of the village carry the pelts."] = "Los arbolitos junto al lago sueltan semillas y brotes; los emboscadores Tuercepinos acechan en el camino al oeste hacia {faction:69}; {npc:2038} espera en lo hondo de {area:258}, al noroeste de la aldea; el atrapasueños está en el campamento de fúrbolgs al este de la aldea, junto a {npc:2107}; los sables de la noche al oeste de la aldea llevan las pieles.",

	-- Step 10: Dolanaar: first hand-in
	-- {area:186} Dolanaar
	["{area:186}: first hand-in"] = "{area:186}: primera entrega",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151} patrulla el camino al oeste de la aldea: si no está en la flecha, sigue el camino hasta encontrarla.",

	-- Step 11: Dolanaar: the Ban'ethil Barrow Den's entrance
	-- {area:186} Dolanaar · {area:262} Ban'ethil Barrow Den
	["{area:186}: the {area:262}'s entrance"] = "{area:186}: la entrada de {area:262}",

	-- Step 12: Dolanaar: the relics and Ferocitas
	-- {area:186} Dolanaar
	["{area:186}: the relics and Ferocitas"] = "{area:186}: las reliquias y Ferocitas",
	-- {area:262} Ban'ethil Barrow Den · {area:186} Dolanaar
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["The four relics of Wakening lie in the {area:262}, south-west of {area:186}; Ferocitas and the Gnarlpine Mystics camp east of the village."] = "Las cuatro reliquias del Despertar están en {area:262}, al suroeste de {area:186}; Ferocitas y los místicos Tuercepinos acampan al este de la aldea.",
	-- {item:8050} Tallonkai's Jewel · {quest:2459} Ferocitas the Dream Eater
	["{item:8050}, from {quest:2459}"] = "{item:8050}, de {quest:2459}",

	-- Step 13: Dolanaar: Ursal the Mauler
	-- {quest:486} Ursal the Mauler · {area:478} Pools of Arlithrien · {zone:1438} Teldrassil
	["{quest:486}, a big bear, roams the {area:478} in south-west {zone:1438}."] = "{quest:486}, un oso grande, recorre {area:478} en el suroeste de {zone:1438}.",

	-- Step 14: Auberdine
	-- {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village
	["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation in an hour at 60. The givers stand along the town's street and pier. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: {area:442}, en {zone:1439}, a un viaje en barco desde {area:702}, unos 1.400 de reputación en una hora a nivel 60. Los que dan misiones están a lo largo de la calle y el muelle del pueblo. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 15: Auberdine: the coast and the woods
	-- {area:442} Auberdine
	["{area:442}: the coast and the woods"] = "{area:442}: la costa y el bosque",
	-- {area:445} Cliffspring Falls
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["The furbolg camp south of town counts for How Big a Threat; the Rabid Thistle Bears roam the woods south of town; the Highborne ghosts of the Ruins of Ameth'Aran, south-east of town, carry the relics, and Anaya's ghost walks there too; the bones lie on the beach south of town; the mushrooms grow in the {area:445} cave to the north-east."] = "El campamento de fúrbolgs al sur del pueblo cuenta para ¿Qué tan grande es la amenaza?; los osos cardo rabiosos recorren el bosque al sur del pueblo; los fantasmas Altonato de las ruinas de Ameth'Aran, al sureste del pueblo, llevan las reliquias, y el fantasma de Anaya también anda por ahí; los huesos están en la playa al sur del pueblo; los champiñones crecen en la cueva de {area:445}, al noreste.",
	-- {npc:2164} Rabid Thistle Bear · {quest:2139} Tharnariun's Hope · {npc:3701} Tharnariun Treetender
	["{npc:2164}: use {quest:2139} on it and lead it back to {npc:3701}"] = "{npc:2164}: usa {quest:2139} en él y llévalo de vuelta con {npc:3701}",
	-- {npc:2164} Rabid Thistle Bear
	["Capture a {npc:2164}"] = "Captura un {npc:2164}",
	-- {quest:954} Bashal'Aran
	["the blue aura in the ruins of {quest:954}"] = "el aura azul en las ruinas de {quest:954}",

	-- Step 16: Auberdine: first hand-in
	-- {area:442} Auberdine
	["{area:442}: first hand-in"] = "{area:442}: primera entrega",

	-- Step 17: Auberdine: the furbolgs, the bears and the grells
	-- {area:442} Auberdine
	["{area:442}: the furbolgs, the bears and the grells"] = "{area:442}: los fúrbolgs, los osos y los grells",
	-- {quest:955} Bashal'Aran
	["The Blackwood furbolgs camp south of town; the grells of {quest:955}, east of town, drop the earrings; the sea turtle remains lie on the beach west of town."] = "Los fúrbolgs Bosquenegro acampan al sur del pueblo; los grells de {quest:955}, al este del pueblo, sueltan los pendientes; los restos de tortuga marina están en la playa al oeste del pueblo.",

	-- Step 18: Auberdine: second hand-in
	-- {area:442} Auberdine
	["{area:442}: second hand-in"] = "{area:442}: segunda entrega",

	-- Step 19: Auberdine: the seal, the Den Mother and the pelts
	-- {area:442} Auberdine · {npc:6788} Den Mother
	["{area:442}: the seal, the {npc:6788} and the pelts"] = "{area:442}: el sello, la {npc:6788} y las pieles",
	-- {item:5338} Ancient Moonstone Seal · {quest:956} Bashal'Aran · {npc:6788} Den Mother · {zone:1439} Darkshore
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The {item:5338} drops from the satyrs of {quest:956}; destroy the seal at the flame there. The {npc:6788} lairs north-east of {quest:956}; the Moonstalker Sires and Matriarchs roam the south of {zone:1439}."] = "El {item:5338} lo sueltan los sátiros de {quest:956}; destruye el sello en la llama de ahí. La {npc:6788} tiene su guarida al noreste de {quest:956}; los sementales y matriarcas acechalunas recorren el sur de {zone:1439}.",
	["the seal at the ancient flame"] = "el sello en la llama antigua",

	-- Step 20: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1440} Ashenvale
	["{item:4306} drops from humanoids level 23 to 40: the satyrs and furbolgs of {zone:1440}, the Thistlefur and Foulweald camps, the Grimtotem of Stonetalon."] = "{item:4306} lo sueltan los humanoides de nivel 23 a 40: los sátiros y fúrbolgs de {zone:1440}, los campamentos Piel de Cardo y Bosque Infecto, los Tótem Siniestro de Sierra Espolón.",

	-- Step 21: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1444} Feralas · {zone:1446} Tanaris
	["{item:4338} drops from humanoids level 35 to 50: the Hatecrest naga and Gordunni ogres of {zone:1444}, the Dunemaul ogres of {zone:1446}."] = "{item:4338} lo sueltan los humanoides de nivel 35 a 50: las nagas Crestafuria y los ogros Gordunni de {zone:1444}, los ogros Machacaduna de {zone:1446}.",

	-- Step 22: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7801} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}, the Scourge cultists of the Plaguelands. Keep any {item:14047} past the first 60 for {quest:7801}."] = "{item:14047} lo sueltan los humanoides de nivel 50 en adelante: los fúrbolgs Muertobosque de {zone:1448}, los fúrbolgs Nevada de {zone:1452}, los sectarios de la Plaga de las Tierras de la Peste. Guarda todo el {item:14047} que pase de los primeros 60 para {quest:7801}.",

	-- Step 23: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {faction:69} Darnassus · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: 175 {faction:69} reputation for two quests (level 54: in Classic 140 at 60), and the chain goes on to {object:2117} for 175 {zone:1453}. The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{npc:9562}, en {area:2418}, en el sureste de {zone:1428}, inicia {quest:4183}: 175 de reputación con {faction:69} por dos misiones (nivel 54: en Classic 140 a nivel 60), y la cadena sigue hasta {object:2117} por 175 con {zone:1453}. Las crías negras y los {npc:7044} viven en las laderas al norte del Vigía; los {npc:7040} y {npc:7041}, al oeste, en el centro de la zona.",

	-- Step 24: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {faction:69} Darnassus · {npc:7916} Erelas Ambersky · {area:702} Rut'theran Village · {zone:1452} Winterspring · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands · {item:12663} Glyphed Oaken Branch
	["{npc:344} waits in the town hall of {area:69}; his next quest takes you to {object:2117} (the {zone:1453} guide follows it). Other {faction:69} quests at this level, for when you pass by: {npc:7916} in {area:702} has a wildkin chain into {zone:1452} (325 in all, with Ranshalla's escort), Arei's escort in {zone:1448} pays 150 after the {area:2479}'s chain, {npc:10739} at the {area:202} in the {zone:1422} 100 for the {item:12663}, and Put Her Down in Upper Blackrock Spire 100 with a group."] = "{npc:344} espera en el ayuntamiento de {area:69}; su siguiente misión te lleva a {object:2117} (la guía de {zone:1453} la sigue). Otras misiones de {faction:69} de este nivel, para cuando pases: {npc:7916}, en {area:702}, tiene una cadena de lechúcicos que va a {zone:1452} (325 en total, con la escolta de Ranshalla), la escolta de Arei en {zone:1448} paga 150 después de la cadena de {area:2479}, {npc:10739} en {area:202}, en {zone:1422}, 100 por el {item:12663}, y Acabar con ella en la Cumbre de Roca Negra superior 100 con un grupo.",

	-- Step 25: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (opcional)",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain · {npc:6735} Innkeeper Saelienne · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50: 220. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "{quest:3803} acepta 10 {item:11040} por 50, cuantas veces quieras, y paga completo a 60. La cadena anterior es de nivel 50: 220. {npc:6735} te manda con {npc:3516} en {area:1658}; quiere 20 {quest:3764}. (Los posaderos de {zone:1453} y {zone:1455} dan el mismo inicio.)",

	-- Step 28: Un'Goro Crater: Un'Goro Soil
	-- {quest:3764} Un'Goro Soil · {item:11040} Morrowgrain
	["Dig {quest:3764} from the dirt mounds all over the crater; most of the crater's beasts and the Gorishi silithids drop it too, about one kill in three. Take far more than 20: every pouch use takes 2, about 18 for each 10 {item:11040}."] = "Saca {quest:3764} de los montículos de tierra de todo el cráter; la mayoría de las bestias del cráter y los silítidos Gorishi también la sueltan, más o menos una de cada tres muertes. Junta mucho más de 20: cada uso de la bolsa gasta 2, unas 18 por cada 10 {item:11040}.",

	-- Step 29: Darnassus: Morrowgrain Research
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker · {item:11020} Evergreen Pouch · {quest:3764} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9047}, beside Fandral in the {area:1658}, takes the soil. {npc:4217} sells the {item:11020} and Packets of Tharlendris Seeds. With a seed packet and 2 {quest:3764} in your bags, use the pouch to grow an {item:11024} and open it: about one casing in three holds {item:11040} (1 to 5), the rest other herbs. The pouch works once every 10 minutes, so use it whenever it is ready while you do other things."] = "{npc:9047}, junto a Fandral en {area:1658}, recibe la tierra. {npc:4217} vende la {item:11020} y paquetes de semillas de Tharlendris. Con un paquete de semillas y 2 {quest:3764} en tus bolsas, usa la bolsa para hacer crecer una {item:11024} y ábrela: más o menos una vaina de cada tres tiene {item:11040} (de 1 a 5), el resto otras hierbas. La bolsa funciona una vez cada 10 minutos, así que úsala cada vez que esté lista mientras haces otras cosas.",

	-- Step 33: Darnassus: Morrowgrain Research
	-- {item:11040} Morrowgrain
	["{item:11040}: grow it here and open the casings"] = "{item:11040}: cultívalo aquí y abre las vainas",

	-- Step 34: Morrowgrain to Darnassus
	-- {item:11040} Morrowgrain · {npc:4217} Mathrengyl Bearwalker · {quest:3764} Un'Goro Soil · {item:14047} Runecloth · {npc:7879} Quintis Jonespyre · {area:1116} Feathermoon Stronghold · {zone:1444} Feralas
	["Every 10 {item:11040}: 50 reputation at {npc:4217}. Keep the pouch and buy seeds as you go. It is slow: about 9 casings, 90 minutes of pouch waits, 18 {quest:3764} and 9 seed packets for each hand-in, a little over 30 reputation an hour, so run it beside the {item:14047}. {npc:7879} at {area:1116} in {zone:1444} takes {item:11040} at the same rate, 25 for 5, after his own quest."] = "Cada 10 {item:11040}: 50 de reputación con {npc:4217}. Guarda la bolsa y compra semillas sobre la marcha. Es lento: unas 9 vainas, 90 minutos de espera de la bolsa, 18 {quest:3764} y 9 paquetes de semillas por cada entrega, poco más de 30 de reputación por hora, así que hazlo en paralelo con el {item:14047}. {npc:7879}, en {area:1116}, en {zone:1444}, acepta {item:11040} al mismo ritmo, 25 por 5, después de su propia misión.",

	-- Step 35: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801} hasta Honorable",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {quest:4183} The True Masters · {item:11040} Morrowgrain · {faction:69} Darnassus · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {zone:1444} Feralas
	["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7801}: 50 de reputación por 20 {item:14047}, cuantas veces quieras. Después de las cuatro primeras donaciones, un humano, enano o gnomo queda en Amistoso 700 de 6.000, así que Honorable está a 5.300: 106 entregas, 2.120 {item:14047} (los elfos de la noche empiezan 900 más arriba: 88 entregas; los Celestes empiezan en Neutral 500, así que a 7.900: 158, dos menos después de Explorando la Alianza). {quest:4183} y la cadena de {item:11040} de arriba restan 8 entregas, y cada 10 {item:11040} que entregues cuenta como una más; cada centro que hiciste resta de 20 a 28 más. Más misiones pagan con {faction:69}, completo mientras no estén más de 5 niveles por debajo de ti: el resto de {zone:1439} (unos 3.400 más), {area:415} en {zone:1440} (unos 3.900) y Plumaluna en {zone:1444} (unos 1.700). Cada ganancia con una ciudad también da un cuarto a las otras tres ciudades de la Alianza (no contado aquí). Entrega todo tu {item:14047} de una vez.",

	-- Step 36: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801} hasta Reverenciado",
	-- {item:14047} Runecloth
	["Honored: in Classic Darnassus's vendors take 10% off for you, Lelanai's nightsabers (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honorable: en Classic, los vendedores de Darnassus te hacen un 10% de descuento, incluidos los sables de la noche de Lelanai (20g, los veloces 200g); Forever no lo definió, y los sitios de guías informan un 5% en Amistoso que sube a un 20% en Exaltado. De Honorable a Reverenciado son 12.000 de reputación: 240 entregas, 4.800 {item:14047}.",

	-- Step 37: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801} hasta Exaltado",
	-- {item:14047} Runecloth · {area:1658} Cenarion Enclave · {faction:69} Darnassus
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, Lelanai at the {area:1658} in {faction:69} sells her nightsabers to other races in Classic; the Saber and Swift Saber guides cover them."] = "De Reverenciado a Exaltado son 21.000 de reputación: 420 entregas, 8.400 {item:14047}. En Exaltado, Lelanai, en {area:1658} de {faction:69}, vende sus sables de la noche a otras razas en Classic; las guías de Sable y Sable veloz los cubren.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Los Adeptos oscuros y Magos oscuros (nivel 58-60) lo sueltan aquí; cada muerte de la Plaga aquí también cuenta para {object:92525} (consulta esa guía). También sirve la casa de subastas.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Los Ogros Machacaduna (nivel 45-48) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7801} hasta ser Exaltado con {faction:69}. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7801}, 20 {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Los Bandidos Zarparrío y los Capataces Zarparrío (nivel 16-18) lo sueltan aquí. La casa de subastas también sirve.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Los Mercenarios de la Hermandad en Stromgarde (nivel 31-32) lo sueltan aquí. La casa de subastas también sirve.",
	-- ["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725} acepta paño para {faction:69} en {faction:69}. Las primeras donaciones de Paño de lana, Paño de seda, Paño de tejido mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7801} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar las monturas de esa raza. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{npc:14725}: {item:14047} delivered"] = "{npc:14725}: {item:14047} entregado",
	-- ["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801} pide 20 {item:14047} por entrega y se repite cuantas veces quieras. Lleva {item:14047} en múltiplos de 20 y entrégalos todos de una vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
