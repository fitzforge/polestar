-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/neutral/deathcharger (forever/collectibles/mounts/neutral/deathcharger.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Deathcharger"] = "Corcel da Morte",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {item:13335} Deathcharger's Reins · {skill:762} Riding
	["{item:13335} needs level 60 and Journeyman {skill:762} to ride (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "As {item:13335} exigem nível 60 e {skill:762} (Profissional) para montar (cliente Forever). Treine com o instrutor de montaria da sua raça; veja os guias de montaria de nível 60.",

	-- Step 2: Stratholme: Baron Rivendare
	-- {area:2279} Stratholme · {object:175461} Service Entrance (no name in this language: may be words) · {object:175440} Elders' Square (no name in this language: may be words) · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare
	["{area:2279} is a group of five, level 58-60. The {object:175461} at {object:175440}, in north-western {zone:1423}, leads to the undead side; {npc:10440} waits in the Slaughter House at its end. Our data gives the reins a 0.02% drop chance (pfQuest, Era): one in about five thousand kills. Nothing shows Forever changing it."] = "{area:2279} é para grupo de cinco, nível 58-60. A {object:175461} em {object:175440}, no noroeste das {zone:1423}, leva ao lado morto-vivo; {npc:10440} espera no Abatedouro, no fim dele. Nossos dados dão às rédeas 0,02% de chance de queda (pfQuest, Era): uma em cerca de cinco mil mortes. Nada indica que o Forever mudou isso.",
	-- {object:175461} Service Entrance (no name in this language: may be words)
	["Stratholme {object:175461}"] = "Stratholme: {object:175461}",
}
