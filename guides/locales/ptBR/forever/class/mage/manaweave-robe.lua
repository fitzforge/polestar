-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "Um manto no nível 15 para magos da Aliança, em {zone:1453} e {zone:1432}.",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire
	["{npc:328} is the {area:87} mage trainer, upstairs in the Lion's Pride Inn."] = "{npc:328} é o instrutor de mago de {area:87}, no andar de cima da estalagem.",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312} treina magos na {object:32362} de {zone:1455}. Depois, pegue o {area:2257} em {object:171524} até {zone:1453}.",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}: climb the spiral ramp and take the portal near the top. The {item:7247} and the {item:7308} lie on the table behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:5497} fica no topo do Sacrário dos Teurgos, a torre violeta do {object:2101}: suba a rampa em espiral e pegue o portal perto do topo. O {item:7247} e o {item:7308} ficam na mesa atrás dela (os dois voltam 5 minutos depois que alguém pega). Você entrega os dois no fim, então guarde.",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {spell:122} Frost Nova · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["{object:2169} is the tavern in the {object:2101}. Read the {item:7308} inside to make the invisible Rift Spawns (level 16-17) show: in the basement it brings out one, on the balcony or in the kitchen two, in the main room or by the door three, so read it downstairs. They hit hard and break out of {spell:122} fast. Beat one down: it does not die but sits stunned with a spiral over its head; use the {item:7247} on it while it is stunned, then click the {item:7292} it leaves on the floor (clicking before it appears wastes a charge). You need three, and the cantation works only once every 5 minutes (logging out does not reset it), so plan on three rounds."] = "{object:2169} é a taberna do {object:2101}. Leia o {item:7308} lá dentro para fazer as Aparições Etéreas invisíveis (nível 16-17) aparecerem: no porão sai uma, na sacada ou na cozinha duas, no salão principal ou na porta três, então leia lá embaixo. Elas batem forte e escapam rápido de {spell:122}. Deixe uma no chão: ela não morre, fica atordoada com uma espiral em cima da cabeça; use o {item:7247} nela enquanto estiver atordoada e depois clique no {item:7292} que ela deixa no chão (clicar antes de ele aparecer gasta uma carga). Você precisa de três, e o cantochão só funciona uma vez a cada 5 minutos (deslogar não reinicia), então conte com três rodadas.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, até ficar atordoada",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, na {npc:6492} atordoada",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "Volte a {npc:5497}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {area:149} Silver Stream Mine · {object:2096} Trade District
	["Any humanoid drops {item:2589}, and the Tunnel Rats in the {area:149} drop it while you gather the gems; the Auction House in the {object:2096} sells it. You hand in ten."] = "Qualquer humanoide deixa cair {item:2589}, e os Ratatúneis de {area:149} deixam cair enquanto você junta as gemas; a Casa de Leilões do {object:2096} vende. Você entrega dez.",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "{area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine · {area:144} Thelsamar · {object:271} Miners' League Crates
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The {area:149} is at the north end of the loch, north of {area:144}; Tunnel Rat kobolds hold it. The gems come only from the tall stacked {object:271} (the cursor shows a cog over them; single boxes hold nothing): every crate gives one, there are fourteen and they come back after 3 to 5 minutes. You may have to go as deep as the end chamber for six. The same crates serve the dwarves' Filthy Paws quest."] = "Pegue {area:2257} até {zone:1455} e depois a estrada para leste pelo túnel do Portão Sul até {zone:1432}. {area:149} fica na ponta norte do lago, ao norte de {area:144}; kobolds Ratatúnel ocupam a mina. As gemas só saem dos {object:271} altos e empilhados (o cursor mostra uma engrenagem neles; caixa sozinha não tem nada): cada caixote dá uma, são catorze e voltam depois de 3 a 5 minutos. Talvez você tenha que ir até a câmara do fundo para juntar seis. Os mesmos caixotes servem para a missão Patas nojentas dos anões.",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "Volte a {zone:1453} pelo metrô. {npc:1309} trabalha em {object:23296}, no {object:2101}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "Humanoides soltam {item:2589}; a Casa de Leilões do {object:2096} também vende.",
	-- ["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "Pegue o {area:2257} até {zone:1455} e siga a estrada para o leste pelo túnel do Portão Sul até {zone:1432}. A liga de mineiros anões deixou os caixotes na {area:149}, no norte do lago; troggs Rato-de-túnel ocupam a mina.",
	-- ["{npc:328} is the {area:87} mage trainer."] = "{npc:328} é o instrutor de magos de {area:87}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497} fica no Sacrário dos Teurgos, a torre do {object:2101}. O {item:7247} e a {item:7308} estão atrás dela.",
	-- ["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169} é a taverna do {object:2101}. Use a {item:7308} lá dentro para tornar visível a {npc:6492}, domine uma com seus feitiços e use o {item:7247} para lançar um cofre e capturá-la.",
}
