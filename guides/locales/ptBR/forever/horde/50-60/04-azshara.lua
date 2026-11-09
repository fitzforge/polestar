-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom (no name in this language: may be words) · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: guarde-a para {zone:1451}",
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words) · {zone:1447} Azshara · {npc:8576} Ag'tor Bloodfist · {area:1237} Valormok
	["{npc:4485}, {object:172958}: carried from the first {zone:1447} visit, else take it here for {npc:8576} in {area:1237}"] = "{npc:4485}, {object:172958}: trazida da primeira visita a {zone:1447}; senão, pegue-a aqui para {npc:8576} em {area:1237}",

	-- Step 2: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voe para {area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 3: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "A oficina de Liv fica no extremo norte das docas de {area:392}; {object:149036} está lá dentro.",
	["Inside"] = "Lá dentro",

	-- Step 4: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} acampa na praia logo ao norte de {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "A Água Purificada vai para o {area:2479} em {zone:1448}: guarde-a para depois.",

	-- Step 5: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "As caixas de {npc:256386}",
	-- {npc:256386} Dokimi · {area:1237} Valormok
	["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "Siga a cavalo pela estrada ao norte até a Encruzilhada; {npc:256386} fica lá. Abra cada caixa que ela entregar e traga de volta o que estiver dentro. Siga voando para {area:1237} a partir da Encruzilhada.",

	-- Step 6: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Voe para {area:1237}",
	["Crossroads flight master"] = "Mestre de voo da Encruzilhada",

	-- Step 8: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Siga para leste até as ruínas na costa. Encha os quatro frascos de Cuely nas poças de maré ao longo da praia; nagas Iralisca patrulham entre elas.",

	-- Step 9: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "Os elfos sangrentos acampam nos penhascos a nordeste, junto à {area:1227}.",

	-- Step 10: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "O acampamento da {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "O acampamento da Rimtori fica na ponta leste do acampamento-base. Leia o {object:151286} de lá e depois mate a Maga.\nCuidado: qual cristal está ligado à Rimtori é aleatório. Cada um dos outros dois invoca um infernal hostil.",

	-- Step 11: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Volte para oeste até {area:1237}.",

	-- Step 12: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Mestre de voo de {area:1237}",

	-- Step 13: Paladin trainer
	["Paladin trainer"] = "Instrutor de paladino",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {zone:1454} não tem instrutor de paladino",

	-- Step 14: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "Voe para {zone:1454} e treine.",

	-- Step 15: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words)
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Voe para {zone:1454}; {npc:4485} está no {object:172958}.",

	-- Step 16: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "Rumo a {zone:1411}",

	-- Step 17: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 18: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "{npc:8390} e {npc:8393} trabalham no Apothecarium.",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, ao lado dele",

	-- Step 19: The Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter (no name in this language: may be words)
	["Take the zeppelin from the tower outside {zone:1454} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Pegue o zepelim na torre do lado de fora de {zone:1454} até {zone:1420} e entre a cavalo em {zone:1458}. Lady Sylvana ocupa o {object:36126}.",

	-- Step 20: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, por perto",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} volta para {npc:10778} nas {zone:1422}: guarde-a.",
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "Só com {quest:79095}, da loja de alquimia de {area:159}, nas bolsas (o guia dos Livros da Biblioteca)",

	-- Step 22: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "Siga a cavalo para leste, saindo da {zone:1458}, pela estrada; {area:152} guarda o caminho para {zone:1422}.",

	-- Step 24: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "A fazenda de {npc:10778} é a primeira a leste de {area:152}. Os Carniçais Grasnantes da fazenda carregam a outra metade do pingente dela; {npc:11075} guarda o caldeirão no campo.\nCuidado: um ou dois mortos-vivos costumam lutar ao lado dele, e mais mestres da caldeira podem atacar depois que você usar o caldeirão.",
	["Upstairs"] = "No andar de cima",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "As duas doações de {item:14047} são entregues mais adiante na rota: comece a guardar {item:14047}.",
	-- ["Fly to the {area:380}"] = "Voe para {area:380}",
	-- ["In the {object:172958}."] = "No {object:172958}.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "No {object:172961}. Tenha Lã, Seda e Magitrama na bolsa.",
	-- ["Open {object:149036} for the {item:10556}"] = "Abra {object:149036} para pegar o {item:10556}",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "O acampamento de Rimtori fica no extremo leste do acampamento-base. Leia o {object:151286} lá e depois mate a Maga.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "A torre do zepelim fica logo a nordeste do portão principal de {zone:1454}; pegue o zepelim para {zone:1458}.",
	-- ["Zeppelin to the {zone:1458}"] = "Zepelim para {zone:1458}",
	-- ["Zeppelin tower"] = "Torre do zepelim",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, no Apothecarium",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} fica na {area:380}. Abra cada caixa que ela lhe entregar e traga de volta o que houver dentro.",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} volta para {npc:10778} em {area:28}: guarde-a.",
}
