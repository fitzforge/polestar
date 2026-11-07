-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Hammerfall
	-- {area:321} Hammerfall
	["Fly to {area:321}"] = "Voe para {area:321}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "Mestre de voo de {area:1446}",

	-- Step 2: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",
	-- {area:321} Hammerfall
	["{area:321} flight master"] = "Mestre de voo de {area:321}",

	-- Step 4: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "O acampamento de {npc:7801}",
	-- {area:272} Tarren Mill · {area:47} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {area:47} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Cavalgue para nordeste de {area:272} até {area:47} e siga a estrada para leste; {npc:7801} acampa no morro ao sul de {area:350}, dos elfos.",

	-- Step 5: Highvale
	["Highvale"] = "Altovale",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "Os elfos do Altovale acampam em volta de {area:350}. Queime o relatório, as cartas e os arquivos nos acampamentos deles. {npc:7780} está preso dentro do pavilhão: leve-o para fora e segure a emboscada no caminho.\nCuidado: grupos de uns três elfos emboscam a escolta, geralmente duas vezes.",

	-- Step 6: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "A leste da aldeia, o Tragão Violeta cresce nas colinas.",
	["Underwater"] = "Debaixo d'água",

	-- Step 7: Revantusk Village
	-- {area:47} The Hinterlands
	["Follow the roads east across the {area:47} to the troll village on the eastern coast."] = "Siga as estradas para leste atravessando {area:47} até a aldeia troll na costa leste.",

	-- Step 9: On the way
	["On the way"] = "No caminho",

	-- Step 10: The Overlook Cliffs: kill these as you meet them
	-- {area:307} The Overlook Cliffs
	["{area:307}: kill these as you meet them"] = "{area:307}: vá matando estes pelo caminho",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "As tartarugas grandes rastejam pelas praias ao norte da aldeia. As garrafas de vinho do Porto de {npc:2491} também ficam nessas praias, mas a missão dele não está nesta rota. Uma mordelisca pode derrubar, raramente, o sinalizador de socorro do OOX-09/HL: guarde-o.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, item raro",

	-- Step 11: The Overlook Cliffs: kill these as you meet them
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} is a level 48 elite: most classes solo it at level 50, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:7977} é elite de nível 48: a maioria das classes encara sozinha no nível 50, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 12: Rin'ji's Secret
	-- {area:307} The Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "O segredo está nos {area:307}, acima da praia.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "para {npc:7825} na {zone:1458}, por volta do nível 50",

	-- Step 13: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "O almoço de {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Seguindo a costa para o norte, a cesta de piquenique de {npc:14731} está na ilhota; um {npc:14748} a vigia.",

	-- Step 15: Shaol'watha: kill these as you meet them
	-- {area:1917} Shaol'watha
	["{area:1917}: kill these as you meet them"] = "{area:1917}: vá matando estes pelo caminho",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha · {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko · {spell:7367} Infected Bite · {npc:2925} Silvermane Howler
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use {spell:7367}. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "A oeste da ilha, os escalpeladores Ramatorpe ocupam os templos de {area:1884} e {area:1917}. As ferramentas do Escoriárvore estão num dos templos.\nOs Espreitadores Jubaprata, as Ferujas Selvagens e os Senhores Celestes Bicavalha dividem as colinas entre os templos e {area:351}. Use o {item:9618} nas ferujas que matar. Os Senhores Celestes também deixam cair Penas Longas Elegantes: guarde dez para a segunda mensagem de {npc:14738}.\nCuidado: os Espreitadores Jubaprata são nível 47-48 e ficam furtivos fora de combate. De perto, usam {spell:7367}. Quando um {npc:2925} cai para 50% de vida ou menos, chama ajuda de qualquer coisa num raio de 25 jd.",

	-- Step 16: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "As caixas de {item:8684} ficam em volta do acampamento abandonado da Horda em {area:351}, entre as gosmas.",

	-- Step 17: Wildkin Muisek
	-- {area:1883} Valorwind Lake
	["Careful: Stealthed wolves and griffons roam the {area:1883} area."] = "Cuidado: lobos e grifos furtivos andam pela área de {area:1883}.",

	-- Step 18: The Altar of Zul: kill these as you meet them
	-- {area:355} The Altar of Zul
	["{area:355}: kill these as you meet them"] = "{area:355}: vá matando estes pelo caminho",
	-- {area:355} The Altar of Zul · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Na volta para leste, os adivinhos Ramatorpe ocupam {area:355}, o templo troll ao sul das colinas centrais. Qiaga e {npc:8636} (elite, 50) ficam lá no topo: fique com os adivinhos dos degraus de baixo.\nA sudoeste, os Uivadores Jubaprata andam pelas colinas a leste das aldeias Cascasseca.",

	-- Step 19: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} The Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "Só com o sinalizador de socorro: o robô fica na nascente do rio a oeste de {area:351}. Escolte-o para leste até a praia depois de {area:307}; a recompensa fica com Olhatorto, em {area:35}.\nCuidado: há duas emboscadas na escolta: primeiro três ferujas, depois três trolls. Antes de cada uma, o robô para e avisa que sente perigo. Gosmas, lobos furtivos e uma tartaruga grande no caminho podem entrar nas lutas, e renascem mesmo que você limpe antes.",

	-- Step 20: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "para {npc:6986} em {zone:1454}, por volta do nível 50",

	-- Step 21: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Volte para oeste até o {area:350}; patrulheiros e atiradores ficam perto do pavilhão, batedores e vanguardeiros nas encostas ao sul dele.",

	-- Step 22: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "O crânio do Guarda-caça Malkhor está numa pilha abaixo das ruínas Ramatorpe, e os ossos numa pilha ao pé de {area:354}. Os Recipientes com Sangue Maculado ficam nos terraços de baixo, e {npc:14757} está preso no topo. Fique nas trilhas: os trolls lá dentro são elite.",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, no topo de {area:354}",
	-- {area:355} The Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "O pedido seguinte dele, que leva ao {area:355}, é para grupo.",

	-- Step 23: Revantusk Village
	-- {npc:14731} Lard
	["{npc:14731}, inside"] = "{npc:14731}, lá dentro",

	-- Step 25: Level 49.02
	["Level 49.02"] = "Nível 49.02",
	-- {quest:7816} Gammerita, Mon!
	["If you skipped {quest:7816}, grind here to level 49.02 to stay on the route's plan."] = "Se você pulou {quest:7816}, mate monstros aqui até o nível 49.02 para seguir o plano da rota.",
	-- {npc:2505} Saltwater Snapjaw
	["grind on {npc:2505}"] = "mate {npc:2505} até subir",

	-- Step 26: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "De volta a sudoeste, o exilado se esconde nas ruínas de {area:353}.",

	-- Step 28: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Ao sul do pavilhão, os trolls Cascasseca ocupam suas aldeias. Cada um deles carrega um crânio: com vinte, use {item:15002} para fazer o Pique de Nimboya Repleto e finque-o dentro da aldeia.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Siga até o extremo oeste, até a cidade Martelo Feroz de {area:348}, e coloque a mensagem junto ao poço no centro. A cidade está cheia de guardas da Aliança: entre, coloque-a e saia.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Poço de {area:348}",

	-- Step 30: Hearth to Revantusk Village
	-- {area:3317} Revantusk Village
	["Hearth to {area:3317}"] = "Pedra de Regresso para {area:3317}",

	-- Step 31: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "O próximo guia começa aqui, em {area:3317}.",

	-- Step 32: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Voe para {area:75}",
	-- {area:3317} Revantusk Village
	["{area:3317} flight master"] = "Mestre de voo de {area:3317}",

	-- Step 33: Fel'zerul
	["On the top floor"] = "No último andar",

	-- Step 34: The bloodmages
	["The bloodmages"] = "Os magos de sangue",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Siga para oeste saindo de {area:75} e para o sul pelo cânion até as {zone:1419}; os dois magos de sangue ficam junto à estrada, logo na entrada.",

	-- Step 35: Serpent's Coil: kill these as you meet them
	-- {area:1440} Serpent's Coil
	["{area:1440}: kill these as you meet them"] = "{area:1440}: vá matando estes pelo caminho",
	-- {npc:5982} Black Slayer · {spell:5416} Venom Sting · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "As cinco missões usam as mesmas partes: junte tudo numa passada só. A oeste da estrada, os abutres {npc:5982}, as Rasgarrindos Famintas, os Aguilhantes Escorpóde e os basiliscos Olho da Morte dividem as colinas.\nA leste da estrada, os javalis Jubacinza e o Grunhido fuçam as encostas ao lado dos basiliscos Itarrubra. Fique longe dos Javiltuscos de nível 52 mais ao sul.\nCuidado: os Aguilhantes Escorpóde usam {spell:5416}; {npc:8301} ainda derruba você.",

	-- Step 36: The bloodmages
	["Ride back north to the bloodmages."] = "Volte para o norte até os magos de sangue.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "As continuações pedem as mesmas partes de novo por um item de bônus e não dão experiência: ignore-as.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "A leste da estrada, os javalis Jubacinza e os Grunhidos fuçam as encostas ao lado dos basiliscos Itarrubra. Fique longe dos Javiltuscos de nível 52 mais ao sul.",
	-- ["Fly to the {area:1497}"] = "Voe para a {area:1497}",
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Siga as estradas para leste pelas {zone:1425} até a aldeia troll na costa leste.",
	-- ["From {area:1446}'s flight master."] = "Com o mestre de voo de {area:1446}.",
	-- ["Grind to 48"] = "Evolua até o 48",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "Na volta para o leste, os Adivinhos Ramatorpe ocupam o {area:355}, o templo troll ao sul das colinas centrais. Qiaga e {npc:8636} (elite, 50) ficam no topo: enfrente os adivinhos dos degraus de baixo.",
	-- ["Only if you are not level 48 yet."] = "Só se você ainda não estiver no nível 48.",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Só com o sinalizador de socorro: o robô fica na nascente do rio a oeste de {area:351}. Escolte-o para leste até a margem além dos {area:307}; a recompensa espera com Olhatorto em {area:35}.",
	-- ["Ride north back to {area:75} and fly to the {area:1497}."] = "Volte para o norte até {area:75} e voe para a {area:1497}.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Siga para nordeste saindo de {area:272} até as {zone:1425} e para leste pela estrada; {npc:7801} acampa na colina ao sul do {area:350} dos elfos.",
	-- ["Saltwater Snapjaws"] = "Mordeliscas de Água Salgada",
	-- ["Silvermane Howlers"] = "Uivadores Jubaprata",
	-- ["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "A sudoeste, os Uivadores Jubaprata vagam pelas colinas a leste das aldeias Cascasseca.",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Os elfos do Altovale acampam em volta do {area:350}. Queime o relatório, as anotações e os registros nos acampamentos deles. {npc:7780} está preso dentro do pavilhão: leve-o para fora e enfrente a emboscada no caminho.",
	-- ["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Os Espreitadores Jubaprata, as Ferujas Selvagens e os Senhores Celestes Bicavalha dividem as colinas entre os templos e {area:351}. Use o {item:9618} nas ferujas que matar. Os Senhores Celestes também derrubam Penas Longas Elegantes: guarde dez para a segunda mensagem de {npc:14738}.",
	-- ["The Vilebranch temples"] = "Os templos Ramatorpe",
	-- ["The central hills"] = "As colinas centrais",
	-- ["The eastern slopes"] = "As encostas do leste",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "As cinco missões pedem as mesmas partes: junte tudo de uma vez. A oeste da estrada, os abutres {npc:5982}, as Rasgarrindas Famintas, os Aguilhantes Escorpódes e os basiliscos Olho da Morte dividem as colinas.",
	-- ["The northern beasts"] = "As feras do norte",
	-- ["Vilebranch soothsayers"] = "Adivinhos Ramatorpe",
	-- ["Vulture hills"] = "Colinas dos abutres",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "A oeste da ilha, os Escalpeladores Ramatorpe ocupam os templos de {area:1884} e {area:1917}. As ferramentas de Escoriárvore estão em um dos templos.",
	-- ["grind on {npc:5982} at the northern hills, {zone:1419}"] = "evolua com {npc:5982} nas colinas do norte, {zone:1419}",
	-- ["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: para {zone:1456}, por volta do nível 50",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
}
