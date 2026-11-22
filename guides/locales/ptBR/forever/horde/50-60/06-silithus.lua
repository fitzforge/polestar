-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1446} Tanaris
	["{zone:1451}, then Un'Goro and {zone:1446}."] = "",

	-- Step 1: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {area:2249} Frostwhisper Gorge
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["{npc:11118}, in {area:2255}'s inn, has more mail for you: the Ice Thistle Yetis in the hills south-east of town carry it. Keep it for the last guide, whose ride back north from {area:2249} crosses those hills."] = "",

	-- Step 2: Back from Mount Hyjal
	-- {zone:2482} Mount Hyjal
	["Back from {zone:2482}"] = "",
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {area:976} Gadgetzan · {npc:9299} Gaeriyan · {npc:7583} Sprinkle · {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Back from {zone:2482}: fly from {area:2255} to {area:976} for {npc:9299}, {npc:7583} and Pestlezugg, then on to {area:541} and {zone:1451}."] = "",
	["Yugrek, the Horde flight master"] = "",

	-- Step 3: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Beba o {item:11243} no cemitério logo a leste de {area:976}: ele mata você, e só como fantasma você consegue ver {npc:9299}, em uma fenda rochosa nas colinas bem ao norte dele. Fale com ele lá, depois corra de volta ao seu corpo e ressuscite: a Lápide Conspícua para onde ele manda você fica naquele cemitério.",

	-- Step 4: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Use {item:12928} em {npc:7583}, a menina goblin em {area:976}. {npc:10977} e {npc:10978} levam o susto mais adiante na rota.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Assuste {npc:7583} com {item:12928}",

	-- Step 5: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Lá dentro: {quest:4493}, se você a pegou em {zone:1454} no guia de {zone:1447}",

	-- Step 6: Alchemist Pestlezugg
	["Inside"] = "Lá dentro",

	-- Step 7: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} volta para {npc:8737} na Cratera Un'Goro: guarde-a.",

	-- Step 8: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto à estrada da {area:1336}, ao sul de {area:976}.",

	-- Step 9: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Voe para {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 10: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["The flight lands at {area:541}: {npc:8737} stands by the cave a few steps from the flight master, {npc:9117} inside it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	-- was: ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Guarde {quest:3942}: {npc:9116} está no {area:2479}, no caminho do próximo guia por {zone:1448}."
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the last guide's way through {zone:1448}."] = "",
	-- {item:12928} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {item:12928} on {npc:10977}"] = "",
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 11: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "O desfiladeiro vindo de Un'Goro sai no {area:3077}, o cemitério no nordeste de {zone:1451}. {npc:13220} fica entre os túmulos.",

	-- Step 12: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cavalgue para sudoeste até as ruínas da {area:2738}. O {object:179565} para {npc:11801} fica dentro de uma das casas em ruínas.",

	-- Step 14: Cenarion Hold
	-- {area:3077} Valor's Rest · {npc:15189} Beetix Ficklespragg
	-- was: ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Cavalgue para o oeste, até o forte murado no meio do deserto. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares."
	["Ride west from {area:3077} to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 15: Calandrath
	-- {skill:185} Cooking · {npc:15174} Calandrath
	["Cooks with 285 {skill:185} or more: {npc:15174}, the innkeeper you just bound with, wants word of the Twilight's Hammer's sandworm recipe; the cookbook lies in the outpost west of the Hold, where this guide goes later."] = "",

	-- Step 16: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: vá matando estes pelo caminho",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Dragatacas, Escorpídeos Petraçoite e Rastejantes da Areia dividem as areias logo ao norte do forte.",

	-- Step 17: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	-- was: ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Os fragmentos brilhantes de tabuleta ficam em volta do acampamento do Crepúsculo no extremo noroeste; as Tempestades de Poeira e os Estrondores do Deserto de lá também os deixam cair. Cuidado: os maiores Estrondores e os Invasores Rodopiantes são de nível 58: puxe um de cada vez."
	["The glowing tablet fragments lie on the ground around the Twilight camp in the far north-west: pick them up. The Dust Stormers and Desert Rumblers there may carry them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "",

	-- Step 18: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",

	-- Step 19: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "De volta à Vila do Vento Sul, suba a torre. Mexer na colmeia do alto faz sair Emboscadores da Colme'Ashi; um deles leva o {item:17346}.",
	-- {quest:8308} Brann Bronzebeard's Lost Letter · {area:2742} Hive'Ashi
	["{quest:8308}: now and then a {area:2742} silithid carries one; right-click it if it drops"] = "",
	-- {npc:15170} Rutgar Glyphshaper
	["for {npc:15170} at Bronzebeard's Encampment, later in this guide"] = "",

	-- Step 21: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Cavalgue para sudeste até o {area:3447}, sob os penhascos de Un'Goro.",
	["Below ground"] = "No subterrâneo",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "{item:20377}, de {npc:11739}, 130 metros a sudoeste",

	-- Step 22: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Dragasmagas e Tenazes",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Siga para o norte pelas dunas do oeste; Dragasmagas e Tenazes Petraçoite vão daqui até o forte.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741} anda por {area:2738}: procure dentro do círculo no mapa",

	-- Step 23: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Cavalgue para oeste até o acampamento da Horda ao norte da {area:2744}.",

	-- Step 24: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Gêiseres de silitista entram em erupção pelo deserto do sul. Entre no silitista que um deles deixa e leve-o ao extrator de silitista da Horda no acampamento de Kyríala; lutar ou montar faz você largá-lo.",

	-- Step 25: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Esfoladores e Espreitadoras de Rocha",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Esfoladores Petraçoite e Espreitadoras de Rocha vagam pelas dunas a sudoeste do acampamento de Kyríala.",

	-- Step 26: Twilight Vanguard
	["Twilight Vanguard"] = "Vanguarda do Crepúsculo",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803} anda pelo acampamento da Vanguarda, no extremo sudoeste. Guarde cada {item:20404} que os sectários deixarem cair: {npc:15306} e Ortell querem dez cada um mais tarde.",

	-- Step 28: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} ocupa o acampamento no oeste.",

	-- Step 29: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804} fica no posto a oeste de {area:3425}. Guarde também os Textos Codificados do Crepúsculo que caírem aqui.",

	-- Step 30: Sandy Cookbook
	-- {object:180503} Sandy Cookbook · {npc:15174} Calandrath
	["The {object:180503} lies in the outpost: read it and take its torn page back to {npc:15174}."] = "",

	-- Step 31: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} e {npc:15190} ficam no andar de cima do prédio deles: suba por dentro, a seta não distingue os andares.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, no lado oeste do Forte",

	-- Step 32: Calandrath
	-- {npc:15174} Calandrath · {object:180503} Sandy Cookbook
	["{npc:15174}, the innkeeper, takes the {object:180503}'s torn page."] = "",

	-- Step 33: Wanted: Deathclasp
	-- {npc:15196} Deathclasp
	["Wanted: {npc:15196}"] = "",
	-- {npc:15196} Deathclasp · {npc:15190} Noggle Ficklespragg · {npc:15182} Vish Kozus
	["{npc:15196}, Terror of the Sands, is a level 59 elite scorpid patrolling the mountains by {npc:15190}'s satchel, at your level: a group choice. The wanted poster stands in the middle of the Hold; {npc:15182} pays out."] = "",

	-- Step 34: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Cavalgue para nordeste até o {area:3447}.",

	-- Step 35: Noggle's Lost Satchel
	-- {npc:15196} Deathclasp
	-- was: ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "A algibeira está nas montanhas do extremo sul, depois do Acampamento Barbabronze. Agarramata, um escorpídeo de elite, patrulha por perto: pegue-a enquanto ele estiver longe."
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. {npc:15196}, an elite scorpid, patrols near it: grab it while he is away."] = "",

	-- Step 36: Deathclasp
	-- {npc:15196} Deathclasp
	["With your group: {npc:15196} walks the mountains around the satchel. Pull him away from the other scorpids."] = "",

	-- Step 37: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171} e {npc:15170} acampam no Acampamento Barbabronze, logo ao norte das montanhas da bolsa. Interrogue-os: passe por toda a conversa de cada um; não precisa lutar com eles.",
	-- {npc:15170} Rutgar Glyphshaper
	["{npc:15170}, if Brann's letter dropped for you"] = "",

	-- Step 38: Twilight Base Camp
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "Junte vinte Textos Codificados do Crepúsculo dos sectários daqui, dez para {npc:15306} e dez para Ortell. Pegue-os dos Vingadores do Crepúsculo e dos Geolordes; deixe os Ceifachamas e os Clamapedras (59-60) em paz.",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "dez para cada missão: {npc:15306} recebe os dele antes de Ortell",

	-- Step 39: Twilight Base Camp
	["The spare texts from the cultists"] = "Os textos que sobraram dos sectários",

	-- Step 40: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "De volta ao {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "A próxima tarefa de Mar'alith, No ventre da loucura, leva você a {area:2744} entre elites. Pule.",

	-- Step 41: Vish Kozus
	-- {npc:15182} Vish Kozus · {npc:15196} Deathclasp
	["{npc:15182}, Captain of the Guard, pays out for {npc:15196}'s pincer."] = "",

	-- Step 43: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Cavalgue para nordeste até o {area:3077}; você sai de {zone:1451} pelo desfiladeiro ao lado.",

	-- Step 45: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	-- was: ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Pela passagem e a leste ao longo dos penhascos do norte até {area:541}. {npc:9997} fica ao lado do mestre de voo."
	["You missed this on the Un'Goro guide's loop: through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 46: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["You missed this on the Un'Goro guide's loop: {npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "",

	-- Step 47: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Siga para o leste até {area:537}, suba e use {npc:10541} na fenda de lava perto do topo; depois volte para o oeste até {npc:10302}.",

	-- Step 48: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} manda você até {npc:9298} em {zone:1452}: guarde.",

	-- Step 49: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "Só se você pegou {quest:4496} em {area:976} no caminho: os Gorishi de {area:540}, ao sul de {area:537}, deixam cair a Glândula de Odor, e a maioria das feras e plantas da cratera deixa cair {item:11018}.",

	-- Step 50: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "Use {item:11833} onde a seta apontar, dentro da colmeia Gorishi de {area:540}, para chamar {npc:10041} (nível 56).",

	-- Step 51: Torwa Pathfinder
	-- {quest:4301} The Mighty U'cha · {area:541} Marshal's Refuge
	["{quest:4301}: his north-east cave is on your way back here from {area:541}"] = "",
	-- {npc:9684} Lar'korwi
	["Keep the bait for {npc:9684}'s lair, next (he is level 56)."] = "",

	-- Step 52: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "O covil de {npc:9684} fica logo ao sul do pilar. Use a isca de {npc:9619} ali; {npc:9684} é nível 56 e bate forte, então comece com a vida cheia.",

	-- Step 53: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} está sentado na serra, perdido e exausto.",

	-- Step 54: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",

	-- Step 56: The Mighty U'cha
	-- {area:541} Marshal's Refuge · {npc:9622} U'cha · {npc:9619} Torwa Pathfinder
	["From {area:541} ride east to the cave in the crater's north-east corner: {npc:9622} (55) sits at its back among his gorillas, well under you now. Then south down the crater's east side to {npc:9619}."] = "",

	-- Step 58: Tanaris
	-- {npc:9619} Torwa Pathfinder · {area:541} Marshal's Refuge · {area:976} Gadgetzan
	["{npc:9619}'s corner has no flight master: ride north to {area:541} and fly to {area:976}."] = "",

	-- Step 59: Gadgetzan
	-- {quest:2741} The Super Egg-O-Matic · {area:976} Gadgetzan
	-- was: ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Voe até {area:976}. Ainda está com {quest:2741}? A máquina fica no meio da cidade."
	["Still carrying {quest:2741}? The machine stands in the middle of {area:976}."] = "",

	-- Step 62: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",

	-- Step 63: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 64: Paladin trainer
	["Paladin trainer"] = "Instrutor de paladino",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {zone:1454} não tem instrutor de paladino",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Um pergaminho rasgado está na entrada da {area:2261}, a cripta ao sul da {area:2260}.",
	-- ["Andorhal watchtowers and silos"] = "Torres de vigia e silos de Andorhal",
	-- ["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "De volta a leste, passando por {area:202}, até {area:201}, a fazenda sob as colinas do leste: {npc:11078} guarda o caldeirão de lá. Mate-o para pegar a chave e depois use o caldeirão.",
	-- ["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Cuidado: os Gorilas de Un'Goro (nível 50-51) chamam ajuda de aliados num raio de 20 metros quando caem para 25% de vida. Tem uma caverna lotada de macacos na área, e lutar lá traz monstro a mais de montão.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "Junte vinte Textos Codificados do Crepúsculo dos sectários daqui, dez para {npc:15306} e dez para Ortell.",
	-- ["Diseased Grizzlies"] = "Ursos-cinzentos Doentes",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Trépido oferece {item:14619} ({quest:838}). Pule-a.",
	-- ["Dredge Strikers"] = "Dragatacas",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Dragatacas, Escorpídeos Petraçoite e Rastejantes da Areia dividem as areias logo ao norte do forte.",
	-- ["Dredge and scorpids"] = "Dragas e escorpídeos",
	-- ["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Para leste pela estrada, {npc:11077} guarda o caldeirão nas {area:200}.",
	-- ["Fly to {area:1637} and train."] = "Voe até {area:1637} e treine.",
	-- ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Voe até {area:976}. Ainda está com {quest:2741}? A máquina fica no meio da cidade.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Voe até {area:976}. O {object:142071} fica no meio da cidade.",
	-- ["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "Da torre do zepelim, cavalgue para leste pela estrada até o {area:152}, na entrada de {zone:1422}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Hameya se esconde entre os trolls Esfolamusgo de {area:2273}, no canto nordeste.\nCuidado: os trolls do caminho até {area:2273} são nível 57-59. Fogem com pouca vida e chamam ajuda, então costumam trazer reforço.",
	-- ["Hameya's mound"] = "O monte de Hameya",
	-- ["Hameya's scroll"] = "O pergaminho de Hameya",
	-- ["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "Se você pulou {quest:6135}, mate monstros aqui até o nível 59.14 para seguir o plano da rota. Ou, em grupo, faça a masmorra {quest:838} ou a masmorra {area:2279}.",
	-- ["Into {zone:1422}"] = "Rumo a {zone:1422}",
	-- ["Into {zone:1423}"] = "Rumo a {zone:1423}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarde a isca: {npc:9684} é nível 56, e a segunda volta passa pelo covil dele.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Guarde {quest:3942}: {npc:9116} está no {area:2479}, no caminho do próximo guia por {zone:1448}.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "Cavaleiros e magos trabalham no {area:192}; os médicos e caçadores acampam ao sul dele. Aproveite e coloque o barril de cupins de {npc:11615} no meio da serraria.\nCuidado: um {npc:10996}, elite de nível 58-59, pode estar no acampamento madeireiro, como em vários outros pontos de {zone:1422}: mantenha distância.",
	-- ["Level 57"] = "Nível 57",
	-- ["Level 58"] = "Nível 58",
	-- ["Level 59.14"] = "Nível 59.14",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Querida Natália, de Mar'alith, requer nível 58 e leva à {area:2744} entre elites. Pule-a.",
	-- ["Mark {npc:10902} with the {item:12815}"] = "Marque a {npc:10902} com a {item:12815}",
	-- ["Mark {npc:10903} with the {item:12815}"] = "Marque a {npc:10903} com a {item:12815}",
	-- ["Mark {npc:10904} with the {item:12815}"] = "Marque a {npc:10904} com a {item:12815}",
	-- ["Mark {npc:10905} with the {item:12815}"] = "Marque a {npc:10905} com a {item:12815}",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Para o norte até a madeireira; coloque o barril de cupins no meio da serraria.",
	-- ["Pamela and the {area:2261}"] = "Pâmela e {area:2261}",
	-- ["Radley and Durgen"] = "Eiras e Durgen",
	-- ["Ride east across the plaguelands to the chapel."] = "Cavalgue para leste pelas terras pestilentas até a capela.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Cavalgue para leste pela estrada até o {area:152}, na divisa.",
	-- ["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Cavalgue para leste até a cabana de {npc:1855} junto ao {area:2619} e ouça o que ele tem a dizer.",
	-- ["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "Cavalgue para nordeste até {area:2276}, perto de {area:2275}: os Patrulheiros, Trilheiros e Lenhadores altos elfos a guardam, e o Registro fica lá dentro. Cuidado: os Trilheiros são 57-58, mas os Patrulheiros chegam a 60: puxe um de cada vez e deixe os Patrulheiros por último.",
	-- ["Ride north-west to {npc:1855}'s hut."] = "Cavalgue para noroeste até a cabana de {npc:1855}.",
	-- ["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Cavalgue para o sul até Andorhal. {npc:10667} espera na estalagem em ruínas no lado oeste da cidade. Fique na porta de cada uma das quatro torres com a {item:12815} para marcá-la; mantenha-se nas bordas da cidade. Use o {item:12627} junto aos silos no meio da cidade para fazer sair Parasitas Temporais.",
	-- ["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "Cavalgue para sudeste, saindo de {npc:1855}, até a casa da fazenda {area:2260}.",
	-- ["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "Cavalgue para sudeste, saindo de {npc:1855}, até {area:2261}; o {object:177675} fica logo atrás.",
	-- ["Ride south-west to {npc:10667} in Andorhal."] = "Cavalgue para sudoeste até {npc:10667} em Andorhal.",
	-- ["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cavalgue até {area:2262}, no sudoeste; a Pâmela brinca entre as casas. {npc:11886} espreita em {area:2261}, a cripta logo a oeste da cidade.\nCuidado: uns quatro capangas não elite vêm com o Mercutio. Eles caminham até o túmulo em vez de aparecer ali na hora.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Cavalgue até {area:2262}, no sudoeste; {npc:10926} brinca entre as casas. {npc:11886} espreita na {area:2261}, a cripta logo a oeste da cidade.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Cavalgue para oeste até o forte murado no meio do deserto.",
	-- ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Cavalgue para o oeste, até o forte murado no meio do deserto. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",
	-- ["Scare {npc:10977} with {npc:10980}"] = "Assuste {npc:10977} com o {npc:10980}",
	-- ["Scarlet Crusade"] = "Cruzada Escarlate",
	-- ["Scourge Champions"] = "Campeões do Flagelo",
	-- ["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Campeões do Flagelo vagam pela {area:2270}, ao norte da capela. Passe o {item:13156} de {npc:11063} sobre cada um que matar: os crânios que ressoam são os que ele quer.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Pegue o zepelim na torre do lado de fora de {area:1637} até {zone:1420} e entre em {zone:1458}. Lady Sylvana ocupa o {object:36126}.",
	-- ["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Os Dragasmagas (57-58) do sudeste ficam dois níveis acima de você se você estiver abaixo do 57. Antes, chegue ao 57 nos Dragatacas (55-56) nas areias a leste de {area:3425}, onde Rastejantes da Areia e Escorpídeos Petraçoites (54-56) vagam entre eles, longe dos Dardejantes Silitídeos das areias do norte. Ou, com um grupo, faça a masmorra {area:1583} (Inferior) ou a masmorra {quest:838}.",
	-- ["The Spirits of Southwind"] = "Os espíritos de Vento Sul",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Os fragmentos brilhantes de tabuleta ficam em volta do acampamento do Crepúsculo no extremo noroeste; as Tempestades de Poeira e os Estrondores do Deserto de lá também os deixam cair.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Os fragmentos brilhantes de tabuleta ficam em volta do acampamento do Crepúsculo no extremo noroeste; as Tempestades de Poeira e os Estrondores do Deserto de lá também os deixam cair. Cuidado: os maiores Estrondores e os Invasores Rodopiantes são de nível 58: puxe um de cada vez.",
	-- ["The lake for {quest:5845}"] = "O lago para {quest:5845}",
	-- ["The libram lies further north, on the way to {area:190}."] = "O incunábulo fica mais ao norte, no caminho para {area:190}.",
	-- ["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "As caixas-fortes ficam nas casas em ruínas de Andorhal, em volta da estalagem de {npc:10667}. Cuidado: carniçais e esqueletos costumam ficar ao lado das caixas e atacam quando você chega perto. Os Carniçais Ardentes também ferem quem estiver por perto e quebram a furtividade.",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "A serraria fica bem ao lado de Eiras: largue o barril de cupins de {npc:11615} no meio dela.",
	-- ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "A algibeira está nas montanhas do extremo sul, depois do Acampamento Barbabronze. Agarramata, um escorpídeo de elite, patrulha por perto: pegue-a enquanto ele estiver longe.",
	-- ["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "O escudo fica em {area:201}, ao sul da cabana de {npc:1855}.",
	-- ["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "O {object:177675} fica logo atrás da {area:2261}.",
	-- ["The {object:177675} is just south, behind the {area:2261}."] = "O {object:177675} fica logo ao sul, atrás da {area:2261}.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "Esses bichos são elite: vale a pena formar um grupo, procure gente para ir junto. {npc:11897} é elite de nível 60: pule se estiver sozinho.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave."] = "Atravesse o desfiladeiro e siga para leste pelos penhascos do norte até o {area:541}. {npc:8737} fica junto à caverna.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Pela passagem e a leste ao longo dos penhascos do norte até {area:541}. {npc:9997} fica ao lado do mestre de voo.",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Suba até o nível 58 aqui antes das Espreitadoras de Rocha de Ortell (57-59) e do sul; {quest:8304}, de {npc:15181}, lá em {area:3425}, também pede nível 58. As Dragasmagas (57-58) no caminho para sudeste são as que {npc:15191} quer: deixe em paz os sectários do Crepúsculo em volta delas. Ou, com um grupo, faça a Masmorra {area:1583} (Inferior) ou a Masmorra {quest:838}.",
	-- ["Underwater"] = "Debaixo d'água",
	-- ["Upstairs"] = "No andar de cima",
	-- ["Use {npc:10980} on {npc:10977}"] = "Use o {npc:10980} em {npc:10977}",
	-- ["West to the {area:152} one last time."] = "A oeste, até {area:152}, uma última vez.",
	-- ["West to the {area:152}."] = "Volte para oeste até a {area:152}.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Para oeste até o {area:152}. O próximo guia começa em {zone:1458}, a uma curta cavalgada a oeste.",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Você perdeu isto na visita anterior da rota a esta região: vem primeiro agora. É rápido e abre as missões seguintes.",
	-- ["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",
	-- ["from the cauldron, for {npc:11055} at the {area:152}"] = "do caldeirão, para {npc:11055} em {area:152}",
	-- ["grind on {npc:10717}"] = "mate {npc:10717} até subir",
	-- ["grind on {npc:11740}"] = "mate {npc:11740} até subir",
	-- ["grind on {npc:11741}"] = "mate {npc:11741} até subir",
	-- ["{area:1099} flight master"] = "Mestre de voo de {area:1099}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Os Escarlates de {area:190} são nível 58-60. Entre cavalgando até o ponto alto marcado no mapa, dê uma olhada na cidade e caia fora.\nCuidado: as sentinelas do portão detectam jogadores furtivos. Há mais sentinelas dentro da cidade, e um elite faz patrulha ali perto.",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "O goblin {npc:10302} fica em {area:543}, logo a leste do pilar.",
	-- ["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "A batalha pela Vila das Flechas de {npc:10667} termina contra elites. Pule-a.",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}, no andar de cima",
	-- ["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739} acampa junto a {area:202}, ao lado do caldeirão; os ursos dele vagam pelas colinas ao norte e a leste, no caminho para {area:201}.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "A fazenda de {npc:10778} é a primeira a leste do {area:152}. Carniçais Grasnantes na fazenda levam a outra metade do amuleto dela; {npc:11075} guarda o caldeirão no campo.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} e a {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "A tarefa da própria {npc:10926} não está nesta rota. Pule-a.",
	-- ["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610} se esconde na colina a nordeste do {area:192}.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} fica a leste do acampamento madeireiro; {npc:11611} guarda a estrada a nordeste de {npc:11610}, rumo a {area:190}.\nCuidado: há guardas na base da torre e mais um patrulhando em volta dela. Limpe-os antes de encarar o Durgen, para eles não entrarem na briga.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} anda pelo acampamento da Vanguarda no extremo sudoeste. Todo sectário daqui deixa cair Textos Codificados do Crepúsculo, com missão ou não: junte vinte, dez para {npc:15306} e dez para Ortell.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} fica no posto avançado a oeste do {area:3425}. Complete seus Textos Codificados do Crepúsculo até vinte com os sectários daqui.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "As tarefas de {npc:11878} não estão nesta rota. Pule-as.",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{quest:8304}, de {npc:15181}, em {area:3425}, exige nível 58: complete nos Dragasmagas (57-58) a oeste do posto e deixe em paz os Vingadores, Geolordes e Petrazes do Crepúsculo (57-61) em volta deles. Ou, em grupo, faça a masmorra {area:1583} (Inferior) ou a masmorra {quest:838}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "O campeão da {npc:15193} ocupa a casa da {area:2260}, ao norte da {area:2261}.",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, no lado oeste do Forte",
	-- ["{npc:15306}, on the west side of the Hold: the texts are already in your bags"] = "{npc:15306}, no lado oeste do Forte: os textos já estão nas suas bolsas",
	-- ["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852} (61, elite) fica no meio de Andorhal entre Senhores da Guerra Esqueléticos (56-57, elite): mate-o com seu grupo e depois pegue o fragmento em {object:177241}, ali mesmo.",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "A próxima tarefa de {npc:1855}, Da honra perdida, não está nesta rota. Pule-a.",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} anda por {area:2276}: procure dentro do círculo no mapa",
	-- ["{npc:9117} is inside the cave."] = "{npc:9117} está dentro da caverna.",
	-- ["{npc:9167} walks around here: look inside the circle on the map"] = "{npc:9167} anda por aqui: procure dentro do círculo no mapa",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Agora {npc:9619} pede a pele de {npc:9622}, lá na caverna a nordeste: pule.",
	-- ["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "O fragmento de {quest:105} está aos pés de {npc:1852}, no meio de Andorhal: ele é um elite de nível 61 cercado de Senhores da Guerra Esqueléticos elite, uma luta para grupo.",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}: vá matando estes pelo caminho",
}
