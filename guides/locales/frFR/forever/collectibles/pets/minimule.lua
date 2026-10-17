-- French (frFR): the guide forever/collectibles/pets/minimule (forever/collectibles/pets/minimule.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Minimule"] = "Minimule",

	-- Step 1: Azeroth Commerce Authority
	["Azeroth Commerce Authority"] = "Administration commerciale d’Azeroth",
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {npc:214101} Marcy Baker
	["The Alliance camp is at {area:1002} in western {zone:1433}. Loot supply crates in the world, fill them and hand them in to {npc:214101} for Merchant's Favor (5-20 a crate); the treat costs 1,500."] = "Le camp de l'Alliance se trouve à {area:1002}, dans l'ouest de {zone:1433}. Ramassez des caisses de ravitaillement dans le monde, remplissez-les et remettez-les à {npc:214101} contre des Merchant's Favor (5 à 20 par caisse) ; la friandise coûte 1 500.",
	["1,500 Merchant's Favor"] = "1 500 Merchant's Favor",

	-- Step 2: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "Transports logistiques Durotar",
	-- {area:380} Crossroads · {npc:256384} Gishah · {zone:1458} Undercity
	["The Horde camp is just outside the {area:380}. Loot supply crates in the world, fill them and hand them in at the camp for Merchant's Favor; the treat costs 1,500. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "Le camp de la Horde se trouve juste à l'extérieur de {area:380}. Ramassez des caisses de ravitaillement dans le monde, remplissez-les et remettez-les au camp contre des Merchant's Favor ; la friandise coûte 1 500. (Un autre {npc:256384} se trouve à {zone:1458} ; c'est celui du camp qu'il vous faut.)",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1411} Supply and Logistics"] = "Transports logistiques {zone:1411}",
}
