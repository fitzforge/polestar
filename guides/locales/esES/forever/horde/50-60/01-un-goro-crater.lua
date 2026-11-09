-- Spanish (Spain) (esES): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "Hacia {zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "Desde {area:1938} cabalga hacia el oeste hasta la larga rampa que baja serpenteando a {zone:1449}; después sigue la pared norte del cráter hasta {area:541}, un campamento en las cuevas del acantilado. Aquí todos son neutrales.",
	-- {npc:9997} Spraggle Frock
	["the wooden sign beside {npc:9997}, by the flight master: the pterrordax are on this guide's ground"] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "",

	-- Step 3: Out of the refuge
	["Out of the refuge"] = "Fuera del refugio",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, en la entrada del refugio",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, justo fuera",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "A partir de aquí recoge cada Cristal de poder (azul, verde, rojo, amarillo) y cada montón de {quest:3761} que encuentres: 25 de tierra en total, 20 para Hamuul y 5 para Morterozugg.",

	-- Step 4: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Los pozos de alquitrán están justo al sur del refugio. Las Bestias Tar, los Rondadores Tar y los Trepadores Tar sueltan el {item:11834}.",

	-- Step 5: Pterrordax
	["Pterrordax"] = "Pterrordáctilo",
	-- {npc:9998} Shizzle
	["Pterrordax fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}."] = "",
	["grind on Pterrordax"] = "",

	-- Step 6: Power Crystals and soil
	["Power Crystals and soil"] = "Cristales de poder y tierra",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Los grupos de cristales están por todo el cráter, muchos alrededor de {area:537}. Coge unos cuantos de más de cada color para los pilones.",

	-- Step 7: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "",
	-- {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:8659} Jes'rimon · {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Dinosaur Bones = {item:11114} Dinosaur Bone · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "",

	-- Step 8: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "El equipo perdido de la expedición está en la jungla del suroeste.",

	-- Step 9: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",
	-- {npc:6551} Gorishi Wasp
	["grind on {npc:6551}"] = "",

	-- Step 11: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Stegodons y ravasaurios",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, botín raro",
	["Use the Mangled Journal to start it"] = "Usa Un diario destrozado para empezarla",

	-- Step 12: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} acampa en la esquina sureste del cráter.",

	-- Step 13: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "Al norte de Torwa yace un trillanodonte muerto junto al agua.",

	-- Step 15: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Amigos de Lar'korwi",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "Los Amigos de Lar'korwi merodean por la jungla al noroeste de {npc:9619}.",

	-- Step 16: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "La balsa está en la orilla del lago del sureste; la mochila pequeña está en el agua, a su lado.",
	["Underwater"] = "",

	-- Step 18: Lashers and Threshers
	["Lashers and Threshers"] = "Latigadores y Trilladores",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Cabalga hacia el norte por el lado este. La jungla está llena de Latigadores y Trilladores pétalo de sangre.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "",

	-- Step 19: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "El cajón de la expedición está en un campamento abandonado de la jungla oriental.",

	-- Step 20: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, en la entrada",
	-- {npc:9997} Spraggle Frock
	["{npc:9997}, beside the flight master"] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Guarda {quest:4147}, de {npc:9118}, y la carta de {npc:8737} para guías posteriores.",

	-- Step 21: Northern Pylon
	["Northern Pylon"] = "Pilón del norte",
	["The pylon stands on the slope east of the refuge."] = "El pilón está en la ladera al este del refugio.",

	-- Step 22: Gorillas
	["Gorillas"] = "Gorilas",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Los gorilas viven en la meseta del noreste. No entres en la cueva más profunda: allí vive {npc:9622}.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau; below ground"] = "",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Después {npc:9623} pide una {item:10561}, un objeto de {skill:202}. Omítela salvo que tengas una.",

	-- Step 23: Un'Goro Crater: kill these as you meet them
	-- {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast {spell:8137} and Tunnelers and the Hive Guard use {spell:14120}."] = "",

	-- Step 24: Eastern Pylon
	["Eastern Pylon"] = "Pilón del este",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Baja por el lado este del cráter hasta el pilón de los acantilados orientales.",

	-- Step 25: The Marshlands
	-- {quest:4061} The Rise of the Machines · {area:340} Kargath · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time.\nBelow level 52, keep hunting the ravasaurs here after the eighth claw: {quest:4061} at {area:340} needs level 52, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	["grind on Ravasaur"] = "",

	-- Step 26: Western Pylon
	["Western Pylon"] = "Pilón del oeste",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Cruza el sur del cráter hasta el pilón de los acantilados occidentales.",

	-- Step 27: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "Vuelve al norte, a {area:541}.",
	["Below ground"] = "",

	-- Step 28: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "",

	-- Step 29: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 30: Orgrimmar
	-- {area:1637} Orgrimmar · {area:16727} Powderfuse Port · {zone:1458} Undercity
	["Fly to {area:1637} and train before the boat to {area:16727}: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "",

	-- Step 31: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 32: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",
	-- {npc:9706} Yorba Screwspigot · {quest:4324} Yuka Screwspigot · {area:251} Flame Crest
	["{npc:9706}, by the dock: for {quest:4324} at {area:251}, later in this guide"] = "",

	-- Step 33: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {zone:1418} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {zone:1418}."] = "",

	-- Step 34: Kargath
	-- {area:340} Kargath · {zone:1418} Badlands
	["{area:340} is built into the cliffs on the {zone:1418}' west edge."] = "",

	-- Step 35: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "Hacia {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Toma el paso del lado oeste de {area:340} hacia {zone:1427}; después cabalga hacia el sur cruzando la garganta hasta el largo puente que entra en {area:254}. Dentro, baja por las pasarelas de cadenas y sal por la salida sur; no tomes los caminos a los portales de las mazmorras.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Puente hacia {area:254}",

	-- Step 36: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "La montaña te deja salir junto a {area:252}, lleno de orcos de nivel 55-57. Sigue el camino hacia el este por los acantilados del norte hasta el campamento de la Horda en {area:251}.",

	-- Step 37: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Sigue los acantilados hacia el sur hasta {quest:3821}, la colina de los ogros Pirontraña. Los restos de {npc:9136} están al pie.",

	-- Step 38: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} recorre las cuevas y túneles de mina de {quest:3821}; si no está, limpia los ogros de las entradas hasta que vuelva.",

	-- Step 39: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven · {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "",

	-- Step 40: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Vuelve al noreste, a {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Guarda la carta de {npc:10267}: {quest:4808} está en {area:2255}, {zone:1452}.",

	-- Step 41: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "El siguiente encargo de Theodora te lleva con Lotwil, al este del pueblo, y luego a {area:1584}: omítelo.",

	-- Step 42: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "",

	-- Step 43: Apothecary Lydon
	["Inside"] = "",

	-- Step 44: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 45: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, junto al maestro de murciélagos",

	-- Step 46: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} está en {object:36082}.",

	-- Step 47: Undercity
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, El Apothecarium: los viales se llenan más tarde en {zone:1447}",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, near Cuely in the Apothecarium"] = "",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",

	-- Step 49: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Sal de {zone:1458} y cabalga hacia el este por el camino a través de {zone:1420} hasta {area:152}, el fuerte de los Renegados en la frontera.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Coge una {object:176092} del cajón junto a Derrington para {quest:5096}, que harás a la vuelta. Equípate {quest:5401}: las Piedras de la Plaga solo caen mientras lo llevas puesto.",

	-- Step 50: Janice Felstone
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {npc:10778} Janice Felstone
	["From the {area:152}, follow the road east into the {zone:1422}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "",
	["Upstairs"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house; inside"] = "",
	-- {npc:10781} Royal Overseer Bauhaus · {zone:1458} Undercity
	["Keep the parcel: {npc:10781} is in the {zone:1458}."] = "",

	-- Step 51: Scarlet forward camp
	["Scarlet forward camp"] = "Campamento avanzado Escarlata",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Las tiendas de la Cruzada Escarlata están entre {area:199} y {area:200}. Incendia la tienda de mando con la {object:176092} y planta el estandarte de la Plaga.",

	-- Step 53: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Sigue el camino hacia el este a través de {zone:1422} y cruza el río hacia {zone:1423}; déjalo hacia el norte para ir a {area:2627}, el pueblo en ruinas del noroeste. {npc:12384} está en una choza en las afueras.",

	-- Step 54: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The book lies in the ruined inn of {area:2627}.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "",

	-- Step 55: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Vuelve al sur hasta el camino y síguelo hacia el este cruzando toda la zona hasta {area:2268}.",

	-- Step 56: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Con la misión de {npc:11063} en tu registro, la Plaga que matas a veces deja un {npc:11064}; habla con él para liberarlo. Mata no-muertos de camino al suroeste, hacia {area:2262}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libera Espíritus de Villa Darrow: habla con ellos",

	-- Step 57: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "El fantasma de {npc:10926} está en las ruinas de {area:2262}, en el suroeste.",

	-- Step 58: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "La cabeza de la muñeca y sus dos mitades están en las casas alrededor de {npc:10926}; únelas desde tus bolsas.",

	-- Step 59: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}, where this guide ends"] = "",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "",

	-- Step 60: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "",

	-- Step 61: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",

	-- Step 62: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Vuelve a {area:2268}",

	-- Step 63: Fly to Tarren Mill
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "",

	-- Step 64: The road north
	["The road north"] = "",
	-- {area:197} Sorrow Hill
	["The road north to {area:197}"] = "",

	-- Step 65: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "",

	-- Step 66: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cabalga al noroeste hasta las Ruinas de Andorhal. {npc:10667} espera en la posada en ruinas del lado oeste del pueblo; los esqueletos son de nivel 54-57, así que ve por los bordes.",

	-- Step 67: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Los Anales están entre los Libros enmohecidos del ayuntamiento de Andorhal; ábrelos hasta dar con el correcto.",

	-- Step 68: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{quest:5210} goes to {area:2268}: keep it for later. The next guide starts with {npc:10739} by the {area:202}, east of Andorhal."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Black Broodlings"] = "Cachorrillos negros",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Los Cachorrillos negros anidan en las colinas justo al este de {area:251}. Usa el {item:12284} de {npc:10267} en un cachorrillo cuando esté casi muerto para capturar su esencia.",
	-- ["Bloodpetal Flayers"] = "Despellejadores pétalo de sangre",
	-- ["Darrowshire Spirits"] = "Espíritus de Villa Darrow",
	-- ["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- ["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Vuela a {area:1637} y entrena antes del zepelín de {object:3202}: la parada en {zone:1458} más adelante en esta guía no tiene instructor de cazador ni de chamán.",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Vuela a {area:1637}, toma el zepelín a {object:3202} y vuela desde allí a {area:340}, construido en los acantilados del borde oeste de {zone:1418}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Vuela a {area:1638} y entrena con {npc:3033} en {area:1639}; después vuela a {area:1637} para tomar el zepelín de {object:3202}.",
	-- ["Fly to {area:340}"] = "Vuela a {area:340}",
	-- ["Follow the road east through the {area:28} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Sigue el camino hacia el este a través de {area:28} y cruza el río hacia {area:139}; déjalo hacia el norte para ir a {area:2627}, el pueblo en ruinas del noroeste. {npc:12384} está en una choza en las afueras.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "Desde {area:1938} cabalga hacia el oeste hasta la larga rampa que baja serpenteando a {area:490}; después sigue la pared norte del cráter hasta {area:541}, un campamento en las cuevas del acantilado. Aquí todos son neutrales.",
	-- ["Gorillas"] = "Gorilas",
	-- ["Into {area:490}"] = "Hacia {area:490}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarda el cebo: {npc:9684} es de nivel 56 y la segunda vuelta pasa por su guarida.",
	-- ["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "Guarda {quest:5152}: Marlene vive en {area:197}, en {zone:1422}.",
	-- ["Lashers and Threshers"] = "Latigadores y Trilladores",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Lleva a {npc:9999} hacia el norte hasta {area:541}. Cuando se desmaye, usa {item:11804} con él para despertarlo.",
	-- ["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "Sal de {zone:1458} y cabalga hacia el este por el camino a través de {area:85} hasta {area:152}, el fuerte de los Renegados en la frontera.",
	-- ["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "La siguiente misión de Morterozugg requiere a la {npc:10041}, un jefe élite. Omítela.",
	-- ["Power Crystals and soil"] = "Cristales de poder y tierra",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Cabalga hacia el este hasta {area:537}, súbelo y usa {npc:10541} en la grieta de lava cerca de la cima; después vuelve al oeste con {npc:10302}.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Cabalga hacia el norte por el lado este. La jungla está llena de Latigadores y Trilladores pétalo de sangre.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Cabalga hacia el suroeste por los acantilados occidentales. Los {npc:9167} vuelan sobre el lado oeste, y los Tramperos pétalo de sangre crecen en la misma jungla.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Cabalga hacia el suroeste hasta {area:537}, el volcán del centro del cráter. Los Despellejadores pétalo de sangre crecen al pie.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Cabalga hacia el oeste hasta la excavación. Los gólems {npc:7039} (53) patrullan a su alrededor y sueltan a menudo los fragmentos; {quest:4296} está en el centro, entre los enanos Thaurissan. Cópiala.",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "Al sur de las aguas termales pastan los Stegodons, que sueltan Huesos de dinosaurio (también los hay en el suelo); los Diemetradones de al lado llevan las escamas que quiere {npc:9998}. Los Ravasaurios cazan en manada en el suroeste: sus garras son para {npc:8659}, y de vez en cuando uno lleva Un diario destrozado (botín raro: acepta su misión solo si te sale). Evita a Gruff, un Stegodon de nivel 57.",
	-- ["Termite mounds"] = "Montículos de termitas",
	-- ["Thaurissan dig site"] = "Excavación de Thaurissan",
	-- ["The Gorishi hive"] = "La colmena Gorishi",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Los Montículos grandes de termitas están por todas las colinas al este de {area:2627}. Usa la {item:15042} en cada montículo que encuentres.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "El libro está en la posada en ruinas de {area:2627}.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "El cajón de la expedición está en un campamento abandonado de la jungla oriental.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Los gorilas viven en la meseta del noreste. No entres en la cueva más profunda: allí vive {npc:9622}.",
	-- ["The next guide starts here, at the chapel's flight master."] = "La siguiente guía empieza aquí, en el maestro de vuelo de la capilla.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "La colmena silítida ocupa el sur del cráter. Las Avispas y los Obreros Gorishi sueltan la glándula de olor; usa el Vial de raspadura en la masa de huevos de la primera cámara. La Reina de la colmena Gorishi, al fondo, es un jefe élite: no entres en su cámara. Los {npc:9166} anidan en los acantilados sobre la colmena; sus escamas son para {npc:9998}.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Los pozos de alquitrán están justo al sur del refugio. Las Bestias Tar, los Rondadores Tar y los Trepadores Tar sueltan el {item:11834}.",
	-- ["The wooden sign beside {npc:9997}"] = "El cartel de madera junto a {npc:9997}",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "La misión de Theodora en {area:340} requiere nivel 52. Los Rondadores Tar y Señores Tar, justo al sur del refugio, son el campamento más cercano.",
	-- ["Western jungle"] = "Jungla occidental",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "farmea Rondadores Tar en {area:538}, {zone:1449}",
	-- ["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} te envía con {npc:9298} en {zone:1452}: guárdala.",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "El goblin {npc:10302} está en {area:543}, justo al este del pilón.",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} acecha justo al oeste de {area:2262}.",
	-- ["{npc:8390}, the {object:36072}: the vials fill in {zone:1447} later"] = "{npc:8390}, {object:36072}: los viales se llenan más tarde en {zone:1447}",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, al fondo de la cueva",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Ahora {npc:9619} pide la piel de {npc:9622}, en la cueva del noreste: omítela.",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Después {npc:9623} pide una {item:10561}, un objeto de {skill:202}. Omítela salvo que tengas una.",
	-- ["{npc:9623}, the robot on the plateau"] = "{npc:9623}, el robot de la meseta",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "La guarida de {npc:9684} está justo al sur del pilón. Usa allí el cebo de {npc:9619}; {npc:9684} es de nivel 56 y pega fuerte, así que empieza con la salud al máximo.",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} está sentado en la cresta, perdido y agotado.",
}
