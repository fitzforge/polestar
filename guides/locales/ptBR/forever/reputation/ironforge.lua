-- Portuguese (Brazil) (ptBR): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "Reputação: Altaforja",
	-- {zone:1428} Burning Steppes · {zone:1426} Dun Morogh · {area:133} Gnomeregan · {zone:1459} Alterac Valley
	["Cloth, the {zone:1428} quests and the {zone:1426} hubs, which pay {area:133} too; {zone:1459} adds more."] = "Tecido, as missões de {zone:1428} e os polos de {zone:1426}, que também rendem para {area:133}; {zone:1459} rende mais.",
	-- {faction:47} Ironforge
	["Exalted with {faction:47}: in Classic, other races may buy the rams"] = "Exaltado com {faction:47}: no Classic, outras raças podem comprar os carneiros",
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1459} Alterac Valley
	["About 600 {faction:47} reputation from level 52-59 quests in the {zone:1428} and {zone:1452}; {zone:1459}'s quests pay {faction:47} too"] = "Cerca de 600 de reputação de {faction:47} com missões de nível 52-59 em {zone:1428} e {zone:1452}; as missões de {zone:1459} também rendem para {faction:47}",
	-- {faction:47} Ironforge · {zone:1426} Dun Morogh · {area:133} Gnomeregan
	["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too"] = "Cerca de 2.900 de reputação de {faction:47} com missões de nível baixo em {zone:1426}, a maior parte rendendo também para {area:133}",

	-- Step 1: Mistina Steelshield, the cloth quartermaster
	-- {npc:14723} Mistina Steelshield
	["{npc:14723}, the cloth quartermaster"] = "{npc:14723}, a intendente do tecido",
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {object:32372} Great Forge (no name in this language: may be words) · {item:14047} Runecloth · {quest:7806} Additional Runecloth · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {zone:1437} Wetlands · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {area:132} Coldridge Valley · {area:131} Kharanos · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14723} takes cloth for {faction:47}; she stands outside the clothier on the north side of the {object:32372}, among the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7806} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12), {zone:1432} (10-20) and the {zone:1437} (20-30) while you level through them. After the donations come the level 52-59 quests of the {zone:1428} and {zone:1452} (about 600), then the optional {zone:1426} hubs, best rate first: {area:132} (about 37 a minute at full value), {area:131} (26), the quarry (17). Every {faction:47} gain also gives a quarter as much to {zone:1453}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14723} aceita tecido para {faction:47}; ela fica do lado de fora da alfaiataria, no lado norte de {object:32372}, entre os alfaiates. Cada primeira doação de 60 Lã, Seda, Magitrama e {item:14047} paga 150 de reputação uma vez; depois da doação de {item:14047}, {quest:7806} paga 50 a cada 20 {item:14047}, quantas vezes você quiser. A Casa de Leilões de Commons é a fonte mais rápida de tecido. No Classic, as missões pagam reputação cheia enquanto estiverem no máximo 5 níveis abaixo de você, então faça {zone:1426} (níveis 1-12), {zone:1432} (10-20) e {zone:1437} (20-30) enquanto sobe de nível por elas. Depois das doações vêm as missões de nível 52-59 de {zone:1428} e {zone:1452} (cerca de 600), então os polos opcionais de {zone:1426}, do melhor ritmo ao pior: {area:132} (cerca de 37 por minuto com valor cheio), {area:131} (26), a pedreira (17). Todo ganho com {faction:47} também dá um quarto disso para {zone:1453}, {zone:1457} e os Exilados de Gnomeregan, exceto missões das áreas iniciais de nível 1-10. O Legado Diplomata soma até 10% a cada ganho.",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592}: troggs, gnolls e kobolds em {zone:1432} e em {zone:1437}",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: o vale inicial dos anões e gnomos, a sudoeste de {area:131}, cerca de 1.100 de reputação em 30 minutos no 60. {npc:658} e {npc:713} ficam em {area:77}. O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 3: Coldridge: wolves, troggs and Felix Whindlebolt's things
	-- {npc:8416} Felix Whindlebolt
	["Coldridge: wolves, troggs and {npc:8416}'s things"] = "Cristálgida: lobos, troggs e as coisas de {npc:8416}",
	-- {area:77} Anvilmar · {npc:8416} Felix Whindlebolt
	["The wolves roam the valley floor; the troggs dig in the camps east of {area:77}; {npc:8416}'s box, chest and bucket lie in the trogg camps."] = "Os lobos vagam pelo fundo do vale; os troggs cavam nos acampamentos a leste de {area:77}; a caixa, o baú e o balde de {npc:8416} estão nos acampamentos de troggs.",

	-- Step 4: Coldridge: Anvilmar and Talin Keeneye
	-- {area:77} Anvilmar · {npc:714} Talin Keeneye
	["Coldridge: {area:77} and {npc:714}"] = "Cristálgida: {area:77} e {npc:714}",

	-- Step 5: Coldridge: Grelin Whitebeard and the troll cave
	-- {npc:786} Grelin Whitebeard
	["Coldridge: {npc:786} and the troll cave"] = "Cristálgida: {npc:786} e a caverna dos trolls",
	-- {npc:786} Grelin Whitebeard · {area:77} Anvilmar
	["{npc:786} camps south of {area:77}, at the mouth of the troll cave; the journal lies at the back of the cave."] = "{npc:786} acampa ao sul de {area:77}, na boca da caverna dos trolls; o diário está no fundo da caverna.",

	-- Step 6: Coldridge: the hot Mornbrew
	["Coldridge: the hot Mornbrew"] = "Cristálgida: o rabo-de-galo quente",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew cools in five minutes: run straight to {npc:836} at {area:77}."] = "O Rabo-de-galo Escaldante esfria em cinco minutos: corra direto até {npc:836} em {area:77}.",

	-- Step 7: Coldridge: on to Kharanos
	-- {area:131} Kharanos
	["Coldridge: on to {area:131}"] = "Cristálgida: seguindo para {area:131}",
	-- {npc:1252} Senir Whitebeard · {area:131} Kharanos
	["{npc:1252}, in {area:131}"] = "{npc:1252}, em {area:131}",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the inn"] = "{npc:6806}, na estalagem",

	-- Step 8: Kharanos
	-- {area:131} Kharanos · {area:133} Gnomeregan · {area:2102} Thunderbrew Distillery · {area:189} Steelgrill's Depot
	["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: {area:131} e as estradas de Brewnall e de {area:133} ao redor, cerca de 1.300 de reputação em 50 minutos no 60. A maioria de quem dá as missões fica dentro e ao redor de {area:2102} e em {area:189}, a leste de lá. O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 9: Kharanos: the hills and the depot
	-- {area:131} Kharanos
	["{area:131}: the hills and the depot"] = "{area:131}: as colinas e o depósito",
	-- {area:131} Kharanos · {area:136} Grizzled Den · {area:133} Gnomeregan
	["The boars and bears roam around {area:131}; the wendigos live in the {area:136} south-west of town; the leper gnomes at the {area:133} road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "Os javalis e os ursos vagam em volta de {area:131}; os wendigos vivem em {area:136}, a sudoeste da cidade; os gnomos leprosos da estrada de {area:133} carregam as engrenagens; a munição de Estremetiro está no acampamento dele, a oeste da cidade.",

	-- Step 10: Kharanos: back in town
	-- {area:131} Kharanos
	["{area:131}: back in town"] = "{area:131}: de volta à cidade",

	-- Step 11: Kharanos: Brewnall and Frostmane Hold
	-- {area:131} Kharanos · {quest:287} Frostmane Hold
	["{area:131}: Brewnall and {quest:287}"] = "{area:131}: Brewnall e {quest:287}",
	-- {npc:1374} Rejold Barleybrew · {area:137} Brewnall Village · {area:131} Kharanos · {quest:287} Frostmane Hold
	["{npc:1374} stands by {area:137} on the lake north-west of {area:131}; {quest:287} is the troll cave west of it."] = "{npc:1374} fica perto de {area:137}, no lago a noroeste de {area:131}; {quest:287} é a caverna dos trolls a oeste dele.",
	["walk to the back of the cave"] = "siga até o fundo da caverna",

	-- Step 12: Kharanos: last hand-in
	-- {area:131} Kharanos
	["{area:131}: last hand-in"] = "{area:131}: última entrega",

	-- Step 13: The quarry and Amberstill Ranch
	-- {area:803} Amberstill Ranch
	["The quarry and {area:803}"] = "A pedreira e {area:803}",
	-- {zone:1426} Dun Morogh · {npc:264936} Earthseer Farsen · {area:134} Gol'Bolar Quarry · {area:803} Amberstill Ranch
	["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation in 30 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: o leste de {zone:1426}, do acampamento de {npc:264936} até {area:134} e {area:803}, cerca de 500 de reputação em 30 minutos no 60. O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 14: The quarry: troggs, spies and Vagash
	-- {npc:1388} Vagash
	["The quarry: troggs, spies and {npc:1388}"] = "A pedreira: troggs, espiões e {npc:1388}",
	-- {area:134} Gol'Bolar Quarry · {npc:1388} Vagash · {area:803} Amberstill Ranch
	["The Dark Iron Spies lurk around Farsen's camp; the troggs dig in the {area:134}; {npc:1388}, a big snow leopard, prowls the hills above {area:803}."] = "Os Espiões Ferro Negro rondam o acampamento de Farsen; os troggs cavam em {area:134}; {npc:1388}, um grande leopardo-da-neve, percorre as colinas acima de {area:803}.",

	-- Step 15: The Reports
	-- {npc:1274} Senator Barin Redstone
	["{npc:1274}, in the throne room"] = "{npc:1274}, na sala do trono",

	-- Step 16: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1437} Wetlands
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "{item:4306} cai de humanoides de nível 23 a 40: os Presa do Dragão de {zone:1437}, a Camarilha de Alterac e de Arathi, os trolls da Selva do Espinhaço.",

	-- Step 17: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron (no name in this language: may be words) · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "{item:4338} cai de humanoides de nível 35 a 50: os anões Umbraforja e {object:147516} de {zone:1418} e {zone:1427}, os ogros Dunamalho de {zone:1446}, os nagas Cristafúria de {zone:1444}.",

	-- Step 18: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7806} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7806}."] = "{item:14047} cai de humanoides de nível 50 ou mais: os cultistas do Flagelo e a Cruzada Escarlate nas Terras Pestilentas, os furbolgs Lenha Morta de {zone:1448}, os furbolgs Invernosos de {zone:1452}. Guarde todo {item:14047} além dos 60 primeiros para {quest:7806}.",

	-- Step 19: Ironforge: Royal Historian Archesonus
	-- {faction:47} Ironforge · {npc:8879} Royal Historian Archesonus · {object:171709} High Seat · {zone:1428} Burning Steppes
	["These quests are level 52 to 59, so they pay in full at 60: about 600 {faction:47} reputation. {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "Estas missões são de nível 52 a 59, então pagam por inteiro no 60: cerca de 600 de reputação com {faction:47}. {npc:8879} fica ao lado do Rei Magni em {object:171709}; ele manda você às ruínas de Thaurissan em {zone:1428}.",
	-- {npc:8879} Royal Historian Archesonus
	["Hear {npc:8879} out"] = "Ouça {npc:8879} até o fim",

	-- Step 20: Morgan's Vigil: Oralius
	-- {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {npc:9177} Oralius · {area:249} Dreadmaul Rock
	["{area:2418} sits in the south-east of the {zone:1428}, at the top of the pass up from Redridge. {npc:9177} wants the Firegut ogres of {area:249}, north of the Vigil, thinned out; the Brutes keep to the rock's east side."] = "{area:2418} fica no sudeste de {zone:1428}, no alto da passagem que sobe de Cristarrubra. {npc:9177} quer os ogros Pirobucho de {area:249}, ao norte da Vigília, reduzidos em número; os Brutamontes ficam no lado leste da rocha.",

	-- Step 21: Thaurissan and Blackrock Stronghold
	-- {area:252} Blackrock Stronghold
	["Thaurissan and {area:252}"] = "Thaurissan e {area:252}",
	-- {area:251} Flame Crest · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {item:11467} Blackrock Medallion · {npc:9177} Oralius · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["The Thaurissan relics are the carved stones in the ruins around {area:251}, west along the road: click twelve of them. {npc:9176} and the Blackrock orcs and worgs hold the camps at the foot of {area:254}, further west; each may drop a {item:11467} (about one kill in three), and {npc:9177} wants fifty. The orcs are level 50 and up, so they drop {item:14047} too: keep it for {quest:7806}."] = "As relíquias de Thaurissan são as pedras entalhadas nas ruínas em volta de {area:251}, a oeste pela estrada: clique em doze delas. {npc:9176} e os orcs e worgs Rocha Negra dominam os acampamentos no pé de {area:254}, mais a oeste; cada um pode soltar um {item:11467} (cerca de uma morte em três), e {npc:9177} quer cinquenta. Os orcs são de nível 50 ou mais, então soltam {item:14047} também: guarde para {quest:7806}.",

	-- Step 22: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418}: entregar",
	-- {npc:9176} Gor'tesh · {area:249} Dreadmaul Rock
	["Plant {npc:9176}'s head on the soft dirt mound at the top of {area:249}."] = "Plante a cabeça de {npc:9176} no monte de terra fofa no alto de {area:249}.",

	-- Step 23: Ironforge: Archesonus again
	-- {faction:47} Ironforge
	["{faction:47}: Archesonus again"] = "{faction:47}: Arquefilis de novo",
	-- {area:1584} Blackrock Depths · {npc:9021} Kharan Mighthammer · {npc:9177} Oralius · {zone:1459} Alterac Valley · {faction:47} Ironforge · {item:17542} Coldtooth Supplies
	-- plural, as words: Dark Iron Fanny Packs = {item:11468} Dark Iron Fanny Pack · Storm Crystals = {item:17423} Storm Crystal
	["With a group, {area:1584} pays more: Archesonus's chain goes on with {npc:9021} (100) and The Fate of the Kingdom (Emperor Thaurissan, 150), and {npc:9177} takes 20 Dark Iron Fanny Packs from the dwarves inside (The Good Stuff, 100). {zone:1459}, from level 51, pays {faction:47} too: its one-time quests about 1,900 as your Stormpike standing grows (the {zone:1459} guide walks them), and inside the battle 25 for every 10 Irondeep or {item:17542} and 50 for 5 Storm Crystals, as often as you like."] = "Com um grupo, {area:1584} rende mais: a cadeia de Arquefilis segue com {npc:9021} (100) e O destino do reino (Imperador Thaurissan, 150), e {npc:9177} pede 20 Pochetes Ferro Negro dos anões lá dentro (Produto de primeira, 100). {zone:1459}, a partir do nível 51, também rende para {faction:47}: as missões únicas dela dão cerca de 1.900 conforme sua reputação com os Lançatroz cresce (o guia de {zone:1459} percorre todas), e dentro da batalha 25 por cada 10 de Ferrofundo ou {item:17542} e 50 por 5 Cristais de Tempestade, quantas vezes você quiser.",

	-- Step 24: Winterspring: Enraged Wildkin
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village · {area:2245} Mazthoril · {faction:47} Ironforge
	["{npc:11755} in {area:2255} sends you west to {npc:10301} at {area:2253}. {npc:10301}'s damaged crate and wrecked wagon lie at {area:2245}, down the valley to the south-east; his supplies lie around the wagon and the owlbeasts nearby carry his amulet. The last quest is level 59: 100 {faction:47} in full."] = "{npc:11755} em {area:2255} manda você para oeste até {npc:10301} em {area:2253}. A caixa danificada e a carroça destruída de {npc:10301} ficam em {area:2245}, vale abaixo a sudeste; os suprimentos dele estão em volta da carroça e as corujas-feras por perto carregam o amuleto dele. A última missão é de nível 59: 100 de {faction:47} inteiros.",

	-- Step 25: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806} até Honrado",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1426} Dun Morogh · {faction:47} Ironforge · {area:144} Thelsamar · {zone:1432} Loch Modan · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1459} Alterac Valley
	["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7806}: 50 de reputação por 20 {item:14047}, quantas vezes você quiser. Depois das quatro primeiras doações, um Humano, Elfo da Noite ou Gnomo fica em Amigável 700 de 6.000, então Honrado está a 5.300 de distância: 106 entregas, 2.120 {item:14047} (os Anões começam 900 acima: 88 entregas; os Celonatos começam em Neutro 2.000, a 6.400 de distância: 128, duas a menos depois de Explorando a Aliança). As missões de nível 52-59 acima tiram 12 entregas; cada polo de {zone:1426} que você fez tira de 10 a 26 a mais. Mais polos rendem para {faction:47}, inteiros enquanto estiverem no máximo 5 níveis abaixo de você: {area:144} em {zone:1432} (cerca de 3.500 no total) e {area:150} em {zone:1437} (cerca de 2.500). A partir do nível 51, as missões únicas de {zone:1459} somam cerca de 1.900. Todo ganho de cidade também rende um quarto disso para as outras três cidades da Aliança (não contado aqui). Entregue todo o seu {item:14047} de uma vez.",

	-- Step 26: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806} até Reverenciado",
	-- {npc:1261} Veron Amberstill · {item:14047} Runecloth
	["Honored: in Classic Ironforge's vendors take 10% off for you, {npc:1261}'s rams (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honrado: no Classic, os vendedores de Altaforja dão 10% de desconto a você, inclusive nos carneiros de {npc:1261} (20g, os velozes 200g); o Forever ainda não decidiu isso, e sites de guias falam em 5% em Amigável, subindo até 20% em Exaltado. De Honrado a Reverenciado são 12.000 de reputação: 240 entregas, 4.800 {item:14047}.",

	-- Step 27: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806} até Exaltado",
	-- {item:14047} Runecloth · {npc:1261} Veron Amberstill · {area:803} Amberstill Ranch · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:1261} at {area:803} in eastern {zone:1426} sells his rams to other races in Classic; the Ram and Swift Ram guides cover them."] = "De Reverenciado a Exaltado são 21.000 de reputação: 420 entregas, 8.400 {item:14047}. Em Exaltado, no Classic, {npc:1261} em {area:803}, no leste de {zone:1426}, vende os carneiros dele para outras raças; os guias de Carneiro e Carneiro Veloz tratam deles.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Adeptos das Trevas e Umbramantes (nível 58-60) deixam cair aqui; cada Flagelo morto aqui também conta para {object:92525} (veja esse guia). A Casa de Leilões também serve.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Ogros Dunamalho (nível 45-48) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7806} até ficar Exaltado com {faction:47}. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7806}, 20 {item:14047} por vez. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation (100 at a fifth) in 30 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: o leste de {zone:1426}, do acampamento de {npc:264936} até {area:134} e {area:803}, cerca de 500 de reputação (100 com um quinto) em 30 minutos no 60. No Classic, as missões 6 ou mais níveis abaixo de você pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram inteiro. Sua primeira entrega mostra qual vale: se pagar um quinto, pule esses polos. Pule este passo para pular o polo.",
	-- ["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation (220 at a fifth) in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: o vale inicial dos anões e gnomos, a sudoeste de {area:131}, cerca de 1.100 de reputação (220 com um quinto) em 30 minutos no 60. {npc:658} e {npc:713} ficam em {area:77}. No Classic, as missões 6 ou mais níveis abaixo de você pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram inteiro. Sua primeira entrega mostra qual vale: se pagar um quinto, pule esses polos. Pule este passo para pular o polo.",
	-- ["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation (260 at a fifth) in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: {area:131} e as estradas de Brewnall e de {area:133} ao redor, cerca de 1.300 de reputação (260 com um quinto) em 50 minutos no 60. A maioria dos recrutadores de missões fica dentro e em volta de {area:2102} e em {area:189}, a leste dele. No Classic, as missões 6 ou mais níveis abaixo de você pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram inteiro. Sua primeira entrega mostra qual vale: se pagar um quinto, pule esses polos. Pule este passo para pular o polo.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Bandidos e Capatazes Pata Molhada (nível 16-18) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Mercenários da Camarilha na Bastilha de Stromgarde (nível 31-32) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["These quests are level 52 to 59, so they pay in full at 60, or nearly: about 600 {faction:47} reputation (in Classic about 450 at 60, as the {zone:1428} ones are level 52 to 54). {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "Essas missões são de nível 52 a 59, então pagam inteiro no 60, ou quase: cerca de 600 de reputação de {faction:47} (no Classic, cerca de 450 no 60, já que as de {zone:1428} são de nível 52 a 54). {npc:8879} fica ao lado do Rei Magni em {object:171709}; ele manda você às ruínas de Thaurissan em {zone:1428}.",
	-- ["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723} recebe tecido para {faction:47} em {faction:47}. As primeiras doações de Lã, Seda, Magitrama e {item:14047} (60 tecidos cada) são feitas uma vez só e dão mais reputação por tecido; depois delas, {quest:7806} se repete até Exaltado. Exaltado com a cidade de outra raça permite comprar as montarias dessa raça. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:14723}: {item:14047} delivered"] = "{npc:14723}: {item:14047} entregue",
	-- ["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806} pede 20 {item:14047} por entrega e se repete quantas vezes quiser. Traga {item:14047} em múltiplos de 20 e entregue tudo de uma vez, uma entrega após a outra. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
}
