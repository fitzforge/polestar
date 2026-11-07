-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/imp-alliance (forever/class/warlock/imp-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Alliance)"] = "Diabrete (Aliança)",
	["Your first demon at level 1-4: the imp, from your start zone's warlock trainer."] = "Seu primeiro demônio no nível 1-4: o diabrete, com o instrutor de bruxo da sua zona inicial.",

	-- Step 1: Drusilla La Salle (Humans)
	-- {npc:459} Drusilla La Salle
	["{npc:459} (Humans)"] = "{npc:459} (Humanos)",
	-- {item:9576} Tainted Letter · {npc:197} Marshal McBride · {npc:459} Drusilla La Salle · {area:24} Northshire Abbey
	["Your first letter ({item:9576}, from {npc:197} after Kobold Camp Cleanup) points you to {npc:459}, the warlock trainer in the little graveyard beside {area:24}. She asks for a book the Defias stole."] = "Sua primeira carta ({item:9576}, de {npc:197} depois de Limpeza no acampamento dos kobolds) leva você a {npc:459}, a instrutora de bruxo no cemitériozinho ao lado de {area:24}. Ela pede um livro que os Défias roubaram.",

	-- Step 2: The Stolen Books
	-- {object:83763} Stolen Books
	["The {object:83763}"] = "{object:83763}",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["The Defias tent stands in the vineyard east of the Abbey. The book is small: it lies on the ground just right of the tent's opening, beside a blue jug. Three Defias Thugs (level 3-4) guard the tent; pull them one at a time, or step inside the tent and click the book, where they cannot reach you. The book respawns three minutes after someone takes it."] = "A tenda dos Défias fica no vinhedo a leste da Abadia. O livro é pequeno: está no chão, logo à direita da abertura da tenda, ao lado de uma jarra azul. Três Capangas Défias (nível 3-4) guardam a tenda; puxe um de cada vez, ou entre na tenda e clique no livro, onde eles não alcançam você. O livro volta três minutos depois de alguém pegá-lo.",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}, from the {object:83763}"] = "{item:6785}, de {object:83763}",

	-- Step 3: Summon Imp
	-- {npc:459} Drusilla La Salle · {spell:688} Summon Imp
	["{npc:459} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:459} ensina {spell:688} na entrega: invoque na hora, não custa nada e luta ao seu lado.",

	-- Step 4: Alamar Grimm (Gnomes)
	-- {npc:460} Alamar Grimm
	["{npc:460} (Gnomes)"] = "{npc:460} (Gnomos)",
	-- {item:9577} Tainted Memorandum · {npc:658} Sten Stoutarm · {npc:460} Alamar Grimm · {area:77} Anvilmar
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Your first letter ({item:9577}, from {npc:658} after Dwarven Outfitters) points you to {npc:460}, the warlock trainer upstairs inside {area:77}. He asks for three Feather Charms."] = "Sua primeira carta ({item:9577}, de {npc:658} depois de Provedores enânicos) leva você a {npc:460}, o instrutor de bruxo no andar de cima de {area:77}. Ele pede três Patuás de Penas.",

	-- Step 5: Feather Charms
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Feather Charms"] = "Patuás de Penas",
	-- {area:77} Anvilmar · {area:132} Coldridge Valley
	-- plural, as words: Frostmane Novices = {npc:946} Frostmane Novice
	["The Frostmane Novices (level 3-4) sit at the back of the troll cave south of {area:77}, near Grek'nir the Cold by the icy pool: take the left tunnel past the entrance. Four kills in five drop a charm, but only two or three novices spawn, so you may wait out their three-minute respawn. They throw frostbolts from range; the Troll Whelps at the cave mouth jump anyone who passes. With the charms, your hearthstone takes you straight back: a new character's is set to {area:132}."] = "Os Noviços Jubafria (nível 3-4) ficam no fundo da caverna dos trolls ao sul de {area:77}, perto de Grek'nir, o Frio, junto à lagoa gelada: pegue o túnel da esquerda depois da entrada. Quatro mortes em cinco soltam um patuá, mas só dois ou três noviços aparecem, então você pode ter de esperar os três minutos de reaparecimento. Eles jogam setas de gelo à distância; os Filhotes de Troll na boca da caverna atacam quem passa. Com os patuás, sua Pedra de Regresso leva você direto de volta: a de um personagem novo está definida para {area:132}.",

	-- Step 6: Summon Imp
	-- {npc:460} Alamar Grimm · {spell:688} Summon Imp
	["{npc:460} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:460} ensina {spell:688} na entrega: invoque na hora, não custa nada e luta ao seu lado.",
}
