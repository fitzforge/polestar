-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/voidwalker-alliance (forever/class/warlock/voidwalker-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Alliance)"] = "Emissário do Caos (Aliança)",
	-- {npc:6122} Gakin the Darkbinder
	["Your tank demon at 10: the voidwalker, after a dark sorceress's choker and a fight in {npc:6122}'s crypt."] = "Seu demônio tanque no nível 10: o emissário do caos, depois do colar de uma feiticeira sombria e de uma luta na cripta de {npc:6122}.",

	-- Step 1: Gakin's Summons (Humans)
	-- {quest:1685} Gakin's Summons
	["{quest:1685} (Humans)"] = "{quest:1685} (Humanos)",
	-- {npc:6121} Remen Marcot · {area:87} Goldshire · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 10 {npc:6121}, in the cellar of the Lion's Pride Inn in {area:87} (the stairs down are in the back room past the butcher's table), sends you to {npc:6122} in {zone:1453}."] = "No nível 10, {npc:6121}, no porão da Estalagem Orgulho do Leão, em {area:87} (a escada para baixo fica no quarto dos fundos, depois da mesa do açougueiro), manda você para {npc:6122}, em {zone:1453}.",
	-- {npc:6121} Remen Marcot
	["{npc:6121}, Lion's Pride Inn cellar"] = "{npc:6121}, porão da Lion's Pride Inn",

	-- Step 2: The Slaughtered Lamb (Gnomes)
	-- {quest:1715} The Slaughtered Lamb
	["{quest:1715} (Gnomes)"] = "{quest:1715} (Gnomos)",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 10 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257} from {object:171524}. If {npc:6120} does not offer it, go to {npc:6122} anyway: he still gives you the next quest."] = "No nível 10, {npc:6120}, o instrutor de bruxo na {object:32383} de {zone:1455}, manda você para {npc:6122}, em {zone:1453}. Pegue o {area:2257} a partir de {object:171524}. Se {npc:6120} não oferecer, vá até {npc:6122} mesmo assim: ele ainda entrega a próxima missão.",

	-- Step 3: Gakin the Darkbinder
	-- {quest:1715} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{quest:1715} is the tavern in the {object:2101}; {npc:6122} is in its cellar, down the stairs inside."] = "{quest:1715} é a taberna do {object:2101}; {npc:6122} fica no porão dela, descendo as escadas lá dentro.",

	-- Step 4: Surena Caledon
	-- {npc:881} Surena Caledon · {area:62} Brackwell Pumpkin Patch · {npc:473} Morgan the Collector
	["{npc:881} (level 9) is inside the farmhouse at the {area:62}, south-east Elwynn near the Redridge road. {npc:473} (level 10) and a warrior stand with her and join the fight; Morgan gouges and goes for your imp, so keep him Feared. Put your damage over time on {npc:881} first, Fear the others, and loot her choker before you finish them: it stays yours even if you die after. She throws fireballs from range and is back three minutes after she dies. Have the quest before you kill her, or the choker does not drop."] = "{npc:881} (nível 9) está dentro da casa de fazenda em {area:62}, no sudeste de Elwynn, perto da estrada de Cristarrubra. {npc:473} (nível 10) e um guerreiro ficam com ela e entram na luta; Morgan fere e vai atrás do seu diabrete, então mantenha-o sob Medo. Ponha seu dano ao longo do tempo em {npc:881} primeiro, use Medo nos outros e saqueie o colar dela antes de acabar com eles: ele continua seu mesmo que você morra depois. Ela joga bolas de fogo à distância e volta três minutos depois de morrer. Tenha a missão antes de matá-la, senão o colar não cai.",

	-- Step 5: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:6122}. He hands you the {item:6928}. The circle is hard to find: take the stairs behind {npc:6122} down; part way along the lowest corridor a side stair on the left leads into a room with a glowing purple circle in the middle. Stand on it and use the choker. The voidwalker (level 10, not elite) gets dangerous below 30% health: {spell:14868}, Corruption and {spell:348} with your imp on it, Fear when it gets close. If it beats you, use the choker again. Keep the choker: {npc:6122} takes it back."] = "De volta a {npc:6122}. Ele entrega {item:6928} a você. O círculo é difícil de achar: desça as escadas atrás de {npc:6122}; no meio do corredor mais baixo, uma escada lateral à esquerda leva a uma sala com um círculo roxo brilhante no meio. Fique nele e use o colar. O emissário do caos (nível 10, não elite) fica perigoso abaixo de 30% de vida: {spell:14868}, Corrupção e {spell:348} com seu diabrete nele, Medo quando ele chegar perto. Se ele vencer você, use o colar de novo. Guarde o colar: {npc:6122} pega de volta.",
	-- {item:6928} Bloodstone Choker
	["{item:6928}, on the circle in the crypt"] = "{item:6928}, no círculo da cripta",
}
