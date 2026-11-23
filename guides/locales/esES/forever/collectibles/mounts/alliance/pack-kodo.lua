-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/alliance/pack-kodo (forever/collectibles/mounts/alliance/pack-kodo.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Azeroth Commerce Authority
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256736} Huey Sunnydale · {npc:10636} Pack Kodo · {faction:2586} Azeroth Commerce Authority · {item:280179} Shipping Label
	["The camp is at {area:1002} in western {zone:1433}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet. {npc:256736} sells the {npc:10636} only once you are Exalted with the {faction:2586}, and it costs 6,000 Merchant's Favor. Crates pay only Favor (about 15 a crate return); the reputation comes from Craftsman's Writs and the one-time {item:280179}, so follow the Supply Factions Reputation guide and keep 6,000 Favor aside."] = "",
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} camp"] = "Campamento de la {faction:2586}",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "Las riendas requieren nivel 60 y Equitación de oficial para montar (cliente de Forever); puedes comprarlas antes.",
	["6,000 Merchant's Favor"] = "6,000 de Favor del mercader",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azeroth Commerce Authority"] = "Autoridad Comercial de Azeroth",
	-- ["The camp is at {area:1002} in western {zone:1433}, between {zone:1429} and {area:69}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "El campamento está en {area:1002}, en el oeste de las {zone:1433}, entre {zone:1429} y {area:69}. Saquea cajas de suministros por el mundo, llénalas y entrégalas en el campamento a cambio de Favor del mercader (5-20 por caja); la {npc:10636} cuesta 6,000. Las Libranzas del artesano pueden ayudar desde nivel 10.",
}
