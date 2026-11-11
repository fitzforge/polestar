-- French (frFR): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386691} Library Book
	["Library Books"] = "Livres de la bibliothèque",
	["Lost books and scrolls all over the world: each pays experience at the library, and 10, 20 and 25 of them earn a necklace, a ring and an off-hand."] = "Des livres et parchemins perdus aux quatre coins du monde : chacun rapporte de l'expérience à la bibliothèque, et 10, 20 et 25 d'entre eux vous valent un collier, un anneau et un objet tenu en main gauche.",

	-- Step 1: Elwynn Forest
	-- {area:91} Tower of Azora · {area:87} Goldshire
	["Halfway up the {area:91}, east of {area:87}. Nothing hostile inside."] = "À mi-hauteur de {area:91}, à l'est de {area:87}. Rien d'hostile à l'intérieur.",

	-- Step 2: Westfall
	-- {area:20} Moonbrook · {area:108} Sentinel Hill
	["Two books: one in a house at {area:20}, one at {area:108} (Alliance only)."] = "Deux livres : l'un dans une maison de {area:20}, l'autre à {area:108} (Alliance uniquement).",
	["Rumi of Gnomeregan"] = "Rumi de Gnomeregan",

	-- Step 3: Duskwood
	-- {area:2098} Dawning Wood Catacombs · {zone:1431} Duskwood
	["The spellbook lies in the {area:2098}, the crypt in north-western {zone:1431}. Undead fill it; a corpse run works if you are low."] = "Le grimoire se trouve dans {area:2098}, la crypte au nord-ouest de {zone:1431}. Elle est remplie de morts-vivants ; si votre niveau est bas, un aller-retour en fantôme fait l'affaire.",

	-- Step 5: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "Des parchemins dans la grotte des ogres Mo'grosh, au nord-est. Les ogres de la grotte sont des élites de niveau 18-19 : il est conseillé de se grouper. (Rumi de Gnomeregan se trouve aussi à {area:144}, si vous l'avez manqué à {area:108}.)",

	-- Step 6: Wetlands
	-- {area:118} Whelgar's Excavation Site · {zone:1437} Wetlands
	["At {area:118}, the dig in the middle of the {zone:1437}."] = "À {area:118}, le chantier de fouilles au milieu de la zone ({zone:1437}).",

	-- Step 7: Silverpine Forest
	-- {area:233} Ambermill
	["At {area:233}, the mage village in south-eastern Silverpine."] = "À {area:233}, le village de mages au sud-est de la forêt des Pins-Argentés.",

	-- Step 8: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "Sur une étagère de la boutique d'apothicaire de {area:159}.",

	-- Step 9: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "En bas des escaliers de {area:443}, dans le nord de {zone:1439}.",

	-- Step 10: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "Sur un tonneau dans une tente de {area:2537}, tout au sud-est de la zone.",

	-- Step 11: The Barrens
	-- {area:382} Sludge Fen · {object:407566} Goblin Tome (no name in this language: may be words) · {area:392} Ratchet
	["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the {object:407566} beside Gazlowe in {area:392}."] = "",

	-- Step 12: The Wailing Caverns' cave
	-- {area:718} Wailing Caverns
	["The {area:718}' cave"] = "La grotte de {area:718}",
	-- {area:387} Lushwater Oasis · {area:718} Wailing Caverns
	["The scrolls lie underground, in the cave below {area:387} by the {area:718} entrance, not inside the dungeon. Go in at the cave mouth in the oasis and follow the cave down; the arrow points at the scrolls from the surface."] = "Les parchemins se trouvent sous terre, dans la grotte sous {area:387} près de l'entrée de {area:718}, pas dans le donjon. Entrez par l'entrée de la grotte dans l'oasis et descendez la grotte ; la flèche indique les parchemins depuis la surface.",
	-- {area:387} Lushwater Oasis
	["Cave mouth at {area:387}"] = "Entrée de la grotte à {area:387}",

	-- Step 13: Orgrimmar
	-- {object:405149} Mural of Ta'zo (no name in this language: may be words) · {object:172961} Valley of Spirits
	["The {object:405149} is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "Le {object:405149} est la tablette de pierre appuyée contre le mur dans {object:172961}, sur le chemin des maîtres des mages. Utilisez-la pour prendre le livre.",

	-- Step 14: The library: first books
	["The library: first books"] = "La bibliothèque : premiers livres",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in the books so far. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Rendez les livres trouvés jusqu'ici. {npc:211033} tient la bibliothèque au sommet du Sanctum des sorciers, dans {object:2101}. Il propose la quête de chaque livre tant que le livre est dans vos sacs : acceptez-la et rendez-la, une à la fois, pour garder votre journal de quêtes libre. Ignorez les livres que vous n'avez pas trouvés.",

	-- Step 15: The library: first books (Horde)
	["The library: first books (Horde)"] = "La bibliothèque : premiers livres (Horde)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in the books so far. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Rendez les livres trouvés jusqu'ici. {npc:211022} tient la bibliothèque dans {object:36082}. Il propose la quête de chaque livre tant que le livre est dans vos sacs : acceptez-la et rendez-la, une à la fois, pour garder votre journal de quêtes libre. Ignorez les livres que vous n'avez pas trouvés.",

	-- Step 16: Friend of the Library
	-- {quest:78150} Friend of the Library · {item:277203} Scholarly Pendant · {item:277204} Erudite's Amulet
	["With 10 different books handed in, the librarian offers {quest:78150}: a choice of two necklaces ({item:277203} or {item:277204}). Take it when it appears."] = "Une fois 10 livres différents rendus, le bibliothécaire propose {quest:78150} : un choix entre deux colliers ({item:277203} ou {item:277204}). Acceptez-la quand elle apparaît.",

	-- Step 17: Alterac Mountains
	-- {area:1357} Gallows' Corner
	["Inside the first tower of the ogre fort at {area:1357}, in the middle of the zone."] = "Dans la première tour du fort des ogres de {area:1357}, au milieu de la zone.",

	-- Step 18: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "À côté de l'entrée d'une tente du village troll, au sud-est d'Arathi.",

	-- Step 19: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "Sur un banc à côté de l'entrée de {area:310}, au milieu de la zone.",

	-- Step 20: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "Dans une crypte près du centre de la zone, accessible par le sentier au sud.",

	-- Step 21: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "Sur la passerelle supérieure de {area:1477}, à l'extérieur du donjon.",

	-- Step 23: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "Dans une hutte sur le plateau de {area:2097}.",

	-- Step 24: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "Au sol, du côté est du camp murloc au nord-est du marécage d'Âprefange.",

	-- Step 25: The library: second books
	["The library: second books"] = "La bibliothèque : deuxièmes livres",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in this part's books. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Rendez les livres de cette partie. {npc:211033} tient la bibliothèque au sommet du Sanctum des sorciers, dans {object:2101}. Il propose la quête de chaque livre tant que le livre est dans vos sacs : acceptez-la et rendez-la, une à la fois, pour garder votre journal de quêtes libre. Ignorez les livres que vous n'avez pas trouvés.",

	-- Step 26: The library: second books (Horde)
	["The library: second books (Horde)"] = "La bibliothèque : deuxièmes livres (Horde)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in this part's books. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Rendez les livres de cette partie. {npc:211022} tient la bibliothèque dans {object:36082}. Il propose la quête de chaque livre tant que le livre est dans vos sacs : acceptez-la et rendez-la, une à la fois, pour garder votre journal de quêtes libre. Ignorez les livres que vous n'avez pas trouvés.",

	-- Step 27: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:281634} Field Researcher's Loop · {item:281635} Philanthropist's Ring
	["From level 20, with 20 different books handed in, {npc:211033} offers {quest:79536}: {item:281634} or {item:281635}."] = "À partir du niveau 20, une fois 20 livres différents rendus, {npc:211033} propose {quest:79536} : {item:281634} ou {item:281635}.",

	-- Step 28: The Hinterlands
	-- {area:353} Shadra'Alor · {zone:1425} The Hinterlands
	["In the troll ruins of {area:353}, in the south of the {zone:1425}."] = "Dans les ruines trolls de {area:353}, dans le sud de la zone ({zone:1425}).",

	-- Step 29: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "Sur une table dans une tente près du centre de la zone.",

	-- Step 30: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "Dans {area:254}, pas dans un donjon : le livre repose sur l'autel du tombeau de {npc:8888}, près de {npc:14387}. Le point de passage marque la montagne.",

	-- Step 32: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "Sur une caisse dans {area:1236}, tout à l'ouest d'{zone:1447}.",

	-- Step 33: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "Sur une bibliothèque dans le bâtiment central du camp pirate de la côte est.",

	-- Step 34: The library: third books
	["The library: third books"] = "La bibliothèque : troisièmes livres",

	-- Step 35: The library: third books (Horde)
	["The library: third books (Horde)"] = "La bibliothèque : troisièmes livres (Horde)",

	-- Step 36: The second Greater Friend of the Library
	-- {quest:79536} Greater Friend of the Library
	["The second {quest:79536}"] = "La deuxième {quest:79536}",
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:277254} Truthseeker's Bow · {item:277258} Crest of Elucidation · {item:277260} Researcher's Night Light
	["From level 35, with 25 different books handed in, {npc:211033} offers the second {quest:79536}: {item:277254}, {item:277258} or {item:277260} (level 40 to equip)."] = "À partir du niveau 35, une fois 25 livres différents rendus, {npc:211033} propose la deuxième {quest:79536} : {item:277254}, {item:277258} ou {item:277260} (niveau 40 pour l'équiper).",

	-- Step 37: Level 60 books: Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Level 60 books: {zone:1422}"] = "Livres de niveau 60 : {zone:1422}",
	-- {item:228141} Necromancy 101 · {area:2298} Caer Darrow · {area:2057} Scholomance · {item:228132} Undead Potatoes · {area:199} Felstone Field
	["Eight more books lie in level 55-60 zones; the mage trainers beside the librarians take them, not the librarians. {item:228141} lies on a table in the ruined keep on {area:2298}, above {area:2057} (outside the dungeon); {item:228132} at {area:199}."] = "Huit autres livres se trouvent dans des zones de niveau 55-60 ; ce sont les maîtres des mages à côté des bibliothécaires qui les prennent, pas les bibliothécaires. {item:228141} est posé sur une table du donjon en ruine de {area:2298}, au-dessus de {area:2057} (hors du donjon) ; {item:228132} à {area:199}.",

	-- Step 38: Level 60 books: Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Level 60 books: {zone:1423}"] = "Livres de niveau 60 : {zone:1423}",
	-- {item:228135} A Study of the Light · {area:2268} Light's Hope Chapel · {item:228138} The Knight and the Lady · {area:2264} Corin's Crossing · {area:2279} Stratholme · {item:228140} Scourge: Undead Menace or Misunderstood? · {area:2277} Plaguewood
	["{item:228135} is inside {area:2268}. {item:228138} lies at {area:2264}; other copies lie elsewhere in the zone (one by the {area:2279} gates), and you can take only one. {item:228140} is on a table in {area:2277}: wait for the patrolling elite to clear the creatures beside it and walk on."] = "{item:228135} se trouve dans {area:2268}. {item:228138} se trouve à {area:2264} ; d'autres exemplaires sont ailleurs dans la zone (un près des portes de {area:2279}), et vous ne pouvez en prendre qu'un. {item:228140} est sur une table à {area:2277} : attendez que l'élite qui patrouille élimine les créatures à côté et poursuive son chemin.",

	-- Step 39: Level 60 books: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Level 60 books: {area:1769}"] = "Livres de niveau 60 : {area:1769}",
	-- {item:228134} Northern Kalimdor - A Comprehensive Guide · {area:1769} Timbermaw Hold · {zone:1448} Felwood · {zone:1452} Winterspring
	["{item:228134} lies inside the {area:1769} tunnel between {zone:1448} and {zone:1452}."] = "{item:228134} se trouve dans le tunnel de {area:1769}, entre {zone:1448} et {zone:1452}.",

	-- Step 40: Level 60 books: Everlook
	-- {area:2255} Everlook
	["Level 60 books: {area:2255}"] = "Livres de niveau 60 : {area:2255}",
	-- {item:228136} Ka-Boom! · {area:2255} Everlook
	["{item:228136} sits on a shelf behind the alchemy supplier in {area:2255}."] = "{item:228136} est posé sur une étagère derrière le fournisseur d'alchimie de {area:2255}.",

	-- Step 41: Level 60 books: Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Level 60 books: {area:254}"] = "Livres de niveau 60 : {area:254}",
	-- {item:228133} Magma or Lava? · {area:254} Blackrock Mountain · {area:1584} Blackrock Depths · {area:2717} Molten Core
	["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver. The waypoint marks the mountain."] = "",

	-- Step 42: The level 60 books: Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["The level 60 books: {npc:5497}"] = "Les livres de niveau 60 : {npc:5497}",
	-- {npc:5497} Jennea Cannon · {npc:211033} Garion Wendell · {item:228132} Undead Potatoes · {item:228138} The Knight and the Lady · {item:228140} Scourge: Undead Menace or Misunderstood?
	["{npc:5497}, the mage trainer beside {npc:211033} in the Wizard's Sanctum, takes the level 60 books: she offers each book's quest while the book is in your bags. Hand in {item:228132}, {item:228138} and {item:228140} the same way (their quests are not in Polestar's data yet)."] = "{npc:5497}, la maîtresse des mages à côté de {npc:211033} dans le Sanctum des sorciers, prend les livres de niveau 60 : elle propose la quête de chaque livre tant que le livre est dans vos sacs. Rendez {item:228132}, {item:228138} et {item:228140} de la même façon (leurs quêtes ne sont pas encore dans les données de Polestar).",

	-- Step 43: The level 60 books: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe
	["The level 60 books: {npc:7825}"] = "Les livres de niveau 60 : {npc:7825}",
	-- {npc:7825} Oran Snakewrithe · {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["{npc:7825}, beside {npc:211022} in the {object:36082}, takes the level 60 books: each book's quest is offered while the book is in your bags. Take and hand them in one at a time (Polestar cannot track these quests for the Horde yet)."] = "{npc:7825}, à côté de {npc:211022} dans {object:36082}, prend les livres de niveau 60 : la quête de chaque livre est proposée tant que le livre est dans vos sacs. Acceptez-les et rendez-les une à la fois (Polestar ne peut pas encore suivre ces quêtes pour la Horde).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the Goblin Tome beside Gazlowe in {area:392}."] = "Deux livres : le manuel dans la salle de contrôle au sommet de la plateforme pétrolière de {area:382}, et le tome gobelin à côté de Gazlowe à {area:392}.",
	-- ["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver; its quest is for mages only. The waypoint marks the mountain."] = "{item:228133} se trouve dans {area:254}, dans le passage de la mine vers {area:1584}, après le donneur de quête de {area:2717} ; sa quête est réservée aux mages. Le point de passage marque la montagne.",
}
