-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/neutral/swift-galestrider (forever/collectibles/mounts/neutral/swift-galestrider.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Galestrider"] = "Vagaventos Veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {skill:762} Riding
	["Swift Galestriders need level 60 and Journeyman {skill:762}. Train it at your own race's riding trainer; see the Level 60 mount guides for where."] = "Os Vagaventos Velozes exigem nível 60 e {skill:762} Profissional. Treine com o instrutor de equitação da sua própria raça; veja os guias de montarias do nível 60 para saber onde.",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste de {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} é a ilha inicial dos Celonatos; qualquer um pode visitar. Um barco celeste sai do lado norte de {area:279} a cada cinco minutos, mais ou menos (outro voa do norte de {zone:1456}; qualquer facção pode pegar qualquer um). Pule isto se você já estiver na ilha.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste para {zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste de {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} é a ilha inicial dos Celonatos; qualquer um pode visitar. Um barco celeste sai dos penhascos ao sul do {area:17045}, ao norte de {zone:1456}, a cada cinco minutos, mais ou menos (outro voa de {area:279}; qualquer facção pode pegar qualquer um). Pule isto se você já estiver na ilha.",

	-- Step 4: Journeyman Riding with Genn Fairweather
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["Journeyman {skill:762} with {npc:265756}"] = "{skill:762} Profissional com {npc:265756}",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Skyborne train Journeyman {skill:762} with {npc:265756} himself for 1,000g; Blizzard says it comes with a mount. He stands at the {area:17684} in {area:16638}, near the skyboat docks."] = "Os Celonatos treinam {skill:762} Profissional com o próprio {npc:265756} por 1.000g; a Blizzard diz que vem junto uma montaria. Ele fica em {area:17684}, em {area:16638}, perto das docas dos barcos celestes.",
	-- {npc:265756} Genn Fairweather
	["{npc:265756}, riding trainer"] = "{npc:265756}, instrutor de equitação",

	-- Step 5: Galestrider Riding for other races
	-- {spell:1285849} Galestrider Riding
	["{spell:1285849} for other races"] = "{spell:1285849} para outras raças",
	-- {spell:1285849} Galestrider Riding · {skill:762} Riding · {npc:265756} Genn Fairweather
	["Any race can buy Galestriders, but riding one also takes {spell:1285849}, which only the Skyborne get with {skill:762}. Other races can learn it too, but how is not known yet: in Classic another race's riding needed Exalted with its home faction, here the High Order (Alliance) or the Windshapers (Horde). Ask {npc:265756} before you buy."] = "Qualquer raça pode comprar Vagaventos, mas montar um também exige {spell:1285849}, que só os Celonatos recebem com {skill:762}. Outras raças também podem aprender, mas ainda não se sabe como: no Classic, a equitação de outra raça exigia Exaltado com a facção natal dela, e aqui seria a Alta Ordem (Aliança) ou os Moldaventos (Horda). Pergunte a {npc:265756} antes de comprar.",

	-- Step 6: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756} is at the {area:17684} in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756} fica em {area:17684}, em {area:16638}, a cidade portuária da ilha, perto das docas dos barcos celestes. O cliente do Forever lista cada Vagavento Veloz por 200g; escolha um.",
	["200g"] = "200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Swift Galestriders need level 60 and Journeyman {skill:762} from a riding trainer of your faction; see the Level 60 mount guides for where."] = "Vagaventos Velozes requerem nível 60 e {skill:762} (Profissional) de um instrutor de montaria da sua facção; veja os guias de montaria de nível 60 para saber onde.",
	-- ["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756} está em {area:16638}, a cidade portuária da ilha, perto das docas dos barcos celestes. O cliente Forever lista cada Vagaventos Veloz por 200g; escolha um.",
}
