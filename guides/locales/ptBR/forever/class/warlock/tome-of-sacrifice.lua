-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {zone:1419} Blasted Lands
	["A rare off-hand at 60, {npc:14463}'s payment for capturing a {npc:12396} in the {zone:1419}."] = "Um item de mão secundária raro no nível 60, o pagamento de {npc:14463} por capturar um {npc:12396} nas {zone:1419}.",

	-- Step 1: Daio the Decrepit
	-- {npc:14463} Daio the Decrepit · {area:73} Tainted Scar · {zone:1419} Blasted Lands
	["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "No nível 60, {npc:14463} espera na {area:73}, no oeste das {zone:1419}.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {area:1099} Camp Mojache · {item:18249} Crescent Key
	["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Os sátiros Criasselvagem do Bairro Lenhatorta, a ala leste de {area:2577}, levam o sangue. A porta dos fundos no {area:2518}, ao norte do {area:1099}, requer a {item:18249}; caso contrário, entre pela entrada principal de {area:2577}. Leve um grupo.",
	-- {item:18603} Satyr Blood
	["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, dentro do Bairro Lenhatorta",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Os demônios Hederine ocupam o {area:2256}, no sul de {zone:1452}. Eles são elite: é recomendado formar grupo.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {item:18601} Glowing Crystal Prison
	["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Entregue os dois a {npc:14463} depois encontre o {npc:12396} na {area:73} e use a {item:18601} nele. Ele é elite e luta para escapar: é recomendado formar grupo.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on the {npc:12396}"] = "{item:18601}, no {npc:12396}",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "De volta a {npc:14463}",
}
