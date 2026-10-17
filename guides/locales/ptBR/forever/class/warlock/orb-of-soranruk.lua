-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/orb-of-soranruk (forever/class/warlock/orb-of-soranruk.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "Um orbe de mão secundária ou um cajado raro para o fim dos seus 20, em troca de fragmentos de duas masmorras.",

	-- Step 1: Doan Karhan
	-- {npc:6247} Doan Karhan · {zone:1413} Barrens · {area:378} Camp Taurajo
	["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247} acampa no sul dos {zone:1413}, a leste da estrada a nordeste de {area:378}.",

	-- Step 2: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {item:6914} Soran'ruk Fragment · {zone:1440} Ashenvale
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "Cada Acólito do Crepúsculo dentro de {area:2797}, uma masmorra de nível 24-32, deixa cair um {item:6914}: leve um grupo. A entrada fica nas ruínas da costa noroeste de {zone:1440}.",
	-- {item:6914} Soran'ruk Fragment
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["{item:6914}, from the Twilight Acolytes"] = "{item:6914}, dos Acólitos do Crepúsculo",

	-- Step 3: Shadowfang Keep
	-- {area:236} Shadowfang Keep · {area:228} Sepulcher
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "Os Almanegras Presa Negra dentro de {area:236}, uma masmorra de nível 20-30, deixam cair o Fragmento Grande cerca de uma vez em cinco: leve um grupo. A fortaleza fica ao sul de {area:228}.",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}, dos Almanegras Presa Negra",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "De volta a {npc:6247}",
}
