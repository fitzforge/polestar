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
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["12 recipes for Carved Centaur Totems at the clan quartermasters, no standing needed"] = "12 receitas de Totem de Centauro Entalhado com os intendentes dos clãs, sem exigir reputação",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "Missão de {npc:5601}: um título do clã e a escolha entre três armas raras de nível 35",

	-- Step 1: Pick your clan
	["Pick your clan"] = "Escolha seu clã",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Forever pays these quests in full at any level."] = "Os Gelkis (sudoeste de {zone:1443}) e os Magram (sudeste) estão em guerra: cada morte de um clã dá 20 ao outro e custa 100 ao seu próprio clã, então você só consegue subir com um. Os dois começam Neutros. As missões do Forever valem muito mais que as mortes agora, e as missões de escolha já não custam nada ao outro clã. Aliança: {npc:5396} em {area:608} oferece {quest:1382} (Gelkis) e {quest:1385} (Magram). Horda: {npc:5412}, a leste de Predassombra, oferece {quest:1368} e {quest:1367}. Pegue a do seu clã e a Comprando Amizade dele (3.000 por levar um fardo de totens), depois marque a tarefa. O guia segue com os Gelkis; pegue as missões dos Magram e ele pula para a metade dos Magram. O Forever paga estas missões por inteiro em qualquer nível.",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "{quest:1382}: Gelkis",
	["Take the quests of one clan"] = "Pegue as missões de um clã",

	-- Step 2: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "{area:606}: {npc:5397} e {npc:253140}",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:606} fica nas colinas do sudoeste de {zone:1443}; {npc:5397} fica no centro. {npc:253140}, o intendente dos Gelkis, está no extremo sul da vila. Só Comprando Amizade já leva você de Neutro a Amigável.",

	-- Step 3: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "Gelkis: os acampamentos Kolkar",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "Os centauros Kolkar (nível 30-33) dominam os acampamentos ao sul de {area:608}, ao longo da estrada leste. Cerca de um em quatro solta um {item:6079}.",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "{item:6079}: centauros Kolkar",

	-- Step 4: Gelkis: Magram Village
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

	-- Step 5: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "Gelkis: {quest:1373}",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "De volta a {npc:5397}, depois a leste, para {zone:1435}: {quest:1373} (nível 37) espera junto a um caldeirão negro em {area:76}, a nordeste de {area:75}.",

	-- Step 6: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "Gelkis: totens e mortes até Honrado",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 Carved Centaur Totems for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "De Amigável a Honrado são 6.000; depois das missões do clã você já tem cerca de 4.000 disso, então faltam 2.000. {quest:92812} de {npc:253140} aceita 5 Totens de Centauro Entalhado por 750, várias vezes: três entregas, 15 totens. Os centauros Maraudinos (nível 36-40) do oeste de {zone:1443} os soltam; os totens não são vinculados, então a Casa de Leilões é a outra fonte. As mortes de Magram dão 20 cada, mas os dados de mortes do Forever os param no fim de Amigável, 1 antes de Honrado. Em Amigável, a vila também tem três encomendas de ofício por 1.000 cada: Halea quer 3 Essências Místicas Maiores, {npc:253140} quer uma {item:10008} (alfaiataria) e Talra quer um {item:5739} (couraria). O Legado Diplomata soma até 10%.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "{item:254432}: centauros Maraudinos",

	-- Step 7: Gelkis: the Valley of Bones
	-- {quest:93034} Valley of Bones
	["Gelkis: the {quest:93034}"] = "Gelkis: {quest:93034}",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:2652} Shen'dralas · {quest:93035} Ravaging Ravagers · {quest:93037} Outing Outcasts · {quest:93041} Facing the Truth · {npc:5601} Khan Jehn · {quest:92811} Economic Warfare
	["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "Em Honrado, {npc:5397} envia você a leste, para {npc:253177}, na entrada sul de {quest:93034}, em {zone:2652}. As missões de {npc:253177} (500 cada) levam você entre os mortos-vivos e os párias de lá: {quest:93035}, {quest:93037} e {quest:93041}, depois Um Grito de Purificação com {npc:5397}, e uma segunda linha (Salvando os Nossos, Enterrando Ossos, Conferindo as Coisas) que termina com {npc:5601}: mate o cã dos Magram na própria vila dele por 6.000, um título e uma arma rara de nível 35. Todas pedem que você continue Honrado ou melhor. De Honrado a Reverenciado são 12.000: as missões do vale pagam cerca de 10.600 disso, e duas ou três entregas de {quest:92811} fazem o resto.",

	-- Step 8: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "Gelkis: {npc:5601}",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	["{npc:5601} (level 37) leads the Magram from the west side of {area:604}, with his bodyguards. The kill costs the Magram 500. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina)."] = "{npc:5601} (nível 37) comanda os Magram a partir do lado oeste de {area:604}, com seus guarda-costas. A morte custa 500 aos Magram. {npc:5397} paga 6.000, um título e a sua escolha de três armas raras de nível 35: {item:271801} (machado de duas mãos: Força, Vigor, Agilidade), {item:271802} (maça de uma mão: Força, Vigor, Agilidade) ou {item:271805} (mão secundária: Espírito, Intelecto, Vigor).",

	-- Step 9: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "Gelkis: totens até Exaltado",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "De Reverenciado em diante só resta {quest:92812}: de Reverenciado a Exaltado são 21.000, 28 entregas, 140 totens. Nada é vendido por reputação; as receitas abaixo só precisam de totens.",

	-- Step 10: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "{area:604}: {npc:5398} e {npc:253139}",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:604} ocupa o vale do sudeste de {zone:1443}; {npc:5398} fica no lado norte, e {npc:253139}, o intendente dos Magram, perto do lago. Só Comprando Amizade já leva você de Neutro a Amigável.",

	-- Step 11: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "Magram: os acampamentos Kolkar",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "Os centauros Kolkar (nível 30-33) dominam os acampamentos ao sul de {area:608}.",

	-- Step 12: Magram: Broken Tears
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

	-- Step 13: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "Magram: {quest:1371}",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "{npc:5398} quer um {item:4392}: engenheiros o fazem (4 {item:4234}, um {item:4389}, uma {item:4382} e uma {item:4387}); os outros compram um. Ele paga 1.000 e a escolha entre dois esquemas de engenharia, o {item:269900} ou o {item:269902}.",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "{item:4392}: feito por engenheiros, ou comprado",

	-- Step 14: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "Magram: totens e mortes até Honrado",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 Carved Centaur Totems for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "De Amigável a Honrado são 6.000; depois das missões do clã você já tem cerca de 3.000 disso (4.000 com {quest:1371}), então faltam 2.000 a 3.000. {quest:92811} de {npc:253139} aceita 5 Totens de Centauro Entalhado por 750, várias vezes; os centauros Maraudinos (nível 36-40) do oeste de {zone:1443} os soltam, e os totens não são vinculados, então a Casa de Leilões é a outra fonte. As mortes de Gelkis dão 20 cada, mas os dados de mortes do Forever os param no fim de Amigável, 1 antes de Honrado. Em Amigável, a vila tem duas encomendas de ofício por 1.000 cada: 3 Poções Maiores de Proteção contra a Sombra de Mirda e 2 Machados Sólidos de Ferro de Grolkar (ferraria). {quest:92743} de {npc:5398} (1.000) não é encomenda de ofício: ele quer um {item:254392} de uma cripta em {zone:1418}, e as páginas de missões do Forever o põem na cadeia dele antes de {quest:92841}, então traga-o antes de chegar a Honrado. O Legado Diplomata soma até 10%.",

	-- Step 15: Magram: the Valley of Bones
	-- {quest:92841} Valley of Bones
	["Magram: the {quest:92841}"] = "Magram: {quest:92841}",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {quest:92841} Valley of Bones · {zone:2652} Shen'dralas · {quest:92844} Mountain of Bones · {quest:92846} Outcast Necromancers · {area:16675} Magram Front · {area:16677} Bristleback Retreat · {npc:5601} Khan Jehn · {area:604} Magram Village · {quest:92811} Economic Warfare
	["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "Em Honrado, e depois de {quest:92743}, {npc:5398} envia você a {npc:253136}, na entrada norte de {quest:92841}, em {zone:2652}. As missões de {npc:253136} (500 cada: {quest:92844}, {quest:92846}, Lágrimas Corruptoras, Prova de Conceito, Sem Piedade com os Fracos, Erguendo Ossos) e as de Hagiak em {area:16675} ({area:16677}, Soluções de Longo Prazo, Ameaça de Fome, Retorno a {npc:253136}) terminam com {npc:5601}: erga o cã morto com o cajado de {npc:253136} na tenda junto ao lago em {area:604}, por 6.000, um título e uma arma rara de nível 35. Todas pedem que você continue Honrado ou melhor. De Honrado a Reverenciado são 12.000: as missões do vale pagam cerca de 11.000 disso, e duas entregas de {quest:92811} fazem o resto.",

	-- Step 16: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "Magram: {quest:93196}",
	-- {area:604} Magram Village · {npc:253136} Orgrul · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["The ritual site is a tent by the lake in the middle of {area:604}. {npc:253136} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit)."] = "O local do ritual é uma tenda junto ao lago, no meio de {area:604}. {npc:253136} paga 6.000, um título e a sua escolha de três armas raras de nível 35: {item:271800} (arma de haste: Vigor, poder de ataque, Agilidade), {item:271803} (cajado: Intelecto, Vigor, Espírito) ou {item:271804} (maça da mão principal: Intelecto, Vigor, Espírito).",

	-- Step 17: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "Magram: totens até Exaltado",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "De Reverenciado em diante só resta {quest:92811}: de Reverenciado a Exaltado são 21.000, 28 entregas, 140 totens.",

	-- Step 18: The totem recipes
	["The totem recipes"] = "As receitas de totens",
	-- {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["Both quartermasters sell the same 12 recipes for Carved Centaur Totems, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Os dois intendentes vendem as mesmas 12 receitas por Totem de Centauro Entalhado, sem exigir reputação: {item:273613} e - Poder de Cura Menor; Explosão de Feitiço Maior e {item:250941}; plantas de {item:250538} e {item:250606}; moldes de {item:252462}, {item:253973}, {item:10011} e {item:274490}; os esquemas de {item:269900} e {item:269902}. Guarde os totens de que precisar para elas antes de entregar o resto.",
}
