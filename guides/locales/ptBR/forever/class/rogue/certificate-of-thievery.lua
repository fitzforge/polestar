-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/certificate-of-thievery (forever/class/rogue/certificate-of-thievery.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6966} Lucius · {quest:2282} Alther's Mill · {quest:2300} SI:7
	["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "Seu primeiro serviço de arrombamento no nível 16: o cofre de {npc:6966} em {quest:2282}, para a {quest:2300}.",

	-- Step 1: SI:7 (Goldshire)
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:6946} Renzik "The Shiv" · {zone:1453} Stormwind
	["At 16 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}. Taking it shuts out the other towns' breadcrumbs."] = "No nível 16, {npc:917}, o instrutor de ladino no andar de cima da Estalagem Orgulho do Leão, em {area:87}, manda você para {npc:6946}, em {zone:1453}. Pegar esta fecha as indicações das outras cidades.",

	-- Step 2: To Hulfdan! (Kharanos)
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge · {object:32383} Forlorn Cavern
	["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165} in {zone:1455}'s {object:32383}."] = "No nível 16, {npc:1234}, na {area:2102}, em {area:131}, manda você para {npc:5165}, na {object:32383} de {zone:1455}.",

	-- Step 3: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["{npc:5165} is in the house with a shady dealer outside, in the {object:32383}, down the stairs. Then fly or take the {area:2257} to {zone:1453}."] = "{npc:5165} fica na casa com um negociante suspeito do lado de fora, na {object:32383}, descendo as escadas. Depois voe ou pegue o {area:2257} até {zone:1453}.",

	-- Step 4: Erion Shadewhisper (Dolanaar)
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {quest:2259} Erion Shadewhisper · {zone:1457} Darnassus
	["At 16 {npc:3599} in the {area:186} inn sends you to {quest:2259} in {zone:1457}."] = "No nível 16, {npc:3599}, na estalagem de {area:186}, manda você para {quest:2259}, em {zone:1457}.",

	-- Step 5: Erion Shadewhisper
	-- {npc:4214} Erion Shadewhisper · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor
	["{npc:4214} stands in the {area:1658}. Then the boat from {area:702} to {area:442}, and the boat from {area:442} to {area:17203}."] = "{npc:4214} fica em {area:1658}. Depois pegue o barco de {area:702} até {area:442} e o barco de {area:442} até {area:17203}.",

	-- Step 6: Renzik "The Shiv"
	-- {npc:6946} Renzik "The Shiv" · {quest:2300} SI:7 · {object:2100} Old Town · {spell:1804} Pick Lock · {npc:13283} Lord Tony Romano
	["{npc:6946} stands upstairs in the {quest:2300} building in {object:2100}, behind the rogue trainers. Before you leave: if you lack {spell:1804}, {npc:13283} in the {quest:2300} building teaches it; Lockpicking is the test of the next quest."] = "{npc:6946} fica no andar de cima do prédio de {quest:2300}, em {object:2100}, atrás dos instrutores de ladino. Antes de sair: se você não tem {spell:1804}, {npc:13283}, no prédio de {quest:2300}, ensina; Arrombamento é o teste da próxima missão.",

	-- Step 7: Lucius
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {npc:6966} Lucius · {item:5060} Thieves' Tools · {npc:3090} Gerald Crawley · {spell:1804} Pick Lock
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} stands on a crate on one of the {area:69} docks, south of town; he gives you {item:5060} with the job ({npc:3090} in {area:69} sells more). {spell:1804} does not work without the tools in your bags."] = "Vá para o leste, atravessando {zone:1429}, até Cristarrubra, ou voe para {area:69}. {npc:6966} fica em cima de um caixote numa das docas de {area:69}, ao sul da cidade; ele entrega {item:5060} junto com o trabalho ({npc:3090}, em {area:69}, vende mais). {spell:1804} não funciona sem as ferramentas nas suas bolsas.",

	-- Step 8: Alther's Mill
	-- {quest:2282} Alther's Mill · {area:69} Lakeshire · {object:121264} Lucius's Lockbox
	["{quest:2282} stands east of {area:69}, up off the road; Blackrock orcs roam near it. Inside, the Practice Lockboxes come back almost at once: pick them until {object:121264} opens for you (about 25 Lockpicking). Your Lockpicking cap rises 5 per level, so a low character may stall. Some boxes are trapped (a frost trap, for one); the skill still goes up. On Forever level 20 spiders wander near the boxes: clear them first or bring a friend. The lockbox always holds the token and is back two seconds after use. Practise on while it still gives skill: the next class quest needs about 75."] = "{quest:2282} fica a leste de {area:69}, subindo a partir da estrada; orcs da Rocha Negra rondam por perto. Lá dentro, os Cofres de Treino voltam quase na hora: arrombe-os até {object:121264} abrir para você (cerca de 25 de Arrombamento). O teto do seu Arrombamento sobe 5 por nível, então um personagem de nível baixo pode travar. Alguns cofres têm armadilha (uma armadilha de gelo, por exemplo); a habilidade sobe do mesmo jeito. No Forever, aranhas de nível 20 andam perto dos cofres: limpe-as primeiro ou leve um amigo. O cofre sempre guarda a ficha e volta dois segundos depois de usado. Continue treinando enquanto ainda der perícia: a próxima missão de classe pede cerca de 75.",

	-- Step 9: Back to Lucius
	-- {npc:6966} Lucius
	["Back to {npc:6966}"] = "De volta a {npc:6966}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165}, in the north of {zone:1455}."] = "No nível 16, {npc:1234}, na {area:2102} em {area:131}, envia você a {npc:5165}, no norte de {zone:1455}.",
	-- ["At 16 {npc:3599} in {area:186} sends you to {quest:2259} in {zone:1457}."] = "No nível 16, {npc:3599}, em {area:186}, envia você a {quest:2259} em {zone:1457}.",
	-- ["At 16 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}."] = "No nível 16, {npc:917}, o instrutor de ladinos na Estalagem Orgulho do Leão, em {area:87}, envia você a {npc:6946} em {zone:1453}.",
	-- ["Ride east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} waits on the west side of {area:69} and gives you {item:5060}."] = "Siga para o leste por {zone:1429} até as Montanhas Cristarrubra, ou voe até {area:69}. {npc:6966} espera no lado oeste de {area:69} e dá a você {item:5060}.",
	-- ["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "Seu primeiro serviço de arrombamento no nível 16: o cofre de {npc:6966} em {quest:2282}, para a {quest:2300}.",
	-- ["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}."] = "{npc:6946} fica ao lado de {npc:332} na {quest:2300}, em {object:2100}. Anões e Gnomos pegam o {area:2257} em {zone:1455}; Elfos Noturnos pegam o Barco de {area:442} para {area:17203}.",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there."] = "{quest:2282} fica a leste de {area:69}, acima da estrada. Abra o {object:121264} lá.",
}
