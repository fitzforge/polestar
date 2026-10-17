-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Vuela a {area:2268}",
	-- {object:1661} The Undercity · {object:36078} Trade Quarter
	["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "El maestro de vuelo de {object:1661} está en la torre oeste de {object:36078}, afuera de las murallas.",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Los objetos de {quest:5168} están en las siguientes zonas de las Tierras de la Peste: guárdala.",

	-- Step 3: Lake Mereldar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Los Canes de peste ({npc:8597}) y sus cachorros recorren las orillas del lago al suroeste de la capilla.",

	-- Step 4: Sword of Marduk
	["Sword of Marduk"] = "Espada de Marduk",
	["The shattered sword lies on the ground north-west of the lake."] = "La espada destrozada está en el suelo al noroeste del lago.",

	-- Step 5: The Pestilent Scar
	-- {area:2622} Pestilent Scar
	["The {area:2622}"] = "{area:2622}",
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "El cráneo está en {area:2622}, entre Horrores contagiados ({npc:8521}) y Monstruosidades de peste.",

	-- Step 6: Hameya's scroll
	["Hameya's scroll"] = "El pergamino de Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Un pergamino roto está en la entrada de {area:2261}, la cripta al sur de {area:2260}.",

	-- Step 7: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead
	["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}.",

	-- Step 8: The western hills
	["The western hills"] = "Las colinas del oeste",
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Los Cachorros de can de peste ({npc:8596}) y los Murcipestes ({npc:8600}) recorren las colinas al norte de {area:2260}, y las Larvas carroñeras ({npc:8603}) se arrastran entre ellos; avanza al norte hacia {area:2627}.",

	-- Step 9: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "El fantasma {npc:11140} está junto a una choza en {area:2627}, en la esquina noroeste.",

	-- Step 10: Quel'Lithien Lodge
	-- {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Los Forestales ({npc:8564}) altos elfos, los Zancaminos ({npc:8565}) y los Trabajadores forestales custodian el refugio junto a {area:2275}; el registro está adentro. Los Forestales llegan a nivel 60: atráelos de uno en uno. Los Murcipestes nocivos ({npc:8601}) vuelan sobre los campos en el camino.",

	-- Step 11: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya se esconde entre los trols Fustamusgo de {area:2273}, en la esquina noreste.",

	-- Step 12: Northdale
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Los Canes de peste demenciados ({npc:8598}) y los Murcipestes monstruosos ({npc:8602}) comparten los campos alrededor de {area:2272} y {area:2271}, al sur de {area:2273}.",

	-- Step 13: Corin's Crossing
	-- {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} se echa a perder en diez minutos: mata rápido a la Plaga del pueblo y muele las siete piezas con {item:15454} de inmediato.",

	-- Step 14: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Cabalga al oeste hasta {area:2260}.",

	-- Step 15: Hameya's mound
	["Hameya's mound"] = "El montículo de Hameya",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just behind the {area:2261}."] = "{object:177675} está justo detrás de {area:2261}.",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:1638} Thunder Bluff
	["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Vuela a {zone:1458}, toma el zepelín a {zone:1454} y luego vuela a {area:1638}.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} en {area:1639}; {npc:246344}",

	-- Step 18: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "En {area:1641}. Lleva el paño de lana, de seda y de tejido mágico en tus bolsas.",

	-- Step 20: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {zone:1452} Winterspring · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Solo si encontraste un frasco de {item:12820} en {zone:1452}: cabalga al norte por el camino. El caldero está en {area:1762}, justo al suroeste de {area:1769}; los furbolgs Muertobosque de allí son hostiles.",

	-- Step 21: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Solo si te salió un {quest:8471}: {npc:11558} espera en la entrada de {area:1769} del lado de {zone:1448}, y solo te habla si eres Neutral con los Fauces de Madera.",

	-- Step 22: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atraviesa {area:1769} y toma el ramal del túnel hacia {zone:1450}. {npc:11801} está en {area:2361}.",
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Ambas misiones llevan a {zone:1451}: guárdalas.",

	-- Step 23: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Regresa por el túnel y toma la salida a {zone:1452}; luego cabalga al sur hasta {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} están en {zone:1448}, en un viaje posterior: guárdala si la tienes.",

	-- Step 24: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Lechubestias lunadón ({npc:7453})",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Cabalga al este hasta {area:2255} y sal al norte; las Lechubestias lunadón ({npc:7453}) recorren las colinas de las laderas sur de {area:2241}. Atráelas de una en una.",

	-- Step 25: Back to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Back to {area:1638}"] = "De vuelta a {area:1638}",

	-- Step 26: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "La máquina {object:142071}",

	-- Step 27: Sprinkle
	-- {npc:10980} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Usa {npc:10980} en {npc:7583}, la niña goblin de {area:976}. {npc:10977} y {npc:10978} se asustan más adelante en la ruta.",

	-- Step 28: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} es un fantasma en el cementerio justo al norte de {area:976}; la lápida llamativa está al sur, afuera de la muralla del pueblo.",
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914} regresa con Linken en Un'Goro: guárdala.",

	-- Step 29: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto al camino de {area:1336}, al sur de {area:976}.",

	-- Step 30: Hippogryph eggs
	["Hippogryph eggs"] = "Huevos de hipogrifo",
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Vuela a {area:1099}. Los nidos de hipogrifo están en el sur de {zone:1444}; cada uno tiene un huevo para {object:142071}.",

	-- Step 31: On to Silithus
	-- {zone:1451} Silithus
	["On to {zone:1451}"] = "Rumbo a {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus · {area:3077} Valor's Rest
	["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Vuela a {area:541} y luego cabalga al suroeste por Un'Goro hasta el paso hacia {zone:1451}. La siguiente guía empieza en {area:3077}, donde sale el paso.",
}
