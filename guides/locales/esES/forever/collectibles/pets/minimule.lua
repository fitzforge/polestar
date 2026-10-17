-- Spanish (Spain) (esES): the guide forever/collectibles/pets/minimule (forever/collectibles/pets/minimule.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Minimule"] = "Minimula",

	-- Step 1: Azeroth Commerce Authority
	["Azeroth Commerce Authority"] = "Autoridad Comercial de Azeroth",
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {npc:214101} Marcy Baker
	["The Alliance camp is at {area:1002} in western {zone:1433}. Loot supply crates in the world, fill them and hand them in to {npc:214101} for Merchant's Favor (5-20 a crate); the treat costs 1,500."] = "El campamento de la Alianza está en {area:1002}, en el oeste de {zone:1433}. Despoja cajas de suministros por el mundo, llénalas y entrégaselas a {npc:214101} a cambio de Favor del mercader (5-20 por caja); la golosina cuesta 1,500.",
	["1,500 Merchant's Favor"] = "1,500 de Favor del mercader",

	-- Step 2: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "Suministros y Logística de Durotar",
	-- {area:380} Crossroads · {npc:256384} Gishah · {zone:1458} Undercity
	["The Horde camp is just outside the {area:380}. Loot supply crates in the world, fill them and hand them in at the camp for Merchant's Favor; the treat costs 1,500. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "El campamento de la Horda está a las afueras de {area:380}. Despoja cajas de suministros por el mundo, llénalas y entrégalas en el campamento a cambio de Favor del mercader; la golosina cuesta 1,500. (Hay otro {npc:256384} en {zone:1458}; este es el del campamento.)",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1411} Supply and Logistics"] = "Suministros y Logística de {zone:1411}",
}
