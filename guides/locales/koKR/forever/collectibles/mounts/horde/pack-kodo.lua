-- Korean (koKR): the guide forever/collectibles/mounts/horde/pack-kodo (forever/collectibles/mounts/horde/pack-kodo.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Durotar Supply and Logistics
	-- {zone:1413} Barrens · {npc:256400} Okamache · {npc:10636} Pack Kodo · {faction:2587} Durotar Supply and Logistics · {item:280179} Shipping Label
	["The camp stands just outside the west gate of the Crossroads in the {zone:1413}. {npc:256400} sells the {npc:10636} only once you are Exalted with {faction:2587}, and it costs 6,000 Merchant's Favor. Crates pay only Favor (about 15 a crate return); the reputation comes from Craftsman's Writs and the one-time {item:280179}, so follow the Supply Factions Reputation guide and keep 6,000 Favor aside."] = "야영지는 불모의 땅 {zone:1413}의 크로스로드 서문 바로 바깥에 있습니다. {npc:256400}은(는) {faction:2587}과(와) 확고한 동맹이 되어야 {npc:10636}을(를) 팔며 상인의 호의 6,000이 필요합니다. 상자는 호의만 줍니다(상자당 약 15 반환). 평판은 장인의 서면과 일회성 {item:280179}에서 오니 자원 분파 평판 가이드를 따라가며 호의 6,000을 남겨 두세요.",
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} camp"] = "{faction:2587} 야영지",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "고삐를 타려면 60레벨과 수습 타기가 필요합니다(Forever 클라이언트). 구매는 그 전에도 할 수 있습니다.",
	["6,000 Merchant's Favor"] = "Merchant's Favor 6,000",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Durotar Supply and Logistics"] = "듀로타 보급 및 병참국",
	-- ["The camp is just outside the {area:380} in the {zone:1413}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "주둔지는 {zone:1413}의 {area:380} 바로 바깥에 있습니다. 필드에서 보급품 상자를 획득해 채운 뒤 주둔지에 제출하면 Merchant's Favor를 얻습니다(상자당 5-20). {npc:10636}은(는) 6,000입니다. 10레벨부터는 장인의 계약서도 도움이 될 수 있습니다.",
}
