-- Korean (koKR): the guide forever/collectibles/pets/shadowgale-squirrel (forever/collectibles/pets/shadowgale-squirrel.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "{area:279}에서 하늘배 타기",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}은(는) 스카이본 시작 섬이며 누구나 방문할 수 있습니다. 하늘배가 약 5분마다 {area:279} 북쪽에서 출발합니다(다른 하나는 {zone:1456} 북쪽에서 출발하며, 두 진영 모두 어느 쪽이든 탈 수 있습니다). 이미 섬에 있다면 건너뛰십시오.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "{zone:2521}행 하늘배",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "{zone:1456}에서 하늘배 타기",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}은(는) 스카이본 시작 섬이며 누구나 방문할 수 있습니다. 하늘배가 약 5분마다 {zone:1456} 북쪽, {area:17045} 남쪽 절벽에서 출발합니다(다른 하나는 {area:279}에서 출발하며, 두 진영 모두 어느 쪽이든 탈 수 있습니다). 이미 섬에 있다면 건너뛰십시오.",

	-- Step 3: Revered with the Nightclaw Druids
	-- {faction:2758} Nightclaw Druids
	["Revered with the {faction:2758}"] = "{faction:2758}에게 존경",
	-- {npc:254151} Vayn Moongaze · {faction:2758} Nightclaw Druids
	["{npc:254151} sells the squirrel (50s) once you are Revered with the {faction:2758}."] = "{faction:2758}에게 존경을 받으면 {npc:254151}이(가) 다람쥐를 판매합니다(50실버).",
	["50s"] = "50실버",
}
