-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Cavalgue para o oeste, até o forte murado no meio do deserto. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",

	-- Step 2: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: vá matando estes pelo caminho",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Dragatacas, Escorpídeos Petraçoite e Rastejantes da Areia dividem as areias logo ao norte do forte.",

	-- Step 3: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Os fragmentos brilhantes de tabuleta ficam em volta do acampamento do Crepúsculo no extremo noroeste; as Tempestades de Poeira e os Estrondores do Deserto de lá também os deixam cair.",

	-- Step 4: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",

	-- Step 5: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "De volta à Vila do Vento Sul, suba a torre. Mexer na colmeia do alto faz sair Emboscadores da Colme'Ashi; um deles leva o {item:17346}.",

	-- Step 6: The Spirits of Southwind
	["The Spirits of Southwind"] = "Os espíritos de Vento Sul",
	["Inside"] = "Lá dentro",

	-- Step 7: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Cavalgue para sudeste até o {area:3447}, sob os penhascos de Un'Goro.",
	["Below ground"] = "No subterrâneo",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "{item:20377}, de {npc:11739}, 130 metros a sudoeste",

	-- Step 8: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Dragasmagas e Tenazes",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Siga para o norte pelas dunas do oeste; Dragasmagas e Tenazes Petraçoite vão daqui até o forte.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741} anda por {area:2738}: procure dentro do círculo no mapa",

	-- Step 9: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Cavalgue para oeste até o acampamento da Horda ao norte da {area:2744}.",

	-- Step 10: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Gêiseres de silitista entram em erupção pelo deserto do sul. Entre no silitista que um deles deixa e leve-o ao extrator de silitista da Horda no acampamento de Kyríala; lutar ou montar faz você largá-lo.",

	-- Step 11: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Esfoladores e Espreitadoras de Rocha",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Esfoladores Petraçoite e Espreitadoras de Rocha vagam pelas dunas a sudoeste do acampamento de Kyríala.",

	-- Step 12: Twilight Vanguard
	["Twilight Vanguard"] = "Vanguarda do Crepúsculo",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803} anda pelo acampamento da Vanguarda, no extremo sudoeste. Guarde cada {item:20404} que os sectários deixarem cair: {npc:15306} e Ortell querem dez cada um mais tarde.",

	-- Step 14: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} ocupa o acampamento no oeste.",

	-- Step 15: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804} fica no posto a oeste de {area:3425}. Guarde também os Textos Codificados do Crepúsculo que caírem aqui.",

	-- Step 16: Level 58
	["Level 58"] = "Nível 58",
	-- {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia · {area:3425} Cenarion Hold · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger
	["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Twilight Avengers, Geolords and Stonecallers west of the outpost. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{quest:8304}, de {npc:15181}, em {area:3425}, exige nível 58: complete nos Vingadores, Geolordes e Petrazes do Crepúsculo a oeste do posto. Ou, em grupo, faça a masmorra {area:1583} (Inferior) ou a masmorra {quest:838}.",
	-- {npc:11880} Twilight Avenger
	["grind on {npc:11880}"] = "mate {npc:11880} até subir",

	-- Step 17: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} e {npc:15190} ficam no andar de cima do prédio deles: suba por dentro, a seta não distingue os andares.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, no lado oeste do Forte",

	-- Step 18: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Cavalgue para nordeste até o {area:3447}.",

	-- Step 19: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "A algibeira está nas montanhas do extremo sul, depois do Acampamento Barbabronze. Agarramata, um escorpídeo de elite, patrulha por perto: pegue-a enquanto ele estiver longe.",

	-- Step 20: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171} e {npc:15170} acampam no Acampamento Barbabronze, logo ao norte das montanhas da bolsa. Interrogue-os: passe por toda a conversa de cada um; não precisa lutar com eles.",

	-- Step 21: Twilight Base Camp
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "Junte vinte Textos Codificados do Crepúsculo dos sectários daqui, dez para {npc:15306} e dez para Ortell.",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "dez para cada missão: {npc:15306} recebe os dele antes de Ortell",

	-- Step 22: Twilight Base Camp
	["The spare texts from the cultists"] = "Os textos que sobraram dos sectários",

	-- Step 23: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "De volta ao {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "A próxima tarefa de Mar'alith, No ventre da loucura, leva você a {area:2744} entre elites. Pule.",

	-- Step 25: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Cavalgue para nordeste até o {area:3077}; você sai de {zone:1451} pelo desfiladeiro ao lado.",

	-- Step 27: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Pela passagem e a leste ao longo dos penhascos do norte até {area:541}. {npc:9997} fica ao lado do mestre de voo.",

	-- Step 28: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "O goblin {npc:10302} fica em {area:543}, logo a leste do pilar.",

	-- Step 29: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Siga para o leste até {area:537}, suba e use {npc:10541} na fenda de lava perto do topo; depois volte para o oeste até {npc:10302}.",

	-- Step 30: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} manda você até {npc:9298} em {zone:1452}: guarde.",

	-- Step 31: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "Use {item:11833} onde a seta apontar, dentro da colmeia Gorishi de {area:540}, para chamar {npc:10041} (nível 56).",

	-- Step 32: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarde a isca: {npc:9684} é nível 56, e a segunda volta passa pelo covil dele.",

	-- Step 33: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "O covil de {npc:9684} fica logo ao sul do pilar. Use a isca de {npc:9619} ali; {npc:9684} é nível 56 e bate forte, então comece com a vida cheia.",

	-- Step 34: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}: vá matando estes pelo caminho",
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Cuidado: os Gorilas de Un'Goro (nível 50-51) chamam ajuda de aliados num raio de 20 metros quando caem para 25% de vida. Tem uma caverna lotada de macacos na área, e lutar lá traz monstro a mais de montão.",

	-- Step 35: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117} is inside the cave."] = "{npc:9117} está dentro da caverna.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Guarde {quest:3942}: {npc:9116} está no {area:2479}, no caminho do próximo guia por {zone:1448}.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Use o {npc:10980} em {npc:10977}",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 36: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} está sentado na serra, perdido e exausto.",

	-- Step 37: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Agora {npc:9619} pede a pele de {npc:9622}, lá na caverna a nordeste: pule.",

	-- Step 41: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Voe até {area:976}. O {object:142071} fica no meio da cidade.",

	-- Step 42: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 43: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 44: Paladin trainer
	["Paladin trainer"] = "Instrutor de paladino",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {zone:1454} não tem instrutor de paladino",

	-- Step 47: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 50: Radley and Durgen
	["Radley and Durgen"] = "Eiras e Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} fica a leste do acampamento madeireiro; {npc:11611} guarda a estrada a nordeste de {npc:11610}, rumo a {area:190}.\nCuidado: há guardas na base da torre e mais um patrulhando em volta dela. Limpe-os antes de encarar o Durgen, para eles não entrarem na briga.",

	-- Step 51: Northridge Lumber Camp
	-- {npc:11615} Mickey Levine
	["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "A serraria fica bem ao lado de Eiras: largue o barril de cupins de {npc:11615} no meio dela.",

	-- Step 53: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "O incunábulo fica mais ao norte, no caminho para {area:190}.",

	-- Step 54: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Os Escarlates de {area:190} são nível 58-60. Entre cavalgando até o ponto alto marcado no mapa, dê uma olhada na cidade e caia fora.\nCuidado: as sentinelas do portão detectam jogadores furtivos. Há mais sentinelas dentro da cidade, e um elite faz patrulha ali perto.",

	-- Step 56: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Torres de vigia e silos de Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Cavalgue para o sul até Andorhal. {npc:10667} espera na estalagem em ruínas no lado oeste da cidade. Fique na porta de cada uma das quatro torres com a {item:12815} para marcá-la; mantenha-se nas bordas da cidade. Use o {item:12627} junto aos silos no meio da cidade para fazer sair Parasitas Temporais.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, no andar de cima",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marque a {npc:10903} com a {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marque a {npc:10904} com a {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marque a {npc:10905} com a {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marque a {npc:10902} com a {item:12815}",

	-- Step 57: Chromie
	["Upstairs"] = "No andar de cima",

	-- Step 58: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "As caixas-fortes ficam nas casas em ruínas de Andorhal, em volta da estalagem de {npc:10667}. Cuidado: carniçais e esqueletos costumam ficar ao lado das caixas e atacam quando você chega perto. Os Carniçais Ardentes também ferem quem estiver por perto e quebram a furtividade.",

	-- Step 63: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Para leste pela estrada, {npc:11077} guarda o caldeirão nas {area:200}.",

	-- Step 65: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "O escudo fica em {area:201}, ao sul da cabana de {npc:1855}.",

	-- Step 66: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Cavalgue para leste até a cabana de {npc:1855} junto ao {area:2619} e ouça o que ele tem a dizer.",

	-- Step 69: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeões do Flagelo",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Campeões do Flagelo vagam pela {area:2270}, ao norte da capela. Passe o {item:13156} de {npc:11063} sobre cada um que matar: os crânios que ressoam são os que ele quer.",

	-- Step 71: Hameya's scroll
	["Hameya's scroll"] = "O pergaminho de Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Um pergaminho rasgado está na entrada da {area:2261}, a cripta ao sul da {area:2260}.",

	-- Step 72: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "Pâmela e {area:2261}",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cavalgue até {area:2262}, no sudoeste; a Pâmela brinca entre as casas. {npc:11886} espreita em {area:2261}, a cripta logo a oeste da cidade.\nCuidado: uns quatro capangas não elite vêm com o Mercutio. Eles caminham até o túmulo em vez de aparecer ali na hora.",

	-- Step 74: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Cavalgue para noroeste até a cabana de {npc:1855}.",

	-- Step 77: Level 59.14
	["Level 59.14"] = "Nível 59.14",
	-- {quest:6135} Duskwing, Oh How I Hate Thee... · {quest:838} Scholomance · {area:2279} Stratholme
	["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "Se você pulou {quest:6135}, mate monstros aqui até o nível 59.14 para seguir o plano da rota. Ou, em grupo, faça a masmorra {quest:838} ou a masmorra {area:2279}.",
	-- {npc:10717} Temporal Parasite
	["grind on {npc:10717}"] = "mate {npc:10717} até subir",

	-- Step 78: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Cavalgue para sudoeste até {npc:10667} em Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "A batalha pela Vila das Flechas de {npc:10667} termina contra elites. Pule-a.",

	-- Step 79: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "Volte para oeste até a {area:152}.",

	-- Step 80: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Rumo a {zone:1423}",

	-- Step 81: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 82: Of Lost Honor
	["Underwater"] = "Debaixo d'água",

	-- Step 83: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Hameya se esconde entre os trolls Esfolamusgo de {area:2273}, no canto nordeste.\nCuidado: os trolls do caminho até {area:2273} são nível 57-59. Fogem com pouca vida e chamam ajuda, então costumam trazer reforço.",

	-- Step 85: Hameya's mound
	["Hameya's mound"] = "O monte de Hameya",
	-- {npc:1855} Tirion Fordring · {area:2261} Undercroft · {object:177675} Mound of Dirt
	["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "Cavalgue para sudeste, saindo de {npc:1855}, até {area:2261}; o {object:177675} fica logo atrás.",

	-- Step 86: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "Rumo a {zone:1422}",

	-- Step 89: Target: Writhing Haunt
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark
	["from the cauldron, for {npc:11055} at the {area:152}"] = "do caldeirão, para {npc:11055} em {area:152}",

	-- Step 91: Target: Gahrron's Withering
	-- {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "De volta a leste, passando por {area:202}, até {area:201}, a fazenda sob as colinas do leste: {npc:11078} guarda o caldeirão de lá. Mate-o para pegar a chave e depois use o caldeirão.",

	-- Step 92: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "A oeste, até {area:152}, uma última vez.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Trépido oferece {item:14619} ({quest:838}). Pule-a.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Dragatacas, Escorpídeos Petraçoite e Rastejantes da Areia dividem as areias logo ao norte do forte.",
	-- ["Dredge and scorpids"] = "Dragas e escorpídeos",
	-- ["Fly to {area:1637} and train."] = "Voe até {area:1637} e treine.",
	-- ["Fly to {area:541}"] = "Voe para {area:541}",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Querida Natália, de Mar'alith, requer nível 58 e leva à {area:2744} entre elites. Pule-a.",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Para o norte até a madeireira; coloque o barril de cupins no meio da serraria.",
	-- ["Ride east across the plaguelands to the chapel."] = "Cavalgue para leste pelas terras pestilentas até a capela.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Cavalgue para leste pela estrada até o {area:152}, na divisa.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cavalgue para sudoeste até as ruínas da {area:2738}. O {object:179565} para {npc:11801} fica dentro de uma das casas em ruínas.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Cavalgue até {area:2262}, no sudoeste; {npc:10926} brinca entre as casas. {npc:11886} espreita na {area:2261}, a cripta logo a oeste da cidade.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Cavalgue para oeste até o forte murado no meio do deserto.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Pegue o zepelim na torre do lado de fora de {area:1637} até {zone:1420} e entre em {zone:1458}. Lady Sylvana ocupa o {object:36126}.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Os fragmentos brilhantes de tabuleta ficam em volta do acampamento do Crepúsculo no extremo noroeste; as Tempestades de Poeira e os Estrondores do Deserto de lá também os deixam cair.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "O desfiladeiro vindo de Un'Goro sai no {area:3077}, o cemitério no nordeste de {zone:1451}. {npc:13220} fica entre os túmulos.",
	-- ["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "O {object:177675} fica logo atrás da {area:2261}.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave."] = "Atravesse o desfiladeiro e siga para leste pelos penhascos do norte até o {area:541}. {npc:8737} fica junto à caverna.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Para oeste até o {area:152}. O próximo guia começa em {zone:1458}, a uma curta cavalgada a oeste.",
	-- ["{area:1099} flight master"] = "Mestre de voo de {area:1099}",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "A fazenda de {npc:10778} é a primeira a leste do {area:152}. Carniçais Grasnantes na fazenda levam a outra metade do amuleto dela; {npc:11075} guarda o caldeirão no campo.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} e a {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "A tarefa da própria {npc:10926} não está nesta rota. Pule-a.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} anda pelo acampamento da Vanguarda no extremo sudoeste. Todo sectário daqui deixa cair Textos Codificados do Crepúsculo, com missão ou não: junte vinte, dez para {npc:15306} e dez para Ortell.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} fica no posto avançado a oeste do {area:3425}. Complete seus Textos Codificados do Crepúsculo até vinte com os sectários daqui.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "As tarefas de {npc:11878} não estão nesta rota. Pule-as.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "O campeão da {npc:15193} ocupa a casa da {area:2260}, ao norte da {area:2261}.",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, no lado oeste do Forte",
	-- ["{npc:15306}, on the west side of the Hold: the texts are already in your bags"] = "{npc:15306}, no lado oeste do Forte: os textos já estão nas suas bolsas",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "A próxima tarefa de {npc:1855}, Da honra perdida, não está nesta rota. Pule-a.",
	-- ["{npc:9167} walks around here: look inside the circle on the map"] = "{npc:9167} anda por aqui: procure dentro do círculo no mapa",
}
