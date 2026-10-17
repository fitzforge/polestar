-- German (deDE): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Horde)"] = "{spell:2842} (Horde)",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever lehrt {spell:2842} über diese Questreihe, nicht beim Lehrer; das Rezept für {item:7676} gibt es dazu.",

	-- Step 1: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "Mit 20 steht {npc:3401} in der {object:172960}, der Schlucht unter dem {object:172982}. Nimm ihn ins Ziel und gib /salutieren ein.",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "/salutieren: {npc:3401}",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}: Behalte {item:8051}",

	-- Step 2: Taskmaster Fizzule
	-- {area:380} Crossroads · {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:7233} Taskmaster Fizzule
	["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "Flieg zum {area:380} und reite nach Norden zum Turm der Venture Co. nördlich von {area:382}. Feuere in Sichtweite des Turms zweimal {item:8051} ab und salutiere dann vor {npc:7233} (/salutieren), bevor er dich angreift.",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, in sight of the tower"] = "{item:8051}, zweimal, in Sichtweite des Turms",

	-- Step 3: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "Bleib verstohlen. {npc:7287} trägt den Turmschlüssel; Gallywix (Elite) und seine Schließkassette sind oben im Turm. Töte je zwei Drohnen, Patrouillen und Ausgucke der Venture Co. rund um den Turm.",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}: {npc:7288} (Elite)",

	-- Step 4: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "Zurück zu {npc:3401}",
	-- {zone:1454} Orgrimmar
	["Fly back to {zone:1454}."] = "Flieg zurück nach {zone:1454}.",

	-- Step 5: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:272} Tarren Mill · {area:287} Hillsbrad · {npc:2391} Serge Hinott
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1458} und reite nach Süden durch den {zone:1421} nach {area:272} in {area:287}. {npc:2391} steht in {area:272}; warte neben ihm, während er das Heilmittel braut.",
	["Wait for the cure"] = "Warte auf das Heilmittel",
}
