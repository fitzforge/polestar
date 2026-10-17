-- Korean (koKR): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring
	["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{zone:1452} 북쪽 {area:2241}의 {npc:10618}이(가) 반복 퀘스트 눈호랑이의 먹이, 눈사태일족의 침략, 광란의 거인(58레벨)을 줍니다. 확고한 동맹까지 가는 유일한 길이므로 몇 주 동안 퀘스트를 반복할 각오를 하십시오.",

	-- Step 2: Reins of the Winterspring Frostsaber
	["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Forever 클라이언트에서는 200골드, 60레벨이며 탈것 기술 등급은 요구하지 않습니다.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200골드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1452} Frostsaber"] = "{zone:1452} 눈호랑이",
}
