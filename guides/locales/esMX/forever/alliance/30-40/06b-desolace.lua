-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1443} Desolace
	["Kodo bones, demons and lost treasure in south {zone:1443}."] = "Huesos de kodo, demonios y tesoros perdidos en el sur de {zone:1443}.",
	["Short: about one level of quests"] = "Corta: alrededor de un nivel de misiones",
	-- {zone:1434} Stranglethorn Vale
	["Then on to {zone:1434}"] = "Luego, a {zone:1434}",
	["Stays on the main route"] = "Se mantiene en la ruta principal",
	["A long trip out to Kalimdor"] = "Un largo viaje hasta Kalimdor",

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
	-- {npc:5396} Captain Pentigast
	["{npc:5396}, if 30-40/02 didn't give it"] = "{npc:5396}, si 30-40/02 no te la dio",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Sigue el camino al sur hasta {area:2407}.",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} está en el borde de {area:596}, al suroeste de {area:2407}; {object:176751} están entre los esqueletos.",

	-- Step 7: Hornizz Brimbuzzle
	-- {quest:6134} Ghost-o-plasm Round Up · {area:2657} Valley of Bones
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:6134}'s magnets draw the Magrami Spectres a few yards from the Magram Necrokhans and Corpsefeeders (45, elite) in the {area:2657}. Skip it if you are alone."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerla. Los imanes de {quest:6134} atraen a los espectros Magrami a pocos metros de los necrokhans y los devoracadáveres Magram (45, élite) en {area:2657}. Omítela si vas solo.",

	-- Step 8: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Un {npc:217590} anda por {area:596}: atrapa uno con la herramienta de {item:213565} de {npc:217412}.",

	-- Step 9: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Los centauros Maraudine ocupan {area:607}, al oeste del cementerio; todos sueltan los tótems.",

	-- Step 10: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está cautiva en el campamento centauro al oeste del cementerio. Libérala y mantenla con vida en la salida; se detiene junto al cementerio.\nCuidado: Los grupos programados están vinculados y solo aparecen durante la escolta, así que no puedes despejarlos antes ni atraerlos de a uno. Sí ayuda despejar antes los centauros normales del camino.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolta a {npc:12277} de vuelta hacia el cementerio",

	-- Step 11: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {npc:5760} Lord Azrethoc
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}. Nether Maidens (37-38) hold its north-west side and drop the wings; Doomwarder Captains (38) stand at the south end and drop the blood.\nCareful: Nether Sorceresses (39-40) stand beside the Doomwarder Captains, and {npc:5760}, a level 40 elite, walks the coven's middle: pull the captains away from them. Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Los demonios se reúnen en {area:602}, en el sur de {zone:1443}. Las doncellas abisales (37-38) ocupan su lado noroeste y sueltan las alas; los capitanes Guardiavil (38) están en el extremo sur y sueltan la sangre.\nCuidado: Las hechiceras abisales (39-40) están junto a los capitanes Guardiavil, y {npc:5760}, un élite de nivel 40, recorre el centro del aquelarre: aleja a los capitanes de ellos. La mayoría de los enemigos patrullan, así que es fácil atraer de más.",
	-- {item:6251} Nether Wing
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden
	["{item:6251}, from the Nether Maidens"] = "{item:6251}, de las doncellas abisales",
	-- {item:6252} Doomwarder Blood
	-- plural, as words: Doomwarder Captains = {npc:4680} Doomwarder Captain
	["{item:6252}, from the Doomwarder Captains"] = "{item:6252}, de los capitanes Guardiavil",

	-- Step 12: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields further east, with Magram Necromancers (42): pull the Ravagers to you, away from them."] = "Los devastadores no-muertos recorren los campos de huesos al sur de la aldea Magram, al este del Aquelarre: la flecha lleva a su borde oeste. Cuidado: los necrokhans Magram y los devoracadáveres (45, élite) recorren los campos de huesos más al este, con nigromantes Magram (42): atrae a los devastadores hacia ti, lejos de ellos.",

	-- Step 13: The ghost magnets
	["The ghost magnets"] = "Los imanes fantasmales",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre
	["Use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres; the Necrokhans and Corpsefeeders (45, elite) walk close by: keep the group together."] = "Usa {item:15848} en su flecha, en el lado este de los campos, para atraer a los espectros Magrami; los necrokhans y los devoracadáveres (45, élite) andan cerca: mantén el grupo unido.",

	-- Step 14: Mannoroc Coven
	-- {npc:5760} Lord Azrethoc
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter
	["Back at the coven on the way west: the Mana Eaters (37-38) on its north edge and the Mage Hunters (38-39) further in drop the brains. {npc:5760} (40, elite) walks among the Mage Hunters: pull them out to you."] = "De vuelta en el aquelarre camino al oeste: los devoradores de maná (37-38) de su borde norte y los cazadores de magos (38-39) más adentro sueltan los cerebros. {npc:5760} (40, élite) anda entre los cazadores de magos: atráelos hacia ti.",

	-- Step 18: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Sigue el camino al oeste por el norte de {zone:1443} hasta las ruinas de {area:2405}. La torre de {npc:11863} está en la colina de ahí, de camino al naufragio.",
	-- {npc:11863} Azore Aldamort · {quest:93464} The Visiting Mage · {zone:1435} Swamp of Sorrows
	["{npc:11863}: {quest:93464}, from Magtoor in the {zone:1435}"] = "{npc:11863}: {quest:93464}, de Magtoor en {zone:1435}",

	-- Step 19: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "El cofre del barco naufragado está justo al suroeste de la torre de {npc:11863}.",

	-- Step 20: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest · {zone:1443} Desolace
	["{object:177787} lies beside {object:35251}, if you didn't take it on your first {zone:1443} visit. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} está junto a {object:35251}, si no lo tomaste en tu primera visita a {zone:1443}. Su llave de plata la sueltan los cangrejos Secachasquido alrededor del naufragio; la dorada viene de los nagas Filozante de la costa noroeste, lo siguiente.",
	-- {object:177787} Rackmore's Log
	["{object:177787}, if 30-40/02 didn't take it"] = "{object:177787}, si 30-40/02 no lo tomó",
	["Underwater"] = "Bajo el agua",

	-- Step 21: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: mata a estos según te los encuentres",
	-- {npc:11863} Azore Aldamort · {spell:131} Water Breathing · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower, on the shore and out in the water. Karnitol's satchel drops now and then from their Tidehunters and Sea Witches, most of them underwater ({spell:131} helps): take it if it comes, it is optional. Any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, de los naga Filozante",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue
	["{item:15766}, on the {object:177673}"] = "{item:15766}, en {object:177673}",

	-- Step 22: Rackmore's Chest
	-- {object:177673} Serpent Statue
	["Rackmore's chest lies just south-east of the {object:177673}."] = "El cofre de Rackmore está justo al sureste de {object:177673}.",

	-- Step 24: Nijel's Point
	-- {area:608} Nijel's Point · {area:2405} Ethel Rethor · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Hearth to {area:608} if you are still bound there and the stone is ready. Otherwise follow the road east from {area:2405} and up the pass. Hand in at {npc:5396}, {npc:5638} and {npc:1182} before the flight."] = "",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} en {zone:1455}: guárdala",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} en {area:271}: guárdala",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Vuela a Isla Theramore",
	["The next guide starts in Theramore."] = "La siguiente guía empieza en Isla Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Sigue el camino al norte hasta {area:608}: {npc:5396} está en su extremo sur, {npc:5638} en el centro, {npc:1182} al norte.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Los nagas Filozante ocupan la costa noroeste, al norte de la torre de {npc:11863}; la cartera de Karnitol está en el fondo del mar frente a ella, y cualquier naga puede soltar la llave dorada de Rackmore. Nada hasta {area:2406}, frente a la punta más al norte, y usa {item:15766} en {object:177673}: surge {npc:12369} (38); mátalo para {quest:6027}.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Los demonios se reúnen en {area:602}, en el sur de {zone:1443}: canes viles (devoradores de maná, cazadores de magos y de líneas ley), doncellas y hermanas abisales, y capitanes Guardaruina alrededor del foso.\nCuidado: La mayoría de los enemigos de aquí patrullan, así que es fácil atraer enemigos de más.",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "Los devastadores no-muertos recorren los campos de huesos al sur de la aldea Magram, al este del Aquelarre: la flecha lleva a su borde oeste. Luego usa {item:15848} en su flecha, en el lado este de los campos, para atraer a los espectros Magrami. Cuidado: los necrokhans Magram y los Corpsefeeders (45, élite) recorren los campos de huesos entre las dos flechas, con nigromantes Magram (42): atrae a los devastadores y a los espectros hacia ti, lejos de ellos.",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} está junto a {object:35251}. Su llave de plata la sueltan los cangrejos Secachasquido alrededor del naufragio; la dorada viene de los nagas Filozante de la costa noroeste, lo siguiente.",
}
