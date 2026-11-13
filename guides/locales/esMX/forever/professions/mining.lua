-- Spanish (Latin America) (esMX): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "Aprende {skill:186}",
	-- {skill:186} Mining · {item:2901} Mining Pick · {spell:2580} Find Minerals · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:11584} Cactus Apple Surprise · {item:247840} Mining for Dummies · {item:277115} Apprentice's Mining Pack · {spell:1230161} Lodestone
	-- plural, as words: Poor Copper Veins = {object:562111} Poor Copper Vein
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on {spell:2580} (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "Cualquier instructor de {skill:186} de tu facción enseña Aprendiz de {skill:186} a cualquier nivel (10c), y también el instructor novato de minería de cada zona inicial; la flecha elige el más cercano. Compra un {item:2901} a un mercader de artículos de comercio o general: guárdalo en tus bolsas, no puedes minar sin él. Activa {spell:2580} (libro de hechizos, pestaña General) para que las vetas se vean en el minimapa. Las zonas iniciales de Forever también tienen vetas de cobre pobre ({item:2770} y {item:2835}, desde habilidad 1). La misión de la primera hora de cada zona inicial (Roedores bribones, Entrega de correo del valle de Crestanevada, El protector del bosque, {item:11584} de Galgar, Una tarea humilde, El último deseo de Marla) ofrece {item:247840} como recompensa: leerlo da 2 puntos de habilidad, hasta 15. Los mercaderes de artículos de comercio y los instructores novatos venden {item:277115}, una bolsa de cuatro casillas para mineral y piedra (25c). Si te sentaste junto a la hoguera de tu zona inicial para “Bendita naturaleza”, el guía de campamento de allí también ofrece “Campamento básico: {skill:186}”: entrégala al instructor de minería que te indica cuando llegues a habilidad 20, a cambio de la receta {spell:1230161}.",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "Cobre: {zone:1429} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "Extrae cada nodo de Cobre (1, naranja), Cobre pobre (1, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 50. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de zona 1-10. Cuenta con unos 60 nodos para estos 49 puntos.",
	["Copper"] = "Cobre",
	["Poor Copper"] = "Cobre pobre",
	["Copper, Poor Copper"] = "Cobre, Cobre pobre",

	-- Step 3: Copper & Poor Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (1-50)"] = "Cobre y Cobre pobre: {zone:1426} (1-50)",

	-- Step 4: Chunk of Amber & Large Chunk of Amber: Teldrassil (1-50)
	-- {object:656332} Chunk of Amber · {object:656333} Large Chunk of Amber · {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every {object:656332} (1, orange), {object:656333} (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "Extrae cada nodo de {object:656332} (1, naranja) y {object:656333} (1, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 50. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de la zona: 1-10. Cuenta con unos 60 nodos para estos 49 puntos.",

	-- Step 5: Copper: Zephras Isle (1-50)
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (1-50)"] = "Cobre: {zone:2521} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 60 nodes for these 49 points."] = "Extrae cada nodo de Cobre (1, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 50. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de la zona: 1-15. Cuenta con unos 60 nodos para estos 49 puntos.",

	-- Step 6: Copper & Poor Copper: Durotar (1-50)
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (1-50)"] = "Cobre y Cobre pobre: {zone:1411} (1-50)",

	-- Step 7: Copper: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (1-50)"] = "Cobre: {zone:1412} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange, rare) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "Extrae cada nodo de Cobre (1, naranja) y Poor Copper (1, naranja, raro) que encuentres y recorre los puntos de ruta hasta {skill:186} 50. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de la zona: 1-10. Cuenta con unos 60 nodos para estos 49 puntos.",

	-- Step 8: Copper & Poor Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (1-50)"] = "Cobre y Cobre pobre: {zone:1420} (1-50)",
	["Poor Copper, Copper"] = "Cobre pobre, Cobre",

	-- Step 9: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "{skill:186} de oficial",
	-- {skill:186} Mining · {spell:1230161} Lodestone · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "Oficial de {skill:186} sube el límite a 150; requiere habilidad 50 y ningún nivel de personaje, y cuesta 5s: apréndelo en cuanto llegues a 50. La flecha elige el instructor de {skill:186} más cercano de tu facción. {spell:1230161}, el objeto de campamento de Forever para {skill:186}, se enseña desde habilidad 20 (1s, o gratis con “Campamento básico: {skill:186}”): lleva un {item:2835} y un {item:2840} cada uno, da puntos hasta 25; colocado junto a una hoguera, da a todos en el campamento un beneficio durante una hora.",

	-- Step 10: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "Cobre: {zone:1429} (50-65) cont.",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "Extrae cada nodo de Cobre (1, amarillo), Cobre pobre (1, amarillo) que encuentres y recorre los puntos de ruta hasta {skill:186} 65. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de zona 1-10. Cuenta con unos 80 nodos para estos 15 puntos.",

	-- Step 11: Copper & Poor Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "Cobre y Cobre pobre: {zone:1426} (50-65) (cont.)",

	-- Step 12: Chunk of Amber & Large Chunk of Amber: Teldrassil (50-65) cont.
	-- {object:656332} Chunk of Amber · {object:656333} Large Chunk of Amber · {zone:1438} Teldrassil
	["{object:656332} & {object:656333}: {zone:1438} (50-65) cont."] = "{object:656332} y {object:656333}: {zone:1438} (50-65) cont.",
	-- {object:656332} Chunk of Amber · {object:656333} Large Chunk of Amber · {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every {object:656332} (1, yellow), {object:656333} (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "Extrae cada nodo de {object:656332} (1, amarillo) y {object:656333} (1, amarillo) que encuentres y recorre los puntos de ruta hasta {skill:186} 65. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de la zona: 1-10. Cuenta con unos 80 nodos para estos 15 puntos.",

	-- Step 13: Copper: Zephras Isle (50-65) cont.
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (50-65) cont."] = "Cobre: {zone:2521} (50-65) (cont.)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 80 nodes for these 15 points."] = "Extrae cada nodo de Cobre (1, amarillo) que encuentres y recorre los puntos de ruta hasta {skill:186} 65. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de la zona: 1-15. Cuenta con unos 80 nodos para estos 15 puntos.",

	-- Step 14: Copper & Poor Copper: Durotar (50-65) cont.
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (50-65) cont."] = "Cobre y Cobre pobre: {zone:1411} (50-65) (cont.)",

	-- Step 15: Copper: Mulgore (50-65) cont.
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (50-65) cont."] = "Cobre: {zone:1412} (50-65) cont.",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow, rare) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "Extrae cada nodo de Cobre (1, amarillo) y Poor Copper (1, amarillo, raro) que encuentres y recorre los puntos de ruta hasta {skill:186} 65. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70) también da puntos. Nivel de la zona: 1-10. Cuenta con unos 80 nodos para estos 15 puntos.",

	-- Step 16: Copper & Poor Copper: Tirisfal Glades (50-65) cont.
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (50-65) cont."] = "Cobre y Cobre pobre: {zone:1420} (50-65) (cont.)",

	-- Step 17: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["At 65 a {skill:186} trainer teaches {spell:2659} (2s; grey at 115) and {spell:3304} (50c; grey at 75): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "A 65 un instructor de {skill:186} enseña {spell:2659} (2s; gris a 115) y {spell:3304} (50c; gris a 75): fundir en una forja también sube {skill:186}, así que funde lo que extraigas.",

	-- Step 18: Incendicite & Tin: Wetlands (65-125)
	-- {zone:1437} Wetlands
	["Incendicite & Tin: {zone:1437} (65-125)"] = "Incendicita y Estaño: {zone:1437} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Incendicite (65, orange), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Extrae cada nodo de Cobre (1, verde), Incendicita (65, naranja), Estaño (65, naranja), Plata (desde 75, raro) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70), {spell:3304} (gris a 75) y {spell:2659} (gris a 115) también dan puntos. {spell:2659} lleva una {item:2840} y una {item:3576} cada vez: guarda barras de las fundiciones anteriores. Nivel de la zona: 20-30. Cuenta con unos 130 nodos para estos 60 puntos. {spell:2658} (2s; naranja hasta 100, gris a 125) se enseña desde 75: apréndelo si pasas por un instructor de {skill:186}, no vale la pena un viaje solo por eso.",
	["Tin, Copper"] = "Estaño, Cobre",
	["Incendicite, Tin"] = "Incendicita, Estaño",

	-- Step 19: Tin: Ashenvale (65-125)
	-- {zone:1440} Ashenvale
	["Tin: {zone:1440} (65-125)"] = "Estaño: {zone:1440} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Extrae cada nodo de Cobre (1, verde), Estaño (65, naranja), Plata (desde 75, raro) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70), {spell:3304} (gris a 75) y {spell:2659} (gris a 115) también dan puntos. {spell:2659} lleva una {item:2840} y una {item:3576} cada vez: guarda barras de las fundiciones anteriores. Nivel de la zona: 18-30. Cuenta con unos 130 nodos para estos 60 puntos. {spell:2658} (2s; naranja hasta 100, gris a 125) se enseña desde 75: apréndelo si pasas por un instructor de {skill:186}, no vale la pena un viaje solo por eso.",
	["Tin"] = "Estaño",

	-- Step 20: Copper & Tin: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Copper & Tin: {zone:1413} (65-125)"] = "Cobre y Estaño: {zone:1413} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Extrae cada nodo de Cobre (1, verde), Estaño (65, naranja), Plata (desde 75, raro) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70), {spell:3304} (gris a 75) y {spell:2659} (gris a 115) también dan puntos. {spell:2659} lleva una {item:2840} y una {item:3576} cada vez: guarda barras de las fundiciones anteriores. Nivel de la zona: 10-25. Cuenta con unos 280 nodos para estos 60 puntos. {spell:2658} (2s; naranja hasta 100, gris a 125) se enseña desde 75: apréndelo si pasas por un instructor de {skill:186}, no vale la pena un viaje solo por eso.",
	["Copper, Tin"] = "Cobre, Estaño",

	-- Step 21: Tin: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin: {zone:1424} (65-125)"] = "Estaño: {zone:1424} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Extrae cada nodo de Cobre (1, verde), Estaño (65, naranja), Plata (desde 75, raro) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde en una forja cuando se llenen tus bolsas: {spell:2657} (naranja hasta 25, gris a 70), {spell:3304} (gris a 75) y {spell:2659} (gris a 115) también dan puntos. {spell:2659} lleva una {item:2840} y una {item:3576} cada vez: guarda barras de las fundiciones anteriores. Nivel de la zona: 20-30. Cuenta con unos 140 nodos para estos 60 puntos. {spell:2658} (2s; naranja hasta 100, gris a 125) se enseña desde 75: apréndelo si pasas por un instructor de {skill:186}, no vale la pena un viaje solo por eso.",

	-- Step 22: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "Experto de {skill:186}",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "Experto de {skill:186} sube el límite a 225; requiere habilidad 125 y ningún nivel de personaje, y cuesta 50s: apréndelo en cuanto llegues a 125. La flecha elige el instructor de {skill:186} más cercano de tu facción. Aprende {spell:3307} (5s; naranja hasta 130, gris a 140) en la misma visita: fundir en una forja también sube {skill:186}, así que funde lo que extraigas.",

	-- Step 23: Iron: Arathi Highlands (125-155)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (125-155)"] = "Hierro: {zone:1417} (125-155)",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "Extrae cada nodo de Estaño (65, verde), Sangrita inferior (75, verde), Plata (75, verde, raro), Hierro (125, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 155. Funde en una forja cuando se llenen tus bolsas: {spell:3307} (naranja hasta 130, gris a 140) también da puntos. Nivel de la zona: 30-40. Cuenta con unos 50 nodos para estos 30 puntos.",
	["Iron, Tin"] = "Hierro, Estaño",
	["Lesser Bloodstone"] = "Sangrita inferior",

	-- Step 24: Iron: Arathi Highlands (155-175)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (155-175)"] = "Hierro: {zone:1417} (155-175)",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, yellow), Gold (155, orange, rare) node you pass and circle the waypoints until {skill:186} 175. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 30-40. Expect about 40 nodes for these 20 points. {spell:3308} (25s; orange to 170, grey at 185) is taught from 155: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Extrae cada nodo de Estaño (65, verde), Sangrita inferior (75, verde), Plata (75, verde, raro), Hierro (125, amarillo), Oro (155, naranja, raro) que encuentres y recorre los puntos de ruta hasta {skill:186} 175. Funde en una forja cuando se llenen tus bolsas: {spell:3308} (naranja hasta 170, gris a 185) también da puntos. Nivel de la zona: 30-40. Cuenta con unos 40 nodos para estos 20 puntos. {spell:3308} (25s; naranja hasta 170, gris a 185) se enseña desde 155: apréndelo si pasas por un instructor de {skill:186}, no vale la pena un viaje solo por eso.",

	-- Step 25: Mithril: Badlands (175-200)
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (175-200)"] = "Mitril: {zone:1418} (175-200)",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 35-45. Expect about 40 nodes for these 25 points."] = "Extrae cada nodo de Hierro (125, verde), Oro (155, naranja), Mitril (175, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 200. Funde en una forja cuando se llenen tus bolsas: {spell:3308} (naranja hasta 170, gris a 185) también da puntos. Nivel de la zona: 35-45. Cuenta con unos 40 nodos para estos 25 puntos.",
	["Iron, Mithril"] = "Hierro, Mitril",

	-- Step 26: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "Artesano de {skill:186}",
	-- {skill:186} Mining
	["Artisan {skill:186} raises the cap to 300; it needs skill 200 and no character level, and costs 5g: train it as soon as you reach 200. The arrow picks the nearest {skill:186} trainer of your faction."] = "Artesano de {skill:186} sube el límite a 300; requiere habilidad 200 y ningún nivel de personaje, y cuesta 5g: apréndelo en cuanto llegues a 200. La flecha elige el instructor de {skill:186} más cercano de tu facción.",

	-- Step 27: Mithril: Badlands (200-230) cont.
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (200-230) cont."] = "Mitril: {zone:1418} (200-230) (cont.)",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 35-45. Expect about 90 nodes for these 30 points."] = "Extrae cada nodo de Hierro (125, verde), Oro (155, amarillo), Mitril (175, amarillo) que encuentres y recorre los puntos de ruta hasta {skill:186} 230. Desde aquí fundir no da puntos (las fundiciones superiores son grises en cuanto las aprendes): funde para fabricar o vender, o vende el mineral. Nivel de la zona: 35-45. Cuenta con unos 90 nodos para estos 30 puntos.",

	-- Step 28: Mithril & Dark Iron: Searing Gorge (230-245)
	-- {object:147516} Dark Iron (no name in this language: may be words) · {zone:1427} Searing Gorge
	["Mithril & {object:147516}: {zone:1427} (230-245)"] = "Mitril y {object:147516}: {zone:1427} (230-245)",
	-- {object:147516} Dark Iron (no name in this language: may be words) · {skill:186} Mining · {item:11099} Dark Iron Ore · {object:174824} Black Forge (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. {item:11099} smelts only at the {object:174824} in {area:1584} (8 ore a bar). Zone level 43-50. Expect about 40 nodes for these 15 points."] = "Extrae cada nodo de Oro (155, verde), Mitril (175, verde), {object:147516} (230, naranja), Veraplata (230, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 245. Desde aquí fundir no da puntos (las fundiciones superiores son grises en cuanto las aprendes): funde para fabricar o vender, o vende el mineral. {item:11099} solo se funde en {object:174824} de {area:1584} (8 minerales por barra). Nivel de la zona: 43-50. Cuenta con unos 40 nodos para estos 15 puntos.",
	-- {object:147516} Dark Iron (no name in this language: may be words)
	["Mithril, {object:147516}"] = "Mitril, {object:147516}",

	-- Step 29: Small Thorium: Felwood (245-275)
	-- {zone:1448} Felwood
	["Small Thorium: {zone:1448} (245-275)"] = "Torio pequeño: {zone:1448} (245-275)",
	-- {skill:186} Mining · {npc:9528} Arathandris Silversky · {npc:9529} Maybess Riverbreeze
	["Mine every Gold (155, green, rare), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Quests here that need {skill:186}: Salve via {skill:186} (level 55, {npc:9528}; Alliance), Salve via {skill:186} (level 55, {npc:9529}; Horde). Zone level 48-55. Expect about 50 nodes for these 30 points."] = "Extrae cada nodo de Oro (155, verde, raro), Mitril (175, verde), Veraplata (230, naranja), Torio pequeño (245, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 275. Desde aquí fundir no da puntos (las fundiciones superiores son grises en cuanto las aprendes): funde para fabricar o vender, o vende el mineral. Misiones de aquí que requieren {skill:186}: Bálsamo mediante {skill:186} (nivel 55, {npc:9528}; Alianza), Bálsamo mediante {skill:186} (nivel 55, {npc:9529}; Horda). Nivel de la zona: 48-55. Cuenta con unos 50 nodos para estos 30 puntos.",
	["Mithril, Small Thorium"] = "Mitril, Torio pequeño",
	["Small Thorium, Truesilver"] = "Torio pequeño, Veraplata",

	-- Step 30: Small Thorium & Rich Thorium: Winterspring (275-300)
	-- {zone:1452} Winterspring
	["Small Thorium & Rich Thorium: {zone:1452} (275-300)"] = "Torio pequeño y Torio enriquecido: {zone:1452} (275-300)",
	-- {skill:186} Mining
	["Mine every Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 55-60. Expect about 40 nodes for these 25 points."] = "Extrae cada nodo de Veraplata (230, amarillo), Torio pequeño (245, amarillo), Torio enriquecido (275, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 300. Desde aquí fundir no da puntos (las fundiciones superiores son grises en cuanto las aprendes): funde para fabricar o vender, o vende el mineral. Nivel de la zona: 55-60. Cuenta con unos 40 nodos para estos 25 puntos.",
	["Rich Thorium, Small Thorium"] = "Torio enriquecido, Torio pequeño",
	["Rich Thorium, Truesilver"] = "Torio enriquecido, Veraplata",
	["Rich Thorium"] = "Torio enriquecido",
	["Small Thorium, Rich Thorium"] = "Torio pequeño, Torio enriquecido",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "Cualquier instructor de {skill:186} de tu facción enseña Aprendiz de {skill:186} (nivel de personaje 5); la flecha elige el más cercano. Compra una {item:2901} a un mercader de suministros comerciales o general: guárdala en tus bolsas, no puedes extraer sin ella.",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "Artesano de {skill:186} sube el límite a 300; requiere habilidad 200 y nivel de personaje 35. La flecha elige el instructor de {skill:186} más cercano de tu facción.",
	-- ["Copper, Silver"] = "Cobre, Plata",
	-- ["Copper: {zone:1411} (1-50)"] = "Cobre: {zone:1411} (1-50)",
	-- ["Copper: {zone:1411} (50-65) cont."] = "Cobre: {zone:1411} (50-65) cont.",
	-- ["Copper: {zone:1420} (1-50)"] = "Cobre: {zone:1420} (1-50)",
	-- ["Copper: {zone:1420} (50-65) cont."] = "Cobre: {zone:1420} (50-65) cont.",
	-- ["Copper: {zone:1426} (1-50)"] = "Cobre: {zone:1426} (1-50)",
	-- ["Copper: {zone:1426} (50-65) cont."] = "Cobre: {zone:1426} (50-65) cont.",
	-- ["Copper: {zone:1439} (1-50)"] = "Cobre: {zone:1439} (1-50)",
	-- ["Copper: {zone:1439} (50-65) cont."] = "Cobre: {zone:1439} (50-65) cont.",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "Experto de {skill:186} sube el límite a 225; requiere habilidad 125 y nivel de personaje 20. La flecha elige el instructor de {skill:186} más cercano de tu facción.",
	-- ["Gold"] = "Oro",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "Oro y Mitril: {zone:1435} (175-200)",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "Oro y Mitril: {zone:1435} (200-230) cont.",
	-- ["Gold, Iron"] = "Oro, Hierro",
	-- ["Gold, Mithril"] = "Oro, Mitril",
	-- ["Gold: {zone:1435} (155-175)"] = "Oro: {zone:1435} (155-175)",
	-- ["Iron, Silver"] = "Hierro, Plata",
	-- ["Iron: {zone:1416} (125-155)"] = "Hierro: {zone:1416} (125-155)",
	-- ["Iron: {zone:1431} (125-155)"] = "Hierro: {zone:1431} (125-155)",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "Oficial de {skill:186} sube el límite a 150; requiere habilidad 50 y nivel de personaje 10. La flecha elige el instructor de {skill:186} más cercano de tu facción.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Extrae cada nodo de Cobre (1, verde), Estaño (65, naranja), Plata (desde 75) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 10-20.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "Extrae cada nodo de Cobre (1, verde), Estaño (65, naranja), Plata (desde 75) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 10-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "Extrae cada nodo de Cobre (1, verde), Estaño (65, naranja), Plata (desde 75) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 15-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "Extrae cada nodo de Cobre (1, verde), Estaño (65, naranja), Plata (desde 75) que encuentres y recorre los puntos de ruta hasta {skill:186} 125. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 20-30.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Extrae cada nodo de Cobre (1, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 50. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 1-10.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Extrae cada nodo de Cobre (1, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 50. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 10-20.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Extrae cada nodo de Cobre (1, amarillo) que encuentres y recorre los puntos de ruta hasta {skill:186} 65. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 1-10.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Extrae cada nodo de Cobre (1, amarillo) que encuentres y recorre los puntos de ruta hasta {skill:186} 65. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 10-20.",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "Extrae cada nodo de Oro (155, verde), Mitril (175, verde), Veraplata (230, naranja), Torio pequeño (245, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 275. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 45-55.",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "Extrae cada nodo de Oro (155, verde), Mitril (175, verde), {object:147516} (230, naranja), Veraplata (230, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 245. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 43-50.",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Extrae cada nodo de Hierro (125, verde), Oro (155, naranja), Mitril (175, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 200. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 35-45.",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Extrae cada nodo de Hierro (125, verde), Oro (155, amarillo), Mitril (175, amarillo) que encuentres y recorre los puntos de ruta hasta {skill:186} 230. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 35-45.",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Extrae cada nodo de Plata (75, verde), Hierro (125, amarillo), Oro (155, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 175. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 35-45.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "Extrae cada nodo de Estaño (65, verde), Plata (75, verde), Hierro (125, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 155. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 18-30.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "Extrae cada nodo de Estaño (65, verde), Plata (75, verde), Hierro (125, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 155. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 30-40.",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "Extrae cada nodo de {object:147516} (230, amarillo), Veraplata (230, amarillo), Torio pequeño (245, amarillo), Torio enriquecido (275, naranja) que encuentres y recorre los puntos de ruta hasta {skill:186} 300. Funde el mineral en una forja cuando se llenen tus bolsas: fundir también sube {skill:186}. Nivel de la zona: 50-58.",
	-- ["Rich Thorium: {zone:1428} (275-300)"] = "Torio enriquecido: {zone:1428} (275-300)",
	-- ["Silver, Tin"] = "Plata, Estaño",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "Estaño y Plata: {zone:1413} (65-125)",
	-- ["Tin & Silver: {zone:1424} (65-125)"] = "Estaño y Plata: {zone:1424} (65-125)",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "Estaño y Plata: {zone:1433} (65-125)",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "Estaño y Plata: {zone:1439} (65-125)",
	-- ["Tin, Silver"] = "Estaño, Plata",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "Veraplata y Torio pequeño: {zone:1419} (245-275)",
	-- ["Truesilver, {object:147516}"] = "Veraplata, {object:147516}",
	-- ["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516} y Veraplata: {zone:1427} (230-245)",
	-- ["{object:147516}, Gold"] = "{object:147516}, Oro",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}, Torio enriquecido",
}
