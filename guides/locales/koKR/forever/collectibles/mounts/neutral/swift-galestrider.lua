-- Korean (koKR): the guide forever/collectibles/mounts/neutral/swift-galestrider (forever/collectibles/mounts/neutral/swift-galestrider.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Galestrider"] = "날쌘 돌풍타조",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {skill:762} Riding
	["Swift Galestriders need level 60 and Journeyman {skill:762}. Train it at your own race's riding trainer; see the Level 60 mount guides for where."] = "",

	-- Step 2: Skyboat from Dalaran
	["Skyboat from Dalaran"] = "",
	-- {zone:2521} Zephras Isle · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of Dalaran about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "{zone:2521}행 하늘배",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "{zone:1456}에서 하늘배 타기",
	-- {zone:2521} Zephras Isle · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of Skywatcher Plateau, north of {zone:1456}, about every five minutes (another flies from Dalaran; either faction may take either). Skip this if you are already on the island."] = "",

	-- Step 4: Journeyman Riding with Genn Fairweather
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["Journeyman {skill:762} with {npc:265756}"] = "",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["Skyborne train Journeyman {skill:762} with {npc:265756} himself for 1,000g; Blizzard says it comes with a mount. He stands at the Fairweather Stables in Valanaar, near the skyboat docks."] = "",
	-- {npc:265756} Genn Fairweather
	["{npc:265756}, riding trainer"] = "",

	-- Step 5: Galestrider Riding for other races
	-- {skill:762} Riding
	["Galestrider {skill:762} for other races"] = "",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["Any race can buy Galestriders, but riding one also takes Galestrider Riding, which only the Skyborne get with {skill:762}. Other races can learn it too, but how is not known yet: in Classic another race's riding needed Exalted with its home faction, here the High Order (Alliance) or the Windshapers (Horde). Ask {npc:265756} before you buy."] = "",

	-- Step 6: Genn Fairweather
	-- {npc:265756} Genn Fairweather
	["{npc:265756} is at the Fairweather Stables in Valanaar, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "",
	["200g"] = "200골드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Skyboat from {area:279}"] = "{area:279}에서 하늘배 타기",
	-- ["Swift Galestriders need level 60 and Journeyman {skill:762} from a riding trainer of your faction; see the Level 60 mount guides for where."] = "날쌘 돌풍타조를 타려면 60레벨과 소속 진영 탈것 상급자에게 배우는 수습 {skill:762}이(가) 필요합니다. 위치는 60레벨 탈것 가이드를 참고하세요.",
	-- ["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756}은(는) 섬의 항구 마을인 {area:16638}의 하늘배 선착장 근처에 있습니다. Forever 클라이언트에서는 날쌘 돌풍타조를 각 200골드에 팝니다. 하나를 고르세요.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}은(는) 스카이본의 시작 섬이며 누구나 방문할 수 있습니다. 하늘배가 약 5분마다 {zone:1456} 북쪽, {area:17045} 남쪽 절벽에서 출발합니다({area:279}에서도 출발하며, 어느 진영이든 둘 다 탈 수 있습니다). 이미 섬에 있다면 건너뛰세요.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}은(는) 스카이본의 시작 섬이며 누구나 방문할 수 있습니다. 하늘배가 약 5분마다 {area:279} 북쪽에서 출발합니다({zone:1456} 북쪽에서도 출발하며, 어느 진영이든 둘 다 탈 수 있습니다). 이미 섬에 있다면 건너뛰세요.",
}
