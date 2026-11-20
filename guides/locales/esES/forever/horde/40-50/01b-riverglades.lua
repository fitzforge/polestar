-- Spanish (Spain) (esES): the guide forever/horde/40-50/01b-riverglades (forever/horde/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16743} Rog'mar
	["About 70 quests in Forever's new zone, from the fort of {area:16743}."] = "Unas 70 misiones en la nueva zona de Forever, desde el fuerte de {area:16743}.",

	-- Step 1: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Vuela a {area:340}",
	-- {zone:2548} Riverglades · {area:3} Badlands · {area:657} Harborage · {area:75} Stonard · {area:340} Kargath
	["The {zone:2548} lie south of the {area:3}. Ride east from the {area:657} to {area:75} and fly to {area:340}: the way down into the zone starts there."] = "{zone:2548} están al sur de {area:3}. Ve al este desde {area:657} hasta {area:75} y vuela a {area:340}: el camino de bajada a la zona empieza allí.",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 2: Into the Riverglades
	-- {area:16591} Riverglades
	["Into the {area:16591}"] = "Hacia {area:16591}",
	-- {area:16591} Riverglades · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {area:16743} Rog'mar
	["New in Forever: this guide follows what players did in the {area:16591}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nFrom {area:340}, ride south-east across the {area:3} to the zone's southern edge: the pass of {area:16685} leads down into the {area:16591}. {area:16743}, the Horde's fort, stands in the middle of the zone, east along the valley."] = "Nuevo en Forever: esta guía sigue lo que hicieron los jugadores en {area:16591}. Si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\nDesde {area:340}, cabalga al sureste a través de {area:3} hasta el borde sur de la zona: el paso de {area:16685} baja hasta {area:16591}. {area:16743}, el fuerte de la Horda, está en el centro de la zona, al este siguiendo el valle.",

	-- Step 3: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Vuela a {area:484}",
	-- {zone:2548} Riverglades · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port · {area:484} Freewind Post · {zone:1441} Thousand Needles · {area:439} Shimmering Flats · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud
	["New in Forever: this guide follows what players did in the {zone:2548}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe {zone:2548} lie across the sea from {zone:1446}: a goblin boat sails from {area:977}, north-east of {area:976}, to {area:16727}. Fly to {area:484} in {zone:1441} and head south-east through the {area:439} to {area:976}. (If you already know {area:340} in the {area:3}, the way in through {area:16685} works too.)"] = "Nuevo en Forever: esta guía sigue lo que hicieron los jugadores en {zone:2548}. Si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\n{zone:2548} están al otro lado del mar desde {zone:1446}: un barco goblin sale de {area:977}, al noreste de {area:976}, hacia {area:16727}. Vuela a {area:484} en {zone:1441} y ve al sureste por {area:439} hasta {area:976}. (Si ya conoces {area:340} en {area:3}, también puedes entrar por {area:16685}.)",

	-- Step 4: Gadgetzan
	-- {area:976} Gadgetzan
	["Learn {area:976}'s flight path: it saves the ride next time."] = "Aprende la ruta de vuelo de {area:976}: te ahorrará el viaje la próxima vez.",

	-- Step 5: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",
	-- {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port
	["{area:977} is on the coast north-east of {area:976}: wait on the pier for the goblin boat to {area:16727}."] = "{area:977} está en la costa al noreste de {area:976}: espera en el muelle el barco goblin a {area:16727}.",

	-- Step 6: Powderfuse Port
	-- {npc:255897} Friz Frazzlespark
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{npc:255897} keeps a stall at the west end of the docks. The port's other jobs are for later in this guide: this crate goes to the Horde's fort."] = "Nuevo en Forever: si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\n{npc:255897} tiene un puesto en el extremo oeste de los muelles. Los demás encargos del puerto son para más adelante en esta guía: esta caja va al fuerte de la Horda.",
	-- {quest:95062} Frazzlespark's Crate · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95062}: for {npc:256418} in {area:16743}"] = "{quest:95062}: para {npc:256418} en {area:16743}",

	-- Step 7: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "Taller de {npc:263367}",
	-- {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["West up the road from the port: {npc:263367} has his workshop on the hill. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "Ve al oeste por el camino desde el puerto: {npc:263367} tiene su taller en la colina. Las fumarolas de gas están en la marisma al suroeste, en tu primera cacería para {npc:258031}.",

	-- Step 8: Rog'mar
	-- {area:16743} Rog'mar · {npc:258031} Neza Bloodsnout · {npc:256657} Kreza Darkthorn · {npc:256418} Krom'rosh · {npc:255993} Grakna · {npc:256675} Innkeeper Toka · {npc:263190} Tan'jani
	["West to {area:16743}, the Horde's fort in the middle of the zone. {npc:258031} stands on its east side, {npc:256657} and {npc:256418} in the middle with {npc:255993}, the wind rider master; {npc:256675} and {npc:263190} on the west side."] = "Ve al oeste hasta {area:16743}, el fuerte de la Horda en el centro de la zona. {npc:258031} está en el lado este, {npc:256657} y {npc:256418} en el centro con {npc:255993}, la maestra de jinetes del viento; {npc:256675} y {npc:263190} en el lado oeste.",
	-- {npc:256418} Krom'rosh · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:256418}: Aggro'gosh's report from {object:3202}, if you carry it"] = "{npc:256418}: el informe de Aggro'gosh desde {object:3202}, si lo llevas",
	-- {npc:255993} Grakna
	["{npc:255993}, in the middle of the fort"] = "{npc:255993}, en el centro del fuerte",
	-- {npc:263190} Tan'jani · {quest:95033} On the Other Side · {npc:8115} Witch Doctor Uzer'i · {area:1099} Camp Mojache · {zone:1444} Feralas
	["{npc:263190}: {quest:95033}, for {npc:8115} at {area:1099} in the {zone:1444} guide"] = "{npc:263190}: {quest:95033}, para {npc:8115} en {area:1099}, en la guía de {zone:1444}",

	-- Step 9: Krom'rosh
	-- {npc:256418} Krom'rosh
	["Frazzlespark's crate from the port goes to {npc:256418}, in the middle of the fort."] = "La caja de Frazzlespark del puerto es para {npc:256418}, en el centro del fuerte.",

	-- Step 10: Sleebo Fizzlespout's workshop
	-- {area:16727} Powderfuse Port · {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["East of Rog'mar, on the hill above the road to {area:16727}: {npc:263367} has his workshop there. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "Al este de Rog'mar, en la colina sobre el camino a {area:16727}: allí tiene su taller {npc:263367}. Las fumarolas de gas están en la marisma al suroeste, en tu primera cacería para {npc:258031}.",

	-- Step 11: The plains and the marsh
	["The plains and the marsh"] = "Las llanuras y la marisma",
	-- {area:16729} Terral's Watch · {quest:96103} A Feast for Buzzards
	-- plural, as words: Low Plains Buzzards = {npc:263343} Low Plains Buzzard
	["South-east of Rog'mar the plains run down to {area:16729}. The Low Plains Buzzards circle everywhere; a picked carcass lies in the grass (its skull starts {quest:96103}), and the marsh vents are just past it."] = "Al sureste de Rog'mar, las llanuras bajan hasta {area:16729}. Los ratoneros de las Llanuras Bajas vuelan en círculos por todas partes; hay un cadáver descarnado en la hierba (su cráneo inicia {quest:96103}), y las fumarolas de la marisma están justo después.",

	-- Step 12: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to the workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "Ve al noreste hasta el taller. La prueba de esfuerzo de {npc:263367} es un combate contra su G45-B4G junto al taller: entrega la misión cuando lo derrotes.",
	["the stress test: beat G45-B4G beside the workshop"] = "la prueba de resistencia: derrota a G45-B4G junto al taller",

	-- Step 13: Neza Bloodsnout
	-- {area:16743} Rog'mar
	["West back to {area:16743}'s east side."] = "Vuelve al oeste, al lado este de {area:16743}.",

	-- Step 14: The vipers and the tallstriders
	["The vipers and the tallstriders"] = "Las víboras y los zancaltos",
	-- {npc:257079} Cavalry Scout Alturin · {area:16729} Terral's Watch · {area:16725} Wheeler's Grange
	-- plural, as words: Glade Vipers = {npc:263307} Glade Viper · Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Glade Vipers hide in the long grass south-east of town; the Roving Tallstriders graze beside them. {npc:257079}, an Alliance elite (level 45), rides the road from {area:16729} to {area:16725} along the grass's south-west edge: keep clear of him."] = "Las Víboras del claro se esconden en la hierba alta al sureste del pueblo; los Zancaltos errantes pastan a su lado. {npc:257079}, un élite de la Alianza (nivel 45), recorre el camino de {area:16729} a {area:16725} por el borde suroeste de la hierba: no te acerques a él.",

	-- Step 16: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16743} Rog'mar
	["{npc:263315}, an elite lion (level 41), prowls the plains south of {area:16743}, where the lions are: grouping up is advised."] = "{npc:263315}, un león élite (nivel 41), merodea por las llanuras al sur de {area:16743}, donde están los leones: se recomienda ir en grupo.",

	-- Step 17: The lions
	["The lions"] = "Los leones",
	-- {area:16743} Rog'mar · {npc:263315} Ombassa
	["The Wildplains lions roam the plains just south of {area:16743}.\nCareful: {npc:263315}, an elite lion (level 41), prowls the same plains around 59.6,53.2: keep an eye out for him and pull the lions away from where he walks."] = "Los leones de las Llanuras Salvajes deambulan por las llanuras justo al sur de {area:16743}.\nCuidado: {npc:263315}, un león élite (nivel 41), merodea por las mismas llanuras hacia 59.6,53.2: vigílalo y aleja a los leones de su camino.",

	-- Step 20: Neza Bloodsnout's elites
	-- {npc:258031} Neza Bloodsnout
	["{npc:258031}'s elites"] = "Los élites de {npc:258031}",

	-- Step 21: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906} es un gnoll élite (nivel 40) que recorre los campamentos del suroeste de {area:16737}: se recomienda ir en grupo.",

	-- Step 23: Turner's Logging Camp
	-- {npc:263380} Ghostmaw
	-- plural, as words: Wood Bundles = {item:271629} Wood Bundle · Peasant Woodpiles = {object:645516} Peasant Woodpile · Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["South-west across the river to the Alliance lumber camp. The lumberjacks carry the axes. Loot Wood Bundles from the Peasant Woodpiles around the camp and use them to fletch Makeshift Stickin' Spears. {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "Al suroeste, cruzando el río, hasta el campamento maderero de la Alianza. Los leñadores llevan las hachas. Despoja Montones de madera de las Pilas de leña de campesino del campamento y úsalos para fabricar Lanzas trinchadoras improvisadas. {npc:263380}, un élite (nivel 42), merodea por el río junto al campamento: si viene hacia ti, retrocede y déjalo pasar.",
	-- {item:271629} Wood Bundle
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["{item:271629}, from the Peasant Woodpiles"] = "{item:271629}, de las Pilas de leña de campesino",
	-- {item:271629} Wood Bundle
	-- plural, as words: Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["{item:271629}: fletch it into Makeshift Stickin' Spears"] = "{item:271629}: conviértelo en Lanzas trinchadoras improvisadas",

	-- Step 24: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp along the slopes and carry the stolen ore. Work south-west through their camps.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "Al oeste, hacia {area:16737}: los gnolls Crestagrana acampan por las laderas y llevan el mineral robado. Avanza hacia el suroeste por sus campamentos.\nCuidado: {npc:255906}, un gnoll élite (nivel 40), deambula por los campamentos del suroeste: aleja a los gnolls de él.",

	-- Step 26: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam
	["South-east out of the hills: {npc:262399}, a prospector who deals with both sides, has camped by the Cinderscale dragonkin's hollow."] = "Al sureste, saliendo de las colinas: {npc:262399}, una prospectora que trata con ambos bandos, ha acampado junto a la hondonada de los dragontantes Escamaceniza.",

	-- Step 27: The Cinderscale hollow
	["The Cinderscale hollow"] = "La hondonada Escamaceniza",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors guard its back, by the {item:271611}. The warriors are level 41-42: pull them one at a time. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "Las crías anidan por toda la hondonada; los guerreros guardan el fondo, junto a la {item:271611}. Los guerreros son de nivel 41-42: atráelos de uno en uno. Scaldaron, un draco élite raro, también puede estar aquí: no lo toques salvo que vayas en grupo.",

	-- Step 29: Meadowsbrook
	-- {area:16735} Meadowsbrook · {area:16744} Southern Watch · {npc:263380} Ghostmaw
	["East to {area:16735}, the Alliance farm by the river: the farmhands work the fields and the feed satchels lie by the barns. {area:16744}, the Alliance outpost on the road, has guards: pass south of it.\nCareful: {npc:263380}, an elite (level 42), hunts along the river by the farm: keep an eye on the riverbank."] = "Al este, hacia {area:16735}, la granja de la Alianza junto al río: los peones trabajan los campos y las bolsas de pienso están junto a los graneros. {area:16744}, el puesto de la Alianza en el camino, tiene guardias: pasa al sur de él.\nCuidado: {npc:263380}, un élite (nivel 42), caza a lo largo del río junto a la granja: vigila la orilla.",

	-- Step 30: Rog'mar
	-- {area:16743} Rog'mar · {npc:263190} Tan'jani · {npc:256418} Krom'rosh · {npc:256655} Gorg · {npc:256657} Kreza Darkthorn · {npc:258031} Neza Bloodsnout
	["Back to {area:16743}, where your Hearthstone is set: {npc:263190} on the fort's west side first, then {npc:256418}, {npc:256655} by the cook fire, {npc:256657} and {npc:258031} on your way east through the fort."] = "Vuelve a {area:16743}, donde tienes vinculada la Piedra de hogar: primero {npc:263190}, en el lado oeste del fuerte; luego {npc:256418}, {npc:256655} junto a la hoguera, {npc:256657} y {npc:258031} de camino al este por el fuerte.",
	-- {npc:256655} Gorg
	["{npc:256655}, by the cook fire"] = "{npc:256655}, junto a la hoguera",
	-- {quest:93976} The Goblin Trader · {npc:255897} Friz Frazzlespark · {area:16727} Powderfuse Port
	["{quest:93976}: for {npc:255897} in {area:16727}, keep it"] = "{quest:93976}: para {npc:255897} en {area:16727}, guárdala",

	-- Step 32: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16743} Rog'mar
	["{npc:263380} is an elite (level 42) who hunts along the river south-west of {area:16743}, by the Farholde camp you go to next: grouping up is advised. The poster hangs in the middle of the fort."] = "{npc:263380} es un élite (nivel 42) que caza a lo largo del río al suroeste de {area:16743}, junto al campamento de Farholde al que vas después: se recomienda ir en grupo. El cartel cuelga en el centro del fuerte.",
	-- {object:645164} WANTED! (no name in this language: may be words)
	["the {object:645164} poster"] = "el cartel de {object:645164}",

	-- Step 33: The training grounds
	["The training grounds"] = "El campo de entrenamiento",
	-- {npc:256655} Gorg · {item:265066} Hearty Stew · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Trainees = {npc:256749} Rog'mar Trainee
	["North of the fort the Rog'mar Trainees drill: use {npc:256655}'s {item:265066} on them.\nCareful: {npc:263380}, an elite (level 42), can come up from the river south of the fort: let him pass."] = "Al norte del fuerte entrenan los Aprendices de Rog'mar: usa el {item:265066} de {npc:256655} con ellos.\nCuidado: {npc:263380}, un élite (nivel 42), puede subir desde el río al sur del fuerte: déjalo pasar.",

	-- Step 35: The river and the Farholde camp
	["The river and the Farholde camp"] = "El río y el campamento de Farholde",
	-- {npc:263190} Tan'jani · {npc:257079} Cavalry Scout Alturin · {npc:263380} Ghostmaw
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["South-west of Rog'mar the river runs between the farms: impale the Freshwater Crocolisks with {npc:263190}'s spears. The Alliance trains its scouts and priests at a camp on the far bank. {npc:257079}, the Alliance elite, rides the road just east of the camp: pull the scouts and priests away from it.\nCareful: {npc:263380}, an elite (level 42), hunts along this river: if he comes your way, back off and let him pass."] = "Al suroeste de Rog'mar, el río corre entre las granjas: empala a los Crocoliscos de agua dulce con las lanzas de {npc:263190}. La Alianza entrena a sus exploradores y sacerdotes en un campamento en la otra orilla. {npc:257079}, el élite de la Alianza, recorre a caballo el camino justo al este del campamento: aleja a los exploradores y sacerdotes de él.\nCuidado: {npc:263380}, un élite (nivel 42), caza a lo largo de este río: si viene hacia ti, retírate y déjalo pasar.",
	-- {npc:263190} Tan'jani
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["{npc:263190}'s spears, on the Freshwater Crocolisks in the river"] = "",

	-- Step 39: Tran'gul
	-- {npc:256710} Tran'gul · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["{npc:256710} stands beside {npc:256418} in the middle of {area:16743}: now that the Farholde camp has had its lesson, he has work in {area:16723}."] = "{npc:256710} está junto a {npc:256418} en el centro de {area:16743}: ahora que el campamento de Farholde ha recibido su lección, tiene trabajo en {area:16723}.",

	-- Step 40: Fuzzle
	-- {area:16723} Sunnyglade · {npc:259158} Fuzzle
	["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158}, a kobold who wants out, hides in the middle of the town."] = "Al oeste de Rog'mar, el culto Crepuscular controla el pueblo agrícola de {area:16723}. {npc:259158}, un kóbold que quiere salirse, se esconde en el centro del pueblo.",

	-- Step 41: Sunnyglade
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade
	["The cultists fill the streets and fields; the Shadowmancers on the town's northern side carry the missives. The finger bones drop from all of them.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass."] = "Los cultores llenan las calles y los campos; los Umbromantes del lado norte del pueblo llevan las misivas. Los huesos de dedo los sueltan todos.\nCuidado: {npc:256899}, un ogro élite (nivel 41), recorre las calles occidentales de {area:16723}, hacia 44-47,47-52. Atrae a los cultores hacia ti y déjalo pasar.",

	-- Step 42: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158} quiere salir de {area:16723}: llévalo al oeste hasta su tesoro, en el borde del pueblo, y mantén a los cultistas lejos de él.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "guía a {npc:259158} fuera de {area:16723} hasta su tesoro, al oeste del pueblo",

	-- Step 43: Tran'gul
	-- {area:16743} Rog'mar
	["East back to {area:16743}."] = "Vuelve al este a {area:16743}.",
	-- {quest:94727} Digging for Answers · {npc:260931} Clubtoe · {area:16723} Sunnyglade
	["{quest:94727}: for {npc:260931} in {area:16723}"] = "{quest:94727}: para {npc:260931} en {area:16723}",

	-- Step 44: Clubtoe
	-- {area:16723} Sunnyglade · {npc:260931} Clubtoe · {npc:256710} Tran'gul
	["West to {area:16723} again: {npc:260931}, a Twilight miner who wants out, waits at the town's eastern edge. Talk him round, then hand {npc:256710}'s quest in; one of the missing ogres stands a few steps west."] = "Vuelve al oeste a {area:16723}: {npc:260931}, un minero Crepuscular que quiere salirse, espera en el borde este del pueblo. Convéncelo y luego entrega la misión de {npc:256710}; uno de los ogros desaparecidos está a unos pasos al oeste.",
	-- {npc:260931} Clubtoe
	["talk {npc:260931} round"] = "convence a {npc:260931}",
	-- {npc:261208} Twilight Brute
	["{npc:261208}, a few steps west"] = "{npc:261208}, a unos pasos al oeste",

	-- Step 45: The ritual grounds
	["The ritual grounds"] = "Los terrenos del ritual",
	-- {area:16723} Sunnyglade · {npc:256899} Chogg'Zac
	["The ritualists and their empowered brutes gather at the ritual circles in the middle of {area:16723}: wreck five of the circles.\nCareful: {npc:256899}, the elite ogre (level 41), walks through here from the western streets: watch for him before each pull."] = "Los ritualistas y sus brutos potenciados se reúnen en los círculos rituales del centro de {area:16723}: destruye cinco de los círculos.\nCuidado: {npc:256899}, el ogro élite (nivel 41), pasa por aquí desde las calles occidentales: búscalo antes de cada pull.",
	-- plural, as words: Twilight Ritual Circles = {npc:262006} Twilight Ritual Circle
	["destroy 5 Twilight Ritual Circles"] = "destruye 5 Círculos rituales Crepusculares",

	-- Step 47: Chogg'Zac
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:255829} Clugfist · {area:16726} Bolder'ok · {quest:95420} Land of Giants · {npc:258570} Da'grosh
	["Careful: {npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised under 43. Clear the cultists around him first and come in with full health and mana: recorded players of 42-43 killed him alone. {npc:255829}'s quests in {area:16726} wait on this one: skip him and {quest:95420}, the {area:16726} quests and {npc:258570}'s camp in the west go with him (about 21,000 XP); the guide then leaves them out."] = "Cuidado: {npc:256899}, el ogro de dos cabezas del borde oeste de {area:16723}, es un élite (nivel 41): se recomienda ir en grupo por debajo del nivel 43. Limpia primero a los cultores que lo rodean y entra con la salud y el maná al máximo: hay jugadores de nivel 42-43 que lo han matado solos. Las misiones de {npc:255829} en {area:16726} dependen de esta: si lo saltas, también pierdes {quest:95420}, las misiones de {area:16726} y el campamento de {npc:258570} en el oeste (unos 21.000 PX); la guía las omite entonces.",

	-- Step 48: Clubtoe
	-- {quest:95418} Spread the Word · {npc:256710} Tran'gul · {area:16743} Rog'mar
	["{quest:95418}: for {npc:256710} in {area:16743}"] = "{quest:95418}: para {npc:256710} en {area:16743}",

	-- Step 49: Tran'gul
	-- {area:16743} Rog'mar · {npc:260931} Clubtoe · {npc:256710} Tran'gul · {npc:255829} Clugfist
	["East back to {area:16743}: {npc:260931}'s word goes to {npc:256710}, and {npc:256710}'s to {npc:255829}, the ogres' chieftain."] = "Vuelve al este a {area:16743}: el mensaje de {npc:260931} va para {npc:256710}, y el de {npc:256710} para {npc:255829}, el jefe de los ogros.",
	-- {quest:95420} Land of Giants · {npc:255829} Clugfist · {area:16726} Bolder'ok
	["{quest:95420}: for {npc:255829} in {area:16726}"] = "{quest:95420}: para {npc:255829} en {area:16726}",

	-- Step 50: WANTED: Scoutmaster Vargas
	-- {npc:260211} Scoutmaster Vargas · {npc:256728} Na'zok · {npc:258031} Neza Bloodsnout
	["{npc:260211} is an elite (level 42) at the Alliance scouts' camp in the hills south-east of {npc:256728}, where you go next: grouping up is advised. The poster hangs in the middle of the fort; {npc:258031} takes the eye, later in this guide."] = "{npc:260211} es un élite (nivel 42) en el campamento de exploradores de la Alianza, en las colinas al sureste de {npc:256728}, adonde vas a continuación: se recomienda ir en grupo. El cartel cuelga en el centro del fuerte; {npc:258031} recibe el ojo, más adelante en esta guía.",
	-- {object:707249} Wanted (no name in this language: may be words)
	["the {object:707249} poster"] = "el cartel de {object:707249}",

	-- Step 51: Na'zok's camp
	-- {npc:256728} Na'zok
	["{npc:256728}'s camp"] = "Campamento de {npc:256728}",
	-- {area:16743} Rog'mar · {npc:256728} Na'zok
	["North-east from {area:16743} up into the hills: {npc:256728} watches the Paletusk boars from his camp."] = "Al noreste de {area:16743}, subiendo a las colinas: {npc:256728} vigila a los jabalíes Colmillo Pálido desde su campamento.",

	-- Step 52: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:255829} Clugfist
	["North-west to {area:16726}, the ogres' town. {npc:255829}, its chieftain, sits on the hill. The ogres are friendly while you leave them alone."] = "Ve al noroeste hasta {area:16726}, el pueblo de los ogros. {npc:255829}, su jefe, está sentado en la colina. Los ogros son amistosos mientras no los molestes.",

	-- Step 53: The Twilight ogres' camp
	["The Twilight ogres' camp"] = "El campamento de los ogros Crepusculares",
	-- {npc:256728} Na'zok · {npc:260973} Klunk · {item:269257} Skullbasher · {npc:260211} Scoutmaster Vargas
	-- plural, as words: Twilight Maulers = {npc:260968} Twilight Mauler · Farholde Ambushers = {npc:260023} Farholde Ambusher
	["The Twilight Maulers and Firecallers camp on the ridge east of {npc:256728}. {npc:260973}, who carries the {item:269257}, stands among them. Just south of the ogres, {npc:260211} (an Alliance elite, level 42) and his Farholde Ambushers hold the scouts' camp: keep north of it unless you came with a group for him."] = "Los Machacadores Crepusculares y los Clamafuegos acampan en la loma al este de {npc:256728}. {npc:260973}, que lleva {item:269257}, está entre ellos. Justo al sur de los ogros, {npc:260211} (un élite de la Alianza, nivel 42) y sus Emboscadores de Farholde ocupan el campamento de exploradores: mantente al norte salvo que vengas en grupo a por él.",
	-- {item:269257} Skullbasher · {npc:260973} Klunk
	["{item:269257}, from {npc:260973}"] = "{item:269257}, de {npc:260973}",

	-- Step 55: The paletusks
	["The paletusks"] = "Los Colmillo Pálido",
	-- {npc:256728} Na'zok
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk · Mature Paletusks = {npc:255851} Mature Paletusk
	["South down the hills, round the west side of the Alliance scouts' camp: tap the Young Paletusks with {npc:256728}'s staff to send them home; the Mature Paletusks around the hills drop the boar meat."] = "Baja al sur por las colinas, rodeando por el oeste el campamento de exploradores de la Alianza: toca a los Colmillo Pálido jóvenes con el bastón de {npc:256728} para mandarlos a casa; los Colmillo Pálido adultos de las colinas sueltan la carne de jabalí.",
	-- {item:268521} Swineherd's Staff
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk
	["{item:268521}, on the Young Paletusks"] = "{item:268521}, sobre los Colmillo Pálido jóvenes",
	-- {item:769} Chunk of Boar Meat
	-- plural, as words: Mature Paletusks = {npc:255851} Mature Paletusk
	["{item:769}, from the Mature Paletusks"] = "{item:769}, de los Colmillo Pálido adultos",

	-- Step 57: Jom-jom's Escape
	-- {npc:258048} Jom-jom · {npc:256728} Na'zok · {area:16726} Bolder'ok
	["{npc:258048} waits by the Twilight ogres' camp north-east of {npc:256728}: take him home to {area:16726} and keep the cultists off him. If he falls, take the quest from him again."] = "{npc:258048} espera junto al campamento de los ogros Crepusculares, al noreste de {npc:256728}: llévalo a casa, a {area:16726}, y protégelo de los cultistas. Si muere, vuelve a aceptar la misión de él.",
	-- {npc:258048} Jom-jom
	["{npc:258048}, in the cave"] = "",
	-- {npc:258048} Jom-jom · {area:16726} Bolder'ok
	["help {npc:258048} reach {area:16726}"] = "ayuda a {npc:258048} a llegar a {area:16726}",

	-- Step 58: Bolder'ok
	-- {npc:255829} Clugfist · {npc:257062} Jezap Jinglesprocket · {quest:94668} Bloodmaster's Ring
	["Back to {npc:255829} on his hill. {npc:257062} runs the {quest:94668} just below it."] = "Vuelve con {npc:255829} a su colina. {npc:257062} lleva {quest:94668} justo debajo.",

	-- Step 59: Clugfist
	-- {quest:95428} Clugfist's Decree · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95428}: for {npc:256418} in {area:16743}, later in this guide"] = "{quest:95428}: para {npc:256418} en {area:16743}, más adelante en esta guía",
	-- {quest:94669} Pay to Play
	["{quest:94669}: the Ring's bouts, one-on-one fights with elites (41-45); a deposit first"] = "{quest:94669}: los combates del Anillo, peleas uno contra uno con élites (41-45); antes hay que pagar un depósito",

	-- Step 60: The Bloodmaster's Ring: Buzzbeak
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Buzzbeak"] = "{quest:94670}: Picozumbón",
	-- {npc:255829} Clugfist · {npc:258626} Mog'thar · {npc:257059} Chub'chob · {npc:257062} Jezap Jinglesprocket
	["Each bout is a fight in the ring below {npc:255829}'s hill against an elite: Buzzbeak (41), Kronk and Bonegnaw (42), {npc:258626} (43), Snufflesnout (44) and {npc:257059} (45). Come in rested, with full health and mana; if a bout goes wrong, {npc:257062} offers it again."] = "Cada combate es una pelea en el anillo bajo la colina de {npc:255829} contra un élite: Picozumbón (41), Kronk y Roehuesos (42), {npc:258626} (43), Hocicorresopla (44) y {npc:257059} (45). Ve descansado, con la salud y el maná al máximo; si un combate sale mal, {npc:257062} te lo vuelve a ofrecer.",
	-- {quest:94670} Bloodmaster's Ring
	["{quest:94670}: Buzzbeak"] = "{quest:94670}: Picozumbón",
	["beat Buzzbeak"] = "derrota a Picozumbón",

	-- Step 61: The Bloodmaster's Ring: Kronk and Bonegnaw
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Kronk and Bonegnaw"] = "{quest:94670}: Kronk y Roehuesos",
	["Kronk"] = "Kronk",
	["Bonegnaw"] = "Roehuesos",

	-- Step 62: The Bloodmaster's Ring: Mog'thar
	-- {quest:94962} Bloodmaster's Ring · {npc:258626} Mog'thar
	["The {quest:94962}: {npc:258626}"] = "{quest:94962}: {npc:258626}",

	-- Step 63: The Bloodmaster's Ring: Snufflesnout and Chub'chob
	-- {quest:94964} Bloodmaster's Ring · {npc:257059} Chub'chob
	["The {quest:94964}: Snufflesnout and {npc:257059}"] = "{quest:94964}: Hocicohusmeador y {npc:257059}",
	-- {npc:257062} Jezap Jinglesprocket · {npc:258626} Mog'thar
	["{npc:257062} offers the last two once Gobam's errands are done (players' recordings), which this guide leaves out. They are level 44 and 45: leave them for later if {npc:258626} was a close fight."] = "{npc:257062} ofrece las dos últimas cuando terminas los recados de Gobam (según grabaciones de jugadores), que esta guía omite. Son de nivel 44 y 45: déjalas para más tarde si {npc:258626} fue un combate ajustado.",
	["Snufflesnout (44)"] = "Hocicohusmeador (44)",
	-- {npc:255829} Clugfist
	["{npc:255829}, on the hill"] = "{npc:255829}, en la colina",

	-- Step 64: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz
	["South-east down out of the hills to {area:16727}, the goblins' harbour on the coast. {npc:255897} keeps a stall at the west end of the docks, {npc:259962} cooks by the inn, and {npc:259961} works the north pier."] = "Baja de las colinas hacia el sureste hasta {area:16727}, el puerto de los goblins en la costa. {npc:255897} tiene un puesto en el extremo oeste de los muelles, {npc:259962} cocina junto a la posada y {npc:259961} trabaja en el embarcadero norte.",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "El cartel de {object:628948} junto a la posada: {npc:260235}",

	-- Step 65: Wharfmaster Whizzbuzz
	-- {npc:259961} Wharfmaster Whizzbuzz · {item:277974} Twice Reordered Package
	["{npc:259961} on the north pier takes Lozgil's {item:277974}."] = "{npc:259961}, en el embarcadero norte, recibe el {item:277974} de Lozgil.",

	-- Step 66: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001} es un élite (nivel 42) en la orilla sur: se recomienda ir en grupo.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "El cartel de {object:628948} junto a la posada",

	-- Step 67: The murlocs, south-west
	["The murlocs, south-west"] = "Los múrlocs, al suroeste",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "Ve al suroeste por la orilla desde el puerto: los múrlocs de agua salada acampan en las playas. Por el camino, hay una piel pintada tendida junto al sendero: inicia {quest:95260} para {npc:260231} en los muelles.",

	-- Step 69: Back through the port
	["Back through the port"] = "De vuelta por el puerto",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "Vuelve al norte por la orilla: entrega los múrlocs y la piel en los muelles de camino a los reptadores.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms grow on the ridge west of the pirates"] = "{quest:95261}: las entrañas de las bestias salen sobre la marcha; los champiñones crecen en la cresta al oeste de los piratas",

	-- Step 70: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "{item:268632} sobre la marcha",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42) wanders the shore and {npc:263380} (elite, 42) the river: take your beasts away from them."] = "La mayoría de las bestias de {zone:2548} sueltan {item:268632} para {npc:260231}: los reptadores de la orilla de esta costa y los jabalíes de la cresta al oeste de los piratas.\nCuidado: {npc:257001} (élite, 42) deambula por la orilla y {npc:263380} (élite, 42) por el río: aleja de ellos a tus bestias.",

	-- Step 71: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "Los reptadores y {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962}, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "Hacia el norte por la playa desde los muelles: los reptadores sueltan la carne para {npc:259962} y sus entrañas cuentan para {npc:260231}. {npc:260235}, un cangrejo grande, corretea por las rocas al este de los muelles. {npc:259758}, un élite raro de nivel 49, recorre esta costa desde los muelles hasta el campamento pirata: si lo ves, mantente bien lejos.",

	-- Step 72: The Eastsea pirates
	["The Eastsea pirates"] = "Los piratas de Mareste",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "Ve al noreste por la costa hasta el campamento pirata de los acantilados. Los bucaneros y mosqueteros llevan la mercancía de contrabando. {npc:259758} también recorre el campamento: no lo pierdas de vista.",

	-- Step 73: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "Vuelve al puerto, desde el muelle norte hacia el oeste por los embarcaderos.",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: para {npc:260390}, en el campamento pirata",

	-- Step 75: The pirates' second wave
	["The pirates' second wave"] = "La segunda oleada pirata",
	-- {npc:259758} Gul'gash
	-- plural, as words: Eastsea Raiders = {npc:257915} Eastsea Raider
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, a level or two over you here: pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "Hacia el norte por la costa desde el puerto: los asaltantes y bombarderos de Mareste se han atrincherado en las laderas al oeste del campamento de los bucaneros, entre sus barriles de pólvora. Atento a {npc:259758} en estos acantilados.\nCuidado: los Asaltantes de Mareste son de nivel 44-45, uno o dos niveles por encima de ti aquí: atráelos de uno en uno desde el borde de las laderas y no te acerques al campamento que hay detrás.",

	-- Step 76: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "Ve hacia el este por los acantilados hasta el otro extremo del campamento pirata: {npc:260390} espera junto al agua, con {npc:260391} a su lado.",

	-- Step 77: Powderfuse Port
	["Back to the port."] = "Vuelve al puerto.",
	-- {npc:255897} Friz Frazzlespark · {quest:95296} Shipping and Handling · {npc:260405} Wharfmaster Steamfizzle · {area:977} Steamwheedle Port · {zone:1444} Feralas · {zone:1446} Tanaris
	["{npc:255897}: {quest:95296}, for {npc:260405} at {area:977} in the {zone:1444} & {zone:1446} guide"] = "{npc:255897}: {quest:95296}, para {npc:260405} en {area:977}, en la guía de {zone:1444} y {zone:1446}",

	-- Step 78: The pirates' ships
	["The pirates' ships"] = "Los barcos piratas",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, a level or two over you here: clear the deck around her first and come in with full health."] = "Vuelve una vez más a los acantilados de los piratas. Coloca las cargas de Whizzbuzz en los tres barcos amarrados bajo el campamento, de sur a norte; {quest:95124} está junto al del medio, con su cofre de botín al lado. Atento a {npc:259758} por el camino.\nCuidado: {quest:95124} es de nivel 45, uno o dos niveles por encima de ti aquí: limpia primero la cubierta a su alrededor y llega con la salud al máximo.",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, el barco del sur",
	["the middle ship"] = "el barco del medio",
	["the northern ship"] = "el barco del norte",

	-- Step 79: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "Champiñones putricarne",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "Al oeste del barco del norte, sube la cresta: los Champiñones putricarne crecen entre las rocas, cerca del campamento de los ogros Crepusculares. Los Colmipálidos maduros de la cresta también dan entrañas.",

	-- Step 80: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "Termina las {item:268632}",
	-- {npc:259758} Gul'gash
	["South-east back towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "Vuelve hacia el sureste hacia el puerto: los reptadores de la playa al norte de los muelles son las entrañas más rápidas. {npc:259758} también baja a esta playa.",

	-- Step 81: Powderfuse Port
	["Down to the port."] = "Baja al puerto.",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: una gran bestia en las aguas poco profundas al suroeste del puerto, cerca de {npc:257001}, el élite",

	-- Step 82: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "El {npc:260244} merodea por las aguas poco profundas al suroeste del puerto, bajo las playas de los múrlocs. {npc:257001}, un élite, recorre la orilla cerca: mantén las distancias.",

	-- Step 84: Rog'mar
	-- {area:16743} Rog'mar · {npc:256418} Krom'rosh · {npc:255829} Clugfist · {npc:258570} Da'grosh
	["Back to {area:16743} from the port, where your Hearthstone is set. {npc:256418} in the middle of the fort: {npc:255829}'s word sends him looking for {npc:258570}, his warrior in the west."] = "Vuelve desde el puerto a {area:16743}, donde tienes vinculada la Piedra de hogar. {npc:256418}, en el centro del fuerte: la palabra de {npc:255829} lo lleva a buscar a {npc:258570}, su guerrero en el oeste.",
	-- {quest:94744} The Wayward Warrior · {npc:258570} Da'grosh · {area:16723} Sunnyglade
	["{quest:94744}: for {npc:258570}, west of {area:16723}"] = "{quest:94744}: para {npc:258570}, al oeste de {area:16723}",

	-- Step 86: Da'grosh
	-- {area:16743} Rog'mar · {area:16723} Sunnyglade · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {npc:256418} Krom'rosh
	["West from {area:16743} through {area:16723} and on up the valley towards {area:16685}: {npc:258570}, {npc:256418}'s wayward warrior, keeps a camp in the hills below the Twilight cult's fortress."] = "Hacia el oeste desde {area:16743}, pasando por {area:16723} y subiendo por el valle hacia {area:16685}: {npc:258570}, el guerrero descarriado de {npc:256418}, tiene un campamento en las colinas bajo la fortaleza del culto Crepuscular.",

	-- Step 87: Crag'rog
	-- {npc:260993} Crag'rog · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:260993}, a {area:16726} ogre, hides in the cave west of {npc:258570}'s camp."] = "{npc:260993}, un ogro de {area:16726}, se esconde en la cueva al oeste del campamento de {npc:258570}.",

	-- Step 88: The Twilight camps
	["The Twilight camps"] = "Los campamentos Crepusculares",
	-- {npc:258570} Da'grosh · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg · {npc:258023} Sergeant Riftan
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer · Farholde Lookouts = {npc:258686} Farholde Lookout
	["The cult's camps fill the valley south and west of {npc:258570}. Free the captive Rog'mar Scouts as you find them. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them. {npc:258023}'s Alliance camp sits at the valley's south end, and its Farholde Lookouts (level 46) attack the Horde: stay north of it."] = "Los campamentos del culto llenan el valle al sur y al oeste de {npc:258570}. Libera a los Exploradores Rog'mar cautivos según los encuentres. Los Ejecutores Crepusculares (élites, nivel 45) patrullan los campamentos: fíjate por dónde caminan antes de cada pull. {npc:256881} y {npc:256891} (élites, 46) ocupan la fortaleza en la cabecera del valle: aleja a los cultistas de ellos. El campamento de la Alianza de {npc:258023} está en el extremo sur del valle, y sus Vigías de Farholde (nivel 46) atacan a la Horda: quédate al norte.",
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout
	["free five captive Rog'mar Scouts"] = "libera a cinco Exploradores Rog'mar cautivos",

	-- Step 89: The ogre mine
	["The ogre mine"] = "La mina de los ogros",
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine: talk five of them into rising up against their masters.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in."] = "Al norte de los campamentos, el culto hace trabajar a mineros ogros en una mina: convence a cinco de que se rebelen contra sus amos.\nCuidado: los Ejecutores Crepusculares (élites, nivel 45) pasan por la entrada de la mina en su ronda por los campamentos. Espera a que pase uno antes de entrar.",
	-- plural, as words: Ogre Miners = {npc:260995} Ogre Miner
	["recruit five Ogre Miners"] = "recluta a cinco Mineros ogros",

	-- Step 92: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881} es un élite (nivel 46) en la fortaleza al fondo del valle, rodeado de Ejecutores: se recomienda ir en grupo.",

	-- Step 93: Twilight's Shroud
	-- {area:340} Kargath · {area:3} Badlands · {npc:258570} Da'grosh · {area:16685} Twilight's Shroud
	["The next guide flies from {area:340} in the {area:3}: north out of {npc:258570}'s valley and up through {area:16685}, the way through to the {area:3}."] = "La siguiente guía sale volando desde {area:340}, en {area:3}: ve al norte, fuera del valle de {npc:258570}, y sube por {area:16685}, el paso hacia {area:3}.",

	-- Step 94: Kargath
	-- {area:3} Badlands · {area:340} Kargath
	["Across the {area:3} to {area:340}, the Horde fortress built into the cliffs at the zone's western edge: its flight master stands at the foot of the fortress."] = "Cruza {area:3} hasta {area:340}, la fortaleza de la Horda construida en los acantilados del extremo oeste de la zona: su maestro de vuelo está al pie de la fortaleza.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:263190}'s spears, on the Freshwater Crocolisks"] = "Las lanzas de {npc:263190}, en los Crocoliscos de agua dulce",
}
