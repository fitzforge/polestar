-- German (deDE): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {area:1099} Camp Mojache · {area:2577} Dire Maul · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key
	["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "Flieg nach Feathermoon (Allianz) oder {area:1099} (Horde) und reite nach {area:2577} im Zentrum von {zone:1444}. {npc:14368} wartet im Athenaeum, der Bibliothek, erreichbar durch den Westflügel (oder den Nordflügel mit einem {item:18249}).",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "Hydrobrut",
	["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "Hydrobrut, ein Wasserelementar, lebt im Wucherborkenviertel (Düsterbruch Ost): Jag den Wichtel Pusillin, bis er sich zum Kampf stellt, säubere den Satyrraum und nimm dann die Wendelrampe hinab zum Becken.",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299}: Hydrobrut",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "Zurück zu Lydros",
}
