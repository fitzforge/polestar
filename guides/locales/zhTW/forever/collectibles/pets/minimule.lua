-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/minimule (forever/collectibles/pets/minimule.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Minimule"] = "Minimule",

	-- Step 1: Azeroth Commerce Authority
	["Azeroth Commerce Authority"] = "艾澤拉斯貿易協會",
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {npc:214101} Marcy Baker
	["The Alliance camp is at {area:1002} in western {zone:1433}. Loot supply crates in the world, fill them and hand them in to {npc:214101} for Merchant's Favor (5-20 a crate); the treat costs 1,500."] = "聯盟營地位於{zone:1433}西部的{area:1002}。在野外拾取補給箱，裝滿後交給{npc:214101}換取Merchant's Favor（每箱5-20）；這個點心要價1,500。",
	["1,500 Merchant's Favor"] = "1,500 Merchant's Favor",

	-- Step 2: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "杜洛塔物資流通",
	-- {area:380} Crossroads · {npc:256384} Gishah · {zone:1458} Undercity
	["The Horde camp is just outside the {area:380}. Loot supply crates in the world, fill them and hand them in at the camp for Merchant's Favor; the treat costs 1,500. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "部落營地就在{area:380}外面。在野外拾取補給箱，裝滿後在營地繳交換取Merchant's Favor；這個點心要價1,500。（另一個{npc:256384}站在{zone:1458}；要找的是營地裡的這位。）",
}
