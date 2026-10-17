-- Spanish (Spain) (esES): the guide forever/class/warlock/felhunter-horde (forever/class/warlock/felhunter-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Horde)"] = "Manáfago (Horda)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "El manáfago, el demonio ideal contra lanzadores de hechizos, y una {item:22244} para tus fragmentos.",

	-- Step 1: Seeking Strahad (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:6251} in {area:392}."] = "A nivel 30, {npc:5875}, en {object:172960} bajo {object:172982}, te envía con {npc:6251} en {area:392}.",

	-- Step 2: Seeking Strahad (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "A nivel 30, {npc:5675}, en {object:36082}, te envía con {npc:6251} en {area:392}. El zepelín de {zone:1420} vuela a {zone:1411}.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} stands on the hill in town."] = "Vuela a {area:392}; {npc:6251} está en la colina del pueblo.",

	-- Step 4: Jorah Annison
	-- {npc:6293} Jorah Annison · {object:36082} Magic Quarter
	["{npc:6293} stands in the {object:36082}."] = "{npc:6293} está en {object:36082}.",

	-- Step 5: Moldy Tome
	-- {item:6931} Moldy Tome · {area:271} Southshore
	["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931} está en la orilla al oeste de {area:271}, pasados los campamentos múrloc Rompeanca.",

	-- Step 6: Tattered Manuscript
	-- {object:92423} Damaged Chest · {area:484} Freewind Post
	["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423} está en el cañón al norte de {area:484}.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, en {object:92423}",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Varas de Mediación",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Bonewarders = {npc:1057} Dragonmaw Bonewarder
	["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Los guardahuesos Faucedraco y los pastores Faucedraco dominan las colinas al este del camino que cruza {zone:1437}: ellos sueltan las varas.",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal
	["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Vuelve con {npc:6251} en {area:392}. Usa {quest:1804} en el círculo de invocación que tiene al lado y derrota al manáfago para vincularlo.",
	-- {npc:6251} Strahad Farsan
	["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: vincula el manáfago contigo",
}
