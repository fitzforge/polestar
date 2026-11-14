-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maestro de vuelo de {area:144}",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "Maestro de vuelo de Theramore",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "Al bajar del barco, sube por el muelle hasta Baldruc, el maestro de vuelo junto a la puerta de {area:514}.",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, si 30-40/02 no la tomó: el naufragio está debajo de la torre de {npc:11863}",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Sigue el camino al sur hasta {area:2407}.",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} está en el borde de {area:596}, al suroeste de {area:2407}; {object:176751} están entre los esqueletos.",

	-- Step 7: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Un {npc:217590} anda por {area:596}: atrapa uno con la herramienta de {item:213565} de {npc:217412}.",

	-- Step 8: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Los centauros Maraudine ocupan {area:607}, al oeste del cementerio; todos sueltan los tótems.",

	-- Step 9: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está cautiva en el campamento centauro al oeste del cementerio. Libérala y mantenla con vida en la salida; se detiene junto al cementerio.\nCuidado: Los grupos programados están vinculados y solo aparecen durante la escolta, así que no puedes despejarlos antes ni atraerlos de a uno. Sí ayuda despejar antes los centauros normales del camino.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolta a {npc:12277} de vuelta hacia el cementerio",

	-- Step 10: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Los demonios se reúnen en {area:602}, en el sur de {zone:1443}: canes viles (devoradores de maná, cazadores de magos y de líneas ley), doncellas y hermanas abisales, y capitanes Guardaruina alrededor del foso.\nCuidado: La mayoría de los enemigos de aquí patrullan, así que es fácil atraer enemigos de más.",

	-- Step 11: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "Los devastadores no-muertos recorren los campos de huesos al sur de la aldea Magram, al este del Aquelarre: la flecha lleva a su borde oeste. Luego usa {item:15848} en su flecha, en el lado este de los campos, para atraer a los espectros Magrami. Cuidado: los necrokhans Magram y los Corpsefeeders (45, élite) recorren los campos de huesos entre las dos flechas, con nigromantes Magram (42): atrae a los devastadores y a los espectros hacia ti, lejos de ellos.",

	-- Step 14: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Sigue el camino al oeste por el norte de {zone:1443} hasta las ruinas de {area:2405}. La torre de {npc:11863} está en la colina de ahí, de camino al naufragio.",

	-- Step 15: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "El cofre del barco naufragado está justo al suroeste de la torre de {npc:11863}.",

	-- Step 16: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest
	["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} está junto a {object:35251}. Su llave de plata la sueltan los cangrejos Secachasquido alrededor del naufragio; la dorada viene de los nagas Filozante de la costa noroeste, lo siguiente.",
	["Underwater"] = "Bajo el agua",

	-- Step 17: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: mata a estos según te los encuentres",
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words) · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Los nagas Filozante ocupan la costa noroeste, al norte de la torre de {npc:11863}; la cartera de Karnitol está en el fondo del mar frente a ella, y cualquier naga puede soltar la llave dorada de Rackmore. Nada hasta {area:2406}, frente a la punta más al norte, y usa {item:15766} en {object:177673}: surge {npc:12369} (38); mátalo para {quest:6027}.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, de los naga Filozante",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words)
	["{item:15766}, on the {object:177673}"] = "{item:15766}, en {object:177673}",

	-- Step 18: Rackmore's Chest
	-- {object:177673} Serpent Statue (no name in this language: may be words)
	["Rackmore's chest lies just south-east of the {object:177673}."] = "El cofre de Rackmore está justo al sureste de {object:177673}.",

	-- Step 21: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Sigue el camino al norte hasta {area:608}: {npc:5396} está en su extremo sur, {npc:5638} en el centro, {npc:1182} al norte.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} en {zone:1455}: guárdala",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} en {area:271}: guárdala",

	-- Step 22: Fly to Theramore
	["Fly to Theramore"] = "Vuela a Isla Theramore",
	["The next guide starts in Theramore."] = "La siguiente guía empieza en Isla Theramore.",
}
