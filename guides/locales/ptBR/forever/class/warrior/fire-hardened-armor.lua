-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "Armadura Endurecida pelo Fogo",
	["Starts now at 20 with a shield; a hauberk at 28, then a coif, leggings and gauntlets from three smiths."] = "Começa agora no nível 20, com um escudo; uma cota no 28, depois uma coifa, perneiras e manoplas de três ferreiros.",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {quest:1698} in Redridge."] = "No nível 20, {npc:5479}, ao lado de {npc:5480}, no prédio dos instrutores de guerreiro de {object:2100}, manda você para {quest:1698}, em Cristarrubra.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "No nível 20, {npc:5113}, o instrutor de guerreiros de {zone:1455}, envia você a {quest:1698} nas Montanhas Cristarrubra.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "No nível 20, {npc:7315}, o instrutor de guerreiros de {zone:1457}, envia você a {quest:1698} nas Montanhas Cristarrubra.",

	-- Step 4: Yorus Barleybrew
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} sits in the inn at {area:69}. His test is timed: before you take it, clear the Redridge gnolls on the path to the {area:98} in the hills north-west of {area:69}, including the two on the rock by the cave mouth (climb it from its right side)."] = "{quest:1698} fica na estalagem de {area:69}. A prova dele tem tempo: antes de pegar, limpe os gnolls de Cristarrubra no caminho para {area:98}, nas colinas a noroeste de {area:69}, inclusive os dois na pedra junto à boca da caverna (suba pelo lado direito dela).",

	-- Step 5: The Rethban Gauntlet
	-- {npc:6166} Yorus Barleybrew · {spell:8553} Barleybrew Scalder · {area:98} Rethban Caverns · {area:69} Lakeshire
	["You have one hour, and {npc:6166}'s {spell:8553} leaves you drunk for 8-10 minutes. Run north-west into the {area:98}, keeping close to the cliff wall to miss most gnoll packs, and go in as far as the first fork; then come back to {npc:6166} (from the ridge you can jump down into {area:69}). Dying and releasing your spirit fails the quest: abandon it and {npc:6166} gives it again."] = "Você tem uma hora, e {spell:8553} de {npc:6166} deixa você bêbado por 8 a 10 minutos. Corra para noroeste até {area:98}, rente à parede do penhasco para evitar a maioria dos grupos de gnolls, e entre até a primeira bifurcação; depois volte a {npc:6166} (da crista dá para pular até {area:69}). Morrer e liberar o espírito faz a missão falhar: abandone e {npc:6166} entrega de novo.",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "Entre em {area:98} e volte",

	-- Step 6: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {npc:6166} Yorus Barleybrew · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail · {item:6842} Furen's Instructions
	["{npc:5413} works in the Dwarven District of Stormwind. He takes the {item:6843} (lost it? abandon the quest and {npc:6166} gives a new one) and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest, with {item:6842} listing what it needs."] = "{npc:5413} trabalha no Distrito dos Anões de Ventobravo. Ele pega {item:6843} (perdeu? abandone a missão e {npc:6166} entrega uma nova) e entrega {item:6970}, um escudo; {quest:1701} é uma missão de nível 28, e {item:6842} lista o que ela precisa.",

	-- Step 7: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "Presas de Aranha Calcinadas",
	-- {zone:1437} Wetlands · {area:836} Dun Algaz
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["You need 50 fangs. The Leech Stalkers and Cave Stalkers (level 21-22) crawl in the middle of the {zone:1437}, north of {area:836}; every one drops a fang. They poison; back in 5 minutes."] = "Você precisa de 50 presas. As Espreitadoras Sanguessuga e Espreitadoras da Caverna (nível 21-22) rastejam no meio de {zone:1437}, ao norte de {area:836}; todas soltam uma presa. Elas envenenam; voltam em 5 minutos.",

	-- Step 8: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "Chifres Calcinados e Galvanizados",
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch · {spell:3396} Corrosive Poison · {spell:403} Lightning Bolt · {area:467} Stonetalon Peak
	-- plural, as words: Charred Horns = {item:6839} Charred Horn · Young Chimaeras = {npc:4032} Young Chimaera
	["The chimaeras live south-west of {area:460} in the {area:465}: you need 12 Charred Horns from the Fledgling (level 25-27) and Young Chimaeras (23-25), four kills in five, and the {item:6840} from the {npc:6167} (28, the big one), also four in five. Only three Fledglings, two Young and one Matriarch live there, each back in 5 minutes, so expect to wait. Fledglings and the Matriarch spit {spell:3396}, the Young cast {spell:403}. Alliance: fly to {area:467} and head south."] = "As quimeras vivem a sudoeste de {area:460}, em {area:465}: você precisa de 12 Chifres Calcinados das Quimeras Filhotes (nível 25-27) e Jovens (23-25), quatro mortes em cinco, e de {item:6840} de {npc:6167} (28, a grande), também quatro em cinco. Só vivem lá três Filhotes, duas Jovens e uma Matriarca, cada uma volta em 5 minutos, então você vai ter de esperar. Os Filhotes e a Matriarca cospem {spell:3396}, as Jovens lançam {spell:403}. Aliança: voe para {area:467} e siga para o sul.",
	-- {item:6839} Charred Horn
	["{item:6839}, from the young chimaeras"] = "{item:6839}, das quimeras jovens",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, de {npc:6167}",

	-- Step 9: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Rugug em {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, and his guards come with him. Inside take the left path at the first fork, cross the root bridge, go past the big empty cauldron: he is in a dead end on the right, with about ten elites on the way. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "Rugug é um quilboar elite (nível 28) dentro de {area:1717}, a masmorra no extremo sul de {zone:1413}; uma masmorra para cinco jogadores: precisa de um grupo de cinco, e os guardas dele vêm junto. Lá dentro, pegue o caminho da esquerda na primeira bifurcação, atravesse a ponte de raízes e passe pelo caldeirão grande vazio: ele fica num beco sem saída à direita, com uns dez elites no caminho. Ele lança {spell:403} e chama Estrondores da Terra. O frasco sempre cai.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, de Rugug",

	-- Step 10: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027} for the hauberk. He then sends you to the smith of your race; the other two smiths' pieces are open to you as well: talk to them directly."] = "De volta a {npc:5413}, no {object:28027}, para pegar a couraça. Ele manda você depois para o ferreiro da sua raça; as peças dos outros dois ferreiros também estão abertas a você: fale direto com eles.",

	-- Step 11: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {object:28027} Dwarven District · {npc:5413} Furen Longbeard · {quest:1705} Burning Blood · {item:6845} Burning Rock
	["{npc:1416} keeps the weapon shop in the north-west of the {object:28027}, a short walk from {npc:5413}. He wants 20 {quest:1705} and the {item:6845}."] = "{npc:1416} cuida da loja de armas no noroeste do {object:28027}, a uma curta caminhada de {npc:5413}. Ele quer 20 {quest:1705} e {item:6845}.",

	-- Step 12: Burning Blood
	-- {zone:1431} Duskwood · {area:42} Darkshire · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock · {area:2161} Roland's Doom · {spell:3427} Infected Wound
	["The Nightbane worgen of {zone:1431} (Dark Runners, Vile Fangs, Shadow Weavers, Worgen and Tainted Ones, level 26-31) south and west of {area:42} drop the {quest:1705} four kills in five. {npc:6170} (level 32, not elite) carries the {item:6845} (also four in five): he walks between the inside and the mouth of the {area:2161} mine south-east of {area:42}, so wait at the entrance and pull him outside. {npc:6170} and the Tainted Ones poison and howl; Vile Fangs cause {spell:3427}."] = "Os worgen Nightbane de {zone:1431} (Corredores das Trevas, Presas Vis, Tecelões das Sombras, Worgen e Maculados, nível 26-31) ao sul e oeste de {area:42} soltam {quest:1705} em quatro de cada cinco mortes. {npc:6170} (nível 32, não elite) carrega {item:6845} (também quatro em cinco): ele anda entre o interior e a boca da mina de {area:2161}, ao sudeste de {area:42}, então espere na entrada e puxe-o para fora. {npc:6170} e os Maculados envenenam e uivam; as Presas Vis causam {spell:3427}.",
	-- {quest:1705} Burning Blood
	["{quest:1705}, from the Nightbane worgen"] = "{quest:1705}, dos worgen Nightbane",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845}, from {npc:6170}"] = "{item:6845}, de {npc:6170}",

	-- Step 14: Mathiel
	-- {quest:1703} Mathiel · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {quest:1710} Sunscorched Shells
	["{quest:1703} works on the south side of the {area:1660} in {zone:1457}. He wants 20 {quest:1710}."] = "{quest:1703} trabalha no lado sul de {area:1660}, em {zone:1457}. Ele quer 20 {quest:1710}.",

	-- Step 15: Sunscorched Shells
	-- {area:482} Highperch · {zone:1441} Thousand Needles
	-- plural, as words: Highperch Wyverns = {npc:4107} Highperch Wyvern
	["The shells lie on the ground under the wyvern nests at {area:482} in western {zone:1441}, deeper into the gorge. Only nine exist and each returns 3 minutes after you pick it, so you will wait; some shell-like things there cannot be looted. Highperch Wyverns (level 28-31) guard them and sometimes come several at once."] = "As cascas ficam no chão embaixo dos ninhos de mantícoras em {area:482}, no oeste de {zone:1441}, mais fundo no desfiladeiro. Só existem nove e cada uma volta 3 minutos depois de você pegar, então você vai esperar; algumas coisas parecidas com cascas ali não podem ser saqueadas. As Mantícoras de Alcândora (nível 28-31) guardam e às vezes vêm várias de uma vez.",

	-- Step 17: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge · {quest:1704} Klockmort Spannerspan · {object:171524} Tinker Town · {item:6848} Searing Coral
	["Ride the {area:2257} from {zone:1453} to {zone:1455}. {quest:1704}, a gnome smith, works in {object:171524} near the engineering trainers. He wants 20 {item:6848}."] = "Pegue o {area:2257} de {zone:1453} até {zone:1455}. {quest:1704}, um ferreiro gnomo, trabalha em {object:171524}, perto dos instrutores de engenharia. Ele quer 20 {item:6848}.",

	-- Step 18: Iron Coral
	-- {quest:1708} Iron Coral · {area:150} Menethil Harbor · {item:5996} Draught of Water Breathing
	["The {quest:1708} grows on the sea floor just south of {area:150}, by the murloc huts and a wrecked boat: eight there and two south-east of the harbor, each back in 3 minutes, so you will wait for respawns to reach 20. The murlocs can net you underwater: watch your breath, and a {item:5996} removes the risk."] = "{quest:1708} cresce no fundo do mar logo ao sul de {area:150}, junto às cabanas de murlocs e a um barco naufragado: oito ali e dois a sudeste do porto, cada um volta em 3 minutos, então você vai esperar os reaparecimentos para chegar a 20. Os murlocs podem lançar rede em você debaixo d'água: cuide do fôlego, e uma {item:5996} elimina o risco.",
	-- {item:6848} Searing Coral · {quest:1708} Iron Coral
	["{item:6848}, from {quest:1708}"] = "{item:6848}, de {quest:1708}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A hauberk at 28, a coif, leggings and gauntlets from three smiths, and a shield on the way."] = "Uma couraça no nível 28, uma touca, as perneiras e as manoplas de três ferreiros, e um escudo no caminho.",
	-- ["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "Uma cota no nível 28, uma coifa, perneiras ou manoplas conforme a raça, e um escudo no caminho.",
	-- ["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "No nível 20, {npc:5479}, em {object:2100}, ao lado da Porco e Apito, envia você a {quest:1698} nas Montanhas Cristarrubra.",
	-- ["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "Volte a {npc:5413} no {object:28027}. Ele envia você a um ferreiro da sua raça.",
	-- ["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "Pegue o {area:2257} de {zone:1453} para {zone:1455}.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Rugug é um javaliano de Elite dentro de {area:1717}, a Masmorra no extremo sul de {zone:1413}; ele deixa cair o {item:6841}. {area:1717} é uma Masmorra: recomenda-se formar um grupo.",
	-- ["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "As Quimeras Filhotes e Quimeras Jovens vagam pelo sudoeste da Cordilheira das Torres de Pedra, com a {npc:6167} entre elas: as jovens deixam cair o {item:6839}; a Matriarca, o {item:6840}.",
	-- ["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "As Espreitadoras Sanguessugas e Espreitadoras da Caverna rastejam por volta de 46,61, no meio de {zone:1437}; elas deixam cair a {item:6838}.",
	-- ["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "Os worgens Nocturno de {zone:1431} deixam cair o {quest:1705}. {npc:6170} anda no extremo sudeste de {zone:1431} e carrega a {item:6845}.",
	-- ["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "O {quest:1708} cresce ao longo da costa oeste de {zone:1437}, ao sul de {area:150}.",
	-- ["The {quest:1710} lie along the western edge of {zone:1441}."] = "As {quest:1710} ficam ao longo da borda oeste de {zone:1441}.",
	-- ["{item:6839} from the young chimaeras"] = "{item:6839} das quimeras jovens",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840} da {npc:6167}",
	-- ["{item:6845} from {npc:6170}"] = "{item:6845} de {npc:6170}",
	-- ["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416} está em {zone:1453}, a pouca distância de {npc:5413}.",
	-- ["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413} trabalha no Distrito dos Anões de Ventobravo. Ele fica com o {item:6843} e dá a você {item:6970}, um escudo; {quest:1701} é uma missão de nível 28.",
	-- ["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698} está em {area:69}, na estalagem. O teste dele tem tempo: corra para noroeste até {area:98}, chegue à primeira bifurcação e volte a ele antes que o tempo acabe. Não morra nem libere o espírito.",
	-- ["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703} é ferreira em {zone:1457}.",
	-- ["{quest:1705} from the Nightbane worgen"] = "{quest:1705} dos worgens Nocturno",
}
