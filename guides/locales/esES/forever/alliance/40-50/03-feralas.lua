-- Spanish (Spain) (esES): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "",

	-- Step 2: Thalanaar flight master
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 3: Boat to Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold
	["Boat to {area:1116}"] = "",

	-- Step 4: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast · {npc:7880} Ginro Hearthkindle
	["{area:1116} stands on {area:1120}, off the {area:1108}: the boat from the coast's dock crosses to it. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}, a su lado",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}, en lo alto del bastión",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}: su respuesta espera en {area:702}, más adelante",

	-- Step 5: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "Camina hacia el sur por la isla hasta las ruinas naga; el cenador está entre ellas.",

	-- Step 7: Hatecrest naga
	["Hatecrest naga"] = "Nagas Crestafuria",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "Vuelve a las {area:1117}. Cualquier naga Crestafuria de allí puede soltar escamas.",

	-- Step 8: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136} espera hasta el final del recorrido por el continente.",

	-- Step 9: Boat to Forgotten Coast
	-- {area:1108} Forgotten Coast
	["Boat to {area:1108}"] = "",

	-- Step 10: Feralas
	["The courier's boat"] = "El bote del mensajero",

	-- Step 11: The courier's boat
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "Toma el barco a {area:1108} y sigue la orilla hacia el sur hasta el bote de remos destrozado en la playa.",

	-- Step 12: Gordunni ogres
	["Gordunni ogres"] = "Ogros Gordunni",
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "Cabalga hacia el este hasta la Avanzada Gordunni, en las colinas al sureste del valle de los yetis: Brujos y Chamanes Gordunni ocupan el campamento y los Toscos Gordunni deambulan por las laderas de alrededor y más al norte.",

	-- Step 13: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "Cabalga hacia el norte hasta el valle de los yetis. Cualquier yeti Cicatriz Feral puede soltar un pellejo grueso; {npc:5346} (nivel 48) merodea por el centro.",

	-- Step 14: Isle of Dread
	-- {area:1121} Isle of Dread · {area:1120} Sardor Isle · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["The {area:1121} is the island just south of {area:1120}: swim over. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "",
	-- {item:9248} Mysterious Relic
	["{item:9248}; below ground"] = "",

	-- Step 15: Feathermoon Stronghold
	-- {npc:7877} Latronicus Moonspear · {npc:7878} Vestia Moonspear · {npc:7900} Angelas Moonbreeze · {npc:7880} Ginro Hearthkindle · {npc:7852} Pratt McGrubben
	["Coming from the south: {npc:7877} and {npc:7878} first, then {npc:7900} beside {npc:7880}'s building, then the stairs. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:7852} is by the flight master, on the way out."] = "",
	-- {npc:7879} Quintis Jonespyre
	["{npc:7879}, upstairs"] = "",

	-- Step 16: Fly to Thalanaar
	-- {area:489} Thalanaar
	["Fly to {area:489}"] = "",
	["Feathermoon flight master"] = "",

	-- Step 17: Feralas
	["Grimtotem camp"] = "Dominios Tótem Siniestro",

	-- Step 18: Grimtotem camp
	-- {area:489} Thalanaar · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["From {area:489} ride west along the road to the Grimtotem camp north of it. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "",

	-- Step 19: Grimtotem tauren
	["Grimtotem tauren"] = "Tauren Tótem Siniestro",

	-- Step 20: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "para Tyrande en {zone:1457}: la ruta te lleva allí a nivel 47",

	-- Step 21: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "Cabalga hacia el sureste hasta los gnolls Zarpaleña; las mochilas del mensajero están en su campamento del sur, y un paquete que hay dentro inicia una entrega a {area:489}. La colmena Zukk'ash está justo al sur: abre paso hasta la vaina que retiene a Raschal el Mensajero, libéralo y mantenlo con vida al salir.",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}, de las mochilas",
	-- {object:164954} Zukk'ash Pod
	["{object:164954}, inside"] = "",

	-- Step 22: High Wilderness: kill these as you meet them
	-- {area:1136} High Wilderness
	["{area:1136}: kill these as you meet them"] = "",
	-- {quest:7735} Pristine Yeti Hide · {npc:7852} Pratt McGrubben · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak
	["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide, and about one in thirty a {quest:7735}, which {npc:7852} pays for too.\n{npc:14637}'s quests on the coast need level 45: grind the yetis here until level 44.5, so the kills also bring {npc:7852}'s hides. Or, with a group, run the {area:978} dungeon instead."] = "",
	-- {npc:5296} Rage Scar Yeti
	["grind on {npc:5296}"] = "",

	-- Step 23: Rage Scar Hold
	-- {quest:7735} Pristine Yeti Hide
	["No {quest:7735} yet? Keep killing the Rage Scar yetis until one drops, then right-click it."] = "",

	-- Step 24: Feathermoon Stronghold
	-- {npc:7880} Ginro Hearthkindle
	["{npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 25: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "Después {npc:3936} te pide que lleves noticias a {zone:1457}: omítelo, {area:976} te enviará allí en su lugar.",

	-- Step 27: Grind to 45
	["Grind to 45"] = "Farmea hasta el 45",
	-- {area:1105} Feral Scar Vale · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak · {area:1517} Uldaman
	["Ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "farmea {npc:5292} en {area:1105}, {zone:1444}",

	-- Step 28: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast
	["Ride back to the {area:1108}; the goblin stands by the dock."] = "Vuelve a {area:1108}; el goblin está junto al muelle.",

	-- Step 29: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Shore Striders = {npc:5359} Shore Strider · Deep Striders = {npc:5360} Deep Strider · Wave Striders = {npc:5361} Wave Strider · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "Zancacostas, Zancaprofundas y Asaltaolas (gigantes élite) vadean la costa al norte del muelle: dispara a uno con {item:18904} y mata al gigante encogido. Elementales marinos y Rocíos del mar flotan entre las mismas olas.",

	-- Step 30: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["{npc:14637}'s refills are level 55: skip them."] = "Las recargas de {npc:14637} son de nivel 55: omítelas.",
	-- {zone:1446} Tanaris · {area:489} Thalanaar
	["The {zone:1446} guide starts with the trip east, past {area:489}."] = "",

	-- Step 31: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "Cabalga hacia el noreste hasta el puesto de los elfos de la noche en la frontera de {zone:1441}.",
	-- {npc:4048} Falfindel Waywarder · {area:489} Thalanaar
	["{npc:4048} walks around {area:489}: look inside the circle on the map"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "Toma el barco a {area:1108} y cabalga hacia el este por {zone:1444} hasta los Dominios Tótem Siniestro, al norte del camino. {npc:7956} espera fuera; libera a los Duendes dardo del cercado del centro y mantén con vida a {npc:7956} y al menos a seis de ellos.",
	-- ["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "Toma el barco a {area:1108} y cabalga hacia el este hasta {area:1105}. Las misiones de {npc:14637} en la costa requieren nivel 45.",
	-- ["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "Desde Theramore, vuela a {area:608} y cabalga hacia el sur desde {zone:1443} hasta {zone:1444}; el camino lleva al oeste hasta el muelle de {area:1108}, donde el barco cruza a Plumaluna, en {area:1120}.",
	-- ["Giants and elementals"] = "Gigantes y elementales",
	-- ["Hearth to Feathermoon."] = "Usa la piedra de hogar para ir a Plumaluna.",
	-- ["Rage Scar yetis"] = "Yetis Estigmodio",
	-- ["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "Vuelve al noroeste hasta el muelle de {area:1108} y toma el barco a la isla.",
	-- ["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "Vuelve al oeste por el camino y luego al norte hasta las colinas de los Dominios de los Cicatriz de Rabia. Cualquier yeti de aquí puede soltar un pellejo; alguno puede soltar un {quest:7735}, que {npc:7852} McGrubben también paga.",
	-- ["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "Cabalga hacia el oeste hasta el gigante de montaña amistoso al pie de las colinas. Los Caminantes de la tierra y los Gigantes del risco que lo rodean son élite: mantén la distancia.",
	-- ["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "Toca la campana cada vez que {npc:7774} se pare a deambular y llévala hacia el sur hasta {npc:7765}.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "Hacer {area:978} en grupo en vez de farmear te lleva allí más rápido. La ciudad trol está en el norte de {zone:1446}, la siguiente zona de la ruta; después vuelve con {npc:14637} en {area:1108}.",
	-- ["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "Nada hacia el sur desde la isla hasta {area:1121}. La ocupan Guardias serpiente y Hechiceras Crestafuria; {npc:8136} (nivel 47) espera en la cueva de su extremo sur. Atrae primero a sus guardias.",
	-- ["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "Terminas en el muelle de {area:1108}: la guía de {zone:1446} empieza con el viaje hacia el este desde aquí.",
	-- ["grind on {npc:5292} at {area:1105}, {area:357}"] = "farmea {npc:5292} en {area:1105}, {area:357}",
	-- ["if you carry {quest:1100} from {zone:1441}"] = "si llevas {quest:1100} de {zone:1441}",
	-- ["{area:978} instead of grinding"] = "{area:978} en vez de farmear",
	-- ["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774} deambula por las colinas al norte de {npc:7765}, entre las arpías Nortearroyo; su campana está en el cofre a su lado.",
	-- ["{npc:7774}'s escort"] = "La escolta de {npc:7774}",
}
