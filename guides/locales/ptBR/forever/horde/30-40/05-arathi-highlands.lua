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

	-- Step 3: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Mestre de voo de {zone:1458}",

	-- Step 4: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside the inn"] = "{npc:2229}, dentro da estalagem",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "O cartaz {object:1763} perto da estalagem",

	-- Step 6: Gol'dir
	-- {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Siga ao norte, passando pelo acampamento de Vito, até {area:280}, a vila dominada pela Camarilha (35-37). {npc:2431} carrega {item:3704}; {quest:503} está numa jaula na casa do lado norte.\nCuidado: espiões furtivos da Camarilha rondam {area:280}, e os prédios têm muitos monstros da Camarilha, entre eles magos.",
	["Inside"] = "Lá dentro",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Descubra onde {quest:503} está preso, no último andar",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, no último andar",

	-- Step 8: Tarren Mill
	-- {npc:2229} Krusk · {area:272} Tarren Mill
	["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} espera dentro da estalagem de {area:272}, descendo a estrada de volta ao sul.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, lá dentro",

	-- Step 9: Baron Vardus
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad · {quest:503} Gol'dir
	["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) leva a cabeça. Ele aparece em um lugar de cada vez: a adega da estalagem de {area:280}, ou um dos acampamentos de tendas da Camarilha nas terras altas ao norte e noroeste da vila, que ficam no seu caminho para a mansão Perenolde. Se você já o encontrou ao libertar {quest:503}, esta etapa está feita.",

	-- Step 10: Alterac Mountains
	["Perenolde manor"] = "Mansão Perenolde",

	-- Step 11: Lord Aliden Perenolde
	-- {area:1339} Lordamere Lake · {quest:507} Lord Aliden Perenolde · {npc:2317} Elysa
	["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Siga para noroeste pelas montanhas até a mansão Perenolde, na margem norte de {area:1339}. {quest:507} (41) espera num quarto no andar de cima: ele se protege com escudo, faz você dormir e se cura abaixo da metade da vida. {npc:2317} fica ao lado dele.",

	-- Step 12: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}: vá matando estes pelo caminho",
	-- {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave
	["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves."] = "Ao sul pela margem do lago, até as ruínas em volta da cratera de {area:279}. Os Evocadores de Dalaran comandam Escravos Elementais; as braçadeiras caem dos escravos.",

	-- Step 14: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "Volte para leste até {area:272}.",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, lá dentro",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, lá dentro",
	["The magus offers a dungeon errand next: leave it."] = "O mago oferece em seguida um serviço de masmorra: deixe de lado.",

	-- Step 15: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "",

	-- Step 16: Northfold Manor
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Saia de {area:272} para leste, passando por {area:1057}. A Camarilha ocupa a mansão murada e sua fazenda ao norte da estrada; seus Bandoleiros, Mercenários e Tocaiantes carregam os Amuletos de Pedra-sangrenta.\nCuidado: os Bandoleiros (nível 30-31) podem estar em Furtividade, então podem estar escondidos quando você chegar perto.",

	-- Step 17: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Siga a estrada para leste. Os cacos violeta brilham um pouco fora da estrada, a uma curta distância a oeste de {area:321}.",

	-- Step 18: Hammerfall
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, no portão sul",

	-- Step 19: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Missões de Stromgarde para um grupo",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "O {quest:639} de {npc:2703} cai dos elites da Camarilha (35-38) nas ruínas de Stromgarde, no oeste do planalto. Ótima XP se você tiver um grupo: a rota passa por Stromgarde a caminho do círculo interno.",

	-- Step 20: Foul Magics with a group
	-- {quest:671} Foul Magics
	["{quest:671} with a group"] = "{quest:671} com um grupo",
	-- {npc:2706} Tor'gan · {quest:671} Foul Magics · {npc:2783} Marez Cowl
	["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "A próxima {quest:671} de {npc:2706} é {npc:2783}, um bruxo elite de nível 40 no bairro da Camarilha de Stromgarde.",

	-- Step 21: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "A nordeste da Ruína do Martelo, os kobolds Bigodesseco mineram o desfiladeiro; os Kobolds da entrada e os Escavadores e Topógrafos lá do fundo deixam cair as Partículas de Myzrael.\nCuidado: todo tipo de kobold sai correndo atrás de ajuda com pouca vida (Kobolds com 30%, Topógrafos e Escavadores com 15%), o que pode trazer mais deles.",

	-- Step 22: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "Os {object:2701} ficam no fundo do desfiladeiro.",
	["Below ground"] = "No subterrâneo",

	-- Step 23: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Cada {object:180105} é um anel de monólitos; a chave fica na pedra do centro. O círculo do leste fica nas colinas a noroeste de {area:321}.\nCuidado: cada pedra central é guardada por uns três elementais perto do nível 39, que atacam juntos se você clicar na pedra sem limpá-los antes: Exilados em Chamas no Oeste, Exilados Trovejantes no Externo, Exilados Vagalhantes no Leste.",

	-- Step 24: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Os Brutamontes Punho de Pedra acampam fora do salão dos ogros, bem a sudoeste de {area:321}; os Magus Punho de Pedra ficam entre eles. Puxe um de cada vez.",

	-- Step 25: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptores Fareja-carne",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Farejas-carne do Planalto (36-37) caçam no planalto sul, um bando ao norte de {area:316} e outro na planície a oeste. Puxe um de cada vez.",

	-- Step 26: Go'shek Farm
	["Go'shek Farm"] = "Fazenda Go'Shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "O barraco de laboratório de {npc:2733} fica na Fazenda Go'shek, a nordeste da planície dos raptores, na volta para {area:321}; a caixa de {item:278462} está lá dentro.",

	-- Step 27: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "De volta a {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "Volte para o nordeste até {area:321}.",

	-- Step 28: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Missões Punho de Pedra para um grupo",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "A próxima {quest:678} de {npc:2771} e a {quest:680} de {npc:2772} são os ogros elite (38-40) do bairro dos ogros de Stromgarde, na mesma viagem em grupo do Signo.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, ao lado dele",

	-- Step 29: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Siga para o oeste; o círculo externo fica no meio do planalto.",

	-- Step 30: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "O círculo oeste fica perto de {area:1057}, a noroeste do círculo externo.",

	-- Step 31: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "O círculo interno fica ao sul do círculo oeste, a leste de Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "A próxima tarefa da pedra exige Fozruk, um elite de nível 42 que vaga a oeste de {area:321}: deixe de lado.",

	-- Step 32: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {npc:2783} Marez Cowl · {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "A oeste do círculo interno, as ruínas de Stromgarde: a Camarilha ocupa a metade leste (o Sigilo cai dos Conjuradores, Predadores e Magus deles; {npc:2783} está entre eles), os Punho de Pedra a metade oeste, junto a {area:325} ({npc:2773} espera numa das casas sem teto ao lado dela).",

	-- Step 33: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Siga para o sul até a enseada dos goblins, na costa sul. {npc:2766} vigia do penhasco acima dela.",

	-- Step 34: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Escolte o professor colina acima até a caverna sobre a enseada e proteja-o enquanto ele trabalha. Dois elementais da água de nível 40 o emboscam ali, e são imunes a gelo. Segure-os na boca da caverna, longe dele: se a luta acontecer dentro da caverna, ele entra na briga em vez de trabalhar, e continuam vindo mais elementais.",

	-- Step 36: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: vá matando estes pelo caminho",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "A oeste da enseada, os Saqueadores e Feiticeiras Espinhadaga (38-40) ocupam a praia: puxe um de cada vez. Os dois naufrágios ficam nas águas rasas em frente, com as cartas e os diários dentro; as gemas ficam no fundo do mar em volta dos naufrágios.",
	["Underwater"] = "Debaixo d'água",

	-- Step 37: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "para {npc:2487} em {area:35}, por volta do nível 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "O próximo guia atravessa {area:880} para {zone:1437} e segue rumo a {zone:1418}.",

	-- Step 38: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Só se você fez Stromgarde em grupo: volte a {area:321} para as entregas e siga para {area:880}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:2733}'s lab shack stands at Go'shek Farm, south-west of the raptors' plain; the case of {item:278462} is inside."] = "O barraco-laboratório de {npc:2733} fica na Fazenda Go'Shek, a sudoeste da planície dos raptores; a caixa de {item:278462} está lá dentro.",
}
