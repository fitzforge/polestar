-- German (deDE): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",

	-- Step 2: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Reite nach Süden aus {zone:1432} durch den Pass ins {zone:1418}; {npc:2860} lagert bei der Ausgrabung.",

	-- Step 3: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} lagert allein in {area:1898}, südöstlich der Ausgrabungsstätte.",

	-- Step 4: Agmond's End
	-- {quest:739} Murdaloc
	["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "Das zerschlagene Skelett liegt am Rand des Lagers der Steingrufttroggs; {quest:739}, Agmonds Mörder, läuft zwischen den Knochenknackern herum.",

	-- Step 5: Rigglefuzz
	-- {area:1877} Valley of Fangs · {zone:1418} Badlands · {npc:2817} Rigglefuzz
	["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Reite nach Westen ins {area:1877} mitten im {zone:1418}; {npc:2817} lagert neben Martek.",
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["Blue Pearls from Stranglethorn"] = "Blaue Perlen aus dem Schlingendorntal",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "Die nächste Quest von {npc:2817} gibt keine Erfahrung: Überspring sie.",

	-- Step 6: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Reite nach Westen durch das {zone:1418} zum Lager der Staubspeier bei {area:342}. {npc:2944} steht in der Mitte, umgeben von Wyrmjägern und Raufern.",

	-- Step 7: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Reite zurück nach Osten zu {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "Die nächste Aufgabe von {npc:2888} ist eine Elitejagd: Überspring sie.",

	-- Step 8: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Die Brühenden Welpen nisten in der Klamm östlich von {npc:2888}; lass die Versengten Wächter (Elite) in Ruhe. {item:4612} fällt selten: Nimm es mit, wenn es beim Grinden kommt.",
	-- {npc:2725} Scalding Whelp · {area:339} Lethlor Ravine · {zone:1418} Badlands
	["grind on {npc:2725} at {area:339}, {zone:1418}"] = "grinde {npc:2725} in {area:339}, {zone:1418}",

	-- Step 10: Southshore
	-- {area:144} Thelsamar · {area:271} Southshore · {npc:3980} Raleigh the Devout
	["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Reite nach Norden nach {area:144} und flieg nach {area:271}. {npc:3980} predigt beim Gasthaus.",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "Raleighs nächster Auftrag ist im {area:796}: Überspring ihn.",

	-- Step 11: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Reite auf der Straße nach Nordosten aus {area:271} ins {zone:1425}; {area:348} liegt gleich hinter der Grenze. {npc:5635} hält oben Hof, {quest:1450} kümmert sich um den Greifenhorst und {npc:7884} steht beim Gasthaus.",

	-- Step 12: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} lagert an der Straße östlich von {area:348}.",
	-- {npc:5634} Rhapsody Shindigger
	["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "{npc:5634}s Cocktail braucht Zutaten aus Kalimdor: Überspring ihn.",

	-- Step 13: Witherbark villages
	["Witherbark villages"] = "Dörfer der Witherbark",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "Die ersten beiden Käfige stehen zusammen im Dorf der Witherbark südlich von {npc:5634}; der dritte ist im nächsten Dorf östlich davon. Jeder Troll der Witherbark kann eine Halskette fallen lassen.",

	-- Step 14: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} zahlt weiter für Halsketten: Gib alle übrigen ab",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, oben neben dem Flugmeister",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "Talonaxes nächste Aufgabe wartet auf einen späteren Guide für das {zone:1425}.",

	-- Step 15: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Nimm vom hinteren Pier das Schiff nach Theramore.",

	-- Step 16: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} steht an den Docks, wo das Schiff anlegt.",

	-- Step 17: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Hexenmeister: {quest:3631}",
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Flieg nach {area:392}; {npc:6251} lehrt im Haus bei der Bank. Flieg danach zurück nach Theramore.",

	-- Step 18: On to Feathermoon
	["On to Feathermoon"] = "Weiter nach Feathermoon",
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Flieg nach {area:608}, reite nach Süden durch {zone:1443} nach {zone:1444} und folge der Straße zum Steg an der {area:1108}; das Schiff fährt hinüber zur {area:1116}, wo der nächste Guide beginnt.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Reite auf der Straße nach Nordosten aus {area:271} ins {zone:1425}; {area:348} liegt gleich hinter der Grenze. Falstad hält oben Hof, {quest:1450} kümmert sich um den Greifenhorst und {npc:7884} steht beim Gasthaus.",
	-- ["Talonaxe's next task waits for a later {zone:1425} guide."] = "Talonaxes nächste Aufgabe wartet auf einen späteren Guide für das {zone:1425}.",
}
