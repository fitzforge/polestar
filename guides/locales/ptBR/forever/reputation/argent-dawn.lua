-- Portuguese (Brazil) (ptBR): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Reputação: Aurora Argêntea",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "Pedras do Flagelo, {area:2057} e {area:2279}: os encantamentos de resistência para ombros e uma dúzia de receitas.",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "Receitas para Alfaiates, Coureiros, Ferreiros, Encantadores e Alquimistas de Honrado e Reverenciado",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Aliança)",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10840} fica em {area:3197}, no sul de {zone:1422}. {object:2160} começa em Neutro 200 para todos. Use o berloque da Ordem enquanto luta contra o Flagelo: as Pedras do Flagelo só caem enquanto você o usa. {npc:11039} em {area:2268} dá a mesma Ordem; você só pode pegar uma.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horda)",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10839} fica em {area:152}, na estrada de {zone:1420} para {zone:1422}. {object:2160} começa em Neutro 200 para todos. Use o berloque da Ordem enquanto luta contra o Flagelo: as Pedras do Flagelo só caem enquanto você o usa. {npc:11039} em {area:2268} dá a mesma Ordem; você só pode pegar uma.",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "De Neutro a Amigável: o Flagelo de {zone:1422}",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "Cada morte do Flagelo nas Terras Pestilentas dá 5 de reputação (os nomeados, 15), dos carniçais e esqueletos de nível 50 em diante; no nível 60 escolha os de nível 53 ou mais, pois no Classic os monstros cinza dão só cerca de um quinto. De Neutro a Amigável são 2.800: cerca de 560 mortes, menos com as missões das Terras Pestilentas pelo caminho. O Flagelo mais denso fica ao redor dos quatro Caldeirões do Flagelo: {area:199} a oeste de Andorhal (esqueletos, 50-53), {area:200} ao norte de Andorhal (zumbis e carniçais, 52-55), {area:202} no sul (carniçais, 54-55) e {area:201} no leste (fantasmas, 56-57). Guarde toda Pedra do Flagelo e toda missão que puder: as entregas nunca deixam de contar, as mortes deixam. {quest:5510} caem de cerca de quatro em cada dez desse Flagelo, as do Invasor de cerca de um terço dos de nível 56 ou mais. Se você morrer, tire a Ordem e coloque de novo: ela pode perder o efeito. Paladinos (Humanos e Anões): {npc:10838} em {area:3197} pede 20 {quest:5510} uma vez para Dissipando o mal, 100 de reputação em vez de 25. A vantagem do Legado Diplomata soma até 10% a todo ganho.",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "{quest:5510}: guarde-as",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "Assombrações Vorazes em {area:201}; qualquer Flagelo conta",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "Carniçais Desalmados em {area:202}",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "Missões das Terras Pestilentas e os Caldeirões do Flagelo",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "As missões das Terras Pestilentas pagam por inteiro no nível 60 a partir do nível 55 e nunca deixam de contar, cerca de 1.500 no total; os guias de leveling percorrem todas. A cadeia dos caldeirões de {npc:11053} em {area:3197} (Horda: {npc:11055} em {area:152}): 150 por caldeirão com a volta, depois Missão cumprida! 200. Adeus, Andorhal 150 ({npc:1852}, elite). Em {area:2268}, as missões de {area:2262} de {npc:11063} (Irmão Carlin 50 com Crona em Andorhal, Vilões da Vila das Flechas 100, Espoliadores da Vila das Flechas 100) e Tesouros escondidos 200 de {npc:10926} no fim da história de {area:2262}; {npc:12250} 75 de {npc:11038}. Depois de Missão cumprida!, cada caldeirão aceita uma entrega repetível: 25 de reputação a cada vez, até Exaltado. {npc:11056} em {area:3197} (Horda: {npc:11057} em {area:152}) dá um {item:13370}, sem o qual os reagentes nunca caem, e vende Aceleradores Arcanos por 50 pratas (um por entrega; ele se desfaz em 30 minutos, então compre por último). Cada entrega também leva 4 {item:14047}. Farme {area:201}: os fantasmas de lá soltam um {item:13354} cerca de uma vez em quatro, então umas 16 mortes enchem uma entrega; os outros caldeirões querem 5 ou 6 reagentes que caem uma vez em dez ou menos. Quando o Flagelo das Terras Pestilentas deixar de contar, isso rende cerca de quatro vezes o que as Pedras do Flagelo sozinhas rendem.",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "{npc:11056}: peça um {item:13370}",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "{npc:11057}, em {area:152}: peça um {item:13370}",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}"] = "o caldeirão em {area:201}",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "Ressonadores Ectoplásmicos: os fantasmas ao redor do caldeirão",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "{item:13320}, 50 pratas",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "Missões de {area:2268}",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243254} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243254} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "{area:2268}, no lado leste de {zone:1423}, é o lar de {faction:529}: {npc:11039}, {npc:11035} e {npc:243254} dão as missões de masmorra, de 100 a 200 de reputação cada uma e cerca de 1.700 no total. São missões de grupo para {area:2279} e {area:2057} (nível 58-60, cinco jogadores): pegue as que seu grupo vai fazer. A cadeia do Duque termina em {object:176317}, um baú com equipamento de {faction:529}.",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "{area:2279} é um grupo de cinco no extremo norte de {zone:1423}. O Flagelo de lá dá 5 de reputação por morte até o último ponto de Honrado, e os chefes do Flagelo 25 até Exaltado ({npc:10440} 50), cada um com {item:12843}. As Sentinelas da Guarda Negra perto do Barão dão 5 até Exaltado. O lado do Flagelo, pela entrada de serviço, paga bem mais que o lado Escarlate.",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "Amostras de Carne Infectada: o Flagelo lá dentro",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "{item:13180}: os caixotes de suprimentos",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "{npc:10811}, lado Escarlate",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "{area:2057} fica sob {area:2298}, a cidade-ilha no sudeste de {zone:1422}; as missões de {area:2057} do seu lado dão {item:13704}, que a abre. É a melhor masmorra de {faction:529}: seus monstros dão 5 até o último ponto de Honrado, e seus treze chefes cerca de 375 de reputação numa limpeza completa, mais umas dez {quest:5508} (cerca de 250 a mais). {npc:10508} e {npc:1853} dão 50 cada.",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "{quest:5529}, no incubatório",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "De volta a {area:2268}",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243254} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243254} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "{quest:5212} leva a {quest:5213} ({item:13176} em um zigurate de {area:2279}), que recompensa com {item:13209} ou {item:19812}: berloques melhores que também fazem as Pedras do Flagelo caírem, então podem substituir a Ordem. {quest:5251} segue para {item:13250} e {npc:10440}. {item:13920}, saque raro (cerca de 6%) de {quest:5529} depois que {quest:5529} está feita, inicia uma missão que vale 50 a cada vez: guarde-as até Reverenciado. {npc:10267} em {zone:1428}, no fim das missões dela de {area:1583}, manda você a {npc:243254} (75) e depois a {item:12368} de {npc:11035} em {area:2057} (25 e 200).",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "De Amigável a Honrado: pedras e Flagelo nomeado",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "O Flagelo comum fora das masmorras para de dar reputação no meio de Amigável (3.000 de 6.000); {npc:10826}, {npc:10821} e {npc:10825} param no fim de Amigável. Depois disso só contam Araj, os monstros de {area:2057} e {area:2279}, as entregas dos caldeirões e as Pedras do Flagelo. Agora entregue as pedras que guardou: {npc:11039} em {area:2268} aceita os três tipos, e os oficiais em {area:3197} e {area:152} também. Cada entrega paga 25 e um {item:12844}: guarde 35 símbolos para os mantos em Reverenciado e Exaltado. {quest:5509} valem o dobro por pedra: os Adeptos das Trevas, Umbramantes, Tecemedos e Campeões do Flagelo (nível 58-60) em {area:2272}, logo ao norte de {area:2268}, as soltam cerca de um terço das vezes ou mais, ao lado da entrega. O Flagelo nomeado abaixo solta {item:12843} metade das vezes ou mais ({npc:1850} duas em três, Araj e {npc:10821} metade das vezes) e dá 15 por morte, Araj até Exaltado; {npc:1850} não dá reputação, só a pedra. Amigável libera os Biscoitos de Maná Enriquecidos (60 pratas) com os intendentes.",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "{item:12843}: o Flagelo nomeado abaixo e os chefes de masmorra",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at {area:2272}"] = "Adeptos das Trevas e Umbramantes em {area:2272}",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "{npc:1852}, Andorhal",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "{npc:1850}, {zone:1422}: só a pedra",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "{quest:5510}: 20 por 25 de reputação",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "{quest:5509}: 10 por 25 de reputação",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "{quest:5508}: 1 por 25 de reputação",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "De Honrado a Reverenciado: masmorras e pedras",
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "De Honrado a Reverenciado são 12.000: cerca de 2.400 monstros de {area:2057} e {area:2279}, menos com os chefes. Os monstros deles param em 11.999 de 12.000 de Honrado; um chefe ou uma entrega leva você além. Sozinho, só contam Pedras do Flagelo, as entregas dos caldeirões e Araj: 12.000 são 480 entregas, ou 4.800 {quest:5509}. Guarde as pedras que pegar nas masmorras até os monstros delas pararem de contar. Honrado libera receitas nos três intendentes: {npc:11536} em {area:2268}, {npc:10857} em {area:3197}, {npc:10856} em {area:152}. Também {item:22014} (133 de ouro) para a missão Três reis das chamas.",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "{item:19446}, 3 de ouro",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "{item:19216} ({skill:197}), 2 de ouro e 20 pratas",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "{item:19328} ({skill:165}), 2 de ouro e 20 pratas",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "{item:19203} ({skill:164}), 2 de ouro e 20 pratas",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "{item:13482} ({skill:171}), 1 de ouro e 50 pratas",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "{item:19442} ({skill:129}), 10 de ouro",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5504} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5504} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "Em Reverenciado, {npc:11536} aceita 10 Símbolos de Bravura da Aurora Argêntea por {quest:5504} (100 de reputação). Depois dela, qualquer intendente de {faction:529} vende os cinco encantamentos de ombro por 10 de ouro cada: Chamas, Gelo, Arcano, Natureza e {item:18173}, +5 nessa resistência. Reverenciado também libera {item:13810} e seu suco (60 pratas) e as receitas de Reverenciado.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "Símbolos de Bravura da Aurora Argêntea, das entregas de pedras",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "{item:18170}: escolha a resistência que precisar, 10 de ouro",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "{item:19447}, 6 de ouro",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "{item:19217} ({skill:197}), 4 de ouro",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "{item:19329} ({skill:165}), 4 de ouro",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "{item:19205} ({skill:164}), 4 de ouro",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "De Reverenciado a Exaltado são 21.000: 840 entregas de Pedras do Flagelo ou de caldeirões, ou os chefes de masmorra com suas {quest:5508} (uma limpeza completa de {area:2057} dá cerca de 600). Entregue toda pedra e todo {item:13920} que você guardou.",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "Em Exaltado, {npc:11536} aceita 25 Símbolos de Bravura da Aurora Argêntea pela {quest:5517} (150 de reputação): +5 em todas as resistências, nas suas ombreiras. Depois dela, os intendentes vendem mais por 40 de ouro cada.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "Símbolos de Bravura da Aurora Argêntea",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Corruptor's Scourgestones and dungeons to Revered"] = "Pedras do Flagelo do Corruptor e masmorras até Reverenciado",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Adeptos das Trevas e Umbramantes (nível 58-60) deixam cair Pedras do Flagelo do Invasor aqui, além das do Lacaio e {item:14047}. Entregue as do Invasor de 10 em 10 e as do Lacaio de 20 em 20 a {npc:11039} em {area:2268}. No Classic, as duas param de dar reputação em Honrado.",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "A partir de Honrado, Pedras do Flagelo do Corruptor (uma por entrega) e mortes de Flagelo em {area:2279} e {area:2057} rendem a reputação. As do Corruptor caem dos chefes do Flagelo de lá ({npc:1853}, {npc:10433}, Vectus) e de {npc:1852} e Putrídius em {zone:1422}. Várias incursões em masmorras rendem mais rápido do que qualquer caçada em mundo aberto.",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Carniçais e esqueletos por todas as {zone:1422} deixam cair Pedras do Flagelo do Lacaio cerca de metade das vezes; este agrupamento é denso. Entregue-as de 20 em 20 a qualquer Oficial Argênteo (Cândida em {area:3197}, Garush em {area:152}, {npc:11039} em {area:2268}). Cada entrega também rende um {item:12844} para os intendentes da Aurora Argêntea.",
	-- ["Invader's Scourgestones to Honored"] = "Pedras do Flagelo do Invasor até Honrado",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Continue fazendo {area:2279} e {area:2057} e entregando cada {item:12843} em {area:2268} até Exaltado.",
	-- ["Minion's Scourgestones to Friendly"] = "Pedras do Flagelo do Lacaio até Amistoso",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Faça {area:2279} (as duas alas) e {area:2057}, matando todo Flagelo pelo caminho.",
	-- ["{faction:529} to Exalted"] = "{faction:529} até Exaltado",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} começa em Neutro. Pegue a Ordem com {npc:10839} em {area:152} e equipe-a: no Classic, Pedras do Flagelo só caem enquanto o berloque {quest:5401} estiver equipado. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} começa em Neutro. Pegue a Ordem com {npc:10840} em {area:3197} e equipe-a: no Classic, Pedras do Flagelo só caem enquanto o berloque {quest:5401} estiver equipado. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
}
