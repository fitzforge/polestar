-- German (deDE): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386691} Library Book
	["Library Books"] = "Bibliotheksbücher",
	["Lost books and scrolls all over the world: each pays experience at the library, and 10, 20 and 25 of them earn a necklace, a ring and an off-hand."] = "Verlorene Bücher und Schriftrollen überall auf der Welt: Jedes bringt in der Bibliothek Erfahrung, und 10, 20 und 25 davon bringen eine Halskette, einen Ring und eine Nebenhand.",

	-- Step 1: Elwynn Forest
	-- {area:91} Tower of Azora · {area:87} Goldshire
	["Halfway up the {area:91}, east of {area:87}. Nothing hostile inside."] = "Auf halber Höhe im {area:91}, östlich von {area:87}. Nichts Feindliches im Inneren.",

	-- Step 2: Westfall
	-- {area:20} Moonbrook · {area:108} Sentinel Hill
	["Two books: one in a house at {area:20}, one at {area:108} (Alliance only)."] = "Zwei Bücher: eines in einem Haus bei {area:20}, eines bei {area:108} (nur Allianz).",
	["Rumi of Gnomeregan"] = "Rumi of Gnomeregan",

	-- Step 3: Duskwood
	-- {area:2098} Dawning Wood Catacombs · {zone:1431} Duskwood
	["The spellbook lies in the {area:2098}, the crypt in north-western {zone:1431}. Undead fill it; a corpse run works if you are low."] = "Das Zauberbuch liegt in den {area:2098}, der Gruft im Nordwesten von {zone:1431}. Untote füllen sie; ein Leichenlauf funktioniert, wenn du wenig Leben hast.",

	-- Step 5: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "Schriftrollen in der Höhle der Mo'grosh-Oger im Nordosten. Die Oger in der Höhle sind Elites der Stufe 18-19: Eine Gruppe wird empfohlen. (Rumi of Gnomeregan liegt auch in {area:144}, falls du es bei {area:108} verpasst hast.)",

	-- Step 6: Wetlands
	-- {area:118} Whelgar's Excavation Site · {zone:1437} Wetlands
	["At {area:118}, the dig in the middle of the {zone:1437}."] = "Bei {area:118}, der Grabungsstätte mitten in den {zone:1437}.",

	-- Step 7: Silverpine Forest
	-- {area:233} Ambermill
	["At {area:233}, the mage village in south-eastern Silverpine."] = "Bei {area:233}, dem Magierdorf im Südosten des Silberwalds.",

	-- Step 8: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "Auf einem Regal in der Apotheke von {area:159}.",

	-- Step 9: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "Die Treppe hinunter bei den {area:443} im Norden von {zone:1439}.",

	-- Step 10: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "Auf einem Fass in einem Zelt bei {area:2537}, im äußersten Südosten des Gebiets.",

	-- Step 11: The Barrens
	-- {area:382} Sludge Fen · {object:407566} Goblin Tome (no name in this language: may be words) · {area:392} Ratchet
	["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the {object:407566} beside Gazlowe in {area:392}."] = "Zwei Bücher: das Handbuch im Kontrollraum oben auf der Ölplattform im {area:382} und der {object:407566} neben Gazlowe in {area:392}.",

	-- Step 12: The Wailing Caverns' cave
	-- {area:718} Wailing Caverns
	["The {area:718}' cave"] = "Die Höhle der {area:718}",
	-- {area:387} Lushwater Oasis · {area:718} Wailing Caverns
	["The scrolls lie underground, in the cave below {area:387} by the {area:718} entrance, not inside the dungeon. Go in at the cave mouth in the oasis and follow the cave down; the arrow points at the scrolls from the surface."] = "Die Schriftrollen liegen unterirdisch, in der Höhle unter {area:387} beim Eingang der {area:718}, nicht im Dungeon selbst. Geh am Höhleneingang in der Oase hinein und folge der Höhle nach unten; der Pfeil zeigt von der Oberfläche auf die Schriftrollen.",
	-- {area:387} Lushwater Oasis
	["Cave mouth at {area:387}"] = "Höhleneingang bei {area:387}",

	-- Step 13: Orgrimmar
	-- {object:405149} Mural of Ta'zo (no name in this language: may be words) · {object:172961} Valley of Spirits
	["The {object:405149} is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "Der {object:405149} ist die Steintafel, die im {object:172961} an der Wand lehnt, auf dem Weg zu den Magierlehrern. Benutze sie, um das Buch zu nehmen.",

	-- Step 14: The library: first books
	["The library: first books"] = "Die Bibliothek: erste Bücher",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in the books so far. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Gib die bisherigen Bücher ab. {npc:211033} führt die Bibliothek oben im Wizard's Sanctum im {object:2101}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",

	-- Step 15: The library: first books (Horde)
	["The library: first books (Horde)"] = "Die Bibliothek: erste Bücher (Horde)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in the books so far. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Gib die bisherigen Bücher ab. {npc:211022} führt die Bibliothek im {object:36082}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",

	-- Step 16: Friend of the Library
	-- {quest:78150} Friend of the Library · {item:277203} Scholarly Pendant · {item:277204} Erudite's Amulet
	["With 10 different books handed in, the librarian offers {quest:78150}: a choice of two necklaces ({item:277203} or {item:277204}). Take it when it appears."] = "Wenn du 10 verschiedene Bücher abgegeben hast, bietet der Bibliothekar {quest:78150} an: eine Auswahl aus zwei Halsketten ({item:277203} oder {item:277204}). Nimm sie an, sobald sie erscheint.",

	-- Step 17: Alterac Mountains
	-- {area:1357} Gallows' Corner
	["Inside the first tower of the ogre fort at {area:1357}, in the middle of the zone."] = "Im ersten Turm der Ogerfestung bei {area:1357}, in der Mitte der Zone.",

	-- Step 18: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "Neben einem Zelteingang im Trolldorf im Südosten von Arathi.",

	-- Step 19: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "Auf einer Bank neben dem Eingang der {area:310}, mitten im Gebiet.",

	-- Step 20: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "In einer Gruft nahe der Mitte des Gebiets, erreichbar über den Pfad südlich davon.",

	-- Step 21: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "Auf dem obersten Laufsteg des {area:1477}, vor dem Dungeon.",

	-- Step 23: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "In einer Hütte auf dem Plateau {area:2097}.",

	-- Step 24: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "Auf dem Boden an der Ostseite des Murlocs-Lagers im Nordosten der Düstermarschen.",

	-- Step 25: The library: second books
	["The library: second books"] = "Die Bibliothek: zweite Bücher",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in this part's books. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Gib die Bücher dieses Abschnitts ab. {npc:211033} führt die Bibliothek oben im Wizard's Sanctum im {object:2101}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",

	-- Step 26: The library: second books (Horde)
	["The library: second books (Horde)"] = "Die Bibliothek: zweite Bücher (Horde)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in this part's books. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Gib die Bücher dieses Abschnitts ab. {npc:211022} führt die Bibliothek im {object:36082}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",

	-- Step 27: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:281634} Field Researcher's Loop · {item:281635} Philanthropist's Ring
	["From level 20, with 20 different books handed in, {npc:211033} offers {quest:79536}: {item:281634} or {item:281635}."] = "Ab Stufe 20, mit 20 abgegebenen verschiedenen Büchern, bietet {npc:211033} {quest:79536} an: {item:281634} oder {item:281635}.",

	-- Step 28: The Hinterlands
	-- {area:353} Shadra'Alor · {zone:1425} The Hinterlands
	["In the troll ruins of {area:353}, in the south of the {zone:1425}."] = "In den Trollruinen von {area:353}, im Süden der {zone:1425}.",

	-- Step 29: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "Auf einem Tisch in einem Zelt nahe der Mitte des Gebiets.",

	-- Step 30: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "Innerhalb von {area:254}, nicht in einem Dungeon: Das Buch liegt auf dem Altar im Grab von {npc:8888}, nahe {npc:14387}. Der Wegpunkt markiert den Berg.",

	-- Step 32: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "Auf einer Kiste im {area:1236}, im äußersten Westen von {zone:1447}.",

	-- Step 33: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "In einem Bücherregal im mittleren Gebäude des Piratenlagers an der Ostküste.",

	-- Step 34: The library: third books
	["The library: third books"] = "Die Bibliothek: dritte Bücher",

	-- Step 35: The library: third books (Horde)
	["The library: third books (Horde)"] = "Die Bibliothek: dritte Bücher (Horde)",

	-- Step 36: The second Greater Friend of the Library
	-- {quest:79536} Greater Friend of the Library
	["The second {quest:79536}"] = "Die zweite {quest:79536}",
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:277254} Truthseeker's Bow · {item:277258} Crest of Elucidation · {item:277260} Researcher's Night Light
	["From level 35, with 25 different books handed in, {npc:211033} offers the second {quest:79536}: {item:277254}, {item:277258} or {item:277260} (level 40 to equip)."] = "Ab Stufe 35, mit 25 abgegebenen verschiedenen Büchern, bietet {npc:211033} die zweite {quest:79536} an: {item:277254}, {item:277258} oder {item:277260} (zum Anlegen Stufe 40).",

	-- Step 37: Level 60 books: Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Level 60 books: {zone:1422}"] = "Bücher der Stufe 60: {zone:1422}",
	-- {item:228141} Necromancy 101 · {area:2298} Caer Darrow · {area:2057} Scholomance · {item:228132} Undead Potatoes · {area:199} Felstone Field
	["Eight more books lie in level 55-60 zones; the mage trainers beside the librarians take them, not the librarians. {item:228141} lies on a table in the ruined keep on {area:2298}, above {area:2057} (outside the dungeon); {item:228132} at {area:199}."] = "Acht weitere Bücher liegen in Zonen der Stufen 55-60; die Magierlehrer neben den Bibliothekaren nehmen sie an, nicht die Bibliothekare. {item:228141} liegt auf einem Tisch in der zerstörten Festung auf {area:2298}, oberhalb von {area:2057} (außerhalb des Dungeons); {item:228132} bei {area:199}.",

	-- Step 38: Level 60 books: Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Level 60 books: {zone:1423}"] = "Bücher der Stufe 60: {zone:1423}",
	-- {item:228135} A Study of the Light · {area:2268} Light's Hope Chapel · {item:228138} The Knight and the Lady · {area:2264} Corin's Crossing · {area:2279} Stratholme · {item:228140} Scourge: Undead Menace or Misunderstood? · {area:2277} Plaguewood
	["{item:228135} is inside {area:2268}. {item:228138} lies at {area:2264}; other copies lie elsewhere in the zone (one by the {area:2279} gates), and you can take only one. {item:228140} is on a table in {area:2277}: wait for the patrolling elite to clear the creatures beside it and walk on."] = "{item:228135} liegt in {area:2268}. {item:228138} liegt bei {area:2264}; weitere Exemplare liegen anderswo in der Zone (eines bei den Toren von {area:2279}), und du kannst nur eines nehmen. {item:228140} liegt auf einem Tisch in {area:2277}: Warte, bis der patrouillierende Elite die Kreaturen daneben beseitigt hat, und geh weiter.",

	-- Step 39: Level 60 books: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Level 60 books: {area:1769}"] = "Bücher der Stufe 60: {area:1769}",
	-- {item:228134} Northern Kalimdor - A Comprehensive Guide · {area:1769} Timbermaw Hold · {zone:1448} Felwood · {zone:1452} Winterspring
	["{item:228134} lies inside the {area:1769} tunnel between {zone:1448} and {zone:1452}."] = "{item:228134} liegt im Tunnel {area:1769} zwischen {zone:1448} und {zone:1452}.",

	-- Step 40: Level 60 books: Everlook
	-- {area:2255} Everlook
	["Level 60 books: {area:2255}"] = "Bücher der Stufe 60: {area:2255}",
	-- {item:228136} Ka-Boom! · {area:2255} Everlook
	["{item:228136} sits on a shelf behind the alchemy supplier in {area:2255}."] = "{item:228136} steht in einem Regal hinter dem Alchemie-Händler in {area:2255}.",

	-- Step 41: Level 60 books: Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Level 60 books: {area:254}"] = "Bücher der Stufe 60: {area:254}",
	-- {item:228133} Magma or Lava? · {area:254} Blackrock Mountain · {area:1584} Blackrock Depths · {area:2717} Molten Core
	["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver. The waypoint marks the mountain."] = "{item:228133} liegt im {area:254}, im Minengang Richtung {area:1584}, hinter dem Questgeber von {area:2717}. Der Wegpunkt markiert den Berg.",

	-- Step 42: The level 60 books: Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["The level 60 books: {npc:5497}"] = "Die Bücher der Stufe 60: {npc:5497}",
	-- {npc:5497} Jennea Cannon · {npc:211033} Garion Wendell · {item:228132} Undead Potatoes · {item:228138} The Knight and the Lady · {item:228140} Scourge: Undead Menace or Misunderstood?
	["{npc:5497}, the mage trainer beside {npc:211033} in the Wizard's Sanctum, takes the level 60 books: she offers each book's quest while the book is in your bags. Hand in {item:228132}, {item:228138} and {item:228140} the same way (their quests are not in Polestar's data yet)."] = "{npc:5497}, die Magierlehrerin neben {npc:211033} im Wizard's Sanctum, nimmt die Bücher der Stufe 60 an: Sie bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist. Gib {item:228132}, {item:228138} und {item:228140} auf dieselbe Weise ab (ihre Quests sind noch nicht in den Daten von Polestar).",

	-- Step 43: The level 60 books: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe
	["The level 60 books: {npc:7825}"] = "Die Bücher der Stufe 60: {npc:7825}",
	-- {npc:7825} Oran Snakewrithe · {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["{npc:7825}, beside {npc:211022} in the {object:36082}, takes the level 60 books: each book's quest is offered while the book is in your bags. Take and hand them in one at a time (Polestar cannot track these quests for the Horde yet)."] = "{npc:7825}, neben {npc:211022} im {object:36082}, nimmt die Bücher der Stufe 60 an: Die Quest jedes Buchs wird angeboten, solange das Buch in deinen Taschen ist. Nimm sie an und gib sie ab, eine nach der anderen (Polestar kann diese Quests für die Horde noch nicht verfolgen).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["From level 20, with more books handed in, {npc:211033} offers {quest:79536}."] = "Ab Stufe 20 bietet {npc:211033} mit weiteren abgegebenen Büchern {quest:79536} an.",
	-- ["From level 30, with more books still, {npc:211033} offers the second {quest:82208}."] = "Ab Stufe 30 bietet {npc:211033} mit noch mehr Büchern die zweite {quest:82208} an.",
	-- ["Lost books and scrolls all over the world: each pays experience at the library, and enough of them earn a {quest:78150} reward."] = "Verlorene Bücher und Schriftrollen überall auf der Welt: Jedes bringt in der Bibliothek Erfahrung, und genug davon verdienen eine Belohnung von {quest:78150}.",
	-- ["Once enough books are in, the librarian offers {quest:78150}. Take it when it appears."] = "Sind genug Bücher abgegeben, bietet der Bibliothekar {quest:78150} an. Nimm sie an, wenn sie erscheint.",
	-- ["The Mural of Ta'zo is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "Das Wandgemälde von Ta'zo ist die Steintafel, die im {object:172961} an der Wand lehnt, auf dem Weg zu den Magierlehrern. Benutze es, um das Buch zu nehmen.",
	-- ["Three books: scrolls outside the {area:718} entrance, the manual in the control room at the top of the oil rig at the {area:382}, and the Goblin Tome beside Gazlowe in {area:392}."] = "Drei Bücher: Schriftrollen vor dem Eingang der {area:718}, das Handbuch im Kontrollraum oben auf der Ölbohrinsel am {area:382} und der Goblin-Wälzer neben Gazlowe in {area:392}.",
	-- ["{npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "{npc:211022} führt die Bibliothek im {object:36082}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",
	-- ["{npc:211033} keeps the library in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "{npc:211033} führt die Bibliothek im {object:2101}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",
}
