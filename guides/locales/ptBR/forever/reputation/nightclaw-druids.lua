-- Portuguese (Brazil) (ptBR): the guide forever/reputation/nightclaw-druids (forever/reputation/nightclaw-druids.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Nightclaw Druids = {npc:254152} Nightclaw Druid
	["Nightclaw Druids Reputation"] = "Reputação: Druidas Noctigarra",
	-- {zone:2521} Zephras Isle
	["{zone:2521}'s hidden druids: five cultist ears pay 1000 reputation, best done before you outlevel the isle."] = "Os druidas escondidos de {zone:2521}: cinco orelhas de cultistas rendem 1000 de reputação, melhor fazer antes de você passar do nível da ilha.",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["48 {skill:164}, {skill:165} and {skill:197} patterns"] = "48 moldes de {skill:164}, {skill:165} e {skill:197}",

	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste de {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the north side of {area:279} about every five minutes; another flies from north of {zone:1456}, and either faction may take either."] = "{zone:2521} é a ilha inicial dos Celonatos, aberta a todos. Um barco celeste parte do lado norte de {area:279} a cada cinco minutos, mais ou menos; outra voa do norte de {zone:1456}, e qualquer facção pode pegar qualquer uma.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste para {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste de {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes; another flies from {area:279}, and either faction may take either."] = "{zone:2521} é a ilha inicial dos Celonatos, aberta a todos. Um barco celeste parte dos penhascos ao sul de {area:17045}, ao norte de {zone:1456}, a cada cinco minutos, mais ou menos; outra voa de {area:279}, e qualquer facção pode pegar qualquer uma.",

	-- Step 3: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Players' turn-ins paid their full reputation well above these quests' level."] = "{npc:252359} fica em {area:16638}, a cidade dos Celonatos no sul da ilha, e não ouviu nada dos druidas do norte. O recado dele é o começo da história dos Noctigarra (nível 8 em diante, qualquer raça). Toda missão dela paga reputação com os Noctigarra: 4100 no total, o bastante para Amigável. As entregas dos jogadores pagavam a reputação cheia bem acima do nível dessas missões.",

	-- Step 4: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into the {area:16631}. {npc:257944} holds the druids' camp in its north-east."] = "Siga para o norte, até {area:16631}. {npc:257944} guarda o acampamento dos druidas, no nordeste.",

	-- Step 5: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:257944} Elegael Thornpaw · {area:16720} Nightclaw Cavern
	["{npc:254151}, the druids' quartermaster, waits inside their den: the cave just across the clearing north-east of {npc:257944} ({area:16720} on the map; {npc:257944} calls it the Nightfang Den). Take his ear quest now: the cultists you fight for {npc:257944} drop ears for it."] = "{npc:254151}, o intendente dos druidas, espera dentro do covil deles: a caverna logo do outro lado da clareira, a nordeste de {npc:257944} ({area:16720} no mapa; {npc:257944} a chama de Nightfang Den). Pegue agora a missão das orelhas dele: os cultistas que você enfrenta para {npc:257944} soltam orelhas para ela.",

	-- Step 6: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Footsoldiers = {npc:252665} Al'Aketh Footsoldier · Bloody Heirlooms = {item:265141} Bloody Heirloom · Shadowgale Shrieklings = {npc:256092} Shadowgale Shriekling
	["The Al'Aketh Footsoldiers and Stormchasers camp just north of {npc:257944} and drop the Bloody Heirlooms (and ears, about one kill in four). The Shadowgale Shrieklings flying west of her drop the feathers; the {item:265105} grows on the trees along the stream west of her."] = "Os Soldados de Infantaria Al'Aketh e os Caça-tempestades acampam logo ao norte de {npc:257944} e soltam as Heranças Sangrentas (e orelhas, uma morte em quatro, mais ou menos). Os Guinchotes Ventosombra que voam a oeste dela soltam as penas; o {item:265105} cresce nas árvores ao longo do riacho a oeste dela.",
	-- {npc:254151} Vayn Moongaze
	["ears for {npc:254151}: keep every one"] = "orelhas para {npc:254151}: guarde todas",

	-- Step 7: Elegael Thornpaw's next tasks
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}'s next tasks"] = "As próximas tarefas de {npc:257944}",
	["500 reputation"] = "500 de reputação",

	-- Step 8: The Nightfang Den and Commander Haalien
	-- {npc:253622} Commander Haalien
	["The Nightfang Den and {npc:253622}"] = "O Nightfang Den e {npc:253622}",
	-- {npc:257944} Elegael Thornpaw · {npc:258134} Naaleos Leafwhisper · {npc:258130} Jorel Windsinger · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["The Nightfang Den is the cave north across the clearing from {npc:257944}. Heal the seven injured druids inside ({npc:258134} among them) and find {npc:258130}. {npc:253622} stands east of the den: he drops his head and a {quest:94490}; right-click the missive to start its quest."] = "O Nightfang Den é a caverna ao norte, do outro lado da clareira em relação a {npc:257944}. Cure os sete druidas feridos lá dentro ({npc:258134} entre eles) e encontre {npc:258130}. {npc:253622} fica a leste do covil: ele solta a cabeça dele e um {quest:94490}; clique com o botão direito no comunicado para iniciar a missão.",
	-- {npc:253622} Commander Haalien
	["from {npc:253622}"] = "de {npc:253622}",

	-- Step 9: Elegael Thornpaw, the den's fate
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the den's fate"] = "{npc:257944}, o destino do covil",
	["1000 reputation"] = "1000 de reputação",

	-- Step 10: Ears at the Shrine of Akir
	-- {area:16629} Shrine of Akir
	["Ears at the {area:16629}"] = "Orelhas em {area:16629}",
	-- {area:16629} Shrine of Akir · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Honor Guards = {npc:3083} Honor Guard
	["The best ears are south of the forest at the {area:16629}: Skypriests drop one in more than half their kills, Guardians in four of ten, Spiritcallers and Honor Guards in a third. The {area:16626} just north-west of {area:16638} are next best (Brawlers and Pillagers, about four in ten). All cultists are level 8 to 10."] = "As melhores orelhas ficam ao sul da floresta, em {area:16629}: os Sacerdotes do Céu soltam uma em mais da metade das mortes, os Guardiões em quatro de dez, os Evoca-espíritos e os Guardas de Honra em um terço. Os {area:16626} logo a noroeste de {area:16638} vêm em seguida (Brigões e Pilhadores, cerca de quatro em dez). Todos os cultistas são de nível 8 a 10.",

	-- Step 11: Mercy Falls on Deaf Ears
	-- {npc:254151} Vayn Moongaze
	["Back to {npc:254151} inside the den. Ten ears for 1000 reputation and a green piece: leather gloves, cloth pants or mail boots. {npc:254151} then takes ears five at a time, for 1000 each, as often as you like, up to level 18; in Classic the pay drops from level 19 and is 200 from level 22. The Legacy perk Diplomat adds up to 10% to every gain."] = "Volte a {npc:254151}, dentro do covil. Dez orelhas por 1000 de reputação e uma peça verde: luvas de couro, calças de tecido ou botas de malha. {npc:254151} passa a aceitar orelhas de cinco em cinco, por 1000 cada, quantas vezes você quiser, até o nível 18; no Classic o pagamento cai a partir do nível 19 e é 200 a partir do nível 22. A vantagem de Legado Diplomata soma até 10% a cada ganho.",

	-- Step 12: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "De volta a {area:16638}",
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["{npc:252359} waits in {area:16638}. Hand in on your way to a skyboat or to the {area:16626}."] = "{npc:252359} espera em {area:16638}. Entregue no caminho para um barco celeste ou para {area:16626}.",

	-- Step 13: Friendly to Honored
	["Friendly to Honored"] = "Amigável a Honrado",
	-- {npc:254151} Vayn Moongaze
	["The storyline and {npc:254151}'s first quest leave you at Friendly with 2100 to spare. Honored is 3900 more: four turn-ins of five ears up to level 18, twenty from level 22. Friendly opens 32 of {npc:254151}'s patterns, in two colours, Cloudy and Azure: Blacksmithing Skyforged Wristguards and Chain (skill 50, 9s 50c), Gauntlets and Greaves (55, 11s); Leatherworking Gustwoven and Windraveled bracers and belts (50) and gloves and boots (55); Tailoring Stormsewn Cuffs and Cord (50), Handwraps and Shoes (55). They bind when you buy them, so buy them on the crafter."] = "A história e a primeira missão de {npc:254151} deixam você em Amigável com 2100 de sobra. Honrado fica a mais 3900: quatro entregas de cinco orelhas até o nível 18, vinte a partir do nível 22. Amigável abre 32 moldes de {npc:254151}, em duas cores, Neblinosa e Lazúli: Ferraria, Munhequeiras e Corrente da Forja Celeste (perícia 50, 9s 50c), Manoplas e Grevas (55, 11s); Couraria, braçadeiras e cintos Tecidos com Lufadas e Desfiados pelo Vento (50) e luvas e botas (55); Alfaiataria, Manilhas e Cordão Costurados a Tempestade (50), Mitenes e Sapatos (55). Eles se tornam vinculados ao serem comprados, então compre-os no artesão.",
	["five ears per turn-in"] = "cinco orelhas por entrega",
	-- {quest:93459} More Al'Aketh Ears
	["{quest:93459}: 1000 reputation"] = "{quest:93459}: 1000 de reputação",
	-- {npc:254151} Vayn Moongaze
	["{npc:254151}'s patterns"] = "Os moldes de {npc:254151}",

	-- Step 14: Honored to Revered
	["Honored to Revered"] = "De Honrado a Reverenciado",
	["Honored opens the chest and leg patterns (skill 60, 12s 50c): Skyforged chainmail and legguards, Gustwoven harness and trousers, Windraveled jerkin and pants, Stormsewn vest and leggings. Revered is 12000 more: 12 turn-ins (60 ears, about 160 cultist kills at the Shrine) up to level 18, 60 turn-ins (300 ears) from level 22."] = "Honrado abre os moldes de peito e pernas (perícia 60, 12s 50c): malha e guarda-pernas da Forja Celeste, arnês e calças Tecidos com Lufadas, gibão e calças Desfiados pelo Vento, colete e perneiras Costurados a Tempestade. Reverenciado fica a mais 12000: 12 entregas (60 orelhas, cerca de 160 mortes de cultistas no Santuário) até o nível 18, 60 entregas (300 orelhas) a partir do nível 22.",

	-- Step 15: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {item:280347} Shadowgale Squirrel
	["Revered opens the {item:280347}, a companion pet, for 50s. Exalted is 21000 more: 21 turn-ins (105 ears, about 280 kills) up to level 18, 105 turn-ins (525 ears) from level 22."] = "Reverenciado abre o {item:280347}, um mascote companheiro, por 50s. Exaltado fica a mais 21000: 21 entregas (105 orelhas, cerca de 280 mortes) até o nível 18, 105 entregas (525 orelhas) a partir do nível 22.",
	-- {item:280347} Shadowgale Squirrel
	["{item:280347}, 50s"] = "{item:280347}, 50s",

	-- Step 16: The Nightclaw Mantle
	-- {item:280363} Nightclaw Mantle
	["The {item:280363}"] = "O {item:280363}",
	-- {item:280363} Nightclaw Mantle
	["Exalted opens the {item:280363}, green cloth shoulders for level 15, for 8s 16c."] = "Exaltado abre o {item:280363}, ombreiras de tecido verdes para o nível 15, por 8s 16c.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Come early: in Classic a quest pays less once you are 6 levels above it, a fifth at most from 9 levels up, and these are level 11 to 13 quests."] = "{npc:252359} fica em {area:16638}, a cidade dos Celonatos no sul da ilha, e não ouviu nada dos druidas do norte. A missão dele é o começo da história dos Noctigarra (nível 8 em diante, qualquer raça). Toda missão dela rende reputação com os Noctigarra: 4100 no total, o bastante para Amigável. Venha cedo: no Classic uma missão paga menos quando você está 6 níveis acima dela e no máximo um quinto a partir de 9 níveis, e estas são missões de nível 11 a 13.",
}
