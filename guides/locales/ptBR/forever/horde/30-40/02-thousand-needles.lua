-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/02-thousand-needles (forever/horde/30-40/02-thousand-needles.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 2: Alliance Relations
	-- {zone:1454} Orgrimmar · {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits (no name in this language: may be words)
	["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city."] = "O zepelim pousa na torre fora do portão principal de {zone:1454}. {npc:5639} espera no Drag; {npc:5640} fica em {object:172961}, no lado oeste da cidade.",
	-- {npc:5639} Craven Drok
	["{npc:5639}: offered from level 30"] = "{npc:5639}: oferecida a partir do nível 30",
	-- {npc:5641} Takata Steelblade · {zone:1443} Desolace
	["for {npc:5641} in {zone:1443}, later in this guide"] = "para {npc:5641}, em {zone:1443}, mais adiante neste guia",

	-- Step 3: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Instrutores de {zone:1454}",
	["Train while you are in the city."] = "Treine enquanto estiver na cidade.",

	-- Step 4: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} fica no {object:172957}.",
	-- {npc:5892} Searn Firewarder · {npc:5905} Prate Cloudseer · {area:484} Freewind Post
	["{npc:5892}: for {npc:5905} by {area:484}, later in this guide"] = "{npc:5892}: para {npc:5905} perto de {area:484}, mais adiante neste guia",

	-- Step 5: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor (no name in this language: may be words) · {quest:2841} Rig Wars · {area:133} Gnomeregan · {zone:1454} Orgrimmar
	["{npc:3412}'s workshop is in the {object:172958}. {quest:2841} is {area:133}'s last boss: great XP if you run it with a group. Run it whenever your group is ready; hand it in on a later {zone:1454} stop."] = "A oficina de {npc:3412} fica em {object:172958}. {quest:2841} é o último chefe de {area:133}: ótima XP se você for com um grupo. Faça quando o seu grupo estiver pronto; entregue em uma parada posterior em {zone:1454}.",

	-- Step 6: Gnomeregan
	-- {area:133} Gnomeregan · {npc:7800} Mekgineer Thermaplugg · {item:9153} Rig Blueprints
	["Run {area:133} with a group when it suits you: {npc:7800} at the end drops his Safe Combination; open his safe behind the northern bomb pillar for the {item:9153}."] = "Faça {area:133} em grupo quando for conveniente: {npc:7800}, no fim, deixa cair a Combinação do Cofre dele; abra o cofre dele atrás do pilar de bomba do norte para pegar o {item:9153}.",

	-- Step 7: Orgrimmar flight master
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 8: Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {area:484} from there."] = "Voe de {zone:1454} para {area:1638} e treine com {npc:3033} em {area:1639}; de lá, siga voando até {area:484}.",

	-- Step 9: Islen Waterseer
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:5901} Islen Waterseer · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to {area:484} from {area:392}."] = "Voe de {zone:1454} para {area:392}. {npc:5901} acampa na costa, a uma curta caminhada ao sul da cidade; de {area:392}, siga voando até {area:484}.",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} e seu {item:5177}",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Voe para {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 11: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 13: Prate Cloudseer
	-- {npc:5905} Prate Cloudseer
	["{npc:5905} hides in a small cave in the canyon wall north-east of the post, on the way east."] = "{npc:5905} se esconde numa pequena caverna na parede do cânion a nordeste do posto, no caminho para o leste.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: seu {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} também inicia Elemental Aid ({area:1717}), a série 33-40 até The Tempest's Weapons: forever/class/shaman/call-of-air-horde.",

	-- Step 14: Moktar Krin
	-- {npc:4483} Moktar Krin
	["Take the lift down and follow the canyon east. {npc:4483} camps on the north-western edge of the salt flats."] = "Desça de elevador e siga o cânion para o leste. {npc:4483} acampa na borda noroeste das planícies de sal.",

	-- Step 15: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Os goblins e gnomos de {area:2240} são neutros e dão missões às duas facções.",
	-- {npc:4452} Kravel Koalbeard · {quest:5762} Hemet Nesingwary
	["{npc:4452}'s crate for {quest:5762} in Stranglethorn, later on the route"] = "A caixa de {npc:4452} para {quest:5762}, na Selva do Espinhaço, mais adiante na rota",

	-- Step 16: The southern flats
	["The southern flats"] = "As planícies do sul",
	-- plural, as words: Saltstone Crystalhides = {npc:4151} Saltstone Crystalhide
	["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats."] = "Ao sul do circuito, os Cristaldermes Sal-gema (32-33) e os Observadores (34-35) vagam pela outra ponta das planícies.",

	-- Step 17: The Rustmaul Dig Site
	-- {item:5877} Cracked Silithid Carapace
	["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health."] = "A oeste deles, os silitídeos enxameiam o sítio de escavação. Buscadores e Zangões da Colmeia andam entre os montes; os Invasores (34-35) ficam dentro da caverna da colmeia. O primeiro silitídeo que você matar solta uma {item:5877}: abra-a.\nCuidado: os Zangões da Colmeia chamam ajuda quando caem para 20% de vida.",

	-- Step 18: Parts of the Swarm
	["Keep killing silithid at the dig site for the heart, the talons and the carapaces."] = "Continue matando silitídeos no sítio de escavação, pelo coração, pelas garras e pelas carapaças.",

	-- Step 19: Moktar Krin
	-- {npc:4483} Moktar Krin
	["North from the dig to {npc:4483}'s camp on the western edge of the flats."] = "Ao norte da escavação, até o acampamento de {npc:4483}, na borda oeste das planícies.",

	-- Step 20: Shimmering Flats: kill these as you meet them
	-- {area:439} Shimmering Flats
	["{area:439}: kill these as you meet them"] = "{area:439}: vá matando estes pelo caminho",
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger
	["East onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it; the Sparkleshell tortoises crowd round a half-buried ship in the north-east, and the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low; the Snappers (34-35) hit hardest of the tortoises."] = "A leste, rumo às planícies. Os Basiliscos Sal-gema (30-31) tomam sol a noroeste delas; as tartarugas Quelobrilho se aglomeram em volta de um navio meio enterrado no nordeste, e os Catadores da Planície Salgada e os Abutres rodeiam as planícies do leste. Todo abutre solta um osso, e cerca de uma tartaruga em três solta uma casca.\nCuidado: Catadores e Abutres usam Executar quando a sua vida está baixa; as Tartaliscas (34-35) são as que batem mais forte entre as tartarugas.",
	-- {object:19868} Rocket Car Rubble
	["{object:19868}, all over the northern flats"] = "{object:19868}, por todas as planícies do norte",
	-- {quest:1104} Salt Flat Venom
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["{quest:1104}, from the Scorpid Reavers of the north half"] = "{quest:1104}, dos Aniquiladores Escorpídeos da metade norte",

	-- Step 21: Mirage Raceway
	["South-west back to the raceway."] = "De volta ao sudoeste, até o circuito.",
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: his parts order goes to {quest:1111} in {area:392}, later on the route"] = "{npc:4452}: o pedido de peças dele vai para {quest:1111} em {area:392}, mais adiante na rota",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, at 39"] = "{npc:4454}: a carta dele vai para Martek, em {zone:1418}, no nível 39",
	-- {npc:4630} Pozzik · {area:392} Ratchet
	["{npc:4630}: for Gazlowe in {area:392}, later on the route"] = "{npc:4630}: para Gazlowe em {area:392}, mais adiante na rota",

	-- Step 22: Level 32.5
	["Level 32.5"] = "Nível 32.5",
	-- {zone:1443} Desolace · {area:796} Scarlet Monastery
	-- plural, as words: Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper
	["{zone:1443}'s quests are 33-38. Still below 32.5 after the raceway's hand-ins? Keep killing the Sparkleshell Snappers on the flats just north of the raceway until level 32.5. Or, with a group, run the {area:796} dungeon (Graveyard or Library) instead."] = "As missões de {zone:1443} são de nível 33-38. Ainda abaixo de 32.5 depois das entregas do circuito? Continue matando as Tartaliscas Quelobrilho nas planícies logo ao norte do circuito até o nível 32.5. Ou, em grupo, faça a masmorra {area:796} (Cemitério ou Biblioteca).",
	-- plural, as words: Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper
	["Sparkleshell Snappers"] = "Tartaliscas Quelobrilho",
	-- {npc:4143} Sparkleshell Snapper
	["grind on {npc:4143}"] = "mate {npc:4143} até subir",

	-- Step 23: Freewind Post
	-- {area:484} Freewind Post · {npc:10537} Cliffwatcher Longhorn
	["West back to {area:484}. {npc:10537} stands in the middle of the post, on the way to the flight master."] = "De volta a oeste, até {area:484}. {npc:10537} fica no meio do posto, no caminho para o mestre de voo.",
	-- {npc:10537} Cliffwatcher Longhorn · {npc:11259} Nataka Longhorn · {zone:1443} Desolace
	["{npc:10537}: for {npc:11259} in {zone:1443}, next"] = "{npc:10537}: para {npc:11259}, em {zone:1443}, em seguida",

	-- Step 24: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Voar para o {area:460}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "Mestre de voo de {area:484}",

	-- Step 26: Scrabblescrew's Camp
	-- {zone:1443} Desolace · {npc:11596} Smeed Scrabblescrew
	["Head south out of Stonetalon into {zone:1443} and follow the road south to {npc:11596}'s camp."] = "Siga para o sul, saindo de Torres de Pedra, até {zone:1443}, e continue pela estrada para o sul até o acampamento de {npc:11596}.",

	-- Step 27: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:11259} Nataka Longhorn · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post, {npc:11259} up on its rise; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} fica no posto, {npc:11259} no alto da elevação; {npc:5641} e {npc:4498} esperam na elevação a oeste dela, acima de {area:596}.",
	-- {npc:11259} Nataka Longhorn
	["{npc:11259}, up on the rise"] = "{npc:11259}, no alto da elevação",

	-- Step 28: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time."] = "Use o {item:13892} de {npc:11596} num Kodo Idoso, Moribundo ou {npc:4702} no cemitério e leve o kodo domado de volta a {npc:11596}. No acampamento dele, fale com o kodo: isso o conta e deixa você domar o próximo. Cinco kodos, um de cada vez.",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 30: Level 33
	["Level 33"] = "Nível 33",
	-- {quest:5381} Hand of Iruxos · {npc:11596} Smeed Scrabblescrew · {area:796} Scarlet Monastery
	-- plural, as words: Scorpashi Lashers = {npc:4697} Scorpashi Lasher
	["Shadowprey's {quest:5381} and the coast's naga want 33. Below that? The Scorpashi Lashers on the slopes north of {npc:11596}'s camp are on your way west: kill them until level 33. Or, with a group, run the {area:796} dungeon (Library) instead."] = "{quest:5381}, de Pescassombra, e as nagas da costa pedem nível 33. Abaixo disso? Os Escorpachis Açoitadores nas encostas ao norte do acampamento de {npc:11596} ficam no seu caminho para oeste: mate-os até o nível 33. Ou, em grupo, faça a masmorra {area:796} (Biblioteca).",
	-- plural, as words: Scorpashi Lashers = {npc:4697} Scorpashi Lasher
	["Scorpashi Lashers"] = "Escorpachis Açoitadores",
	-- {npc:4697} Scorpashi Lasher
	["grind on {npc:4697}"] = "mate {npc:4697} até subir",

	-- Step 31: Shadowprey Village
	-- {area:606} Gelkis Village · {npc:268705} Aka'rai · {quest:97265} Hate the Hatefury
	["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village.\n{npc:268705} may not be here on Forever: if {npc:268705} doesn't offer {quest:97265}, skip it."] = "Siga para oeste até a vila troll na costa, mantendo distância de {area:606} no caminho. {npc:268705} fica na trilha logo ao norte da vila.\n{npc:268705} pode não estar aqui no Forever: se {npc:268705} não oferecer {quest:97265}, pule.",
	-- {npc:268705} Aka'rai · {area:603} Sargeron
	["{npc:268705}: the Hatefury satyrs of {area:603}, later in this guide"] = "{npc:268705}: os sátiros Furiódio de {area:603}, mais adiante neste guia",
	-- {npc:11877} Roon Wildmane · {quest:5762} Hemet Nesingwary
	["{npc:11877}: for {quest:5762} in Stranglethorn, next guide"] = "{npc:11877}: para {quest:5762}, na Selva do Espinhaço, no próximo guia",
	-- {npc:6726} Thalon
	["{npc:6726}, at the village's south-west end"] = "{npc:6726}, na ponta sudoeste da aldeia",

	-- Step 32: Clam beds
	["Clam beds"] = "Leitos de mariscos",
	-- {item:15874} Soft-shelled Clam
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach: each clam you open on the sea floor, and some crawlers, give a {item:15874}. Open each one in your bags for its meat."] = "Siga para o norte pela costa. Mariscos de Casca Mole Gigantes ficam nas águas rasas e os Tiscorais Enfurecidos andam pela praia: cada marisco que você abrir no fundo do mar, e alguns tiscorais, dão {item:15874}. Abra cada um nas bolsas para pegar a carne.",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam
	["Giant Softshell Clams, on the sea floor"] = "Mariscos de Casca Mole Gigantes, no fundo do mar",
	-- {item:15874} Soft-shelled Clam
	["{item:15874}: open it in your bags"] = "{item:15874}: abra nas bolsas",
	["Underwater"] = "Debaixo d'água",

	-- Step 33: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time."] = "Continue ao norte até {area:598}. Os Mirmidões, Nagas e Feiticeiras Sibilâmina ocupam a praia; puxe-os um de cada vez.",

	-- Step 34: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the east."] = "{npc:11863} espera na torre em ruínas de {area:2405}, para o interior, a leste.",

	-- Step 35: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {npc:13019} Burning Blade Seer · {item:20310} Flayed Demon Skin · {quest:5381} Hand of Iruxos · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal (no name in this language: may be words) · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. {quest:5381}: clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}."] = "Siga para leste até {area:599}. Derrube um sectário da Lâmina Ardente e use {item:6436} nele antes que morra, para obter {item:6435}. {npc:13019} fica no último andar da fortaleza com o Cetro. Os sectários também deixam cair {item:20310} de vez em quando (1-5%); quando cair, leia. {quest:5381}: limpe o meio do maior prédio e use {item:14523} no {object:176581} vermelho de lá. Um {npc:11876} (37) aparece: mate-o para pegar {item:13542}.",
	["On the top floor"] = "No último andar",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal (no name in this language: may be words)
	["{item:14523}, on the {object:176581}"] = "{item:14523}, no {object:176581}",

	-- Step 36: Ethel Rethor
	-- {npc:11863} Azore Aldamort
	["Back west to {npc:11863}."] = "De volta ao oeste, até {npc:11863}.",

	-- Step 37: The Book of the Ancients
	-- {quest:6027} Book of the Ancients
	["The {quest:6027}"] = "O {quest:6027}",
	-- {area:2405} Ethel Rethor · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words) · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}. He is well above you: rest to full first."] = "As nagas Sibilâmina dominam a costa ao norte de {area:2405}. Nade até {area:2406}, no extremo norte, e use {item:15766} no {object:177673}: surge {npc:12369} (38); mate-o para pegar {quest:6027}. Ele está bem acima do seu nível: descanse até ficar com vida cheia antes.",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words)
	["{item:15766}, on the {object:177673}"] = "{item:15766}, no {object:177673}",

	-- Step 39: Sargeron
	-- {area:599} Thunder Axe Fortress · {area:603} Sargeron · {npc:268705} Aka'rai
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["Head east past {area:599} and along the northern hills to the satyrs' ruins of {area:603}. Kill every kind you meet for {npc:268705}; the Shadowstalkers walk unseen.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "Siga para leste, passando por {area:599} e pelas colinas do norte, até as ruínas dos sátiros de {area:603}. Mate todos os tipos que encontrar para {npc:268705}; os Assombrantes andam sem serem vistos.\nCuidado: os Errantes Furiódio usam Esconder ao surgir, então ficam furtivos até você encontrá-los.",
	-- {npc:4671} Hatefury Trickster
	["{npc:4671}, on the way south"] = "{npc:4671}, no caminho para o sul",

	-- Step 40: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["South to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "Ao sul, até {area:609}. {quest:1365} (35) anda entre as tendas do lado leste com um ou dois Senhores de Batalha (32-33): limpe em volta dele, depois puxe-o sozinho, com vida cheia.\nCuidado: os Senhores de Batalha Kolkar chamam aliados num raio de 30 metros quando caem a 20% de vida.",

	-- Step 41: Ghost Walker Post
	["South-west down the road to the post."] = "Desça a estrada para o sudoeste até o posto.",
	-- {npc:5641} Takata Steelblade · {npc:5640} Keldran · {zone:1454} Orgrimmar
	["{npc:5641}: for {npc:5640} in {zone:1454}, next guide"] = "{npc:5641}: para {npc:5640}, em {zone:1454}, no próximo guia",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "A próxima tarefa de {npc:5641} manda você atrás de um senhor demoníaco com uma guarda de elite: pule-a.",
	-- {zone:1443} Desolace
	["for the second {zone:1443} visit, in forever/horde/30-40/04-dustwallow-marsh"] = "para a segunda visita a {zone:1443}, em forever/horde/30-40/04-dustwallow-marsh",

	-- Step 42: Shadowprey Village
	["West to Shadowprey: your hearthstone is bound there."] = "A oeste, até Pescassombra: sua Pedra de Regresso está vinculada lá.",
	-- {npc:268705} Aka'rai
	["{npc:268705}, on the path just north of the village"] = "{npc:268705}, na trilha logo ao norte da aldeia",
	-- {npc:11624} Taiga Wisemane · {zone:1443} Desolace · {zone:1454} Orgrimmar · {zone:1434} Stranglethorn Vale
	["{npc:11624}'s Portals of the Legion and {zone:1443}'s other 38-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "Os Portais para a Legião de {npc:11624} e as outras missões de {zone:1443} dos níveis 38-40 ficam para a segunda visita, no nível 38: os próximos guias voam para {zone:1454} e pegam o zepelim para {zone:1434}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Suba a costa para o norte. Os Mariscos de Casca Mole Gigantes ficam na água rasa e os Tiscorais Enfurecidos andam pela praia; abra cada marisco nas bolsas para pegar a carne.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}; {npc:12369} guards the {quest:6027} at the far northern tip."] = "Os nagas Sibilâmina ocupam a costa ao norte de {area:2405}. {npc:12369} guarda o {quest:6027} na ponta extrema do norte.",
	-- ["{zone:1443}'s quests are 33-38. Below 32.5? Keep killing the Sparkleshell Snappers near the silithid dig and the Saltstone Gazers south of it until level 32.5. Or, with a group, run the {area:796} dungeon (Graveyard or Library) instead."] = "As missões de {zone:1443} são de nível 33-38. Abaixo de 32.5? Continue matando as Tartaliscas Quelobrilho perto da escavação dos silitídeos e os Observadores Sal-gema ao sul dela até o nível 32.5. Ou, em grupo, faça a masmorra {area:796} (Cemitério ou Biblioteca).",
}
