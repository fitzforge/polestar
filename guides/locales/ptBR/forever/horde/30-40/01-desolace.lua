-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Freewind Post
	-- {area:484} Freewind Post
	["Hearth to {area:484}"] = "",

	-- Step 2: To Freewind Post
	-- {area:484} Freewind Post
	["To {area:484}"] = "",

	-- Step 3: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voar para {area:1637}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 4: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits (no name in this language: may be words) · {npc:4949} Thrall · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} espera no Drag; {npc:5640} fica no {object:172961}, no lado oeste da cidade. Celonatos: {npc:4949} espera na Fortaleza Grommash, no {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Fortaleza Grommash, se você a tiver",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Missões de classe em {zone:1454}",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} fica no {object:172957}.",

	-- Step 6: Train
	["Train"] = "Treinar",
	["Train your new spells."] = "Treine seus novos feitiços.",

	-- Step 7: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short walk south of the town."] = "",

	-- Step 8: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "Voe até {area:484}. {npc:5905} se esconde numa pequena caverna na parede do cânion a nordeste do posto.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: seu {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} também inicia Elemental Aid ({area:1717}), a série 33-40 até The Tempest's Weapons: forever/class/shaman/call-of-air-horde.",

	-- Step 9: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",

	-- Step 10: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Voar para o {area:460}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 13: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} fica no posto; {npc:5641} e {npc:4498} esperam na elevação a oeste dele, acima do {area:596}.",

	-- Step 14: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "Use o {item:13892} de {npc:11596} num Kodo Idoso, Moribundo ou {npc:4702} no cemitério e leve o kodo domado de volta a {npc:11596}. Cinco kodos, um de cada vez.",

	-- Step 15: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Head north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "",

	-- Step 16: Sargeron
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "",

	-- Step 17: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Head west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "",

	-- Step 18: Ghost Walker Post
	["Head back south to the post."] = "",

	-- Step 19: Ghost Walker Post
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "A próxima missão de {npc:5641}, {quest:1431}, manda você de volta a {zone:1454} à toa: deixe-a.",

	-- Step 20: Kolkar ears
	["Kolkar ears"] = "Orelhas Kolkar",
	-- {area:609} Kolkar Village
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["Back at {area:609}, every Kolkar can drop an ear.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "",

	-- Step 21: Shadowstalker scalp
	["Shadowstalker scalp"] = "Escalpo de Assombrante",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "Os Assombrantes Furiódio em {area:603} andam invisíveis até atacar; cerca de um em três leva um escalpo.",

	-- Step 23: Shadowprey Village
	-- {area:606} Gelkis Village
	["Head south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}: para {npc:715} no Espinhaço",

	-- Step 25: On the way
	["On the way"] = "",

	-- Step 26: Clam beds
	["Clam beds"] = "Leitos de mariscos",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "",
	["Underwater"] = "",

	-- Step 27: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "Oráculos Sibilâmina",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "Continue para o norte até a {area:598}. Os Oráculos ficam entre os outros nagas no extremo norte; atraia um de cada vez.",

	-- Step 28: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863} espera na torre em ruínas de {area:2405}, terra adentro a sudeste.",

	-- Step 29: Ghost Walker Post
	["Head south-east to the post."] = "",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "A próxima tarefa de {npc:5641} manda você atrás de um senhor demoníaco com uma guarda de elite: pule-a.",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Mestre de voo da {area:2408}",

	-- Step 32: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 34: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "Voe da Aldeia Pescassombra até {area:1638} e treine com {npc:3033} no {area:1639}, depois voe até {zone:1454}.",

	-- Step 35: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",

	-- Step 36: Back to Orgrimmar
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 38: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 39: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 40: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}: para {zone:1413}, mais adiante na rota",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}: para {area:321} em Arathi, mais adiante na rota",

	-- Step 41: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 42: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 43: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515} requer uma {item:3388}, um item de {skill:171}: compre uma na casa de leilões daqui se puder (ou peça a um alquimista). Sem poção: pule as etapas do Elixir em {area:287}.",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: casa de leilões ou um alquimista, para {quest:515}.",

	-- Step 44: Brazier of Everfount
	-- {zone:1458} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {zone:1458} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "para {npc:5901}: do Espinhaço, próximo guia",

	-- Step 45: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "De volta a {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 47: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",

	-- Step 48: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Siga a estrada para o norte saindo de {area:272} até o sopé de Alterac. {quest:535} espera perto do acampamento da Camarilha; entregue-lhe a cerveja.",

	-- Step 49: Syndicate missives
	["Syndicate missives"] = "Missivas da Camarilha",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Os Salteadores e Ladrões da Camarilha (32-33) em volta dos acampamentos a oeste da estrada levam as missivas; cerca de um em três deixa cair uma.",

	-- Step 51: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinhadaga",
	-- {area:271} Southshore
	["Head south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "",
	["Daggerspine shore"] = "Margem dos Espinhadaga",

	-- Step 52: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Rancapina",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "Siga a margem para oeste passando a baía de {area:271}; os murlocs Rancapina acampam nas praias depois dela.",
	["Torn Fin beach"] = "Praia dos Rancapina",

	-- Step 53: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Head back north to {area:272}, keeping west of {area:271}."] = "",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",

	-- Step 54: Shindigger keg
	["Shindigger keg"] = "Barril do Festeiro",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "O barril fica com alguns outros no acampamento da Camarilha na costa sudeste de {area:287}.",
	["Below ground"] = "",

	-- Step 55: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Head back north to {area:272}."] = "",
	-- {object:1729} Tainted Keg (no name in this language: may be words) · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "",

	-- Step 56: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "A sudoeste, Yetis das Cavernas e Yetis Ferozes (30-31) enchem as cavernas nas colinas a oeste de {area:272}; cerca de um em dezesseis leva o bastão.",

	-- Step 58: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "Os traidores de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens.\nCareful: Many guards stand in linked pairs and others patrol alone around the camp."] = "",

	-- Step 59: Hearth to Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth to {area:272}"] = "",

	-- Step 60: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "A próxima tarefa de Trevando termina no cemitério de {area:271} e o mago oferece uma tarefa de masmorra: deixe as duas.",

	-- Step 62: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "",
	["Inside"] = "",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "",

	-- Step 65: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back south to {area:272}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back at {area:609}, every Kolkar can drop an ear."] = "De volta à {area:609}, todo Kolkar pode deixar cair uma orelha.",
	-- ["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Faça suas compras em {area:1497} primeiro, depois voe até {area:228}. O {object:113791} fica na colina logo a sudoeste dele: derrote a Manifestação Menor Corrompida da Água ao lado, coloque as braçadeiras dela no braseiro, fale com a {npc:5895} e guarde o {item:7813} para {npc:5901}. De {area:228}, voe até {area:272}.",
	-- ["Fly to the {area:1497}"] = "Voar para {area:1497}",
	-- ["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "Voe até {area:392}. {npc:5901} acampa na costa, a uma curta cavalgada ao sul da cidade.",
	-- ["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "Siga a estrada para sudoeste saindo do Retiro Rocha do Sol até {zone:1443} e continue para o sul passando o {area:608}. A caravana de kodos de {npc:11625} espera junto à estrada ao norte da {area:609}; se já tiver partido, siga em frente.",
	-- ["From {area:484}, fly to {area:1637}."] = "De {area:484}, voe até {area:1637}.",
	-- ["Gizelton caravan"] = "Caravana dos Gizelton",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "Siga para oeste ao pé das montanhas até a cúpula violeta de {area:279}. {npc:2411}, {npc:2412} e {npc:2413} (33-34) ficam juntos dentro da borda leste da cratera, {npc:2414} (35) um pouco a oeste deles; cada um leva uma peça de Pedra-sangrenta. Os Escudeiros e Teurgos (31-32) em volta deles deixam cair as Fichas de Pedra Gasta.",
	-- ["Hearth back (or ride north if it is on cooldown)."] = "Regresse (ou cavalgue para o norte se a pedra estiver em recarga).",
	-- ["His next errand is not on this route."] = "A próxima tarefa dele não está nesta rota.",
	-- ["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "Saia de {zone:1454} pelo portão principal; a torre de zepelim fica logo a nordeste. Pegue o zepelim de {area:1497}.",
	-- ["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "Para o norte pelas colinas do leste, os sátiros ocupam as ruínas de {area:603}. Os Assombrantes andam invisíveis; os quatro tipos de que você precisa, não.",
	-- ["Place the {object:1729} on the {object:1728} beside the inn"] = "Coloque o {object:1729} no {object:1728} ao lado da estalagem",
	-- ["Ride back east to {area:272}."] = "Cavalgue de volta para leste até {area:272}.",
	-- ["Ride back north to {area:272}, keeping west of {area:271}."] = "Cavalgue de volta para o norte até {area:272}, mantendo-se a oeste de {area:271}.",
	-- ["Ride back south to the post."] = "Cavalgue de volta para o sul até o posto.",
	-- ["Ride back south to {area:272}."] = "Cavalgue de volta para o sul até {area:272}.",
	-- ["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Cavalgue para o norte passando o acampamento de {quest:535} até {area:280}, a vila ocupada pela Camarilha (35-37). {npc:2431} leva a {item:3704}; {quest:503} está numa jaula na casa do lado norte.",
	-- ["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Cavalgue para o norte pela costa. Mariscos de Casca Mole Gigantes ficam no raso e Tiscorais Enfurecidos andam pela praia; abra cada marisco nas suas bolsas para pegar a carne.",
	-- ["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Cavalgue para nordeste até a {area:609}. {quest:1365} (35) anda entre as tendas do lado leste com um ou dois Senhores de Batalha (32-33): limpe em volta dele e depois atraia-o sozinho, com a vida cheia.",
	-- ["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Cavalgue para o sul, a leste de {area:271}, até a costa. Os nagas Espinhadaga ocupam a margem a sudeste da cidade.",
	-- ["Ride south-east to the post."] = "Cavalgue para sudeste até o posto.",
	-- ["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Cavalgue para sudoeste até a aldeia troll na costa, mantendo distância da {area:606} no caminho.",
	-- ["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Cavalgue para sudoeste rumo à Aldeia Pescassombra. Os centauros Gelkis (32-35) em volta da aldeia deles são um bom lugar para farmar; lute com eles até o nível 32.",
	-- ["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Cavalgue para oeste até {area:599}. Deixe um sectário da Lâmina Ardente com pouca vida e use a {item:6436} nele antes que morra para encher uma {item:6435}. Eles também deixam cair uma {item:20310} de vez em quando (1-5%); se cair, leia-a.",
	-- ["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "O Vidente fica no lado sul da {area:599}, a leste de {area:2405}. Elimine primeiro os sectários em volta dele.",
	-- ["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "A caravana segue para o sul passando a {area:609}. Saqueadores Kolkar a emboscam em ondas: mate-os antes que cheguem a {npc:11625}. Ela para perto do {area:2617}, a leste do {area:597}.",
	-- ["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "O próximo guia começa em {area:1497}, no zepelim de {object:3202}.",
	-- ["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "Seu instrutor está em {area:1638}, a um voo de distância: {npc:3033} (Druidas) no {area:1639}, {npc:246344} (Paladinos). De lá, voe até o {area:460}.",
	-- ["Zeppelin to the {area:1497}"] = "Zepelim para {area:1497}",
	-- ["Zeppelin tower"] = "Torre de zepelim",
	-- ["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "farme Pisoteantes e Ventilhãs Gelkis na {area:606}, {zone:1443}",
	-- ["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093} treina Paladinos em {area:1497}.",
	-- ["{npc:4551}, the bat handler"] = "{npc:4551}, o adestrador de morcegos",
}
