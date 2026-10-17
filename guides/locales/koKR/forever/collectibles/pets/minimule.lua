-- Korean (koKR): the guide forever/collectibles/pets/minimule (forever/collectibles/pets/minimule.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Minimule"] = "Minimule",

	-- Step 1: Azeroth Commerce Authority
	["Azeroth Commerce Authority"] = "아제로스 상업 관리국",
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {npc:214101} Marcy Baker
	["The Alliance camp is at {area:1002} in western {zone:1433}. Loot supply crates in the world, fill them and hand them in to {npc:214101} for Merchant's Favor (5-20 a crate); the treat costs 1,500."] = "얼라이언스 야영지는 {zone:1433} 서부의 {area:1002}에 있습니다. 필드에서 보급품 상자를 획득해 채운 뒤 {npc:214101}에게 제출하면 Merchant's Favor를 얻습니다(상자당 5-20). 간식은 1,500입니다.",
	["1,500 Merchant's Favor"] = "Merchant's Favor 1,500",

	-- Step 2: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "듀로타 보급 및 병참국",
	-- {area:380} Crossroads · {npc:256384} Gishah · {zone:1458} Undercity
	["The Horde camp is just outside the {area:380}. Loot supply crates in the world, fill them and hand them in at the camp for Merchant's Favor; the treat costs 1,500. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "호드 야영지는 {area:380} 바로 바깥에 있습니다. 필드에서 보급품 상자를 획득해 채운 뒤 야영지에 제출하면 Merchant's Favor를 얻습니다. 간식은 1,500입니다. ({zone:1458}에도 {npc:256384}이(가) 있지만, 여기서는 야영지에 있는 쪽입니다.)",
}
