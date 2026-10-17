-- German (deDE): the guide forever/collectibles/pets/minimule (forever/collectibles/pets/minimule.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Minimule"] = "Minimule",

	-- Step 1: Azeroth Commerce Authority
	["Azeroth Commerce Authority"] = "Handelskommission von Azeroth",
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {npc:214101} Marcy Baker
	["The Alliance camp is at {area:1002} in western {zone:1433}. Loot supply crates in the world, fill them and hand them in to {npc:214101} for Merchant's Favor (5-20 a crate); the treat costs 1,500."] = "Das Lager der Allianz ist bei {area:1002} im westlichen {zone:1433}. Plündere Vorratskisten in der Welt, füll sie und gib sie bei {npc:214101} ab für Merchant's Favor (5-20 pro Kiste); das Leckerli kostet 1.500.",
	["1,500 Merchant's Favor"] = "1.500 Merchant's Favor",

	-- Step 2: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "Versorgung und Logistik Durotar",
	-- {area:380} Crossroads · {npc:256384} Gishah · {zone:1458} Undercity
	["The Horde camp is just outside the {area:380}. Loot supply crates in the world, fill them and hand them in at the camp for Merchant's Favor; the treat costs 1,500. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "Das Lager der Horde liegt gleich außerhalb von {area:380}. Plündere Vorratskisten in der Welt, füll sie und gib sie im Lager ab für Merchant's Favor; das Leckerli kostet 1.500. (Ein weiterer {npc:256384} steht in {zone:1458}; gemeint ist der im Lager.)",
}
