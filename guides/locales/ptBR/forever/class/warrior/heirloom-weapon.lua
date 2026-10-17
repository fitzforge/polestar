-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} e uma arma de uma mão à sua escolha no nível 10.",

	-- Step 1: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} fica em {area:159}. {npc:6390} espera no mausoléu na colina logo ao norte da cidade: abra o portão e enfrente-o.",

	-- Step 2: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500} está na estalagem, a {area:2119}, em {area:159}.",

	-- Step 3: Agamand Mills
	-- {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "Os quatro Cavaletes de Armas dos Agamand ficam entre os prédios de {area:157}, ao norte de {area:159}. Os mortos-vivos dos moinhos atacam assim que veem você.",

	-- Step 4: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "De volta a {npc:1500}",
}
