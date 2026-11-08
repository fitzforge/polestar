-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Fly to {object:1772}"] = "",
	["Thorium Point flight master"] = "",

	-- Step 3: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "O acampamento de {npc:7801}",
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser
	["Ride north-east from {object:1772} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' Quel'Danil Lodge."] = "",

	-- Step 4: Highvale
	["Highvale"] = "Altovale",
	-- {npc:7780} Rin'ji
	["The Highvale elves camp around Quel'Danil Lodge. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "",

	-- Step 5: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "A leste da aldeia, o Tragão Violeta cresce nas colinas.",
	["Underwater"] = "",

	-- Step 6: Revantusk Village
	["Revantusk Village"] = "",
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Siga as estradas para leste pelas {zone:1425} até a aldeia troll na costa leste.",

	-- Step 8: Revantusk Village
	-- {quest:7849} Separation Anxiety · {quest:7845} Kidnapped Elder Torntusk! · {quest:7850} Dark Vessels · {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{quest:7849}, {quest:7845} and {quest:7850} are group quests: they send you into Jintha'Alor, whose trolls are elite (46-50). Take them with a group of three or more; skip them if you are alone, the route has you grind the experience back.\n{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 9: The Overlook Cliffs: kill these as you meet them
	["The Overlook Cliffs: kill these as you meet them"] = "",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "As tartarugas grandes rastejam pelas praias ao norte da aldeia. As garrafas de vinho do Porto de {npc:2491} também ficam nessas praias, mas a missão dele não está nesta rota. Uma mordelisca pode derrubar, raramente, o sinalizador de socorro do OOX-09/HL: guarde-o.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, item raro",

	-- Step 10: The Overlook Cliffs: kill these as you meet them
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} is a level 48 elite: most classes solo it at level 50, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 11: Rin'ji's Secret
	["The secret lies on the Overlook Cliffs, above the beach."] = "",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "para {npc:7825} na {zone:1458}, por volta do nível 50",

	-- Step 12: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "O almoço de {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Seguindo a costa para o norte, a cesta de piquenique de {npc:14731} está na ilhota; um {npc:14748} a vigia.",

	-- Step 14: Shaol'watha: kill these as you meet them
	["Shaol'watha: kill these as you meet them"] = "",
	-- {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko · {npc:2925} Silvermane Howler
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["West of the island, the Vilebranch scalpers hold the temples of Agol'watha and Shaol'watha. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and Skulk Rock. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use Infected Bite. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "",

	-- Step 15: Skulk Rock
	["Skulk Rock"] = "",
	-- {item:8684} Hinterlands Honey Ripple
	["The crates of {item:8684} lie around the abandoned Horde camp at Skulk Rock, among the oozes."] = "",

	-- Step 16: Wildkin Muisek
	["Careful: Stealthed wolves and griffons roam the Valorwind Lake area."] = "",

	-- Step 17: The Altar of Zul: kill these as you meet them
	["The Altar of Zul: kill these as you meet them"] = "",
	-- {npc:8636} Morta'gya the Keeper
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west of the lake, the Vilebranch soothsayers hold the Altar of Zul, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "",

	-- Step 18: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["Only with the distress beacon: the robot sits at the head of the river west of Skulk Rock. Escort it east to the shore beyond the Overlook Cliffs; its reward waits with Oglethorpe in {object:3204}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "",

	-- Step 19: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "para {npc:6986} em {zone:1454}, por volta do nível 50",

	-- Step 20: Highvale
	["Back west to Quel'Danil Lodge; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "",

	-- Step 21: Jintha'Alor
	["Jintha'Alor"] = "",
	-- {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of Jintha'Alor. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. The trolls inside are elite: stay with your group and keep to the paths."] = "",
	-- {npc:14757} Elder Torntusk
	["{npc:14757}, at the top of Jintha'Alor"] = "",
	["His next request, going on to the Altar of Zul, is for a group."] = "",

	-- Step 22: Revantusk Village
	-- {npc:14731} Lard
	["{npc:14731}, inside"] = "",

	-- Step 23: Revantusk Village
	-- {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 25: Level 49.02
	["Level 49.02"] = "",
	-- {quest:7816} Gammerita, Mon!
	["If you skipped {quest:7816} or the Jintha'Alor group quests, grind here to level 49.02 to stay on the route's plan. Or, with a group, run the Maraudon dungeon instead."] = "",
	-- {npc:2505} Saltwater Snapjaw
	["grind on {npc:2505}"] = "",

	-- Step 26: The Atal'ai Exile
	["South-west again, the exile hides by the ruins of Shadra'Alor."] = "",

	-- Step 28: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Ao sul do pavilhão, os trolls Cascasseca ocupam suas aldeias. Cada um deles carrega um crânio: com vinte, use {item:15002} para fazer o Pique de Nimboya Repleto e finque-o dentro da aldeia.",

	-- Step 29: Aerie Peak
	["Aerie Peak"] = "",
	["Ride all the way west to the Wildhammer town of Aerie Peak and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "",
	["Aerie Peak well"] = "",

	-- Step 31: Fly to Stonard
	["Fly to Stonard"] = "",
	["Revantusk Village flight master"] = "",

	-- Step 32: Fel'zerul
	["On the top floor"] = "",

	-- Step 33: The bloodmages
	["The bloodmages"] = "Os magos de sangue",
	-- {zone:1419} Blasted Lands
	["Ride west out of Stonard and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "",

	-- Step 34: Serpent's Coil: kill these as you meet them
	["Serpent's Coil: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use Venom Sting; {npc:8301} adds Knockdown."] = "",

	-- Step 35: The bloodmages
	["Ride back north to the bloodmages."] = "Volte para o norte até os magos de sangue.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "As continuações pedem as mesmas partes de novo por um item de bônus e não dão experiência: ignore-as.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Volte para oeste até o {area:350}; patrulheiros e atiradores ficam perto do pavilhão, batedores e vanguardeiros nas encostas ao sul dele.",
	-- ["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "A leste da estrada, os javalis Jubacinza e os Grunhidos fuçam as encostas ao lado dos basiliscos Itarrubra. Fique longe dos Javiltuscos de nível 52 mais ao sul.",
	-- ["Fly to the {area:1497}"] = "Voe para a {area:1497}",
	-- ["Fly to {area:272}"] = "Voe para {area:272}",
	-- ["Fly to {area:75}"] = "Voe para {area:75}",
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Siga as estradas para leste pelas {zone:1425} até a aldeia troll na costa leste.",
	-- ["From {area:1446}'s flight master."] = "Com o mestre de voo de {area:1446}.",
	-- ["Grind to 48"] = "Evolua até o 48",
	-- ["His next request, going on to the {area:355}, is for a group."] = "O pedido seguinte dele, que leva ao {area:355}, é para grupo.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "O crânio do Guarda-caça Malkhor está numa pilha abaixo das ruínas Ramatorpe, e os ossos numa pilha ao pé de {area:354}. Os Recipientes com Sangue Maculado ficam nos terraços de baixo, e {npc:14757} está preso no topo. Fique nas trilhas: os trolls lá dentro são elite.",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "Na volta para o leste, os Adivinhos Ramatorpe ocupam o {area:355}, o templo troll ao sul das colinas centrais. Qiaga e {npc:8636} (elite, 50) ficam no topo: enfrente os adivinhos dos degraus de baixo.",
	-- ["Only if you are not level 48 yet."] = "Só se você ainda não estiver no nível 48.",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Só com o sinalizador de socorro: o robô fica na nascente do rio a oeste de {area:351}. Escolte-o para leste até a margem além dos {area:307}; a recompensa espera com Olhatorto em {area:35}.",
	-- ["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Siga até o extremo oeste, até a cidade Martelo Feroz de {area:348}, e coloque a mensagem junto ao poço no centro. A cidade está cheia de guardas da Aliança: entre, coloque-a e saia.",
	-- ["Ride north back to {area:75} and fly to the {area:1497}."] = "Volte para o norte até {area:75} e voe para a {area:1497}.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Siga para nordeste saindo de {area:272} até as {zone:1425} e para leste pela estrada; {npc:7801} acampa na colina ao sul do {area:350} dos elfos.",
	-- ["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Siga para oeste saindo de {area:75} e para o sul pelo cânion até as {zone:1419}; os dois magos de sangue ficam junto à estrada, logo na entrada.",
	-- ["Saltwater Snapjaws"] = "Mordeliscas de Água Salgada",
	-- ["Silvermane Howlers"] = "Uivadores Jubaprata",
	-- ["South-west again, the exile hides by the ruins of {area:353}."] = "De volta a sudoeste, o exilado se esconde nas ruínas de {area:353}.",
	-- ["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "A sudoeste, os Uivadores Jubaprata vagam pelas colinas a leste das aldeias Cascasseca.",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Os elfos do Altovale acampam em volta do {area:350}. Queime o relatório, as anotações e os registros nos acampamentos deles. {npc:7780} está preso dentro do pavilhão: leve-o para fora e enfrente a emboscada no caminho.",
	-- ["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Os Espreitadores Jubaprata, as Ferujas Selvagens e os Senhores Celestes Bicavalha dividem as colinas entre os templos e {area:351}. Use o {item:9618} nas ferujas que matar. Os Senhores Celestes também derrubam Penas Longas Elegantes: guarde dez para a segunda mensagem de {npc:14738}.",
	-- ["The Vilebranch temples"] = "Os templos Ramatorpe",
	-- ["The central hills"] = "As colinas centrais",
	-- ["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "As caixas de {item:8684} ficam em volta do acampamento abandonado da Horda em {area:351}, entre as gosmas.",
	-- ["The eastern slopes"] = "As encostas do leste",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "As cinco missões pedem as mesmas partes: junte tudo de uma vez. A oeste da estrada, os abutres {npc:5982}, as Rasgarrindas Famintas, os Aguilhantes Escorpódes e os basiliscos Olho da Morte dividem as colinas.",
	-- ["The next guide starts here, at {area:3317}."] = "O próximo guia começa aqui, em {area:3317}.",
	-- ["The northern beasts"] = "As feras do norte",
	-- ["The secret lies on the {area:307}, above the beach."] = "O segredo está nos {area:307}, acima da praia.",
	-- ["Vilebranch soothsayers"] = "Adivinhos Ramatorpe",
	-- ["Vulture hills"] = "Colinas dos abutres",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "A oeste da ilha, os Escalpeladores Ramatorpe ocupam os templos de {area:1884} e {area:1917}. As ferramentas de Escoriárvore estão em um dos templos.",
	-- ["grind on {npc:5982} at the northern hills, {zone:1419}"] = "evolua com {npc:5982} nas colinas do norte, {zone:1419}",
	-- ["{area:348} well"] = "Poço de {area:348}",
	-- ["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, no topo de {area:354}",
	-- ["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: para {zone:1456}, por volta do nível 50",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
}
