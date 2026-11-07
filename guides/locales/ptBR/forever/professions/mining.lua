-- Portuguese (Brazil) (ptBR): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "Aprenda {skill:186}",
	-- {skill:186} Mining · {item:2901} Mining Pick · {spell:2580} Find Minerals · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:11584} Cactus Apple Surprise · {item:247840} Mining for Dummies · {item:277115} Apprentice's Mining Pack · {spell:1230161} Lodestone
	-- plural, as words: Poor Copper Veins = {object:562111} Poor Copper Vein
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on {spell:2580} (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "Qualquer instrutor de {skill:186} da sua facção ensina {skill:186} (Aprendiz) em qualquer nível (10c), e o Instrutor Júnior de Mineração de cada área inicial também; a seta indica o mais próximo. Compre uma {item:2901} em um vendedor de bens de comércio ou geral: mantenha na bolsa, pois sem ela você não consegue minerar. Ative {spell:2580} (grimório, aba Geral) para os veios aparecerem no minimapa. As áreas iniciais do Forever também têm Veios de Cobre Pobre ({item:2770} e {item:2835}, a partir da perícia 1). A missão da primeira hora de cada área inicial (Fome de conhecimento, Correio de Vale Cristálgida, A protetora dos bosques, {item:11584} de Galgar, Uma humilde tarefa, O último desejo de Marla) dá {item:247840} como recompensa: ao ler, você ganha 2 de perícia, até 15. Vendedores de bens de comércio e os instrutores júnior vendem a {item:277115}, uma bolsa de quatro espaços para minério e pedra (25c). Se você se sentou na fogueira da sua área inicial para Vida ao ar livre, o guia de acampamento de lá também oferece Introdução ao acampamento: {skill:186}: entregue-a ao instrutor de mineração indicado quando chegar à perícia 20, para receber a receita {spell:1230161}.",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "Cobre: {zone:1429} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "Minere todos os nós de Cobre (1, laranja) e Cobre Pobre (1, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 50. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 1-10. Espere cerca de 60 nós para esses 49 pontos.",
	["Copper"] = "Cobre",
	["Poor Copper"] = "Cobre Pobre",
	["Copper, Poor Copper"] = "Cobre, Cobre Pobre",

	-- Step 3: Copper & Poor Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (1-50)"] = "Cobre e Cobre Pobre: {zone:1426} (1-50)",

	-- Step 4: Copper: Darkshore (1-50)
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (1-50)"] = "Cobre: {zone:1439} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 60 nodes for these 49 points."] = "Minere todos os nós de Cobre (1, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 50. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 10-20. Espere cerca de 60 nós para esses 49 pontos.",

	-- Step 5: Copper: Zephras Isle (1-50)
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (1-50)"] = "Cobre: {zone:2521} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 60 nodes for these 49 points."] = "Minere todos os nós de Cobre (1, laranja) e Cobre Pobre (1, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 50. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 1-15. Espere cerca de 60 nós para esses 49 pontos.",

	-- Step 6: Copper & Poor Copper: Durotar (1-50)
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (1-50)"] = "Cobre e Cobre Pobre: {zone:1411} (1-50)",

	-- Step 7: Copper: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (1-50)"] = "Cobre: {zone:1412} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "Minere todos os nós de Cobre (1, laranja) e Cobre Pobre (1, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 50. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 1-10. Espere cerca de 60 nós para esses 49 pontos.",

	-- Step 8: Copper & Poor Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (1-50)"] = "Cobre e Cobre Pobre: {zone:1420} (1-50)",
	["Poor Copper, Copper"] = "Cobre Pobre, Cobre",

	-- Step 9: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "{skill:186} (Profissional)",
	-- {skill:186} Mining · {spell:1230161} Lodestone · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "{skill:186} (Profissional) eleva o limite para 150; exige perícia 50 e nenhum nível de personagem, e custa 5s: aprenda assim que chegar a 50. A seta indica o instrutor de {skill:186} mais próximo da sua facção. {spell:1230161}, o item de acampamento do Forever para {skill:186}, é ensinado a partir da perícia 20 (1s, ou de graça com Introdução ao acampamento: {skill:186}): com {item:2835} e {item:2840}, um de cada, ele dá pontos até 25; colocado ao lado de uma fogueira, dá a todos no acampamento um bônus por uma hora.",

	-- Step 10: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "Cobre: {zone:1429} (50-65) cont.",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "Minere todos os nós de Cobre (1, amarelo) e Cobre Pobre (1, amarelo) que encontrar e percorra os pontos de passagem até {skill:186} 65. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 1-10. Espere cerca de 80 nós para esses 15 pontos.",

	-- Step 11: Copper & Poor Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "Cobre e Cobre Pobre: {zone:1426} (50-65), continuação",

	-- Step 12: Copper: Darkshore (50-65) cont.
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (50-65) cont."] = "Cobre: {zone:1439} (50-65) cont.",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 80 nodes for these 15 points."] = "Minere todos os nós de Cobre (1, amarelo) que encontrar e percorra os pontos de passagem até {skill:186} 65. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 10-20. Espere cerca de 80 nós para esses 15 pontos.",

	-- Step 13: Copper: Zephras Isle (50-65) cont.
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (50-65) cont."] = "Cobre: {zone:2521} (50-65), continuação",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 80 nodes for these 15 points."] = "Minere todos os nós de Cobre (1, amarelo) que encontrar e percorra os pontos de passagem até {skill:186} 65. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 1-15. Espere cerca de 80 nós para esses 15 pontos.",

	-- Step 14: Copper & Poor Copper: Durotar (50-65) cont.
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (50-65) cont."] = "Cobre e Cobre Pobre: {zone:1411} (50-65), continuação",

	-- Step 15: Copper: Mulgore (50-65) cont.
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (50-65) cont."] = "Cobre: {zone:1412} (50-65) cont.",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "Minere todos os nós de Cobre (1, amarelo) que encontrar e percorra os pontos de passagem até {skill:186} 65. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70) também dá pontos. Nível da zona 1-10. Espere cerca de 80 nós para esses 15 pontos.",

	-- Step 16: Copper & Poor Copper: Tirisfal Glades (50-65) cont.
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (50-65) cont."] = "Cobre e Cobre Pobre: {zone:1420} (50-65), continuação",

	-- Step 17: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["At 65 a {skill:186} trainer teaches {spell:2659} (2s; grey at 115) and {spell:3304} (50c; grey at 75): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "Aos 65, um instrutor de {skill:186} ensina {spell:2659} (2s; cinza em 115) e {spell:3304} (50c; cinza em 75): fundir em uma forja também aumenta {skill:186}, então funda o que minerar.",

	-- Step 18: Incendicite & Tin: Wetlands (65-125)
	-- {zone:1437} Wetlands
	["Incendicite & Tin: {zone:1437} (65-125)"] = "Incendicita e Estanho: {zone:1437} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Incendicite (65, orange), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minere todos os nós de Cobre (1, verde), Incendicita (65, laranja), Estanho (65, laranja) e Prata (a partir de 75, raro) que encontrar e percorra os pontos de passagem até {skill:186} 125. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70), {spell:3304} (cinza em 75) e {spell:2659} (cinza em 115) também dão pontos. {spell:2659} usa {item:2840} e {item:3576}, um de cada: guarde barras das fundições anteriores. Nível da zona 20-30. Espere cerca de 130 nós para esses 60 pontos. {spell:2658} (2s; laranja até 100, cinza em 125) é ensinado a partir de 75: aprenda se passar por um instrutor de {skill:186}; não vale uma viagem só para isso.",
	["Tin, Copper"] = "Estanho, Cobre",
	["Incendicite, Tin"] = "Incendicita, Estanho",

	-- Step 19: Tin: Ashenvale (65-125)
	-- {zone:1440} Ashenvale
	["Tin: {zone:1440} (65-125)"] = "Estanho: {zone:1440} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minere todos os nós de Cobre (1, verde), Estanho (65, laranja) e Prata (a partir de 75, raro) que encontrar e percorra os pontos de passagem até {skill:186} 125. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70), {spell:3304} (cinza em 75) e {spell:2659} (cinza em 115) também dão pontos. {spell:2659} usa {item:2840} e {item:3576}, um de cada: guarde barras das fundições anteriores. Nível da zona 18-30. Espere cerca de 130 nós para esses 60 pontos. {spell:2658} (2s; laranja até 100, cinza em 125) é ensinado a partir de 75: aprenda se passar por um instrutor de {skill:186}; não vale uma viagem só para isso.",
	["Tin, Silver"] = "Estanho, Prata",
	["Tin"] = "Estanho",

	-- Step 20: Copper & Tin: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Copper & Tin: {zone:1413} (65-125)"] = "Cobre e Estanho: {zone:1413} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minere todos os nós de Cobre (1, verde), Estanho (65, laranja) e Prata (a partir de 75, raro) que encontrar e percorra os pontos de passagem até {skill:186} 125. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70), {spell:3304} (cinza em 75) e {spell:2659} (cinza em 115) também dão pontos. {spell:2659} usa {item:2840} e {item:3576}, um de cada: guarde barras das fundições anteriores. Nível da zona 10-25. Espere cerca de 280 nós para esses 60 pontos. {spell:2658} (2s; laranja até 100, cinza em 125) é ensinado a partir de 75: aprenda se passar por um instrutor de {skill:186}; não vale uma viagem só para isso.",
	["Copper, Tin"] = "Cobre, Estanho",

	-- Step 21: Tin: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin: {zone:1424} (65-125)"] = "Estanho: {zone:1424} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minere todos os nós de Cobre (1, verde), Estanho (65, laranja) e Prata (a partir de 75, raro) que encontrar e percorra os pontos de passagem até {skill:186} 125. Funda em uma forja quando as bolsas encherem: {spell:2657} (laranja até 25, cinza em 70), {spell:3304} (cinza em 75) e {spell:2659} (cinza em 115) também dão pontos. {spell:2659} usa {item:2840} e {item:3576}, um de cada: guarde barras das fundições anteriores. Nível da zona 20-30. Espere cerca de 140 nós para esses 60 pontos. {spell:2658} (2s; laranja até 100, cinza em 125) é ensinado a partir de 75: aprenda se passar por um instrutor de {skill:186}; não vale uma viagem só para isso.",

	-- Step 22: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "{skill:186} (Perito)",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "{skill:186} (Perito) eleva o limite para 225; exige perícia 125 e nenhum nível de personagem, e custa 50s: aprenda assim que chegar a 125. A seta indica o instrutor de {skill:186} mais próximo da sua facção. Aprenda {spell:3307} (5s; laranja até 130, cinza em 140) na mesma visita: fundir em uma forja também aumenta {skill:186}, então funda o que minerar.",

	-- Step 23: Iron: Arathi Highlands (125-155)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (125-155)"] = "Ferro: {zone:1417} (125-155)",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "Minere todos os nós de Estanho (65, verde), Pedra-sangrenta Inferior (75, verde), Prata (75, verde, raro) e Ferro (125, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 155. Funda em uma forja quando as bolsas encherem: {spell:3307} (laranja até 130, cinza em 140) também dá pontos. Nível da zona 30-40. Espere cerca de 50 nós para esses 30 pontos.",
	["Iron, Tin"] = "Ferro, Estanho",
	["Lesser Bloodstone, Silver"] = "Pedra-sangrenta Inferior, Prata",

	-- Step 24: Iron: Arathi Highlands (155-175)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (155-175)"] = "Ferro: {zone:1417} (155-175)",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, yellow), Gold (155, orange, rare) node you pass and circle the waypoints until {skill:186} 175. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 30-40. Expect about 40 nodes for these 20 points. {spell:3308} (25s; orange to 170, grey at 185) is taught from 155: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minere todos os nós de Estanho (65, verde), Pedra-sangrenta Inferior (75, verde), Prata (75, verde, raro), Ferro (125, amarelo) e Ouro (155, laranja, raro) que encontrar e percorra os pontos de passagem até {skill:186} 175. Funda em uma forja quando as bolsas encherem: {spell:3308} (laranja até 170, cinza em 185) também dá pontos. Nível da zona 30-40. Espere cerca de 40 nós para esses 20 pontos. {spell:3308} (25s; laranja até 170, cinza em 185) é ensinado a partir de 155: aprenda se passar por um instrutor de {skill:186}; não vale uma viagem só para isso.",
	["Lesser Bloodstone, Gold"] = "Pedra-sangrenta Inferior, Ouro",

	-- Step 25: Mithril: Badlands (175-200)
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (175-200)"] = "Mithril: {zone:1418} (175-200)",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 35-45. Expect about 40 nodes for these 25 points."] = "Minere todos os nós de Ferro (125, verde), Ouro (155, laranja) e Mithril (175, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 200. Funda em uma forja quando as bolsas encherem: {spell:3308} (laranja até 170, cinza em 185) também dá pontos. Nível da zona 35-45. Espere cerca de 40 nós para esses 25 pontos.",
	["Iron, Mithril"] = "Ferro, Mithril",

	-- Step 26: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "{skill:186} (Artífice)",
	-- {skill:186} Mining
	["Artisan {skill:186} raises the cap to 300; it needs skill 200 and no character level, and costs 5g: train it as soon as you reach 200. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} (Artífice) eleva o limite para 300; exige perícia 200 e nenhum nível de personagem, e custa 5g: aprenda assim que chegar a 200. A seta indica o instrutor de {skill:186} mais próximo da sua facção.",

	-- Step 27: Mithril: Badlands (200-230) cont.
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (200-230) cont."] = "Mithril: {zone:1418} (200-230), continuação",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 35-45. Expect about 90 nodes for these 30 points."] = "Minere todos os nós de Ferro (125, verde), Ouro (155, amarelo) e Mithril (175, amarelo) que encontrar e percorra os pontos de passagem até {skill:186} 230. A fundição não dá mais pontos daqui em diante (as fundições mais altas ficam cinza depois de aprendidas): funda para fabricar ou vender, ou venda o minério. Nível da zona 35-45. Espere cerca de 90 nós para esses 30 pontos.",

	-- Step 28: Mithril & Dark Iron: Searing Gorge (230-245)
	-- {object:147516} Dark Iron (no name in this language: may be words) · {zone:1427} Searing Gorge
	["Mithril & {object:147516}: {zone:1427} (230-245)"] = "Mithril e Ferro Negro: {zone:1427} (230-245)",
	-- {object:147516} Dark Iron (no name in this language: may be words) · {skill:186} Mining · {item:11099} Dark Iron Ore · {object:174824} Black Forge (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. {item:11099} smelts only at the {object:174824} in {area:1584} (8 ore a bar). Zone level 43-50. Expect about 40 nodes for these 15 points."] = "Minere todos os nós de Ouro (155, verde), Mithril (175, verde), Ferro Negro (230, laranja) e Veraprata (230, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 245. A fundição não dá mais pontos daqui em diante (as fundições mais altas ficam cinza depois de aprendidas): funda para fabricar ou vender, ou venda o minério. {item:11099} só funde no {object:174824} em {area:1584} (8 minérios por barra). Nível da zona 43-50. Espere cerca de 40 nós para esses 15 pontos.",
	-- {object:147516} Dark Iron (no name in this language: may be words)
	["Mithril, {object:147516}"] = "Mithril, Ferro Negro",

	-- Step 29: Small Thorium: Felwood (245-275)
	-- {zone:1448} Felwood
	["Small Thorium: {zone:1448} (245-275)"] = "Tório Escasso: {zone:1448} (245-275)",
	-- {skill:186} Mining · {npc:9528} Arathandris Silversky · {npc:9529} Maybess Riverbreeze
	["Mine every Gold (155, green, rare), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Quests here that need {skill:186}: Salve via {skill:186} (level 55, {npc:9528}; Alliance), Salve via {skill:186} (level 55, {npc:9529}; Horde). Zone level 48-55. Expect about 50 nodes for these 30 points."] = "Minere todos os nós de Ouro (155, verde, raro), Mithril (175, verde), Veraprata (230, laranja) e Tório Escasso (245, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 275. A fundição não dá mais pontos daqui em diante (as fundições mais altas ficam cinza depois de aprendidas): funda para fabricar ou vender, ou venda o minério. Missões daqui que exigem {skill:186}: Bálsamo via {skill:186} (nível 55, {npc:9528}; Aliança) e Bálsamo via {skill:186} (nível 55, {npc:9529}; Horda). Nível da zona 48-55. Espere cerca de 50 nós para esses 30 pontos.",
	["Mithril, Small Thorium"] = "Mithril, Tório Escasso",
	["Small Thorium, Truesilver"] = "Tório Escasso, Veraprata",

	-- Step 30: Small Thorium & Rich Thorium: Winterspring (275-300)
	-- {zone:1452} Winterspring
	["Small Thorium & Rich Thorium: {zone:1452} (275-300)"] = "Tório Escasso e Tório Rico: {zone:1452} (275-300)",
	-- {skill:186} Mining
	["Mine every Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 55-60. Expect about 40 nodes for these 25 points."] = "Minere todos os nós de Veraprata (230, amarelo), Tório Escasso (245, amarelo) e Tório Rico (275, laranja) que encontrar e percorra os pontos de passagem até {skill:186} 300. A fundição não dá mais pontos daqui em diante (as fundições mais altas ficam cinza depois de aprendidas): funda para fabricar ou vender, ou venda o minério. Nível da zona 55-60. Espere cerca de 40 nós para esses 25 pontos.",
	["Rich Thorium, Small Thorium"] = "Tório Rico, Tório Escasso",
	["Rich Thorium, Truesilver"] = "Tório Rico, Veraprata",
	["Rich Thorium"] = "Tório Rico",
	["Small Thorium, Rich Thorium"] = "Tório Escasso, Tório Rico",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "Qualquer instrutor de {skill:186} da sua facção ensina {skill:186} Aprendiz (nível de personagem 5); a seta escolhe o mais próximo. Compre uma {item:2901} de um mercador de mercadorias ou de artigos gerais: mantenha-a nas bolsas, sem ela você não pode minerar.",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} Artífice eleva o limite para 300; requer perícia 200 e nível de personagem 35. A seta escolhe o instrutor de {skill:186} mais próximo da sua facção.",
	-- ["Copper, Silver"] = "Cobre, Prata",
	-- ["Copper: {zone:1411} (1-50)"] = "Cobre: {zone:1411} (1-50)",
	-- ["Copper: {zone:1411} (50-65) cont."] = "Cobre: {zone:1411} (50-65) cont.",
	-- ["Copper: {zone:1420} (1-50)"] = "Cobre: {zone:1420} (1-50)",
	-- ["Copper: {zone:1420} (50-65) cont."] = "Cobre: {zone:1420} (50-65) cont.",
	-- ["Copper: {zone:1426} (1-50)"] = "Cobre: {zone:1426} (1-50)",
	-- ["Copper: {zone:1426} (50-65) cont."] = "Cobre: {zone:1426} (50-65) cont.",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} (Perito) eleva o limite para 225; requer perícia 125 e nível de personagem 20. A seta escolhe o instrutor de {skill:186} mais próximo da sua facção.",
	-- ["Gold"] = "Ouro",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "Ouro e Mithril: {zone:1435} (175-200)",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "Ouro e Mithril: {zone:1435} (200-230) cont.",
	-- ["Gold, Iron"] = "Ouro, Ferro",
	-- ["Gold, Mithril"] = "Ouro, Mithril",
	-- ["Gold: {zone:1435} (155-175)"] = "Ouro: {zone:1435} (155-175)",
	-- ["Iron, Silver"] = "Ferro, Prata",
	-- ["Iron: {zone:1416} (125-155)"] = "Ferro: {zone:1416} (125-155)",
	-- ["Iron: {zone:1431} (125-155)"] = "Ferro: {zone:1431} (125-155)",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} Profissional eleva o limite para 150; requer perícia 50 e nível de personagem 10. A seta escolhe o instrutor de {skill:186} mais próximo da sua facção.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Minere cada jazida de Cobre (1, verde), Estanho (65, laranja), Prata (a partir de 75) pelo caminho e percorra os pontos de rota até {skill:186} 125. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 10-20.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "Minere cada jazida de Cobre (1, verde), Estanho (65, laranja), Prata (a partir de 75) pelo caminho e percorra os pontos de rota até {skill:186} 125. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 10-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "Minere cada jazida de Cobre (1, verde), Estanho (65, laranja), Prata (a partir de 75) pelo caminho e percorra os pontos de rota até {skill:186} 125. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 15-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "Minere cada jazida de Cobre (1, verde), Estanho (65, laranja), Prata (a partir de 75) pelo caminho e percorra os pontos de rota até {skill:186} 125. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 20-30.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Minere cada jazida de Cobre (1, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 50. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 1-10.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Minere cada jazida de Cobre (1, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 50. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 10-20.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Minere cada jazida de Cobre (1, amarelo) pelo caminho e percorra os pontos de rota até {skill:186} 65. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 1-10.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Minere cada jazida de Cobre (1, amarelo) pelo caminho e percorra os pontos de rota até {skill:186} 65. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 10-20.",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "Minere cada jazida de Ouro (155, verde), Mithril (175, verde), Veraprata (230, laranja), Tório Escasso (245, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 275. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 45-55.",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "Minere cada jazida de Ouro (155, verde), Mithril (175, verde), {object:147516} (230, laranja), Veraprata (230, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 245. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 43-50.",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Minere cada jazida de Ferro (125, verde), Ouro (155, laranja), Mithril (175, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 200. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 35-45.",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Minere cada jazida de Ferro (125, verde), Ouro (155, amarelo), Mithril (175, amarelo) pelo caminho e percorra os pontos de rota até {skill:186} 230. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 35-45.",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Minere cada jazida de Prata (75, verde), Ferro (125, amarelo), Ouro (155, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 175. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 35-45.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "Minere cada jazida de Estanho (65, verde), Prata (75, verde), Ferro (125, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 155. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 18-30.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "Minere cada jazida de Estanho (65, verde), Prata (75, verde), Ferro (125, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 155. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 30-40.",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "Minere cada jazida de {object:147516} (230, amarelo), Veraprata (230, amarelo), Tório Escasso (245, amarelo), Tório Abundante (275, laranja) pelo caminho e percorra os pontos de rota até {skill:186} 300. Funda o minério numa forja quando as bolsas encherem: fundir também eleva {skill:186}. Zona de nível 50-58.",
	-- ["Rich Thorium: {zone:1428} (275-300)"] = "Tório Abundante: {zone:1428} (275-300)",
	-- ["Silver, Tin"] = "Prata, Estanho",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "Estanho e Prata: {zone:1413} (65-125)",
	-- ["Tin & Silver: {zone:1424} (65-125)"] = "Estanho e Prata: {zone:1424} (65-125)",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "Estanho e Prata: {zone:1433} (65-125)",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "Estanho e Prata: {zone:1439} (65-125)",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "Veraprata e Tório Escasso: {zone:1419} (245-275)",
	-- ["Truesilver, {object:147516}"] = "Veraprata, {object:147516}",
	-- ["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516} e Veraprata: {zone:1427} (230-245)",
	-- ["{object:147516}, Gold"] = "{object:147516}, Ouro",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}, Tório Abundante",
}
