-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7676} Thistle Tea
	["Ten {item:7676}, the rogue energy drink, from the Horde lockpicking jobs at 16."] = "Dez {item:7676}, a bebida de energia dos ladinos, dos trabalhos de arrombamento da Horda no nível 16.",

	-- Step 1: To Orgrimmar!
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {npc:3401} Shenthul · {zone:1454} Orgrimmar
	["At 16 {npc:3170}, the rogue trainer in {area:362}, sends you to {npc:3401} in {zone:1454}."] = "No nível 16, {npc:3170}, o instrutor de ladinos em {area:362}, manda você até {npc:3401} em {zone:1454}.",

	-- Step 2: Find the Shattered Hand
	-- {npc:6467} Mennet Carkad · {object:36073} Rogues' Quarter (no name in this language: may be words) · {npc:3401} Shenthul · {zone:1454} Orgrimmar · {quest:1998} Fenwick Thatros · {zone:1421} Silverpine Forest
	["At 16 {npc:6467} in the {object:36073} sends you to {npc:3401} in {zone:1454}. Take {quest:1998} from him too; it is done in {zone:1421} at the end of this guide."] = "No nível 16, {npc:6467} no {object:36073} manda você até {npc:3401} em {zone:1454}. Pegue também {quest:1998} com ele; ela é feita em {zone:1421} no fim deste guia.",

	-- Step 3: Shenthul and Zando'zan
	-- {npc:3401} Shenthul · {quest:2379} Zando'zan
	["{npc:3401} and {quest:2379}"] = "{npc:3401} e {quest:2379}",
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words) · {spell:1804} Pick Lock
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}. Train {spell:1804} from {npc:3401} (or any rogue trainer) now if you lack it: this job is a lockpicking test."] = "Mortos-vivos pegam o zepelim das torres fora da {zone:1458} até {zone:1411}. {npc:3401} e {quest:2379} ficam na {object:172960}, o cânion sob o {object:172982}. Aprenda {spell:1804} com {npc:3401} (ou qualquer instrutor de ladino) agora, se não tiver: este serviço é um teste de arrombamento.",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools · {spell:1804} Pick Lock
	["Fly or walk to {area:392} on the {zone:1413} coast. {npc:7161} stands in a small shed near the bank, up the hill to the left before the docks. His Gizmotronic Apparatus beside him hands out what the job needs: take an {item:7970} and {item:5060} ({spell:1804} does not work without the tools in your bags)."] = "Voe ou ande até {area:392}, na costa de {zone:1413}. {npc:7161} fica num galpão pequeno perto do banco, subindo o morro à esquerda antes das docas. O Aparato Gizmotrônico ao lado dele entrega o que o trabalho precisa: pegue {item:7970} e {item:5060} ({spell:1804} não funciona sem as ferramentas nas suas bolsas).",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {object:123462} The Jewel of the Southsea (no name in this language: may be words) · {npc:7168} Polly · {item:7970} E.C.A.C. · {item:7968} Southsea Treasure
	["Follow the coast south from {area:392} to the first beached pirate ship, the Tide Razor, and climb aboard up its bow. On the middle deck the Buccaneer's Strongboxes come back fast: pick them until your Lockpicking is about 30 (a few are trapped with a frost nova or turn you into a rat; picking still works as a rat). Keep picking while they still give skill: the poisons job at 20 ends at a lockbox that needs about 75, and these boxes are the closest practice. Then go down to the bottom hold and pick the lock of {object:123462}: it is empty, but opening it calls a giant level 50 {npc:7168} into the next room. Stay stealthed, put the {item:7970} on your action bar, target {npc:7168} and use it: the parrot shrinks to level 18. Kill it for the {item:7968}."] = "Siga a costa para o sul de {area:392} até o primeiro navio pirata encalhado, o Tide Razor, e suba a bordo pela proa. No convés do meio, as Caixas-fortes dos Bucaneiros voltam rápido: abra-as até o seu Arrombamento chegar a cerca de 30 (algumas têm armadilha de Nova de Gelo ou transformam você em rato; arrombar ainda funciona como rato). Continue abrindo enquanto elas ainda dão habilidade: o serviço dos venenos no nível 20 termina numa caixa trancada que exige cerca de 75, e estas caixas são o treino mais próximo. Depois desça até o porão e arrombe a fechadura de {object:123462}: está vazio, mas abri-lo chama um {npc:7168} gigante de nível 50 para a sala ao lado. Fique furtivo, ponha o {item:7970} na sua barra de ação, selecione {npc:7168} e use-o: o papagaio encolhe para o nível 18. Mate-o para pegar o {item:7968}.",
	-- {item:7968} Southsea Treasure · {npc:7168} Polly · {item:7970} E.C.A.C.
	["{item:7968}: {npc:7168}, after the {item:7970}"] = "{item:7968}: {npc:7168}, depois de {item:7970}",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "De volta a {npc:7161}",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161}: dez {item:7676}",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:1338} Lordamere Lake · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and head south into Silverpine. {quest:1998} (level 16) stands alone on the old ferry dock on {area:1338}, north-east of the {area:228}. His Uppercut knocks you back, so do not fight him at the dock's edge. He always drops his head and is back 4 1/2 minutes after a death."] = "Pegue o zepelim de {zone:1454} até a {zone:1458} e siga para o sul, rumo a Pinhaprata. {quest:1998} (nível 16) fica sozinho na velha doca da balsa em {area:1338}, a nordeste da {area:228}. O Golpe Ascendente dele empurra você para trás, então não lute com ele na beira da doca. Ele sempre solta a cabeça e volta 4 minutos e meio depois de morrer.",

	-- Step 8: Mennet Carkad
	-- {item:5060} Thieves' Tools · {npc:6566} Estelle Gendry · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["If you have no {item:5060} left, ask {npc:6566}, the outfitter in the {object:36073}."] = "Se você não tiver mais {item:5060}, peça a {npc:6566}, a fornecedora no {object:36073}.",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox · {item:5060} Thieves' Tools
	["The Kirin Tor keep their reports in walled {area:233}, in south-east Silverpine. Facing the town hall, take the building on the right: the {object:103815} is in a corner room upstairs (any Lockpicking opens it; the {item:5060} must be in your bags). Three casters of level 19-20 guard that floor and see through stealth, one walking in and out of the strongbox room: time it or fight them one at a time."] = "O Kirin Tor guarda os relatórios em {area:233}, cercada de muros, no sudeste de Pinhaprata. De frente para a prefeitura, entre no prédio da direita: {object:103815} fica num quarto de canto no andar de cima (qualquer Arrombamento abre; {item:5060} precisa estar nas suas bolsas). Três conjuradores de nível 19-20 guardam aquele andar e enxergam através da furtividade, e um deles entra e sai da sala do cofre: marque o tempo ou lute com eles um de cada vez.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "De volta a {npc:6467}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Voe ou cavalgue até {area:392}, no litoral dos {zone:1413}. {npc:7161} fica na cidade com seu Aparato Mercadotrônico: compre um {item:7970} e {item:5060} no aparato antes de ir.",
	-- ["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "Ao sul pelo litoral a partir de {area:392}, no acampamento dos piratas dos Mares do Sul. Se um papagaio estranhamente hostil atacar você, use o {item:7970} nele (o conselho da própria missão).",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Pegue o zepelim de {zone:1454} para {zone:1458} e cavalgue para o sul até a Floresta de Pinhaprata. {quest:1998} fica a nordeste de {area:228}.",
	-- ["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "O Kirin Tor guarda seus relatórios em {area:233}, no sudeste da Floresta de Pinhaprata: arrombe a fechadura do {object:103815}.",
	-- ["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "Mortos-vivos pegam o zepelim nas torres do lado de fora de {zone:1458} para {zone:1411}. {npc:3401} e {quest:2379} ficam na {object:172960}, o cânion abaixo do {object:172982}.",
}
