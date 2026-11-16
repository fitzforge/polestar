-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/neutral/swift-galestrider (forever/collectibles/mounts/neutral/swift-galestrider.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Galestrider"] = "迅捷逐風者",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {skill:762} Riding
	["Swift Galestriders need level 60 and Journeyman {skill:762}. Train it at your own race's riding trainer; see the Level 60 mount guides for where."] = "迅捷逐風者需要60級和中級{skill:762}。向你自己種族的騎術訓練師學習；地點請見60級坐騎指南。",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "從{area:279}搭乘天空船",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔精靈的起始島嶼；任何人都可以前往。天空船約每五分鐘從{area:279}北側出發（另一艘從{zone:1456}北邊起飛；兩個陣營都可搭乘任一艘）。如果你已在島上，跳過此步。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "搭乘天空船前往{zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "從{zone:1456}搭乘天空船",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔精靈的起始島嶼；任何人都可以前往。天空船約每五分鐘從{zone:1456}北邊、{area:17045}南側的懸崖出發（另一艘從{area:279}起飛；兩個陣營都可搭乘任一艘）。如果你已在島上，跳過此步。",

	-- Step 4: Journeyman Riding with Genn Fairweather
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["Journeyman {skill:762} with {npc:265756}"] = "",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Skyborne train Journeyman {skill:762} with {npc:265756} himself for 1,000g; Blizzard says it comes with a mount. He stands at the {area:17684} in {area:16638}, near the skyboat docks."] = "",
	-- {npc:265756} Genn Fairweather
	["{npc:265756}, riding trainer"] = "",

	-- Step 5: Galestrider Riding for other races
	-- {spell:1285849} Galestrider Riding
	["{spell:1285849} for other races"] = "",
	-- {spell:1285849} Galestrider Riding · {skill:762} Riding · {npc:265756} Genn Fairweather
	["Any race can buy Galestriders, but riding one also takes {spell:1285849}, which only the Skyborne get with {skill:762}. Other races can learn it too, but how is not known yet: in Classic another race's riding needed Exalted with its home faction, here the High Order (Alliance) or the Windshapers (Horde). Ask {npc:265756} before you buy."] = "",

	-- Step 6: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756} is at the {area:17684} in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756}在島上的港口城鎮{area:16638}的{area:17684}，靠近天空船碼頭。Forever用戶端標價每隻迅捷逐風者200金；選一隻。",
	["200g"] = "200金",
}
