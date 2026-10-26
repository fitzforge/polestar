-- German (deDE): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386691} Library Book
	["Library Books"] = "Bibliotheksbücher",
	-- {quest:78150} Friend of the Library
	["Lost books and scrolls all over the world: each pays experience at the library, and enough of them earn a {quest:78150} reward."] = "Verlorene Bücher und Schriftrollen überall auf der Welt: Jedes bringt in der Bibliothek Erfahrung, und genug davon verdienen eine Belohnung von {quest:78150}.",

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

	-- Step 4: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "Auf einer Bank neben dem Eingang der {area:310}, mitten im Gebiet.",

	-- Step 5: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "Auf dem obersten Laufsteg des {area:1477}, vor dem Dungeon.",

	-- Step 7: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "Innerhalb von {area:254}, nicht in einem Dungeon: Das Buch liegt auf dem Altar im Grab von {npc:8888}, nahe {npc:14387}. Der Wegpunkt markiert den Berg.",

	-- Step 8: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "Auf einem Tisch in einem Zelt nahe der Mitte des Gebiets.",

	-- Step 9: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "In einer Gruft nahe der Mitte des Gebiets, erreichbar über den Pfad südlich davon.",

	-- Step 10: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "Schriftrollen in der Höhle der Mo'grosh-Oger im Nordosten. Die Oger in der Höhle sind Elites der Stufe 18-19: Eine Gruppe wird empfohlen. (Rumi of Gnomeregan liegt auch in {area:144}, falls du es bei {area:108} verpasst hast.)",

	-- Step 13: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "Neben einem Zelteingang im Trolldorf im Südosten von Arathi.",

	-- Step 17: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "Auf einem Regal in der Apotheke von {area:159}.",

	-- Step 18: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "Die Treppe hinunter bei den {area:443} im Norden von {zone:1439}.",

	-- Step 19: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "Auf einer Kiste im {area:1236}, im äußersten Westen von {zone:1447}.",

	-- Step 20: Orgrimmar
	-- {object:172961} Valley of Spirits
	["The Mural of Ta'zo is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "Das Wandgemälde von Ta'zo ist die Steintafel, die im {object:172961} an der Wand lehnt, auf dem Weg zu den Magierlehrern. Benutze es, um das Buch zu nehmen.",

	-- Step 21: The Barrens
	-- {area:718} Wailing Caverns · {area:382} Sludge Fen · {area:392} Ratchet
	["Three books: scrolls outside the {area:718} entrance, the manual in the control room at the top of the oil rig at the {area:382}, and the Goblin Tome beside Gazlowe in {area:392}."] = "Drei Bücher: Schriftrollen vor dem Eingang der {area:718}, das Handbuch im Kontrollraum oben auf der Ölbohrinsel am {area:382} und der Goblin-Wälzer neben Gazlowe in {area:392}.",

	-- Step 22: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "Auf einem Fass in einem Zelt bei {area:2537}, im äußersten Südosten des Gebiets.",

	-- Step 24: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "In einer Hütte auf dem Plateau {area:2097}.",

	-- Step 25: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "Auf dem Boden an der Ostseite des Murlocs-Lagers im Nordosten der Düstermarschen.",

	-- Step 26: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "In einem Bücherregal im mittleren Gebäude des Piratenlagers an der Ostküste.",

	-- Step 27: Garion Wendell
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["{npc:211033} keeps the library in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "{npc:211033} führt die Bibliothek im {object:2101}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",

	-- Step 28: Owen Thadd
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["{npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "{npc:211022} führt die Bibliothek im {object:36082}. Er bietet die Quest jedes Buchs an, solange das Buch in deinen Taschen ist: Nimm sie an und gib sie ab, eine nach der anderen, damit dein Questlog frei bleibt. Überspringe die Bücher, die du nicht gefunden hast.",

	-- Step 29: Friend of the Library
	-- {quest:78150} Friend of the Library
	["Once enough books are in, the librarian offers {quest:78150}. Take it when it appears."] = "Sind genug Bücher abgegeben, bietet der Bibliothekar {quest:78150} an. Nimm sie an, wenn sie erscheint.",

	-- Step 30: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library
	["From level 20, with more books handed in, {npc:211033} offers {quest:79536}."] = "Ab Stufe 20 bietet {npc:211033} mit weiteren abgegebenen Büchern {quest:79536} an.",

	-- Step 31: The second Greater Friend of the Library
	-- {quest:82208} Greater Friend of the Library
	["The second {quest:82208}"] = "Die zweite {quest:82208}",
	-- {npc:211033} Garion Wendell · {quest:82208} Greater Friend of the Library
	["From level 30, with more books still, {npc:211033} offers the second {quest:82208}."] = "Ab Stufe 30 bietet {npc:211033} mit noch mehr Büchern die zweite {quest:82208} an.",
}
