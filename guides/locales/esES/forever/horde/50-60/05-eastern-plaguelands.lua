-- Spanish (Spain) (esES): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Hacia {zone:1423}",

	-- Step 2: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "Ve al este por el camino hasta {zone:1423}. {npc:1855} vive en una casita junto a {area:2619}, justo al norte del camino en la frontera; sus tres cacerías están en la zona de esta guía.",

	-- Step 4: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "Sigue el camino hacia el este desde {zone:1422}, cruza el río y atraviesa todas {zone:1423} hasta la capilla de {object:92525}, en el extremo este.",

	-- Step 5: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "El fantasma de {npc:10926} está en las ruinas de {area:2262}, al suroeste.",

	-- Step 6: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "La cabeza de la muñeca y sus dos costados están en las casas alrededor de {npc:10926}; únelos desde tus bolsas.",
	["Inside"] = "Adentro",

	-- Step 7: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "un mensaje para {npc:11063} en {area:2268}",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Guarda {quest:5152}: {npc:10927} vive en {area:197}, en {zone:1422}.",

	-- Step 8: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "Zaeldarr acecha justo al oeste de {area:2262}.",
	["Below ground"] = "Bajo tierra",

	-- Step 9: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: {npc:10411} se vuelve invisible fuera de combate y llama a gárgolas Alarroca en cuanto empieza el combate. Solo hay 3 y reaparecen cada 15 min.",

	-- Step 10: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Vuelve a {area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "Los espíritus de {quest:5211} llegan con la parada en {area:2264} más adelante en esta guía: guárdala.",

	-- Step 11: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Maestro de vuelo de {area:2268}",

	-- Step 12: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "A {area:197}",

	-- Step 13: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Sube por el camino hacia el norte desde {area:272}. La casa de {npc:10927} está junto al camino en {area:197}, y el monumento de {npc:10936} está en el cementerio de detrás.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, en el piso de arriba",

	-- Step 14: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Ve al noroeste hacia Andorhal. {npc:10667} espera en la posada en ruinas del lado oeste del pueblo; los esqueletos de dentro son de nivel 54-57, así que mantente por los bordes.",
	["Upstairs"] = "Piso de arriba",

	-- Step 15: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "Los Anales están entre los libros enmohecidos del ayuntamiento de Andorhal; ábrelos hasta encontrar el correcto.\nCuidado: puede haber un {npc:10996}, élite de nivel 58-59, en Andorhal, como en muchos otros puntos de {zone:1422}: guarda las distancias.",

	-- Step 17: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Vuela a {area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "Vuelve al sur hasta {area:272} y vuela a {area:2268}.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Maestro de vuelo de {area:272}",

	-- Step 18: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Los objetos de {quest:5168} están en zonas de las Tierras de la Peste que verás más adelante: guárdala.",

	-- Step 19: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: mata a estos según te los encuentres",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "Los canes de peste y sus cachorros recorren las orillas del lago al suroeste de la capilla; los murcipestes y las larvas carroñeras comparten el terreno. Cuidado: los canes de peste más grandes son de nivel 56, atráelos de uno en uno.\nLa espada rota está en el suelo al noroeste del lago.",

	-- Step 20: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft · {npc:8564} Ranger
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}. Su caza de {npc:8564}, en el norte de la zona, espera al viaje a las Tierras de la Peste de la próxima guía.",
	-- plural, as words: Rangers = {npc:8564} Ranger
	["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "guárdala: los especialistas (59-60) esperan a la segunda incursión al norte de la próxima guía",

	-- Step 21: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Los Cachorros de can de la Peste y los Murcipestes recorren las colinas al norte de {area:2260}, y las Larvas carroñeras se arrastran entre ellos; avanza hacia el norte, hacia {area:2627}.",

	-- Step 22: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "{npc:11140}, el fantasma, está junto a una cabaña en {area:2627}, en la esquina noroeste; {npc:12384} está sentado dentro de la cabaña.",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}, dentro",

	-- Step 23: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}: mata a estos según te los encuentres",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "El libro está en la posada en ruinas de {area:2627}; los no-muertos del pueblo son de nivel 54-56, así que atráelos de uno en uno.\nLos montículos grandes de termitas están por todas las colinas al este de {area:2627}. Usa la {item:15042} en cada montículo que encuentres.\nCuidado: los protectores Ziggurat (58, élite) están junto a los zigurats al este y noreste del pueblo: ve a los montículos más cercanos al pueblo y mantente lejos de ellos.",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}: los no-muertos de {area:2627} las sueltan mientras llevas la {item:12846}",

	-- Step 24: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:813} Bulwark · {zone:1422} Western Plaguelands
	["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "Guarda las termitas: {npc:11615}, en {area:813}, las recoge en el viaje a {zone:1422} de la próxima guía.",

	-- Step 25: Level 56
	["Level 56"] = "Nivel 56",
	-- {npc:11878} Nathanos Blightcaller · {area:1583} Blackrock Spire
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "Sube aquí hasta el nivel 56 antes de los canes de peste demenciados de Villa del Norte (57-58): los murcipestes nocivos (54-56) que sobrevuelan los campos de camino al este son de tu nivel, y {npc:11878} quiere veinte. O, con grupo, haz la mazmorra de {area:1583} (Inferior).",
	-- {npc:8601} Noxious Plaguebat
	["grind on {npc:8601}"] = "farmea {npc:8601}",

	-- Step 26: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: mátalos según te los encuentres",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "Los canes de peste demenciados recorren los campos alrededor de {area:2272} y {area:2271}, al sur de {area:2273}; los murcipestes nocivos sobrevuelan los campos del norte, y los murcipestes monstruosos, alrededor de {area:2272} y {area:2271}. Cuidado: los canes son de nivel 57-58 y los murcipestes monstruosos más grandes de 58: atráelos de uno en uno.",

	-- Step 27: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "El cráneo está en {area:2622}, entre horrores apestados y monstruosidades de la Peste.",
	["Underwater"] = "Bajo el agua",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Ve al sur hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele los siete trozos con {item:15454} enseguida.\nCuidado: los sirvientes ocultos piden ayuda en un radio de 25 m cuando bajan al 40 % de salud. Fuera de combate, además, se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, puede unirse al combate un gran número de enemigos. Luchar cerca de las afueras reduce este riesgo.\nCon {quest:5211} en tu registro (de {npc:11063}, al principio de esta guía), la Plaga alrededor del pueblo deja espíritus de Villa Darrow: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libera a los espíritus de Villa Darrow: habla con ellos",

	-- Step 29: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Ve al oeste a {area:2260}.",

	-- Step 31: Class trainer
	["Class trainer"] = "Instructor de clase",
	-- {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "Usa la piedra de hogar para ir a {zone:1454}: sigue vinculada allí desde la guía de {zone:1447} (los magos se teletransportan). Entrena antes del vuelo.",

	-- Step 32: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "Vuela a {area:1997}",
	-- {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "Usa la piedra de hogar para ir a {zone:1454}: sigue vinculada allí desde la guía de {zone:1447} (los magos se teletransportan). Luego, el maestro de vuelo.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 33: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "Usa la piedra de hogar para ir a {zone:1454}: sigue vinculada allí desde la guía de {zone:1447}. Luego, el maestro de vuelo.",

	-- Step 34: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033} (druidas) entrena en {area:1639}, y {npc:246344} (paladines) también en la ciudad.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} en {area:1639}; {npc:246344}",

	-- Step 35: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 37: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Sube por el camino hacia el norte. El caldero está en {area:1762}, justo al suroeste de {area:1769}; los fúrbolg Muertobosque de allí son hostiles.",

	-- Step 38: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Solo si te ha caído {quest:8471}: {npc:11558} espera en la entrada de {area:1769} del lado de {zone:1448}, y solo te habla si eres Neutral con el Bastión de los Fauces de Madera.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} da vueltas por aquí: búscala dentro del círculo del mapa",

	-- Step 40: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atraviesa {area:1769} y toma el ramal del túnel hacia {zone:1450}. {npc:11801} está en {area:2361}.",

	-- Step 41: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Las dos misiones llevan a {zone:1451}: guárdalas.",

	-- Step 43: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "Desde la salida del túnel en {zone:1452}, cabalga al sur hasta {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086} están en {zone:1448}, en un viaje posterior: guárdala.",

	-- Step 44: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Lechubestias lunadón",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Ve al este hasta {area:2255} y sal de allí hacia el norte; las lechubestias lunadón recorren las colinas de las laderas sur de {area:2241}. Cuidado: son de nivel 57-58: atráelas de una en una.\nCuidado: los Hailspite, élites de nivel 60, se reúnen en los campos nevados al sureste de {area:2255}, donde también rondan algunas lechubestias lunadón: no te salgas de las laderas al norte del pueblo.",

	-- Step 45: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cuernos de yeti prístinos",
	-- {area:2255} Everlook
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "Los cuernos de Umi, pendientes desde tu última parada en {area:2255}: las colinas de los yetis empiezan justo al sureste de {area:2255}. Solo las matriarcas y los patriarcas sueltan cuernos, y los patriarcas llegan al nivel 58: atráelos de uno en uno.",

	-- Step 46: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "La tercera broma de Umi va dirigida a goblins de {area:976}, Un'Goro y {area:2255}: guárdala para más adelante.",

	-- Step 47: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Maestro de vuelo de {area:2255}",

	-- Step 48: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Bebe el {item:11243} en el cementerio justo al este de {area:976}: te mata, y solo como fantasma puedes ver a {npc:9299}, en una grieta rocosa de las colinas justo al norte. Habla con él allí, luego corre de vuelta a tu cuerpo y resucita: la Lápida llamativa a la que te envía está en ese cementerio.",

	-- Step 49: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Usa {item:12928} con {npc:7583}, la niña goblin de {area:976}. A {npc:10977} y {npc:10978} se les asusta más adelante en la ruta.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Asusta a {npc:7583} con {item:12928}",

	-- Step 50: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Dentro: {quest:4493}, si la cogiste en {zone:1454} en la guía de {zone:1447}",

	-- Step 52: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} se entrega a {npc:8737} en el Cráter de Un'Goro: guárdala.",

	-- Step 53: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto al camino de {area:1336}, al sur de {area:976}.",

	-- Step 54: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Vuela a {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 55: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "El vuelo aterriza en {area:541}: {npc:9997} está junto al maestro de vuelo, y {npc:8737} junto a la cueva, a pocos pasos. El trabajo de {npc:9997} está en Un'Goro, en el camino de vuelta al norte de la siguiente guía.",
	-- {quest:3941} A Gnome's Assistance · {npc:9117} J.D. Collie · {area:541} Marshal's Refuge
	["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "{quest:3941} va para {npc:9117}, en la cueva de aquí, cuando la siguiente guía vuelva a {area:541}: guárdala.",

	-- Step 56: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "El paso desde Un'Goro sale en {area:3077}, el cementerio del noreste de {zone:1451}. {npc:13220} está entre las tumbas.",

	-- Step 57: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {quest:1123} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "Ve al suroeste hasta las ruinas de {area:2738}. {object:179565} para {quest:1123} está dentro de una de las casas en ruinas.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Hay un pergamino roto en la entrada de {area:2261}, la cripta al sur de {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Vuelve por el túnel, toma la salida a {area:618} y ve al sur hasta {area:2246}.",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "Vuelve por el túnel y toma la salida a {zone:1452}: {npc:11556} está justo donde desemboca.",
	-- ["Back to {area:1638}"] = "Vuelve a {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Vuela a {zone:1458}, toma el zepelín a {zone:1454} y sigue volando hasta {area:1638}.",
	-- ["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Vuela a {area:1099}. Los nidos de hipogrifo están en el sur de {zone:1444}; cada uno tiene un huevo para {object:142071}.",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Vuela a {area:541} y luego ve al suroeste por el Cráter de Un'Goro hasta el paso hacia {zone:1451}. La siguiente guía empieza en {area:3077}, donde sale el paso.",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Los canes de la Peste demenciados y los murcipestes monstruosos comparten los campos alrededor de {area:2272} y {area:2271}, al sur de {area:2273}.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atraviesa {area:1769} y toma el ramal del túnel hacia {area:493}. {npc:11801} está en {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya se esconde entre los trols Fustamusgo de {area:2273}, en la esquina noreste.",
	-- ["Hameya's mound"] = "El montículo de Hameya",
	-- ["Hameya's scroll"] = "El pergamino de Hameya",
	-- ["Hippogryph eggs"] = "Huevos de hipogrifo",
	-- ["On to {zone:1451}"] = "Rumbo a {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "En {area:1641}. Lleva el paño de lana, el paño de seda y la tela de paño mágico en las bolsas.",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "Solo si aún llevas {quest:2741}: cabalga al sur desde {area:1099}; los nidos de hipogrifo están en el sur de {zone:1444}, y cada uno tiene un huevo para el Huevomático.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Los canes de la Peste y sus cachorros recorren las orillas del lago al suroeste de la capilla.",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Ve al este hasta {area:2255} y sal de allí hacia el norte; las lechubestias lunadón recorren las colinas de las laderas sur de {area:2241}. Atráelas de una en una.\nCuidado: los Hailspite, élites de nivel 60, se reúnen en los campos nevados al sureste de {area:2255}, donde también rondan algunas lechubestias lunadón: no te salgas de las laderas al norte del pueblo.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Ve al sur desde el refugio hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele los siete trozos con {item:15454} enseguida.\nCuidado: los sirvientes invisibles piden ayuda en un radio de 25 m cuando bajan al 40 % de salud. Fuera de combate, además, se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, puede unirse al combate un gran número de enemigos. Luchar cerca de las afueras reduce este riesgo.\nCon {quest:5211} en tu registro (de {npc:11063}, al final de la guía de Un'Goro), la Plaga alrededor del pueblo deja espíritus de Villa Darrow: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Ve al sur desde el refugio hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele los siete trozos con {item:15454} enseguida.\nCuidado: los sirvientes invisibles piden ayuda en un radio de 25 m cuando bajan al 40 % de salud. Fuera de combate, además, se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, puede unirse al combate un gran número de enemigos. Luchar cerca de las afueras reduce este riesgo.\nCon {quest:5211} en tu registro (de {npc:11063}, al principio de esta guía), la Plaga alrededor del pueblo deja espíritus de Villa Darrow: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Cabalga al sur desde {area:1099}: los nidos de hipogrifo están en el sur de {zone:1444}; cada uno tiene un huevo para {object:142071}.",
	-- ["Sword of Marduk"] = "Espada de Marduk",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Los Anales están entre los tomos mohosos del ayuntamiento de Andorhal; ábrelos hasta encontrar el correcto.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Los especialistas, zancaminos y leñantros altos elfos guardan el refugio junto a {area:2275}; el registro está dentro. Los especialistas llegan al nivel 60: atráelos de uno en uno. Por el camino, los murcipestes tóxicos sobrevuelan los campos.\nLa calavera está en {area:2622}, entre Horrores malditos y Monstruosidades de la peste.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "La espada rota está en el suelo, al noroeste del lago.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "El cráneo está en {area:2622}, entre horrores apestados y monstruosidades de la Peste.",
	-- ["The western hills"] = "Las colinas del oeste",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "La máquina {object:142071}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} está justo detrás de {area:2261}.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele los siete trozos con {item:15454} enseguida.",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880} recorre {object:172982} y las calles que salen de él: búscalo de camino a la torre del maestro de vuelo; el círculo del mapa es su recorrido.",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}: para {npc:7776} en {quest:7492}, al final de esta guía",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "{npc:11140}, el fantasma, está junto a una cabaña en {area:2627}, en la esquina noroeste.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}.",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} es un fantasma del cementerio justo al norte de {area:976}; la lápida llamativa está al sur, fuera de la muralla del pueblo.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "El maestro de vuelo de {object:1661} está en la torre oeste de {object:36078}, fuera de las murallas.",
}
