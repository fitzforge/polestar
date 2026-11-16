-- Portuguese (Brazil) (ptBR): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "Reputação: Centauros Gelkis e Magram",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "Os clãs rivais de {zone:1443}, reformulados no Forever: escolha um, compre a amizade dele e troque totens por receitas.",
	-- {quest:93224} Carved Centaur Totems
	["12 recipes for {quest:93224} at the clan quartermasters, no standing needed"] = "12 receitas de {quest:93224} com os intendentes dos clãs, sem exigir reputação",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "Missão de {npc:5601}: um título do clã e a escolha entre três armas raras de nível 35",

	-- Step 1: Pick your clan
	["Pick your clan"] = "Escolha seu clã",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance · {quest:93224} Carved Centaur Totems
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, and every quest of one clan costs the other five times what it pays (Buying Friendship: 3,000 for yours, 15,000 off the other), so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "Os Gelkis (sudoeste de {zone:1443}) e os Magram (sudeste) estão em guerra: cada morte de um clã dá 20 ao outro e custa 100 ao seu próprio clã, e cada missão de um clã custa ao outro cinco vezes o que paga (Comprando Amizade: 3.000 para o seu, 15.000 a menos para o outro), então você só consegue subir com um. Os dois começam Neutros. As missões do Forever valem muito mais que as mortes agora. Aliança: {npc:5396} em {area:608} oferece {quest:1382} (Gelkis) e {quest:1385} (Magram). Horda: {npc:5412} oferece {quest:1368} e {quest:1367}. Pegue a do seu clã e {quest:93224}: a Comprando Amizade de cada clã (3.000) é oferecida assim que você traz os totens de volta. Depois marque a tarefa. O guia segue com os Gelkis; pegue as missões dos Magram e ele vai para a metade dos Magram. O Forever paga estas missões por inteiro em qualquer nível.",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "{quest:1382}: Gelkis",
	["Take the quests of one clan"] = "Pegue as missões de um clã",

	-- Step 2: Carved Centaur Totems
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) in the camps along the eastern road, south of {area:608}, drop the totems, and so do the Magram and the Maraudine. Bring five back, then take your clan's Buying Friendship (Gelkis below; the Magram's instead for the Magram)."] = "Os centauros Kolkar (nível 30-33) dos acampamentos ao longo da estrada leste, ao sul de {area:608}, soltam os totens, assim como os Magram e os Maraudinos. Traga cinco de volta e depois pegue a Comprando Amizade do seu clã (Gelkis abaixo; a dos Magram, no lugar, para os Magram).",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Kolkar centaurs"] = "{item:254432}: centauros Kolkar",

	-- Step 3: Gelkis or Magram
	["Gelkis or Magram"] = "Gelkis ou Magram",
	["No clan's quests in your log: the guide goes on with the Gelkis. For the Magram, take their choice quest and Buying Friendship and the guide goes to the Magram half."] = "Nenhuma missão de clã no seu registro de missões: o guia segue com os Gelkis. Para os Magram, pegue a missão de escolha deles e Comprando Amizade, e o guia vai para a metade dos Magram.",

	-- Step 4: Gelkis: the choice quest
	["Gelkis: the choice quest"] = "Gelkis: a missão de escolha",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village
	["The Gelkis half starts with the clan's choice quest from the giver you just handed the totems to: {npc:5397}'s quests in {area:606} follow from it, and Buying Friendship alone does not open them."] = "A metade dos Gelkis começa com a missão de escolha do clã, com o recrutador de missões a quem você acabou de entregar os totens: as missões de {npc:5397} em {area:606} vêm dela, e Comprando Amizade sozinha não as libera.",

	-- Step 5: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "{area:606}: {npc:5397} e {npc:253140}",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:606} fica nas colinas do sudoeste de {zone:1443}; {npc:5397} fica no centro. {npc:253140}, o intendente dos Gelkis, está no extremo sul da vila. Só Comprando Amizade já leva você de Neutro a Amigável.",

	-- Step 6: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "Gelkis: os acampamentos Kolkar",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "Os centauros Kolkar (nível 30-33) dominam os acampamentos ao sul de {area:608}, ao longo da estrada leste. Cerca de um em quatro solta um {item:6079}.",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "{item:6079}: centauros Kolkar",

	-- Step 7: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "Gelkis: {area:604}",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "Os Sacos de Carne ficam em {area:604}, no sudeste. Cada Magram que você matar no caminho dá 20 aos Gelkis.",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "{item:6069}: Sacos de Carne",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "{npc:4640}: 20 Gelkis",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "{npc:4641}: 20 Gelkis",

	-- Step 8: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "Gelkis: {quest:1373}",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "De volta a {npc:5397}, depois a leste, para {zone:1435}: {quest:1373} (nível 37) espera junto a um caldeirão negro em {area:76}, a nordeste de {area:75}.",

	-- Step 9: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "Gelkis: totens e mortes até Honrado",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 {quest:93224} for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "De Amigável a Honrado são 6.000; depois das missões do clã você já tem cerca de 4.000 disso, então faltam 2.000. {quest:92812} de {npc:253140} aceita 5 {quest:93224} por 750, várias vezes: três entregas, 15 totens. Os centauros Maraudinos (nível 36-40) do oeste de {zone:1443} os soltam; os totens não são vinculados, então a Casa de Leilões é a outra fonte. As mortes de Magram dão 20 cada, mas os dados de mortes do Forever os param no fim de Amigável, 1 antes de Honrado. Em Amigável, a vila também tem três encomendas de ofício por 1.000 cada: Halea quer 3 Essências Místicas Maiores, {npc:253140} quer uma {item:10008} (alfaiataria) e Talra quer um {item:5739} (couraria). O Legado Diplomata soma até 10%.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "{item:254432}: centauros Maraudinos",

	-- Step 10: Gelkis: Uthek the Wise sends you to the valley
	-- {npc:5397} Uthek the Wise
	["Gelkis: {npc:5397} sends you to the valley"] = "Gelkis: {npc:5397} manda você ao vale",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:1443} Desolace · {zone:2652} Shen'dralas · {quest:92811} Economic Warfare
	["At Honored and level 35, {npc:5397} sends you east to {npc:253177}, a Gelkis scout at the western mouth of the {quest:93034}, where the south of {zone:1443} runs into {zone:2652}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Gelkis, and each costs the Magram five times what it pays. Honored to Revered is 12,000; the valley pays 10,625 of it, {quest:92811} the rest."] = "Em Honrado e no nível 35, {npc:5397} envia você a leste, para {npc:253177}, um batedor Gelkis na entrada oeste de {quest:93034}, onde o sul de {zone:1443} encontra {zone:2652}. As etapas do vale seguem os dados de missão do Forever: ninguém que registra o próprio jogo fez estas missões ainda, então um local ou a ordem pode estar errado. Toda missão do vale pede que você continue Honrado com os Gelkis, e cada uma custa aos Magram cinco vezes o que paga. De Honrado a Reverenciado são 12.000; o vale paga 10.625 disso, {quest:92811} o resto.",

	-- Step 11: Gelkis: Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}"] = "Gelkis: {npc:253177}",
	-- {npc:253177} Nerlokh · {npc:11559} Outcast Necromancer
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253177} waits at the valley's western mouth. He wants six Undead Ravagers put to rest and the ritual garb of an {npc:11559}: the outcasts are Gelkis exiles who took up the Magram's necromancy."] = "Segundo os dados da missão: {npc:253177} espera na entrada oeste do vale. Ele quer seis Assoladores Mortos-vivos postos para descansar e o traje ritual de um {npc:11559}: os párias são exilados Gelkis que adotaram a necromancia dos Magram.",

	-- Step 12: Gelkis: the valley's mouth
	["Gelkis: the valley's mouth"] = "Gelkis: a entrada do vale",
	-- {quest:92846} Outcast Necromancers · {npc:253177} Nerlokh · {npc:253136} Orgrul
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253177} north-east to {npc:253136}'s post at its northern mouth; players have met them all along it. {npc:253136}'s Magram are hostile to a friend of the Gelkis. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "Segundo os dados da missão: os Assoladores Mortos-vivos e os {quest:92846} enchem o vale, de {npc:253177} para nordeste até o posto de {npc:253136}, na entrada norte; os jogadores os encontraram ao longo de todo ele. Os Magram de {npc:253136} são hostis a quem é amigo dos Gelkis. Come-cadáveres, elite e de nível 45, andam pelo vale e atacam qualquer um.",

	-- Step 13: Gelkis: Facing the Truth
	-- {quest:93041} Facing the Truth
	["Gelkis: {quest:93041}"] = "Gelkis: {quest:93041}",
	-- {npc:253177} Nerlokh · {item:255941} Gelkis Necromantic Garb · {npc:5397} Uthek the Wise · {item:255945} Accursed Skull
	["From the quest data: {npc:253177} gives you a {item:255941} to show {npc:5397}, with an {item:255945} you find yourself: a freshly cursed skull, hoarded in the jaws of one of the valley's giant skeletons. The game's data has no spot for it."] = "Segundo os dados da missão: {npc:253177} lhe dá um {item:255941} para mostrar a {npc:5397}, junto com um {item:255945} que você mesmo encontra: um crânio recém-amaldiçoado, guardado nas mandíbulas de um dos esqueletos gigantes do vale. Os dados do jogo não têm um local para ele.",
	-- {item:255945} Accursed Skull
	["{item:255945}: in a giant skeleton's jaws"] = "{item:255945}: nas mandíbulas de um esqueleto gigante",

	-- Step 14: Gelkis: Uthek the Wise and Mulara
	-- {npc:5397} Uthek the Wise · {npc:253713} Mulara
	["Gelkis: {npc:5397} and {npc:253713}"] = "Gelkis: {npc:5397} e {npc:253713}",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village · {npc:253713} Mulara · {npc:253140} Molkar · {quest:92812} Economic Warfare
	["From the quest data: back west to {npc:5397} in {area:606}. She needs Tears of Theradras: {npc:253713}, the Voice of Theradras, keeps them in the cave in the south of the village, past {npc:253140}. Ask her for them on {npc:5397}'s behalf and bring three back. {npc:253140} takes {quest:92812} on the way."] = "Segundo os dados da missão: de volta a oeste até {npc:5397}, em {area:606}. Ela precisa de Lágrimas de Theradras: {npc:253713}, a Voz de Theradras, as guarda na caverna no sul da vila, depois de {npc:253140}. Peça-as a ela em nome de {npc:5397} e traga três de volta. {npc:253140} recebe {quest:92812} no caminho.",
	-- {npc:253713} Mulara
	["{npc:253713}, in the cave"] = "{npc:253713}, na caverna",
	["three Tears of Theradras"] = "três Lágrimas de Theradras",

	-- Step 15: Gelkis: Test Your Theory
	-- {quest:93045} Test Your Theory
	["Gelkis: {quest:93045}"] = "Gelkis: {quest:93045}",
	-- {npc:5397} Uthek the Wise · {item:6071} Draenethyst Crystal · {item:256061} Uthek's Draenethyst Staff · {item:255945} Accursed Skull · {npc:253177} Nerlokh
	["From the quest data: {npc:5397} gives you her staff and a {item:6071}. Put them together into {item:256061}, take it to the ritual site by the pond just east of the village and dispel the curse on the {item:255945}. Then east again to {npc:253177}."] = "Segundo os dados da missão: {npc:5397} lhe dá o cajado dela e um {item:6071}. Junte os dois em {item:256061}, leve-o ao local do ritual junto à lagoa logo a leste da vila e dissipe a maldição do {item:255945}. Depois volte a leste até {npc:253177}.",
	-- {item:255945} Accursed Skull
	["dispel the {item:255945} by the pond"] = "dissipe o {item:255945} junto à lagoa",

	-- Step 16: Gelkis: back to Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: back to {npc:253177}"] = "Gelkis: de volta a {npc:253177}",
	-- {npc:253177} Nerlokh · {item:271794} Centaur Spear · {item:271795} Wanderer's Broadsword · {item:271799} Desert Crawler's Claw
	["From the quest data: {npc:253177} pays 500 and your pick of three weapons for level 35: {item:271794} (polearm), {item:271795} (two-handed sword) or {item:271799} (dagger). Then he has two jobs deeper in the valley."] = "Segundo os dados da missão: {npc:253177} paga 500 e a sua escolha de três armas para o nível 35: {item:271794} (arma de haste), {item:271795} (espada de duas mãos) ou {item:271799} (adaga). Depois ele tem duas tarefas mais fundo no vale.",

	-- Step 17: Gelkis: the heart of the valley
	["Gelkis: the heart of the valley"] = "Gelkis: o coração do vale",
	-- {npc:253177} Nerlokh · {npc:253446} Haggard Bones · {item:256061} Uthek's Draenethyst Staff
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: east of {npc:253177}, in the heart of the valley, the Magram hold Gelkis Captives: free five. Among them lie {npc:253446}, failed summons stuck in the ground: lay eight to rest with {item:256061}, which the quest gives you. Corpsefeeders and Magram Necrokhans, elite and level 45, walk the valley and attack a friend of the Gelkis: let them pass before you pull."] = "Segundo os dados da missão: a leste de {npc:253177}, no coração do vale, os Magram mantêm Cativos Gelkis: liberte cinco. Entre eles jazem {npc:253446}, invocações fracassadas presas no chão: faça oito descansarem com {item:256061}, que a missão lhe dá. Come-cadáveres e Necrokhans Magram, elite e de nível 45, andam pelo vale e atacam quem é amigo dos Gelkis: deixe-os passar antes de puxar.",
	-- {npc:253446} Haggard Bones
	["Lay {npc:253446} to rest"] = "Faça {npc:253446} descansar",
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive
	["free five Gelkis Captives"] = "liberte cinco Cativos Gelkis",

	-- Step 18: Gelkis: Checking Things Out
	-- {quest:93122} Checking Things Out
	["Gelkis: {quest:93122}"] = "Gelkis: {quest:93122}",
	-- {npc:253177} Nerlokh · {zone:2652} Shen'dralas · {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253177}'s next order takes you deeper into {zone:2652} to scout two places: the {area:16675}, a Magram camp south-east of the valley, and the {area:16676}, the exiles' camp west of the Shen'dralar town, further south."] = "Segundo os dados da missão: a próxima ordem de {npc:253177} leva você mais fundo em {zone:2652} para fazer o reconhecimento de dois lugares: {area:16675}, um acampamento Magram a sudeste do vale, e {area:16676}, o acampamento dos exilados a oeste da cidade Shen'dralar, mais ao sul.",

	-- Step 19: Gelkis: the Magram Front and the Outcast Hideaway
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["Gelkis: the {area:16675} and the {area:16676}"] = "Gelkis: {area:16675} e {area:16676}",
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway · {npc:254040} Rokren · {npc:253177} Nerlokh
	-- plural, as words: Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: walk into the Magram camp at the {area:16675}, then south-west into the {area:16676}, where Outcast Necrokhans, elite and level 45, stand guard. In a tent there {npc:254040}, a Gelkis the outcasts hold, asks you to get him out: escort him clear of the hideaway, then tell {npc:253177}."] = "Segundo os dados da missão: entre no acampamento Magram em {area:16675}, depois siga para sudoeste até {area:16676}, onde Necrokhans Párias, elite e de nível 45, montam guarda. Numa tenda ali, {npc:254040}, um Gelkis preso pelos párias, pede que você o tire de lá: escolte-o para fora do esconderijo e depois avise {npc:253177}.",
	-- {npc:254040} Rokren
	["escort {npc:254040} out of the hideaway"] = "escolte {npc:254040} para fora do esconderijo",

	-- Step 20: Gelkis: Nerlokh's last order
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}'s last order"] = "Gelkis: a última ordem de {npc:253177}",
	-- {npc:253177} Nerlokh
	["From the quest data: with the Magram's warriors busy at the Front, {npc:253177} sees a chance at their khan."] = "Segundo os dados da missão: com os guerreiros Magram ocupados na Frente, {npc:253177} vê uma chance de pegar o khan deles.",

	-- Step 21: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "Gelkis: {npc:5601}",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:253177} Nerlokh · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	-- plural, as words: Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: {npc:5601} (level 37) leads the Magram from the west side of {area:604}, north-east of {npc:253177}. The village is hostile to a friend of the Gelkis, and two Magram Necrokhans, elite and level 45, stand a little west of the khan. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina). The quest costs the Magram 30,000."] = "Segundo os dados da missão: {npc:5601} (nível 37) comanda os Magram a partir do lado oeste de {area:604}, a nordeste de {npc:253177}. A aldeia é hostil a quem é amigo dos Gelkis, e dois Necrokhans Magram, elite e de nível 45, ficam um pouco a oeste do khan. {npc:5397} paga 6.000, um título e a sua escolha de três armas raras de nível 35: {item:271801} (machado de duas mãos: Força, Vigor, Agilidade), {item:271802} (maça de uma mão: Força, Vigor, Agilidade) ou {item:271805} (mão secundária: Espírito, Intelecto, Vigor). A missão custa 30.000 aos Magram.",

	-- Step 22: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "Gelkis: totens até Exaltado",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "De Reverenciado em diante só resta {quest:92812}: de Reverenciado a Exaltado são 21.000, 28 entregas, 140 totens. Nada é vendido por reputação; as receitas abaixo só precisam de totens.",

	-- Step 23: Gelkis done
	["Gelkis done"] = "Gelkis concluídos",
	["No Gelkis quests done: on to the Magram, south-east."] = "Nenhuma missão dos Gelkis feita: siga para os Magram, a sudeste.",

	-- Step 24: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "{area:604}: {npc:5398} e {npc:253139}",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:604} ocupa o vale do sudeste de {zone:1443}; {npc:5398} fica no lado norte, e {npc:253139}, o intendente dos Magram, perto do lago. Só Comprando Amizade já leva você de Neutro a Amigável.",

	-- Step 25: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "Magram: os acampamentos Kolkar",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "Os centauros Kolkar (nível 30-33) dominam os acampamentos ao sul de {area:608}.",

	-- Step 26: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "Magram: {quest:1369}",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "As Lágrimas de Theradras são cristais na caverna atrás de {area:606}, no sudoeste. Cada Gelkis que você matar no caminho dá 20 aos Magram.",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "{quest:1369}: os cristais {object:22246}",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "{npc:4648}: 20 Magram",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "{npc:4649}: 20 Magram",

	-- Step 27: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "Magram: {quest:1371}",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "{npc:5398} quer um {item:4392}: engenheiros o fazem (4 {item:4234}, um {item:4389}, uma {item:4382} e uma {item:4387}); os outros compram um. Ele paga 1.000 e a escolha entre dois esquemas de engenharia, o {item:269900} ou o {item:269902}.",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "{item:4392}: feito por engenheiros, ou comprado",

	-- Step 28: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "Magram: totens e mortes até Honrado",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "De Amigável a Honrado são 6.000; depois das missões do clã você já tem cerca de 3.000 disso (4.000 com {quest:1371}), então faltam 2.000 a 3.000. {quest:92811} de {npc:253139} aceita 5 {quest:93224} por 750, várias vezes; os centauros Maraudinos (nível 36-40) do oeste de {zone:1443} os soltam, e os totens não são vinculados, então a Casa de Leilões é a outra fonte. As mortes de Gelkis dão 20 cada, mas os dados de mortes do Forever os param no fim de Amigável, 1 antes de Honrado. Em Amigável, a vila tem duas encomendas de ofício por 1.000 cada: 3 Poções Maiores de Proteção contra a Sombra de Mirda e 2 Machados Sólidos de Ferro de Grolkar (ferraria). {quest:92743} de {npc:5398} (1.000) não é encomenda de ofício: ele quer um {item:254392} de uma cripta em {zone:1418}, e as páginas de missões do Forever o põem na cadeia dele antes de {quest:92841}, então traga-o antes de chegar a Honrado. O Legado Diplomata soma até 10%.",

	-- Step 29: Magram: Warug sends you to the valley
	-- {npc:5398} Warug
	["Magram: {npc:5398} sends you to the valley"] = "Magram: {npc:5398} manda você ao vale",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {area:604} Magram Village · {quest:92841} Valley of Bones · {quest:92811} Economic Warfare
	["At Honored and level 35, after {quest:92743}, {npc:5398} sends you to {npc:253136} at the south end of {area:604}, the northern mouth of the {quest:92841}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Magram, and each costs the Gelkis five times what it pays. Honored to Revered is 12,000; the valley pays 11,125 of it, {quest:92811} the rest."] = "Em Honrado e no nível 35, depois de {quest:92743}, {npc:5398} envia você a {npc:253136}, no extremo sul de {area:604}, a entrada norte de {quest:92841}. As etapas do vale seguem os dados de missão do Forever: ninguém que registra o próprio jogo fez estas missões ainda, então um local ou a ordem pode estar errado. Toda missão do vale pede que você continue Honrado com os Magram, e cada uma custa aos Gelkis cinco vezes o que paga. De Honrado a Reverenciado são 12.000; o vale paga 11.125 disso, {quest:92811} o resto.",

	-- Step 30: Magram: Orgrul
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}"] = "Magram: {npc:253136}",
	-- {npc:253136} Orgrul · {quest:92846} Outcast Necromancers
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253136} wants bones from the valley's Undead Ravagers (the quest log counts them in hundreds) and six {quest:92846} dead: Gelkis exiles meddling with the Magram's new magic."] = "Segundo os dados da missão: {npc:253136} quer ossos dos Assoladores Mortos-vivos do vale (o registro de missões os conta em centenas) e seis {quest:92846} mortos: exilados Gelkis que se metem com a nova magia dos Magram.",

	-- Step 31: Magram: the valley's mouth
	["Magram: the valley's mouth"] = "Magram: a entrada do vale",
	-- {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253136} south-west to {npc:253177}'s post at its western mouth; players have met them all along it. {npc:253177} is a Gelkis scout. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "Segundo os dados da missão: os Assoladores Mortos-vivos e os {quest:92846} enchem o vale, de {npc:253136} para sudoeste até o posto de {npc:253177}, na entrada oeste; os jogadores os encontraram ao longo de todo ele. {npc:253177} é um batedor Gelkis. Come-cadáveres, elite e de nível 45, andam pelo vale e atacam qualquer um.",
	-- plural, as words: Gently Cursed Bones = {item:254663} Gently Cursed Bone · Undead Ravagers = {npc:11561} Undead Ravager
	["Gently Cursed Bones: Undead Ravagers"] = "Ossos Levemente Amaldiçoados: Assoladores Mortos-vivos",

	-- Step 32: Magram: Corrupting Tears
	-- {quest:92847} Corrupting Tears
	["Magram: {quest:92847}"] = "Magram: {quest:92847}",
	-- {npc:253136} Orgrul · {item:254841} Petrified Bark · {item:254840} Imbued Tears · {npc:5398} Warug
	["From the quest data: {npc:253136} wants three {item:254841} from the valley's accursed trees (the game's data has no spot for them) and three {item:254840}: {npc:5398} keeps the crystals you took from the Gelkis, so ask him."] = "Segundo os dados da missão: {npc:253136} quer três {item:254841} das árvores amaldiçoadas do vale (os dados do jogo não têm um local para elas) e três {item:254840}: {npc:5398} guarda os cristais que você tirou dos Gelkis, então peça a ele.",
	-- {item:254841} Petrified Bark
	["{item:254841}: the valley's accursed trees"] = "{item:254841}: as árvores amaldiçoadas do vale",

	-- Step 33: Magram: Proof of Concept
	-- {quest:92873} Proof of Concept
	["Magram: {quest:92873}"] = "Magram: {quest:92873}",
	-- {npc:253136} Orgrul · {item:254870} Rudimentary Necromancy Staff
	-- plural, as words: Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager · Well Cursed Bones = {item:254842} Well Cursed Bone
	["From the quest data: {npc:253136} gives you a {item:254870}. He laid out two skeletons on the hill just east of his post: put the staff to use there, and the Nascent Undead Ravagers give the Well Cursed Bones."] = "Segundo os dados da missão: {npc:253136} lhe dá um {item:254870}. Ele deixou dois esqueletos no morro logo a leste do posto dele: use o cajado ali, e os Assoladores Mortos-vivos Nascentes dão os Ossos Bem Amaldiçoados.",
	-- plural, as words: Well Cursed Bones = {item:254842} Well Cursed Bone · Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager
	["Well Cursed Bones: Nascent Undead Ravagers"] = "Ossos Bem Amaldiçoados: Assoladores Mortos-vivos Nascentes",

	-- Step 34: Magram: Orgrul's next tasks
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s next tasks"] = "Magram: as próximas tarefas de {npc:253136}",
	-- {npc:253136} Orgrul · {item:271796} Blade of the Magram Clan · {item:271797} Staff of Revelations · {item:271798} Desperate Barrier
	["From the quest data: {npc:253136} pays 500 and your pick of three items for level 35: {item:271796} (one-handed sword), {item:271797} (staff) or {item:271798} (shield)."] = "Segundo os dados da missão: {npc:253136} paga 500 e a sua escolha de três itens para o nível 35: {item:271796} (espada de uma mão), {item:271797} (cajado) ou {item:271798} (escudo).",

	-- Step 35: Magram: the heart of the valley
	["Magram: the heart of the valley"] = "Magram: o coração do vale",
	-- {npc:253136} Orgrul · {npc:253446} Haggard Bones
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: south-east of {npc:253136}, in the heart of the valley, the Magram keep Gelkis Captives: kill five. The {npc:253446} there are failed summons stuck in the ground: raise ten with the Enhanced Necromancy Staff Orgrul gave you, and kill the ones that fight back. Corpsefeeders, elite and level 45, walk the valley and attack anyone; the Magram Necrokhans, elite too, leave a friend of the Magram alone."] = "Segundo os dados da missão: a sudeste de {npc:253136}, no coração do vale, os Magram mantêm Cativos Gelkis: mate cinco. Os {npc:253446} dali são invocações fracassadas presas no chão: erga dez com o Cajado de Necromancia Aprimorado que Orgrul lhe deu e mate os que revidarem. Come-cadáveres, elite e de nível 45, andam pelo vale e atacam qualquer um; os Necrokhans Magram, também elite, deixam em paz quem é amigo dos Magram.",
	-- {npc:253446} Haggard Bones
	["Raise or slay {npc:253446}"] = "Erga ou mate {npc:253446}",

	-- Step 36: Magram: Bristleback Retreat
	-- {quest:93066} Bristleback Retreat
	["Magram: {quest:93066}"] = "Magram: {quest:93066}",
	-- {npc:253136} Orgrul · {quest:93066} Bristleback Retreat
	["From the quest data: back to {npc:253136}, then east to {quest:93066} for his next order."] = "Segundo os dados da missão: de volta a {npc:253136}, depois a leste até {quest:93066} para a próxima ordem dele.",

	-- Step 37: Magram: the quilboar
	["Magram: the quilboar"] = "Magram: os javaleses",
	-- {quest:93066} Bristleback Retreat · {npc:253527} Kog'thug the Brave · {npc:255678} Quolga the Wise · {npc:253851} Hagiak · {area:16675} Magram Front
	["From the quest data: the Bristleback quilboar hold {quest:93066}, east of the valley. {npc:253527} (elite, level 43) and {npc:255678} (elite, level 42) lead them: leave those two be. Then report to {npc:253851} at the {area:16675}, south of the Retreat."] = "Segundo os dados da missão: os javaleses Costagulha ocupam {quest:93066}, a leste do vale. {npc:253527} (elite, nível 43) e {npc:255678} (elite, nível 42) os lideram: deixe esses dois em paz. Depois apresente-se a {npc:253851} em {area:16675}, ao sul do Refúgio.",

	-- Step 38: Magram: Hagiak at the Magram Front
	-- {npc:253851} Hagiak · {area:16675} Magram Front
	["Magram: {npc:253851} at the {area:16675}"] = "Magram: {npc:253851} em {area:16675}",
	-- {npc:253851} Hagiak · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253851} sends you south-west to the {area:16676}, the exiles' camp west of the Shen'dralar town."] = "Segundo os dados da missão: {npc:253851} manda você para sudoeste, até {area:16676}, o acampamento dos exilados a oeste da cidade Shen'dralar.",

	-- Step 39: Magram: the Outcast Hideaway
	-- {area:16676} Outcast Hideaway
	["Magram: the {area:16676}"] = "Magram: {area:16676}",
	-- {item:256892} Stolen Supplies · {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Outcast Scouts = {npc:254283} Outcast Scout · Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: Outcast Scouts and Marauders hold the hideaway, with Outcast Necrokhans, elite and level 45, among them. The {item:256892} are crates in its west. The quest wants {quest:92846} here too; players have met them only in the valley between {npc:253136} and {npc:253177} so far, so take them there if the hideaway has none."] = "Segundo os dados da missão: Batedores e Saqueadores Párias ocupam o esconderijo, com Necrokhans Párias, elite e de nível 45, entre eles. Os {item:256892} são caixotes no lado oeste dele. A missão também quer {quest:92846} aqui; até agora os jogadores só os encontraram no vale entre {npc:253136} e {npc:253177}, então pegue-os lá se o esconderijo não tiver nenhum.",
	-- {item:256892} Stolen Supplies
	["{item:256892}: crates"] = "{item:256892}: caixotes",

	-- Step 40: Magram: back to Hagiak
	-- {npc:253851} Hagiak
	["Magram: back to {npc:253851}"] = "Magram: de volta a {npc:253851}",

	-- Step 41: Magram: Orgrul's ritual
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s ritual"] = "Magram: o ritual de {npc:253136}",
	-- {quest:93196} Khan Jehn · {npc:253136} Orgrul
	["From the quest data: {quest:93196} has been slain by outsiders working for the Gelkis, and {npc:253136} means to raise him."] = "Segundo os dados da missão: {quest:93196} foi morto por forasteiros a serviço dos Gelkis, e {npc:253136} pretende ressuscitá-lo.",

	-- Step 42: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "Magram: {quest:93196}",
	-- {item:257517} Ultimate Necromancy Staff · {area:604} Magram Village · {quest:93196} Khan Jehn · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["From the quest data: take the {item:257517} to the ritual site, a tent by the lake in the middle of {area:604}, and raise {quest:93196}. The risen khan takes the quest: 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit). The quest costs the Gelkis 30,000."] = "Segundo os dados da missão: leve {item:257517} ao local do ritual, uma tenda junto ao lago, no meio de {area:604}, e ressuscite {quest:93196}. O khan ressuscitado recebe a missão: 6.000, um título e a sua escolha de três armas raras de nível 35: {item:271800} (arma de haste: Vigor, poder de ataque, Agilidade), {item:271803} (cajado: Intelecto, Vigor, Espírito) ou {item:271804} (maça da mão principal: Intelecto, Vigor, Espírito). A missão custa 30.000 aos Gelkis.",
	-- {quest:93196} Khan Jehn
	["raise {quest:93196} at the tent by the lake"] = "ressuscite {quest:93196} na tenda junto ao lago",

	-- Step 43: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "Magram: totens até Exaltado",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "De Reverenciado em diante só resta {quest:92811}: de Reverenciado a Exaltado são 21.000, 28 entregas, 140 totens.",

	-- Step 44: The totem recipes
	["The totem recipes"] = "As receitas de totens",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Os dois intendentes vendem as mesmas 12 receitas por {quest:93224}, sem exigir reputação: {item:273613} e - Poder de Cura Menor; Explosão de Feitiço Maior e {item:250941}; plantas de {item:250538} e {item:250606}; moldes de {item:252462}, {item:253973}, {item:10011} e {item:274490}; os esquemas de {item:269900} e {item:269902}. Guarde os totens de que precisar para elas antes de entregar o resto.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["12 recipes for Carved Centaur Totems at the clan quartermasters, no standing needed"] = "12 receitas de Totem de Centauro Entalhado com os intendentes dos clãs, sem exigir reputação",
	-- ["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "Em Honrado, e depois de {quest:92743}, {npc:5398} envia você a {npc:253136}, na entrada norte de {quest:92841}, em {zone:2652}. As missões de {npc:253136} (500 cada: {quest:92844}, {quest:92846}, Lágrimas Corruptoras, Prova de Conceito, Sem Piedade com os Fracos, Erguendo Ossos) e as de Hagiak em {area:16675} ({area:16677}, Soluções de Longo Prazo, Ameaça de Fome, Retorno a {npc:253136}) terminam com {npc:5601}: erga o cã morto com o cajado de {npc:253136} na tenda junto ao lago em {area:604}, por 6.000, um título e uma arma rara de nível 35. Todas pedem que você continue Honrado ou melhor. De Honrado a Reverenciado são 12.000: as missões do vale pagam cerca de 11.000 disso, e duas entregas de {quest:92811} fazem o resto.",
	-- ["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "Em Honrado, {npc:5397} envia você a leste, para {npc:253177}, na entrada sul de {quest:93034}, em {zone:2652}. As missões de {npc:253177} (500 cada) levam você entre os mortos-vivos e os párias de lá: {quest:93035}, {quest:93037} e {quest:93041}, depois Um Grito de Purificação com {npc:5397}, e uma segunda linha (Salvando os Nossos, Enterrando Ossos, Conferindo as Coisas) que termina com {npc:5601}: mate o cã dos Magram na própria vila dele por 6.000, um título e uma arma rara de nível 35. Todas pedem que você continue Honrado ou melhor. De Honrado a Reverenciado são 12.000: as missões do vale pagam cerca de 10.600 disso, e duas ou três entregas de {quest:92811} fazem o resto.",
	-- ["Both quartermasters sell the same 12 recipes for Carved Centaur Totems, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Os dois intendentes vendem as mesmas 12 receitas por Totem de Centauro Entalhado, sem exigir reputação: {item:273613} e - Poder de Cura Menor; Explosão de Feitiço Maior e {item:250941}; plantas de {item:250538} e {item:250606}; moldes de {item:252462}, {item:253973}, {item:10011} e {item:274490}; os esquemas de {item:269900} e {item:269902}. Guarde os totens de que precisar para elas antes de entregar o resto.",
	-- ["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 Carved Centaur Totems for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "De Amigável a Honrado são 6.000; depois das missões do clã você já tem cerca de 3.000 disso (4.000 com {quest:1371}), então faltam 2.000 a 3.000. {quest:92811} de {npc:253139} aceita 5 Totens de Centauro Entalhado por 750, várias vezes; os centauros Maraudinos (nível 36-40) do oeste de {zone:1443} os soltam, e os totens não são vinculados, então a Casa de Leilões é a outra fonte. As mortes de Gelkis dão 20 cada, mas os dados de mortes do Forever os param no fim de Amigável, 1 antes de Honrado. Em Amigável, a vila tem duas encomendas de ofício por 1.000 cada: 3 Poções Maiores de Proteção contra a Sombra de Mirda e 2 Machados Sólidos de Ferro de Grolkar (ferraria). {quest:92743} de {npc:5398} (1.000) não é encomenda de ofício: ele quer um {item:254392} de uma cripta em {zone:1418}, e as páginas de missões do Forever o põem na cadeia dele antes de {quest:92841}, então traga-o antes de chegar a Honrado. O Legado Diplomata soma até 10%.",
	-- ["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 Carved Centaur Totems for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "De Amigável a Honrado são 6.000; depois das missões do clã você já tem cerca de 4.000 disso, então faltam 2.000. {quest:92812} de {npc:253140} aceita 5 Totens de Centauro Entalhado por 750, várias vezes: três entregas, 15 totens. Os centauros Maraudinos (nível 36-40) do oeste de {zone:1443} os soltam; os totens não são vinculados, então a Casa de Leilões é a outra fonte. As mortes de Magram dão 20 cada, mas os dados de mortes do Forever os param no fim de Amigável, 1 antes de Honrado. Em Amigável, a vila também tem três encomendas de ofício por 1.000 cada: Halea quer 3 Essências Místicas Maiores, {npc:253140} quer uma {item:10008} (alfaiataria) e Talra quer um {item:5739} (couraria). O Legado Diplomata soma até 10%.",
	-- ["Gelkis: the {quest:93034}"] = "Gelkis: {quest:93034}",
	-- ["Magram: the {quest:92841}"] = "Magram: {quest:92841}",
	-- ["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Forever pays these quests in full at any level."] = "Os Gelkis (sudoeste de {zone:1443}) e os Magram (sudeste) estão em guerra: cada morte de um clã dá 20 ao outro e custa 100 ao seu próprio clã, então você só consegue subir com um. Os dois começam Neutros. As missões do Forever valem muito mais que as mortes agora, e as missões de escolha já não custam nada ao outro clã. Aliança: {npc:5396} em {area:608} oferece {quest:1382} (Gelkis) e {quest:1385} (Magram). Horda: {npc:5412}, a leste de Predassombra, oferece {quest:1368} e {quest:1367}. Pegue a do seu clã e a Comprando Amizade dele (3.000 por levar um fardo de totens), depois marque a tarefa. O guia segue com os Gelkis; pegue as missões dos Magram e ele pula para a metade dos Magram. O Forever paga estas missões por inteiro em qualquer nível.",
}
