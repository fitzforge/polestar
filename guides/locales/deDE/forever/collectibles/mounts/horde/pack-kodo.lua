-- German (deDE): the guide forever/collectibles/mounts/horde/pack-kodo (forever/collectibles/mounts/horde/pack-kodo.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Durotar Supply and Logistics
	-- {zone:1413} Barrens · {npc:256400} Okamache · {npc:10636} Pack Kodo · {faction:2587} Durotar Supply and Logistics · {item:280179} Shipping Label
	["The camp stands just outside the west gate of the Crossroads in the {zone:1413}. {npc:256400} sells the {npc:10636} only once you are Exalted with {faction:2587}, and it costs 6,000 Merchant's Favor. Crates pay only Favor (about 15 a crate return); the reputation comes from Craftsman's Writs and the one-time {item:280179}, so follow the Supply Factions Reputation guide and keep 6,000 Favor aside."] = "Das Lager steht direkt vor dem Westtor von Crossroads in der {zone:1413}. {npc:256400} verkauft das {npc:10636} erst, wenn du bei {faction:2587} Ehrfürchtig bist, und es kostet 6.000 Gunst der Händler. Kisten zahlen nur Gunst (etwa 15 pro abgegebener Kiste); der Ruf kommt von den Schriftstücken der Handwerker und dem einmaligen {item:280179}. Folge also dem Ruf-Guide für die Versorgungsfraktionen und lege 6.000 Gunst beiseite.",
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} camp"] = "Lager von {faction:2587}",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "Die Zügel erfordern zum Reiten Stufe 60 und Geübtes Reiten (Forever-Client); kaufen kannst du sie schon früher.",
	["6,000 Merchant's Favor"] = "6,000 Merchant's Favor",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Durotar Supply and Logistics"] = "Versorgung und Logistik Durotar",
	-- ["The camp is just outside the {area:380} in the {zone:1413}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "Das Lager ist direkt außerhalb von {area:380} in {zone:1413}. Plündere Versorgungskisten in der Welt, füll sie und gib sie im Lager für Merchant's Favor ab (5-20 pro Kiste); {npc:10636} kostet 6,000. Handwerksverfügungen können ab Stufe 10 helfen.",
}
