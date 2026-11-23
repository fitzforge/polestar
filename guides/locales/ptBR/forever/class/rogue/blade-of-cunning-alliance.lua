-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/blade-of-cunning-alliance (forever/class/rogue/blade-of-cunning-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Alliance)"] = "{item:7298} (Aliança)",
	["A dagger at 10 from your home town's rogue quests."] = "Uma adaga no nível 10, das missões de ladino da sua cidade natal.",

	-- Step 1: Seek out SI: 7
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:332} Master Mathias Shaw · {zone:1453} Stormwind · {spell:921} Pick Pocket
	["At 10 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}. Train {spell:921} if you lack it: this chain needs it."] = "No nível 10, {npc:917}, o instrutor de ladino no andar de cima da Estalagem Orgulho do Leão, em {area:87}, entrega a você um pacote para {npc:332}, em {zone:1453}. Aprenda {spell:921} se não tiver: esta cadeia exige.",

	-- Step 2: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north to {zone:1453}. Shaw stands upstairs in the SI:7 building in {object:2100} (the quest says the Barracks; it means SI:7)."] = "Vá para o norte, até {zone:1453}. Shaw fica no andar de cima do prédio da SI:7, em {object:2100} (a missão diz Quartel; ela quer dizer SI:7).",

	-- Step 3: Defias Dockmaster
	-- {npc:6846} Defias Dockmaster · {area:797} Jerod's Landing · {area:87} Goldshire · {spell:921} Pick Pocket · {spell:2070} Sap
	["The {npc:6846} (level 10, a goblin) works in the dock house at {area:797}, on the river at Elwynn's southern edge, south of {area:87}. Stealth in and {spell:921} him from behind: the schedule never drops from his corpse. Do not open with {spell:2070} or a fight: he calls in three waves of bodyguards. Keep away from the fireplaces in the house; they burn you out of stealth. He is back 2 to 5 minutes after a death."] = "O {npc:6846} (nível 10, um goblin) trabalha na casa da doca de {area:797}, no rio, na ponta sul de Elwynn, ao sul de {area:87}. Entre em furtividade e use {spell:921} nele pelas costas: o cronograma nunca cai do corpo dele. Não comece com {spell:2070} nem com uma luta: ele chama três levas de guarda-costas. Fique longe das lareiras da casa; elas queimam você para fora da furtividade. Ele volta de 2 a 5 minutos depois de morrer.",
	-- {spell:921} Pick Pocket · {npc:6846} Defias Dockmaster · {item:7675} Defias Shipping Schedule
	["{spell:921} the {npc:6846} for the {item:7675}"] = "Use {spell:921} no {npc:6846} para pegar o {item:7675}",

	-- Step 4: Back to Mathias Shaw
	["Back to Mathias Shaw"] = "De volta ao Mestre Mathias Shaw",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7"] = "{npc:332}, AVIN",

	-- Step 5: Road to Salvation
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 10 {npc:1234}, the rogue trainer in the {area:2102} in {area:131}, sends you to {npc:5165} in {zone:1455}."] = "No nível 10, {npc:1234}, o instrutor de ladinos na {area:2102} em {area:131}, manda você até {npc:5165} em {zone:1455}.",

	-- Step 6: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {zone:1455} Ironforge
	["{npc:5165} is in the {object:32383}, the rogue quarter in the north of {zone:1455}: go into the building with a shady dealer outside and down the stairs."] = "{npc:5165} fica na {object:32383}, o bairro dos ladinos no norte de {zone:1455}: entre no prédio com um negociante suspeito do lado de fora e desça as escadas.",

	-- Step 7: Onin MacHammar
	-- {area:133} Gnomeregan · {npc:6886} Onin MacHammar · {npc:1211} Leper Gnome
	["Head west to {area:133}. Beside the road to its entrance stands a wooden spiral tower: {npc:6886} waits stealthed on the top platform, next to a level 10 {npc:1211}, so you only see him up close."] = "Vá para o oeste, até {area:133}. Ao lado da estrada para a entrada fica uma torre de madeira em espiral: {npc:6886} espera em furtividade na plataforma de cima, ao lado de um {npc:1211} de nível 10, então você só o vê de perto.",

	-- Step 8: Back to Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard
	["Back to {npc:5165}"] = "De volta a {npc:5165}",

	-- Step 9: The Apple Falls
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {npc:4163} Syurna · {zone:1457} Darnassus
	["At 10 {npc:3599}, the rogue trainer in the {area:186} inn, gives you a rose for {npc:4163} in {zone:1457}. If you lose the rose, abandon the quest and take it again."] = "No nível 10, {npc:3599}, o instrutor de ladino na estalagem de {area:186}, entrega a você uma rosa para {npc:4163}, em {zone:1457}. Se perder a rosa, abandone a missão e pegue de novo.",

	-- Step 10: Syurna
	-- {zone:1457} Darnassus · {npc:4163} Syurna · {area:1658} Cenarion Enclave
	["Head west to {zone:1457}. {npc:4163} is below ground in the {area:1658}: the way down is the opening at the foot of the split tree left of the Arch Druid's tree, near the nightsaber trainer. Her map marker shows above ground."] = "Vá para o oeste, até {zone:1457}. {npc:4163} fica no subterrâneo, em {area:1658}: a entrada é a abertura ao pé da árvore rachada, à esquerda da árvore do Arquidruida, perto do instrutor de sabres-da-noite. O marcador dela no mapa aparece acima do chão.",

	-- Step 11: Sethir the Ancient
	-- {npc:6909} Sethir the Ancient · {area:264} Oracle Glade · {spell:2983} Sprint
	["{npc:6909} (level 12 satyr) lives out on a great branch north of the {area:264}: go through the V-shaped gap in the wall north of the glade and out along the branch. Pick his pocket for the journal; killing him does not give it, and a fight brings out three Minions of Sethir. He walks between the main branch and a side branch: wait stealthed at the far end of the main branch and pick him from behind when he comes back. Then {spell:2983} away. He is back 8 1/2 minutes after a death."] = "{npc:6909} (sátiro de nível 12) fica num grande galho ao norte de {area:264}: passe pela abertura em V na parede ao norte da clareira e siga pelo galho. Bata a carteira dele para pegar o diário; matá-lo não dá o diário, e uma luta faz aparecer três Lacaios de Sethir. Ele anda entre o galho principal e um galho lateral: espere em furtividade na ponta do galho principal e bata a carteira dele pelas costas quando ele voltar. Depois use {spell:2983} para sair. Ele volta 8 minutos e meio depois de morrer.",
	-- {item:7737} Sethir's Journal
	["Pick Pocket Sethir the Ancient for {item:7737}"] = "{item:7737}: bata a carteira de Sethir, o Antigo",

	-- Step 12: Back to Syurna
	-- {npc:4163} Syurna
	["Back to {npc:4163}"] = "De volta a {npc:4163}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:3599}, the rogue trainer in {area:186}, gives you a rose for {npc:4163} in {zone:1457}."] = "No nível 10, {npc:3599}, o instrutor de ladinos em {area:186}, dá a você uma rosa para {npc:4163} em {zone:1457}.",
	-- ["At 10 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}."] = "No nível 10, {npc:917}, o instrutor de ladinos na Estalagem Orgulho do Leão em {area:87}, dá a você um pacote para {npc:332} em {zone:1453}.",
	-- ["Ride north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Cavalgue para o norte até {zone:1453}; Mestre Mathias Shaw está na AVIN, em {object:2100}.",
	-- ["Ride west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "Cavalgue para oeste até {zone:1457}. {npc:4163} fica no noroeste da cidade.",
	-- ["The {npc:6846} stands by the river at Elwynn's southern edge, south of {area:87}. He carries the shipping schedule."] = "O {npc:6846} fica junto ao rio, na borda sul da Floresta de Elwynn, ao sul de {area:87}. Ele leva a programação de embarques.",
	-- ["{npc:5165} stands in the north of {zone:1455}."] = "{npc:5165} fica no norte de {zone:1455}.",
	-- ["{npc:6886} waits near {area:133}, in western {zone:1426}."] = "{npc:6886} espera perto de {area:133}, no oeste de {zone:1426}.",
	-- ["{npc:6909} lives in the north of {zone:1438}, north-east of {zone:1457}. Take his journal."] = "{npc:6909} vive no norte de {zone:1438}, a nordeste de {zone:1457}. Pegue o diário dele.",
}
