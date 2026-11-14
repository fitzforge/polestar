-- Spanish (Latin America) (esMX): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "Reputación: Entrañas",
	-- {item:14047} Runecloth
	["Tirisfal quests while you level, the Plaguelands quests from 55, then {item:14047} to Exalted."] = "Misiones de Tirisfal mientras subes de nivel, misiones de las Tierras de la Peste desde el 55, y luego {item:14047} hasta Exaltado.",
	-- {faction:68} Undercity
	["Exalted with the {faction:68}"] = "Exaltado con {faction:68}",

	-- Step 1: Undercity: how it works
	-- {faction:68} Undercity
	["{faction:68}: how it works"] = "{faction:68}: cómo funciona",
	-- {faction:68} Undercity · {npc:14729} Ralston Farnsley · {object:36082} Magic Quarter · {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:287} Hillsbrad · {area:272} Tarren Mill · {object:1661} The Undercity
	["{faction:68} reputation comes from quests and cloth. {npc:14729}, the cloth quartermaster, stands in the {object:36082} beside the tailors. He takes four one-time donations of 60 cloth (150 each) and then {quest:7819}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:68} also gives a quarter as much to {zone:1454}, {zone:1456} and the Darkspear Trolls. While you level, do the {faction:68}'s quests within 5 levels of them: Tirisfal at 1 to 12, Silverpine at 10 to 20, {area:287} and {area:272} at 20 to 33. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the {faction:68}'s merchants sell to you for 10% less (the Classic rule), the horse vendor included; at Exalted other races can buy the skeletal horses: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse, once you have mount training. {object:1661} has no tabard or other reward."] = "La reputación con {faction:68} viene de misiones y paño. {npc:14729}, el intendente de paño, está en {object:36082} junto a los sastres. Acepta cuatro donaciones únicas de 60 de paño (150 cada una) y luego {quest:7819}, 20 {item:14047} por 50, cuantas veces quieras. Cada punto que ganas con {faction:68} también da un cuarto a {zone:1454}, {zone:1456} y los Trols Lanza Negra. Mientras subes de nivel, haz las misiones de {faction:68} cuando estén a menos de 5 niveles de ti: Tirisfal de 1 a 12, Bosque de Argénteos de 10 a 20, {area:287} y {area:272} de 20 a 33. La ventaja Diplomático del Legado suma hasta un 10%. Recompensas: en Honorable, los mercaderes de {faction:68} te venden un 10% más barato (la regla de Classic), incluido el vendedor de caballos; en Exaltado otras razas pueden comprar los caballos esqueléticos: 20 de oro por un caballo de nivel 40, 200 de oro por un caballo de guerra de nivel 60, una vez que tengas el entrenamiento de equitación. {object:1661} no tiene tabardo ni otra recompensa.",
	["his donations are handed in from his window and never enter the log"] = "sus donaciones se entregan desde su ventana y nunca entran en el registro",

	-- Step 2: Deathknell (optional hub)
	-- {area:154} Deathknell
	["{area:154} (optional hub)"] = "{area:154} (centro opcional)",
	-- {area:154} Deathknell · {faction:68} Undercity · {npc:1661} Novice Elreth · {npc:1570} Executor Arren · {npc:1740} Deathguard Saltain
	["Forever pays these old quests in full at any level. {area:154}, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "Forever paga estas misiones viejas completas a cualquier nivel. {area:154}, el inicio de los Renegados en el extremo oeste de Tirisfal: unos 900 de reputación con {faction:68} en 25 minutos. Las misiones de la zona inicial no dan parte a las otras ciudades. {npc:1661}, {npc:1570} y {npc:1740} están en la aldea.",

	-- Step 3: Deathknell: the next quests
	-- {area:154} Deathknell
	["{area:154}: the next quests"] = "{area:154}: las siguientes misiones",

	-- Step 4: Around Deathknell
	-- {area:154} Deathknell
	["Around {area:154}"] = "Alrededor de {area:154}",
	-- {object:164662} Equipment Boxes · {quest:380} Night Web's Hollow · {npc:271961} Webbed Forsaken · {npc:1919} Samuel Fipps · {object:178090} Marla's Grave
	["The {object:164662} are all around the village. {quest:380} is the mine north-west; the {npc:271961} hang inside. {npc:1919} waits at the ruined camp by the road north-east: bury his remains at {object:178090}, in the front row of the village graveyard."] = "Las {object:164662} están por toda la aldea. {quest:380} es la mina del noroeste; los {npc:271961} cuelgan adentro. {npc:1919} espera en el campamento en ruinas junto al camino al noreste: entierra sus restos en {object:178090}, en la primera fila del cementerio de la aldea.",
	-- {npc:271961} Webbed Forsaken
	["{npc:271961} freed"] = "{npc:271961} liberados",
	-- {object:178090} Marla's Grave · {item:16333} Samuel's Remains
	["{object:178090}, with {item:16333}"] = "{object:178090}, con {item:16333}",

	-- Step 5: Deathknell: hand in
	-- {area:154} Deathknell
	["{area:154}: hand in"] = "{area:154}: entregas",

	-- Step 6: The Scarlet camp
	["The Scarlet camp"] = "El campamento Escarlata",
	-- {area:154} Deathknell · {npc:1667} Meven Korgal
	["The Scarlet camp is south-east of {area:154}. {npc:1667} leads it."] = "El campamento Escarlata está al sureste de {area:154}. {npc:1667} lo dirige.",
	-- {item:2885} Scarlet Crusade Documents · {npc:1667} Meven Korgal
	["{item:2885}, from {npc:1667}"] = "{item:2885}, de {npc:1667}",
	-- {quest:383} Vital Intelligence · {npc:1515} Executor Zygand · {area:159} Brill
	["{quest:383}, +75: to {npc:1515} in {area:159}"] = "{quest:383}, +75: para {npc:1515} en {area:159}",

	-- Step 8: Brill (optional hub)
	-- {area:159} Brill
	["{area:159} (optional hub)"] = "{area:159} (centro opcional)",
	-- {area:159} Brill · {faction:68} Undercity · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren · {npc:1518} Apothecary Johaan · {npc:1496} Deathguard Dillinger · {npc:1500} Coleman Farthing
	["Forever pays these old quests in full at any level. {area:159} and the fields around it: about 1,100 {faction:68} reputation in 45 minutes. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "Forever paga estas misiones viejas completas a cualquier nivel. {area:159} y los campos de alrededor: unos 1.100 de reputación con {faction:68} en 45 minutos. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} y {npc:1500} están en el pueblo.",

	-- Step 9: Around Brill
	-- {area:159} Brill
	["Around {area:159}"] = "Alrededor de {area:159}",
	-- {item:286176} Executor's Motivator · {area:159} Brill · {quest:99141} Patience · {npc:1496} Deathguard Dillinger · {npc:251001} Deathguard Kristof · {npc:10666} Gordo · {npc:1525} Rotting Dead
	["Use the {item:286176} on five Deathguards around {area:159}. For {quest:99141}, talk to {npc:1496} west of {area:159}, {npc:251001} at the waystation east of it and {npc:10666} on the road. The Rot Hide gnolls dig at the mass grave north of {area:159}. The {npc:1525} walk around the old bridge west of {area:159}; the dry branches lie under the trees there. Darkhounds roam everywhere."] = "Usa el {item:286176} en cinco guardias de la muerte alrededor de {area:159}. Para {quest:99141}, habla con {npc:1496} al oeste de {area:159}, con {npc:251001} en la parada al este y con {npc:10666} en el camino. Los gnolls Pellejo Podrido cavan en la fosa común al norte de {area:159}. Los {npc:1525} andan alrededor del puente viejo al oeste de {area:159}; las ramas secas están bajo los árboles de ahí. Los canes oscuros recorren todas partes.",
	["Motivate 5 Deathguards"] = "Motiva a 5 guardias de la muerte",

	-- Step 10: Agamand Mills
	-- {npc:1657} Devlin Agamand · {area:157} Agamand Mills
	["{npc:1657} walks the road to {area:157}; Nissa waits upstairs in the first house, Gregor and Thurman further on in the mills."] = "{npc:1657} recorre el camino a {area:157}; Nissa espera arriba en la primera casa, Gregor y Thurman más adelante, en los molinos.",

	-- Step 11: Brill: hand in
	-- {area:159} Brill
	["{area:159}: hand in"] = "{area:159}: entregas",

	-- Step 12: Agamand Mills again
	-- {area:157} Agamand Mills
	["{area:157} again"] = "{area:157} otra vez",
	-- {area:157} Agamand Mills
	-- plural, as words: Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["The skeletons of {area:157} drop the ribs; the Darkeye Bonecasters the skulls."] = "Los esqueletos de {area:157} sueltan las costillas; los lanzahuesos Ojo Oscuro, los cráneos.",

	-- Step 13: Ralston Farnsley: A Donation of Wool
	-- {npc:14729} Ralston Farnsley · {item:14047} Runecloth · {quest:7819} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14729} offers the {item:14047} donation, and {quest:7819} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "Desde aquí es paño. Hay que entregar lana, seda y tejido mágico antes de que {npc:14729} ofrezca la donación de {item:14047}, y {quest:7819} necesita la donación de {item:14047}. Compra el paño en la casa de subastas, o farméalo: lo sueltan los humanoides, la lana del nivel 15 al 25, la seda del 25 al 40, el tejido mágico del 40 al 50, {item:14047} del 50 en adelante. A nivel 60, farmea enemigos de nivel 52 o más: los de menos son grises.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: los fúrbolgs Piel de Cardo la sueltan más o menos una de cada cuatro muertes",

	-- Step 14: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Seda: el Sindicato en {area:287} y Alterac la suelta más o menos una de cada tres muertes, o cómprala.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: el Sindicato",

	-- Step 15: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Tejido mágico: los sátiros Fuego de Jade del sur de {zone:1448} y los ogros Machacaduna de {zone:1446} lo sueltan más o menos una de cada tres muertes, o cómpralo.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: los sátiros Fuego de Jade",

	-- Step 16: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: los Escarlata en {area:2266} de {zone:1423}, los ogros Gordok afuera de {area:2577} en {zone:1444} y los campamentos Crepusculares de {zone:1451} lo sueltan más o menos una de cada tres muertes. La casa de subastas es más rápida si tienes oro.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: los Escarlata afuera de {area:2266}",

	-- Step 17: Undercity: Harbinger Balthazad
	-- {area:152} Bulwark · {npc:10879} Harbinger Balthazad · {faction:68} Undercity
	["The level 55 to 60 quests pay in full. First the {area:152}: {npc:10879}, by the {faction:68}'s elevators, sends you there."] = "Las misiones de nivel 55 a 60 pagan completo. Primero {area:152}: {npc:10879}, junto a los ascensores de {faction:68}, te manda ahí.",

	-- Step 18: Bulwark: Scarlet Diversions
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {npc:10837} High Executor Derrington · {faction:68} Undercity · {item:12814} Flame in a Bottle · {area:200} Dalson's Tears · {area:199} Felstone Field · {item:12807} Scourge Banner
	["{area:152} is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between {area:200} and {area:199} and plant the {item:12807} beside it."] = "{area:152} es el campamento de los Renegados en el camino de Tirisfal a {zone:1422}. La cadena de {npc:10837} te manda contra los calderos de la Plaga de {zone:1422}: unos 820 de reputación con {faction:68}. Toma un {item:12814} de la caja a su lado; quema la tienda de mando del campamento Escarlata entre {area:200} y {area:199} y planta el {item:12807} junto a ella.",
	-- {quest:5096} Scarlet Diversions
	["{quest:5096}, +100 (level 53)"] = "{quest:5096}, +100 (nivel 53)",
	-- {object:176088} Scarlet Crusade Forward Camp
	["the {object:176088}"] = "el {object:176088}",

	-- Step 19: Bulwark: the cauldrons
	-- {area:152} Bulwark
	["{area:152}: the cauldrons"] = "{area:152}: los calderos",
	-- {quest:5229} Target: Felstone Field
	["{quest:5229}, +100 (level 53)"] = "{quest:5229}, +100 (nivel 53)",

	-- Step 20: Felstone Field and the Andorhal towers
	-- {area:199} Felstone Field
	["{area:199} and the Andorhal towers"] = "{area:199} y las torres de Andorhal",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {quest:5230} Return to the Bulwark · {item:12815} Beacon Torch
	["{npc:11075} guards the cauldron at {area:199}. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "{npc:11075} vigila el caldero de {area:199}. Haz clic en el caldero después de matarlo para iniciar {quest:5230}. Marca las cuatro torres de Andorhal con la {item:12815} en sus puertas.",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "el {object:176361}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["{npc:10902}: use the {item:12815} at the door"] = "{npc:10902}: usa la {item:12815} en la puerta",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca {npc:10902} con la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca {npc:10903} con la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca {npc:10904} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca {npc:10905} con la {item:12815}",

	-- Step 22: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["{npc:11077} guards the cauldron at {area:200}."] = "{npc:11077} vigila el caldero de {area:200}.",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "el {object:177289}",

	-- Step 23: Bulwark: the Writhing Haunt
	-- {area:152} Bulwark · {area:202} Writhing Haunt
	["{area:152}: the {area:202}"] = "{area:152}: {area:202}",

	-- Step 24: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt
	["{npc:11076} guards the cauldron at the {area:202}."] = "{npc:11076} vigila el caldero de {area:202}.",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "el {object:176393}",

	-- Step 26: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}."] = "{npc:11078} vigila el caldero de {area:201}.",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "el {object:176392}",

	-- Step 27: Bulwark: done
	-- {area:152} Bulwark
	["{area:152}: done"] = "{area:152}: terminado",
	-- {area:152} Bulwark · {area:2057} Scholomance · {npc:10136} Chemist Fuely · {faction:68} Undercity · {zone:1448} Felwood · {zone:1449} Un'Goro Crater
	["{area:152} is also where The Key to {area:2057} ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "{area:152} es también donde termina La llave de {area:2057} (200), tras una cadena más larga. {npc:10136}, en el Boticario de {faction:68}, paga unos 290 más por mocos de {zone:1448} y {zone:1449}.",

	-- Step 28: Nathanos Blightcaller
	-- {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {faction:68} Undercity
	["{npc:11878}, the Ranger Lord, keeps his camp on the western edge of the {zone:1423}. His quests are level 58 to 60 and pay in full: 500 {faction:68} reputation."] = "{npc:11878}, el Señor de los Forestales, tiene su campamento en el borde oeste de {zone:1423}. Sus misiones son de nivel 58 a 60 y pagan completo: 500 de reputación con {faction:68}.",

	-- Step 29: Plaguebats, Quel'Lithien Lodge and Corin's Crossing
	-- {area:2276} Quel'Lithien Lodge · {area:2264} Corin's Crossing
	["Plaguebats, {area:2276} and {area:2264}"] = "Murciélagos de la peste, {area:2276} y {area:2264}",
	-- {area:2276} Quel'Lithien Lodge · {area:2268} Light's Hope Chapel · {item:15847} Quel'Thalas Registry · {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {item:15448} Coagulated Rot
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. {area:2276} is north-west of {area:2268}; the {item:15847} lies inside. Do {area:2264} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "Los murciélagos de la peste nocivos vuelan en el sur de la zona, los murciélagos de la peste monstruosos más al noroeste. {area:2276} está al noroeste de {area:2268}; el {item:15847} está adentro. Haz {area:2264} al final: su Plaga suelta {item:15447}, que dura solo 10 minutos. Con 7 en tus bolsas, usa el {item:15454} enseguida para la {item:15448}.",
	-- {item:15448} Coagulated Rot · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15448}: 7 {item:15447} and the {item:15454}"] = "{item:15448}: 7 {item:15447} y el {item:15454}",

	-- Step 30: Nathanos Blightcaller: hand in
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}: hand in"] = "{npc:11878}: entregas",

	-- Step 31: Duskwing and Borelgore
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897} and {npc:11896}"] = "{npc:11897} y {npc:11896}",
	-- {npc:11897} Duskwing · {area:2260} Marris Stead · {npc:11896} Borelgore · {area:2272} Northdale
	["{npc:11897}, an elite bat, roams the fields north of {area:2260}. {npc:11896} paces a long valley west of {area:2272}."] = "{npc:11897}, un murciélago élite, recorre los campos al norte de {area:2260}. {npc:11896} va y viene por un valle largo al oeste de {area:2272}.",
	-- {npc:11878} Nathanos Blightcaller · {faction:68} Undercity · {area:2279} Stratholme · {npc:12337} Crimson Courier
	["{npc:11878}: 500 {faction:68} reputation. His {area:2279} quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "{npc:11878}: 500 de reputación con {faction:68}. Sus misiones de {area:2279} (El {npc:12337}, El Oráculo Escarlata, Demetria, Ramstein) requieren grupo.",

	-- Step 32: The Spider God (optional chain)
	-- {quest:2936} The Spider God
	["{quest:2936} (optional chain)"] = "{quest:2936} (cadena opcional)",
	-- {zone:1425} Hinterlands · {area:272} Tarren Mill · {area:367} Sen'jin Village · {area:978} Zul'Farrak · {faction:68} Undercity · {quest:2937} Summoning Shadra · {quest:2938} Venom to the Undercity · {quest:2933} Venom Bottles
	["Six quests across the {zone:1425}, {area:272}, {area:367}, {area:978} and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 and pay in full too. Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "Seis misiones entre {zone:1425}, {area:272}, {area:367}, {area:978} y {faction:68}: 600 de reputación con {faction:68} y 225 con Lanza Negra. {quest:2937} y {quest:2938} son de nivel 55 y pagan 400 completos a 60; las cuatro anteriores son de nivel 43 a 45 y también pagan completo. Calcula unos 90 minutos con los viajes. Las {quest:2933} están en las mesas de la aldea Secacorteza, en el oeste de {zone:1425}: haz clic en una para empezar.",

	-- Step 34: Shadra'Alor: an Undamaged Venom Sac
	-- {area:353} Shadra'Alor · {quest:2934} Undamaged Venom Sac
	["{area:353}: an {quest:2934}"] = "{area:353}: una {quest:2934}",
	-- {area:353} Shadra'Alor · {zone:1425} Hinterlands
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["The Witherbark Broodguards crawl around {area:353} in the south-west of the {zone:1425}; about one in ten carries an undamaged sac."] = "Los guardacrías Secacorteza se arrastran alrededor de {area:353}, en el suroeste de {zone:1425}; más o menos uno de cada diez lleva una glándula intacta.",
	-- {quest:2934} Undamaged Venom Sac
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["{quest:2934}, from Witherbark Broodguards"] = "{quest:2934}, de los guardacrías Secacorteza",

	-- Step 35: Tarren Mill, then Sen'jin Village
	-- {area:272} Tarren Mill · {area:367} Sen'jin Village
	["{area:272}, then {area:367}"] = "{area:272}, luego {area:367}",
	-- {quest:2935} Consult Master Gadrin
	["{quest:2935}, +75 Darkspear"] = "{quest:2935}, +75 Lanza Negra",
	-- {npc:3188} Master Gadrin · {area:367} Sen'jin Village
	["{npc:3188}, in {area:367}"] = "{npc:3188}, en {area:367}",
	-- {quest:2936} The Spider God
	["{quest:2936}, +150 Darkspear"] = "{quest:2936}, +150 Lanza Negra",

	-- Step 36: Zul'Farrak: the Tablet of Theka
	-- {area:978} Zul'Farrak · {object:142715} Tablet of Theka
	["{area:978}: the {object:142715}"] = "{area:978}: la {object:142715}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7272} Theka the Martyr · {object:142715} Tablet of Theka
	["{area:978} is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "{area:978} es una mazmorra de nivel 44 a 54 en el norte de {zone:1446}; un nivel 60 puede abrirse camino solo, o lleva un grupo. {npc:7272}, un trol élite, vigila su tumba en la instancia: mátalo y lee ahí la {object:142715}.",
	-- {object:142715} Tablet of Theka
	["read the {object:142715}"] = "lee la {object:142715}",

	-- Step 38: Shadra'Alor: Shadra
	-- {item:9323} Gadrin's Parchment · {area:353} Shadra'Alor · {npc:2707} Shadra
	["Read {item:9323} at the altar of {area:353} to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "Lee {item:9323} en el altar de {area:353} para llamar a {npc:2707}, una araña élite de nivel 55: suelta su veneno siempre.",
	-- {item:9324} Shadra's Venom · {npc:2707} Shadra
	["{item:9324}, from {npc:2707}"] = "{item:9324}, de {npc:2707}",

	-- Step 39: Tarren Mill and the Undercity
	-- {area:272} Tarren Mill · {faction:68} Undercity
	["{area:272} and the {faction:68}"] = "{area:272} y {faction:68}",
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, en la botica real",

	-- Step 40: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819} hasta Honorable",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth
	["{quest:7819}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an Undead starts at Friendly 1,000: 100 hand-ins; every other race starts at Neutral 500 and first needs 50 hand-ins, 1,000 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7819}: 20 {item:14047} por 50 de reputación, cuantas veces quieras. De Amistoso a Honorable son 6.000: 120 entregas, 2.400 {item:14047}, menos lo que te dieron las misiones (un no-muerto empieza en Amistoso 1.000: 100 entregas; las demás razas empiezan en Neutral 500 y primero necesitan 50 entregas, 1.000 {item:14047}, para llegar a Amistoso). Entrega cada 20 que lleves, una tras otra.",

	-- Step 41: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819} hasta Venerado",
	-- {item:14047} Runecloth · {item:12358} Darkstone Tablet · {area:1584} Blackrock Depths
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} ({area:1584}) pays 150 in full."] = "De Honorable a Reverenciado son 12.000: 240 entregas, 4.800 {item:14047}. La {item:12358} ({area:1584}) paga 150 completos.",

	-- Step 42: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819} hasta Exaltado",
	-- {item:14047} Runecloth · {npc:4731} Zachariah Post · {area:159} Brill
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in {area:159} sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Reverenciado a Exaltado son 21.000: 420 entregas, 8.400 {item:14047}. ¡Por la Horda! (la cabeza de Rend) y El Señor de Roca Negra (la cabeza de Nefarian) pagan 200 a cada ciudad de la Horda. En Exaltado, {npc:4731}, en {area:159}, vende los caballos esqueléticos a todas las razas de la Horda: 20 de oro por un caballo de nivel 40, 200 de oro por un caballo de guerra de nivel 60 (los precios de Forever); en Classic, las otras razas necesitaban Exaltado para comprarlos.",
	-- {npc:4731} Zachariah Post
	["{npc:4731}: the skeletal horses"] = "{npc:4731}: los caballos esqueléticos",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Los Adeptos oscuros y Magos oscuros (nivel 58-60) lo sueltan aquí; cada muerte de la Plaga aquí también cuenta para {object:92525} (consulta esa guía). También sirve la casa de subastas.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Los Ogros Machacaduna (nivel 45-48) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7819} hasta ser Exaltado con {faction:68}. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7819}, 20 {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Los Centauros Kolkar (nivel 30-33) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Los Déspotas de Ventura y Cía. de {area:381} (nivel 16-17) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729} acepta paño para {faction:68} en {faction:68}. Las primeras donaciones de Paño de lana, Paño de seda, Paño de tejido mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7819} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar las monturas de esa raza. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{npc:14729}: {item:14047} delivered"] = "{npc:14729}: {item:14047} entregado",
	-- ["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819} pide 20 {item:14047} por entrega y se repite cuantas veces quieras. Lleva {item:14047} en múltiplos de 20 y entrégalos todos de una vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
