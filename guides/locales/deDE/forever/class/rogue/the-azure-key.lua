-- German (deDE): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Ruf bei Ravenholdt und Erfahrung auf Stufe 50; Forever hat die Gegenstandsauswahl aus Classic entfernt.",
	["Ravenholdt reputation"] = "Ruf bei Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Allianz)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "Auf Stufe 50 hat {npc:918} in {object:2100} in {zone:1453} sie; ebenso Syurna in {zone:1457} sowie {npc:5165} und Fenthwick in {zone:1455}.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horde)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "Auf Stufe 50 hat {npc:3328} in der {object:172960} sie; ebenso {npc:4583} im {object:36073} von {zone:1458}.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486} versteckt sich in den Hügeln östlich von {area:272}, einen Pfad hinauf ins {zone:1416}. Horde fliegt nach {area:272}, Allianz nach {area:271}.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "Allianz fliegt nach {area:3137}, Horde nach {area:1237}. Die Schamanen der Holzschlundfeste in den nördlichen Hügeln von {zone:1447} lassen die Tasche fallen, etwa eine von dreißig.",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "Die Waldbrühschlammer im südlichen {zone:1447} lassen die Fragmente fallen.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "Zurück zu Xylem",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz im {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, ein grüner Drache, ist ein Elite-Boss tief im {area:1417}, einem Dungeon der Stufe 50: Bring eine Gruppe von fünf mit. Der Tempel steht im {area:74}; schwimm hinab zum Eingang. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:1438} und reite weiter.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: Morphaz, im Tempel",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Lord Ravenholdt",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768}: In Forever keine Gegenstandsauswahl",
}
