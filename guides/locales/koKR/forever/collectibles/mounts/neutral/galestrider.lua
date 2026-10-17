-- Korean (koKR): the guide forever/collectibles/mounts/neutral/galestrider (forever/collectibles/mounts/neutral/galestrider.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Galestrider"] = "돌풍타조",

	-- Step 1: Learn to ride
	["Learn to ride"] = "탈것 타기 배우기",
	-- {skill:762} Riding · {spell:1285849} Galestrider Riding
	["Galestriders need level 40 and {skill:762} ({spell:1285849} comes with it in the Forever client). Any riding trainer of your faction teaches it; see the Level 40 mount guides for where."] = "돌풍타조에는 40레벨과 {skill:762}이(가) 필요합니다(Forever 클라이언트에서는 {spell:1285849}이(가) 함께 따라옵니다). 같은 진영의 탈것 상급자라면 누구나 가르칩니다. 위치는 40레벨 탈것 가이드를 보세요.",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "{area:279}에서 하늘배 타기",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}은(는) 스카이본 시작 섬이며 누구나 방문할 수 있습니다. 하늘배가 약 5분마다 {area:279} 북쪽에서 출발합니다(다른 하나는 {zone:1456} 북쪽에서 출발하며, 두 진영 모두 어느 쪽이든 탈 수 있습니다). 이미 섬에 있다면 건너뛰십시오.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "{zone:2521}행 하늘배",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "{zone:1456}에서 하늘배 타기",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}은(는) 스카이본 시작 섬이며 누구나 방문할 수 있습니다. 하늘배가 약 5분마다 {zone:1456} 북쪽, {area:17045} 남쪽 절벽에서 출발합니다(다른 하나는 {area:279}에서 출발하며, 두 진영 모두 어느 쪽이든 탈 수 있습니다). 이미 섬에 있다면 건너뛰십시오.",

	-- Step 4: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Galestrider at 20g; choose one."] = "{npc:265756}은(는) 섬의 항구 마을인 {area:16638}의 하늘배 선착장 근처에 있습니다. Forever 클라이언트에서 돌풍타조는 각 20골드입니다. 하나를 고르십시오.",
	["20g"] = "20골드",
}
