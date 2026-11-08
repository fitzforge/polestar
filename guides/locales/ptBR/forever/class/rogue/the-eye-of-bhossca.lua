-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/the-eye-of-bhossca (forever/class/rogue/the-eye-of-bhossca.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277246} Ruby-Adorned Blade · {area:796} Scarlet Monastery
	["The {item:277246}, C's payment for a solo job inside the {area:796}."] = "A {item:277246}, o pagamento de C por um serviço solo dentro do {area:796}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "O ponto de entrega de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["C's next job comes by letter: once you are level 30 and have done the horn job, visit any capital city and C's letter arrives in the mailbox; only then does the {object:410369} near {area:204}, in southern Silverpine just south of {area:236}, offer it. The quest data lists a minimum of 25, but players get the letter, and the job, at 30."] = "A próxima missão de C vem por carta: quando você estiver no nível 30 e tiver feito a missão do chifre, visite qualquer capital e a carta de C chega na caixa de correio; só então {object:410369}, perto de {area:204}, no sul de Pinhaprata, logo ao sul de {area:236}, a oferece. Os dados da missão listam um mínimo de 25, mas os jogadores recebem a carta, e a missão, no 30.",

	-- Step 2: The Scarlet Monastery
	-- {area:796} Scarlet Monastery
	["The {area:796}"] = "{area:796}",
	-- {zone:1420} Tirisfal Glades · {spell:427592} Scarlet Initiate's Uniform · {spell:921} Pick Pocket · {npc:4293} Scarlet Scryer · {item:210963} Scryer's Key · {item:210968} Reliquary Key
	["The monastery stands in the far north-east of {zone:1420}. Go in alone, out of any group. Before entering, take the {spell:427592} from the Supply Locker in the stables behind the monastery and wear it; stealth and suspicious actions remove it, so put it back on after each wing change. In the Graveyard, in the Chamber of Atonement (the first big room), {spell:921} a {npc:4293} or Scarlet Crier for the {item:210963}. In the Library, open the Personal Letterbox in the Athenaeum with it and read the Confidential Message. It sends you back to sit on both benches between the two statues in the Graveyard. Watch for the mechanism's messages, then take the {item:210968} from the stone coffer: an elite stands by the coffer with a patrol behind it, but from beside the northern mausoleum you can turn the camera until the box shows and click it through the wall (an interact key works too). An elite ghost walks near the mausoleum; the broken piece at its edge keeps you out of its path. Then return to the Library for the locked reliquary and the eye. Avoid fighting through the instance."] = "O monastério fica no extremo nordeste de {zone:1420}. Entre sozinho, fora de qualquer grupo. Antes de entrar, pegue {spell:427592} no Armário de Suprimentos nos estábulos atrás do monastério e vista-o; furtividade e ações suspeitas o removem, então coloque de volta a cada mudança de ala. No Cemitério, na Câmara da Expiação (a primeira sala grande), use {spell:921} em um {npc:4293} ou Pregoeiro Escarlate para pegar {item:210963}. Na Biblioteca, abra a Caixa de Correio Pessoal no Ateneu com ela e leia a Mensagem Confidencial. Ela manda você de volta para sentar nos dois bancos entre as duas estátuas do Cemitério. Fique atento às mensagens do mecanismo e depois pegue {item:210968} do cofre de pedra: um elite fica ao lado do cofre, com uma patrulha atrás dele, mas, ao lado do mausoléu norte, dá para girar a câmera até a caixa aparecer e clicar nela através da parede (uma tecla de interagir também funciona). Um fantasma elite anda perto do mausoléu; a peça quebrada na borda dele mantém você fora do caminho. Depois volte à Biblioteca para o relicário trancado e o olho. Evite lutar para atravessar a instância.",
	["Solo route: Graveyard key, Library letter, Graveyard benches and coffer, then Library reliquary for the eye. Read the letter before the bench puzzle; check the disguise each time you change wings."] = "Rota solo: chave do Cemitério, carta da Biblioteca, bancos e cofre do Cemitério, depois o relicário da Biblioteca para pegar o olho. Leia a carta antes do enigma dos bancos; confira o disfarce a cada mudança de ala.",

	-- Step 3: Back to the dead drop
	["Back to the dead drop"] = "De volta ao ponto de entrega",
	-- {object:410369} Dead Drop
	["Place the eye in the {object:410369} near Pyrewood. Check a capital mailbox for C's payment letter on your next planned city visit, then return here for the reward quest. The payment may not be available immediately; do not repeat the infiltration just because the reward has not appeared."] = "Coloque o olho em {object:410369} perto de Lenhardente. Olhe a caixa de correio de uma capital, na sua próxima visita planejada à cidade, para ver a carta de pagamento de C, e volte aqui para a missão de recompensa. O pagamento pode não estar disponível na hora; não repita a infiltração só porque a recompensa ainda não apareceu.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the Eye of Bhossca inside the {area:796}."] = "Encontre o Olho de Bhossca dentro do {area:796}.",
	-- ["Place the eye in the {object:410369} near Pyrewood. C's payment is the second Eye of Bhossca quest at the same chest."] = "Coloque o olho no {object:410369} perto de Vilarejo Lenhardente. O pagamento de C é a segunda missão Olho de Bhossca, no mesmo baú.",
	-- ["The monastery stands in the far north-east of {zone:1420}. Go in alone; C advises a disguise from the monastery's grounds before you enter."] = "O monastério fica no extremo nordeste de {zone:1420}. Entre sozinho; C recomenda pegar um disfarce nos arredores do monastério antes de entrar.",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. C's next note waits there once you are 25."] = "O {object:410369} é um baú perto de {area:204}, no sul da Floresta de Pinhaprata, logo ao sul de {area:236}. O próximo bilhete de C espera lá quando você tiver nível 25.",
}
