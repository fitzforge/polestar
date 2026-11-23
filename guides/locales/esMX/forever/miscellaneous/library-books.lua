-- Spanish (Latin America) (esMX): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386691} Library Book
	["Library Books"] = "Libros de biblioteca",
	["Lost books and scrolls all over the world: each pays experience at the library, and 10, 20 and 25 of them earn a necklace, a ring and an off-hand."] = "Libros y pergaminos perdidos por todo el mundo: cada uno da experiencia en la biblioteca, y 10, 20 y 25 de ellos dan un collar, un anillo y un objeto de mano izquierda.",

	-- Step 1: Elwynn Forest
	-- {area:91} Tower of Azora · {area:87} Goldshire
	["Halfway up the {area:91}, east of {area:87}. Nothing hostile inside."] = "A mitad de la subida de {area:91}, al este de {area:87}. Adentro no hay nada hostil.",

	-- Step 2: Westfall
	-- {area:20} Moonbrook · {area:108} Sentinel Hill
	["Two books: one in a house at {area:20}, one at {area:108} (Alliance only)."] = "Dos libros: uno en una casa de {area:20}, otro en {area:108} (solo Alianza).",
	["Rumi of Gnomeregan"] = "Rumi de Gnomeregan",

	-- Step 3: Duskwood
	-- {area:2098} Dawning Wood Catacombs · {zone:1431} Duskwood
	["The spellbook lies in the {area:2098}, the crypt in north-western {zone:1431}. Undead fill it; a corpse run works if you are low."] = "El libro de hechizos está en {area:2098}, la cripta del noroeste de {zone:1431}. Está llena de no-muertos; si tienes poco nivel, sirve una carrera de cadáver.",

	-- Step 5: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "Pergaminos en la cueva de los ogros Mo'grosh, en el noreste. Los ogros de la cueva son élites de nivel 18-19: se recomienda ir en grupo. (Rumi de Gnomeregan también está en {area:144}, si no la encontraste en {area:108}.)",

	-- Step 6: Wetlands
	-- {area:118} Whelgar's Excavation Site · {zone:1437} Wetlands
	["At {area:118}, the dig in the middle of the {zone:1437}."] = "En {area:118}, la excavación en medio de {zone:1437}.",

	-- Step 7: Silverpine Forest
	-- {area:233} Ambermill
	["At {area:233}, the mage village in south-eastern Silverpine."] = "En {area:233}, el pueblo de magos del sureste del Bosque de Argénteos.",

	-- Step 8: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "En un estante de la botica de {area:159}.",

	-- Step 9: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "Bajando las escaleras de {area:443}, en el norte de {zone:1439}.",

	-- Step 10: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "Sobre un barril en una tienda de {area:2537}, en el extremo sureste de la zona.",

	-- Step 11: The Barrens
	-- {area:382} Sludge Fen · {object:407566} Goblin Tome (no name in this language: may be words) · {area:392} Ratchet
	["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the {object:407566} beside Gazlowe in {area:392}."] = "Dos libros: el manual en la sala de control, en lo alto de la plataforma petrolera de {area:382}, y el {object:407566} junto a Gazlowe en {area:392}.",

	-- Step 12: The Wailing Caverns' cave
	-- {area:718} Wailing Caverns
	["The {area:718}' cave"] = "La cueva de {area:718}",
	-- {area:387} Lushwater Oasis · {area:718} Wailing Caverns
	["The scrolls lie underground, in the cave below {area:387} by the {area:718} entrance, not inside the dungeon. Go in at the cave mouth in the oasis and follow the cave down; the arrow points at the scrolls from the surface."] = "Los pergaminos están bajo tierra, en la cueva debajo de {area:387}, junto a la entrada de {area:718}, no dentro de la mazmorra. Entra por la boca de la cueva en el oasis y sigue la cueva hacia abajo; la flecha apunta a los pergaminos desde la superficie.",
	-- {area:387} Lushwater Oasis
	["Cave mouth at {area:387}"] = "Boca de la cueva en {area:387}",

	-- Step 13: Orgrimmar
	-- {object:405149} Mural of Ta'zo (no name in this language: may be words) · {object:172961} Valley of Spirits
	["The {object:405149} is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "El {object:405149} es la tabla de piedra apoyada contra la pared en {object:172961}, de camino a los instructores de magos. Úsala para tomar el libro.",

	-- Step 14: The library: first books
	["The library: first books"] = "La biblioteca: primeros libros",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in the books so far. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entrega los libros que llevas. {npc:211033} lleva la biblioteca en lo alto del Sanctasanctórum del Mago, en {object:2101}. Ofrece la misión de cada libro mientras el libro está en tus bolsas: tómala y entrégala, de una en una, para que tu registro de misiones quede libre. Sáltate los libros que no encontraste.",

	-- Step 15: The library: first books (Horde)
	["The library: first books (Horde)"] = "La biblioteca: primeros libros (Horda)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in the books so far. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entrega los libros que llevas. {npc:211022} lleva la biblioteca en {object:36082}. Ofrece la misión de cada libro mientras el libro está en tus bolsas: tómala y entrégala, de una en una, para que tu registro de misiones quede libre. Sáltate los libros que no encontraste.",

	-- Step 16: Friend of the Library
	-- {quest:78150} Friend of the Library · {item:277203} Scholarly Pendant · {item:277204} Erudite's Amulet
	["With 10 different books handed in, the librarian offers {quest:78150}: a choice of two necklaces ({item:277203} or {item:277204}). Take it when it appears."] = "Con 10 libros distintos entregados, el bibliotecario ofrece {quest:78150}: a elegir entre dos collares ({item:277203} o {item:277204}). Tómala cuando aparezca.",

	-- Step 17: Alterac Mountains
	-- {area:1357} Gallows' Corner
	["Inside the first tower of the ogre fort at {area:1357}, in the middle of the zone."] = "Dentro de la primera torre del fuerte ogro de {area:1357}, en medio de la zona.",

	-- Step 18: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "Junto a la entrada de una tienda en el poblado trol del sureste de Arathi.",

	-- Step 19: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "En un banco junto a la entrada de {area:310}, en medio de la zona.",

	-- Step 20: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "Dentro de una cripta cerca del centro de la zona, a la que se llega por el sendero de su sur.",

	-- Step 21: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "En la pasarela superior de {area:1477}, afuera de la mazmorra.",

	-- Step 23: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "Dentro de una choza en la meseta de {area:2097}.",

	-- Step 24: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "En el suelo, en el lado este del campamento múrloc del noreste del Marjal Revolcafango.",

	-- Step 25: The library: second books
	["The library: second books"] = "La biblioteca: segundos libros",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in this part's books. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entrega los libros de esta parte. {npc:211033} lleva la biblioteca en lo alto del Sanctasanctórum del Mago, en {object:2101}. Ofrece la misión de cada libro mientras el libro está en tus bolsas: tómala y entrégala, de una en una, para que tu registro de misiones quede libre. Sáltate los libros que no encontraste.",

	-- Step 26: The library: second books (Horde)
	["The library: second books (Horde)"] = "La biblioteca: segundos libros (Horda)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in this part's books. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entrega los libros de esta parte. {npc:211022} lleva la biblioteca en {object:36082}. Ofrece la misión de cada libro mientras el libro está en tus bolsas: tómala y entrégala, de una en una, para que tu registro de misiones quede libre. Sáltate los libros que no encontraste.",

	-- Step 27: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:281634} Field Researcher's Loop · {item:281635} Philanthropist's Ring
	["From level 20, with 20 different books handed in, {npc:211033} offers {quest:79536}: {item:281634} or {item:281635}."] = "Desde el nivel 20, con 20 libros distintos entregados, {npc:211033} ofrece {quest:79536}: {item:281634} o {item:281635}.",

	-- Step 28: The Hinterlands
	-- {area:353} Shadra'Alor · {zone:1425} The Hinterlands
	["In the troll ruins of {area:353}, in the south of the {zone:1425}."] = "En las ruinas trol de {area:353}, en el sur de {zone:1425}.",

	-- Step 29: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "Sobre una mesa dentro de una tienda cerca del centro de la zona.",

	-- Step 30: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "Dentro de {area:254}, no en una mazmorra: el libro está sobre el altar de la tumba de {npc:8888}, cerca de {npc:14387}. El punto de ruta marca la montaña.",

	-- Step 32: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "Sobre una caja en {area:1236}, en el extremo oeste de {zone:1447}.",

	-- Step 33: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "En una estantería del edificio del medio del campamento pirata de la costa este.",

	-- Step 34: The library: third books
	["The library: third books"] = "La biblioteca: terceros libros",

	-- Step 35: The library: third books (Horde)
	["The library: third books (Horde)"] = "La biblioteca: terceros libros (Horda)",

	-- Step 36: The second Greater Friend of the Library
	-- {quest:79536} Greater Friend of the Library
	["The second {quest:79536}"] = "La segunda {quest:79536}",
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:277254} Truthseeker's Bow · {item:277258} Crest of Elucidation · {item:277260} Researcher's Night Light
	["From level 35, with 25 different books handed in, {npc:211033} offers the second {quest:79536}: {item:277254}, {item:277258} or {item:277260} (level 40 to equip)."] = "Desde el nivel 35, con 25 libros distintos entregados, {npc:211033} ofrece la segunda {quest:79536}: {item:277254}, {item:277258} o {item:277260} (nivel 40 para equipar).",

	-- Step 37: Level 60 books: Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Level 60 books: {zone:1422}"] = "Libros de nivel 60: {zone:1422}",
	-- {item:228141} Necromancy 101 · {area:2298} Caer Darrow · {area:2057} Scholomance · {item:228132} Undead Potatoes · {area:199} Felstone Field
	["Eight more books lie in level 55-60 zones; the mage trainers beside the librarians take them, not the librarians. {item:228141} lies on a table in the ruined keep on {area:2298}, above {area:2057} (outside the dungeon); {item:228132} at {area:199}."] = "Ocho libros más están en zonas de nivel 55-60; los aceptan los instructores de magos junto a los bibliotecarios, no los bibliotecarios. {item:228141} está sobre una mesa en la torre en ruinas de {area:2298}, encima de {area:2057} (afuera de la mazmorra); {item:228132} en {area:199}.",

	-- Step 38: Level 60 books: Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Level 60 books: {zone:1423}"] = "Libros de nivel 60: {zone:1423}",
	-- {item:228135} A Study of the Light · {area:2268} Light's Hope Chapel · {item:228138} The Knight and the Lady · {area:2264} Corin's Crossing · {area:2279} Stratholme · {item:228140} Scourge: Undead Menace or Misunderstood? · {area:2277} Plaguewood
	["{item:228135} is inside {area:2268}. {item:228138} lies at {area:2264}; other copies lie elsewhere in the zone (one by the {area:2279} gates), and you can take only one. {item:228140} is on a table in {area:2277}: wait for the patrolling elite to clear the creatures beside it and walk on."] = "{item:228135} está dentro de {area:2268}. {item:228138} está en {area:2264}; hay otras copias en otros lugares de la zona (una junto a las puertas de {area:2279}), y solo puedes tomar una. {item:228140} está sobre una mesa en {area:2277}: espera a que el élite que patrulla despeje las criaturas de al lado y sigue.",

	-- Step 39: Level 60 books: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Level 60 books: {area:1769}"] = "Libros de nivel 60: {area:1769}",
	-- {item:228134} Northern Kalimdor - A Comprehensive Guide · {area:1769} Timbermaw Hold · {zone:1448} Felwood · {zone:1452} Winterspring
	["{item:228134} lies inside the {area:1769} tunnel between {zone:1448} and {zone:1452}."] = "{item:228134} está dentro del túnel de {area:1769}, entre {zone:1448} y {zone:1452}.",

	-- Step 40: Level 60 books: Everlook
	-- {area:2255} Everlook
	["Level 60 books: {area:2255}"] = "Libros de nivel 60: {area:2255}",
	-- {item:228136} Ka-Boom! · {area:2255} Everlook
	["{item:228136} sits on a shelf behind the alchemy supplier in {area:2255}."] = "{item:228136} está en un estante detrás del proveedor de alquimia de {area:2255}.",

	-- Step 41: Level 60 books: Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Level 60 books: {area:254}"] = "Libros de nivel 60: {area:254}",
	-- {item:228133} Magma or Lava? · {area:254} Blackrock Mountain · {area:1584} Blackrock Depths · {area:2717} Molten Core
	["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver. The waypoint marks the mountain."] = "{item:228133} está dentro de {area:254}, en el pasaje de la mina hacia {area:1584}, más allá del que da la misión de {area:2717}. El punto de ruta marca la montaña.",

	-- Step 42: The level 60 books: Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["The level 60 books: {npc:5497}"] = "Los libros de nivel 60: {npc:5497}",
	-- {npc:5497} Jennea Cannon · {npc:211033} Garion Wendell · {item:228132} Undead Potatoes · {item:228138} The Knight and the Lady · {item:228140} Scourge: Undead Menace or Misunderstood?
	["{npc:5497}, the mage trainer beside {npc:211033} in the Wizard's Sanctum, takes the level 60 books: she offers each book's quest while the book is in your bags. Hand in {item:228132}, {item:228138} and {item:228140} the same way (their quests are not in Polestar's data yet)."] = "{npc:5497}, la instructora de magos junto a {npc:211033} en el Sanctasanctórum del Mago, acepta los libros de nivel 60: ofrece la misión de cada libro mientras el libro está en tus bolsas. Entrega {item:228132}, {item:228138} y {item:228140} de la misma forma (sus misiones todavía no están en los datos de Polestar).",

	-- Step 43: The level 60 books: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe
	["The level 60 books: {npc:7825}"] = "Los libros de nivel 60: {npc:7825}",
	-- {npc:7825} Oran Snakewrithe · {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["{npc:7825}, beside {npc:211022} in the {object:36082}, takes the level 60 books: each book's quest is offered while the book is in your bags. Take and hand them in one at a time (Polestar cannot track these quests for the Horde yet)."] = "{npc:7825}, junto a {npc:211022} en {object:36082}, acepta los libros de nivel 60: ofrece la misión de cada libro mientras el libro está en tus bolsas. Tómalas y entrégalas de una en una (Polestar todavía no puede seguir estas misiones para la Horda).",
}
