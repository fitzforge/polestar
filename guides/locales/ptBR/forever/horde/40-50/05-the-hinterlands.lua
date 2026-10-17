-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Voe para {area:75}",
	-- {area:1446} Thorium Point
	["From {area:1446}'s flight master."] = "Com o mestre de voo de {area:1446}.",

	-- Step 2: The bloodmages
	["The bloodmages"] = "Os magos de sangue",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Siga para oeste saindo de {area:75} e para o sul pelo cânion até as {zone:1419}; os dois magos de sangue ficam junto à estrada, logo na entrada.",

	-- Step 3: The northern beasts
	["The northern beasts"] = "As feras do norte",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "As cinco missões pedem as mesmas partes: junte tudo de uma vez. A oeste da estrada, os abutres {npc:5982}, as Rasgarrindas Famintas, os Aguilhantes Escorpódes e os basiliscos Olho da Morte dividem as colinas.",

	-- Step 4: The eastern slopes
	["The eastern slopes"] = "As encostas do leste",
	["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "A leste da estrada, os javalis Jubacinza e os Grunhidos fuçam as encostas ao lado dos basiliscos Itarrubra. Fique longe dos Javiltuscos de nível 52 mais ao sul.",

	-- Step 5: The bloodmages
	["Ride back north to the bloodmages."] = "Volte para o norte até os magos de sangue.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "As continuações pedem as mesmas partes de novo por um item de bônus e não dão experiência: ignore-as.",

	-- Step 6: Grind to 48
	["Grind to 48"] = "Evolua até o 48",
	["Only if you are not level 48 yet."] = "Só se você ainda não estiver no nível 48.",
	["Vulture hills"] = "Colinas dos abutres",
	-- {npc:5982} Black Slayer · {zone:1419} Blasted Lands
	["grind on {npc:5982} at the northern hills, {zone:1419}"] = "evolua com {npc:5982} nas colinas do norte, {zone:1419}",

	-- Step 7: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Voe para a {area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity
	["Ride north back to {area:75} and fly to the {area:1497}."] = "Volte para o norte até {area:75} e voe para a {area:1497}.",

	-- Step 8: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- {npc:6741} Innkeeper Norman · {zone:1456} Thunder Bluff
	["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: para {zone:1456}, por volta do nível 50",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",

	-- Step 10: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "O acampamento de {npc:7801}",
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Siga para nordeste saindo de {area:272} até as {zone:1425} e para leste pela estrada; {npc:7801} acampa na colina ao sul do {area:350} dos elfos.",

	-- Step 11: Highvale
	["Highvale"] = "Altovale",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Os elfos do Altovale acampam em volta do {area:350}. Queime o relatório, as anotações e os registros nos acampamentos deles. {npc:7780} está preso dentro do pavilhão: leve-o para fora e enfrente a emboscada no caminho.",

	-- Step 12: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Ao sul do pavilhão, os trolls Cascasseca ocupam suas aldeias. Cada um deles carrega um crânio: com vinte, use {item:15002} para fazer o Pique de Nimboya Repleto e finque-o dentro da aldeia.",

	-- Step 13: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "A leste da aldeia, o Tragão Violeta cresce nas colinas.",

	-- Step 14: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "De volta a sudoeste, o exilado se esconde nas ruínas de {area:353}.",

	-- Step 15: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Siga as estradas para leste pelas {zone:1425} até a aldeia troll na costa leste.",

	-- Step 16: Saltwater Snapjaws
	-- plural, as words: Saltwater Snapjaws = {npc:2505} Saltwater Snapjaw
	["Saltwater Snapjaws"] = "Mordeliscas de Água Salgada",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "As tartarugas grandes rastejam pelas praias ao norte da aldeia. As garrafas de vinho do Porto de {npc:2491} também ficam nessas praias, mas a missão dele não está nesta rota. Uma mordelisca pode derrubar, raramente, o sinalizador de socorro do OOX-09/HL: guarde-o.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, item raro",

	-- Step 17: Rin'ji's Secret
	-- {area:307} Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "O segredo está nos {area:307}, acima da praia.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "para {npc:7825} na {zone:1458}, por volta do nível 50",

	-- Step 18: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "O almoço de {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Seguindo a costa para o norte, a cesta de piquenique de {npc:14731} está na ilhota; um {npc:14748} a vigia.",

	-- Step 19: The Vilebranch temples
	["The Vilebranch temples"] = "Os templos Ramatorpe",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "A oeste da ilha, os Escalpeladores Ramatorpe ocupam os templos de {area:1884} e {area:1917}. As ferramentas de Escoriárvore estão em um dos templos.",

	-- Step 20: The central hills
	["The central hills"] = "As colinas centrais",
	-- {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Os Espreitadores Jubaprata, as Ferujas Selvagens e os Senhores Celestes Bicavalha dividem as colinas entre os templos e {area:351}. Use o {item:9618} nas ferujas que matar. Os Senhores Celestes também derrubam Penas Longas Elegantes: guarde dez para a segunda mensagem de {npc:14738}.",

	-- Step 21: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "As caixas de {item:8684} ficam em volta do acampamento abandonado da Horda em {area:351}, entre as gosmas.",

	-- Step 22: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Só com o sinalizador de socorro: o robô fica na nascente do rio a oeste de {area:351}. Escolte-o para leste até a margem além dos {area:307}; a recompensa espera com Olhatorto em {area:35}.",

	-- Step 23: Silvermane Howlers
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["Silvermane Howlers"] = "Uivadores Jubaprata",
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "A sudoeste, os Uivadores Jubaprata vagam pelas colinas a leste das aldeias Cascasseca.",

	-- Step 24: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Volte para oeste até o {area:350}; patrulheiros e atiradores ficam perto do pavilhão, batedores e vanguardeiros nas encostas ao sul dele.",

	-- Step 25: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "para {npc:6986} em {zone:1454}, por volta do nível 50",

	-- Step 26: Vilebranch soothsayers
	["Vilebranch soothsayers"] = "Adivinhos Ramatorpe",
	-- {area:355} Altar of Zul · {npc:8636} Morta'gya the Keeper
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "Na volta para o leste, os Adivinhos Ramatorpe ocupam o {area:355}, o templo troll ao sul das colinas centrais. Qiaga e {npc:8636} (elite, 50) ficam no topo: enfrente os adivinhos dos degraus de baixo.",

	-- Step 27: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "O crânio do Guarda-caça Malkhor está numa pilha abaixo das ruínas Ramatorpe, e os ossos numa pilha ao pé de {area:354}. Os Recipientes com Sangue Maculado ficam nos terraços de baixo, e {npc:14757} está preso no topo. Fique nas trilhas: os trolls lá dentro são elite.",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, no topo de {area:354}",
	-- {area:355} Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "O pedido seguinte dele, que leva ao {area:355}, é para grupo.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Siga até o extremo oeste, até a cidade Martelo Feroz de {area:348}, e coloque a mensagem junto ao poço no centro. A cidade está cheia de guardas da Aliança: entre, coloque-a e saia.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Poço de {area:348}",

	-- Step 30: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "O próximo guia começa aqui, em {area:3317}.",
}
