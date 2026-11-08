-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/pack-kodo (forever/collectibles/mounts/horde/pack-kodo.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Durotar Supply and Logistics
	-- {zone:1413} Barrens · {npc:256400} Okamache · {npc:10636} Pack Kodo · {faction:2587} Durotar Supply and Logistics · {item:280179} Shipping Label
	["The camp stands just outside the west gate of the Crossroads in the {zone:1413}. {npc:256400} sells the {npc:10636} only once you are Exalted with {faction:2587}, and it costs 6,000 Merchant's Favor. Crates pay only Favor (about 15 a crate return); the reputation comes from Craftsman's Writs and the one-time {item:280179}, so follow the Supply Factions Reputation guide and keep 6,000 Favor aside."] = "",
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} camp"] = "{faction:2587}營地",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "韁繩需要60級和中級騎術才能騎乘（Forever用戶端）；你可以提早購買。",
	["6,000 Merchant's Favor"] = "6,000 Merchant's Favor",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Durotar Supply and Logistics"] = "杜洛塔物資流通",
	-- ["The camp is just outside the {area:380} in the {zone:1413}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "營地就在{zone:1413}的{area:380}外面。在野外拾取補給箱，裝滿後在營地繳交換取Merchant's Favor（每箱5-20）；{npc:10636}要價6,000。10級起工匠的令狀可能有幫助。",
}
