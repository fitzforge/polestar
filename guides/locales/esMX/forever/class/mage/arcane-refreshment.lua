-- Spanish (Latin America) (esMX): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10140} Conjure Water
	["The level 60 {spell:10140}, from a Dire Maul library: drink for you and your group."] = "",
	["Shen'dralar reputation"] = "Reputación con Shen'dralar",

	-- Step 1: Lorekeeper Lydros
	-- {object:176945} Camp Mojache (no name in this language: may be words) · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18594} Powerful Seaforium Charge
	["Fly to Feathermoon (Alliance) or {object:176945} (Horde) and ride to Dire Maul in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing, or through the North wing's courtyard doors with a {item:18249} (it drops from the imp Pusillin in the East wing; a {item:18594} also opens them; Blink no longer gets past). Other mages in your group can take it too: share it."] = "",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "Hidromilecio",
	["Hydrospawn, a level 57 elite water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool. A group of five. Frost does nothing to him, so frost mages switch to fire or arcane. Riptide hits everyone within 10 yards, so ranged stand back; at a quarter health he calls Hydrolings. The essence always drops; he does not come back until the instance resets."] = "",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299}: Hidromilecio",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "Regresa con Lydros",
	-- {npc:14368} Lorekeeper Lydros · {spell:10140} Conjure Water
	["{npc:14368}: {spell:10140}, and 200 Shen'dralar reputation"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "Vuela a Plumaluna (Alianza) o a {area:1099} (Horda) y cabalga hasta {area:2577}, en el centro de {zone:1444}. {npc:14368} espera en el Athenaeum, la biblioteca, a la que se llega por el ala Oeste (o por el ala Norte con una {item:18249}).",
	-- ["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "Hidromilecio, un elemental de agua, vive en el ala este de La Masacre: persigue al diablillo Pusillín hasta que se vuelva para pelear, limpia la sala de los sátiros y luego baja por la rampa en espiral hasta el estanque.",
	-- ["The level 60 {spell:10140}, from a {area:2577} library: drink for you and your group."] = "{spell:10140} de nivel 60, de una biblioteca de {area:2577}: bebida para ti y tu grupo.",
}
