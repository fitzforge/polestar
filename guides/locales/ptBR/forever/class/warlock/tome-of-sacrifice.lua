-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["At 60 {npc:14463} waits in the {area:73}, the demon-filled hollow in the west of the {zone:1419}. The Scar is full of hard-hitting elites: Soulstone yourself first, then keep to the right-hand wall going in, or ride through mounted. {npc:14463} gives you two errands at once."] = "No nível 60, {npc:14463} espera em {area:73}, a depressão cheia de demônios no oeste de {zone:1419}. A Cicatriz é cheia de elites que batem forte: use Pedra da Alma em você primeiro, depois mantenha-se na parede da direita ao entrar, ou atravesse montado. {npc:14463} entrega duas tarefas de uma vez.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {item:18249} Crescent Key · {zone:1444} Feralas
	["The Wildspawn satyrs (level 55-57, elite) fill the Warpwood Quarter, {area:2577}'s eastern wing: bring a group of five. Four in five drop a blood, but they do not come back for two hours and one full clear may come up short of fifteen; reset and run it again. The back door at {area:2518} needs the {item:18249}, which drops inside this wing; until someone has it, go in by {area:2577}'s main gate in central {zone:1444}."] = "Os sátiros Wildspawn (nível 55-57, elite) enchem o Quarteirão Warpwood, a ala leste de {area:2577}: leve um grupo de cinco. Quatro em cinco soltam um sangue, mas não voltam por duas horas e uma limpeza completa pode ficar abaixo de quinze; reinicie e refaça. A porta dos fundos em {area:2518} precisa de {item:18249}, que cai dentro desta ala; até alguém ter, entre pelo portão principal de {area:2577}, no centro de {zone:1444}.",
	-- {item:18603} Satyr Blood
	["{item:18603}, from the Wildspawn inside"] = "{item:18603}, dos Wildspawn lá dentro",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring · {spell:7645} Dominate Mind · {spell:710} Banish
	["The Hederine demons (level 57-60, elite) hold {area:2256} in the far south of {zone:1452}: grouping up is encouraged. Two Slayers guard the gorge past the bridge; the western tunnel leads to more Initiates, the easiest of them (watch for their {spell:7645}). A warlock can solo them one at a time with Fear or {spell:710} and damage over time, but slowly. Any of them can drop the Tears, four kills in five."] = "Os demônios Hederine (nível 57-60, elite) ocupam {area:2256}, no extremo sul de {zone:1452}: vale a pena formar grupo. Dois Matadores guardam a garganta depois da ponte; o túnel do oeste leva a mais Iniciados, os mais fáceis (cuidado com o {spell:7645} deles). Um bruxo consegue sozinho, um de cada vez, com Medo ou {spell:710} e dano ao longo do tempo, mas devagar. Qualquer um deles pode soltar as Lágrimas, quatro mortes em cinco.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {spell:45} War Stomp · {item:18605} Imprisoned Doomguard
	["Hand both in to {npc:14463} and take the {item:18601}. Find a {npc:12396} (level 61, elite) standing alone in the {area:73}, open from about 30 yards with your voidwalker on him, and channel the prison on him for about 20 seconds: he attacks you to break free, and his {spell:45} can interrupt the channel, so sacrifice the voidwalker for its shield if you must. Grouping up is encouraged: a second player to tank makes it easy. When the channel finishes he becomes the {item:18605}: click it. If the channel breaks, kill him or run, and try another."] = "Entregue os dois a {npc:14463} e pegue {item:18601}. Encontre um {npc:12396} (nível 61, elite) sozinho em {area:73}, abra de uns 30 metros com seu emissário do caos nele e canalize a prisão nele por uns 20 segundos: ele ataca você para se soltar, e o {spell:45} dele pode interromper a canalização, então sacrifique o emissário pelo escudo, se precisar. Vale a pena formar grupo: um segundo jogador para tankar facilita. Quando a canalização termina, ele vira {item:18605}: clique. Se a canalização quebrar, mate-o ou fuja e tente outro.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on a {npc:12396}"] = "{item:18601}, em um {npc:12396}",
	-- {item:18605} Imprisoned Doomguard
	["{item:18605}, click it"] = "{item:18605}, clique",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "De volta a {npc:14463}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "No nível 60, {npc:14463} espera na {area:73}, no oeste das {zone:1419}.",
	-- ["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Entregue os dois a {npc:14463} depois encontre o {npc:12396} na {area:73} e use a {item:18601} nele. Ele é elite e luta para escapar: é recomendado formar grupo.",
	-- ["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Os demônios Hederine ocupam o {area:2256}, no sul de {zone:1452}. Eles são elite: é recomendado formar grupo.",
	-- ["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Os sátiros Criasselvagem do Bairro Lenhatorta, a ala leste de {area:2577}, levam o sangue. A porta dos fundos no {area:2518}, ao norte do {area:1099}, requer a {item:18249}; caso contrário, entre pela entrada principal de {area:2577}. Leve um grupo.",
	-- ["{item:18601}, on the {npc:12396}"] = "{item:18601}, no {npc:12396}",
	-- ["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, dentro do Bairro Lenhatorta",
}
