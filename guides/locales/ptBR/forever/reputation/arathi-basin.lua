-- Portuguese (Brazil) (ptBR): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Reputação: Bacia Arathi",
	["Every 200 resources your team gathers pays it; Exalted gives a Legacy Point, epic shoulders and the tabard."] = "A cada 200 recursos que seu time reúne, ele ganha reputação; Exaltado dá um Ponto de Legado, ombreiras épicas e o tabardo.",
	["Master of Arathi Basin: a Legacy Point at Exalted"] = "Mestre da Bacia Arathi: um Ponto de Legado em Exaltado",

	-- Step 1: Refuge Pointe
	-- {zone:1461} Arathi Basin
	["{zone:1461} is a 15 against 15 battle over five bases, from level 20: hold bases to gather resources, and the first team to 2000 wins. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every 200 resources your team gathers pay everyone 10 reputation, so a win pays 100 and a close loss nearly as much; a game also pays 3 Arathi Basin Marks of Honor for a win, 1 for a loss. The three quests here pay 500 reputation together (200, 200 and 100), once. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1461} é uma batalha de 15 contra 15 por cinco bases, a partir do nível 20: mantenha bases para reunir recursos, e o primeiro time a chegar a 2.000 vence. Entre na fila em qualquer mestre de batalha nas capitais ou pela tela de campo de batalha. No Classic, a cada 200 recursos que seu time reúne todos ganham 10 de reputação, então uma vitória paga 100 e uma derrota apertada quase o mesmo; uma partida também paga 3 Marcas de Honra da Bacia Arathi na vitória e 1 na derrota. As três missões daqui pagam 500 de reputação juntas (200, 200 e 100), uma única vez. A vantagem do Legado Diplomata do Forever soma até 10% a todos os números deste guia.",
	-- {npc:14983} Field Marshal Oslight
	["{npc:14983}: assault four bases, 200"] = "{npc:14983}: assalte quatro bases, 200",
	-- {npc:14984} Sergeant Maclear
	["{npc:14984}: one mark, 200"] = "{npc:14984}: uma marca, 200",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: three marks, 100"] = "{npc:15351}: três marcas, 100",

	-- Step 2: Arathi Basin
	-- {npc:14984} Sergeant Maclear · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:14984}, three for the Brigadier General. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Assaltar uma base é clicar no estandarte dela até ele virar: você não precisa mantê-la. São quatro marcas no total: uma para {npc:14984}, três para o General de Brigada. O equipamento de JxJ do Forever também custa Marcas de Honra, além de honra: decida o que você quer antes de entregá-las. Você carrega no máximo 30 marcas de {zone:1461}: entregue ou gaste antes de chegar a isso.",
	["Assault the Mine banner"] = "Assalte o estandarte da Mina",
	-- {area:3422} Lumber Mill
	["Assault the {area:3422} banner"] = "Assalte o estandarte de {area:3422}",
	["Assault the Blacksmith banner"] = "Assalte o estandarte da Ferraria",
	["Assault the Farm banner"] = "Assalte o estandarte da Fazenda",
	-- {item:20559} Arathi Basin Mark of Honor
	["one {item:20559}"] = "uma {item:20559}",
	["three more marks"] = "mais três marcas",

	-- Step 3: Back to Refuge Pointe
	-- {area:320} Refuge Pointe
	["Back to {area:320}"] = "De volta a {area:320}",
	["hand in the three marks first"] = "entregue primeiro as três marcas",

	-- Step 4: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "A Liga de Arathor até Respeitado",
	-- {quest:8374} Claiming Arathi Basin · {area:320} Refuge Pointe
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:320} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "De Neutro a Amigável são 3.000 de reputação. No Classic, uma vitória pagava 100 e suas 3 marcas rendem mais 50 com o General de Brigada ({quest:8374}, várias vezes): cerca de 150 por vitória, umas 20 vitórias. O Forever não publicou suas taxas de campo de batalha, então conte as partidas só como referência. Abaixo do nível 50, as missões em {area:320} vêm numa versão para a sua faixa (a partir do nível 20): 200 por assaltar as bases, 200 por uma marca e depois 100 e 50 a cada 3 marcas com o General de Brigada.",
	-- {npc:15351} Alliance Brigadier General · {quest:8374} Claiming Arathi Basin
	["{npc:15351}: {quest:8374} again, 50 reputation for 3 marks"] = "{npc:15351}: {quest:8374} de novo, 50 de reputação por 3 marcas",

	-- Step 5: Control Four Bases
	-- {npc:14983} Field Marshal Oslight · {quest:8115} Control Five Bases
	["At level 60 and Friendly, {npc:14983} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8115} for Exalted."] = "No nível 60 e Amigável, {npc:14983} pede que seu time mantenha quatro bases ao mesmo tempo: 200 de reputação, uma única vez. Isso libera {quest:8115} para Exaltado.",
	["four bases held at once"] = "quatro bases mantidas ao mesmo tempo",

	-- Step 6: League of Arathor to Honored
	["League of Arathor to Honored"] = "A Liga de Arathor até Honrado",
	-- {npc:15127} Samuel Hawke · {npc:14983} Field Marshal Oslight · {item:20071} Talisman of Arathor · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15127} beside {npc:14983}: the {item:20071} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Arathor care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "De Amigável a Honrado são 6.000 de reputação, cerca de 40 vitórias na taxa do Classic. Amigável libera as primeiras recompensas com {npc:15127}, ao lado de {npc:14983}: o berloque {item:20071} para os níveis 28, 38, 48 e 58 (72s a 4g12s), e comida e bandagens que funcionam em {zone:1461} (10s a 20s). Em Amigável ele também dá um pacote de suprimentos dos Arathor (escolha o do seu nível): 10 de reputação e uma bolsa de comida e bandagens de campo de batalha.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Friendly rewards"] = "{npc:15127}: recompensas de Amigável",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}: 50 de reputação por 3 marcas",

	-- Step 7: League of Arathor to Revered
	["League of Arathor to Revered"] = "A Liga de Arathor até Reverenciado",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Highlander's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (72s to 8g84s)."] = "De Honrado a Reverenciado são 12.000 de reputação, cerca de 80 vitórias. Honrado libera os cinturões do Highlander em placa, lamelar, encadeado, malha, couro, couro de lagarto e tecido para os níveis 28 a 58 (72s a 8g84s).",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Honored rewards"] = "{npc:15127}: recompensas de Honrado",

	-- Step 8: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "A Liga de Arathor até Exaltado",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Highlander's boots and greaves for levels 28 to 58 (1g7s to 13g65s), the ones with the run-speed bonus."] = "De Reverenciado a Exaltado são 21.000 de reputação, cerca de 140 vitórias: metade de toda a subida. Reverenciado libera as botas e grevas do Highlander para os níveis 28 a 58 (1g7s a 13g65s), as que têm bônus de velocidade de corrida.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Revered rewards"] = "{npc:15127}: recompensas de Reverenciado",

	-- Step 9: Samuel Hawke
	-- {item:20073} Cloak of the Honor Guard · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Highlander's shoulders in every armor type (12g33s to 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) and Sageclaw (44g24s), both from level 55."] = "Exaltado dá o Ponto de Legado “Mestre da Bacia Arathi” e libera os épicos: as ombreiras do Highlander de nível 60 em todos os tipos de armadura (12g33s a 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) e Garrassábia (44g24s), ambos a partir do nível 55.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Exalted rewards"] = "{npc:15127}: recompensas de Exaltado",

	-- Step 10: Control Five Bases
	-- {npc:14983} Field Marshal Oslight · {item:20132} Arathor Battle Tabard
	["At Exalted, {npc:14983} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20132}, the only way to get it."] = "Em Exaltado, {npc:14983} pede que seu time mantenha as cinco bases ao mesmo tempo. Ele paga 200 de reputação e {item:20132}, a única forma de obtê-lo.",
	["all five bases held at once"] = "as cinco bases mantidas ao mesmo tempo",

	-- Step 11: Hammerfall
	-- {npc:15021} Deathmaster Dwire
	["{npc:15021}: assault four bases, 200"] = "{npc:15021}: assalte quatro bases, 200",
	-- {npc:15022} Deathstalker Mortis
	["{npc:15022}: one mark, 200"] = "{npc:15022}: uma marca, 200",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: three marks, 100"] = "{npc:15350}: três marcas, 100",

	-- Step 12: Arathi Basin
	-- {npc:15022} Deathstalker Mortis · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:15022}, three for the Warbringer. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Assaltar uma base é clicar no estandarte dela até ele virar: você não precisa mantê-la. São quatro marcas no total: uma para {npc:15022}, três para o Armipotente. O equipamento de JxJ do Forever também custa Marcas de Honra, além de honra: decida o que você quer antes de entregá-las. Você carrega no máximo 30 marcas de {zone:1461}: entregue ou gaste antes de chegar a isso.",
	["Assault the Stables banner"] = "Assalte o estandarte dos Estábulos",

	-- Step 13: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "De volta a {area:321}",

	-- Step 14: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} até Respeitado",
	-- {quest:8370} Conquering Arathi Basin · {area:321} Hammerfall
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:321} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "De Neutro a Amigável são 3.000 de reputação. No Classic, uma vitória pagava 100 e suas 3 marcas rendem mais 50 com o Armipotente ({quest:8370}, várias vezes): cerca de 150 por vitória, umas 20 vitórias. O Forever não publicou suas taxas de campo de batalha, então conte as partidas só como referência. Abaixo do nível 50, as missões em {area:321} vêm numa versão para a sua faixa (a partir do nível 20): 200 por assaltar as bases, 200 por uma marca e depois 100 e 50 a cada 3 marcas com o Armipotente.",
	-- {npc:15350} Horde Warbringer · {quest:8370} Conquering Arathi Basin
	["{npc:15350}: {quest:8370} again, 50 reputation for 3 marks"] = "{npc:15350}: {quest:8370} de novo, 50 de reputação por 3 marcas",

	-- Step 15: Take Four Bases
	-- {npc:15021} Deathmaster Dwire · {quest:8122} Take Five Bases
	["At level 60 and Friendly, {npc:15021} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8122} for Exalted."] = "No nível 60 e Amigável, {npc:15021} pede que seu time mantenha quatro bases ao mesmo tempo: 200 de reputação, uma única vez. Isso libera {quest:8122} para Exaltado.",

	-- Step 16: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} até Honrado",
	-- {npc:15126} Rutherford Twing · {npc:15021} Deathmaster Dwire · {item:20072} Defiler's Talisman · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15126} beside {npc:15021}: the {item:20072} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Defiler's care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "De Amigável a Honrado são 6.000 de reputação, cerca de 40 vitórias na taxa do Classic. Amigável libera as primeiras recompensas com {npc:15126}, ao lado de {npc:15021}: o berloque {item:20072} para os níveis 28, 38, 48 e 58 (72s a 4g12s), e comida e bandagens que funcionam em {zone:1461} (10s a 20s). Em Amigável ele também dá um pacote de suprimentos dos Profanadores (escolha o do seu nível): 10 de reputação e uma bolsa de comida e bandagens de campo de batalha.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Friendly rewards"] = "{npc:15126}: recompensas de Amigável",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}: 50 de reputação por 3 marcas",

	-- Step 17: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} até Reverenciado",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Defiler's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (75s to 8g78s)."] = "De Honrado a Reverenciado são 12.000 de reputação, cerca de 80 vitórias. Honrado libera os cinturões do Profanador em placa, lamelar, encadeado, malha, couro, couro de lagarto e tecido para os níveis 28 a 58 (75s a 8g78s).",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Honored rewards"] = "{npc:15126}: recompensas de Honrado",

	-- Step 18: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} até Exaltado",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Defiler's boots and greaves for levels 28 to 58 (1g12s to 13g41s), the ones with the run-speed bonus."] = "De Reverenciado a Exaltado são 21.000 de reputação, cerca de 140 vitórias: metade de toda a subida. Reverenciado libera as botas e grevas do Profanador para os níveis 28 a 58 (1g12s a 13g41s), as que têm bônus de velocidade de corrida.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Revered rewards"] = "{npc:15126}: recompensas de Reverenciado",

	-- Step 19: Rutherford Twing
	-- {item:20068} Deathguard's Cloak · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Defiler's shoulders in every armor type (12g75s to 20g), {item:20068} (13g18s), {item:20069} (50g46s) and Mindfang (42g83s), both from level 55."] = "Exaltado dá o Ponto de Legado “Mestre da Bacia Arathi” e libera os épicos: as ombreiras do Profanador de nível 60 em todos os tipos de armadura (12g75s a 20g), {item:20068} (13g18s), {item:20069} (50g46s) e Presa da Mente (42g83s), ambos a partir do nível 55.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Exalted rewards"] = "{npc:15126}: recompensas de Exaltado",

	-- Step 20: Take Five Bases
	-- {npc:15021} Deathmaster Dwire · {item:20131} Battle Tabard of the Defilers
	["At Exalted, {npc:15021} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20131}, the only way to get it."] = "Em Exaltado, {npc:15021} pede que seu time mantenha as cinco bases ao mesmo tempo. Ele paga 200 de reputação e {item:20131}, a única forma de obtê-lo.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the League of Arathor earns a Legacy Point."] = "Exaltado com A Liga de Arathor rende um Ponto de Legado.",
	-- ["Exalted with {faction:510} earns a Legacy Point."] = "Exaltado com {faction:510} rende um Ponto de Legado.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continue jogando {zone:1461}. Nos fins de semana de Chamado às Armas: {zone:1461}, o {npc:15350} nas capitais aceita três Marcas de Honra da Bacia Arathi por reputação extra.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continue jogando {zone:1461}. Nos fins de semana de Chamado às Armas: {zone:1461}, o {npc:15351} nas capitais aceita três Marcas de Honra da Bacia Arathi por reputação extra.",
	-- ["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Continue jogando {zone:1461}; vitórias com muitas bases dominadas dão mais.",
	-- ["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} luta por {zone:1461} a partir de {area:320}. A reputação vem do campo de batalha: os recursos que seu time junta dão reputação a todos, então manter mais bases por mais tempo dá mais. Entre na fila com qualquer mestre de batalha. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} lutam por {zone:1461} a partir de {area:321}. A reputação vem do campo de batalha: os recursos que seu time junta dão reputação a todos, então manter mais bases por mais tempo dá mais. Entre na fila com qualquer mestre de batalha. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "A Batalha pela {zone:1461}! (ataque todas as bases) e Controlar quatro bases / Controlar cinco bases, de {npc:14983}, são missões únicas; {npc:14984}, ao lado dele, aceita Caixas de Recursos Arathi.",
	-- ["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "A batalha pela {zone:1461}! (ataque todas as bases) e Tome quatro bases / Tome cinco bases, de {npc:15021}, são missões únicas; {npc:15022}, ao lado dele, aceita Caixas de Recursos Arathi.",
	-- ["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} entrega um Kit de Sobrevivência do Profanador por nível",
	-- ["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} entrega um Kit de Sobrevivência de Arathor por nível",
}
