-- Russian (ruRU): the guide forever/collectibles/mounts/neutral/swift-galestrider (forever/collectibles/mounts/neutral/swift-galestrider.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Galestrider"] = "Стремительный буреног",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762}: подмастерье",
	-- {skill:762} Riding
	["Swift Galestriders need level 60 and Journeyman {skill:762} from a riding trainer of your faction; see the Level 60 mount guides for where."] = "Для стремительных буреногов нужны 60-й уровень и навык {skill:762} (подмастерье) от учителя верховой езды вашей фракции; где его найти, см. в гайдах по средствам передвижения 60-го уровня.",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Небесный корабль: {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} — стартовый остров Небеснорожденных; посетить его может любой. Небесный корабль отправляется с северной стороны места {area:279} примерно каждые пять минут (еще один летает с севера города {zone:1456}; обе фракции могут садиться на любой). Пропустите это, если вы уже на острове.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Небесный корабль: {zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Небесный корабль: {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} — стартовый остров Небеснорожденных; посетить его может любой. Небесный корабль отправляется от утесов к югу от места {area:17045}, к северу от города {zone:1456}, примерно каждые пять минут (еще один летает из места {area:279}; обе фракции могут садиться на любой). Пропустите это, если вы уже на острове.",

	-- Step 4: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756} находится здесь: {area:16638} — портовый город острова, рядом с пристанью небесных кораблей. Клиент Forever указывает цену каждого стремительного буренога 200 з.; выберите одного.",
	["200g"] = "200 з.",
}
