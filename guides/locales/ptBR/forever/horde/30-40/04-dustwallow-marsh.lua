-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
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

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para Zé \"Olho de Lama\"",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor (no name in this language: may be words) · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "{npc:3354}, {object:172958}: para {area:720}, mais adiante neste guia (oferecida a partir do nível 30)",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "Voe para a Encruzilhada",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} fica ao lado do mestre de voo da Encruzilhada.",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "para {npc:4485}, em {zone:1454}, no fim deste guia",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Voar para o {area:378}",
	["Crossroads flight master"] = "Mestre de voo da Encruzilhada",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Siga para leste de {area:378} pela estrada que entra no pântano. {area:403}, toda queimada, fica ao lado da estrada logo depois da divisa; o escudo, o distintivo e as pegadas de casco estão dentro e em volta da ruína.",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "Pegue a estrada para o norte na bifurcação até a aldeia ogra de Muralha Verde.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, na borda sul da aldeia, onde chega a estrada",

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} espera no {area:2302} a leste da aldeia. Siga-o até Reethe e mantenha-o vivo na luta que começa.",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "Inácio \"Cascão\"",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Siga para o norte até {area:502}. O Cascão fica no pé do morro; escolte-o enquanto ele colhe as folhas logo ao sul dali.",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs Lamapina",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Os murlocs Lamapina lotam a costa a leste e a nordeste do {area:502}; todo tipo deixa cair cabeças.",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Zé \"Olho de Lama\"",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Zé mora no {area:497} a sudeste do {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, ao lado do solar",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "{quest:1218}, se você não comprou em {zone:1454}",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "{area:496}: vá matando estes pelo caminho",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Atravesse o pântano de volta para oeste. As Cospeçonhas Presanegra nas cristas ao norte da Muralha Verde deixam cair as bolsas de veneno. Infiltradores de Theramore (35-36) se esgueiram pela mesma mata: estão furtivos, então olhe com atenção.\nAs aranhas Névoa Negra infestam a entrada da caverna a noroeste da Muralha Verde; todo tipo deixa cair olhos.\nCuidado: as Tocaieiras Presanegra (nível 36-37) ficam furtivas fora de combate e soltam Veneno quando a luta começa.\nCuidado: aranhas furtivas da mesma área atacam assim que veem você.\nCuidado: as Tocaieiras Névoa Negra andam furtivas e usam veneno no combate. As aranhas ficam bem juntas, então é comum vir monstro a mais; puxar um alvo de cada vez pela borda ajuda.",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Head east back to the {area:497}."] = "Volte para leste até {area:497}.",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, agora que {npc:4791} leu o relatório",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "só se você tiver uma {item:3853} ({skill:164} ou a Casa de Leilões)",

	-- Step 18: The Theramore Docks
	["Underwater"] = "Debaixo d'água",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "Volte para o oeste, até a Aldeia Muralha Verde, com a cabeça: {npc:4503} fica na borda sul da aldeia, onde a estrada chega, e {npc:4791}, na aldeia.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "Para {npc:2519} em {object:3202}, em forever/horde/40-50/01-stranglethorn-vale",

	-- Step 20: Level 37.5
	["Level 37.5"] = "Nível 37.5",
	-- {zone:1443} Desolace · {area:1316} Razorfen Downs · {area:796} Scarlet Monastery
	["{zone:1443}'s last quests and Alterac are 38-41. Still below 37.5 after Brackenwall's hand-ins? The Darkmist spiders and Lurkers (35-38) by the cavern north-west of the village are the closest: kill them until level 37.5. Or, with a group, run the {area:1316} dungeon or the {area:796} dungeon (Armory) instead."] = "As últimas missões de {zone:1443} e Alterac são de nível 38-41. Ainda abaixo de 37.5 depois das entregas de Muralha Verde? As aranhas e Tocaieiras Névoa Negra (35-38) perto da caverna a noroeste da aldeia são as mais próximas: mate-as até o nível 37.5. Ou, em grupo, faça a masmorra {area:1316} ou a masmorra {area:796} (Armaria).",
	["Darkmist cavern"] = "Caverna Névoa Negra",
	-- {npc:4377} Darkmist Lurker
	["grind on {npc:4377}"] = "mate {npc:4377} até subir",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voe para {area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "Mestre de voo de {area:496}",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {npc:3446} Mebok Mizzyrix
	["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "{npc:3391} espera no andar de cima da casa junto ao mestre de voo; {npc:3446} fica no andar de baixo, rumo às docas.",
	-- {npc:3391} Gazlowe · {area:35} Booty Bay
	["{npc:3391}'s next errand takes you to {area:35}, off this part of the route: leave it."] = "A próxima tarefa de {npc:3391} leva você a {area:35}, fora desta parte da rota: deixe de lado.",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}, nas docas",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "As peças de Caruncho voltam para Kravel em {area:439}, fora da rota: deixe-as.",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Siga para o sul pela costa de {area:392} até {area:720}. {npc:6236} fica junto à arena: pise na grade para começar a luta; os desafiantes vêm um de cada vez e, por fim, {npc:6238} (33).",

	-- Step 24: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Voe para {area:2408}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "{npc:11624} fica na aldeia.",

	-- Step 26: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "Siga para leste até {area:602}. Com {quest:5381}, de {npc:11624}, nas bolsas, abra o anel de um portal demoníaco: sai um {npc:11937} (38-39); mate-o para fechar esse portal. São seis portais. Cuidado: Infernais, Demonarcas e Evocadores da Lâmina Ardente andam perto de muitos portais e podem entrar na briga; mate os mobs próximos primeiro ou arraste o guardião para longe, por exemplo em direção ao lago central do covil.",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "Ao norte, até o posto; {npc:5412} fica ao lado de {npc:5395}.",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the {area:607}. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}."] = "A oeste do posto, os centauros Maraudinos ocupam {area:607}. Todo Maraudino pode deixar cair {item:254432} e uma orelha para {quest:1366}, de {npc:5395}.",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está presa no acampamento Maraudino, na ponta oeste do vale; liberte-a e escolte-a para fora, a leste do vale.\nCuidado: os grupos da escolta vêm juntos e só aparecem durante ela, então não dá para limpar antes nem puxar um de cada vez. Limpar os centauros comuns do caminho antes de começar ajuda.",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} espera no acampamento goblin no lado oeste do {area:596}.",

	-- Step 31: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "Siga para sudeste até os campos de ossos de {area:2657}, onde Assoladores Mortos-vivos vagam. No extremo sudeste, use {item:15848} para atrair os Espectros Magrami: eles deixam cair o fantasmoplasma.",

	-- Step 32: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard
	["North to the goblin camp on the west side of the {area:596}."] = "Ao norte, até o acampamento goblin no lado oeste de {area:596}.",

	-- Step 34: Shadowprey
	["Shadowprey"] = "Pescassombra",
	["West to Shadowprey."] = "A oeste, até Pescassombra.",

	-- Step 35: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Voe de {area:2408} para {area:1638} e treine com {npc:3033} em {area:1639}; de lá, siga voando até {zone:1454}.",

	-- Step 36: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Mestre de voo da {area:2408}",

	-- Step 37: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "De volta a {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words)
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485} fica em {object:172958}.",

	-- Step 39: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "A oficina de {npc:3412} fica em {object:172958}, ao lado de {npc:4485}: entregue {quest:2841} se você fez {area:133}.",

	-- Step 40: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Instrutores de {zone:1454}",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "Treine enquanto estiver na cidade; todos os outros treinam em {zone:1458}, em seguida.",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "O próximo guia pega o zepelim de {zone:1458} na torre fora do portão principal.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "Aranhas Presanegra",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Para {npc:2519} em {object:3202}, no próximo guia",
	-- ["Head east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "Siga para leste até {area:602}. Use o bastão de banimento junto a cada portal demoníaco para fechar seis deles.\nCuidado: Infernais, Demonarcas e Evocadores da Lâmina Ardente andam perto de vários portais e podem entrar na briga; mate os monstros por perto primeiro ou arraste o guardião para longe, por exemplo rumo ao lago central do conciliábulo.",
	-- ["Hearth to Shadowprey"] = "Regressar para a Aldeia Pescassombra",
	-- ["Hearth to {area:392}"] = "Regressar para {area:392}",
	-- ["Kodo bones and ghosts"] = "Ossos de kodo e fantasmas",
	-- ["Maraudine totems"] = "Totens Maraudinos",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Pegue os Ossos de Kodo espalhados pelo cemitério e use o {item:15848} entre os ossos: os fantasmas que ele atrai deixam cair o fantasmoplasma.",
	-- ["Ride back west to Brackenwall with the head."] = "Cavalgue de volta para oeste até Muralha Verde com a cabeça.",
	-- ["Ride east back to the {area:497}."] = "Cavalgue para leste de volta ao {area:497}.",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Cavalgue para leste do {area:378} pela estrada até o pântano. A {area:403} queimada fica ao lado dela, logo depois da divisa; o escudo, o distintivo e as pegadas estão dentro e ao lado da ruína.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Cavalgue para leste até o {area:602}. Use o bastão de banimento junto a cada portal demoníaco para fechar seis deles.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Cavalgue para o norte do conciliábulo até {npc:5412} no {area:597}.",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Cavalgue para o norte até o {area:502}. Cascão fica ao pé do morro; escolte-o enquanto ele colhe folhas de feijão-do-brejo logo ao sul.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Cavalgue para o norte pela estrada até a cabana junto à estrada ao norte do cemitério.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Cavalgue para nordeste até o {area:607}. {npc:12277} está presa no acampamento dos centauros Maraudinos; liberte-a e escolte-a para fora, a leste do vale.",
	-- ["Ride on south-west to Shadowprey."] = "Siga cavalgando para sudoeste até a Aldeia Pescassombra.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Cavalgue para o sul de {area:2405} até o {area:607}. Os Batedores, Cavalgantes, Espancadores, Ventilhãs e Espoliadores Maraudinos (36-39) deixam cair os {quest:93225}.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Cavalgue para oeste atravessando o pântano. Os Cospeçonhas Presanegra nas cristas ao norte de Muralha Verde deixam cair as glândulas de veneno. Infiltradores de Theramore (35-36) se esgueiram pela mesma mata: estão furtivos, então olhe com atenção.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Cavalgue para oeste até a torre de {npc:11863} em {area:2405}, na costa noroeste.",
	-- ["Slitherblade coast"] = "Costa dos Sibilâmina",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Lâmina Ardente ocupa a fortaleza a noroeste de {area:2407}. Use a {item:14523} no {npc:11876} da fortaleza para obter a {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "As aranhas Névoa Negra lotam a entrada da caverna a noroeste de Muralha Verde; todo tipo deixa cair olhos.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Os nagas Sibilâmina ocupam a costa ao norte de {area:2405}, até a {area:598}. {npc:12369} guarda o {quest:6027} na ponta norte.",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "A caravana termina no acampamento de {npc:11596}, no lado leste do {area:596}.",
	-- ["The next guide takes you back to {zone:1434}."] = "O próximo guia leva você de volta à {zone:1434}.",
	-- ["grind on {npc:4362}"] = "mate {npc:4362} até subir",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "A caravana de {npc:11626} para na estrada na borda do {area:602}. Escolte-a para leste passando o conciliábulo; demônios a atacam duas vezes.",
	-- ["{npc:3412}, in the {object:172958} beside {npc:4485}: {quest:2841}, if you ran {area:133}"] = "{npc:3412}, em {object:172958}, ao lado de {npc:4485}: {quest:2841}, se você fez {area:133}",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} e {npc:5412} ficam no posto logo a oeste do acampamento de {npc:11596}.",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{zone:1443}'s last quests and Alterac are 38-41. Below 37.5? Keep killing the Mirefin murlocs along the north-east coast, past {area:502}, until level 37.5. Or, with a group, run the {area:1316} dungeon or the {area:796} dungeon (Armory) instead."] = "As últimas missões de {zone:1443} e Alterac são de nível 38-41. Abaixo de 37.5? Continue matando os murlocs Lamapina na costa nordeste, passando por {area:502}, até o nível 37.5. Ou, em grupo, faça a masmorra {area:1316} ou a masmorra {area:796} (Arsenal).",
}
