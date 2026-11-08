-- Spanish (Spain) (esES): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "Manáfago (Alianza)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "El manáfago, el demonio ideal contra lanzadores de hechizos, y una {item:22244} para tus fragmentos.",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "A nivel 30, {npc:6122}, en el sótano de {object:2164}, en el {object:2101}, te envía con {npc:6251} en {area:392}.",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "A nivel 30, {npc:6120}, en {object:32383}, te envía con {npc:6251} en {area:392}.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6294} Krom Stoutarm · {zone:1455} Ironforge
	["{area:392} is a neutral goblin port on the {zone:1413} coast: the boat from {area:35} docks there. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6294} in {zone:1455}."] = "",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers (no name in this language: may be words) · {quest:1758} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6294} is in the library of the {object:32356}. He wants two lost pieces of the {quest:1758}: one on the {area:287} coast, one in {zone:1441}."] = "",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "",
	-- {item:6931} Moldy Tome · {quest:1802} Tome of the Cabal
	["{item:6931}, from the {quest:1802} on the sand"] = "",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}, a Horde town: keep clear of its guards. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, en {object:92423}",

	-- Step 7: Back to Krom Stoutarm
	-- {npc:6294} Krom Stoutarm
	["Back to {npc:6294}"] = "",
	-- {npc:6294} Krom Stoutarm · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6294} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Varas de Mediación",
	-- {area:1036} Angerfang Encampment · {area:150} Menethil Harbor · {area:836} Dun Algaz
	["The Dragonmaw hold {area:1036} in the hills east of the road from {area:150} to {area:836}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "",
	["Rods of Channeling, from the Dragonmaw casters"] = "",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Vuelve con {npc:6251} en {area:392}. Usa {quest:1804} en el círculo de invocación a su lado y derrota al manáfago para vincularlo.",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Los Guardahuesos Faucedraco y los Pastores Faucedraco ocupan las colinas al este del camino que cruza {zone:1437}: sueltan las varas.",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931} está en la orilla al oeste de {area:271}, pasados los campamentos de múrlocs Rompeanca.",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423} está en el cañón al norte de {area:484}.",
	-- ["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392} está en la costa de {zone:1413}; {npc:6251} está en la colina del pueblo.",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: vincula el manáfago a ti",
	-- ["{npc:6294} stands in the {object:32356}."] = "{npc:6294} está en la {object:32356}.",
}
