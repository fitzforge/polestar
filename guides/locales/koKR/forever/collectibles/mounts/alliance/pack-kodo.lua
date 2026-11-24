-- Korean (koKR): the guide forever/collectibles/mounts/alliance/pack-kodo (forever/collectibles/mounts/alliance/pack-kodo.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Azeroth Commerce Authority
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256736} Huey Sunnydale · {npc:10636} Pack Kodo · {faction:2586} Azeroth Commerce Authority · {item:280179} Shipping Label
	["The camp is at {area:1002} in western {zone:1433}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet. {npc:256736} sells the {npc:10636} only once you are Exalted with the {faction:2586}, and it costs 6,000 Merchant's Favor. Crates pay only Favor (about 15 a crate return); the reputation comes from Craftsman's Writs and the one-time {item:280179}, so follow the Supply Factions Reputation guide and keep 6,000 Favor aside."] = "야영지는 서부 {zone:1433}의 {area:1002}에 있으며 {zone:1429}, {zone:1431}, {area:69}에서 오는 길이 만납니다. {npc:256736}은(는) {faction:2586}과(와) 확고한 동맹이 되어야 {npc:10636}을(를) 팔며 상인의 호의 6,000이 필요합니다. 상자는 호의만 줍니다(상자당 약 15 반환). 평판은 장인의 서면과 일회성 {item:280179}에서 오니 자원 분파 평판 가이드를 따라가며 호의 6,000을 남겨 두세요.",
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} camp"] = "{faction:2586} 주둔지",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "고삐를 타려면 60레벨과 수습 타기가 필요합니다(Forever 클라이언트). 구매는 그 전에도 할 수 있습니다.",
	["6,000 Merchant's Favor"] = "Merchant's Favor 6,000",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azeroth Commerce Authority"] = "아제로스 상업 관리국",
	-- ["The camp is at {area:1002} in western {zone:1433}, between {zone:1429} and {area:69}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "주둔지는 {zone:1433} 서쪽, {zone:1429}와(과) {area:69} 사이의 {area:1002}에 있습니다. 필드에서 보급품 상자를 획득해 채운 뒤 주둔지에 제출하면 Merchant's Favor를 얻습니다(상자당 5-20). {npc:10636}은(는) 6,000입니다. 10레벨부터는 장인의 계약서도 도움이 될 수 있습니다.",
}
