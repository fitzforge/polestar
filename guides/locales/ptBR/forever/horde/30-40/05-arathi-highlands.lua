-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instrutores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {object:36073} Rogues' Quarter (no name in this language: may be words) · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Treine enquanto estiver em {zone:1458}: os instrutores ficam no {object:36070}, no {object:36073} e no {object:36082} (paladinos: {npc:260093}).",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038} fica no Apothecarium.",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038}: o coração de Stormheart, de {zone:1441}",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Mestre de voo de {zone:1458}",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk · {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow
	["{npc:2229}, {npc:2410} and {npc:2437} are inside the inn; {npc:2770} stands outside it."] = "{npc:2229}, {npc:2410} e {npc:2437} estão dentro da estalagem; {npc:2770} fica do lado de fora.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, lá dentro",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, lá dentro",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}: {quest:93680}; {item:279469} fica perto dos traidores",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, lá dentro",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide"] = "{npc:2770}: para {npc:2771} em {area:321}, mais adiante neste guia",
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",

	-- Step 6: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["Follow the road north out of {area:272} into the Alterac foothills: {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Siga a estrada ao norte saindo de {area:272} até o sopé de Alterac: {quest:535} espera junto ao acampamento da Camarilha. Ele só oferece a tarefa enquanto você tiver a Infiltração de {npc:2229}: entregue a cerveja logo, e a recompensa dele é a Missiva da Camarilha que Krusk quer. Uma missiva da Camarilha daqui serve também: com uma nas bolsas, o guia pula {quest:535}.",

	-- Step 7: Syndicate missives
	["Syndicate missives"] = "Missivas da Camarilha",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one."] = "Só se a missiva de {quest:535} não veio: os Salteadores e Ladrões da Camarilha (32-34) nos acampamentos a oeste da estrada também carregam missivas; cerca de um em cada três deixa cair uma.",

	-- Step 8: Alterac Mountains
	-- {npc:246848} Kirin Tor Guard
	["West along the foot of the hills, south of the road: a {npc:246848} (55) walks that road from the north-east down into the traitors' camp."] = "Siga a oeste pelo pé dos morros, ao sul da estrada: um {npc:246848} (55) percorre essa estrada vindo do nordeste até o acampamento dos traidores.",
	-- {area:279} Dalaran
	["South of the {area:279} crater's camp"] = "Ao sul do acampamento da cratera de {area:279}",

	-- Step 9: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "A cratera de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard · Kirin Tor Enforcers = {npc:276215} Kirin Tor Enforcer
	["From the south, walk up into the camp below the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together in the camp, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens: the ones on the camp's west side are furthest from the Guard's road.\nCareful: Kirin Tor Guards (55) attack the Horde on sight, and one of them patrols the road that comes down into the camp from the north-east and walks right up to the traitors: he has killed many players here. Watch for him, let him walk back up the road, then pull the traitors. Many of the camp's guards stand in linked pairs and others patrol alone. Arcane Sentries (55, elite) and Kirin Tor Enforcers (55) stand around the violet dome itself: keep to the camp below the rim."] = "Vindo do sul, suba até o acampamento abaixo da cúpula violeta de {area:279}. {npc:2411}, {npc:2412} e {npc:2413} (33-34) ficam juntos no acampamento, e {npc:2414} (35) um pouco a oeste deles; cada um carrega um pedaço da Pedra de Sangue. Os Guardas-escudo e Teurgos (31-33) em volta deixam cair as Fichas de Pedra Gasta: os do lado oeste do acampamento são os mais longe da estrada do Guarda.\nCuidado: Guardas do Kirin Tor (55) atacam a Horda à vista, e um deles patrulha a estrada que desce ao acampamento vindo do nordeste e chega bem perto dos traidores: ele já matou muitos jogadores aqui. Fique de olho, deixe-o subir a estrada de volta e então puxe os traidores. Muitos guardas do acampamento ficam em pares ligados e outros patrulham sozinhos. Sentinelas Arcanas (55, elite) e Executores do Kirin Tor (55) ficam em volta da própria cúpula violeta: fique no acampamento abaixo da borda.",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "{item:279469}: um objeto para saquear, perto dos traidores",
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Worn Stone Tokens, from the Shield Guards and Theurgists on the camp's west side"] = "Fichas de Pedra Gasta, dos Guardas-escudo e Teurgos no lado oeste do acampamento",

	-- Step 11: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east along the foothills to {area:272}: everything from the first loop is handed in inside the inn."] = "Volte a leste pelo sopé até {area:272}: tudo da primeira volta é entregue dentro da estalagem.",

	-- Step 13: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north up the road past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Siga a estrada ao norte, passando pelo acampamento de {quest:535}, até {area:280}, a vila dominada pela Camarilha (35-37). {npc:2431} carrega {item:3704}; {quest:503} está numa jaula na casa do lado norte.\nCuidado: espiões furtivos da Camarilha rondam {area:280}, e os prédios têm muitos monstros da Camarilha, entre eles magos.",
	["Inside"] = "Lá dentro",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Descubra onde {quest:503} está preso, no último andar",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, no último andar",
	-- {npc:2229} Krusk · {npc:2423} Lord Aliden Perenolde · {area:1339} Lordamere Lake
	["{npc:2229} will offer {npc:2423} (41, in his manor far up {area:1339}) for this: leave it, he is over your level."] = "{npc:2229} vai oferecer {npc:2423} (41, na mansão dele bem ao norte de {area:1339}) depois desta: deixe para lá, ele está acima do seu nível.",

	-- Step 14: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}: vá matando estes pelo caminho",
	-- {area:280} Strahnbrad · {area:1357} Gallows' Corner · {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["From {area:280} follow the road south-west to {area:1357} and on west to the ruins north of the {area:279} crater, along the lake shore. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "De {area:280}, siga a estrada para sudoeste até {area:1357} e continue para oeste até as ruínas ao norte da cratera de {area:279}, pela margem do lago. Os Evocadores de Dalaran comandam Escravos Elementais; as braçadeiras caem dos escravos. Cuidado: Sentinelas Arcanas (55, elite) e Guardas do Kirin Tor (55) guardam a própria cúpula e atacam a Horda: fique na borda externa das ruínas e não suba até a cúpula.",

	-- Step 15: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "De volta a {area:272}",
	-- {area:272} Tarren Mill
	["Hearth back to {area:272} (your hearthstone is bound there), or walk back south-east along the road out of Alterac."] = "Use a Pedra de Regresso para voltar a {area:272} (ela está vinculada lá) ou volte a pé para sudeste pela estrada que sai de Alterac.",

	-- Step 16: Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth back to {area:272}: your hearthstone is bound there."] = "Use a Pedra de Regresso para voltar a {area:272}: ela está vinculada lá.",
	["The magus offers a dungeon errand next: leave it."] = "O mago oferece em seguida um serviço de masmorra: deixe de lado.",

	-- Step 17: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "A estrada para leste por {area:1057}",

	-- Step 18: Boulderfist camp
	["Boulderfist camp"] = "Acampamento Punho de Pedra",
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Saia de {area:272} para leste, passando por {area:1057}, e siga a estrada para leste. Os Ogros e Impositores Punho de Pedra (32-34) acampam ao sul da estrada, ao sul de {area:313}; os Impositores ficam na caverna de lá.",
	["Below ground"] = "No subterrâneo",

	-- Step 19: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Siga a estrada para leste. Os cacos violeta brilham um pouco fora da estrada, a uma curta distância a oeste de {area:321}.",

	-- Step 20: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "A fortaleza orc na ponta leste da estrada. {npc:2851}, o mestre de mantícoras, fica junto ao portão.\n{npc:15126} só oferece {quest:8263} quando você está Amigável com os Profanadores ({zone:1461}): pule se ele não oferecer.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, junto ao portão",
	-- {npc:12920} Doctor Gregory Victor · {skill:129} First Aid
	["{npc:12920}, at the south gate. If {npc:12920} offers nothing, another player may be running his {skill:129} quest Triage: he can be busy for a few minutes. Wait, then talk to him again."] = "{npc:12920}, no portão sul. Se {npc:12920} não oferecer nada, outro jogador pode estar fazendo a missão de {skill:129} Triagem: ele pode ficar ocupado por alguns minutos. Espere e fale com ele de novo.",

	-- Step 21: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Missões de Stromgarde para um grupo",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "O {quest:639} de {npc:2703} cai dos elites da Camarilha (35-38) nas ruínas de Stromgarde, no oeste do planalto. Ótima XP se você tiver um grupo: a rota passa por Stromgarde a caminho do círculo interno.",

	-- Step 22: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "A nordeste da Ruína do Martelo, os kobolds Bigodesseco mineram o desfiladeiro; os Kobolds da entrada e os Escavadores e Topógrafos lá do fundo deixam cair as Partículas de Myzrael.\nCuidado: todo tipo de kobold sai correndo atrás de ajuda com pouca vida (Kobolds com 30%, Topógrafos e Escavadores com 15%), o que pode trazer mais deles.",

	-- Step 23: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "Os {object:2701} ficam no fundo do desfiladeiro.",

	-- Step 24: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Cada {object:180105} é um anel de monólitos; a chave fica na pedra do centro. O círculo do leste fica nas colinas a noroeste de {area:321}.\nCuidado: cada pedra central é guardada por uns três elementais perto do nível 39, que atacam juntos se você clicar na pedra sem limpá-los antes: Exilados em Chamas no Oeste, Exilados Trovejantes no Externo, Exilados Vagalhantes no Leste.",

	-- Step 25: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Ao sul de Ruína do Martelo, os trolls Cascasseca ocupam a aldeia nas colinas. Arremessadores de Machado guardam as cabanas de fora; os Mandingueiros e Caçadores de Cabeças ficam no coração da aldeia. Cuidado: os três tipos de troll fogem atrás de ajuda com 15% de vida, o que pode trazer mais trolls dos acampamentos vizinhos.",

	-- Step 26: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "Raptores do Planalto e Rastejantes das Planícies",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "No caminho de volta ao norte, Andarilhos do Planalto vagam pelas colinas em volta de {area:321} e deixam cair os olhos, e ao sul dela os Rastejantes das Planícies (32-33) tecem suas teias no capim; eles carregam a seda de aranha.",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "{item:278225}, dos Rastejantes das Planícies",

	-- Step 27: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}: the doctor stands at the south gate."] = "Volte ao norte para {area:321}: o doutor fica no portão sul.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate. If he won't take the silk, another player may be running Triage: wait a few minutes and talk to him again."] = "{npc:12920}, no portão sul. Se ele não aceitar a seda, outro jogador pode estar fazendo Triagem: espere alguns minutos e fale com ele de novo.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, no portão sul",

	-- Step 28: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Os Brutamontes Punho de Pedra acampam fora do salão dos ogros, bem a sudoeste de {area:321}; os Magus Punho de Pedra ficam entre eles. Puxe um de cada vez.",

	-- Step 29: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptores Fareja-carne",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Farejas-carne do Planalto (36-37) caçam no planalto sul, um bando ao norte de {area:316} e outro na planície a oeste. Puxe um de cada vez.",

	-- Step 30: Go'shek Farm
	["Go'shek Farm"] = "Fazenda Go'Shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "O barraco de laboratório de {npc:2733} fica na Fazenda Go'shek, a nordeste da planície dos raptores, na volta para {area:321}; a caixa de {item:278462} está lá dentro.",

	-- Step 31: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "De volta a {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "Volte para o nordeste até {area:321}.",

	-- Step 32: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Missões Punho de Pedra para um grupo",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "A próxima {quest:678} de {npc:2771} e a {quest:680} de {npc:2772} são os ogros elite (38-40) do bairro dos ogros de Stromgarde, na mesma viagem em grupo do Signo.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, ao lado dele",

	-- Step 33: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Siga para o oeste; o círculo externo fica no meio do planalto.",

	-- Step 34: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "O círculo oeste fica perto de {area:1057}, a noroeste do círculo externo.",

	-- Step 35: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "O círculo interno fica ao sul do círculo oeste, a leste de Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "A próxima tarefa da pedra exige Fozruk, um elite de nível 42 que vaga a oeste de {area:321}: deixe de lado.",

	-- Step 36: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "A oeste do círculo interno, as ruínas de Stromgarde: a Camarilha ocupa a metade leste (o Sigilo cai dos Conjuradores, Predadores e Magus deles), os Punho de Pedra a metade oeste, junto a {area:325} ({npc:2773} espera numa das casas sem teto ao lado dela).",

	-- Step 37: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Siga para o sul até a enseada dos goblins, na costa sul. {npc:2766} vigia do penhasco acima dela.",

	-- Step 38: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Escolte o professor colina acima até a caverna sobre a enseada e proteja-o enquanto ele trabalha. Dois elementais da água de nível 40 o emboscam ali, e são imunes a gelo. Segure-os na boca da caverna, longe dele: se a luta acontecer dentro da caverna, ele entra na briga em vez de trabalhar, e continuam vindo mais elementais.",

	-- Step 40: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: vá matando estes pelo caminho",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "A oeste da enseada, os Saqueadores e Feiticeiras Espinhadaga (38-40) ocupam a praia: puxe um de cada vez. Os dois naufrágios ficam nas águas rasas em frente, com as cartas e os diários dentro; as gemas ficam no fundo do mar em volta dos naufrágios.",
	["Underwater"] = "Debaixo d'água",

	-- Step 41: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "para {npc:2487} em {area:35}, por volta do nível 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "O próximo guia atravessa {area:880} para {zone:1437} e segue rumo a {zone:1418}.",

	-- Step 42: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Só se você fez Stromgarde em grupo: volte a {area:321} para as entregas e siga para {area:880}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Head back east to {area:272}."] = "Volte para leste até {area:272}.",
	-- ["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Saia de {area:272} para leste, passando por {area:1057}. A Camarilha ocupa a mansão murada e sua fazenda ao norte da estrada; seus Bandoleiros, Mercenários e Tocaiantes carregam os Amuletos de Pedra-sangrenta.\nCuidado: os Bandoleiros (nível 30-31) podem estar em Furtividade, então podem estar escondidos quando você chegar perto.",
	-- ["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Siga ao norte, passando pelo acampamento de Vito, até {area:280}, a vila dominada pela Camarilha (35-37). {npc:2431} carrega {item:3704}; {quest:503} está numa jaula na casa do lado norte.\nCuidado: espiões furtivos da Camarilha rondam {area:280}, e os prédios têm muitos monstros da Camarilha, entre eles magos.",
	-- ["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Siga para noroeste pelas montanhas até a mansão Perenolde, na margem norte de {area:1339}. {quest:507} (41) espera num quarto no andar de cima: ele se protege com escudo, faz você dormir e se cura abaixo da metade da vida. {npc:2317} fica ao lado dele.",
	-- ["Perenolde manor"] = "Mansão Perenolde",
	-- ["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Ao sul pela margem do lago, até as ruínas em volta da cratera de {area:279}. Os Evocadores de Dalaran comandam Escravos Elementais; as braçadeiras caem dos escravos. Cuidado: Sentinelas Arcanas (55, elite) e Guardas do Kirin Tor (55) guardam a própria cúpula e atacam a Horda: fique na borda externa das ruínas e não suba até a cúpula.",
	-- ["The {object:1763} poster by the inn"] = "O cartaz {object:1763} perto da estalagem",
	-- ["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "A oeste do círculo interno, as ruínas de Stromgarde: a Camarilha ocupa a metade leste (o Sigilo cai dos Conjuradores, Predadores e Magus deles; {npc:2783} está entre eles), os Punho de Pedra a metade oeste, junto a {area:325} ({npc:2773} espera numa das casas sem teto ao lado dela).",
	-- ["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} espera dentro da estalagem de {area:272}, descendo a estrada de volta ao sul.",
	-- ["{npc:2229}, inside the inn"] = "{npc:2229}, dentro da estalagem",
	-- ["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) leva a cabeça. Ele aparece em um lugar de cada vez: a adega da estalagem de {area:280}, ou um dos acampamentos de tendas da Camarilha nas terras altas ao norte e noroeste da vila, que ficam no seu caminho para a mansão Perenolde. Se você já o encontrou ao libertar {quest:503}, esta etapa está feita.",
	-- ["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "A próxima {quest:671} de {npc:2706} é {npc:2783}, um bruxo elite de nível 40 no bairro da Camarilha de Stromgarde.",
	-- ["{npc:2733}'s lab shack stands at Go'shek Farm, south-west of the raptors' plain; the case of {item:278462} is inside."] = "O barraco-laboratório de {npc:2733} fica na Fazenda Go'Shek, a sudoeste da planície dos raptores; a caixa de {item:278462} está lá dentro.",
	-- ["{quest:671} with a group"] = "{quest:671} com um grupo",
}
