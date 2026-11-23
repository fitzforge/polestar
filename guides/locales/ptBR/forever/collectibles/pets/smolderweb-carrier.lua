-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{npc:10260} em {area:251}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12264} Worg Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He also gives {npc:10260}'s Exotic Pets (the {item:12264}): take both, they are done in the same run."] = "{npc:10260} fica dentro da caverna em {area:251}, o acampamento no norte de {zone:1428}, a leste de {area:254}. Ele também entrega os Animais Exóticos de {npc:10260} ({item:12264}): pegue os dois, são feitos na mesma corrida.",

	-- Step 2: Lower Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583} Inferior",
	-- {area:1583} Blackrock Spire · {area:254} Blackrock Mountain · {npc:10596} Mother Smolderweb
	-- plural, as words: Spire Spider Eggs = {item:12530} Spire Spider Egg
	["Lower {area:1583} is a group of five, level 55-60, inside {area:254}. The Spire Spider Eggs lie around {npc:10596}'s nest in the Skitterweb Tunnels, the spider halls: click them until you have 15 (each gives one to three). Hard-hitting spiderlings can hatch as you loot. By player reports the eggs cannot be looted in a raid group, so keep the party at five or fewer."] = "Lower {area:1583} é um grupo de cinco, nível 55-60, dentro de {area:254}. Os Ovos de Aranha do Pináculo ficam em volta do ninho de {npc:10596} nos Skitterweb Tunnels, os salões das aranhas: clique neles até ter 15 (cada um dá de um a três). Aracnídeos que batem forte podem chocar enquanto você saqueia. Segundo relatos de jogadores, os ovos não podem ser saqueados em grupo de raide, então mantenha o grupo em cinco ou menos.",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "De volta a {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "{area:1583} Inferior é para um grupo de cinco, nível 55-60. Colete 15 Ovos de Aranha do Pináculo nos ninhos perto de {npc:10596}.",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} fica em {area:251}, no norte das {zone:1428}, perto da trilha para a {area:254}.",
}
