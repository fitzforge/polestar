-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/neutral/swift-galestrider (forever/collectibles/mounts/neutral/swift-galestrider.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Galestrider"] = "迅捷疾风陆行鸟",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {skill:762} Riding
	["Swift Galestriders need level 60 and Journeyman {skill:762}. Train it at your own race's riding trainer; see the Level 60 mount guides for where."] = "迅捷疾风陆行鸟需要60级和中级 {skill:762}。向本族骑术训练师学习；具体位置见60级坐骑指南。",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "从{area:279}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。天空飞船约每五分钟从{area:279}北侧出发一次（另一艘从{zone:1456}以北出发；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "乘天空飞船前往{zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "从{zone:1456}乘天空飞船",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔的起始岛屿；任何人都可以前往。天空飞船约每五分钟从{zone:1456}以北、{area:17045}以南的悬崖出发一次（另一艘从{area:279}出发；两个阵营都可以乘坐任意一艘）。如果你已经在岛上，跳过此步。",

	-- Step 4: Journeyman Riding with Genn Fairweather
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["Journeyman {skill:762} with {npc:265756}"] = "向{npc:265756}学习中级{skill:762}",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Skyborne train Journeyman {skill:762} with {npc:265756} himself for 1,000g; Blizzard says it comes with a mount. He stands at the {area:17684} in {area:16638}, near the skyboat docks."] = "天裔可直接向 {npc:265756} 学习中级 {skill:762}，费用 1,000 金币；暴雪说明该训练会附赠一只坐骑。他站在 {area:16638} 的 {area:17684}，靠近飞艇码头。",
	-- {npc:265756} Genn Fairweather
	["{npc:265756}, riding trainer"] = "{npc:265756}，骑术训练师",

	-- Step 5: Galestrider Riding for other races
	-- {spell:1285849} Galestrider Riding
	["{spell:1285849} for other races"] = "其他种族学习{spell:1285849}",
	-- {spell:1285849} Galestrider Riding · {skill:762} Riding · {npc:265756} Genn Fairweather
	["Any race can buy Galestriders, but riding one also takes {spell:1285849}, which only the Skyborne get with {skill:762}. Other races can learn it too, but how is not known yet: in Classic another race's riding needed Exalted with its home faction, here the High Order (Alliance) or the Windshapers (Horde). Ask {npc:265756} before you buy."] = "任何种族都能购买疾风陆行鸟，但骑乘还需要 {spell:1285849}，只有天裔学习 {skill:762} 时会一并获得。其他种族也能学习，但具体方法尚不清楚：经典怀旧服要求对应种族主城声望崇拜；这里对应的是高阶会（联盟）或塑风者码头管理员（部落）。购买前先询问 {npc:265756}。",

	-- Step 6: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756} is at the {area:17684} in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756} 位于岛上港口城镇 {area:16638} 的 {area:17684}，靠近空艇码头。无限服客户端列出的每只迅捷疾风陆行鸟价格为200金币；任选一只。",
	["200g"] = "200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Swift Galestriders need level 60 and Journeyman {skill:762} from a riding trainer of your faction; see the Level 60 mount guides for where."] = "迅捷疾风陆行鸟需要60级，以及在本阵营骑术训练师处学习的中级{skill:762}；地点参见60级坐骑指南。",
	-- ["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756}在岛上的港口小镇{area:16638}，靠近天空飞船码头。Forever客户端中每只迅捷疾风陆行鸟标价200金；选择一只。",
}
