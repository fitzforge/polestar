-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/staff-or-orb-alliance (forever/class/mage/staff-or-orb-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:9514} Arcane Staff
	["Ley or {item:9514} or Orb (Alliance)"] = "Meridiano ou {item:9514} ou Orbe (Aliança)",
	["A staff or an off-hand orb at 10 from your home town's mage trainer; Skyborne add a wand."] = "Um cajado ou um orbe de mão secundária no nível 10, com o instrutor de mago da sua cidade natal; Celonatos ganham ainda uma varinha.",

	-- Step 1: Anathamaas Aetherwind (Valanaar)
	-- {npc:252373} Anathamaas Aetherwind · {area:16638} Valanaar · {npc:256507} Belann Windwood
	["At 10 {npc:252373}, the {area:16638} mage trainer, sends you to {npc:256507}, the staff merchant a few steps away in the same town."] = "No nível 10, {npc:252373}, o instrutor de mago de {area:16638}, manda você até {npc:256507}, o mercador de cajados a poucos passos, na mesma cidade.",

	-- Step 2: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "As Formações de Pedra Eólica",
	-- {area:16636} Falaath Village
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The bough lies on the ground among the Windstone Formations, the wind shrine on the rise west of Fillion's camp, south of {area:16636}. It does not sparkle, so look at the ground by the stones; there are two spots for it."] = "O ramo está no chão entre as Formações de Pedra Eólica, o santuário do vento no morro a oeste do acampamento do Filião, ao sul de {area:16636}. Ele não brilha, então olhe o chão perto das pedras; ele pode estar em dois lugares.",

	-- Step 3: Back to Belann Windwood
	-- {npc:256507} Belann Windwood
	["Back to {npc:256507}"] = "De volta a {npc:256507}",
	-- {quest:1861} Mirror Lake · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{quest:1861} (the next steps) waits for you with {npc:5497} in {zone:1453}, at about 15."] = "{quest:1861} (as próximas etapas) espera você com {npc:5497}, em {zone:1453}, lá pelo nível 15.",

	-- Step 4: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire · {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {quest:1879} Speak with Bink · {area:131} Kharanos · {quest:1861} Mirror Lake · {npc:5144} Bink
	["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {quest:1879}, the {area:131} trainer's errand; {quest:1861} and {npc:5144}'s Gizmonitor shut out each other, so you get one staff or orb."] = "No nível 10, {npc:328}, o instrutor de mago de {area:87}, no andar de cima da Estalagem Orgulho do Leão, manda você a {npc:5497} em {zone:1453}. Pegar esta fecha {quest:1879}, o recado do instrutor de {area:131}; {quest:1861} e o Treconitor Magostático de {npc:5144} se excluem, então você fica com um cajado ou um orbe.",

	-- Step 5: Magis Sparkmantle (Kharanos)
	-- {npc:1228} Magis Sparkmantle · {area:131} Kharanos · {area:2102} Thunderbrew Distillery · {npc:5144} Bink · {zone:1455} Ironforge · {quest:1860} Speak with Jennea · {area:87} Goldshire · {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake · {npc:328} Zaldimar Wefhellt
	["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {quest:1860}, the {area:87} trainer's errand; {npc:5144}'s Gizmonitor and {npc:5497}'s {quest:1861} shut out each other, so you get one staff or orb. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "No nível 10, {npc:1228}, o instrutor de mago de {area:131}, em {area:2102}, manda você até {npc:5144}, em {zone:1455}. Pegar esta fecha {quest:1860}, o recado do instrutor de {area:87}; o Treconitor Magostático de {npc:5144} e {quest:1861}, de {npc:5497}, se excluem, então você só faz uma missão de cajado ou orbe. (Um Gnomo que pegou a missão de {npc:328} em {area:87} segue as etapas de {quest:1861}; um Humano que pegou esta, as etapas do Treconitor Magostático.)",

	-- Step 6: Jennea Cannon
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5497} Jennea Cannon · {item:7207} Jennea's Flask · {quest:1861} Mirror Lake
	["Follow the road north into {zone:1453} and west to the {object:2101}. {npc:5497} stands at the top of the Wizard's Sanctum, the tall violet tower: climb the spiral ramp and step into the portal near the top, which puts you beside her. She hands you {item:7207}. Skyborne mages take {quest:1861} from her when they first reach {zone:1453}, at about 15."] = "Siga a estrada para o norte até {zone:1453} e para oeste até o {object:2101}. {npc:5497} fica no topo do Sacrário dos Teurgos, a torre violeta alta: suba a rampa em espiral e entre no portal perto do topo, que deixa você ao lado dela. Ela entrega o {item:7207}. Magos Celonatos pegam {quest:1861} com ela quando chegam a {zone:1453} pela primeira vez, lá pelo nível 15.",

	-- Step 7: The Mirror Lake waterfall
	-- {quest:1861} Mirror Lake
	["The {quest:1861} waterfall"] = "A cachoeira do {quest:1861}",
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate and head south-west to the waterfall that feeds {quest:1861}. Wade in under the falling water to the rock behind it and use {item:7207} there (a 5 second cast); it fails anywhere else. Level 10 Defias casters stand on the rocks either side of the falls and shoot from range: pull them one at a time or fill the flask from the water."] = "Saia de {zone:1453} pelo portão principal e siga para sudoeste até a cachoeira que alimenta o {quest:1861}. Entre na água por baixo da queda até a pedra atrás dela e use o {item:7207} ali (5 segundos de conjuração); em qualquer outro lugar falha. Défias lançadores de feitiço de nível 10 ficam nas pedras dos dois lados da cachoeira e atiram de longe: puxe um de cada vez ou encha o frasco de dentro d'água.",
	-- {item:7207} Jennea's Flask
	["{item:7207}, under the falls"] = "{item:7207}, embaixo da cachoeira",

	-- Step 8: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "Volte a {npc:5497}",
	["Back up the Wizard's Sanctum and through the portal. The orb is an off-hand for a one-hand weapon; the staff is a two-hander."] = "Suba de novo o Sacrário dos Teurgos e passe pelo portal. O orbe é mão secundária para quem usa arma de uma mão; o cajado é de duas mãos.",
	-- {npc:5497} Jennea Cannon · {item:7508} Ley Orb · {item:9513} Ley Staff
	["{npc:5497}: {item:7508} or {item:9513}"] = "{npc:5497}: {item:7508} ou {item:9513}",

	-- Step 9: Bink
	-- {npc:5144} Bink · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1455} Ironforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["{npc:5144} teaches mages in the {object:32362}, at the back of {zone:1455} past the {object:32386}."] = "{npc:5144} treina magos na {object:32362}, nos fundos de {zone:1455}, depois do {object:32386}.",

	-- Step 10: Bink's Toolbox
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Head west along the road to {area:133}. Just north of its entrance stand two huts; the toolbox is in the taller, eastern one, the hut with the lift: a small grey box on the ground floor, half under the table beside the lift. Leper Gnomes (level 8) guard the huts: pull them singly. There is only one toolbox and it takes 15 minutes to come back after someone opens it, so wait nearby if it is gone."] = "Siga a estrada para oeste até {area:133}. Logo ao norte da entrada ficam duas cabanas; a caixa de ferramentas está na mais alta, a do leste, a cabana com o elevador: uma caixinha cinza no térreo, meio embaixo da mesa ao lado do elevador. Gnomos Leprosos (nível 8) guardam as cabanas: puxe um de cada vez. Só existe uma caixa de ferramentas e ela leva 15 minutos para voltar depois que alguém abre, então espere por perto se ela tiver sumido.",

	-- Step 11: Back to Bink
	-- {npc:5144} Bink
	["Back to {npc:5144}"] = "De volta a {npc:5144}",
	-- {npc:5144} Bink · {item:7507} Arcane Orb · {item:9514} Arcane Staff
	["{npc:5144}: {item:7507} or {item:9514}"] = "{npc:5144}: {item:7507} ou {item:9514}",

	-- Step 12: Belann Windwood's wand (optional)
	-- {npc:256507} Belann Windwood
	["{npc:256507}'s wand (optional)"] = "A varinha de {npc:256507} (opcional)",
	-- {npc:256507} Belann Windwood · {area:16638} Valanaar · {zone:2521} Zephras Isle · {npc:252373} Anathamaas Aetherwind · {item:262668} Wind-Infused Bough · {area:16636} Falaath Village · {item:263430} Windbough Wand
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["{npc:256507}'s quest is open to Human and Gnome mages too, if you ever visit {area:16638} on {zone:2521}, the Skyborne home: {npc:252373}, the town's mage trainer, sends you to {npc:256507} next door, who wants a {item:262668} from the ground by the Windstone Formations south of {area:16636}, for the {item:263430}. It does not shut out the staff or the orb."] = "A missão de {npc:256507} também vale para magos Humanos e Gnomos, se um dia você visitar {area:16638}, em {zone:2521}, a terra dos Celonatos: {npc:252373}, o instrutor de mago da cidade, manda você até {npc:256507}, ali do lado, que quer um {item:262668} do chão perto das Formações de Pedra Eólica ao sul de {area:16636}, em troca da {item:263430}. Ela não fecha o cajado nem o orbe.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {npc:5144}'s quest in {zone:1455}; you get one staff-or-orb quest."] = "No nível 10, {npc:328}, o instrutor de mago de {area:87}, no andar de cima da estalagem, manda você até {npc:5497}, em {zone:1453}. Pegar esta fecha a missão de {npc:5144} em {zone:1455}; você só faz uma missão de cajado ou orbe.",
}
