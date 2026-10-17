-- Russian (ruRU): the guide forever/class/rogue/blade-of-cunning-alliance (forever/class/rogue/blade-of-cunning-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Alliance)"] = "{item:7298} (Альянс)",
	["A dagger at 10 from your home town's rogue quests."] = "Кинжал на 10-м уровне за задания разбойников в вашем родном городе.",

	-- Step 1: Seek out SI: 7
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["At 10 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}."] = "На 10-м уровне {npc:917}, учитель разбойников в таверне ({area:87}), дает вам сверток для персонажа {npc:332} ({zone:1453}).",

	-- Step 2: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Езжайте на север: {zone:1453}. Мастер Матиас Шоу – в здании ШРУ ({object:2100}).",

	-- Step 3: Defias Dockmaster
	-- {npc:6846} Defias Dockmaster · {area:87} Goldshire
	["The {npc:6846} stands by the river at Elwynn's southern edge, south of {area:87}. He carries the shipping schedule."] = "{npc:6846} стоит у реки на южном краю Элвиннского леса, к югу от места {area:87}. Расписание поставок – у него.",

	-- Step 4: Back to Mathias Shaw
	["Back to Mathias Shaw"] = "Назад к Матиасу Шоу",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7"] = "{npc:332}, ШРУ",

	-- Step 5: Road to Salvation
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 10 {npc:1234}, the rogue trainer in the {area:2102} in {area:131}, sends you to {npc:5165} in {zone:1455}."] = "На 10-м уровне {npc:1234}, учитель разбойников ({area:2102}, {area:131}), отправляет вас к персонажу {npc:5165} ({zone:1455}).",

	-- Step 6: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["{npc:5165} stands in the north of {zone:1455}."] = "{npc:5165} стоит в северной части города ({zone:1455}).",

	-- Step 7: Onin MacHammar
	-- {npc:6886} Onin MacHammar · {area:133} Gnomeregan · {zone:1426} Dun Morogh
	["{npc:6886} waits near {area:133}, in western {zone:1426}."] = "{npc:6886} ждет рядом с местом {area:133}, на западе зоны {zone:1426}.",

	-- Step 8: Back to Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard
	["Back to {npc:5165}"] = "Назад к {npc:5165}",

	-- Step 9: The Apple Falls
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {npc:4163} Syurna · {zone:1457} Darnassus
	["At 10 {npc:3599}, the rogue trainer in {area:186}, gives you a rose for {npc:4163} in {zone:1457}."] = "На 10-м уровне {npc:3599}, учитель разбойников ({area:186}), дает вам розу для персонажа {npc:4163} ({zone:1457}).",

	-- Step 10: Syurna
	-- {zone:1457} Darnassus · {npc:4163} Syurna
	["Ride west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "Езжайте на запад: {zone:1457}. {npc:4163} стоит в северо-западной части города.",

	-- Step 11: Sethir the Ancient
	-- {npc:6909} Sethir the Ancient · {zone:1438} Teldrassil · {zone:1457} Darnassus
	["{npc:6909} lives in the north of {zone:1438}, north-east of {zone:1457}. Take his journal."] = "{npc:6909} живет на севере зоны {zone:1438}, к северо-востоку от города {zone:1457}. Заберите его дневник.",

	-- Step 12: Back to Syurna
	-- {npc:4163} Syurna
	["Back to {npc:4163}"] = "Назад: {npc:4163}",
}
