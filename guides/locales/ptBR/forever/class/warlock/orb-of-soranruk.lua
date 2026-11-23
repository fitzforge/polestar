-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/orb-of-soranruk (forever/class/warlock/orb-of-soranruk.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare off-hand orb or staff for your 20s, for fragments from two dungeons."] = "Um orbe raro de mão secundária ou um cajado para os seus 20 e poucos níveis, por fragmentos de duas masmorras.",

	-- Step 1: Doan Karhan
	-- {npc:6247} Doan Karhan · {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {zone:1413} Barrens · {area:392} Ratchet · {area:2797} Blackfathom Deeps · {area:236} Shadowfang Keep
	["{npc:6247} camps beside {npc:6244}, at a tent just north-east of {area:378} in the southern {zone:1413}. Alliance warlocks reach him from {area:392} or Theramore; Horde ones head south from the Crossroads. He wants fragments from two dungeons: take the quest before your {area:2797} and {area:236} runs."] = "{npc:6247} acampa ao lado de {npc:6244}, numa tenda a nordeste de {area:378}, no sul de {zone:1413}. Bruxos da Aliança chegam a ele de {area:392} ou Theramore; os da Horda vão para o sul saindo da Encruzilhada. Ele quer fragmentos de duas masmorras: pegue a missão antes das suas idas a {area:2797} e {area:236}.",

	-- Step 2: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {area:414} Zoram Strand · {npc:4832} Twilight Lord Kelris · {npc:4829} Aku'mai
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["{area:2797} (level 24-32, a group of five) opens in the ruins on the north-west coast of {zone:1440}, under the water at {area:414}. The Twilight Acolytes (level 24-25, elite, healers) stand in the last halls, around {npc:4832} and the altar before {npc:4829}; each one drops a fragment, but only three spawn in a run and they do not come back for two hours, so one run covers one warlock: kill them first, before they heal the rest."] = "{area:2797} (nível 24-32, grupo de cinco) abre nas ruínas da costa noroeste de {zone:1440}, embaixo d'água em {area:414}. Os Acólitos do Crepúsculo (nível 24-25, elite, curandeiros) ficam nos últimos salões, em volta de {npc:4832} e do altar diante de {npc:4829}; cada um solta um fragmento, mas só três aparecem por corrida e eles não voltam por duas horas, então uma corrida serve a um bruxo: mate-os primeiro, antes que curem os outros.",
	-- plural, as words: Soran'ruk Fragments = {item:6914} Soran'ruk Fragment · Twilight Acolytes = {npc:4809} Twilight Acolyte
	["Soran'ruk Fragments, from the Twilight Acolytes inside"] = "Fragmentos de Soran'ruk, dos Acólitos do Crepúsculo lá dentro",

	-- Step 3: Shadowfang Keep
	-- {area:236} Shadowfang Keep · {area:228} Sepulcher
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{area:236} (level 22-30, a group of five) stands on the hill south of the {area:228}. Free the prisoner in the cells right of the entrance and he opens the way into the courtyard. The Shadowfang Darksouls (level 20-21, elite) are not in the courtyard: they walk the halls past it, up the ramp that curves left and in the building after. About twelve stand in a run and one in five drops the Large Fragment, so clear every Darksoul and run it again if it does not drop."] = "{area:236} (nível 22-30, grupo de cinco) fica no morro ao sul de {area:228}. Liberte o prisioneiro nas celas à direita da entrada e ele abre o caminho para o pátio. As Almanegras Presa Negra (nível 20-21, elite) não ficam no pátio: andam pelos salões depois dele, pela rampa que curva à esquerda e no prédio seguinte. Cerca de doze aparecem por corrida e uma em cinco solta o Fragmento Grande, então limpe todas as Almanegras e refaça a corrida se não cair.",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls inside"] = "{item:6915}, das Almanegras Presa Negra lá dentro",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "De volta a {npc:6247}",
	-- {item:6898} Orb of Soran'ruk · {item:15109} Staff of Soran'ruk
	["Choose the off-hand {item:6898} or the two-handed {item:15109}."] = "Escolha {item:6898}, de mão secundária, ou {item:15109}, de duas mãos.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "Um orbe de mão secundária ou um cajado raro para o fim dos seus 20, em troca de fragmentos de duas masmorras.",
	-- ["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "Os Almanegras Presa Negra dentro de {area:236}, uma masmorra de nível 20-30, deixam cair o Fragmento Grande cerca de uma vez em cinco: leve um grupo. A fortaleza fica ao sul de {area:228}.",
	-- ["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "Cada Acólito do Crepúsculo dentro de {area:2797}, uma masmorra de nível 24-32, deixa cair um {item:6914}: leve um grupo. A entrada fica nas ruínas da costa noroeste de {zone:1440}.",
	-- ["{item:6914}, from the Twilight Acolytes"] = "{item:6914}, dos Acólitos do Crepúsculo",
	-- ["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}, dos Almanegras Presa Negra",
	-- ["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247} acampa no sul dos {zone:1413}, a leste da estrada a nordeste de {area:378}.",
}
