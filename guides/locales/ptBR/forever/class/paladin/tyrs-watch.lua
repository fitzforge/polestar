-- Portuguese (Brazil) (ptBR): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328} (Forsaken)"] = "Vigília de Tyr e {spell:7328} (Renegados)",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328} para reerguer aliados caídos, além de uma arma e um escudo para um novo paladino Renegado.",

	-- Step 1: Aramis Hammerhand
	-- {npc:1569} Shadow Priest Sarvis · {item:282423} Consecrated Scroll · {quest:364} The Mindless Ones · {npc:244808} Aramis Hammerhand · {npc:259377} Injured Deathguard · {area:154} Deathknell · {spell:635} Holy Light
	["{npc:1569} gives you a {item:282423} after {quest:364}: read it, then bring it to {npc:244808} by the church. He asks you to heal five {npc:259377} lying around {area:154}. {spell:635} hurts a Forsaken paladin a little each time: watch your health."] = "{npc:1569} dá um {item:282423} depois de {quest:364}: leia-o e leve-o a {npc:244808}, junto à igreja. Ele pede que você cure cinco {npc:259377} caídos em volta de {area:154}. {spell:635} machuca um pouco um paladino Renegado a cada uso: cuidado com a sua vida.",
	-- {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Heal 5 {npc:259377} with {spell:635}"] = "Cure 5 {npc:259377} com {spell:635}",

	-- Step 2: Coming to Terms
	-- {npc:244808} Aramis Hammerhand · {npc:246143} Frightened Paladin
	["At 4 {npc:244808} sends you after a {npc:246143} who fled into the hills west of the church, just south of the bat cave. Talk to her to offer aid: she turns on you, and you have to put her down (level 3, easy)."] = "No nível 4, {npc:244808} manda você atrás de uma {npc:246143} que fugiu para as colinas a oeste da igreja, logo ao sul da caverna dos morcegos. Fale com ela para oferecer ajuda: ela se vira contra você, e você precisa derrubá-la (nível 3, fácil).",
	-- {npc:246143} Frightened Paladin
	["Talk to the {npc:246143}, then defeat her"] = "Fale com a {npc:246143} e depois derrote-a",

	-- Step 3: Shari Stilwell
	-- {area:154} Deathknell · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road east out of {area:154} to {area:159}. {npc:246152}, the paladin trainer, stands in town; she trains you from here on."] = "Siga a estrada para leste, saindo de {area:154}, até {area:159}. {npc:246152}, a instrutora de paladino, fica na vila; ela treina você daqui em diante.",

	-- Step 4: A Second Home
	-- {npc:246152} Shari Stilwell · {area:159} Brill · {quest:91317} The Tarnished · {area:16881} Shadowvale
	["At 8 {npc:246152} in {area:159} sends you to the order's keep on the west coast. {quest:91317} in {area:16881} and the crypt under it hit hard at 8-9: come at 10 or later."] = "No nível 8, {npc:246152}, em {area:159}, manda você à fortaleza da ordem na costa oeste. {quest:91317} em {area:16881} e a cripta embaixo batem forte no nível 8-9: venha no 10 ou depois.",

	-- Step 5: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {npc:267009} Hadric Harlson · {area:159} Brill
	["{area:16602} stands on the bluffs north-west of the {area:156} (the road west starts near 29,46). {npc:246349} waits at the gate. {npc:246389}, the keep's trainer, and {npc:259190}, its stable master, stand at the forest's edge just south of him. They only have work for you from level 10 and after {quest:96896} from Leonid at the keep, the end of {npc:267009}'s chain that starts south-east of {area:159}; take their quests when you see them."] = "{area:16602} fica nos penhascos a noroeste de {area:156} (a estrada para o oeste começa perto de 29,46). {npc:246349} espera no portão. {npc:246389}, o instrutor da fortaleza, e {npc:259190}, o mestre de estábulos, ficam na beira da floresta logo ao sul dele. Eles só têm trabalho para você a partir do nível 10 e depois de {quest:96896}, com Leonid na fortaleza, o fim da cadeia de {npc:267009} que começa a sudeste de {area:159}; pegue as missões deles quando os vir.",

	-- Step 6: Murlocs at the Gates
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs (level 9-11) lurk on the bluffs along the road east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "Os murlocs Pinavil (nível 9-11) espreitam nos penhascos ao longo da estrada a leste da fortaleza e nos acampamentos em volta do lago a sudoeste, no caminho de descida para {area:16881}.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers x8"] = "Atacantes Pinavil x8",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers x8"] = "Videntes Pinavil x8",

	-- Step 7: Touring the Grounds
	-- {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:246394} Ander Solliden · {npc:246393} Jorin Croge · {npc:246378} Danitha Morr
	["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246394}, the lookout, who walks the road south-east of the keep, then {npc:246393} and {npc:246378} inside the keep. Pick the conversation option with each."] = "{npc:246349} dá uma arma e depois manda você dar uma volta pela fortaleza para falar com quatro pessoas: {npc:246389}, logo ao sul do portão, {npc:246394}, o vigia, que anda pela estrada a sudeste da fortaleza, e depois {npc:246393} e {npc:246378}, dentro da fortaleza. Escolha a opção de conversa com cada um.",
	-- {npc:246349} Breton Samuels · {item:246164} Skullthumper · {item:246165} Driftwood Smasher
	["{npc:246349}: {item:246164} or {item:246165}"] = "{npc:246349}: {item:246164} ou {item:246165}",

	-- Step 8: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge · {quest:91317} The Tarnished
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it. {quest:91317} need level 9."] = "{npc:246378} lidera a ordem de dentro da fortaleza; {npc:246393} fica ao lado. {quest:91317} pede nível 9.",

	-- Step 9: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {npc:259431} Rudolph Gelhardt
	["{quest:91317} (level 8-9) hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. Commander {npc:259431} (level 10) stands on the upper floor of a house, with Drudges below him: clear the ground floor first."] = "{quest:91317} (nível 8-9) ocupam a aldeia em ruínas de {area:16881}, em {area:16616}, a sudoeste da fortaleza. O comandante {npc:259431} (nível 10) fica no andar de cima de uma casa, com Labutadores embaixo: limpe o térreo primeiro.",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges x8"] = "Labutadores Manchados x8",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots x6"] = "Zelotes Manchados x6",

	-- Step 10: The crypt under Shadowvale
	-- {area:16881} Shadowvale
	["The crypt under {area:16881}"] = "A cripta embaixo de {area:16881}",
	-- {item:246213} Sturdy Lumber · {npc:260396} Whispering Horror
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["The cellar is under the village, not on the surface: the way down is inside a burned-out house, where the arrow points. Twelve Lumber Piles (stacked beams) lie in the cellar, each good for one {item:246213}. {npc:260396}, an elite (level 11-13), sits at the far end: leave it alone."] = "O porão fica embaixo da aldeia, não na superfície: a descida é dentro de uma casa queimada, para onde a seta aponta. Doze pilhas de lenha (vigas empilhadas) ficam no porão, cada uma rende uma {item:246213}. {npc:260396}, um elite (nível 11-13), fica no fundo: deixe-o em paz.",
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["Lumber Piles, in the cellar: the way down is here"] = "Pilhas de lenha, no porão: a descida é aqui",

	-- Step 11: Hilda the Breaker's bones
	-- {npc:246389} Hilda the Breaker
	["{npc:246389}'s bones"] = "Os ossos para {npc:246389}",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher · Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["The Shadowvale Lurchers and Mystics (level 8-10) in the crypt drop the Faintly Glowing Bones: about one in two from Lurchers, more from one kind of Mystic, less from the other."] = "Os Saltadores e Místicos do Vale das Sombras (nível 8-10) da cripta deixam cair os Ossos Levemente Brilhantes: mais ou menos um em dois dos Saltadores, mais de um tipo de Místico e menos do outro.",
	-- plural, as words: Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["Faintly Glowing Bones x6"] = "Ossos Levemente Brilhantes x6",

	-- Step 12: Ephram Barbaro's crystal
	-- {npc:259190} Ephram Barbaro
	["{npc:259190}'s crystal"] = "O cristal para {npc:259190}",
	-- {item:286269} Glowing Crystal Fragment
	["The {item:286269}, a green crystal, lies on the floor in the left-hand part of the crypt."] = "O {item:286269}, um cristal verde, está no chão na parte esquerda da cripta.",

	-- Step 13: Back to the keep
	["Back to the keep"] = "Volte à fortaleza",
	-- {npc:246378} Danitha Morr · {npc:259431} Rudolph Gelhardt
	["{npc:246378} hands you {npc:259431}'s head for Sylvanas: keep it in your bags, it is what you hand in."] = "{npc:246378} entrega a cabeça de {npc:259431} para a Sylvana: guarde nas bolsas, é ela que você entrega.",

	-- Step 14: Hilda the Breaker
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190} wait at the forest's edge south of the gate."] = "{npc:246389} e {npc:259190} esperam na beira da floresta, ao sul do portão.",

	-- Step 15: Ephram Barbaro
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker
	["{npc:259190} waits at the forest's edge south of the gate, a few steps west of {npc:246389}."] = "{npc:259190} espera na orla da floresta ao sul do portão, uns passos a oeste de {npc:246389}.",

	-- Step 16: A Lesson in Divinity
	-- {npc:246378} Danitha Morr · {item:2589} Linen Cloth · {zone:1458} Undercity
	["{npc:246378} offers the first Lesson in Divinity at level 12. Bring 10 {item:2589} if you have it: the {zone:1458} asks for it next."] = "{npc:246378} oferece a primeira Lição de Divindade no nível 12. Leve 10 {item:2589} se tiver: {zone:1458} pede em seguida.",

	-- Step 17: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter (no name in this language: may be words) · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter (no name in this language: may be words)
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "Ande para o sul de {area:159} até as {area:153} e desça até a {zone:1458}. {npc:10181} reina no {object:36126}; {npc:257648} mendiga no {object:36078}.",

	-- Step 18: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["{npc:257648} needs 10 {item:2589}. Humanoids drop it: the Scarlet Zealots and Friars of the glades about three kills in ten. The Undercity Auction House sells it too."] = "{npc:257648} precisa de 10 {item:2589}. Humanoides deixam cair: os Zelotes e Frades Escarlates das clareiras mais ou menos três vezes a cada dez. A Casa de Leilões da Cidade Baixa também vende.",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589} x10",

	-- Step 20: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep. If you lose the symbol, {npc:246378} gives you another."] = "De volta a {area:16602}. {npc:246378} entrega o {item:6866}; {npc:257655} espera no andar de baixo da fortaleza. Se perder o símbolo, {npc:246378} dá outro.",
	-- {npc:257655} Deathguard Billmuth
	["{npc:257655}, downstairs"] = "{npc:257655}, no andar de baixo",

	-- Step 21: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["{area:812} is at the far east end of the glades, a long walk. Falgan lies dead among the Scarlet Crusaders there: target his body and use the {item:6866}, then talk to him at once, as he does not stay alive long. If he is already up (another player), just talk to him; if he died again, raise him again."] = "{area:812} fica no extremo leste das clareiras, uma longa caminhada. Falgan jaz morto entre a Cruzada Escarlate ali: selecione o corpo dele e use o {item:6866}, depois fale com ele na hora, pois ele não fica vivo por muito tempo. Se ele já estiver de pé (outro jogador), é só falar com ele; se morreu de novo, ressuscite-o de novo.",

	-- Step 22: The Scarlet attack plans
	["The Scarlet attack plans"] = "Os planos de ataque Escarlates",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["The Scarlet Zealots (level 8-9), Friars (9-10) and Tarnished around {area:812} carry the attack plans. They run for help at low health and respawn in five minutes."] = "Os Zelotes (nível 8-9) e Frades Escarlates (9-10) e os Manchados em volta de {area:812} carregam os planos de ataque. Eles fogem atrás de ajuda com pouca vida e renascem em cinco minutos.",

	-- Step 23: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}, across the whole glades: Billmuth downstairs takes the plans, then {npc:246378}, back upstairs in the keep, teaches you {spell:7328}."] = "De volta a {area:16602}, atravessando as clareiras inteiras: o Billmuth, no andar de baixo, fica com os planos, e depois {npc:246378}, de volta ao andar de cima da fortaleza, ensina {spell:7328}.",
	-- {npc:246378} Danitha Morr · {spell:7328} Redemption
	["{npc:246378}, back upstairs: {spell:7328}"] = "{npc:246378}, de volta ao andar de cima: {spell:7328}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "Volte a {area:16602}. {npc:246378} lhe dá o {item:6866}; {npc:257655} espera no andar de baixo da fortaleza.",
	-- ["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "Volte a {area:16602}: Billmuth fica com os planos, {npc:246378} lhe ensina {spell:7328}.",
	-- ["Tarnished Drudges"] = "Labutadores Manchados",
	-- ["Tarnished Zealots"] = "Zelotes Manchados",
	-- ["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "Os Cruzados Escarlates acampados em volta de {area:812} carregam os planos de ataque.",
	-- ["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "Os murlocs Pinavil espreitam nos penhascos ao longo da estrada a leste da fortaleza e nos acampamentos em volta do lago a oeste.",
	-- ["Tyr's Watch and {spell:7328}"] = "Tyr's Watch e {spell:7328}",
	-- ["Vile Fin Attackers"] = "Atacantes Pinavil",
	-- ["Vile Fin Seers"] = "Videntes Pinavil",
	-- ["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602} fica nos penhascos a noroeste de {area:156}. {npc:246349} espera no portão.",
	-- ["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812} fica no extremo leste das clareiras. Use o {item:6866} em {npc:257663} e fale com ele. Se perder o símbolo, {npc:246378} lhe dá outro.",
	-- ["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "{npc:246152}, que treina paladinos em {area:159}, envia você à fortaleza da ordem no litoral oeste.",
	-- ["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378} lidera a ordem de dentro da fortaleza; {npc:246393} fica ao lado dela.",
	-- ["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378} oferece a primeira missão Uma lição de divindade no nível 12.",
	-- ["{npc:246389} and {npc:259190}"] = "{npc:246389} e {npc:259190}",
	-- ["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648} precisa de 10 {item:2589}. Zelotes Escarlates e Frades Escarlates soltam cerca de três vezes em dez; traga se já tiver.",
	-- ["{object:554626}, in the root cellar"] = "{object:554626}, no porão",
	-- ["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317} ocupam a aldeia em ruínas de {area:16881}, em {area:16616}, a sudoeste da fortaleza. A {item:246213} está empilhada no porão de uma das casas; o comandante {npc:259431} anda entre seus Manchados.",
}
