-- Portuguese (Brazil) (ptBR): the guide forever/reputation/ravenholdt (forever/reputation/ravenholdt.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt Reputation"] = "Reputação: Corvoforte",
	["The assassins' guild: Forever's new rogue quests, then Syndicate kills and Heavy Junkboxes to Exalted."] = "A guilda dos assassinos: as novas missões de ladino do Forever, depois mortes da Camarilha e Caixas de Tralhas Pesadas até Exaltado.",
	-- {faction:349} Ravenholdt
	["{faction:349} reputation (no vendor or reward in Forever's data)"] = "Reputação com {faction:349} (sem vendedor nem recompensa nos dados do Forever)",

	-- Step 1: The Manor, Ravenholdt
	-- {item:17126} Elegant Letter · {area:275} Durnholde Keep · {npc:6707} Fahrad
	["Rogues from level 24: ask your class trainer in a capital \"May I have it, please?\" for the {item:17126}, and read it. The path up to the manor starts in the hills north of {area:275}. In the tunnel on the way lies a chest: do not open it (an elite guard jumps out), just walk past it to earn the Rite of Cunning. {npc:6707} waits on the manor's balcony."] = "Ladinos a partir do nível 24: peça ao seu instrutor de classe numa capital “Pode me dar, por favor?” para receber a {item:17126}, e leia-o. O caminho até a mansão começa nas colinas ao norte de {area:275}. No túnel do caminho há um baú: não o abra (um guarda de elite salta de dentro), apenas passe por ele para ganhar o Rito da Astúcia. {npc:6707} espera na sacada da mansão.",
	-- {item:17126} Elegant Letter
	["{item:17126}, from your class trainer"] = "{item:17126}, do seu instrutor de classe",
	["walk past the trapped chest in the tunnel"] = "passe pelo baú armadilhado no túnel",
	-- {npc:6707} Fahrad
	["{npc:6707}: 100 reputation"] = "{npc:6707}: 100 de reputação",

	-- Step 2: Myrokos Silentform
	-- {npc:13085} Myrokos Silentform · {quest:96779} Syndicate Sabotage · {quest:96781} What's the Big Idea? · {quest:96782} Covert Extraction · {quest:96786} The Syndicate Sting · {quest:96783} A Way In · {item:5140} Flash Powder
	["{npc:13085}, in the manor, has Forever's new rogue quests: 100 reputation each for {quest:96779}, {quest:96781} and {quest:96782}, which follows it, and 300 for {quest:96786} at the end of the Stromgarde chain ({quest:96783} and the two quests after it pay nothing). All can be done solo with stealth from level 30; below that, the Master of Deception talent and a {item:5140} for Vanish help."] = "{npc:13085}, na mansão, tem as novas missões de ladino do Forever: 100 de reputação cada por {quest:96779}, {quest:96781} e {quest:96782}, que vem depois dela, e 300 por {quest:96786}, no fim da cadeia de Stromgarde ({quest:96783} e as duas missões seguintes não pagam nada). Todas podem ser feitas sozinho, com furtividade, a partir do nível 30; abaixo disso, o talento Mestre da Enganação e um {item:5140} para Desaparecer ajudam.",

	-- Step 3: Durnholde Keep: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:271} Southshore
	["{npc:266216} is inside {area:275}, the Syndicate fortress east of {area:271}. Stealth past the guards in the courtyard."] = "{npc:266216} está dentro de {area:275}, a fortaleza da Camarilha a leste de {area:271}. Passe em furtividade pelos guardas no pátio.",

	-- Step 4: Strahnbrad: Barton
	-- {area:280} Strahnbrad
	["{area:280}: Barton"] = "{area:280}: Barton",
	-- {area:280} Strahnbrad
	["Barton hides in a house in {area:280}, among stealthed Syndicate. Pick his pocket for the report; Distract turns him around if you are under his level."] = "Barton se esconde numa casa em {area:280}, entre membros da Camarilha em furtividade. Bata a carteira dele para pegar o relatório; Distrair o faz virar de costas se você estiver abaixo do nível dele.",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482}: bata a carteira de Barton",

	-- Step 5: Northfold Manor: a uniform
	-- {area:313} Northfold Manor
	["{area:313}: a uniform"] = "{area:313}: um uniforme",
	-- {object:656157} Syndicate Footlocker (no name in this language: may be words) · {area:313} Northfold Manor · {quest:96783} A Way In · {item:275706} Syndicate Uniform
	["The {object:656157} stands among the Syndicate camps of {area:313}, north of Stromgarde. Open it to finish {quest:96783} and take the {item:275706}."] = "O Baú da Camarilha fica entre os acampamentos da Camarilha de {area:313}, ao norte de Stromgarde. Abra-o para concluir {quest:96783} e pegar o {item:275706}.",

	-- Step 6: Stromgarde: Anastasia Miller
	-- {npc:266847} Anastasia Miller
	["Stromgarde: {npc:266847}"] = "Stromgarde: {npc:266847}",
	-- {item:275706} Syndicate Uniform · {npc:266847} Anastasia Miller
	["Put on the {item:275706} and go into Stromgarde. {npc:266847} waits on a ledge just outside the castle; players reach her by jumping from the roof of the house beside the ledge. Her stash is upstairs in a house near the keep."] = "Vista o {item:275706} e entre em Stromgarde. {npc:266847} espera numa saliência logo fora do castelo; os jogadores chegam até ela pulando do telhado da casa ao lado da saliência. O esconderijo dela fica no andar de cima de uma casa perto da fortaleza.",
	-- {item:275709} Stolen Funds
	["{item:275709}, in Anastasia's Stash upstairs"] = "{item:275709}, no Esconderijo de Anastasia, no andar de cima",

	-- Step 7: Thoradin's Wall: the shipment
	-- {area:1057} Thoradin's Wall
	["{area:1057}: the shipment"] = "{area:1057}: o carregamento",
	-- {area:1057} Thoradin's Wall · {zone:1417} Arathi Highlands · {item:275882} Intercepted Shipment · {npc:13085} Myrokos Silentform
	["The hand-off is at the southern end of {area:1057}, in the west of the {zone:1417}: two Syndicate guard the box. Kill them or lure them off, then take the {item:275882}. Keep the uniform: {npc:13085} wants it back."] = "A entrega fica no extremo sul de {area:1057}, no oeste de {zone:1417}: dois membros da Camarilha guardam a caixa. Mate-os ou atraia-os para longe, depois pegue o {item:275882}. Fique com o uniforme: {npc:13085} quer de volta.",

	-- Step 8: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "De volta a {npc:13085}",
	-- {quest:96782} Covert Extraction · {quest:96781} What's the Big Idea?
	["{quest:96782}, after {quest:96781}"] = "{quest:96782}, depois de {quest:96781}",

	-- Step 9: Ruins of Alterac: the Perenolde heirlooms
	-- {area:281} Ruins of Alterac
	["{area:281}: the Perenolde heirlooms"] = "{area:281}: as relíquias dos Perenolde",
	-- {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["The two heirlooms lie in two towers of the {area:281}, the ogre-held ruin in the middle of the {zone:1416}. The tower with the sword is ringed by elite ogres: stay in stealth. Neither item is guarded once you are inside."] = "As duas relíquias estão em duas torres de {area:281}, a ruína dominada por ogros no meio de {zone:1416}. A torre com a espada é cercada por ogros de elite: fique em furtividade. Nenhum dos itens é vigiado depois que você entra.",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, the shield"] = "{item:275636}, o escudo",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, the sword"] = "{item:275635}, a espada",

	-- Step 10: Syndicate Emblems to Friendly
	-- {quest:6701} Syndicate Emblems
	["{quest:6701} to Friendly"] = "{quest:6701} até Amigável",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Neutral to Friendly is 3,000 reputation; the quests above pay 700 of it. Any {npc:6766} on the path takes {quest:6701}, 100 reputation each, until you reach Friendly: 23 emblems after the quests. Pick the pockets of Syndicate humans; they never drop emblems when killed. The Arathi camps pay best: Syndicate Prowlers and Conjurors carry one about a quarter of the time. Kill what you have robbed so the next ones respawn fresh."] = "De Neutro a Amigável são 3.000 de reputação; as missões acima pagam 700 disso. Qualquer {npc:6766} no caminho aceita {quest:6701}, 100 de reputação cada, até você chegar a Amigável: 23 emblemas depois das missões. Bata a carteira dos humanos da Camarilha; eles nunca soltam emblemas quando morrem. Os acampamentos de Arathi pagam melhor: Predadores e Conjuradores da Camarilha carregam um cerca de um quarto das vezes. Mate quem você roubou para os próximos renascerem novos.",
	-- {item:17124} Syndicate Emblem
	["{item:17124}: pickpocket Syndicate"] = "{item:17124}: bata a carteira da Camarilha",
	-- {npc:6766} Ravenholdt Guard
	["a {npc:6766}: 100 per emblem"] = "um {npc:6766}: 100 por emblema",

	-- Step 11: Syndicate kills to the end of Honored
	["Syndicate kills to the end of Honored"] = "Mortes da Camarilha até o fim de Honrado",
	-- {faction:349} Ravenholdt · {zone:1416} Alterac Mountains
	-- plural, as words: Syndicate Assassins = {npc:2246} Syndicate Assassin
	["Everyone, not only rogues: in Classic every Syndicate human gave {faction:349} 5 reputation up to the end of Honored (11,999 of 12,000) and not one point more, so 0 to there is 4,200 kills (3,600 after a rogue's quests and emblems). This step ticks at Honored; keep killing until the bar stops moving, then go on to the junkboxes. The highest Syndicate are in the north-west of the {zone:1416}, Syndicate Assassins and Enforcers (level 38-40), with Syndicate Sentries (36-37) nearer the middle. At 60 all Syndicate are grey, and in Classic grey kills gave about a fifth: farm them before 48 if you can. Legacy Diplomat adds up to 10%."] = "Todo mundo, não só ladinos: no Classic, cada humano da Camarilha dava 5 de reputação com {faction:349} até o fim de Honrado (11.999 de 12.000) e nem um ponto a mais, então de 0 até lá são 4.200 mortes (3.600 depois das missões e dos emblemas de um ladino). Este passo marca em Honrado; continue matando até a barra parar de andar, depois siga para as caixas de tralhas. Os da Camarilha de nível mais alto ficam no noroeste de {zone:1416}: Assassinos e Seguranças da Camarilha (nível 38-40), com Sentinelas da Camarilha (36-37) mais perto do meio. No 60, todos da Camarilha são cinzas, e no Classic as mortes cinzas davam cerca de um quinto: farme-os antes do 48, se puder. O Legado Diplomata soma até 10%.",
	-- {npc:2246} Syndicate Assassin
	["{npc:2246}, level 38-39"] = "{npc:2246}, nível 38-39",
	-- {npc:2247} Syndicate Enforcer
	["{npc:2247}, level 39-40"] = "{npc:2247}, nível 39-40",
	-- {npc:2243} Syndicate Sentry
	["{npc:2243}, level 36-37"] = "{npc:2243}, nível 36-37",

	-- Step 12: A Simple Request, rogues 50+
	-- {quest:8233} A Simple Request
	["{quest:8233}, rogues 50+"] = "{quest:8233}, ladinos 50+",
	-- {npc:6768} Lord Jorach Ravenholdt · {quest:8234} Sealed Azure Bag · {zone:1447} Azshara · {quest:8235} Encoded Fragments · {quest:8236} The Azure Key · {area:1477} Temple of Atal'Hakkar
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman · Forest Oozes = {npc:8766} Forest Ooze
	["At level 50 your class trainer has another letter for you, and {npc:6768} a short chain: 360 reputation in all. The {quest:8234} drops from Timbermaw Shamans in northern {zone:1447} (about 1 in 27, or pick their pockets); the {quest:8235} from Forest Oozes in {zone:1447} (4 in 5). {quest:8236} comes from Morphaz, an elite drake deep in the {area:1477}: a five-player dungeon, group up."] = "No nível 50, seu instrutor de classe tem outra carta para você, e {npc:6768} uma cadeia curta: 360 de reputação ao todo. {quest:8234} cai dos Xamãs Presamatos do norte de {zone:1447} (cerca de 1 em 27, ou bata a carteira deles); {quest:8235}, das Gosmas Florestais de {zone:1447} (4 em 5). {quest:8236} vem de Morphaz, um draco de elite no fundo de {area:1477}: uma masmorra para cinco jogadores, forme um grupo.",
	-- {quest:8234} Sealed Azure Bag
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["{quest:8234}: Timbermaw Shamans"] = "{quest:8234}: Xamãs Presamatos",
	-- {item:20023} Encoded Fragment
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["{item:20023}: Forest Oozes"] = "{item:20023}: Gosmas Florestais",
	-- {item:20022} Azure Key · {area:1477} Temple of Atal'Hakkar
	["{item:20022}: Morphaz, {area:1477} (group)"] = "{item:20022}: Morphaz, {area:1477} (grupo)",

	-- Step 13: Heavy Junkboxes to Exalted
	["Heavy Junkboxes to Exalted"] = "Caixas de Tralhas Pesadas até Exaltado",
	-- {quest:8249} Junkboxes Needed · {npc:6707} Fahrad · {item:20086} Dusksteel Throwing Knife · {area:1583} Blackrock Spire · {area:1584} Blackrock Depths
	["From the top of Honored to Exalted is 21,001 reputation, and {quest:8249} is the only way: {npc:6707} pays 50 and a {item:20086} for every five Heavy Junkboxes (Classic Era paid 75), 421 turn-ins and 2,105 boxes. Boxes count at any standing, so take the cheap kills to their cap first. Any class can hand them in. Rogues get them by picking the pockets of humanoids around level 50 and up: Lower {area:1583} and {area:1584} are the classic spots, pick every pocket, reset and go again. The boxes do not bind, so everyone else buys them from rogues or at the auction house. Hand them in unopened; an opened box you empty vanishes, so leave one item in it."] = "Do topo de Honrado até Exaltado são 21.001 de reputação, e {quest:8249} é o único jeito: {npc:6707} paga 50 e uma {item:20086} a cada cinco Caixas de Tralhas Pesadas (a Classic Era pagava 75), 421 entregas e 2.105 caixas. As caixas contam em qualquer nível de reputação, então leve as mortes fáceis até o limite primeiro. Qualquer classe pode entregá-las. Ladinos as conseguem batendo a carteira de humanoides de nível 50 ou mais: {area:1583} e {area:1584} inferiores são os pontos clássicos; bata todas as carteiras, reinicie e repita. As caixas não são vinculadas, então todo mundo as compra de ladinos ou na Casa de Leilões. Entregue-as fechadas; uma caixa aberta que você esvazia some, então deixe um item dentro.",
	-- {item:16885} Heavy Junkbox · {area:1445} Blackrock Mountain
	["{item:16885}: pickpocket level 50+ humanoids, {area:1445}"] = "{item:16885}: bata a carteira de humanoides de nível 50+, {area:1445}",
	-- {npc:6707} Fahrad
	["{npc:6707}: 50 per five boxes"] = "{npc:6707}: 50 a cada cinco caixas",
}
