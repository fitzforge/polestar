-- German (deDE): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["At 60 {npc:14463} waits in the {area:73}, the demon-filled hollow in the west of the {zone:1419}. The Scar is full of hard-hitting elites: Soulstone yourself first, then keep to the right-hand wall going in, or ride through mounted. {npc:14463} gives you two errands at once."] = "Mit Stufe 60 wartet {npc:14463} im {area:73}, der dämonenerfüllten Senke im Westen von {zone:1419}. Die Scar ist voller hart zuschlagender Elites: Setz zuerst einen Seelenstein auf dich, halte dich dann beim Hineingehen an die rechte Wand oder reite beritten hindurch. {npc:14463} gibt dir zwei Aufträge auf einmal.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {item:18249} Crescent Key · {zone:1444} Feralas
	["The Wildspawn satyrs (level 55-57, elite) fill the Warpwood Quarter, {area:2577}'s eastern wing: bring a group of five. Four in five drop a blood, but they do not come back for two hours and one full clear may come up short of fifteen; reset and run it again. The back door at {area:2518} needs the {item:18249}, which drops inside this wing; until someone has it, go in by {area:2577}'s main gate in central {zone:1444}."] = "Die Wildspawn-Satyrn (Stufe 55-57, Elite) füllen das Warpwood Quarter, den Ostflügel von {area:2577}: Bring eine Gruppe aus fünf mit. Vier von fünf lassen ein Blut fallen, aber sie kommen zwei Stunden nicht zurück und ein vollständiges Räumen reicht vielleicht nicht für fünfzehn; setz zurück und wiederhole den Durchlauf. Die Hintertür bei {area:2518} braucht {item:18249}, der in diesem Flügel fällt; bis jemand ihn hat, geh durch das Haupttor von {area:2577} im zentralen {zone:1444} hinein.",
	-- {item:18603} Satyr Blood
	["{item:18603}, from the Wildspawn inside"] = "{item:18603}, von den Wildspawn drinnen",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring · {spell:7645} Dominate Mind · {spell:710} Banish
	["The Hederine demons (level 57-60, elite) hold {area:2256} in the far south of {zone:1452}: grouping up is encouraged. Two Slayers guard the gorge past the bridge; the western tunnel leads to more Initiates, the easiest of them (watch for their {spell:7645}). A warlock can solo them one at a time with Fear or {spell:710} and damage over time, but slowly. Any of them can drop the Tears, four kills in five."] = "Die Hederine-Dämonen (Stufe 57-60, Elite) halten {area:2256} im äußersten Süden von {zone:1452}: Eine Gruppe wird empfohlen. Zwei Slayers bewachen die Schlucht hinter der Brücke; der westliche Tunnel führt zu weiteren Initiates, den leichtesten von ihnen (achte auf ihr {spell:7645}). Ein Hexenmeister kann sie einzeln mit Furcht oder {spell:710} und Schaden über Zeit solo schaffen, aber langsam. Jeder von ihnen kann die Tränen fallen lassen, bei vier von fünf Kills.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {spell:45} War Stomp · {item:18605} Imprisoned Doomguard
	["Hand both in to {npc:14463} and take the {item:18601}. Find a {npc:12396} (level 61, elite) standing alone in the {area:73}, open from about 30 yards with your voidwalker on him, and channel the prison on him for about 20 seconds: he attacks you to break free, and his {spell:45} can interrupt the channel, so sacrifice the voidwalker for its shield if you must. Grouping up is encouraged: a second player to tank makes it easy. When the channel finishes he becomes the {item:18605}: click it. If the channel breaks, kill him or run, and try another."] = "Gib beide bei {npc:14463} ab und nimm {item:18601} an. Such einen {npc:12396} (Stufe 61, Elite), der allein im {area:73} steht, eröffne aus etwa 30 Metern mit deinem Leerwandler auf ihm und kanalisiere das Gefängnis etwa 20 Sekunden lang auf ihn: Er greift dich an, um sich zu befreien, und sein {spell:45} kann die Kanalisierung unterbrechen, opfere also notfalls den Leerwandler für dessen Schild. Eine Gruppe wird empfohlen: Ein zweiter Spieler zum Tanken macht es leicht. Ist die Kanalisierung beendet, wird er zu {item:18605}: Klicke ihn an. Bricht die Kanalisierung ab, töte ihn oder lauf weg und versuch einen anderen.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on a {npc:12396}"] = "{item:18601}, auf einen {npc:12396}",
	-- {item:18605} Imprisoned Doomguard
	["{item:18605}, click it"] = "{item:18605}, anklicken",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "Zurück zu {npc:14463} dem Klapprigen",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "Mit 60 wartet {npc:14463} in der {area:73} im Westen der {zone:1419}.",
	-- ["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Gib beides bei {npc:14463} dem Klapprigen ab, such dann den {npc:12396} in der {area:73} und benutze {item:18601} an ihm. Er ist Elite und kämpft um seine Flucht: Eine Gruppe wird empfohlen.",
	-- ["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Die Dämonen von Hederine halten die {area:2256} im Süden von {zone:1452}. Sie sind Elite: Eine Gruppe wird empfohlen.",
	-- ["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Die Satyrn der Wildhufe im Wucherborkenviertel, dem Ostflügel von {area:2577}, tragen das Blut. Die Hintertür beim {area:2518} nördlich von {area:1099} braucht {item:18249}; sonst geh durch den Haupteingang von {area:2577}. Bring eine Gruppe mit.",
	-- ["{item:18601}, on the {npc:12396}"] = "{item:18601}, am {npc:12396}",
	-- ["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, im Wucherborkenviertel",
}
