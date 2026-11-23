-- German (deDE): the guide forever/class/warlock/imp-horde (forever/class/warlock/imp-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Horde)"] = "Wichtel (Horde)",
	["Your first demon at level 1-4: the imp, with a starter blade or staff for Orcs and Trolls."] = "Dein erster Dämon auf Stufe 1-4: der Wichtel, mit einer Startklinge oder einem Startstab für Orcs und Trolle.",

	-- Step 1: Ruzan (Orcs and Trolls)
	-- {npc:5765} Ruzan
	["{npc:5765} (Orcs and Trolls)"] = "{npc:5765} (Orcs und Trolle)",
	-- {item:9579} Tainted Parchment · {item:282346} Tainted Tablet · {npc:5765} Ruzan · {area:363} Valley of Trials
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Your first letter ({item:9579} for Orcs, {item:282346} for Trolls, from Gornek after Cutting Teeth) points you to Nartok, the warlock trainer in the Den. {npc:5765} stands just outside the Den in the {area:363} and asks for six Vile Familiar Heads."] = "Dein erster Brief ({item:9579} für Orcs, {item:282346} für Trolle, von Gornek nach Cutting Teeth) schickt dich zu Nartok, dem Hexenmeisterlehrer in der Höhle. {npc:5765} steht direkt vor der Höhle im {area:363} und verlangt sechs Vile Familiar Heads.",

	-- Step 2: Vile Familiars
	-- {quest:1485} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:1485} (level 3-4) swarm the {area:365}, the cave north of the Den, inside and around its mouth. Almost every kill drops a head (80%), so about eight kills does it; they throw small fireballs, so pull them one at a time. They respawn in just over three minutes. Other classes hunt the same imps for their own {quest:1485} quest."] = "Die {quest:1485} (Stufe 3-4) wimmeln in {area:365}, der Höhle nördlich davon, drinnen und rund um den Eingang. Fast jeder Kill lässt einen Kopf fallen (80 %), etwa acht Kills reichen also; sie werfen kleine Feuerbälle, pull sie also einzeln. Sie respawnen nach etwas mehr als drei Minuten. Andere Klassen jagen dieselben Wichtel für ihre eigene Quest {quest:1485}.",
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Vile Familiar Heads"] = "Vile Familiar Heads",

	-- Step 3: Summon Imp
	-- {npc:5765} Ruzan · {spell:688} Summon Imp · {npc:3145} Zureetha Fargaze
	["{npc:5765} teaches you {spell:688} when you hand in the heads: summon it right away, it costs nothing and fights beside you. Then speak with {npc:3145} a few steps away for a starter weapon."] = "{npc:5765} bringt dir {spell:688} bei, wenn du die Köpfe abgibst: Beschwöre ihn sofort, er kostet nichts und kämpft an deiner Seite. Sprich dann ein paar Schritte weiter mit {npc:3145} für eine Startwaffe.",

	-- Step 4: Venya Marthand (Undead)
	-- {npc:5667} Venya Marthand
	["{npc:5667} (Undead)"] = "{npc:5667} (Untote)",
	-- {item:9578} Tainted Scroll · {npc:1569} Shadow Priest Sarvis · {area:154} Deathknell · {npc:5667} Venya Marthand
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Your first letter ({item:9578}, from {npc:1569} after The Mindless Ones) points you to Maximillion, the warlock trainer in {area:154}. {npc:5667} waits inside the building beside him and asks for three Rattlecage Skulls."] = "Dein erster Brief ({item:9578}, von {npc:1569} nach The Mindless Ones) schickt dich zu Maximillion, dem Hexenmeisterlehrer in {area:154}. {npc:5667} wartet im Gebäude neben ihm und verlangt drei Rattlecage Skulls.",

	-- Step 5: Rattlecage Skulls
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Rattlecage Skulls"] = "Rattlecage Skulls",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons (level 2-3) stand around the old smithy buildings just north of {area:154}, often right against the walls. Four kills in five drop a skull, so plan on about five; twenty of them spawn there and each comes back after five minutes."] = "Die Rattlecage Skeletons (Stufe 2-3) stehen bei den alten Schmiedegebäuden direkt nördlich von {area:154}, oft direkt an den Wänden. Vier von fünf Kills lassen einen Schädel fallen, plane also etwa fünf ein; zwanzig davon spawnen dort, und jedes kommt nach fünf Minuten zurück.",

	-- Step 6: Summon Imp
	-- {npc:5667} Venya Marthand · {spell:688} Summon Imp
	["{npc:5667} teaches you {spell:688} when you hand in the skulls: summon it right away, it costs nothing and fights beside you."] = "{npc:5667} bringt dir {spell:688} bei, wenn du die Schädel abgibst: Beschwöre ihn sofort, er kostet nichts und kämpft an deiner Seite.",
}
