-- German (deDE): the guide forever/class/warlock/imp-alliance (forever/class/warlock/imp-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Alliance)"] = "Wichtel (Allianz)",
	["Your first demon at level 1-4: the imp, from your start zone's warlock trainer."] = "Dein erster Dämon auf Stufe 1-4: der Wichtel, vom Hexenmeisterlehrer deines Startgebiets.",

	-- Step 1: Drusilla La Salle (Humans)
	-- {npc:459} Drusilla La Salle
	["{npc:459} (Humans)"] = "{npc:459} (Menschen)",
	-- {item:9576} Tainted Letter · {npc:197} Marshal McBride · {npc:459} Drusilla La Salle · {area:24} Northshire Abbey
	["Your first letter ({item:9576}, from {npc:197} after Kobold Camp Cleanup) points you to {npc:459}, the warlock trainer in the little graveyard beside {area:24}. She asks for a book the Defias stole."] = "Dein erster Brief ({item:9576}, von {npc:197} nach Kobold Camp Cleanup) schickt dich zu {npc:459}, der Hexenmeisterlehrerin auf dem kleinen Friedhof neben {area:24}. Sie verlangt ein Buch, das die Defias gestohlen haben.",

	-- Step 2: The Stolen Books
	-- {object:83763} Stolen Books
	["The {object:83763}"] = "{object:83763}",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["The Defias tent stands in the vineyard east of the Abbey. The book is small: it lies on the ground just right of the tent's opening, beside a blue jug. Three Defias Thugs (level 3-4) guard the tent; pull them one at a time, or step inside the tent and click the book, where they cannot reach you. The book respawns three minutes after someone takes it."] = "Das Defias-Zelt steht im Weinberg östlich der Abtei. Das Buch ist klein: Es liegt auf dem Boden direkt rechts der Zeltöffnung, neben einem blauen Krug. Drei Defias Thugs (Stufe 3-4) bewachen das Zelt; pull sie einzeln, oder geh ins Zelt hinein und klicke das Buch an, wo sie dich nicht erreichen. Das Buch respawnt drei Minuten, nachdem jemand es genommen hat.",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}, from the {object:83763}"] = "{item:6785}, aus {object:83763}",

	-- Step 3: Summon Imp
	-- {npc:459} Drusilla La Salle · {spell:688} Summon Imp
	["{npc:459} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:459} bringt dir bei der Abgabe {spell:688} bei: Beschwöre ihn sofort, er kostet nichts und kämpft an deiner Seite.",

	-- Step 4: Alamar Grimm (Gnomes)
	-- {npc:460} Alamar Grimm
	["{npc:460} (Gnomes)"] = "{npc:460} (Gnome)",
	-- {item:9577} Tainted Memorandum · {npc:658} Sten Stoutarm · {npc:460} Alamar Grimm · {area:77} Anvilmar
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Your first letter ({item:9577}, from {npc:658} after Dwarven Outfitters) points you to {npc:460}, the warlock trainer upstairs inside {area:77}. He asks for three Feather Charms."] = "Dein erster Brief ({item:9577}, von {npc:658} nach Dwarven Outfitters) schickt dich zu {npc:460}, dem Hexenmeisterlehrer im Obergeschoss von {area:77}. Er verlangt drei Feather Charms.",

	-- Step 5: Feather Charms
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Feather Charms"] = "Feather Charms",
	-- {area:77} Anvilmar · {area:132} Coldridge Valley
	-- plural, as words: Frostmane Novices = {npc:946} Frostmane Novice
	["The Frostmane Novices (level 3-4) sit at the back of the troll cave south of {area:77}, near Grek'nir the Cold by the icy pool: take the left tunnel past the entrance. Four kills in five drop a charm, but only two or three novices spawn, so you may wait out their three-minute respawn. They throw frostbolts from range; the Troll Whelps at the cave mouth jump anyone who passes. With the charms, your hearthstone takes you straight back: a new character's is set to {area:132}."] = "Die Frostmane Novices (Stufe 3-4) sitzen hinten in der Trollhöhle südlich von {area:77}, nahe Grek'nir the Cold am eisigen Teich: Nimm den linken Tunnel hinter dem Eingang. Vier von fünf Kills lassen einen Charm fallen, aber es spawnen nur zwei oder drei Novices, du musst also vielleicht ihren Respawn von drei Minuten abwarten. Sie werfen Frostblitze aus der Distanz; die Troll Whelps am Höhleneingang greifen jeden an, der vorbeikommt. Mit den Charms bringt dich dein Ruhestein direkt zurück: Der eines neuen Charakters ist auf {area:132} gesetzt.",

	-- Step 6: Summon Imp
	-- {npc:460} Alamar Grimm · {spell:688} Summon Imp
	["{npc:460} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:460} bringt dir bei der Abgabe {spell:688} bei: Beschwöre ihn sofort, er kostet nichts und kämpft an deiner Seite.",
}
