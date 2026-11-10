-- German (deDE): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10140} Conjure Water · {area:2577} Dire Maul
	["The level 60 {spell:10140}, from a {area:2577} library: drink for you and your group."] = "{spell:10140} der Stufe 60, aus einer Bibliothek in {area:2577}: Getränke für dich und deine Gruppe.",
	["Shen'dralar reputation"] = "Ruf bei den Shen'dralar",

	-- Step 1: Lorekeeper Lydros
	-- {area:1099} Camp Mojache · {area:2577} Dire Maul · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18594} Powerful Seaforium Charge
	["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing, or through the North wing's courtyard doors with a {item:18249} (it drops from the imp Pusillin in the East wing; a {item:18594} also opens them; Blink no longer gets past). Other mages in your group can take it too: share it."] = "Flieg nach Feathermoon (Allianz) oder {area:1099} (Horde) und reite nach {area:2577} in der Mitte von {zone:1444}. {npc:14368} wartet im Athenaeum, der Bibliothek, die du durch den Westflügel erreichst, oder durch die Hofflügeltüren des Nordflügels mit {item:18249} (er fällt vom Imp Pusillin im Ostflügel; auch {item:18594} öffnet sie; Blinzeln kommt nicht mehr vorbei). Andere Magier in deiner Gruppe können sie ebenfalls annehmen: Teilt sie.",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "Hydrobrut",
	-- {area:1758} Riptide
	["Hydrospawn, a level 57 elite water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool. A group of five. Frost does nothing to him, so frost mages switch to fire or arcane. {area:1758} hits everyone within 10 yards, so ranged stand back; at a quarter health he calls Hydrolings. The essence always drops; he does not come back until the instance resets."] = "Hydrospawn, ein Wasserelementar-Elite der Stufe 57, lebt im Warpwood Quarter (Dire Maul Ost): Jage den Imp Pusillin, bis er sich zum Kampf stellt, räum den Satyrraum und nimm dann die Spiralrampe hinunter zum Becken. Eine Gruppe aus fünf. Frost wirkt bei ihm nicht, also wechseln Frostmagier zu Feuer oder Arkan. {area:1758} trifft alle im Umkreis von 10 Metern, also bleiben Fernkämpfer zurück; bei einem Viertel Gesundheit ruft er Hydrolings. Die Essenz fällt immer; er kommt erst wieder, wenn die Instanz zurückgesetzt wird.",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299}: Hydrobrut",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "Zurück zu Lydros",
	-- {npc:14368} Lorekeeper Lydros · {spell:10140} Conjure Water
	["{npc:14368}: {spell:10140}, and 200 Shen'dralar reputation"] = "{npc:14368}: {spell:10140} und 200 Ruf bei den Shen'dralar",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "Flieg nach Feathermoon (Allianz) oder {area:1099} (Horde) und reite nach {area:2577} im Zentrum von {zone:1444}. {npc:14368} wartet im Athenaeum, der Bibliothek, erreichbar durch den Westflügel (oder den Nordflügel mit einem {item:18249}).",
	-- ["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "Hydrobrut, ein Wasserelementar, lebt im Wucherborkenviertel (Düsterbruch Ost): Jag den Wichtel Pusillin, bis er sich zum Kampf stellt, säubere den Satyrraum und nimm dann die Wendelrampe hinab zum Becken.",
}
