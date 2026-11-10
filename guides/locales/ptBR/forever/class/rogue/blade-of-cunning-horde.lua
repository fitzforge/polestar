-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/blade-of-cunning-horde (forever/class/rogue/blade-of-cunning-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Horde)"] = "{item:7298} (Horda)",
	["A dagger at 10 from your home town's rogue quests."] = "Uma adaga no nível 10, das missões de ladino da sua cidade natal.",

	-- Step 1: Therzok
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {quest:1859} Therzok · {zone:1454} Orgrimmar · {quest:1963} The Shattered Hand
	["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}. It is only a pointer: an Orc already in {zone:1454} can skip it and take {quest:1963} from {quest:1859} straight away."] = "No nível 10, {npc:3170}, o instrutor de ladino em {area:362}, manda você para {quest:1859}, em {zone:1454}. É só uma indicação: um orc que já está em {zone:1454} pode pular essa parte e pegar {quest:1963} direto com {quest:1859}.",

	-- Step 2: The Shattered Hand
	-- {quest:1859} Therzok · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words) · {quest:1963} The Shattered Hand
	["{quest:1859} stands in the {object:172960}, the canyon under the {object:172982}. Trolls: take {quest:1963} from him at 10."] = "{quest:1859} fica na {object:172960}, o cânion sob o {object:172982}. Trolls: peguem {quest:1963} com ele no nível 10.",

	-- Step 3: Tazan
	-- {npc:6494} Tazan · {area:391} Merchant Coast · {area:392} Ratchet
	["{npc:6494} (level 13, not elite) is a troll pirate on the {area:391} south of {area:392}: he walks the fenced hill path between the lower pirate camp by the beached ship and the upper camp by a big tree. Fight him at the foot of the hill, away from the camps. He always drops his satchel and is back 4 1/2 minutes after a death; one satchel per kill, so two rogues need two kills. Hand the satchel in unopened: picking its lock now destroys it and you must kill him again."] = "{npc:6494} (nível 13, não elite) é um pirata troll na {area:391}, ao sul de {area:392}: ele anda pela trilha cercada do morro entre o acampamento pirata de baixo, perto do navio encalhado, e o de cima, perto de uma árvore grande. Lute com ele ao pé do morro, longe dos acampamentos. Ele sempre solta a sacola e volta 4 minutos e meio depois de morrer; uma sacola por morte, então dois ladinos precisam de duas mortes. Entregue a sacola fechada: arrombar a fechadura agora a destrói, e você teria de matá-lo de novo.",

	-- Step 4: Back to Therzok
	-- {npc:6446} Therzok
	["Back to {npc:6446}"] = "Volte a {npc:6446}",

	-- Step 5: Tazan's Key
	-- {quest:1859} Therzok · {npc:6466} Gamon · {object:172982} Valley of Strength (no name in this language: may be words) · {item:7208} Tazan's Key · {item:7209} Tazan's Satchel · {spell:1804} Pick Lock
	["{quest:1859} hands the satchel back: now open it. {npc:6466} (level 12) kneels by the innkeeper in the inn in the {object:172982}; stealth up and pick his pocket for {item:7208} (do not kill him: the key almost never drops). Players often kill him, so you may wait up to 5 minutes for him. Then use the key on {item:7209} in your bags. If you have trained {spell:1804}, you can pick the satchel's lock instead."] = "{quest:1859} devolve a sacola: agora abra-a. {npc:6466} (nível 12) fica ajoelhado junto ao estalajadeiro, na estalagem do {object:172982}; fique furtivo e bata a carteira dele para pegar {item:7208} (não o mate: a chave quase nunca cai). Jogadores costumam matá-lo, então você pode esperar até 5 minutos por ele. Depois use a chave em {item:7209} nas bolsas. Se você treinou {spell:1804}, pode abrir a fechadura da sacola com ela.",
	-- {item:7208} Tazan's Key
	["Pick Pocket Gamon for {item:7208}"] = "{item:7208}: bata a carteira de Gamon",
	-- {item:7209} Tazan's Satchel
	["{item:7209}, once you have the key"] = "{item:7209}, depois de ter a chave",
	-- {item:7295} Tazan's Logbook
	["{item:7295}, from the satchel"] = "{item:7295}, da algibeira",

	-- Step 6: Therzok's reward
	-- {npc:6446} Therzok
	["{npc:6446}'s reward"] = "Recompensa de {npc:6446}",

	-- Step 7: Mennet Carkad
	-- {npc:2130} Marion Call · {area:2119} Gallows' End Tavern · {area:159} Brill · {quest:1885} Mennet Carkad · {zone:1458} Undercity
	["At 10 {npc:2130}, the rogue trainer upstairs in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "No nível 10, {npc:2130}, o instrutor de ladino no andar de cima da {area:2119}, em {area:159}, manda você para {quest:1885}, na {zone:1458}.",

	-- Step 8: The Rogues' Quarter
	-- {object:36073} Rogues' Quarter (no name in this language: may be words)
	["The {object:36073}"] = "{object:36073}",
	-- {quest:1885} Mennet Carkad · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["{quest:1885} stands in the {object:36073}."] = "{quest:1885} fica no {object:36073}.",

	-- Step 9: Astor Hadren
	-- {npc:6497} Astor Hadren · {area:228} Sepulcher · {zone:1458} Undercity
	["{npc:6497} (level 13) walks the road between the {area:228} and the {zone:1458}, north of the {area:228}. He looks like a friendly traveller with no quest mark. Talk to him and pick both of his answers: he turns hostile. Kill him for the letter (it always drops). Fight him away from guards, who can take the kill and leave no loot; only one rogue per kill gets the letter. He is back 5 minutes after a death."] = "{npc:6497} (nível 13) anda pela estrada entre a {area:228} e a {zone:1458}, ao norte da {area:228}. Ele parece um viajante amigável, sem marca de missão. Fale com ele e escolha as duas respostas dele: ele fica hostil. Mate-o para pegar a carta (ela sempre cai). Lute com ele longe dos guardas, que podem roubar a morte e deixar sem saque; só um ladino por morte recebe a carta. Ele volta 5 minutos depois de morrer.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Volte a {npc:6467}",

	-- Step 11: Andron Gant
	-- {npc:6522} Andron Gant
	["{npc:6522} is in the Apothecarium, in its biggest room, where two huge guards watch a small bridge. His ledger is on the bookshelf in the back room behind him, not the shelf on the wall next to him."] = "{npc:6522} fica no Apothecarium, na maior sala, onde dois guardas enormes vigiam uma ponte pequena. O livro-caixa dele está na estante do quarto dos fundos, atrás dele, não na estante da parede ao lado dele.",

	-- Step 12: Mennet Carkad and Varimathras
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras
	["{npc:6467} and {npc:2425}"] = "{npc:6467} e {npc:2425}",
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras · {object:36126} Royal Quarter (no name in this language: may be words) · {npc:6522} Andron Gant
	["{npc:6467} sends the ledger on to {npc:2425}, the big demon in the middle of the Hall of the Dark Lady in the {object:36126}, past its elite guards; the way in is the passage off the Apothecarium. If you lose the ledger, take another from {npc:6522}'s bookshelf."] = "{npc:6467} manda o livro-razão a {npc:2425}, o demônio grande no meio do Salão da Dama Sombria, no {object:36126}, passando por seus guardas elite; o caminho é a passagem que sai do Apothecarium. Se perder o livro-razão, pegue outro na estante de {npc:6522}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:2130}, the rogue trainer in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "No nível 10, {npc:2130}, a instrutora de ladinos na {area:2119} em {area:159}, envia você a {quest:1885} na {zone:1458}.",
	-- ["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}."] = "No nível 10, {npc:3170}, o instrutor de ladinos em {area:362}, envia você a {quest:1859} em {zone:1454}.",
	-- ["Tazan"] = "Tazan",
	-- ["{item:7208}: Gamon"] = "{item:7208}: Gamon",
	-- ["{item:7209}: Tazan"] = "{item:7209}: Tazan",
	-- ["{npc:6466} drinks in the inn in the {object:172982}. Pick his pocket for {item:7208}, then open {item:7209}."] = "{npc:6466} bebe na estalagem do {object:172982}. Bata a carteira dele para pegar a {item:7208} e abra a {item:7209}.",
	-- ["{npc:6467} sends the ledger on to {npc:2425} in the Hall of the Dark Lady, the {object:36126}."] = "{npc:6467} envia o livro-caixa a {npc:2425} no Salão da Dama Sombria, o {object:36126}.",
	-- ["{npc:6494} stands on the {zone:1413} coast south of {area:392}. Kill him for his satchel."] = "{npc:6494} fica no litoral dos {zone:1413}, ao sul de {area:392}. Mate-o para pegar a algibeira.",
	-- ["{npc:6497} stands north-east of the {area:228}. Take his Letter of Introduction from him."] = "{npc:6497} fica a nordeste de {area:228}. Pegue com ele a Carta de Apresentação do Astolfo.",
	-- ["{npc:6522}'s ledger sits on the bookshelf beside him."] = "O livro-caixa de {npc:6522} está na estante ao lado dele.",
}
