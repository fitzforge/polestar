-- German (deDE): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Merchant's Favor Reputation"] = "Ruf: Händlergunst",

	-- Step 1: Azeroth Commerce Authority to Friendly
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Friendly"] = "{faction:2586} auf Freundlich",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1433} Redridge Mountains · {object:1561} Sealed Crate · {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "Die {faction:2586} ist in Forever die Berufsfraktion der Allianz. Ihr Lager ist bei {area:1002} im westlichen {zone:1433}. Ab Stufe 10 lassen Gegner Abgefangene Kisten fallen: Füll jede mit den Waren, die ihr Etikett verlangt, und gib die {object:1561} bei {npc:214101} im Lager ab für Ruf und Merchant's Favor. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",

	-- Step 2: Azeroth Commerce Authority to Honored
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Honored"] = "{faction:2586} auf Wohlwollend",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101}."] = "Füll weiter Abgefangene Kisten für {npc:214101}.",

	-- Step 3: Azeroth Commerce Authority to Revered
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Revered"] = "{faction:2586} auf Respektvoll",

	-- Step 4: Azeroth Commerce Authority to Exalted
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Exalted"] = "{faction:2586} auf Ehrfürchtig",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "Füll weiter Abgefangene Kisten für {npc:214101}, bis du Ehrfürchtig bist.",

	-- Step 5: Durotar Supply and Logistics to Friendly
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Friendly"] = "{faction:2587} auf Freundlich",
	-- {faction:2587} Durotar Supply and Logistics · {area:380} Crossroads · {zone:1413} Barrens · {object:1561} Sealed Crate
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587} ist in Forever die Berufsfraktion der Horde. Ihr Lager liegt gleich außerhalb von {area:380} im {zone:1413}. Ab Stufe 10 lassen Gegner Abgefangene Kisten fallen: Füll jede mit den Waren, die ihr Etikett verlangt, und gib die {object:1561} bei Dokimi im Lager ab für Ruf und Merchant's Favor. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	["Dokimi"] = "Dokimi",

	-- Step 6: Durotar Supply and Logistics to Honored
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Honored"] = "{faction:2587} auf Wohlwollend",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi."] = "Füll weiter Abgefangene Kisten für Dokimi.",

	-- Step 7: Durotar Supply and Logistics to Revered
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Revered"] = "{faction:2587} auf Respektvoll",

	-- Step 8: Durotar Supply and Logistics to Exalted
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Exalted"] = "{faction:2587} auf Ehrfürchtig",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi until Exalted."] = "Füll weiter Abgefangene Kisten für Dokimi, bis du Ehrfürchtig bist.",
}
