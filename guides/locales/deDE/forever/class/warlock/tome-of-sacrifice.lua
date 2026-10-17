-- German (deDE): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {zone:1419} Blasted Lands
	["A rare off-hand at 60, {npc:14463}'s payment for capturing a {npc:12396} in the {zone:1419}."] = "Ein seltener Schildhand-Gegenstand mit 60, {npc:14463}s Lohn dafür, dass du einen {npc:12396} in den {zone:1419} einfängst.",

	-- Step 1: Daio the Decrepit
	-- {npc:14463} Daio the Decrepit · {area:73} Tainted Scar · {zone:1419} Blasted Lands
	["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "Mit 60 wartet {npc:14463} in der {area:73} im Westen der {zone:1419}.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {area:1099} Camp Mojache · {item:18249} Crescent Key
	["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Die Satyrn der Wildhufe im Wucherborkenviertel, dem Ostflügel von {area:2577}, tragen das Blut. Die Hintertür beim {area:2518} nördlich von {area:1099} braucht {item:18249}; sonst geh durch den Haupteingang von {area:2577}. Bring eine Gruppe mit.",
	-- {item:18603} Satyr Blood
	["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, im Wucherborkenviertel",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Die Dämonen von Hederine halten die {area:2256} im Süden von {zone:1452}. Sie sind Elite: Eine Gruppe wird empfohlen.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {item:18601} Glowing Crystal Prison
	["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Gib beides bei {npc:14463} dem Klapprigen ab, such dann den {npc:12396} in der {area:73} und benutze {item:18601} an ihm. Er ist Elite und kämpft um seine Flucht: Eine Gruppe wird empfohlen.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on the {npc:12396}"] = "{item:18601}, am {npc:12396}",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "Zurück zu {npc:14463} dem Klapprigen",
}
