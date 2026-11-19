-- Spanish (Spain) (esES): the guide forever/alliance/40-50/01b-riverglades (forever/alliance/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16724} Farholde Keep
	["About 90 quests in Forever's new zone, from {area:16724}: the level for its port and Western Front."] = "Unas 90 misiones en la nueva zona de Forever, desde {area:16724}: el nivel de su puerto y del Frente Occidental.",

	-- Step 1: Ironforge flight master
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",
	-- {zone:1426} Dun Morogh · {zone:1455} Ironforge · {area:69} Lakeshire
	["The Stranglethorn guide leaves Dwarves and Gnomes at their riding trainer in {zone:1426}: ride back west into {zone:1455}, where the flight to {area:69} leaves from the gryphon master."] = "La guía de Tuercespina deja a Enanos y Gnomos con su instructor de equitación en {zone:1426}: vuelve al oeste hasta {zone:1455}, donde el maestro de grifos tiene el vuelo a {area:69}.",

	-- Step 2: Into the Riverglades
	-- {zone:2548} Riverglades
	["Into the {zone:2548}"] = "Hacia {zone:2548}",
	-- {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass · {zone:2548} Riverglades · {area:16737} Bristle Hills
	["Fly from {zone:1455} to {area:69} in Redridge, then follow the road north out of town and up through {area:2417}: it comes down into the western {zone:2548} by the {area:16737}."] = "Vuela de {zone:1455} a {area:69}, en Crestagrana, y sigue el camino al norte saliendo del pueblo y subiendo por {area:2417}: baja al oeste de {zone:2548} junto a {area:16737}.",
	-- {zone:2548} Riverglades
	["The western {zone:2548}"] = "El oeste de {zone:2548}",

	-- Step 3: Scout Bolain
	-- {npc:260026} Scout Bolain
	["{npc:260026} waits beside the road east of the pass."] = "{npc:260026} espera junto al camino, al este del paso.",

	-- Step 4: Southern Watch
	-- {area:16744} Southern Watch
	["Follow the road east to {area:16744}, the Alliance outpost above the river. The gnolls you passed on the way in are Captain Dalton's job: you go back for them after the lumber camp."] = "Sigue el camino al este hasta {area:16744}, el puesto de la Alianza sobre el río. Los gnolls que has pasado al entrar son tarea del capitán Dalton: vuelves a por ellos después del campamento maderero.",
	-- {quest:95148} Southern Watch Gnoll Report · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95148}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95148}: para {npc:257558}, en {area:16724}; guárdalo",

	-- Step 5: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906} es un gnoll élite (nivel 40) que recorre los campamentos del suroeste de {area:16737}: se recomienda ir en grupo.",

	-- Step 6: Turner's Logging Camp
	-- {npc:256438} Halligan Turner
	["North up the road to the lumber camp. {npc:256438} runs it; his third job, the saplings, comes once his plant food is in."] = "Al norte por el camino hasta el campamento maderero. Lo dirige {npc:256438}; su tercer encargo, los plantones, llega cuando le entregues el abono.",

	-- Step 7: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp on the slopes all the way from the hills west of the lumber camp to the pass you came in by. The stolen saw blades lie only in the western camps, near the pass.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "Al oeste, en {area:16737}: los gnolls de Crestagrana acampan en las laderas desde las colinas al oeste del campamento maderero hasta el paso por el que has entrado. Las hojas de sierra robadas solo están en los campamentos del oeste, cerca del paso.\nCuidado: {npc:255906}, un gnoll élite (nivel 40), recorre los campamentos del suroeste: aleja de él a los gnolls antes de luchar.",

	-- Step 9: Southern Watch
	-- {area:16744} Southern Watch
	["Back east along the road to {area:16744}."] = "Vuelve al este por el camino hasta {area:16744}.",

	-- Step 11: Gelinda Coppergleam
	-- {area:16744} Southern Watch · {npc:262399} Gelinda Coppergleam
	["South-west past {area:16744}: {npc:262399}, a prospector, has camped by the Cinderscale dragonkin's hollow."] = "Al suroeste, pasado {area:16744}: {npc:262399}, una prospectora, ha acampado junto a la hondonada de los dracónidos Escamaceniza.",

	-- Step 12: The Cinderscale hollow
	["The Cinderscale hollow"] = "La hondonada Escamaceniza",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors (level 41-42) guard its back, by the {item:271611}. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "Las crías anidan por toda la hondonada; los guerreros (nivel 41-42) guardan el fondo, junto a la {item:271611}. Escaldarón, un draco élite raro, también puede estar aquí: déjalo en paz salvo que vayas en grupo.",

	-- Step 14: Holmsby farm
	["Holmsby farm"] = "La granja de los Holmsby",
	-- {area:16744} Southern Watch
	["Back past {area:16744} and south to the Holmsbys' farm by the river."] = "Vuelve pasando {area:16744} y ve al sur hasta la granja de los Holmsby, junto al río.",

	-- Step 15: Benjy Wheeler
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner
	["North-east across the fields to {area:16725}: {npc:258317} wants the Mudfin murlocs on the river thinned out, the same murlocs whose heads {npc:256438} needs, so one pass along the river does both."] = "Al noreste a través de los campos hasta {area:16725}: {npc:258317} quiere que diezmes a los múrlocs Aletafango del río, los mismos cuyas cabezas necesita {npc:256438}, así que una pasada por el río sirve para ambas.",

	-- Step 16: Meadowsbrook and the river
	-- {area:16735} Meadowsbrook
	["{area:16735} and the river"] = "{area:16735} y el río",
	-- {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner · {npc:258588} Jumbo Crawfish · {npc:258935} Curly · {npc:259049} Robbie Holmsby · {area:16735} Meadowsbrook · {npc:263380} Ghostmaw
	-- plural, as words: Mudfin Warriors = {npc:258574} Mudfin Warrior
	["Back south-west along the river: kill the Mudfin Warriors and Oracles on the banks for {npc:258317} (they drop {npc:256438}'s heads) and the {npc:258588} in the shallows for the shells. {npc:258935}, one of {npc:256438}'s lumberjacks, is stuck on the bank just north-west of the murlocs; {npc:259049}'s hat lies on the riverbank among them; the fresh manure is in the fields of {area:16735}, between the river and the farm. {npc:263380}, an elite (level 42), prowls the river: if he comes your way, back off and let him pass."] = "Vuelve al suroeste por el río: mata a los Guerreros y Oráculos Aletafango de las orillas para {npc:258317} (sueltan las cabezas de {npc:256438}) y a los {npc:258588} de los bajíos para las conchas. {npc:258935}, uno de los leñadores de {npc:256438}, está atrapado en la orilla justo al noroeste de los múrlocs; el sombrero de {npc:259049} está en la ribera entre ellos; el estiércol fresco está en los campos de {area:16735}, entre el río y la granja. {npc:263380}, un élite (nivel 42), ronda el río: si viene hacia ti, retírate y déjalo pasar.",

	-- Step 18: Watcher Fredericks
	-- {npc:259051} Watcher Fredericks · {area:16744} Southern Watch
	["{npc:259051} keeps the west end of {area:16744}."] = "{npc:259051} vigila el extremo oeste de {area:16744}.",

	-- Step 19: Turner's Logging Camp
	["North up the road to the lumber camp."] = "Al norte por el camino hasta el campamento maderero.",

	-- Step 20: Saplings
	["Saplings"] = "Retoños",
	-- {npc:256438} Halligan Turner · {item:266161} Tree Sprouting Kit
	["Use {npc:256438}'s {item:266161} on bare ground around the camp: five saplings."] = "Usa el {item:266161} de {npc:256438} en suelo despejado alrededor del campamento: cinco retoños.",

	-- Step 21: Hurley
	-- {npc:258963} Hurley · {npc:258935} Curly · {quest:94861} Helping Hands · {npc:263380} Ghostmaw
	["{npc:258963} stands at the camp's south end. He sets off for {npc:258935}, south-east of the camp, as soon as you take {quest:94861}: go with him and keep the attackers off, and wait if {npc:263380} is in sight. If it fails, {npc:258963} offers the quest again."] = "{npc:258963} está en el extremo sur del campamento. Sale a buscar a {npc:258935}, al sureste del campamento, en cuanto aceptas {quest:94861}: acompáñalo y mantén a raya a los atacantes, y espera si {npc:263380} está a la vista. Si fracasa, {npc:258963} vuelve a ofrecer la misión.",
	-- {npc:258963} Hurley · {npc:258935} Curly
	["go with {npc:258963} to save {npc:258935}"] = "acompaña a {npc:258963} para salvar a {npc:258935}",

	-- Step 23: Wheeler's Grange
	-- {area:16724} Farholde Keep · {npc:258317} Benjy Wheeler · {area:16725} Wheeler's Grange
	["East along the road towards {area:16724}: hand {npc:258317} his murlocs as you pass {area:16725}."] = "Al este por el camino hacia {area:16724}: entrégale a {npc:258317} sus múrlocs al pasar por {area:16725}.",

	-- Step 24: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257087} Gretchen Mayberry · {npc:260070} Bertrand Ironbrow · {npc:260080} Ember Bladewhisper · {npc:263613} Brother Lowley · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["On east along the road to {area:16724}. {npc:257087}, the gryphon master, stands at its western gate; {npc:260070} and {npc:260080} are on the way in, {npc:263613} tends the wounded by the barracks, {npc:257558} and {npc:257591} wait in the keep at the east end, and the inn is in the south of the walls."] = "Sigue al este por el camino hasta {area:16724}. {npc:257087}, la maestra de grifos, está en su puerta oeste; {npc:260070} y {npc:260080} están de camino al entrar, {npc:263613} atiende a los heridos junto al cuartel, {npc:257558} y {npc:257591} esperan en la fortaleza del extremo este, y la posada está en el sur del recinto.",
	-- {npc:257087} Gretchen Mayberry
	["{npc:257087}, at the western gate"] = "{npc:257087}, en la puerta oeste",
	-- {npc:257558} Demar Brant
	["{npc:257558}, in the keep"] = "{npc:257558}, en la fortaleza",
	-- {quest:94877} Saving Sunnyglade
	["{quest:94877}: for later in this guide"] = "{quest:94877}: para más adelante en esta guía",
	-- {npc:257591} Ashe Amberhall · {quest:94881} Curious Trinkets
	["{npc:257591}: {quest:94881}, for later in this guide"] = "{npc:257591}: {quest:94881}, para más adelante en esta guía",
	-- {quest:94879} Scraps of Knowledge
	["{quest:94879}, for later in this guide"] = "{quest:94879}, para más adelante en esta guía",
	-- {npc:259863} Cassandra Wheeler · {quest:95330} Love Thy Neighbor · {area:16736} Turner's Logging Camp
	["{npc:259863}, by the inn: {quest:95330}, for {area:16736} later in this guide"] = "{npc:259863}, junto a la posada: {quest:95330}, para {area:16736} más adelante en esta guía",
	-- {npc:257595} Barracks Master Harlan
	["{npc:257595}, at the inn"] = "{npc:257595}, en la posada",

	-- Step 25: The cathedral
	["The cathedral"] = "La catedral",
	-- {npc:262031} Sister Rowland · {area:16724} Farholde Keep · {npc:272437} Marla Bell · {npc:271742} Abbot Schuncke
	["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} sells the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} cuida la vieja catedral en la esquina suroeste de {area:16724}. Los murciélagos anidan en su piso superior; {npc:272437} vende las velas sagradas a su lado; las tumbas están en el cementerio de la capilla.\n{npc:271742}, un élite de nivel 53, está en la catedral: no te ataca, así que nunca lo ataques y aleja a los murciélagos de él.",
	-- {item:17028} Holy Candle · {npc:272437} Marla Bell
	["{item:17028}, from {npc:272437}"] = "{item:17028}, de {npc:272437}",
	-- {item:269997} Bundle of Candles
	["{item:269997}, on the graves"] = "{item:269997}, en las tumbas",

	-- Step 26: Wheeler's Grange
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler
	["West to {area:16725}: {npc:258317} stands by the farmhouse."] = "Al oeste, a {area:16725}: {npc:258317} está junto a la granja.",

	-- Step 27: The stables
	["The stables"] = "Los establos",
	["Search around the stables south of the farmhouse for the horses' tracks; the bundles of hay lie around the farm."] = "Busca las huellas de los caballos alrededor de los establos al sur de la granja; los fardos de heno están por la granja.",

	-- Step 29: The coyote den
	["The coyote den"] = "La guarida de coyotes",
	-- {npc:258522} Sootfur
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The coyotes den in the hills south of the farm: {npc:258522}, the big dark one, sits at the back of it; the Plains Coyotes around it drop the pelts."] = "Los coyotes tienen su guarida en las colinas al sur de la granja: {npc:258522}, el grande y oscuro, está al fondo; los coyotes de las llanuras de alrededor sueltan las pieles.",

	-- Step 30: The lost horse
	["The lost horse"] = "El caballo perdido",
	["One of Benjy's horses ran north up the river, past the farm. Give it the feed, then lead it home."] = "Uno de los caballos de Benjy huyó al norte remontando el río, pasada la granja. Dale el pienso y luego llévalo a casa.",
	-- {area:16725} Wheeler's Grange
	["walk it back to {area:16725}"] = "llévalo andando de vuelta a {area:16725}",

	-- Step 32: Foreman's Crate
	-- {area:16729} Terral's Watch
	["North up the track towards {area:16729}: the foreman's crate lies by the road."] = "Al norte por el camino hacia {area:16729}: la caja del capataz está junto al camino.",

	-- Step 33: Terral's Watch
	-- {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{npc:259352} holds {area:16729}, the tower on the plains north-east of the crate."] = "{npc:259352} defiende {area:16729}, la torre en las llanuras al noreste de la caja.",

	-- Step 34: The plains
	["The plains"] = "Las llanuras",
	-- {quest:95983} A Feast for Buzzards · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Poachers = {npc:259052} Rog'mar Poacher
	["The Rog'mar Poachers hunt the plains north of the tower; the Wildplains lions roam among them. A picked carcass lies in the grass east of the tower: its skull starts {quest:95983}.\nCareful: {npc:263380}, an elite (level 42), hunts along the river west of the plains: keep an eye on the riverbank."] = "Los cazadores furtivos Rog'mar cazan en las llanuras al norte de la torre; los leones de Llanura Salvaje deambulan entre ellos. Un cadáver descarnado yace en la hierba al este de la torre: su cráneo inicia {quest:95983}.\nCuidado: {npc:263380}, un élite (nivel 42), caza a lo largo del río al oeste de las llanuras: vigila la orilla.",

	-- Step 35: Terral's Watch
	-- {quest:94928} A Few Furs for Friz · {area:16727} Powderfuse Port
	["{quest:94928}: for {area:16727}, keep it"] = "{quest:94928}: para {area:16727}, guárdala",
	-- {quest:95984} Song of the Strider · {npc:263367} Sleebo Fizzlespout
	["{quest:95984}: for later, where the tallstriders graze by {npc:263367}'s workshop; keep it"] = "{quest:95984}: para más adelante, donde pastan las zancaaltas junto al taller de {npc:263367}; guárdala",
	-- {quest:95064} Preventative Measures · {area:16743} Rog'mar
	["{quest:95064}: for later, at the Horde's training grounds north of {area:16743}"] = "{quest:95064}: para más adelante, en el campo de entrenamiento de la Horda al norte de {area:16743}",
	-- {quest:96125} In Need of Relief · {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["{quest:96125}: for {npc:259057} in {area:16726}, keep it"] = "{quest:96125}: para {npc:259057} en {area:16726}, guárdala",
	-- {quest:95426} Rog'mar Supplies
	["{quest:95426}: for later, the same training grounds"] = "{quest:95426}: para más adelante, en el mismo campo de entrenamiento",

	-- Step 36: Farholde Keep
	-- {area:16724} Farholde Keep
	["South back to {area:16724}."] = "Vuelve al sur, a {area:16724}.",
	-- {quest:96009} High Stakes · {area:16736} Turner's Logging Camp
	["{quest:96009}: for {area:16736} later in this guide"] = "{quest:96009}: para {area:16736}, más adelante en esta guía",

	-- Step 37: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch · {npc:259859} Wheatley
	["{npc:263380} is an elite (level 42) who hunts along the river between {area:16725} and {area:16729}, on your way north later in this guide: grouping up is advised. The poster hangs by the keep; {npc:259859}, who takes the fang, stands south of the inn."] = "{npc:263380} es un élite (nivel 42) que caza a lo largo del río entre {area:16725} y {area:16729}, de camino al norte más adelante en esta guía: se recomienda ir en grupo. El cartel cuelga junto a la fortaleza; {npc:259859}, que recibe el colmillo, está al sur de la posada.",
	-- {object:645166} WANTED! (no name in this language: may be words)
	["the {object:645166} poster"] = "el cartel de {object:645166}",

	-- Step 38: WANTED: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo · {area:16743} Rog'mar
	["{npc:263071} is an elite (level 42) at the Horde's training grounds north of {area:16743}, where this guide goes later: grouping up is advised."] = "{npc:263071} es un élite (nivel 42) en el campo de entrenamiento de la Horda al norte de {area:16743}, adonde va esta guía más adelante: se recomienda ir en grupo.",
	-- {object:707245} Wanted (no name in this language: may be words)
	["the {object:707245} poster"] = "el cartel de {object:707245}",

	-- Step 39: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch
	["{npc:263380}, the elite, hunts along the river between {area:16725} and {area:16729}, on your way north."] = "{npc:263380}, el élite, caza a lo largo del río entre {area:16725} y {area:16729}, de camino al norte.",

	-- Step 40: Sunnyglade
	-- {area:16724} Farholde Keep · {area:16729} Terral's Watch · {area:16723} Sunnyglade · {area:16743} Rog'mar · {npc:259158} Fuzzle · {npc:256831} Apprentice Claire · {npc:258697} Farmer Elbrim
	["North from {area:16724}, past {area:16729} and across the river, to {area:16723}, the farm town the Twilight cult holds; keep clear of {area:16743}, the Horde's fort east of the town. {npc:259158} the kobold hides in the middle of the town, {npc:256831} at its eastern edge, and {npc:258697} waits at his farm on the north-eastern edge."] = "Ve al norte desde {area:16724}, pasa {area:16729} y cruza el río hasta {area:16723}, el pueblo agrícola que ocupa el culto Crepuscular; mantente lejos de {area:16743}, el fuerte de la Horda al este del pueblo. {npc:259158}, el kóbold, se esconde en el centro del pueblo, {npc:256831} en su borde este y {npc:258697} espera en su granja, en el borde noreste.",

	-- Step 41: The Twilight cult
	["The Twilight cult"] = "El culto Crepuscular",
	-- {area:16723} Sunnyglade · {item:266148} Farmers' Mementos · {item:4338} Mageweave Cloth · {npc:263613} Brother Lowley · {area:16724} Farholde Keep · {quest:94885} Field Marshal's Log · {npc:256899} Chogg'Zac · {npc:263380} Ghostmaw
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["The cultists fill the streets and fields of {area:16723}. Start at the ritual circles in the middle (fill Claire's catalyst there), work west through the burnt houses to the edge of town, then back north-east to the loose soil west of Elbrim's farm: bury the {item:266148} the Twilight Raiders drop there. The charms, pages and finger bones drop from the cultists.\nKeep the {item:4338} they drop: {npc:263613} in {area:16724} asks for twenty when you are back there. Now and then a cultist drops the {quest:94885}: right-click it to start the quest.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass; players died here more than anywhere else in the zone.\n{npc:263380}, the river's elite (level 42), can wander up from the south-western fields: let him pass."] = "Los cultistas llenan las calles y campos de {area:16723}. Empieza por los círculos rituales del centro (llena allí el catalizador de Claire), avanza al oeste por las casas quemadas hasta el borde del pueblo y vuelve al noreste, a la tierra suelta al oeste de la granja de Elbrim: entierra allí los {item:266148} que sueltan los Asaltantes Crepusculares. Los amuletos, páginas y huesos de dedo los sueltan los cultistas.\nGuarda la {item:4338} que sueltan: {npc:263613}, en {area:16724}, te pide veinte cuando vuelvas. De vez en cuando un cultista suelta el {quest:94885}: haz clic derecho para empezar la misión.\nCuidado: {npc:256899}, un ogro élite (nivel 41), recorre las calles del oeste de {area:16723}, hacia 44-47,47-52. Atrae a los cultistas hacia ti y déjalo pasar; aquí han muerto más jugadores que en ningún otro sitio de la zona.\n{npc:263380}, el élite del río (nivel 42), puede subir desde los campos del suroeste: déjalo pasar.",
	-- {item:269990} Crystal Catalyst
	["fill the {item:269990} at the ritual circles"] = "llena el {item:269990} en los círculos rituales",
	-- {object:621813} Loose Soil (no name in this language: may be words) · {item:266148} Farmers' Mementos
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["{object:621813}, west of Elbrim's farm: each grave takes one of the {item:266148} the Twilight Raiders drop, so loot five first"] = "",
	-- {quest:94885} Field Marshal's Log
	["{quest:94885}: only if a cultist dropped the log"] = "{quest:94885}: solo si un cultista soltó el diario",

	-- Step 43: Cut Off the Heads
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{npc:256899}, the two-headed ogre, is an elite (level 41) at the western edge of {area:16723}: grouping up is advised. Claire then has the filled catalyst for {npc:257591} in {area:16724}."] = "{npc:256899}, el ogro de dos cabezas, es un élite (nivel 41) en el borde oeste de {area:16723}: se recomienda ir en grupo. Después Claire te da el catalizador lleno para {npc:257591} en {area:16724}.",
	-- {quest:94884} An Unsettling Discovery · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{quest:94884}: for {npc:257591} in {area:16724}"] = "{quest:94884}: para {npc:257591} en {area:16724}",

	-- Step 44: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158} quiere salir de {area:16723}: llévalo al oeste hasta su tesoro, en el borde del pueblo, y mantén a los cultistas lejos de él.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "guía a {npc:259158} fuera de {area:16723} hasta su tesoro, al oeste del pueblo",

	-- Step 45: Farmer Elbrim
	["Back east through the town to Elbrim's farm: the doll and the locket are in the burnt farmhouse beside it."] = "Vuelve al este por el pueblo hasta la granja de Elbrim: la muñeca y el guardapelo están en la casa quemada que hay a su lado.",

	-- Step 46: The Rog'mar training grounds
	-- {area:16743} Rog'mar
	["The {area:16743} training grounds"] = "Los campos de entrenamiento de {area:16743}",
	-- {area:16743} Rog'mar · {npc:263071} Blademaster Kaijo · {npc:263615} Krek the Noxious
	-- plural, as words: Rog'mar Grunts = {npc:255996} Rog'mar Grunt
	["North-east of Elbrim's farm, the Horde drills its trainees in the fields north of {area:16743}. Stay north of the fort: its guards are far above your level. The supply crates lie around the drill grounds. Three elites work this ground: {npc:263071} (42) walks among the trainees, {npc:263615} (42) lurks at the north end, and Komuk (45), a Horde elite, patrols the hills to the east; give each of them room.\nCareful: Rog'mar Grunts (55) guard the fort's north wall, around 59,39 to 61,41. Leave the crates and trainees by the wall and take the ones further north, around 57-61,34-37."] = "Al noreste de la granja de Elbrim, la Horda entrena a sus reclutas en los campos al norte de {area:16743}. Mantente al norte del fuerte: sus guardias tienen un nivel muy superior al tuyo. Las cajas de suministros están por los campos de entrenamiento. Tres élites rondan la zona: {npc:263071} (42) camina entre los reclutas, {npc:263615} (42) acecha en el extremo norte y Komuk (45), un élite de la Horda, patrulla las colinas del este; mantén las distancias con todos ellos.\nCuidado: los Brutos de Rog'mar (55) vigilan la muralla norte del fuerte, sobre 59,39 a 61,41. Deja las cajas y los reclutas junto a la muralla y ve a por los que están más al norte, sobre 57-61,34-37.",

	-- Step 47: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo
	["{npc:263071}, the elite, walks the training grounds."] = "{npc:263071}, el élite, recorre los campos de entrenamiento.",

	-- Step 48: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "Taller de {npc:263367}",
	-- {area:16743} Rog'mar · {npc:263367} Sleebo Fizzlespout · {area:16726} Bolder'ok
	["South-east, round {area:16743}'s east side, to {npc:263367}'s workshop on the hill. Komuk and the {area:16726} ogres walk the road east of the fort: let them pass before you cross it."] = "Ve al sureste, rodeando {area:16743} por el este, hasta el taller de {npc:263367} en la colina. Komuk y los ogros de {area:16726} recorren el camino al este del fuerte: déjalos pasar antes de cruzarlo.",

	-- Step 49: The tallstriders and the marsh
	["The tallstriders and the marsh"] = "Las zancaaltas y el pantano",
	-- plural, as words: Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Roving Tallstriders graze the meadows south-west of the workshop; further south-west the marsh bubbles with gas: fill the vials at the vents."] = "Las Zancaaltas errantes pastan en los prados al suroeste del taller; más al suroeste, el pantano burbujea de gas: llena los viales en las fumarolas.",

	-- Step 50: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower stands just south-west of the marsh."] = "La torre de {npc:259352} está justo al suroeste del pantano.",
	-- {quest:95066} The Rog'mar Situation · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95066}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95066}: para {npc:257558} en {area:16724}, guárdala",

	-- Step 51: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257591} Ashe Amberhall · {npc:257558} Demar Brant · {area:16723} Sunnyglade · {npc:263089} Tessa Dawnbright · {npc:263613} Brother Lowley
	["South across the plains to {area:16724}: {npc:257591} and {npc:257558} stand together in the keep at the east end, {npc:257591} first, her news is what Brant's next orders wait on. With {area:16723} saved, {npc:263089} by the orchard and {npc:263613} by the barracks have work for you too."] = "Ve al sur por las llanuras hasta {area:16724}: {npc:257591} y {npc:257558} están juntos en el torreón del extremo este; habla primero con {npc:257591}, pues las siguientes órdenes de Brant dependen de sus noticias. Con {area:16723} a salvo, {npc:263089}, junto al huerto, y {npc:263613}, junto a los barracones, también tienen trabajo para ti.",
	-- {quest:94907} A Small Favor
	["{quest:94907}: for later in this guide"] = "{quest:94907}: para más adelante en esta guía",
	-- {quest:95329} Out in the Field · {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{quest:95329}: for {npc:259352} at {area:16729}, keep it"] = "{quest:95329}: para {npc:259352} en {area:16729}, guárdala",
	-- {quest:94886} The Western Front
	["{quest:94886}: for later in this guide"] = "{quest:94886}: para más adelante en esta guía",
	-- {npc:263613} Brother Lowley · {item:4338} Mageweave Cloth · {area:16723} Sunnyglade
	["{npc:263613}: twenty {item:4338}, from {area:16723}'s cultists and the pirates; hand it in when you are back"] = "{npc:263613}: veinte de {item:4338}, de los cultistas y los piratas de {area:16723}; entrégala cuando vuelvas",

	-- Step 52: Tessa Dawnbright
	-- {npc:263089} Tessa Dawnbright
	["{npc:263089} stands west of the inn, by the orchard: the apples hang on the trees around it."] = "{npc:263089} está al oeste de la posada, junto al huerto: las manzanas cuelgan de los árboles de alrededor.",

	-- Step 53: Coyote pelts
	["Coyote pelts"] = "Pieles de coyote",
	-- {area:16725} Wheeler's Grange
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The Plains Coyotes roam west and south-west of the keep, towards {area:16725}."] = "Los Coyotes de las llanuras merodean al oeste y suroeste del torreón, hacia {area:16725}.",

	-- Step 54: Tessa Dawnbright
	-- {quest:95961} Stepped Out · {npc:263120} Gray Dawnbright · {area:16727} Powderfuse Port
	["{quest:95961}: for {npc:263120} in {area:16727}, keep it"] = "{quest:95961}: para {npc:263120} en {area:16727}, guárdala",

	-- Step 55: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16729} Terral's Watch
	["{npc:263315}, an elite lion (level 41), prowls the plains north of {area:16729}, on your way back north: grouping up is advised."] = "{npc:263315}, un león élite (nivel 41), merodea por las llanuras al norte de {area:16729}, de camino de vuelta al norte: se recomienda ir en grupo.",

	-- Step 57: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to {npc:263367}'s workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "Ve al noreste hasta el taller de {npc:263367}. La prueba de resistencia de {npc:263367} es un combate contra su G45-B4G junto al taller: entrega la misión cuando lo derrotes.",
	["the stress test: beat G45-B4G beside the workshop"] = "la prueba de resistencia: derrota a G45-B4G junto al taller",

	-- Step 58: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:263120} Gray Dawnbright · {npc:255894} Innkeeper Zizplink · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz · {npc:260487} Gritta Chumwater · {npc:260565} Kor'gar · {npc:260560} Krikshank
	["East down the road to {area:16727}, the goblins' harbour. {npc:255897} keeps a stall at the west end of the docks; {npc:263120}, {npc:255894} and {npc:259962} are at the inn, and {npc:259961} works the north pier. Zizplink's drink needs three things the port's traders sell: the chum from {npc:260487}, the degreaser and the old poison from {npc:260565} and {npc:260560}, by {npc:255897}'s stall."] = "Ve al este por el camino hasta {area:16727}, el puerto de los goblins. {npc:255897} tiene un puesto en el extremo oeste de los muelles; {npc:263120}, {npc:255894} y {npc:259962} están en la posada, y {npc:259961} trabaja en el muelle norte. La bebida de Zizplink necesita tres cosas que venden los comerciantes del puerto: la carnaza de {npc:260487}, y el desengrasante y el veneno viejo de {npc:260565} y {npc:260560}, junto al puesto de {npc:255897}.",
	-- {quest:95059} Frazzlespark's Crate · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95059}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95059}: para {npc:257558} en {area:16724}, guárdala",
	-- {item:271657} Fresh Chum · {npc:260487} Gritta Chumwater
	["{item:271657}, from {npc:260487}"] = "{item:271657}, de {npc:260487}",
	-- {item:271653} Goblin Degreaser · {npc:260565} Kor'gar
	["{item:271653}, from {npc:260565}"] = "{item:271653}, de {npc:260565}",
	-- {item:271654} Expired Poison · {npc:260560} Krikshank
	["{item:271654}, from {npc:260560}"] = "{item:271654}, de {npc:260560}",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "El cartel de {object:628948} junto a la posada: {npc:260235}",

	-- Step 59: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001} es un élite (nivel 42) en la orilla sur: se recomienda ir en grupo.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "El cartel de {object:628948} junto a la posada",

	-- Step 60: The murlocs, south-west
	["The murlocs, south-west"] = "Los múrlocs, al suroeste",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "Ve al suroeste por la orilla desde el puerto: los múrlocs de agua salada acampan en las playas. Por el camino, hay una piel pintada tendida junto al sendero: inicia {quest:95260} para {npc:260231} en los muelles.",

	-- Step 62: Back through the port
	["Back through the port"] = "De vuelta por el puerto",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "Vuelve al norte por la orilla: entrega los múrlocs y la piel en los muelles de camino a los reptadores.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms are for later"] = "{quest:95261}: las entrañas de las bestias caen sobre la marcha; las setas son para más adelante",

	-- Step 63: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "Los reptadores y {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962} and the spittle for Zizplink, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "Ve al norte por la playa desde los muelles: los reptadores sueltan la carne para {npc:259962} y la saliva para Zizplink, y sus entrañas cuentan para {npc:260231}. {npc:260235}, un cangrejo grande, corretea por las rocas al este de los muelles. {npc:259758}, un élite raro de nivel 49, ronda esta costa desde los muelles hasta el campamento pirata: si lo ves, mantente bien lejos.",

	-- Step 64: The Eastsea pirates
	["The Eastsea pirates"] = "Los piratas de Mareste",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "Ve al noreste por la costa hasta el campamento pirata de los acantilados. Los bucaneros y mosqueteros llevan la mercancía de contrabando. {npc:259758} también recorre el campamento: no lo pierdas de vista.",

	-- Step 65: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "Vuelve al puerto, desde el muelle norte hacia el oeste por los embarcaderos.",
	-- {quest:95122} Unchecked Expansion
	["{quest:95122}: for later in this guide"] = "{quest:95122}: para más adelante en esta guía",
	-- {quest:95123} A Blast Ye Scurvy Dogs!
	["{quest:95123}: for later in this guide"] = "{quest:95123}: para más adelante en esta guía",
	-- {quest:95975} Her World
	["{quest:95975}: for later, the wildflowers west of the port"] = "{quest:95975}: para más adelante, las flores silvestres al oeste del puerto",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: para {npc:260390}, en el campamento pirata",

	-- Step 67: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "{item:268632} sobre la marcha",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42), Komuk (a Horde elite, 45) and {npc:263380} (elite, 42) range over the zone's wilds: take your beasts away from them."] = "La mayoría de las bestias de {zone:2548} sueltan {item:268632} para {npc:260231}: los reptadores de la orilla de esta costa y los jabalíes de la loma al oeste de los piratas.\nCuidado: {npc:257001} (élite, 42), Komuk (un élite de la Horda, 45) y {npc:263380} (élite, 42) recorren las zonas salvajes: aleja a tus bestias de ellos.",

	-- Step 68: Level 44.4 on the Eastsea pirates
	["Level 44.4 on the Eastsea pirates"] = "Sube al nivel 44.4 con los piratas de Mareste",
	-- {npc:259758} Gul'gash · {area:1517} Uldaman
	["Before the second wave: its raiders and bombardiers (43-45) and the pirates' ships after them are a level over you below 44.4. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "Antes de la segunda oleada: sus asaltantes y bombarderos (43-45) y los barcos piratas que vienen después te superan en un nivel si estás por debajo de 44.4. Termina de subir con los bucaneros y mosqueteros del primer campamento (41-43), en su extremo suroeste, lejos del puerto. {npc:259758}, un élite raro de nivel 49, ronda estos acantilados: si lo ves, mantente bien lejos. O, en grupo, haz la mazmorra de {area:1517}.",
	-- {npc:257901} Eastsea Buccaneer
	["grind on {npc:257901}"] = "farmea {npc:257901}",

	-- Step 69: The pirates' second wave
	["The pirates' second wave"] = "La segunda oleada pirata",
	-- {npc:259758} Gul'gash
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. They stand close together: pull them one at a time. {npc:259758}, a rare elite of level 49, roams these cliffs and the beach below: if you see him, keep well away."] = "Hacia el norte por la costa desde el puerto: los asaltantes y bombarderos de Mareste se han atrincherado en las laderas al oeste del campamento de los bucaneros, entre sus barriles de pólvora. Están muy juntos: atráelos de uno en uno. {npc:259758}, un raro élite de nivel 49, ronda estos acantilados y la playa de abajo: si lo ves, mantente bien lejos.",

	-- Step 70: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "Ve hacia el este por los acantilados hasta el otro extremo del campamento pirata: {npc:260390} espera junto al agua, con {npc:260391} a su lado.",

	-- Step 71: Powderfuse Port
	["Back to the port."] = "Vuelve al puerto.",

	-- Step 72: The pirates' ships
	["The pirates' ships"] = "Los barcos piratas",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} (level 45) stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way."] = "Vuelve una vez más a los acantilados de los piratas. Coloca las cargas de Whizzbuzz en los tres barcos amarrados bajo el campamento, de sur a norte; {quest:95124} (nivel 45) está junto al del medio, con su cofre de botín al lado. Vigila a {npc:259758} por el camino.",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, el barco del sur",
	["the middle ship"] = "el barco del medio",
	["the northern ship"] = "el barco del norte",

	-- Step 73: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "Champiñones putricarne",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "Al oeste del barco del norte, sube la cresta: los Champiñones putricarne crecen entre las rocas, cerca del campamento de los ogros Crepusculares. Los Colmipálidos maduros de la cresta también dan entrañas.",

	-- Step 74: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:259057} Dunston Willis
	["North-west to {area:16726}, the ogres' town. Its ogres side with the Horde and attack you on sight, and Clugfist on his hill in the middle is an elite (level 50): keep to the town's north-eastern edge, where {npc:259057} hides."] = "Ve al noroeste hasta {area:16726}, el pueblo de los ogros. Sus ogros están del lado de la Horda y te atacan nada más verte, y Clugfist, en su colina del centro, es élite (nivel 50): no te alejes del borde noreste del pueblo, donde se esconde {npc:259057}.",

	-- Step 75: Gronok's Key
	-- {npc:263749} Gronok the Butcher · {npc:259057} Dunston Willis · {item:275043} Bloodmaster's Ring
	["{npc:263749} (level 44) carries the key: he paces the lanes south of {npc:259057}'s hut.\nThe {item:275043} lies just west of the lanes: its fighters (elites, 41-45) only fight in a bout, so leave them be."] = "{npc:263749} (nivel 44) lleva la llave: recorre los callejones al sur de la choza de {npc:259057}.\nEl {item:275043} está justo al oeste de los callejones: sus luchadores (élite, 41-45) solo pelean en un combate de arena, así que déjalos en paz.",

	-- Step 76: Dunston Willis
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["Free him, then get him out: {npc:259057} fights his way out of {area:16726}, and you keep the ogres off him. If he falls, take the quest from him again."] = "Libéralo y sácalo de allí: {npc:259057} se abre paso para salir de {area:16726} y tú mantienes alejados de él a los ogros. Si muere, vuelve a aceptar la misión que te da.",
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["help {npc:259057} break out of {area:16726}"] = "ayuda a {npc:259057} a escapar de {area:16726}",

	-- Step 77: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "Termina las {item:268632}",
	-- {npc:259758} Gul'gash
	["South-east out of the hills towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "Ve al sureste, fuera de las colinas, hacia el puerto: los reptadores de costa de la playa al norte de los muelles son las entrañas más rápidas. {npc:259758} también baja a esta playa.",

	-- Step 78: Powderfuse Port
	["Down to the port."] = "Baja al puerto.",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: una gran bestia en las aguas poco profundas al suroeste del puerto, cerca de {npc:257001}, el élite",

	-- Step 79: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "El {npc:260244} merodea por las aguas poco profundas al suroeste del puerto, bajo las playas de los múrlocs. {npc:257001}, un élite, recorre la orilla cerca: mantén las distancias.",

	-- Step 81: The meadows
	["The meadows"] = "Los prados",
	-- {npc:263367} Sleebo Fizzlespout
	["West of the port, the wildflowers grow in the meadows below {npc:263367}'s workshop."] = "Al oeste del puerto, las flores silvestres crecen en los prados bajo el taller de {npc:263367}.",

	-- Step 82: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257558} Demar Brant
	["South-west across the plains to {area:16724}: {npc:257558} in the keep at the east end."] = "Ve al suroeste cruzando las llanuras hasta {area:16724}: {npc:257558}, en la fortaleza del extremo este.",

	-- Step 83: Demar Brant
	-- {quest:94887} Saving Marshal Ryan
	["{quest:94887}: for later in this guide"] = "{quest:94887}: para más adelante en esta guía",

	-- Step 86: Brother Lowley
	-- {npc:263613} Brother Lowley · {npc:262031} Sister Rowland
	["{npc:263613} tends the wounded beside the barracks: bandage three of his soldiers, then he has a note for {npc:262031} in the cathedral."] = "{npc:263613} atiende a los heridos junto al cuartel: venda a tres de sus soldados y luego te dará una nota para {npc:262031}, en la catedral.",
	-- {item:272126} Makeshift Bandages
	-- plural, as words: Wounded Soldiers = {npc:263614} Wounded Soldier
	["{item:272126}, on the Wounded Soldiers beside him"] = "{item:272126}, en los Soldados heridos que tiene al lado",

	-- Step 87: Farholde Keep, the west side
	-- {area:16724} Farholde Keep
	["{area:16724}, the west side"] = "{area:16724}, el lado oeste",
	-- {npc:263089} Tessa Dawnbright · {npc:259859} Wheatley
	["West through the keep: {npc:263089} by the orchard, then the cathedral and {npc:259859} south of the inn if you have their errands."] = "Ve al oeste por la fortaleza: {npc:263089}, junto al huerto, y luego la catedral y {npc:259859}, al sur de la posada, si tienes sus encargos.",

	-- Step 88: Sister Rowland
	-- {quest:96084} Something's in the Water
	["{quest:96084}: for later in this guide"] = "{quest:96084}: para más adelante en esta guía",

	-- Step 90: Something's in the Water
	-- {area:16729} Terral's Watch · {npc:262031} Sister Rowland
	["North past {area:16729}: fill {npc:262031}'s phial in the marsh water north-east of the tower."] = "Ve al norte, más allá de {area:16729}: llena el vial de {npc:262031} en el agua del pantano al noreste de la torre.",

	-- Step 91: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower."] = "La torre de {npc:259352}.",

	-- Step 93: Turner's Logging Camp
	-- {area:16736} Turner's Logging Camp · {npc:263380} Ghostmaw
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["West across the river to {area:16736}: the Peasant Woodpiles around the camp give the wood bundles.\nCareful: {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "Cruza el río hacia el oeste hasta {area:16736}: las Pilas de leña de campesino alrededor del campamento dan los haces de madera.\nCuidado: {npc:263380}, un élite (nivel 42), ronda el río junto al campamento: si viene hacia ti, retírate y déjalo pasar.",

	-- Step 94: Sergeant Riftan
	-- {area:16685} Twilight's Shroud · {npc:258023} Sergeant Riftan
	["North up the long valley towards {area:16685}: {npc:258023} holds a small camp below the Twilight cult's fortress."] = "Sube al norte por el largo valle hacia {area:16685}: {npc:258023} tiene un pequeño campamento bajo la fortaleza del culto Crepuscular.",

	-- Step 95: The Twilight camps
	["The Twilight camps"] = "Los campamentos Crepusculares",
	-- {npc:258652} Twilight Thrall · {npc:257591} Ashe Amberhall · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The cult's camps fill the valley north and west of Riftan. Free the captive Farholde Scouts as you find them, and kill a {npc:258652} for {npc:257591}: her soulstone takes it. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them."] = "Los campamentos del culto llenan el valle al norte y al oeste de Riftan. Libera a los Exploradores de Farholde cautivos según los encuentres y mata a un {npc:258652} para {npc:257591}: su piedra de alma lo captura. Los Ejecutores Crepusculares (élites, nivel 45) patrullan los campamentos: fíjate por dónde pasan antes de cada pull. {npc:256881} y {npc:256891} (élites, 46) ocupan la fortaleza al fondo del valle: aleja de ellos a los cultistas.",
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout
	["free five captive Farholde Scouts"] = "libera a cinco Exploradores de Farholde cautivos",
	-- {npc:258652} Twilight Thrall
	["kill a {npc:258652}"] = "mata a un {npc:258652}",

	-- Step 96: Marshal Ryan
	-- {npc:257250} Marshal Ryan · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	["{npc:257250} lies wounded among the camps at the valley's western edge.\nCareful: {npc:256881} and {npc:256891} (elites, 46) hold the fortress north of him: come at Ryan from the south."] = "{npc:257250} yace herido entre los campamentos del extremo oeste del valle.\nCuidado: {npc:256881} y {npc:256891} (élites, 46) ocupan la fortaleza al norte de él: acércate a Ryan desde el sur.",
	-- {npc:257250} Marshal Ryan
	["find {npc:257250} and talk to him"] = "encuentra a {npc:257250} y habla con él",
	-- {quest:94892} Dying Wish · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:94892}: for {npc:257558} in {area:16724}"] = "{quest:94892}: para {npc:257558} en {area:16724}",

	-- Step 97: The ogre mine
	["The ogre mine"] = "La mina de los ogros",
	-- plural, as words: Twilight Subjugators = {npc:260996} Twilight Subjugator · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine, driven by the Twilight Subjugators.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in, and pull the miners and Subjugators back out to you."] = "Al norte de los campamentos, el culto hace trabajar a mineros ogros en una mina, vigilados por los Subyugadores Crepusculares.\nCuidado: los Ejecutores Crepusculares (élites, nivel 45) pasan por la entrada de la mina al recorrer los campamentos. Espera a que pase uno antes de entrar y atrae a los mineros y Subyugadores hacia fuera.",

	-- Step 99: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881} es un élite (nivel 46) en la fortaleza al fondo del valle, rodeado de Ejecutores: se recomienda ir en grupo.",
	-- {quest:94891} News to Farholde · {npc:257591} Ashe Amberhall
	["{quest:94891}: for {npc:257591}"] = "{quest:94891}: para {npc:257591}",

	-- Step 100: Back to Farholde Keep
	-- {area:16724} Farholde Keep
	["Back to {area:16724}"] = "De vuelta a {area:16724}",
	-- {area:16724} Farholde Keep
	["Your hearthstone is bound at {area:16724}'s inn: use it, or ride back south to the keep."] = "Tu piedra de hogar está vinculada a la posada de {area:16724}: úsala o vuelve cabalgando al sur hasta el castillo.",

	-- Step 101: Farholde Keep
	-- {npc:260070} Bertrand Ironbrow · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["From the inn: {npc:260070} on the way in, then {npc:257558} and {npc:257591} in the keep."] = "Desde la posada: {npc:260070} de camino, y luego {npc:257558} y {npc:257591} en el castillo.",

	-- Step 103: Demar Brant
	-- {quest:94893} Delivering Closure · {npc:278088} Abigail Lawson · {zone:1453} Stormwind
	["{quest:94893}: for {npc:278088} in {zone:1453}"] = "{quest:94893}: para {npc:278088} en {zone:1453}",

	-- Step 104: The Twilight Threat
	-- {npc:257558} Demar Brant · {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:257558}: Kilgar's head for {npc:1748} in {object:2117}"] = "{npc:257558}: la cabeza de Kilgar para el {npc:1748} en el {object:2117}",

	-- Step 105: Sister Rowland
	-- {npc:262031} Sister Rowland
	["{npc:262031}, in the cathedral at the keep's south-west corner."] = "{npc:262031}, en la catedral de la esquina suroeste del castillo.",

	-- Step 106: Stormwind
	-- {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind · {npc:278088} Abigail Lawson · {object:2098} Cathedral Square
	["{npc:257087} flies to {zone:1453}. {npc:278088} waits in the {object:2098}."] = "{npc:257087} vuela a {zone:1453}. {npc:278088} espera en la {object:2098}.",

	-- Step 108: Train before the Badlands
	-- {zone:1418} Badlands
	["Train before the {zone:1418}"] = "Entrena antes de {zone:1418}",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1425} Hinterlands · {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}, and the {zone:1418} & {zone:1425} guide passes none: {npc:257087} flies to {zone:1453}, where you train before you go on."] = "No hay instructor de clase en {zone:2548}, y la guía de {zone:1418} y {zone:1425} no pasa por ninguno: {npc:257087} vuela a {zone:1453}, donde entrenas antes de seguir.",

	-- Step 109: Your class trainer
	["Your class trainer"] = "Tu instructor de clase",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}: train here in {zone:1453} before you fly on."] = "No hay instructor de clase en {zone:2548}: entrena aquí, en {zone:1453}, antes de seguir volando.",

	-- Step 110: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 111: Shaman trainer
	["Shaman trainer"] = "",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind · {zone:1418} Badlands · {zone:1425} Hinterlands · {area:1537} Ironforge · {area:144} Thelsamar
	["No shaman trainer stands in the {zone:2548} or in {zone:1453}, and the {zone:1418} & {zone:1425} guide passes none: fly to {area:1537} and train there; {area:144} is a short flight on."] = "No hay instructor de chamanes en {zone:2548} ni en {zone:1453}, y la guía de {zone:1418} y {zone:1425} no pasa por ninguno: vuela a {area:1537} y entrena allí; {area:144} está a un vuelo corto.",

	-- Step 112: Leave Stormwind
	-- {zone:1453} Stormwind
	["Leave {zone:1453}"] = "Sal de {zone:1453}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1453} Stormwind · {object:2096} Trade District
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}. {zone:1453}'s gryphon master stands in the {object:2096}."] = "La siguiente guía empieza en {zone:1418}, al sur de {zone:1432}: vuela a {area:144}. El maestro de grifos de {zone:1453} está en el {object:2096}.",

	-- Step 113: Loch Modan
	-- {area:144} Thelsamar · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["No flight path to {area:144} yet: go to {zone:1455} (by the {area:2257} from {zone:1453}), ride out of its gates east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "Aún no tienes ruta de vuelo a {area:144}: ve a {zone:1455} (en el {area:2257} desde {zone:1453}), sal por sus puertas hacia el este a través de {zone:1426} y el túnel hasta {zone:1432}, y sigue el camino hasta {area:144}.",

	-- Step 114: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Vuela a {area:144}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}."] = "La siguiente guía empieza en {zone:1418}, al sur de {zone:1432}: vuela a {area:144}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:17028}, from {npc:272437}"] = "{item:17028}, de {npc:272437}",
	-- ["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} hands out the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} cuida la vieja catedral en la esquina suroeste de {area:16724}. Los murciélagos anidan en su piso superior; {npc:272437} reparte las velas sagradas a su lado; las tumbas están en el cementerio de la capilla.\n{npc:271742}, un élite de nivel 53, está en la catedral: no te ataca, así que nunca lo ataques y aleja a los murciélagos de él.",
	-- ["{object:621813}: bury the mementos"] = "{object:621813}: entierra los recuerdos",
}
