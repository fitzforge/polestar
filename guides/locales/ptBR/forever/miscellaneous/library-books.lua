-- Portuguese (Brazil) (ptBR): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386691} Library Book
	["Library Books"] = "Livros da Biblioteca",
	["Lost books and scrolls all over the world: each pays experience at the library, and 10, 20 and 25 of them earn a necklace, a ring and an off-hand."] = "Livros e pergaminhos perdidos pelo mundo todo: cada um dá experiência na biblioteca, e 10, 20 e 25 deles rendem um colar, um anel e uma mão secundária.",

	-- Step 1: Elwynn Forest
	-- {area:91} Tower of Azora · {area:87} Goldshire
	["Halfway up the {area:91}, east of {area:87}. Nothing hostile inside."] = "No meio de {area:91}, a leste de {area:87}. Nada hostil lá dentro.",

	-- Step 2: Westfall
	-- {area:20} Moonbrook · {area:108} Sentinel Hill
	["Two books: one in a house at {area:20}, one at {area:108} (Alliance only)."] = "Dois livros: um numa casa em {area:20}, outro em {area:108} (só Aliança).",
	["Rumi of Gnomeregan"] = "Rumi de Gnomeregan",

	-- Step 3: Duskwood
	-- {area:2098} Dawning Wood Catacombs · {zone:1431} Duskwood
	["The spellbook lies in the {area:2098}, the crypt in north-western {zone:1431}. Undead fill it; a corpse run works if you are low."] = "O livro de magias fica em {area:2098}, a cripta no noroeste de {zone:1431}. Mortos-vivos enchem o lugar; uma corrida de cadáver funciona se você estiver fraco.",

	-- Step 5: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "Pergaminhos na caverna dos ogros Mo'grosh, no nordeste. Os ogros da caverna são elites de nível 18-19: vale a pena formar grupo. (Rumi de Gnomeregan também fica em {area:144}, se você perdeu em {area:108}.)",

	-- Step 6: Wetlands
	-- {area:118} Whelgar's Excavation Site · {zone:1437} Wetlands
	["At {area:118}, the dig in the middle of the {zone:1437}."] = "Em {area:118}, a escavação no meio de {zone:1437}.",

	-- Step 7: Silverpine Forest
	-- {area:233} Ambermill
	["At {area:233}, the mage village in south-eastern Silverpine."] = "Em {area:233}, a vila dos magos no sudeste de Pinhaprata.",

	-- Step 8: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "Numa prateleira do boticário de {area:159}.",

	-- Step 9: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "Descendo as escadas em {area:443}, no norte de {zone:1439}.",

	-- Step 10: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "Num barril numa tenda em {area:2537}, no extremo sudeste da zona.",

	-- Step 11: The Barrens
	-- {area:382} Sludge Fen · {object:407566} Goblin Tome (no name in this language: may be words) · {area:392} Ratchet
	["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the {object:407566} beside Gazlowe in {area:392}."] = "Dois livros: o manual na sala de controle no topo da plataforma de petróleo em {area:382}, e o {object:407566} ao lado de Gasganete, em {area:392}.",

	-- Step 12: The Wailing Caverns' cave
	-- {area:718} Wailing Caverns
	["The {area:718}' cave"] = "A caverna de {area:718}",
	-- {area:387} Lushwater Oasis · {area:718} Wailing Caverns
	["The scrolls lie underground, in the cave below {area:387} by the {area:718} entrance, not inside the dungeon. Go in at the cave mouth in the oasis and follow the cave down; the arrow points at the scrolls from the surface."] = "Os pergaminhos ficam no subterrâneo, na caverna embaixo de {area:387}, junto à entrada de {area:718}, não dentro da masmorra. Entre pela boca da caverna no oásis e siga a caverna para baixo; a seta aponta para os pergaminhos a partir da superfície.",
	-- {area:387} Lushwater Oasis
	["Cave mouth at {area:387}"] = "Boca da caverna em {area:387}",

	-- Step 13: Orgrimmar
	-- {object:405149} Mural of Ta'zo (no name in this language: may be words) · {object:172961} Valley of Spirits (no name in this language: may be words)
	["The {object:405149} is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "O {object:405149} é a tábua de pedra encostada na parede de {object:172961}, no caminho para os instrutores de mago. Use-a para pegar o livro.",

	-- Step 14: The library: first books
	["The library: first books"] = "A biblioteca: primeiros livros",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in the books so far. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entregue os livros até agora. {npc:211033} cuida da biblioteca no topo do Sacrário dos Teurgos, no {object:2101}. Ele oferece a missão de cada livro enquanto o livro está nas suas bolsas: pegue e entregue, um de cada vez, para o registro de missões ficar livre. Pule os livros que você não achou.",

	-- Step 15: The library: first books (Horde)
	["The library: first books (Horde)"] = "A biblioteca: primeiros livros (Horda)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter (no name in this language: may be words)
	["Hand in the books so far. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entregue os livros até agora. {npc:211022} cuida da biblioteca no Bairro Mágico. Ele oferece a missão de cada livro enquanto o livro está nas suas bolsas: pegue e entregue, um de cada vez, para o registro de missões ficar livre. Pule os livros que você não achou.",

	-- Step 16: Friend of the Library
	-- {quest:78150} Friend of the Library · {item:277203} Scholarly Pendant · {item:277204} Erudite's Amulet
	["With 10 different books handed in, the librarian offers {quest:78150}: a choice of two necklaces ({item:277203} or {item:277204}). Take it when it appears."] = "Com 10 livros diferentes entregues, o bibliotecário oferece {quest:78150}: uma escolha entre dois colares ({item:277203} ou {item:277204}). Pegue quando aparecer.",

	-- Step 17: Alterac Mountains
	-- {area:1357} Gallows' Corner
	["Inside the first tower of the ogre fort at {area:1357}, in the middle of the zone."] = "Dentro da primeira torre do forte dos ogros em {area:1357}, no meio da zona.",

	-- Step 18: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "Ao lado da entrada de uma tenda na vila dos trolls no sudeste de Arathi.",

	-- Step 19: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "Num banco ao lado da entrada de {area:310}, no meio da zona.",

	-- Step 20: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "Dentro de uma cripta perto do meio da zona, alcançada pela trilha ao sul dela.",

	-- Step 21: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "Na passarela de cima de {area:1477}, fora da masmorra.",

	-- Step 23: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "Dentro de uma cabana na mesa de {area:2097}.",

	-- Step 24: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "No chão, no lado leste do acampamento de murlocs no nordeste do Pântano Vadeoso.",

	-- Step 25: The library: second books
	["The library: second books"] = "A biblioteca: segundos livros",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in this part's books. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entregue os livros desta parte. {npc:211033} cuida da biblioteca no topo do Sacrário dos Teurgos, no {object:2101}. Ele oferece a missão de cada livro enquanto o livro está nas suas bolsas: pegue e entregue, um de cada vez, para o registro de missões ficar livre. Pule os livros que você não achou.",

	-- Step 26: The library: second books (Horde)
	["The library: second books (Horde)"] = "A biblioteca: segundos livros (Horda)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter (no name in this language: may be words)
	["Hand in this part's books. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Entregue os livros desta parte. {npc:211022} cuida da biblioteca no Bairro Mágico. Ele oferece a missão de cada livro enquanto o livro está nas suas bolsas: pegue e entregue, um de cada vez, para o registro de missões ficar livre. Pule os livros que você não achou.",

	-- Step 27: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:281634} Field Researcher's Loop · {item:281635} Philanthropist's Ring
	["From level 20, with 20 different books handed in, {npc:211033} offers {quest:79536}: {item:281634} or {item:281635}."] = "A partir do nível 20, com 20 livros diferentes entregues, {npc:211033} oferece {quest:79536}: {item:281634} ou {item:281635}.",

	-- Step 28: The Hinterlands
	-- {area:353} Shadra'Alor · {zone:1425} The Hinterlands
	["In the troll ruins of {area:353}, in the south of the {zone:1425}."] = "Nas ruínas trolls de {area:353}, no sul de {zone:1425}.",

	-- Step 29: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "Numa mesa dentro de uma tenda perto do meio da zona.",

	-- Step 30: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "Dentro de {area:254}, não numa masmorra: o livro está no altar da tumba de {npc:8888}, perto de {npc:14387}. O marcador de rota aponta para a montanha.",

	-- Step 32: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "Num caixote em {area:1236}, no extremo oeste de {zone:1447}.",

	-- Step 33: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "Numa estante do prédio do meio do acampamento pirata, na costa leste.",

	-- Step 34: The library: third books
	["The library: third books"] = "A biblioteca: terceiros livros",

	-- Step 35: The library: third books (Horde)
	["The library: third books (Horde)"] = "A biblioteca: terceiros livros (Horda)",

	-- Step 36: The second Greater Friend of the Library
	-- {quest:79536} Greater Friend of the Library
	["The second {quest:79536}"] = "A segunda {quest:79536}",
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:277254} Truthseeker's Bow · {item:277258} Crest of Elucidation · {item:277260} Researcher's Night Light
	["From level 35, with 25 different books handed in, {npc:211033} offers the second {quest:79536}: {item:277254}, {item:277258} or {item:277260} (level 40 to equip)."] = "A partir do nível 35, com 25 livros diferentes entregues, {npc:211033} oferece a segunda {quest:79536}: {item:277254}, {item:277258} ou {item:277260} (nível 40 para equipar).",

	-- Step 37: Level 60 books: Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Level 60 books: {zone:1422}"] = "Livros de nível 60: {zone:1422}",
	-- {item:228141} Necromancy 101 · {area:2298} Caer Darrow · {area:2057} Scholomance · {item:228132} Undead Potatoes · {area:199} Felstone Field
	["Eight more books lie in level 55-60 zones; the mage trainers beside the librarians take them, not the librarians. {item:228141} lies on a table in the ruined keep on {area:2298}, above {area:2057} (outside the dungeon); {item:228132} at {area:199}."] = "Mais oito livros ficam em zonas de nível 55-60; os instrutores de mago ao lado dos bibliotecários os pegam, não os bibliotecários. {item:228141} fica numa mesa na fortaleza em ruínas em {area:2298}, acima de {area:2057} (fora da masmorra); {item:228132} em {area:199}.",

	-- Step 38: Level 60 books: Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Level 60 books: {zone:1423}"] = "Livros de nível 60: {zone:1423}",
	-- {item:228135} A Study of the Light · {area:2268} Light's Hope Chapel · {item:228138} The Knight and the Lady · {area:2264} Corin's Crossing · {area:2279} Stratholme · {item:228140} Scourge: Undead Menace or Misunderstood? · {area:2277} Plaguewood
	["{item:228135} is inside {area:2268}. {item:228138} lies at {area:2264}; other copies lie elsewhere in the zone (one by the {area:2279} gates), and you can take only one. {item:228140} is on a table in {area:2277}: wait for the patrolling elite to clear the creatures beside it and walk on."] = "{item:228135} fica dentro de {area:2268}. {item:228138} fica em {area:2264}; outras cópias ficam em outros pontos da zona (uma perto dos portões de {area:2279}), e você só pode pegar uma. {item:228140} está numa mesa em {area:2277}: espere o elite que patrulha afastar as criaturas ao lado dela e passe andando.",

	-- Step 39: Level 60 books: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Level 60 books: {area:1769}"] = "Livros de nível 60: {area:1769}",
	-- {item:228134} Northern Kalimdor - A Comprehensive Guide · {area:1769} Timbermaw Hold · {zone:1448} Felwood · {zone:1452} Winterspring
	["{item:228134} lies inside the {area:1769} tunnel between {zone:1448} and {zone:1452}."] = "{item:228134} fica dentro do túnel de {area:1769}, entre {zone:1448} e {zone:1452}.",

	-- Step 40: Level 60 books: Everlook
	-- {area:2255} Everlook
	["Level 60 books: {area:2255}"] = "Livros de nível 60: {area:2255}",
	-- {item:228136} Ka-Boom! · {area:2255} Everlook
	["{item:228136} sits on a shelf behind the alchemy supplier in {area:2255}."] = "{item:228136} está numa prateleira atrás do fornecedor de alquimia em {area:2255}.",

	-- Step 41: Level 60 books: Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Level 60 books: {area:254}"] = "Livros de nível 60: {area:254}",
	-- {item:228133} Magma or Lava? · {area:254} Blackrock Mountain · {area:1584} Blackrock Depths · {area:2717} Molten Core
	["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver. The waypoint marks the mountain."] = "{item:228133} fica dentro de {area:254}, na passagem da mina rumo a {area:1584}, depois do fornecedor de missão de {area:2717}. O marcador de rota aponta para a montanha.",

	-- Step 42: The level 60 books: Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["The level 60 books: {npc:5497}"] = "Os livros de nível 60: {npc:5497}",
	-- {npc:5497} Jennea Cannon · {npc:211033} Garion Wendell · {item:228132} Undead Potatoes · {item:228138} The Knight and the Lady · {item:228140} Scourge: Undead Menace or Misunderstood?
	["{npc:5497}, the mage trainer beside {npc:211033} in the Wizard's Sanctum, takes the level 60 books: she offers each book's quest while the book is in your bags. Hand in {item:228132}, {item:228138} and {item:228140} the same way (their quests are not in Polestar's data yet)."] = "{npc:5497}, a instrutora de mago ao lado de {npc:211033} no Sacrário dos Teurgos, pega os livros de nível 60: ela oferece a missão de cada livro enquanto o livro está nas suas bolsas. Entregue {item:228132}, {item:228138} e {item:228140} do mesmo jeito (as missões deles ainda não estão nos dados do Polestar).",

	-- Step 43: The level 60 books: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe
	["The level 60 books: {npc:7825}"] = "Os livros de nível 60: {npc:7825}",
	-- {npc:7825} Oran Snakewrithe · {npc:211022} Owen Thadd · {object:36082} Magic Quarter (no name in this language: may be words)
	["{npc:7825}, beside {npc:211022} in the {object:36082}, takes the level 60 books: each book's quest is offered while the book is in your bags. Take and hand them in one at a time (Polestar cannot track these quests for the Horde yet)."] = "{npc:7825}, ao lado de {npc:211022}, no Bairro Mágico, pega os livros de nível 60: a missão de cada livro é oferecida enquanto o livro está nas suas bolsas. Pegue e entregue um de cada vez (o Polestar ainda não consegue acompanhar essas missões para a Horda).",
}
