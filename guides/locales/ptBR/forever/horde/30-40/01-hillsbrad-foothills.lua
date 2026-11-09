-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "Mestre de voo de {area:484}",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "Voe de {area:484} para {area:1638} e treine com {npc:3033} em {area:1639}; de lá, siga voando até a Encruzilhada.",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "Voe de {area:484} para {area:392}. {npc:5901} acampa na costa, a uma curta caminhada ao sul da cidade; de {area:392}, siga voando até a Encruzilhada.",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "{npc:5901}: {item:6637}, para o braseiro",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "Voe para a Encruzilhada",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 7: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} fica ao lado do mestre de voo da Encruzilhada.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428}: para {npc:4485} em {zone:1454}",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	["Crossroads flight master"] = "Mestre de voo da Encruzilhada",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:4949} espera na Fortaleza Grommash, em {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Fortaleza Grommash, se você a tiver",

	-- Step 10: Train
	["Train"] = "Treinar",
	["Train your new spells."] = "Treine seus novos feitiços.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words)
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "{npc:4485} fica em {object:172958}, no caminho para o portão principal.",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "para {npc:4483} em {area:439}, no próximo guia",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 13: The Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "{quest:515} precisa de um {item:3388}, um item de {skill:171}: compre um na casa de leilões se puder (ou peça a um alquimista). O texto da missão diz Forte, mas ela pede um {item:3388}. Sem elixir: pule as etapas de Elixir em {area:287}.",
	-- {item:3388} Lesser Troll's Blood Elixir · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: casa de leilões ou um alquimista, para {quest:515}.",

	-- Step 14: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "{npc:260093} treina Paladinos em {zone:1458}.",

	-- Step 15: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Mestre de voo de {zone:1458}",

	-- Step 16: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Voe para {area:228}. {object:113791} fica no morro logo a sudoeste dela: derrote a Manifestação Corrompida da Água ao lado, coloque as braçadeiras dela no braseiro, fale com {npc:5895} e guarde o {item:7813} para {npc:5901}. Siga voando para {area:272} a partir de {area:228}.",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "{item:6637}: beba junto à pedra erguida para ver o elemental",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "para {npc:5901}, próximo guia",

	-- Step 17: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "Mestre de voo de {area:228}",

	-- Step 19: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, lá dentro",
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",

	-- Step 20: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Siga a estrada para o norte saindo de {area:272} até o sopé de Alterac. {quest:535} espera perto do acampamento da Camarilha; entregue-lhe a cerveja.",

	-- Step 21: Syndicate missives
	["Syndicate missives"] = "Missivas da Camarilha",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-34) around the camps west of the road carry the missives; about one in three drops one."] = "Os Salteadores e Ladrões da Camarilha (32-34) em volta dos acampamentos a oeste da estrada levam as missivas; cerca de um em três deixa cair uma.",

	-- Step 24: Helcular's Rod
	-- {area:277} Foothill Caverns · {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod."] = "A sudoeste, os Yetis das Cavernas e Yetis Ferozes (30-32) enchem {area:277}, nas colinas a oeste de {area:272}; cerca de um em cada dezesseis carrega o bastão.",

	-- Step 25: Level 30
	["Level 30"] = "Nível 30",
	-- {area:272} Tarren Mill · {quest:544} Prison Break In · {quest:556} Stone Tokens · {quest:676} The Hammer May Fall · {area:796} Scarlet Monastery · {area:2797} Blackfathom Deeps
	["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the {area:796} dungeon (Graveyard) or the {area:2797} dungeon instead."] = "As missões {quest:544}, {quest:556} e {quest:676} de {area:272} são oferecidas a partir do nível 30. Abaixo disso? Continue matando os yetis nestas cavernas até o nível 30. Ou, em grupo, faça a masmorra {area:796} (Cemitério) ou a masmorra {area:2797}.",
	-- {npc:2248} Cave Yeti
	["grind on {npc:2248}"] = "mate {npc:2248} até subir",

	-- Step 26: Town hall
	["Town hall"] = "Prefeitura",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Siga para a vila de {area:287}, a sudoeste das cavernas dos yetis. A prefeitura fica no lado oeste da vila: {npc:2335} (30) e {npc:2448} estão lá dentro com o Cartório; a Proclamação está afixada ao lado. Conselheiros andam pela vila.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, lá dentro",
	["Inside"] = "Lá dentro",

	-- Step 27: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "Volte para leste até {area:272}.",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside: offered from level 30"] = "{npc:2410}, lá dentro: oferecida a partir do nível 30",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}: {quest:93680}; {item:279469} fica perto dos traidores",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside: offered from level 30"] = "{npc:2437}, lá dentro: oferecida a partir do nível 30",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "{npc:2770}: para {npc:2771} em {area:321}, mais adiante neste guia (a partir do nível 30)",

	-- Step 28: Foothill Caverns
	-- {area:272} Tarren Mill · {item:3710} Rod of Helcular · {object:1768} Flame of Azel · {object:1769} Flame of Veraz
	["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "De volta às cavernas dos yetis a oeste de {area:272} com o {item:3710}. O caminho se divide logo na entrada: {object:1768} queima no nível de cima, à direita, e {object:1769} no nível de baixo, à esquerda, depois de mais yetis.",

	-- Step 29: Flame of Uzel
	["The third flame burns in the smaller cave up in the hills north of the caverns."] = "A terceira chama queima na caverna menor, no alto das colinas ao norte das cavernas.",

	-- Step 30: Alterac Mountains
	-- {area:279} Dalaran
	["The {area:279} crater"] = "A cratera de {area:279}",

	-- Step 31: The Dalaran crater
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp."] = "Siga para oeste pelo pé das montanhas até a cúpula violeta de {area:279}. {npc:2411}, {npc:2412} e {npc:2413} (33-34) ficam juntos na borda leste da cratera, {npc:2414} (35) um pouco a oeste deles; cada um carrega uma peça de Pedra-sangrenta. Os Escudeiros e Teurgos (31-33) em volta deles deixam cair as Fichas de Pedra Gastas. Cuidado: muitos guardas andam em duplas ligadas, e outros patrulham sozinhos em volta do acampamento.",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "{item:279469}: um objeto para saquear, perto dos traidores",

	-- Step 33: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Siga ao sul, passando pela vila de {area:287}, até {area:288}. Mineiros trabalham nos túneis; {npc:2305} (30) e {npc:2450} (29) estão bem lá no fundo.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "Dentro de {area:288}",

	-- Step 34: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Rancapina",
	-- {area:271} Southshore
	["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "Os murlocs Rancapina acampam nas praias a sudoeste da baía de {area:271}, abaixo da mina.",
	["Torn Fin beach"] = "Praia dos Rancapina",

	-- Step 35: Helcular's Grave
	-- {area:271} Southshore
	["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north and keep away from the town's guards."] = "Siga para leste até o cemitério de {area:271}, na ponta nordeste da vila: o túmulo de Helcular fica entre os outros. Chegue pelo norte e fique longe dos guardas da vila.",

	-- Step 36: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinhadaga",
	["The Daggerspine naga line the shore south-east of the town."] = "As nagas Espinhadaga se enfileiram pela costa a sudeste da cidade.",
	["Daggerspine shore"] = "Margem dos Espinhadaga",

	-- Step 37: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Head back north to {area:272}, east of {area:271}."] = "Volte ao norte até {area:272}, a leste de {area:271}.",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, lá dentro",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, lá dentro",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:545} Dalaran Patrols
	["{npc:2410}: he offers {quest:545} after it"] = "{npc:2410}: ele oferece {quest:545} depois disso",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}: for the 38-39 visit to Alterac"] = "{npc:2437}: para a visita aos níveis 38-39 em Alterac",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}: for the 38-39 visit to Alterac"] = "{npc:2410}: para a visita aos níveis 38-39 em Alterac",
	-- {npc:2229} Krusk · {npc:2316} Gol'dir
	["{npc:2229} now offers {npc:2316} (level 36): leave it for the 38-39 visit."] = "{npc:2229} agora oferece {npc:2316} (nível 36): deixe para a visita dos níveis 38-39.",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, lá dentro",

	-- Step 38: Elixir of Agony with a group
	-- {quest:515} Elixir of Agony
	["{quest:515} with a group"] = "{quest:515} com um grupo",
	-- {area:290} Dun Garok · {area:271} Southshore
	["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "A próxima tarefa de Lindolfo é um barril de Stout do Festeiro da adega de {area:290}, a fortaleza anã de elite a sudeste de {area:271}: só pegue se for lá em grupo.",

	-- Step 39: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "{quest:539} com um grupo",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "A última batalha de Darthalia é em {area:290}, a fortaleza anã a sudeste de {area:271}: todo anão de lá é elite (28-32), {npc:2304} também. Ótima XP se você tiver um grupo.",

	-- Step 40: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "{quest:547} com um grupo",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "A espada de {npc:2419} cai dos mesmos anões de {area:290} (cerca de um em doze).",

	-- Step 41: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "Limpe {area:290} do portão para dentro; os anões correm para pedir ajuda com 30% de vida.",

	-- Step 42: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "para {npc:2425}, em {zone:1458}, no fim deste guia",

	-- Step 44: Shindigger keg
	["Shindigger keg"] = "Barril do Festeiro",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "Os Barris de Stout do Festeiro ficam na adega de {area:290}, a fortaleza anã a sudeste de {area:271}, ao lado de {npc:2304} (32); todo anão de lá é elite (28-32).",
	["Below ground"] = "No subterrâneo",

	-- Step 45: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "De volta a {area:272}",
	-- {area:272} Tarren Mill
	["Head back north to {area:272}."] = "Volte para o norte até {area:272}.",
	-- {object:1729} Tainted Keg (no name in this language: may be words) · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "Coloque {object:1729} em {object:1728} ao lado da estalagem; no andar de cima",

	-- Step 46: Arathi Highlands
	["Boulderfist camp"] = "Acampamento Punho de Pedra",

	-- Step 47: Boulderfist camp
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Saia de {area:272} para leste, passando por {area:1057}, e siga a estrada para leste. Os Ogros e Impositores Punho de Pedra (32-34) acampam ao sul da estrada, ao sul de {area:313}; os Impositores ficam na caverna de lá.",

	-- Step 48: Level 31
	["Level 31"] = "Nível 31",
	-- {area:321} Hammerfall · {area:796} Scarlet Monastery · {area:2797} Blackfathom Deeps
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the {area:796} dungeon (Graveyard) or the {area:2797} dungeon instead."] = "As missões de {area:321} são de nível 32-36. Abaixo de 31? Continue matando os Ogros e Impositores Punho de Pedra neste acampamento até o nível 31. Ou, em grupo, faça a masmorra {area:796} (Cemitério) ou a masmorra {area:2797}.",
	-- {npc:2562} Boulderfist Ogre
	["grind on {npc:2562}"] = "mate {npc:2562} até subir",

	-- Step 49: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "A fortaleza orc na ponta leste da estrada. {npc:2851}, o mestre de mantícoras, fica junto ao portão.\n{npc:15126} só oferece {quest:8263} quando você está Amigável com os Profanadores ({zone:1461}): pule se ele não oferecer.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, junto ao portão",
	-- {npc:2706} Tor'gan · {area:272} Tarren Mill
	["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "{npc:2706}: a Camarilha de lá fica junto à estrada que vem de {area:272}, na visita dos níveis 38-39",

	-- Step 50: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Ao sul de Ruína do Martelo, os trolls Cascasseca ocupam a aldeia nas colinas. Arremessadores de Machado guardam as cabanas de fora; os Mandingueiros e Caçadores de Cabeças ficam no coração da aldeia. Cuidado: os três tipos de troll fogem atrás de ajuda com 15% de vida, o que pode trazer mais trolls dos acampamentos vizinhos.",

	-- Step 51: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "Raptores do Planalto e Rastejantes das Planícies",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "No caminho de volta ao norte, Andarilhos do Planalto vagam pelas colinas em volta de {area:321} e deixam cair os olhos, e ao sul dela os Rastejantes das Planícies (32-33) tecem suas teias no capim; eles carregam a seda de aranha.",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "{item:278225}, dos Rastejantes das Planícies",

	-- Step 52: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}."] = "Volte ao norte até {area:321}.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, no portão sul",
	-- {npc:2706} Tor'gan · {npc:2771} Drum Fel · {quest:677} Call to Arms
	["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "A astúcia dos raptores de {npc:2706}, a próxima {quest:677} de {npc:2771} e o Reabastecimento de Proteção do doutor ficam para a visita dos níveis 38-39.",

	-- Step 53: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Voe para {area:1497}",
	-- {area:321} Hammerfall
	["{area:321} flight master"] = "Mestre de voo de {area:321}",

	-- Step 54: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "{npc:2425} fica ao lado de Sylvana em {object:36126}.",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "{npc:2425}: a recomendação de Darthalia",

	-- Step 55: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instrutores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {object:36073} Rogues' Quarter (no name in this language: may be words) · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Treine enquanto estiver em {zone:1458}: os instrutores ficam no {object:36070}, no {object:36073} e no {object:36082} (paladinos: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "O barril fica com alguns outros no acampamento da Camarilha na costa sudeste de {area:287}.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "A fortaleza orc no extremo leste da estrada. {npc:2851}, a mestre dos mantícoras, fica junto ao portão.",
}
