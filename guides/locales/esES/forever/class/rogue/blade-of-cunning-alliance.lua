-- Spanish (Spain) (esES): the guide forever/class/rogue/blade-of-cunning-alliance (forever/class/rogue/blade-of-cunning-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Alliance)"] = "{item:7298} (Alianza)",
	["A dagger at 10 from your home town's rogue quests."] = "Una daga a nivel 10 de las misiones de pícaro de tu ciudad natal.",

	-- Step 1: Seek out SI: 7
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["At 10 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}."] = "A nivel 10, {npc:917}, el instructor de pícaros de la posada Orgullo de León en {area:87}, te da un paquete para {npc:332} en {zone:1453}.",

	-- Step 2: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Cabalga al norte hasta {zone:1453}; Mathias Shaw está en el IV:7, en {object:2100}.",

	-- Step 3: Defias Dockmaster
	-- {npc:6846} Defias Dockmaster · {area:87} Goldshire
	["The {npc:6846} stands by the river at Elwynn's southern edge, south of {area:87}. He carries the shipping schedule."] = "El {npc:6846} está junto al río, en el extremo sur del Bosque de Elwynn, al sur de {area:87}. Lleva el horario de envíos.",

	-- Step 4: Back to Mathias Shaw
	["Back to Mathias Shaw"] = "De vuelta con Mathias Shaw",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7"] = "{npc:332}, IV:7",

	-- Step 5: Road to Salvation
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 10 {npc:1234}, the rogue trainer in the {area:2102} in {area:131}, sends you to {npc:5165} in {zone:1455}."] = "A nivel 10, {npc:1234}, el instructor de pícaros de la {area:2102} en {area:131}, te envía con {npc:5165} en {zone:1455}.",

	-- Step 6: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["{npc:5165} stands in the north of {zone:1455}."] = "{npc:5165} está en el norte de {zone:1455}.",

	-- Step 7: Onin MacHammar
	-- {npc:6886} Onin MacHammar · {area:133} Gnomeregan · {zone:1426} Dun Morogh
	["{npc:6886} waits near {area:133}, in western {zone:1426}."] = "{npc:6886} espera cerca de {area:133}, en el oeste de {zone:1426}.",

	-- Step 8: Back to Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard
	["Back to {npc:5165}"] = "De vuelta con {npc:5165}",

	-- Step 9: The Apple Falls
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {npc:4163} Syurna · {zone:1457} Darnassus
	["At 10 {npc:3599}, the rogue trainer in {area:186}, gives you a rose for {npc:4163} in {zone:1457}."] = "A nivel 10, {npc:3599}, el instructor de pícaros de {area:186}, te da una rosa para {npc:4163} en {zone:1457}.",

	-- Step 10: Syurna
	-- {zone:1457} Darnassus · {npc:4163} Syurna
	["Ride west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "Cabalga al oeste hasta {zone:1457}. {npc:4163} está en el noroeste de la ciudad.",

	-- Step 11: Sethir the Ancient
	-- {npc:6909} Sethir the Ancient · {zone:1438} Teldrassil · {zone:1457} Darnassus
	["{npc:6909} lives in the north of {zone:1438}, north-east of {zone:1457}. Take his journal."] = "{npc:6909} vive en el norte de {zone:1438}, al noreste de {zone:1457}. Coge su diario.",

	-- Step 12: Back to Syurna
	-- {npc:4163} Syurna
	["Back to {npc:4163}"] = "De vuelta con {npc:4163}",
}
