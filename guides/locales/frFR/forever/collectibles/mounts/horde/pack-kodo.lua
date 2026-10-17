-- French (frFR): the guide forever/collectibles/mounts/horde/pack-kodo (forever/collectibles/mounts/horde/pack-kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "Transports logistiques Durotar",
	-- {area:380} Crossroads · {zone:1413} Barrens · {npc:10636} Pack Kodo
	["The camp is just outside the {area:380} in the {zone:1413}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "Le camp se trouve juste à l'extérieur de {area:380}, dans {zone:1413}. Ramassez des caisses de ravitaillement dans le monde, remplissez-les et rendez-les au camp contre de la Faveur du marchand (5 à 20 par caisse) ; le {npc:10636} coûte 6,000. Les Commissions d'artisan peuvent aider dès le niveau 10.",
	["Durotar Supply and Logistics camp"] = "Camp des Transports logistiques Durotar",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "Les rênes demandent le niveau 60 et la monte Compagnon pour être utilisées (client Forever) ; vous pouvez les acheter avant.",
	["6,000 Merchant's Favor"] = "6,000 Faveur du marchand",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1411} Supply and Logistics"] = "Transports logistiques {zone:1411}",
	-- ["{zone:1411} Supply and Logistics camp"] = "Camp des Transports logistiques {zone:1411}",
}
