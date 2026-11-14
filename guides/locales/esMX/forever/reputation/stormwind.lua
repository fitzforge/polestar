-- Spanish (Latin America) (esMX): the guide forever/reputation/stormwind (forever/reputation/stormwind.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Stormwind Reputation"] = "Reputación: Ventormenta",
	-- {zone:1422} Western Plaguelands
	["Cloth, the {zone:1422}' cauldron quests and the Elwynn hubs: the quests pay most while you level."] = "Paño, las misiones de los calderos de {zone:1422} y los centros de Elwynn: las misiones pagan más mientras subes de nivel.",
	-- {faction:72} Stormwind
	["Exalted with {faction:72}: in Classic, other races may buy the horses"] = "Exaltado con {faction:72}: en Classic, otras razas pueden comprar los caballos",
	-- {faction:72} Stormwind · {area:3197} Chillwind Camp · {zone:1428} Burning Steppes
	["About 1,150 {faction:72} reputation from level 52-58 quests at {area:3197} and in the {zone:1428}"] = "Unos 1.150 de reputación con {faction:72} de misiones de nivel 52-58 en {area:3197} y en {zone:1428}",
	-- {faction:72} Stormwind · {area:717} Stockade
	["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717}"] = "Unos 4.500 de reputación con {faction:72} de misiones de nivel bajo en Elwynn y en {area:717}",

	-- Step 1: Clavicus Knavingham, the cloth quartermaster
	-- {npc:14722} Clavicus Knavingham
	["{npc:14722}, the cloth quartermaster"] = "{npc:14722}, el intendente de paño",
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {item:14047} Runecloth · {quest:7796} Additional Runecloth · {zone:1436} Westfall · {zone:1431} Duskwood · {zone:1422} Western Plaguelands · {zone:1428} Burning Steppes · {area:717} Stockade · {area:87} Goldshire · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{npc:14722} takes cloth for {faction:72}. The arrow leads to him; he stands upstairs inside his building. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7796} pays 50 for every 20 {item:14047}, as often as you like. The Auction House is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do Elwynn (levels 1-10), {zone:1436} (10-18), Redridge (15-25) and {zone:1431} (20-30) while you level through them. After the donations come the level 52-58 quests of the {zone:1422} and the {zone:1428} (about 1,150), then the optional low-level hubs, best rate first: Northshire and the city errands (about 40 a minute at full value), the {area:717} (30), Eastvale and {area:87} (25). Every {faction:72} gain also gives a quarter as much to {zone:1455}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14722} acepta paño para {faction:72}. La flecha lleva hasta él; está arriba, dentro de su edificio. Cada primera donación de 60 de lana, seda, tejido mágico y {item:14047} paga 150 de reputación una sola vez; después de la de {item:14047}, {quest:7796} paga 50 por cada 20 {item:14047}, cuantas veces quieras. La casa de subastas es la forma más rápida de conseguir paño. En Classic, las misiones pagan la reputación completa mientras estén como mucho 5 niveles por debajo de ti, así que haz Elwynn (niveles 1-10), {zone:1436} (10-18), Crestagrana (15-25) y {zone:1431} (20-30) mientras subes por ellas. Después de las donaciones vienen las misiones de nivel 52-58 de {zone:1422} y {zone:1428} (unos 1.150), y luego los centros opcionales de nivel bajo, del mejor ritmo al peor: Villanorte y los encargos de la ciudad (unos 40 por minuto a valor completo), {area:717} (30), Vallefresno del Este y {area:87} (25). Cada ganancia con {faction:72} también da un cuarto a {zone:1455}, {zone:1457} y los Exiliados de Gnomeregan, salvo las misiones de las zonas iniciales de nivel 1-10. El Diplomático del Legado suma hasta un 10% a cada ganancia.",
	-- {item:2592} Wool Cloth · {zone:1436} Westfall
	["{item:2592}: Defias, gnolls and kobolds in {zone:1436} and Redridge"] = "{item:2592}: Defias, gnolls y kóbolds en {zone:1436} y Crestagrana",

	-- Step 2: Stormwind errands
	-- {faction:72} Stormwind
	["{faction:72} errands"] = "Encargos en {faction:72}",
	-- {faction:72} Stormwind
	["Optional: four quick deliveries inside {faction:72} for 200 reputation in about five minutes. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: cuatro entregas rápidas dentro de {faction:72} por 200 de reputación en unos cinco minutos. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 3: Northshire Valley
	-- {area:87} Goldshire · {npc:823} Deputy Willem · {npc:197} Marshal McBride · {area:24} Northshire Abbey
	["Optional: the Human start valley north of {area:87}: about 1,600 reputation in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: el valle inicial de los humanos al norte de {area:87}: unos 1.600 de reputación en 40 minutos a nivel 60, el mejor ritmo de los centros. {npc:823} y {npc:197} están en {area:24}. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 4: Northshire: kobolds, wolves and bandanas
	["Northshire: kobolds, wolves and bandanas"] = "Villanorte: kóbolds, lobos y pañuelos",
	-- {npc:6} Kobold Vermin · {item:247834} Nibbled-On Book
	["The {npc:6} dig at the camp north of the abbey; the wolves roam the valley; the Defias at the vineyard east of the abbey drop the bandanas. Keep any {item:247834} a kobold drops: it starts Forever's book chain."] = "Las {npc:6} cavan en el campamento al norte de la abadía; los lobos recorren el valle; los Defias del viñedo al este de la abadía sueltan los pañuelos. Guarda cualquier {item:247834} que suelte un kóbold: inicia la cadena de libros de Forever.",
	-- {item:247834} Nibbled-On Book
	["{item:247834}, from the kobolds"] = "{item:247834}, de los kóbolds",

	-- Step 5: Northshire: back at the abbey
	["Northshire: back at the abbey"] = "Villanorte: de vuelta en la abadía",

	-- Step 6: Northshire: Echo Ridge, Garrick Padfoot and the vineyard
	-- {npc:103} Garrick Padfoot
	["Northshire: Echo Ridge, {npc:103} and the vineyard"] = "Villanorte: Cresta del Eco, {npc:103} y el viñedo",
	-- {area:34} Echo Ridge Mine · {npc:103} Garrick Padfoot · {quest:3904} Milly's Harvest · {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["The Kobold Workers are in {area:34} north of the abbey; {npc:103} stands in the Defias camp east of the vineyard; {quest:3904} crates lie in the vineyard; the rats carrying the {object:83763} run about the abbey grounds."] = "Los obreros kóbold están en {area:34}, al norte de la abadía; {npc:103} está en el campamento Defias al este del viñedo; las cajas de {quest:3904} están en el viñedo; las ratas que llevan los {object:83763} corren por los terrenos de la abadía.",

	-- Step 7: Northshire: second hand-in
	["Northshire: second hand-in"] = "Villanorte: segunda entrega",

	-- Step 8: Northshire: the mine and the books
	["Northshire: the mine and the books"] = "Villanorte: la mina y los libros",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80}, deep in {area:34}"] = "{npc:80}, en lo hondo de {area:34}",

	-- Step 9: Northshire: last hand-in
	["Northshire: last hand-in"] = "Villanorte: última entrega",
	-- {object:563442} Kobold Tracks
	["{object:563442}, east of the abbey"] = "{object:563442}, al este de la abadía",

	-- Step 10: Northshire: the books end in Goldshire
	-- {area:87} Goldshire
	["Northshire: the books end in {area:87}"] = "Villanorte: los libros terminan en {area:87}",
	-- {npc:240} Marshal Dughan · {area:87} Goldshire · {area:57} Fargodeep Mine
	-- plural, as words: Lost Books = {item:248001} Lost Book
	["{npc:240} stands in front of the Lion's Pride Inn in {area:87}. The Lost Books drop from the kobolds of {area:57} south of {area:87}; the picture book and the two rare books from the named kobolds there."] = "{npc:240} está frente a la Posada Orgullo de León, en {area:87}. Los libros perdidos los sueltan los kóbolds de {area:57}, al sur de {area:87}; el libro de dibujos y los dos libros raros, los kóbolds con nombre de ahí.",
	["Arcane Explainer"] = "Explicador arcano",
	-- {npc:951} Brother Paxton
	["{npc:951}, back at the abbey"] = "{npc:951}, de vuelta en la abadía",

	-- Step 11: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:253} William Pestle
	["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: {area:87}, Arroyoeste y las granjas al sur de {area:87}: unos 1.450 de reputación en una hora a nivel 60. {npc:240}, {npc:241} y {npc:253} están alrededor de la Posada Orgullo de León. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 12: Goldshire: the mines
	-- {area:87} Goldshire
	["{area:87}: the mines"] = "{area:87}: las minas",
	-- {area:57} Fargodeep Mine · {area:87} Goldshire · {area:54} Jasperlode Mine · {item:773} Gold Dust
	["{area:57} is south of {area:87}, {area:54} north-east of it. The kobolds in both drop the candles and the {item:773}; the wolves around {area:87} the pelts."] = "{area:57} está al sur de {area:87}, {area:54} al noreste. Los kóbolds de ambas sueltan las velas y el {item:773}; los lobos alrededor de {area:87}, las pieles.",

	-- Step 13: Goldshire: back at the inn
	-- {area:87} Goldshire
	["{area:87}: back at the inn"] = "{area:87}: de vuelta en la posada",

	-- Step 14: Goldshire: Jasperlode Mine
	["walk into the mine"] = "entra a la mina",

	-- Step 15: Goldshire: Westbrook and Hogger
	-- {area:87} Goldshire · {npc:448} Hogger
	["{area:87}: Westbrook and {npc:448}"] = "{area:87}: Arroyoeste y {npc:448}",
	-- {npc:448} Hogger · {area:120} Westbrook Garrison
	["{npc:448} is an elite gnoll west of {area:120}; at 60 he is no trouble. The Wanted poster hangs on the garrison."] = "{npc:448} es un gnoll élite al oeste de {area:120}; a nivel 60 no da problemas. El cartel de SE BUSCA cuelga en la guarnición.",
	-- {item:782} Painted Gnoll Armband
	["{item:782}, from the Riverpaw gnolls"] = "{item:782}, de los gnolls Zarparrío",
	-- {item:1931} Huge Gnoll Claw · {npc:448} Hogger
	["{item:1931}, from {npc:448}"] = "{item:1931}, de {npc:448}",

	-- Step 16: The farms south of Goldshire
	-- {area:87} Goldshire
	["The farms south of {area:87}"] = "Las granjas al sur de {area:87}",
	-- {area:87} Goldshire · {quest:87} Goldtooth · {area:57} Fargodeep Mine · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch
	["The Stonefields' farm and the Maclures' farm lie on either side of the road south of {area:87}. {quest:87} guards the back of {area:57}; {npc:330} the boar roams the {area:62}."] = "La granja de los Pedregosa y la de los Maclure están a ambos lados del camino al sur de {area:87}. {quest:87} vigila el fondo de {area:57}; {npc:330}, la jabalina, recorre {area:62}.",
	-- {item:1006} Brass Collar · {npc:330} Princess
	["{item:1006}, from {npc:330}"] = "{item:1006}, de {npc:330}",

	-- Step 17: Goldtooth and the kelp
	-- {quest:87} Goldtooth
	["{quest:87} and the kelp"] = "{quest:87} y el alga",
	-- {item:981} Bernice's Necklace · {quest:87} Goldtooth
	["{item:981}, from {quest:87}"] = "{item:981}, de {quest:87}",
	-- {item:1256} Crystal Kelp Frond · {area:18} Crystal Lake
	["{item:1256}, from the murlocs of {area:18}"] = "{item:1256}, de los múrlocs de {area:18}",

	-- Step 18: Goldshire: last hand-in
	-- {area:87} Goldshire
	["{area:87}: last hand-in"] = "{area:87}: última entrega",

	-- Step 19: Shipment to Stormwind
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, in the {object:2096}"] = "{npc:279}, en {object:2096}",

	-- Step 20: Eastvale
	["Eastvale"] = "Vallefresno del Este",
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora
	["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation in 40 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: el este de Elwynn, alrededor de {npc:261} en el puente y {area:91}, unos 1.000 de reputación en 40 minutos a nivel 60. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 21: Eastvale: the work
	["Eastvale: the work"] = "Vallefresno del Este: el trabajo",
	-- {area:91} Tower of Azora · {area:54} Jasperlode Mine
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear · Kobold Geomancers = {npc:476} Kobold Geomancer
	["The murlocs along the river south of the bridge drop the fins; Prowlers and Young Forest Bears roam the woods; the Defias around the Brackwell farm and the {area:91} carry the bandanas; the enchanting supplies lie in their camps north of the tower; the Kobold Geomancers dig at {area:54}; the tools and the river finds lie along the river north of the logging camp."] = "Los múrlocs a lo largo del río al sur del puente sueltan las aletas; los merodeadores y osos del bosque jóvenes recorren el bosque; los Defias alrededor de la granja Brackwell y {area:91} llevan los pañuelos; los suministros de encantamiento están en sus campamentos al norte de la torre; los geomantes kóbold cavan en {area:54}; las herramientas y los hallazgos del río están a lo largo del río al norte del campamento maderero.",

	-- Step 22: Eastvale: hand in
	["Eastvale: hand in"] = "Vallefresno del Este: entregas",

	-- Step 23: Eastvale: Defias Rogue Wizards
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Eastvale: Defias Rogue Wizards"] = "Vallefresno del Este: magos renegados Defias",
	["opens with Thomas' report"] = "se abre con el informe de Thomas",
	-- {item:780} Torn Murloc Fin
	["{item:780}, from the murlocs south of the bridge"] = "{item:780}, de los múrlocs al sur del puente",

	-- Step 24: Stockade: two quests
	-- {area:717} Stockade
	["{area:717}: two quests"] = "{area:717}: dos misiones",
	-- {area:717} Stockade · {faction:72} Stormwind · {object:2101} Mage Quarter · {npc:1719} Warden Thelwater · {npc:1721} Nikova Raskol · {object:2100} Old Town · {npc:1696} Targorr the Dread · {npc:859} Guard Berton · {area:69} Lakeshire · {npc:1663} Dextren Ward · {npc:270} Councilman Millstipe · {area:42} Darkshire · {npc:639} Edwin VanCleef · {area:1581} Deadmines
	["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation. {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: {area:717} es la prisión de {faction:72}, una mazmorra en los canales de {object:2101}. A nivel 60 la despejas solo en diez minutos: 300 de reputación. {npc:1719} está en la puerta, {npc:1721} en {object:2100}. Otras dos misiones de {area:717} empiezan fuera de la ciudad, 100 cada una, si pasas por ahí: Lo que se siembra... ({npc:1696}) de {npc:859} en {area:69} y Crimen y castigo ({npc:1663}) de {npc:270} en {area:42}. (Los disturbios de las Mazmorras, 100 más, requiere antes la Carta sin enviar de {npc:639} en {area:1581}.) Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 25: Inside the Stockade
	-- {area:717} Stockade
	["Inside the {area:717}"] = "Dentro de {area:717}",
	-- {npc:1716} Bazil Thredd
	-- plural, as words: Red Wool Bandanas = {item:2909} Red Wool Bandana
	["Kill the prisoners, convicts and insurgents in the cells; the Red Wool Bandanas drop from the Defias inside. {npc:1716} waits in the far end."] = "Mata a los prisioneros, convictos e insurgentes de las celdas; los pañuelos de lana rojos los sueltan los Defias de adentro. {npc:1716} espera al fondo.",

	-- Step 26: Stockade: hand in
	-- {area:717} Stockade
	["{area:717}: hand in"] = "{area:717}: entregas",

	-- Step 27: A Donation of Silk
	-- {item:4306} Silk Cloth · {area:94} Raven Hill
	["{item:4306} drops from humanoids level 23 to 40: Syndicate in Alterac and Arathi, the Defias of Duskwood's {area:94}, Stranglethorn's trolls."] = "{item:4306} lo sueltan los humanoides de nivel 23 a 40: el Sindicato en Alterac y Arathi, los Defias de {area:94} en el Bosque del Ocaso, los trols de Tuercespina.",

	-- Step 28: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1446} Tanaris · {zone:1444} Feralas · {zone:1418} Badlands
	["{item:4338} drops from humanoids level 35 to 50: the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}, the Shadowforge dwarves of the {zone:1418}."] = "{item:4338} lo sueltan los humanoides de nivel 35 a 50: los ogros Machacaduna de {zone:1446}, las nagas Crestafuria de {zone:1444}, los enanos Forjatiniebla de {zone:1418}.",

	-- Step 29: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7796} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60: it all goes to {quest:7796} later."] = "{item:14047} lo sueltan los humanoides de nivel 50 en adelante: los sectarios de la Plaga y la Cruzada Escarlata en las Tierras de la Peste, los fúrbolgs Muertobosque de {zone:1448}, los fúrbolgs Nevada de {zone:1452}. Guarda todo el {item:14047} que pase de los primeros 60: todo va a {quest:7796} después.",

	-- Step 30: Chillwind Camp: Clear the Way
	-- {npc:10838} Commander Ashlam Valorfist · {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {faction:72} Stormwind · {object:92525} Argent Dawn
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["These quests are level 52 to 58, so they pay in full at 60. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side. The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "Estas misiones son de nivel 52 a 58, así que pagan completo a 60. {npc:10838} y {npc:11053}, en {area:3197}, en el sur de {zone:1422}, te mandan contra los cuatro calderos de la Plaga: 820 de reputación con {faction:72} en total y 600 con {object:92525} de paso. Los despellejadores esqueléticos y necrófagos esclavizantes recorren los campos al norte del campamento.",

	-- Step 31: Andorhal and Felstone Field
	-- {area:199} Felstone Field
	["Andorhal and {area:199}"] = "Andorhal y {area:199}",
	-- {item:12815} Beacon Torch · {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {npc:10778} Janice Felstone · {faction:72} Stormwind
	["Mark the four watchtowers around Andorhal, north of the camp, with the {item:12815} at each door. {npc:11075} guards the cauldron at {area:199}, west of Andorhal; his key opens it. {npc:10778}'s ghost wanders by the Felstone farmhouse, and her parcel lies inside: it goes to {faction:72} for 150 more."] = "Marca las cuatro atalayas alrededor de Andorhal, al norte del campamento, con la {item:12815} en cada puerta. {npc:11075} vigila el caldero de {area:199}, al oeste de Andorhal; su llave lo abre. El fantasma de {npc:10778} vaga junto a la granja de los Campopiedra, y su paquete está adentro: va a {faction:72} por 150 más.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca {npc:10902} con la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca {npc:10903} con la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca {npc:10904} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca {npc:10905} con la {item:12815}",
	-- {item:13194} Felstone Field Cauldron Key · {npc:11075} Cauldron Lord Bilemaw
	["{item:13194}, from {npc:11075}"] = "{item:13194}, de {npc:11075}",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "el {object:176361}",
	-- {object:175894} Janice's Parcel
	["{object:175894}, in the farmhouse"] = "{object:175894}, en la granja",

	-- Step 33: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears · {area:199} Felstone Field
	["{npc:11077} guards the cauldron at {area:200}, north-east of {area:199}."] = "{npc:11077} vigila el caldero de {area:200}, al noreste de {area:199}.",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "el {object:177289}",

	-- Step 34: Chillwind Camp: the Writhing Haunt
	-- {area:3197} Chillwind Camp · {area:202} Writhing Haunt
	["{area:3197}: the {area:202}"] = "{area:3197}: {area:202}",

	-- Step 35: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["{npc:11076} guards the cauldron at the {area:202}, the farm east of {area:200}."] = "{npc:11076} vigila el caldero de {area:202}, la granja al este de {area:200}.",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "el {object:176393}",

	-- Step 37: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}, in the east of the zone."] = "{npc:11078} vigila el caldero de {area:201}, en el este de la zona.",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "el {object:176392}",

	-- Step 38: Chillwind Camp: done
	-- {area:3197} Chillwind Camp
	["{area:3197}: done"] = "{area:3197}: terminado",
	-- {npc:11056} Alchemist Arbington · {area:2057} Scholomance
	["{npc:11056} in the camp also ends The Key to {area:2057} (200), after a longer chain that needs a {area:2057} group."] = "{npc:11056}, en el campamento, también cierra La llave de {area:2057} (200), tras una cadena más larga que requiere un grupo para {area:2057}.",

	-- Step 39: Stormwind: Janice Felstone's parcel
	-- {faction:72} Stormwind · {npc:10778} Janice Felstone
	["{faction:72}: {npc:10778}'s parcel"] = "{faction:72}: el paquete de {npc:10778}",
	-- {npc:10782} Royal Factor Bathrilor · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {npc:3520} Ol' Emma
	["{npc:10782} stands in the city hall on {object:2098}, beside {npc:1646}; {npc:3520} walks the canals."] = "{npc:10782} está en el ayuntamiento de {object:2098}, junto a {npc:1646}; {npc:3520} recorre los canales.",

	-- Step 40: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {area:69} Lakeshire · {object:2117} Stormwind Keep · {faction:72} Stormwind · {zone:1457} Darnassus · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{npc:9562}, en {area:2418}, en el sureste de {zone:1428}, inicia {quest:4183}: una cadena que va a {area:69} y {object:2117}, 175 de reputación con {faction:72} y 175 con {zone:1457} (nivel 54). Las crías negras y los {npc:7044} viven en las laderas al norte del Vigía; los {npc:7040} y {npc:7041}, al oeste, en el centro de la zona.",

	-- Step 41: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire
	["{npc:344} waits in the town hall of {area:69}."] = "{npc:344} espera en el ayuntamiento de {area:69}.",

	-- Step 42: Stormwind Keep
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep · {npc:1749} Lady Katrana Prestor
	["{npc:1748} holds court in {object:2117} with {npc:1749} at his side: speak with her for the second of his quests."] = "{npc:1748} recibe en {object:2117} con {npc:1749} a su lado: habla con ella para la segunda de sus misiones.",
	-- {npc:1749} Lady Katrana Prestor
	["Speak with {npc:1749}"] = "Habla con {npc:1749}",

	-- Step 43: Lakeshire: Solomon again
	-- {area:69} Lakeshire
	["{area:69}: Solomon again"] = "{area:69}: Solomon otra vez",
	-- {area:1584} Blackrock Depths · {npc:9023} Marshal Windsor · {faction:72} Stormwind · {area:1583} Blackrock Spire · {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {area:2057} Scholomance
	["With a group the chain goes on into {area:1584}: {npc:9023}, Jail Break! and The Great Masquerade back in {faction:72} pay about 750 {faction:72} more, Maxwell's Mission (Lower {area:1583}) 250, Delivery to Ridgewell 135. Order Must Be Restored ({npc:11878} in the {zone:1423}) pays 200, The Key to {area:2057} 200; Onyxia's head 400 and Nefarian's 200 when the raids open."] = "Con un grupo, la cadena sigue en {area:1584}: {npc:9023}, ¡Fuga de la prisión! y La gran mascarada, de vuelta en {faction:72}, pagan unos 750 más con {faction:72}, La misión de Maxwell ({area:1583} inferior) 250, Entrega para Ridgewell 135. Hay que restaurar el orden ({npc:11878} en {zone:1423}) paga 200, La llave de {area:2057} 200; la cabeza de Onyxia 400 y la de Nefarian 200 cuando abran las bandas.",

	-- Step 44: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796} hasta Honorable",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {faction:72} Stormwind · {zone:1436} Westfall · {area:69} Lakeshire · {zone:1431} Duskwood · {area:42} Darkshire
	["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7796}: 50 de reputación por 20 {item:14047}, cuantas veces quieras. Después de las cuatro primeras donaciones, alguien que no es humano queda en Amistoso 700 de 6.000, así que Honorable está a 5.300: 106 entregas, 2.120 {item:14047} (los humanos empiezan 900 más arriba: 88 entregas; Explorando la Alianza de un Celeste pagó 100, dos menos). Las misiones de nivel 52-58 de arriba restan 23 entregas; cada centro de Elwynn que hiciste resta de 20 a 30 más. Más centros de misiones pagan con {faction:72}, completo mientras no estén más de 5 niveles por debajo de ti: {zone:1436} (unos 2.500 en total), {area:69} en Crestagrana (unos 3.000) y {area:42} en {zone:1431} (unos 2.900). Cada ganancia con una ciudad también da un cuarto a las otras tres ciudades de la Alianza (no contado aquí). Entrega todo tu {item:14047} de una vez.",

	-- Step 45: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796} hasta Reverenciado",
	-- {npc:384} Katie Hunter · {item:14047} Runecloth
	["Honored: in Classic Stormwind's vendors take 10% off for you, {npc:384}'s horses (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honorable: en Classic, los vendedores de Ventormenta te hacen un 10% de descuento, incluidos los caballos de {npc:384} (20g, los veloces 200g); Forever no lo definió, y los sitios de guías informan un 5% en Amistoso que sube a un 20% en Exaltado. De Honorable a Reverenciado son 12.000 de reputación: 240 entregas, 4.800 {item:14047}.",

	-- Step 46: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796} hasta Exaltado",
	-- {item:14047} Runecloth · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:384} at {area:88} sells her horses to other races in Classic; the Horse and Swift Horse guides cover them."] = "De Reverenciado a Exaltado son 21.000 de reputación: 420 entregas, 8.400 {item:14047}. En Exaltado, {npc:384}, en {area:88}, vende sus caballos a otras razas en Classic; las guías de Caballo y Caballo veloz los cubren.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Los Adeptos oscuros y los Magos oscuros (nivel 58-60) lo sueltan aquí; cada muerte de la Plaga aquí también cuenta para {object:92525} (consulta esa guía). La casa de subastas también sirve.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Los ogros Machacaduna (nivel 45-48) lo sueltan aquí. La casa de subastas también sirve.",
	-- ["Keep handing in {quest:7796} until {faction:72} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7796} hasta que {faction:72} sea Exaltado. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Keep handing in {quest:7796}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7796}, 20 de {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Los Bandidos Zarparrío y los Capataces Zarparrío (nivel 16-18) lo sueltan aquí. La casa de subastas también sirve.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Los Mercenarios de la Hermandad en Stromgarde (nivel 31-32) lo sueltan aquí. La casa de subastas también sirve.",
	-- ["{npc:14722} takes cloth for {faction:72} in {zone:1453}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7796} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14722} acepta paño para {faction:72} en {zone:1453}. Las primeras donaciones de Paño de lana, Paño de seda, Paño de tejido mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7796} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar las monturas de esa raza. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{npc:14722}: {item:14047} delivered"] = "{npc:14722}: {item:14047} entregado",
	-- ["{quest:7796} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796} acepta 20 de {item:14047} por entrega y se repite cuantas veces quieras. Lleva {item:14047} en múltiplos de 20 y entrégalo todo a la vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
