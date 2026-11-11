-- German (deDE): the guide forever/class/mage/teleports-horde (forever/class/mage/teleports-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Horde)"] = "Teleports und Portale (Horde)",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "Deine Stadtteleports mit 20 und 30 und die Gruppenportale mit 40 und 50, jeweils vom Portallehrer der Stadt.",

	-- Step 1: Teleport: Orgrimmar
	-- {object:173161} Darkbriar Lodge (no name in this language: may be words) · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {npc:5958} Thuul · {spell:3567} Teleport: Orgrimmar · {item:17031} Rune of Teleportation
	["At 20 go to {object:173161} in {zone:1454}'s {object:172961}, where the mage trainers live. {npc:5958}, the portal trainer, stands on the upper floor and teaches {spell:3567} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor), so carry a few."] = "Geh mit Stufe 20 zu {object:173161} im {object:172961} von {zone:1454}, wo die Magierlehrer leben. {npc:5958}, der Portallehrer, steht im oberen Stockwerk und bringt dir {spell:3567} für 20 Silber bei. Jeder Teleport verbraucht eine {item:17031} (10 Silber bei jedem Reagenzienhändler), nimm also ein paar mit.",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}, je 10s",

	-- Step 2: Teleport: Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {npc:4575} Hannah Akeley
	["Take the zeppelin from the tower outside {zone:1454}'s gate to {zone:1420} and walk into the {zone:1458}. {npc:2492}, the portal trainer, stands in the {object:36082} with the mage trainers: {spell:3563}, 20 silver. {npc:4575} beside him sells the runes."] = "Nimm den Zeppelin vom Turm vor dem Tor von {zone:1454} nach {zone:1420} und geh in {zone:1458} hinein. {npc:2492}, der Portallehrer, steht im {object:36082} bei den Magierlehrern: {spell:3563}, 20 Silber. {npc:4575} neben ihm verkauft die Runen.",

	-- Step 3: Teleport: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {zone:1454} Orgrimmar · {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {spell:3566} Teleport: Thunder Bluff
	["At 30. {zone:1456} is in {zone:1412}: fly there from {zone:1454} or the Crossroads. {npc:5957}, the portal trainer, stands with the mage trainers in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart. She teaches {spell:3566} for 80 silver."] = "Mit Stufe 30. {zone:1456} liegt in {zone:1412}: Flieg von {zone:1454} oder der Crossroads dorthin. {npc:5957}, die Portallehrerin, steht bei den Magierlehrern in den {area:2197}, der Höhle unter {area:1640}: Geh drinnen nach unten, der Pfeil kann die Stockwerke nicht unterscheiden. Sie bringt dir {spell:3566} für 80 Silber bei.",

	-- Step 4: Portals to Orgrimmar and the Undercity
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Portals to {zone:1454} and the {zone:1458}"] = "Portale nach {zone:1454} und {zone:1458}",
	-- {item:17032} Rune of Portals · {npc:5958} Thuul · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {spell:11417} Portal: Orgrimmar · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {spell:11418} Portal: Undercity
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:5958} in {object:173161} has {spell:11417}; teleport to the {zone:1458} for {npc:2492}'s {spell:11418}."] = "Mit Stufe 40 bringen dir die Portallehrer die Portale bei: ein Tor, durch das deine ganze Gruppe treten kann, für je 1 Gold 50 Silber. Jedes Portal verbraucht eine {item:17032} (20 Silber bei jedem Reagenzienhändler). {npc:5958} in {object:173161} hat {spell:11417}; teleportiere dich nach {zone:1458} für {spell:11418} von {npc:2492}.",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}, je 20s",

	-- Step 5: Portal: Thunder Bluff
	-- {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {spell:11420} Portal: Thunder Bluff · {spell:3566} Teleport: Thunder Bluff
	["At 50 {npc:5957}, down in the {area:2197} under {area:1640} in {zone:1456}, teaches the last one, {spell:11420}, for 3 gold 20 silver. Use your {spell:3566} to get there."] = "Mit Stufe 50 bringt dir {npc:5957}, unten in den {area:2197} unter {area:1640} in {zone:1456}, das letzte bei, {spell:11420}, für 3 Gold 20 Silber. Nutze dein {spell:3566}, um hinzukommen.",
}
