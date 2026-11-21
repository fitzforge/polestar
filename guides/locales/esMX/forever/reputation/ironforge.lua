-- Spanish (Latin America) (esMX): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "Reputación: Forjaz",
	-- {zone:1428} Burning Steppes · {zone:1426} Dun Morogh · {area:133} Gnomeregan · {zone:1459} Alterac Valley
	["Cloth, the {zone:1428} quests and the {zone:1426} hubs, which pay {area:133} too; {zone:1459} adds more."] = "Paño, las misiones de {zone:1428} y los centros de {zone:1426}, que también pagan con {area:133}; {zone:1459} suma más.",
	-- {faction:47} Ironforge
	["Exalted with {faction:47}: in Classic, other races may buy the rams"] = "Exaltado con {faction:47}: en Classic, otras razas pueden comprar los carneros",
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1459} Alterac Valley
	["About 600 {faction:47} reputation from level 52-59 quests in the {zone:1428} and {zone:1452}; {zone:1459}'s quests pay {faction:47} too"] = "Unos 600 de reputación con {faction:47} de misiones de nivel 52-59 en {zone:1428} y {zone:1452}; las misiones de {zone:1459} también pagan con {faction:47}",
	-- {faction:47} Ironforge · {zone:1426} Dun Morogh · {area:133} Gnomeregan
	["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too"] = "Unos 2.900 de reputación con {faction:47} de misiones de nivel bajo en {zone:1426}, la mayor parte pagada también a {area:133}",

	-- Step 1: Mistina Steelshield, the cloth quartermaster
	-- {npc:14723} Mistina Steelshield
	["{npc:14723}, the cloth quartermaster"] = "{npc:14723}, la intendente de paño",
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {object:32372} Great Forge (no name in this language: may be words) · {item:14047} Runecloth · {quest:7806} Additional Runecloth · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {zone:1437} Wetlands · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {area:132} Coldridge Valley · {area:131} Kharanos · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14723} takes cloth for {faction:47}; she stands outside the clothier on the north side of the {object:32372}, among the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7806} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12), {zone:1432} (10-20) and the {zone:1437} (20-30) while you level through them. After the donations come the level 52-59 quests of the {zone:1428} and {zone:1452} (about 600), then the optional {zone:1426} hubs, best rate first: {area:132} (about 37 a minute at full value), {area:131} (26), the quarry (17). Every {faction:47} gain also gives a quarter as much to {zone:1453}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14723} acepta paño para {faction:47}; está afuera de la tienda de ropa del lado norte de {object:32372}, entre los sastres. Cada primera donación de 60 de lana, seda, tejido mágico y {item:14047} paga 150 de reputación una sola vez; después de la de {item:14047}, {quest:7806} paga 50 por cada 20 {item:14047}, cuantas veces quieras. La casa de subastas de la Explanada es la forma más rápida de conseguir paño. En Classic, las misiones pagan la reputación completa mientras estén como mucho 5 niveles por debajo de ti, así que haz {zone:1426} (niveles 1-12), {zone:1432} (10-20) y {zone:1437} (20-30) mientras subes por ellas. Después de las donaciones vienen las misiones de nivel 52-59 de {zone:1428} y {zone:1452} (unas 600), y luego los centros opcionales de {zone:1426}, del mejor ritmo al peor: {area:132} (unos 37 por minuto a valor completo), {area:131} (26), la cantera (17). Cada ganancia con {faction:47} también da un cuarto a {zone:1453}, {zone:1457} y los Exiliados de Gnomeregan, salvo las misiones de las zonas iniciales de nivel 1-10. El Diplomático del Legado suma hasta un 10% a cada ganancia.",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592}: troggs, gnolls y kóbolds en {zone:1432} y {zone:1437}",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: el valle inicial de enanos y gnomos al suroeste de {area:131}, unos 1.100 de reputación en 30 minutos a nivel 60. {npc:658} y {npc:713} están en {area:77}. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 3: Coldridge: wolves, troggs and Felix Whindlebolt's things
	-- {npc:8416} Felix Whindlebolt
	["Coldridge: wolves, troggs and {npc:8416}'s things"] = "Crestanevada: lobos, troggs y las cosas de {npc:8416}",
	-- {area:77} Anvilmar · {npc:8416} Felix Whindlebolt
	["The wolves roam the valley floor; the troggs dig in the camps east of {area:77}; {npc:8416}'s box, chest and bucket lie in the trogg camps."] = "Los lobos recorren el fondo del valle; los troggs cavan en los campamentos al este de {area:77}; la caja, el cofre y el cubo de {npc:8416} están en los campamentos de troggs.",

	-- Step 4: Coldridge: Anvilmar and Talin Keeneye
	-- {area:77} Anvilmar · {npc:714} Talin Keeneye
	["Coldridge: {area:77} and {npc:714}"] = "Crestanevada: {area:77} y {npc:714}",

	-- Step 5: Coldridge: Grelin Whitebeard and the troll cave
	-- {npc:786} Grelin Whitebeard
	["Coldridge: {npc:786} and the troll cave"] = "Crestanevada: {npc:786} y la cueva de los trols",
	-- {npc:786} Grelin Whitebeard · {area:77} Anvilmar
	["{npc:786} camps south of {area:77}, at the mouth of the troll cave; the journal lies at the back of the cave."] = "{npc:786} acampa al sur de {area:77}, en la boca de la cueva de los trols; el diario está al fondo de la cueva.",

	-- Step 6: Coldridge: the hot Mornbrew
	["Coldridge: the hot Mornbrew"] = "Crestanevada: el Albrebaje caliente",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew cools in five minutes: run straight to {npc:836} at {area:77}."] = "El Albrebaje hirviente se enfría en cinco minutos: corre directo a {npc:836} en {area:77}.",

	-- Step 7: Coldridge: on to Kharanos
	-- {area:131} Kharanos
	["Coldridge: on to {area:131}"] = "Crestanevada: rumbo a {area:131}",
	-- {npc:1252} Senir Whitebeard · {area:131} Kharanos
	["{npc:1252}, in {area:131}"] = "{npc:1252}, en {area:131}",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the inn"] = "{npc:6806}, en la posada",

	-- Step 8: Kharanos
	-- {area:131} Kharanos · {area:133} Gnomeregan · {area:2102} Thunderbrew Distillery · {area:189} Steelgrill's Depot
	["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: {area:131} y los caminos de Aldea Cervecera y {area:133} alrededor, unos 1.300 de reputación en 50 minutos a nivel 60. La mayoría de los que dan misiones están dentro y alrededor de {area:2102} y en {area:189}, al este. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 9: Kharanos: the hills and the depot
	-- {area:131} Kharanos
	["{area:131}: the hills and the depot"] = "{area:131}: las colinas y el depósito",
	-- {area:131} Kharanos · {area:136} Grizzled Den · {area:133} Gnomeregan
	["The boars and bears roam around {area:131}; the wendigos live in the {area:136} south-west of town; the leper gnomes at the {area:133} road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "Los jabalíes y osos recorren los alrededores de {area:131}; los wendigos viven en {area:136}, al suroeste del pueblo; los gnomos leprosos del camino a {area:133} llevan los engranajes; la munición de Retumbatiro está en su campamento al oeste del pueblo.",

	-- Step 10: Kharanos: back in town
	-- {area:131} Kharanos
	["{area:131}: back in town"] = "{area:131}: de vuelta en el pueblo",

	-- Step 11: Kharanos: Brewnall and Frostmane Hold
	-- {area:131} Kharanos · {quest:287} Frostmane Hold
	["{area:131}: Brewnall and {quest:287}"] = "{area:131}: Aldea Cervecera y {quest:287}",
	-- {npc:1374} Rejold Barleybrew · {area:137} Brewnall Village · {area:131} Kharanos · {quest:287} Frostmane Hold
	["{npc:1374} stands by {area:137} on the lake north-west of {area:131}; {quest:287} is the troll cave west of it."] = "{npc:1374} está junto a {area:137}, en el lago al noroeste de {area:131}; {quest:287} es la cueva de los trols al oeste.",
	["walk to the back of the cave"] = "camina hasta el fondo de la cueva",

	-- Step 12: Kharanos: last hand-in
	-- {area:131} Kharanos
	["{area:131}: last hand-in"] = "{area:131}: última entrega",

	-- Step 13: The quarry and Amberstill Ranch
	-- {area:803} Amberstill Ranch
	["The quarry and {area:803}"] = "La cantera y {area:803}",
	-- {zone:1426} Dun Morogh · {npc:264936} Earthseer Farsen · {area:134} Gol'Bolar Quarry · {area:803} Amberstill Ranch
	["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation in 30 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: el este de {zone:1426}, desde el campamento de {npc:264936} hasta {area:134} y {area:803}, unos 500 de reputación en 30 minutos a nivel 60. Forever paga estas misiones viejas completas a cualquier nivel. Sáltate este paso para saltarte el centro.",

	-- Step 14: The quarry: troggs, spies and Vagash
	-- {npc:1388} Vagash
	["The quarry: troggs, spies and {npc:1388}"] = "La cantera: troggs, espías y {npc:1388}",
	-- {area:134} Gol'Bolar Quarry · {npc:1388} Vagash · {area:803} Amberstill Ranch
	["The Dark Iron Spies lurk around Farsen's camp; the troggs dig in the {area:134}; {npc:1388}, a big snow leopard, prowls the hills above {area:803}."] = "Los espías Hierro Negro merodean alrededor del campamento de Farsen; los troggs cavan en {area:134}; {npc:1388}, un leopardo de las nieves grande, acecha en las colinas sobre {area:803}.",

	-- Step 15: The Reports
	-- {npc:1274} Senator Barin Redstone
	["{npc:1274}, in the throne room"] = "{npc:1274}, en la sala del trono",

	-- Step 16: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1437} Wetlands
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "{item:4306} lo sueltan los humanoides de nivel 23 a 40: los Faucedraco de {zone:1437}, el Sindicato de Alterac y Arathi, los trols de Tuercespina.",

	-- Step 17: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron (no name in this language: may be words) · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "{item:4338} lo sueltan los humanoides de nivel 35 a 50: los enanos Forjatiniebla y {object:147516} de {zone:1418} y {zone:1427}, los ogros Machacaduna de {zone:1446}, las nagas Crestafuria de {zone:1444}.",

	-- Step 18: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7806} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7806}."] = "{item:14047} lo sueltan los humanoides de nivel 50 en adelante: los sectarios de la Plaga y la Cruzada Escarlata en las Tierras de la Peste, los fúrbolgs Muertobosque de {zone:1448}, los fúrbolgs Nevada de {zone:1452}. Guarda todo el {item:14047} que pase de los primeros 60 para {quest:7806}.",

	-- Step 19: Ironforge: Royal Historian Archesonus
	-- {faction:47} Ironforge · {npc:8879} Royal Historian Archesonus · {object:171709} High Seat · {zone:1428} Burning Steppes
	["These quests are level 52 to 59, so they pay in full at 60: about 600 {faction:47} reputation. {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "Estas misiones son de nivel 52 a 59, así que pagan completo a 60: unos 600 de reputación con {faction:47}. {npc:8879} está junto al rey Magni en {object:171709}; te manda a las ruinas de Thaurissan en {zone:1428}.",
	-- {npc:8879} Royal Historian Archesonus
	["Hear {npc:8879} out"] = "Escucha a {npc:8879}",

	-- Step 20: Morgan's Vigil: Oralius
	-- {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {npc:9177} Oralius · {area:249} Dreadmaul Rock
	["{area:2418} sits in the south-east of the {zone:1428}, at the top of the pass up from Redridge. {npc:9177} wants the Firegut ogres of {area:249}, north of the Vigil, thinned out; the Brutes keep to the rock's east side."] = "{area:2418} está en el sureste de {zone:1428}, en lo alto del paso que sube desde Crestagrana. {npc:9177} quiere que diezmes a los ogros Pirontraña de {area:249}, al norte del Vigía; los brutos se quedan en el lado este de la roca.",

	-- Step 21: Thaurissan and Blackrock Stronghold
	-- {area:252} Blackrock Stronghold
	["Thaurissan and {area:252}"] = "Thaurissan y {area:252}",
	-- {area:251} Flame Crest · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {item:11467} Blackrock Medallion · {npc:9177} Oralius · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["The Thaurissan relics are the carved stones in the ruins around {area:251}, west along the road: click twelve of them. {npc:9176} and the Blackrock orcs and worgs hold the camps at the foot of {area:254}, further west; each may drop a {item:11467} (about one kill in three), and {npc:9177} wants fifty. The orcs are level 50 and up, so they drop {item:14047} too: keep it for {quest:7806}."] = "Las reliquias de Thaurissan son las piedras talladas de las ruinas alrededor de {area:251}, al oeste por el camino: haz clic en doce. {npc:9176} y los orcos y huargos Roca Negra ocupan los campamentos al pie de {area:254}, más al oeste; cada uno puede soltar un {item:11467} (más o menos una de cada tres muertes), y {npc:9177} quiere cincuenta. Los orcos son de nivel 50 o más, así que también sueltan {item:14047}: guárdalo para {quest:7806}.",

	-- Step 22: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418}: entregas",
	-- {npc:9176} Gor'tesh · {area:249} Dreadmaul Rock
	["Plant {npc:9176}'s head on the soft dirt mound at the top of {area:249}."] = "Clava la cabeza de {npc:9176} en el montículo de tierra blanda de lo alto de {area:249}.",

	-- Step 23: Ironforge: Archesonus again
	-- {faction:47} Ironforge
	["{faction:47}: Archesonus again"] = "{faction:47}: Archesonus otra vez",
	-- {area:1584} Blackrock Depths · {npc:9021} Kharan Mighthammer · {npc:9177} Oralius · {zone:1459} Alterac Valley · {faction:47} Ironforge · {item:17542} Coldtooth Supplies
	-- plural, as words: Dark Iron Fanny Packs = {item:11468} Dark Iron Fanny Pack · Storm Crystals = {item:17423} Storm Crystal
	["With a group, {area:1584} pays more: Archesonus's chain goes on with {npc:9021} (100) and The Fate of the Kingdom (Emperor Thaurissan, 150), and {npc:9177} takes 20 Dark Iron Fanny Packs from the dwarves inside (The Good Stuff, 100). {zone:1459}, from level 51, pays {faction:47} too: its one-time quests about 1,900 as your Stormpike standing grows (the {zone:1459} guide walks them), and inside the battle 25 for every 10 Irondeep or {item:17542} and 50 for 5 Storm Crystals, as often as you like."] = "Con un grupo, {area:1584} paga más: la cadena de Archesonus sigue con {npc:9021} (100) y El destino del reino (el emperador Thaurissan, 150), y {npc:9177} acepta 20 riñoneras Hierro Negro de los enanos de adentro (Lo bueno, 100). {zone:1459}, desde el nivel 51, también paga con {faction:47}: sus misiones únicas unos 1.900 a medida que crece tu reputación con Pico Tormenta (la guía de {zone:1459} las recorre), y dentro de la batalla 25 por cada 10 de Hondonada de Hierro o {item:17542} y 50 por 5 cristales de tormenta, cuantas veces quieras.",

	-- Step 24: Winterspring: Enraged Wildkin
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village · {area:2245} Mazthoril · {faction:47} Ironforge
	["{npc:11755} in {area:2255} sends you west to {npc:10301} at {area:2253}. {npc:10301}'s damaged crate and wrecked wagon lie at {area:2245}, down the valley to the south-east; his supplies lie around the wagon and the owlbeasts nearby carry his amulet. The last quest is level 59: 100 {faction:47} in full."] = "{npc:11755}, en {area:2255}, te manda al oeste con {npc:10301} en {area:2253}. La caja dañada y el carromato destrozado de {npc:10301} están en {area:2245}, valle abajo al sureste; sus suministros están alrededor del carromato y las lechubestias de cerca llevan su amuleto. La última misión es de nivel 59: 100 con {faction:47}, completos.",

	-- Step 25: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806} hasta Honorable",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1426} Dun Morogh · {faction:47} Ironforge · {area:144} Thelsamar · {zone:1432} Loch Modan · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1459} Alterac Valley
	["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7806}: 50 de reputación por 20 {item:14047}, cuantas veces quieras. Después de las cuatro primeras donaciones, un humano, elfo de la noche o gnomo queda en Amistoso 700 de 6.000, así que Honorable está a 5.300: 106 entregas, 2.120 {item:14047} (los enanos empiezan 900 más arriba: 88 entregas; los Celestes empiezan en Neutral 2.000, así que a 6.400: 128, dos menos después de Explorando la Alianza). Las misiones de nivel 52-59 de arriba restan 12 entregas; cada centro de {zone:1426} que hiciste resta de 10 a 26 más. Más centros pagan con {faction:47}, completo mientras no estén más de 5 niveles por debajo de ti: {area:144} en {zone:1432} (unos 3.500 en total) y {area:150} en {zone:1437} (unos 2.500). Desde el nivel 51, las misiones únicas de {zone:1459} suman unos 1.900. Cada ganancia con una ciudad también da un cuarto a las otras tres ciudades de la Alianza (no contado aquí). Entrega todo tu {item:14047} de una vez.",

	-- Step 26: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806} hasta Venerado",
	-- {npc:1261} Veron Amberstill · {item:14047} Runecloth
	["Honored: in Classic Ironforge's vendors take 10% off for you, {npc:1261}'s rams (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honorable: en Classic, los vendedores de Forjaz te hacen un 10% de descuento, incluidos los carneros de {npc:1261} (20g, los veloces 200g); Forever no lo definió, y los sitios de guías informan un 5% en Amistoso que sube a un 20% en Exaltado. De Honorable a Reverenciado son 12.000 de reputación: 240 entregas, 4.800 {item:14047}.",

	-- Step 27: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806} hasta Exaltado",
	-- {item:14047} Runecloth · {npc:1261} Veron Amberstill · {area:803} Amberstill Ranch · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:1261} at {area:803} in eastern {zone:1426} sells his rams to other races in Classic; the Ram and Swift Ram guides cover them."] = "De Reverenciado a Exaltado son 21.000 de reputación: 420 entregas, 8.400 {item:14047}. En Exaltado, {npc:1261}, en {area:803}, en el este de {zone:1426}, vende sus carneros a otras razas en Classic; las guías de Carnero y Carnero veloz los cubren.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Los Adeptos oscuros y Magos oscuros (nivel 58-60) lo sueltan aquí; cada muerte de la Plaga aquí también cuenta para {object:92525} (consulta esa guía). También sirve la casa de subastas.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Los Ogros Machacaduna (nivel 45-48) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7806} hasta ser Exaltado con {faction:47}. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7806}, 20 {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Los Bandidos y Capataces Zarparrío (nivel 16-18) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Los Mercenarios de la Hermandad del Castillo de Stromgarde (nivel 31-32) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723} acepta paño para {faction:47} en {faction:47}. Las primeras donaciones de Paño de lana, Paño de seda, Paño de tejido mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7806} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar las monturas de esa raza. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{npc:14723}: {item:14047} delivered"] = "{npc:14723}: {item:14047} entregado",
	-- ["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806} pide 20 {item:14047} por entrega y se repite cuantas veces quieras. Lleva {item:14047} en múltiplos de 20 y entrégalos todos de una vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
