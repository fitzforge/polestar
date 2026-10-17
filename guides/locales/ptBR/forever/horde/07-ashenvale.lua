-- Portuguese (Brazil) (ptBR): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale
	["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "Voe de {area:392} até o {area:2897}, na costa de {zone:1440}.",
	-- {npc:12717} Muglash
	["{npc:12717}: starts his escort at once"] = "{npc:12717}: começa a escolta dele na hora",

	-- Step 2: Vorsha the Lasher
	-- {npc:12717} Muglash
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717} anda para o norte pela praia até um braseiro naga. Apague o braseiro e depois proteja-o das ondas de nagas até Vorsha morrer.",
	["Naga brazier"] = "Braseiro naga",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "Ruínas das {area:2797}",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "O caminho até as Safiras passa pelas ruínas submersas no extremo norte da praia: desça as escadas até o fosso.",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "Safiras de Aku'Mai",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "As Safiras são cristais azuis nas paredes dos túneis que levam ao portal das {area:2797}, no subsolo e fora da instância: nade para baixo a partir do fosso, por baixo da parede, até a caverna. Os sátiros e nagas dos túneis são elite: é recomendado formar grupo. Os cristais reaparecem rápido, então não é preciso ir fundo.",

	-- Step 5: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "{npc:12736} oferece em seguida uma missão das {area:2797}; deixe-a de lado a menos que tenha um grupo.",

	-- Step 6: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "A leste de Zoram'gar, os furbolgs Pelocardo enchem a aldeia e as colinas em volta da toca deles.",

	-- Step 7: Thistlefur Hold
	["Thistlefur Hold"] = "Toca dos Pelocardo",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "Dentro da toca, Baús dos Trolls ficam ao longo dos túneis. {npc:12818} está preso lá no fundo: liberte-o e proteja-o até a saída, depois ele corre para casa em {area:428}.",

	-- Step 8: Zoram'gar Outpost
	["Back west to Zoram'gar before heading east for good."] = "De volta a oeste até Zoram'gar antes de seguir para o leste de vez.",

	-- Step 9: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "Siga a estrada principal para leste passando {area:415} (Aliança: fique na estrada). {npc:12678}, um urso-pardo grande, vaga pelas {area:418} ao sul da estrada, a oeste do {area:421}. A pata dele inicia a próxima missão de caça.",

	-- Step 10: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "Fonte das {area:418}",
	-- {area:418} Ruins of Stardust · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "A fonte fica no meio das {area:418}: use o {item:7767} lá.",

	-- Step 11: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}, uma novidade do Forever, fica na margem oeste do {area:421} com três missões rápidas de Matadragões.",

	-- Step 12: Tideress
	-- {npc:12759} Tideress · {area:421} Mystral Lake · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}, um elemental da água corrompido, flutua no {area:421}. O {item:16408} dela inicia uma missão para o Posto Machadada.",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "Os furbolgs Torpeflora ocupam a mata a leste do {area:421}, ao sul da estrada. Coloque o {item:16972} no {object:178206} e proteja-o: os furbolgs vêm derrubá-lo. {npc:12918} vem por último; o totem dele cai no cesto.",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "Continue para leste pela estrada. {npc:12858} espera a sudoeste do Acampamento de Lenhadores Brado Guerreiro. Ele e seus peões invadem o {area:2360}: deixe que eles atraiam a ameaça e fique com {npc:12858} até {npc:12860} morrer.",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} fica no acampamento de lenhadores. Os Vanguardeiros elfos noturnos rondam a mata a sudeste dele; eles ficam furtivos, então fique atento.",

	-- Step 16: Splintertree Post
	-- {area:431} Splintertree Post · {area:428} Night Run
	["North up the road to {area:431} and {area:428} beside it."] = "Para o norte pela estrada até o {area:431} e {area:428} ao lado.",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}: só se você tiver as páginas do manual",

	-- Step 17: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}, uma grande sabre-noturno, ronda a mata a sudeste do Acampamento de Lenhadores Brado Guerreiro. A garra dela inicia a próxima missão de caça.",

	-- Step 18: Felmusk satyrs
	["Felmusk satyrs"] = "Sátiros Malmíscar",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "A noroeste do Posto Machadada, os sátiros Malmíscar acampam na mata. Todo sátiro pode deixar cair chifres.",

	-- Step 19: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}, uma pantera das sombras, ronda a mata em volta do {area:426}, a oeste do acampamento Malmíscar. A cabeça dela inicia a próxima missão de caça.",

	-- Step 20: Mystral Lake
	-- {area:421} Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "De volta a sudoeste até o {area:421}. Elementais da Água Contaminados flutuam pelas margens; o gazebo fica na ilha, com vista para o posto avançado da Aliança.",
	["Gazebo"] = "Gazebo",

	-- Step 23: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {npc:2995} Tal
	["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Voe até {area:1638} se conhecer a rota de voo. Se não, voe até o {area:378}, cavalgue para oeste por {zone:1412} passando a {area:222} até {area:1638} e pegue a rota de voo com {npc:2995} na elevação central.",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "Fale com {npc:3057}, em {area:1638}: {quest:93739}",

	-- Step 24: The Earthen Ring
	["The Earthen Ring"] = "A Harmonia Telúrica",
	-- {zone:1456} Thunder Bluff · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury
	["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "Desça de {zone:1456} por um elevador. O acampamento da Harmonia Telúrica fica ao norte dos penhascos: {npc:264074}, {npc:264072} e {npc:259118}.",

	-- Step 25: Gloomrise
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "Ao norte do acampamento, aranhas infestam o cemitério em {area:17044}. Use o {item:273015} de {npc:264074} nos Cadáveres Roídos; as Tecelãs deixam cair a {item:273181}. {npc:264082} fica no extremo norte: o {item:273658} dela inicia {quest:96294}.",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "Amostras de Toxina de Penumbrascente, dos Cadáveres Roídos ({npc:264096})",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, das Tecelãs de Penumbrascente ({npc:264081})",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{item:273658}, de {npc:264082}",

	-- Step 26: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "De volta ao sul até o acampamento, depois suba até {zone:1456} para o voo até o {area:378}.",

	-- Step 27: Brine
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {npc:5899} Brine · {area:1718} Great Lift
	["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "Voe de {zone:1456} até o {area:378}. A cabana de {npc:5899} fica na crista acima do bebedouro dos javalis ao sul do acampamento, na estrada para o {area:1718}.",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "para {npc:5901}, ao sul de {area:392}: próximo guia",

	-- Step 28: Great Lift
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {zone:1413} Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "Voe de {zone:1456} até o {area:378} e pegue a estrada para o sul até o {area:1718}, no extremo sul de {zone:1413}.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, no alto do elevador",

	-- Step 29: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "Desça de elevador e siga a estrada para leste pelos cânions até {area:484}, uma aldeia tauren no alto das mesetas. O elevador dela fica no lado norte.",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}, perto do mestre de mantícoras",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}, a mercadora de suprimentos de profissão: as harpias Guinchadoras do {area:487}",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "O cartaz de procura-se ao lado do {npc:10537} do Rochedo",

	-- Step 30: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "Desça de elevador. O ovo está num ninho no fundo do cânion em um de três lugares: a sudeste das mesetas (52.3,55.2), a leste (56.4,50.4) ou a sudoeste (37.6,56.1).",

	-- Step 32: Galak centaurs
	["Galak centaurs"] = "Centauros Galath",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "Os acampamentos Galath enchem o cânion ao norte da Aldeia Vento Livre; Batedores, Cavalgantes e Ventilhãs dividem todos os acampamentos. Um {npc:10617} solitário anda entre os acampamentos: mate-o quando o encontrar, o bilhete dele inicia uma missão para o {area:2237}.",

	-- Step 33: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986} fica no alto de uma meseta a leste dos acampamentos Galath. Para o {quest:1149}, ande até o fim das tábuas ao lado dele: você cai em segurança.",

	-- Step 35: Grimtotem camps
	["Grimtotem camps"] = "Acampamentos Temível Totem",
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "A oeste da Aldeia Vento Livre, os acampamentos Temível Totem abaixo do {area:2097}. Os Bilhetes Secretos estão em Baús de Documentos nos acampamentos sudeste, sudoeste e noroeste.",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, acampamento sudeste",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, acampamento sudoeste",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, acampamento noroeste",

	-- Step 36: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "Suba a trilha até o alto do {area:2097}. {npc:10646} está presa ao lado de {npc:10896} (29): elimine os guardas e {npc:10896} primeiro, depois liberte-a e proteja-a na descida; emboscadores Temível Totem atacam você no caminho.",

	-- Step 37: Whitereach Post
	-- {area:2237} Whitereach Post
	["Follow the canyon west to {area:2237}."] = "Siga o cânion para oeste até o {area:2237}.",
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "A próxima missão de {npc:10428}, Fogo sagrado, termina em {zone:1456}, fora desta rota. Pule-a.",
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "Mate o {npc:10720} que vem atrás de {npc:10638}",

	-- Step 38: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "A oeste do Posto Confinalvo, as mantícoras fazem ninhos nos penhascos do {area:482}; os ovos ficam nos ninhos. {npc:10427} espera no lado leste dos ninhais: liberte-o e mantenha-o vivo no caminho de volta ao {area:2237}.",

	-- Step 40: Roguefeather Den
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "Ao sul do Pináculo da Nuvem Negra, as harpias do {area:487}. {npc:4490} (31) anda entre elas: reduza as harpias em volta dela antes de atraí-la. As Harpias Guinchadoras, Plumerrantes e Arautos do Vento de lá são de {npc:4877}.",

	-- Step 43: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499} um elemental de rocha que bate forte, anda pelos penhascos do {area:482}. {npc:4499} é elite: é recomendado formar grupo.",

	-- Step 44: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Siga o cânion para leste saindo das mesetas até as planícies salgadas. Os goblins e gnomos do {area:2240} são neutros e dão missões às duas facções.",
	["His crate is for Stranglethorn, later on the route"] = "O caixote dele é para o Espinhaço, mais adiante na rota",

	-- Step 45: The salt flats
	["The salt flats"] = "As planícies salgadas",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "Há {object:19868} por todas as planícies ao norte da pista. Aniquiladores Escorpídeos e Tartarugas Quelobrilho vagam pela metade norte, Catadores da Planície Salgada circulam no alto e Basiliscos Sal-gema pastam a oeste da pista. Os Cristaldermes vagam pelo meio das planícies e os Observadores (34-35, cinco níveis acima de você: um de cada vez) pelo extremo sul.",

	-- Step 46: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}: a carta dele vai para Martek em {zone:1418}, por volta do nível 38",

	-- Step 47: Freewind Post
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to {zone:1454}."] = "O próximo guia voa daqui para {zone:1454}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Shadumbra"] = "Shadumbra",
	-- ["Sharptalon"] = "Garraguda",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Tideress"] = "Mareante",
	-- ["Ursangous"] = "Ursangous",
}
