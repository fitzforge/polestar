-- Spanish (Spain) (esES): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Merchant's Favor Reputation"] = "Reputación: Favor de mercader",

	-- Step 1: Azeroth Commerce Authority to Friendly
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Friendly"] = "{faction:2586} a Amistoso",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1433} Redridge Mountains · {object:1561} Sealed Crate · {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "La {faction:2586} es la facción de profesiones de la Alianza en Forever. Su campamento está en {area:1002}, al oeste de {zone:1433}. Desde el nivel 10 los enemigos sueltan Cajones saqueados: llena cada uno con los bienes que pide su etiqueta y entrega el {object:1561} a {npc:214101} en el campamento a cambio de reputación y Favor del mercader. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",

	-- Step 2: Azeroth Commerce Authority to Honored
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Honored"] = "{faction:2586} a Honorable",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101}."] = "Sigue llenando Cajones saqueados para {npc:214101}.",

	-- Step 3: Azeroth Commerce Authority to Revered
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Revered"] = "{faction:2586} a Venerado",

	-- Step 4: Azeroth Commerce Authority to Exalted
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Exalted"] = "{faction:2586} a Exaltado",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "Sigue llenando Cajones saqueados para {npc:214101} hasta Exaltado.",

	-- Step 5: Durotar Supply and Logistics to Friendly
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Friendly"] = "{faction:2587} a Amistoso",
	-- {faction:2587} Durotar Supply and Logistics · {area:380} Crossroads · {zone:1413} Barrens · {object:1561} Sealed Crate
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587} es la facción de profesiones de la Horda en Forever. Su campamento está justo a las afueras de {area:380}, en {zone:1413}. Desde el nivel 10 los enemigos sueltan Cajones saqueados: llena cada uno con los bienes que pide su etiqueta y entrega el {object:1561} a Dokimi en el campamento a cambio de reputación y Favor del mercader. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",
	["Dokimi"] = "Dokimi",

	-- Step 6: Durotar Supply and Logistics to Honored
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Honored"] = "{faction:2587} a Honorable",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi."] = "Sigue llenando Cajones saqueados para Dokimi.",

	-- Step 7: Durotar Supply and Logistics to Revered
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Revered"] = "{faction:2587} a Venerado",

	-- Step 8: Durotar Supply and Logistics to Exalted
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Exalted"] = "{faction:2587} a Exaltado",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi until Exalted."] = "Sigue llenando Cajones saqueados para Dokimi hasta Exaltado.",
}
