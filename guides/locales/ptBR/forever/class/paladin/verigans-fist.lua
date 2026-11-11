-- Portuguese (Brazil) (ptBR): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5502} Sense Undead
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield and {spell:5502} on the way."] = "A maça de duas mãos rara do paladino da Aliança para os 20 e poucos, com um escudo e {spell:5502} no caminho.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["At 20 {npc:6179}, upstairs in the {object:32386} in the {object:32362}, gives you the {item:6776}. Right-click it: it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the {area:2257} from {zone:1455} to {zone:1453}."] = "No nível 20, {npc:6179}, no andar de cima do {object:32386}, na {object:32362}, entrega o {item:6776}. Clique nele com o botão direito: ele manda você a {npc:6171}, na Catedral da Luz de {zone:1453}. Pegue o {area:2257} de {zone:1455} até {zone:1453}.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Humans get the {item:6776} from him. Right-click the book to start its quest and hand it straight back to him."] = "{npc:6171} fica na Catedral da Luz. Humanos ganham o {item:6776} dele. Clique com o botão direito no livro para começar a missão e entregue de volta a ele na hora.",
	-- {item:6776} Tome of Valor
	["Right-click the {item:6776}"] = "Clique com o botão direito no {item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall · {area:20} Moonbrook · {area:1581} Deadmines
	-- plural, as words: Defias Raiders = {npc:6180} Defias Raider
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}, south of {area:20}: take the path that runs south beside the {area:1581}' back exit. When you take her quest, she walks from her orchard to the house and three waves of Defias Raiders (level 17-18) attack: three, then four, then five. Fight close to her so they do not swarm her, and heal her when she drops. You get time to eat and drink between waves, and she heals to full. If you or {npc:6182} die, the quest fails: abandon it and take it again from her (she is back five minutes after dying). Players find it hard alone before about 24."] = "A casa de fazenda de {npc:6182} fica na costa sudoeste de {zone:1436}, ao sul de {area:20}: pegue a trilha que desce para o sul ao lado da saída dos fundos de {area:1581}. Quando você pega a missão, ela anda do pomar até a casa e três ondas de Saqueadores Défias (nível 17-18) atacam: três, depois quatro, depois cinco. Lute colado nela para eles não a cercarem, e cure quando ela cair de vida. Dá tempo de comer e beber entre as ondas, e ela recupera a vida toda. Se você ou {npc:6182} morrerem, a missão falha: abandone e pegue de novo com ela (ela volta cinco minutos depois de morrer). A galera acha difícil sozinho antes do nível 24, mais ou menos.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}: three waves"] = "Proteja {npc:6182}: três ondas",

	-- Step 4: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {item:9607} Bastion of Stormwind · {spell:5502} Sense Undead
	["Back to the Cathedral of Light: {npc:6171} gives you the {item:9607} shield and teaches you {spell:5502}."] = "De volta à Catedral da Luz: {npc:6171} entrega o escudo {item:9607} e ensina {spell:5502}.",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} works outside the gates of {zone:1455}, not inside. He gives you {item:6996}: four parts, in any order. Keep the notes."] = "{npc:6181} trabalha do lado de fora dos portões de {zone:1455}, não dentro. Ele entrega as {item:6996}: quatro partes, em qualquer ordem. Guarde as anotações.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is downstairs in the house of {area:144} that has a tailoring merchant outside. His quest only opens once you hold Jordan's."] = "{npc:6241} fica no andar de baixo da casa de {area:144} que tem um mercador de alfaiataria na frente. A missão dele só abre depois que você pegar a do Jardel.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The crate of ore sits outdoors in the middle of the Mo'grosh ogre camp in north-east {zone:1432}, beside a big tree and a broken wagon, between the caves. The camp holds about fifteen Mo'grosh ogres, elite (level 18-19), who knock you down and come back after five minutes: grouping up is encouraged; at 20-22 it needs a group of about three. The crate is back two seconds after each loot, so every paladin in the group gets one."] = "O caixote de minério fica ao ar livre no meio do acampamento dos ogros Mo'grosh, no nordeste de {zone:1432}, ao lado de uma árvore grande e de uma carroça quebrada, entre as cavernas. O acampamento tem uns quinze ogros Mo'grosh elite (nível 18-19), que derrubam você e voltam depois de cinco minutos: vale ir em grupo; no nível 20-22, precisa de um grupo de uns três. O caixote volta dois segundos depois de cada saque, então todo paladino do grupo pega o seu.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "Caixote de {object:92420}",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "De volta a {npc:6241}",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}, the part Jordan wants."] = "{npc:6241} transforma o minério no {item:6993}, a parte que o Jardel quer.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is at the bottom of the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in the mast room with Sneed drop the lumber every time."] = "{area:1581} é masmorra de grupo de cinco embaixo de {area:20}; o portal da instância fica no fundo da mina de {area:20}. Os Goblins Entalhadores (elite, nível 18-19) na sala do mastro, com o Sneed, sempre deixam cair a madeira.",
	-- {area:1581} Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, na mina de {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Goblins Entalhadores, lá dentro",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest · {zone:1437} Wetlands · {area:287} Hillsbrad
	["{area:236} is a dungeon for a group of five in the low to mid 20s, in southern {zone:1421}, Horde land: a long trip for the Alliance, through the {zone:1437}, Arathi and {area:287}. The hammer lies on a crate across from the horses in the stables, early in the dungeon, at the far end of the courtyard before the ramp up; it is back five minutes after someone takes it."] = "{area:236} é masmorra para grupo de cinco por volta do nível 20 a 25, no sul de {zone:1421}, terra da Horda: uma viagem longa para a Aliança, por {zone:1437}, Arathi e {area:287}. O martelo está num caixote em frente aos cavalos, nos estábulos, no começo da masmorra, no fundo do pátio antes da rampa de subida; ele volta cinco minutos depois que alguém pega.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, lá dentro",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}. Take his quest before you hunt naga: the Kor Gem never drops without it."] = "{npc:3649} fica em {area:442}. Pegue a missão dele antes de caçar nagas: sem ela, a Gema Kor nunca cai.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "A {item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The Blackfathom naga in the flooded passages around the {area:2797} entrance, on {zone:1440}'s north-west coast, drop the {item:6995}: Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24), one in two. You do not need to enter the instance. All are elite: grouping up is encouraged; players solo them one at a time, with difficulty. They heal themselves, run for help at low health, satyrs stand near some, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Os nagas das Profundezas Negras nas passagens alagadas em volta da entrada de {area:2797}, na costa noroeste de {zone:1440}, deixam cair a {item:6995}: Sacerdotisas da Maré (nível 20-21), Oráculos (21-22) e Bruxas do Mar (23-24), uma vez em duas. Não precisa entrar na instância. Todos são elite: vale ir em grupo; a galera encara um de cada vez sozinha, com dificuldade. Eles se curam, fogem atrás de ajuda com pouca vida, há sátiros perto de alguns, e as Bruxas do Mar soltam {spell:122} de perto. Há quem relate que não cai nada em grupo de raide.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "A {item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "De volta a {npc:3649} em {area:442}: ele purifica a gema.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}. Accept his last quest and wait by him while he forges the mace at his anvil."] = "Leve as quatro partes a {npc:6181}, do lado de fora de {zone:1455}. Aceite a última missão dele e espere ao lado enquanto ele forja a maça na bigorna.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "No nível 20, {npc:6179} na {object:32362} lhe dá o {item:6776}; ele manda você a {npc:6171} na Catedral da Luz de {zone:1453}. Pegue o metrô de {zone:1455} até {zone:1453}.",
	-- ["Bring the four parts to {npc:6181} outside {zone:1455}."] = "Leve as quatro partes a {npc:6181}, do lado de fora de {zone:1455}.",
	-- ["Protect {npc:6182}"] = "Proteja {npc:6182}",
	-- ["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "A maça de duas mãos rara do paladino da Aliança para os 20, com um escudo no caminho.",
	-- ["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "Os nagas das Profundezas Negras junto à entrada das {area:2797}, na costa noroeste de {zone:1440}, deixam cair a {item:6995}. Eles são elite: é recomendado formar grupo.",
	-- ["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "O caixote de minério fica junto às árvores no meio do acampamento dos ogros Mo'grosh, no nordeste de {zone:1432}. Os ogros Mo'grosh são elite: é recomendado formar grupo.",
	-- ["from the {item:6776}"] = "do {item:6776}",
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581} é para um grupo de cinco, embaixo de {area:20}; o portal da instância fica dentro da mina de {area:20}. Os Goblins Entalhadores na sala do mastro, com Sneed, deixam cair a madeira.",
	-- ["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236} é uma masmorra de nível 20-30 no sul de {zone:1421}. O martelo está numa caixa dentro dos estábulos, no fundo do pátio, antes da rampa.",
	-- ["{npc:3649} is in {area:442}."] = "{npc:3649} está em {area:442}.",
	-- ["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171} fica na Catedral da Luz. Clique com o botão direito no {item:6776} para iniciar a missão dele.",
	-- ["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181} fica do lado de fora dos portões de {zone:1455}. Ele lhe dá as {item:6996}, que listam as quatro partes.",
	-- ["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "A casa da fazenda de {npc:6182} fica na costa sudoeste de {zone:1436}. Ondas de Défias a atacam durante a missão dela: mantenha-a viva e cure-a se precisar.",
	-- ["{npc:6241} is in {area:144}."] = "{npc:6241} está em {area:144}.",
	-- ["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241} transforma o minério no {item:6993}.",
}
