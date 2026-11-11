-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277210} Pyrewood Signet Ring · {area:236} Shadowfang Keep
	["The {item:277210}, C's payment for a solo job inside {area:236}."] = "O {item:277210}, o pagamento de C por um serviço solo dentro do {area:236}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "O esconderijo de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest in a house just outside {area:204} in southern Silverpine, south of {area:236}. Open it and read C's note: the job has to be done alone, out of any group."] = "{object:410369} é um baú numa casa logo fora de {area:204}, no sul de Pinhaprata, ao sul de {area:236}. Abra e leia o bilhete de C: o trabalho precisa ser feito sozinho, fora de qualquer grupo.",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order · {spell:921} Pick Pocket
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon, a short way north-east of {area:460}. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers (level 18) working around him carry them in their pockets. Stealth up behind one and {spell:921} it; killing them does not give it."] = "{npc:4086}, um goblin amigo das duas facções, fica entre o pessoal da Empreendimentos S.A. em {area:461}, no leste da Cordilheira das Torres de Pedra, a uma curta distância a nordeste de {area:460}. A Horda voa para {area:460}; a Aliança, para {area:467}. Ele quer uma {item:210187} antes de entregar explosivos: os Madeireiros da Empreendimentos S.A. (nível 18) que trabalham em volta dele a carregam nos bolsos. Fique furtivo atrás de um e use {spell:921} nele; matá-los não dá o item.",
	-- {spell:921} Pick Pocket · {npc:3989} Venture Co. Logger · {item:210187} Venture Co. Work Order
	["{spell:921} a {npc:3989} for a {item:210187}"] = "Use {spell:921} em um {npc:3989} para pegar uma {item:210187}",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge · {item:5140} Flash Powder · {item:210213} Sister's Half-Key · {item:210212} Brother's Half-Key
	["Go in alone and use the {item:210186} at the courtyard gate. Players also report a freed prisoner opening the courtyard door for you: if you die while he is opening it, stay dead until it is open; it stays open once you release. If you know Vanish, bring {item:5140} and check its cooldown before entering; keep it ready for a failed approach. Pickpocket the sister in the dining hall for the {item:210213}, then the brother in the room reached by turning right at the top of the stairs for the {item:210212} (a level 20 rogue without Vanish may need ranks in Master of Deception to reach the second one unseen). Combine them somewhere safe: this breaks stealth. Free a bag slot first: opening the chest with full bags can use up the key without giving the horn. Return to the courtyard stables and use the combined key on the chest for the horn. Stay clear of the nearby elites; the minimum quest level does not guarantee a safe approach."] = "Vá sozinho e use {item:210186} no portão do pátio. Jogadores também relatam um prisioneiro libertado abrindo a porta do pátio para você: se você morrer enquanto ele abre, fique morto até ela abrir; ela continua aberta depois que você libera o espírito. Se você conhece Sumir, leve {item:5140} e confira o tempo de recarga antes de entrar; deixe pronto para uma aproximação que falhe. Bata a carteira da irmã no salão de jantar para pegar {item:210213}, depois a do irmão, no quarto que se alcança virando à direita no topo da escada, para pegar {item:210212} (um ladino de nível 20 sem Vanish pode precisar de graus em Mestre da Enganação para chegar ao segundo sem ser visto). Combine as duas num lugar seguro: isso quebra a furtividade. Libere um espaço na bolsa antes: abrir o baú com as bolsas cheias pode gastar a chave sem dar a trombeta. Volte aos estábulos do pátio e use a chave combinada no baú para pegar a trombeta. Fique longe dos elites próximos; o nível mínimo da missão não garante uma aproximação segura.",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}, dentro do {area:236}",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "Volte ao esconderijo",
	-- {object:410369} Dead Drop
	["Place the horn in the {object:410369} near Pyrewood. The payment may not appear immediately: check a capital mailbox for C's follow-up letter on your next planned city visit, then return to this chest for the reward quest. Do not repeat the dungeon just because the payment is not yet offered."] = "Coloque a trombeta em {object:410369} perto de Lenhardente. O pagamento pode não aparecer na hora: olhe a caixa de correio de uma capital, na sua próxima visita planejada à cidade, para ver a carta de acompanhamento de C, e volte a este baú para a missão de recompensa. Não repita a masmorra só porque o pagamento ainda não foi oferecido.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "Entre sozinho. A {item:210186} passa pelo portão do pátio; os dados não dizem onde a trompa está no castelo.",
	-- ["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "Coloque a trompa na {object:410369} perto da vila. O pagamento de C é a segunda missão {item:210183} no mesmo baú.",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "{object:410369} é um baú perto de {area:204}, no sul da Floresta de Pinhaprata, logo ao sul do {area:236}. Leia o bilhete de C.",
	-- ["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}, um goblin amigável às duas facções, fica entre a Empreendimentos S.A. no {area:461}, no leste da Cordilheira das Torres de Pedra. A Horda voa até o {area:460}; a Aliança, até o {area:467}. Ele quer uma {item:210187} antes de entregar explosivos: os Madeireiros da Empreendimentos S.A. em volta dele as carregam.",
}
