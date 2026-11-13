-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "Sigue el camino al este desde {zone:1422}, cruza el río y atraviesa todas {zone:1423} hasta la capilla de {object:92525}, en el extremo este.",

	-- Step 3: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "El fantasma de {npc:10926} está en las ruinas de {area:2262}, al suroeste.",

	-- Step 4: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "La cabeza de la muñeca y sus dos lados están en las casas alrededor de {npc:10926}; únelos desde tus bolsas.",
	["Inside"] = "Adentro",

	-- Step 5: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "un mensaje para {npc:11063} en {area:2268}",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Guarda {quest:5152}: {npc:10927} vive en {area:197}, en {zone:1422}.",

	-- Step 6: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "Zaeldarr acecha justo al oeste de {area:2262}.",
	["Below ground"] = "Bajo tierra",

	-- Step 7: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: {npc:10411} se vuelve invisible fuera de combate y llama a Gárgolas Alarroca en cuanto empieza una pelea. Solo existen 3 y reaparecen cada 15 min.",

	-- Step 8: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "De vuelta a {area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "Los espíritus de {quest:5211} llegan con la parada en {area:2264} más adelante en esta guía: guárdala.",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "",

	-- Step 10: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "Hacia {area:197}",

	-- Step 11: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Cabalga al norte por el camino desde {area:272}. La casa de {npc:10927} está junto al camino en {area:197}, y el monumento de {npc:10936} está en el cementerio detrás de ella.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, en el piso de arriba",

	-- Step 12: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cabalga al noroeste hacia Andorhal. {npc:10667} espera en la posada en ruinas del lado oeste del pueblo; los esqueletos de adentro son de nivel 54-57, así que mantente en las orillas.",
	["Upstairs"] = "Arriba",

	-- Step 13: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Los Anales están entre los Tomos mohosos del ayuntamiento de Andorhal; ábrelos hasta encontrar el correcto.",

	-- Step 15: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Vuela a {area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "Cabalga de vuelta al sur hasta {area:272} y vuela a {area:2268}.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 16: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Los objetos de {quest:5168} están en las siguientes zonas de las Tierras de la Peste: guárdala.",

	-- Step 17: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "",

	-- Step 18: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}.",

	-- Step 19: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Los Cachorros de can de peste ({npc:8596}) y los Murcipestes ({npc:8600}) recorren las colinas al norte de {area:2260}, y las Larvas carroñeras ({npc:8603}) se arrastran entre ellos; avanza al norte hacia {area:2627}.",

	-- Step 20: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "El fantasma {npc:11140} está junto a una choza en {area:2627}, en la esquina noroeste.",

	-- Step 21: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Los Canes de peste demenciados ({npc:8598}) y los Murcipestes monstruosos ({npc:8602}) comparten los campos alrededor de {area:2272} y {area:2271}, al sur de {area:2273}.",

	-- Step 22: Eastern Plaguelands: kill these as you meet them
	-- {area:2275} Northpass Tower · {area:2622} Pestilent Scar
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Blighted Horrors = {npc:8521} Blighted Horror
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "",
	["Underwater"] = "Bajo el agua",

	-- Step 23: Pathstrider
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "",

	-- Step 24: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Cabalga hacia el sur desde el refugio hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con el {item:15454} de inmediato.\nCuidado: los Sirvientes invisibles piden ayuda en un radio de 25 m cuando bajan al 40% de salud. Fuera de combate también se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, muchos enemigos pueden unirse a la pelea. Luchar en las afueras reduce ese riesgo.\nCon {quest:5211} en tu registro (de {npc:11063} al inicio de esta guía), la Plaga alrededor del pueblo deja Espíritus de Darrowshire: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libera a los Espíritus de Darrowshire: habla con ellos",

	-- Step 25: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Cabalga al oeste hasta {area:2260}.",

	-- Step 27: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 29: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",

	-- Step 30: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 31: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 32: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",

	-- Step 33: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} en {area:1639}; {npc:246344}",

	-- Step 34: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 36: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 37: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Solo si te salió un {quest:8471}: {npc:11558} espera en la entrada de {area:1769} del lado de {zone:1448}, y solo te habla si eres Neutral con los Fauces de Madera.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 39: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atraviesa {area:1769} y toma el ramal del túnel hacia {zone:1450}. {npc:11801} está en {area:2361}.",

	-- Step 40: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 41: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Ambas misiones llevan a {zone:1451}: guárdalas.",

	-- Step 43: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Regresa por el túnel y toma la salida a {zone:1452}; luego cabalga al sur hasta {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "",

	-- Step 44: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Lechubestias lunadón ({npc:7453})",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Cabalga al este hasta {area:2255} y sal al norte; las Lechubestias lunadón ({npc:7453}) recorren las colinas de las laderas sur de {area:2241}. Atráelas de una en una.",

	-- Step 46: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 47: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Bebe el {item:11243} en el cementerio justo al este de {area:976}: te mata, y solo como fantasma puedes ver a {npc:9299}, en una grieta rocosa en las colinas justo al norte de allí. Habla con él allí, luego corre de vuelta a tu cuerpo y resucita: la Lápida llamativa a la que te envía está en ese cementerio.",

	-- Step 48: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Usa {item:12928} en {npc:7583}, la niña goblin de {area:976}. {npc:10977} y {npc:10978} se asustan más adelante en la ruta.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Asusta a {npc:7583} con {item:12928}",

	-- Step 49: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} regresa con {npc:8737} en Un'Goro: guárdala.",

	-- Step 50: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto al camino de {area:1336}, al sur de {area:976}.",

	-- Step 51: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 52: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "",
	-- {quest:3941} A Gnome's Assistance · {npc:9117} J.D. Collie · {area:541} Marshal's Refuge
	["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "",

	-- Step 53: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "El paso desde Un'Goro sale en {area:3077}, el cementerio del noreste de {zone:1451}. {npc:13220} está entre las tumbas.",

	-- Step 54: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {quest:1123} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Un pergamino roto está en la entrada de {area:2261}, la cripta al sur de {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Regresa por el túnel y toma la salida a {area:618}; luego cabalga al sur hasta {area:2246}.",
	-- ["Back to {area:1638}"] = "De vuelta a {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Vuela a {zone:1458}, toma el zepelín a {zone:1454} y luego vuela a {area:1638}.",
	-- ["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Vuela a {area:1099}. Los nidos de hipogrifo están en el sur de {zone:1444}; cada uno tiene un huevo para {object:142071}.",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Vuela a {area:541} y luego cabalga al suroeste por Un'Goro hasta el paso hacia {zone:1451}. La siguiente guía empieza en {area:3077}, donde sale el paso.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atraviesa {area:1769} y toma el ramal del túnel hacia {area:493}. {npc:11801} está en {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya se esconde entre los trols Fustamusgo de {area:2273}, en la esquina noreste.",
	-- ["Hameya's mound"] = "El montículo de Hameya",
	-- ["Hameya's scroll"] = "El pergamino de Hameya",
	-- ["Hippogryph eggs"] = "Huevos de hipogrifo",
	-- ["On to {zone:1451}"] = "Rumbo a {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "En {area:1641}. Lleva el paño de lana, de seda y de tejido mágico en tus bolsas.",
	-- ["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Solo si encontraste un frasco de {item:12820} en {area:618}: cabalga al norte por el camino. El caldero está en {area:1762}, justo al suroeste de {area:1769}; los furbolgs Muertobosque de allí son hostiles.",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "Solo si todavía llevas {quest:2741}: cabalga al sur desde {area:1099}; los nidos de hipogrifo están en el sur de {zone:1444}, y cada uno tiene un huevo para el Huevomático.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Los Canes de peste ({npc:8597}) y sus cachorros recorren las orillas del lago al suroeste de la capilla.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Cabalga hacia el sur desde el refugio hasta {area:2264}, por el camino. {item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con el {item:15454} de inmediato.\nCuidado: los Sirvientes invisibles piden ayuda en un radio de 25 m cuando bajan al 40% de salud. Fuera de combate también se vuelven invisibles con {spell:10228}. Si piden ayuda dentro del pueblo, muchos enemigos pueden unirse a la pelea. Luchar en las afueras reduce ese riesgo.\nCon {quest:5211} en tu registro (de {npc:11063} al final de la guía de Un'Goro), la Plaga alrededor del pueblo deja Espíritus de Darrowshire: habla con cada uno para liberarlo. Libéralos antes de empezar con {item:15447}.",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Cabalga al sur desde {area:1099}: los nidos de hipogrifo están en el sur de {zone:1444}; cada uno tiene un huevo para {object:142071}.",
	-- ["Sword of Marduk"] = "Espada de Marduk",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Los Forestales ({npc:8564}) altos elfos, los Zancaminos ({npc:8565}) y los Trabajadores forestales custodian el refugio junto a {area:2275}; el registro está adentro. Los Forestales llegan a nivel 60: atráelos de uno en uno. Los Murcipestes nocivos ({npc:8601}) vuelan sobre los campos en el camino.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "La espada destrozada está en el suelo al noroeste del lago.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "El cráneo está en {area:2622}, entre Horrores contagiados ({npc:8521}) y Monstruosidades de peste.",
	-- ["The western hills"] = "Las colinas del oeste",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "La máquina {object:142071}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} está justo detrás de {area:2261}.",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con {item:15454} de inmediato.",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880} recorre {object:172982} y las calles que salen de allí: búscalo de camino a la torre del maestro de vuelo; el círculo en el mapa es su recorrido.",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}: para {npc:7776} en {quest:7492}, al final de esta guía",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}.",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} es un fantasma en el cementerio justo al norte de {area:976}; la lápida llamativa está al sur, afuera de la muralla del pueblo.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "El maestro de vuelo de {object:1661} está en la torre oeste de {object:36078}, afuera de las murallas.",
	-- ["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} están en {zone:1448}, en un viaje posterior: guárdala si la tienes.",
}
