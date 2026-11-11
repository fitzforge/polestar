-- Portuguese (Brazil) (ptBR): the guide forever/reputation/kirin-tor (forever/reputation/kirin-tor.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kirin Tor Reputation"] = "Reputação: Kirin Tor",
	-- {area:279} Dalaran
	["New in Forever: {area:279}'s mages sell Azure armour recipes at Friendly and their tabard at Exalted."] = "Novidade no Forever: os magos de {area:279} vendem receitas de armadura Lazúli em Amigável e o tabardo deles em Exaltado.",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["Eight Azure helm and shoulder recipes at Friendly ({skill:164}, {skill:165}, {skill:197})"] = "Oito receitas de elmo e ombreiras Lazúli em Amigável ({skill:164}, {skill:165}, {skill:197})",

	-- Step 1: Skyborne: the recipes now
	["Skyborne: the recipes now"] = "Celonatos: as receitas agora",
	-- {faction:2740} Kirin Tor · {npc:32287} Archmage Alvareaux · {area:279} Dalaran
	["Alliance Skyborne start Friendly with the {faction:2740}, and their arrival quests The Magical City of Dalaran and Exploring the Alliance pay 100 more each, so {npc:32287} sells you the Azure recipes at once (10g each, they need skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}, past the Sky Enclave. Buy the ones for your profession."] = "Os Celonatos da Aliança começam Amigáveis com {faction:2740}, e as missões de chegada deles, A cidade mágica de Dalaran e Explorando a Aliança, rendem mais 100 cada, então {npc:32287} vende as receitas Lazúli na hora (10g cada, exigem perícia 175). Ele fica no andar de cima do prédio com as bandeiras de {faction:2740} em {area:279}, depois do Enclave Celeste. Compre as da sua profissão.",

	-- Step 2: An Alarming Request
	-- {npc:247264} Emissary Jacques · {faction:2740} Kirin Tor · {area:271} Southshore · {npc:246748} Archmage Modera · {area:1338} Lordamere Lake · {area:279} Dalaran
	["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation at any level in Forever."] = "{npc:247264} do {faction:2740} espera em {area:271}. Ele manda você à imagem de {npc:246748}, na margem de {area:1338}, fora das muralhas de {area:279}. As missões do {faction:2740} começam do nível 24 ao 30 e pagam reputação cheia em qualquer nível no Forever.",

	-- Step 3: Archmage Modera's image
	-- {npc:246748} Archmage Modera
	["{npc:246748}'s image"] = "A imagem de {npc:246748}",
	-- {item:277507} Dalaran Sewer Key
	["you get the {item:277507} with it"] = "você recebe {item:277507} junto",

	-- Step 4: The City of Dalaran
	["The City of Dalaran"] = "A Cidade de Dalaran",
	-- {quest:92457} Starving Arcane · {npc:246020} Shade of the Archmage · {npc:246748} Archmage Modera · {item:251961} Arcane Mote · {faction:2740} Kirin Tor
	["The City of Dalaran is a dungeon for levels 28 to 33: go in through the sewers with the key Modera gave you. The arcane elementals throughout the city count for {quest:92457}. The {npc:246020}, the last boss, waits in the Purple Parlor above the Violet Citadel (a portal by {npc:246748} in the Citadel takes you up) and drops the {item:251961}. Beta players saw every kill in the dungeon pay {faction:2740} reputation, the bosses the most. Group of five advised below level 35."] = "A Cidade de Dalaran é uma masmorra para os níveis 28 a 33: entre pelos esgotos com a chave que Modera deu a você. Os elementais arcanos por toda a cidade contam para {quest:92457}. {npc:246020}, o último chefe, espera na Sala Púrpura, acima da Cidadela Violeta (um portal ao lado de {npc:246748}, na Cidadela, leva você até lá) e solta {item:251961}. Jogadores do beta viram toda morte na masmorra render reputação de {faction:2740}, os chefes mais. Grupo de cinco recomendado abaixo do nível 35.",
	-- {item:251961} Arcane Mote · {npc:246020} Shade of the Archmage
	["{item:251961}, from the {npc:246020}"] = "{item:251961}, de {npc:246020}",

	-- Step 5: Back to Modera's image
	["Back to Modera's image"] = "De volta à imagem de Modera",

	-- Step 6: Archmage Celindra
	-- {npc:252085} Archmage Celindra · {area:279} Dalaran
	["{npc:252085} waits in the Violet Citadel in {area:279}."] = "{npc:252085} espera na Cidadela Violeta, em {area:279}.",

	-- Step 7: Past Due
	-- {npc:264265} Magus Olvek · {area:279} Dalaran · {npc:6487} Arcanist Doan · {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["{npc:264265} in {area:279} wants a book back from {npc:6487}, the last boss of the {area:796}'s Library (levels 33 to 41), in {zone:1420}."] = "{npc:264265} em {area:279} quer um livro de volta de {npc:6487}, o último chefe da Biblioteca de {area:796} (níveis 33 a 41), em {zone:1420}.",

	-- Step 8: Arcanist Doan
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["The {area:796} stands in the north-east of {zone:1420}; Doan waits at the end of the Library wing. Group of five advised below level 40."] = "{area:796} fica no nordeste de {zone:1420}; Doan espera no fim da ala da Biblioteca. Grupo de cinco recomendado abaixo do nível 40.",
	-- {item:273169} The Lost Magic of the Runemasters · {npc:6487} Arcanist Doan
	["{item:273169}, from {npc:6487}"] = "{item:273169}, de {npc:6487}",

	-- Step 9: Back to Magus Olvek
	-- {npc:264265} Magus Olvek
	["Back to {npc:264265}"] = "De volta a {npc:264265}",

	-- Step 10: City of Dalaran runs to Friendly
	["City of Dalaran runs to Friendly"] = "Cidade de Dalaran até Amigável",
	["The quests leave a non-Skyborne at about 320 of the 3,000 Friendly needs. The rest comes from kills in the City of Dalaran dungeon: run it until Friendly. How much each kill pays is not in the game's data; the bosses pay the most. At 60 you clear it alone."] = "As missões deixam quem não é Celonato com cerca de 320 dos 3.000 que Amigável exige. O resto vem das mortes na masmorra Cidade de Dalaran: repita até Amigável. Quanto cada morte rende não consta nos dados do jogo; os chefes rendem mais. No 60 você limpa sozinho.",

	-- Step 11: Archmage Alvareaux: the Azure recipes
	-- {npc:32287} Archmage Alvareaux
	["{npc:32287}: the Azure recipes"] = "{npc:32287}: as receitas Lazúli",
	-- {npc:32287} Archmage Alvareaux · {faction:2740} Kirin Tor · {area:279} Dalaran
	["{npc:32287} sells the Azure helm and shoulder recipes at Friendly, 10g each (skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}. Buy the ones for your profession."] = "{npc:32287} vende as receitas de elmo e ombreiras Lazúli em Amigável, 10g cada (perícia 175). Ele fica no andar de cima do prédio com as bandeiras de {faction:2740} em {area:279}. Compre as da sua profissão.",

	-- Step 12: City of Dalaran runs to Exalted
	["City of Dalaran runs to Exalted"] = "Cidade de Dalaran até Exaltado",
	["Nothing is sold at Honored or Revered in the game's data. Friendly to Exalted is 39,000 reputation, all from City of Dalaran kills. In Classic most dungeon kills stop paying at Honored or Revered; whether these do is not known yet."] = "Nada é vendido em Honrado ou Reverenciado nos dados do jogo. De Amigável a Exaltado são 39.000 de reputação, todos de mortes na Cidade de Dalaran. No Classic, a maioria das mortes em masmorras para de render em Honrado ou Reverenciado; ainda não se sabe se estas também.",

	-- Step 13: The Kirin Tor Tabard
	-- {item:285327} Kirin Tor Tabard
	["The {item:285327}"] = "O {item:285327}",
	-- {npc:32287} Archmage Alvareaux · {npc:28776} Elizabeth Ross · {area:279} Dalaran · {item:285327} Kirin Tor Tabard
	["{npc:32287} and {npc:28776}, the tabard vendor in {area:279}, sell the {item:285327} at Exalted for 25g."] = "{npc:32287} e {npc:28776}, o vendedor de tabardos em {area:279}, vendem o {item:285327} em Exaltado por 25g.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation while they are at most 5 levels below you; in Classic a quest 6+ levels below you pays less (a fifth at 60)."] = "{npc:247264} de {faction:2740} espera em {area:271}. Ele manda você até a imagem de {npc:246748}, na margem de {area:1338}, fora das muralhas de {area:279}. As missões de {faction:2740} começam entre os níveis 24 e 30 e pagam a reputação inteira enquanto estiverem no máximo 5 níveis abaixo de você; no Classic, uma missão 6 ou mais níveis abaixo de você paga menos (um quinto no 60).",
}
