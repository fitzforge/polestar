-- Spanish (Latin America) (esMX): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "¿No tienes {item:4371} para {quest:174}? {npc:3133} lo vende en la casa junto a la de {npc:276}, con existencias limitadas; {npc:1448} en {area:150} también lo vende.",
	-- {npc:352} Dungar Longdrink · {zone:1453} Stormwind
	["From {npc:352} in {zone:1453}"] = "De {npc:352} en {zone:1453}",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, en la taberna",
	-- {npc:840} Watcher Backus
	["{npc:840}, at the north entrance of town"] = "{npc:840}, en la entrada norte del pueblo",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, en el ayuntamiento",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, junto al ayuntamiento",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, de {npc:3133}, si no tienes",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, at the east end of town"] = "{npc:276}, en el extremo este del pueblo",

	-- Step 2: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "Tejesombras Penumbría",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "Los huargos ocupan el bosque de la Arboleda del Destello, al oeste de {area:42} y al norte del camino. Atráelos de uno en uno.",

	-- Step 4: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "Sombracechadores Penumbría",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "Los sombracechadores merodean por el bosque al sur del camino, al oeste de {area:42}.",

	-- Step 6: Blind Mary
	-- {area:42} Darkshire
	["Her house stands on the hill south-east of {area:42}."] = "Su casa está en la colina al sureste de {area:42}.",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "Colmillovil Penumbría y {npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "Los huargos más fuertes deambulan por el bosque al sur de {area:42}, al oeste y al sur de {area:121}. {npc:511} se esconde en la pequeña cripta junto al cementerio.",

	-- Step 8: Darkshire
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house"] = "{npc:661}, junto a la casa de {npc:633}",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "Cabalga al oeste por el camino; la choza del ermitaño está al noreste de {area:492}.",

	-- Step 10: Plague Spreaders
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["Plague Spreaders"] = "Propagadores de peste",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "Los propagadores de peste recorren la mitad norte de {area:492}. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.",

	-- Step 11: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "Campamento de {npc:311}",

	-- Step 12: Raven Hill Cemetery, west
	-- {area:492} Raven Hill Cemetery
	["{area:492}, west"] = "{area:492}, oeste",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "Los asaltantes, sanadores y guardas esqueléticos ocupan la parte oeste del cementerio, justo al este del campamento de {npc:311}.",

	-- Step 13: Sven Yorgen's Camp
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "Para {npc:1212} en {zone:1453}, en la siguiente guía",

	-- Step 14: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "El campamento Defias está en el suroeste de {zone:1431}, al sur de {area:94}, cerca de la frontera de {zone:1436}. La caja fuerte está entre las tiendas.",

	-- Step 15: Vul'Gol Ogre Mound
	-- {object:119} Abercrombie's Crate
	["Ride east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Cabalga al este hasta el túmulo de los ogros. {object:119} está en el campamento de su entrada; los ogros Puñastilla lo vigilan.",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "Solo si un {npc:272273} soltó {quest:96138}: haz clic derecho en él",

	-- Step 17: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Regresa a {area:42}",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "Para {npc:482} en {zone:1453}, en la siguiente guía",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263}, en el ayuntamiento",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, en la casa detrás del ayuntamiento",
	["Wait a moment, then speak with her again"] = "Espera un momento y vuelve a hablar con ella",

	-- Step 18: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, en la posada",
	-- {item:2594} Flagon of Mead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, de {npc:1464}",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "{npc:1217}, en el piso de arriba de la posada",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "{npc:2104}, junto a la fortaleza",

	-- Step 19: The wreck of the Third Fleet
	["The wreck of the Third Fleet"] = "El naufragio de la Tercera Flota",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "Sigue la costa al norte hasta el barco naufragado. Los Marineros malditos ({npc:1157}) recorren la playa, y los Marinos malditos ({npc:1158}), la cubierta; {npc:1159} está en la playa junto a la proa. Los Crocoliscos gigantes de Los Humedales ({npc:2089}) acechan en la costa justo al norte.",

	-- Step 20: Bluegill Raiders
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Bluegill Raiders"] = "Asaltantes Branquiazul",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "Sigue la costa al noreste pasando el naufragio: los asaltantes Branquiazul ocupan el pantano más allá de los crocoliscos gigantes.",

	-- Step 22: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "El capitán recorre la cubierta del barco naufragado; su caja fuerte está en la bodega.",

	-- Step 23: Glorin Steelbrow
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, in the next guide"] = "Para {npc:1284} en {zone:1453}, en la siguiente guía",

	-- Step 24: Whelgar's Excavation Site
	["Follow the road east to the excavation site."] = "Sigue el camino al este hasta la Excavación de Whelgar.",

	-- Step 25: The dig and Sarltooth
	-- {npc:1353} Sarltooth
	["The dig and {npc:1353}"] = "La excavación y {npc:1353}",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "Las reliquias están en la propia excavación. {npc:1353}, un gran Tajobuche, merodea por el valle de raptores justo al oeste.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 26: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} y Whelgar",

	-- Step 27: Dragonmaw camp
	["Dragonmaw camp"] = "Campamento Faucedraco",
	["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "Los orcos Faucedraco acampan al este de la excavación. Los asaltantes y correpantanos llevan los estandartes de guerra.",

	-- Step 28: Captain Stoutfist
	-- {area:150} Menethil Harbor
	["Ride back west along the road to {area:150}."] = "Cabalga de vuelta al oeste por el camino hasta {area:150}.",

	-- Step 29: Dragonmaw catapult
	["Dragonmaw catapult"] = "Catapulta Faucedraco",
	["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "Cabalga otra vez al este; la catapulta está en el campamento Faucedraco al sur del camino.",
	["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "El siguiente paso, Derrota a Nek'rosh, te enfrenta a un cabecilla élite: omítelo.",

	-- Step 30: To Theramore
	["To Theramore"] = "A Theramore",
	-- {area:513} Theramore Isle · {zone:1445} Dustwallow Marsh
	["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "Toma el barco del muelle de Menethil a {area:513} en {zone:1445}.",

	-- Step 31: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "En el camino al sur por {zone:1413}, {npc:6244} acampa al este del camino, al noreste de {area:378}; llega desde el este y mantente lejos de los guardias de la Horda.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: en {zone:1440}, de camino a {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: el íncubo, junto a la súcubo; {item:190309} está cerca de {quest:1738}",

	-- Step 32: The Great Lift
	-- {zone:1413} Barrens · {area:378} Camp Taurajo · {area:485} The Great Lift · {zone:1441} Thousand Needles
	["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "Desde Theramore sigue el camino al oeste fuera de Revolcafango hacia {zone:1413} y luego al sur por él; aléjate bien de {area:378}. {area:485}, en el extremo sur de {zone:1413}, te baja a {zone:1441}. El diario está al pie del elevador.",
	-- {npc:4048} Falfindel Waywarder · {zone:1444} Feralas
	["For {npc:4048} in {zone:1444}, much later"] = "Para {npc:4048} en {zone:1444}, mucho después",

	-- Step 33: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Sigue los cañones al este hasta El Desierto de Sal. Los goblins y gnomos de {area:2240} son neutrales y dan misiones a ambas facciones.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Para {quest:5762} en Tuercespina, más adelante",

	-- Step 34: The salt flats
	["The salt flats"] = "El Desierto de Sal",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Scorpid Terrors = {npc:4139} Scorpid Terror
	["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868} está por todo el desierto. Los atracadores escórpidos, las tortugas brillavalva y los basiliscos Piedra de sal recorren la mitad norte; los vitropieles, los terrores escórpidos y los mordedores, el centro; y los observadores (34-35, cinco niveles por encima de ti: de uno en uno), el extremo sur. Los buitres sobrevuelan todo.",

	-- Step 35: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454}: para Martek en {zone:1418}, más adelante",

	-- Step 36: Back to Menethil
	["Back to Menethil"] = "Regresa a Menethil",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride east to the ogre mound. {item:1349} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Cabalga al este hasta el Túmulo de Vul'Gol. {item:1349} está en el campamento de su entrada; los ogros Puñastilla lo vigilan.",
}
