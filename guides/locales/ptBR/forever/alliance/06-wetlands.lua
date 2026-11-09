-- Portuguese (Brazil) (ptBR): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Use {spell:18960}",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lance {spell:18960}. Com as duas metades do pingente na bolsa, fique junto a {area:2362}, na margem noroeste do lago, e use uma metade para uni-las; depois vá até {npc:11802}, em {area:2361}. {npc:11802} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: junte as metades em {area:2362}",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "Pegue {quest:5061} com {npc:11802}, no andar de cima do prédio dele. Depois {npc:11800}, em {area:2361}, leva Druidas direto para {area:702}.",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "Pegue o portal para subir até {area:1658} e depois voe de volta para {area:442} para o barco até {area:150}.",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Voe para {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Mestre de voo de {area:442}",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "Rumo a {zone:1457}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "Pegue o barco no cais de {area:442} até {area:150}.",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",

	-- Step 13: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, na estalagem",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, de {npc:1464}",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "{npc:2104}, junto à bastilha; no andar de cima",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "{npc:2104}: {quest:98221}, os Planos de Ataque em {area:1036}",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, no píer ao norte da estalagem",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "{npc:2094}, junto às docas",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "{npc:2097}, junto ao portão norte: {npc:1071} recebe na parada de {area:205} de 30-40/01-hillsbrad-foothills",

	-- Step 14: The Bluegill hovels
	["The Bluegill hovels"] = "As choças Guelrazul",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Siga a costa para o norte, saindo de Menethil, até {area:1022}. Três recipientes nas choças dos murlocs, de sul a norte: {object:261}, depois {object:142151}, depois {object:259} no extremo norte.",

	-- Step 15: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "{area:1039}: vá matando estes pelo caminho",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "Siga a costa para o norte até o navio naufragado. Marinheiros Amaldiçoados andam pela praia e Fuzileiros Amaldiçoados pelo convés; {npc:1159} fica na praia junto à proa. Crocoliscos do Pantanal Gigantes espreitam na costa logo ao norte.\nCuidado: Rastejantes do Pântano se escondem furtivos onde o rio se divide, perto do navio fantasma, e podem entrar na briga.",

	-- Step 16: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "Vindo do norte: {npc:2094} junto às docas, {npc:1242} no cais, {npc:2104} na bastilha, depois {npc:1239} na estalagem.",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: para {npc:2104} na fortaleza",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "{npc:2104}, no último andar",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Para Bolvar Fordragon na {object:2117}: guarde-o",

	-- Step 17: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "O capitão anda pelo convés do navio naufragado; a caixa-forte dele fica no porão.",

	-- Step 18: Raptor valley
	["Raptor valley"] = "Vale dos raptores",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "Siga a estrada para leste: os raptors maiores de {quest:295} caçam no vale logo a oeste do sítio de escavação.",

	-- Step 19: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "O sítio de escavação fica no morro ao sul da estrada: {npc:1078} no alto, {npc:1077} no subterrâneo.",

	-- Step 20: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "{area:118}: vá matando estes pelo caminho",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "As relíquias estão na própria escavação. {npc:1353}, um grande Rasgaqueixo, ronda o vale dos raptores logo a oeste dela.\nGoaz Warders (elite, 32) ficam entre as relíquias e {object:331}: puxe-os um de cada vez, ou contorne-os.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 21: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} e Whelgar",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "{npc:1077}, no subterrâneo: a {item:279993}, dos Goaz Warders elite",

	-- Step 22: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "Goaz Warders",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "Os Goaz Warders ficam logo a oeste do acampamento de Whelgar: use a {item:279996} que ele lhe deu ao lado de um deles.\n{npc:270892} é elite: recomenda-se ir em grupo.",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "No subterrâneo",

	-- Step 24: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "Uma nova {item:279996}, para os quatro vigias titânicos em volta de {zone:1437}; no subterrâneo. Os corações deles vêm de elites de nível 32 na visita a {area:205}",

	-- Step 25: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "Ao norte, da escavação até o acampamento dos Presa do Dragão: clique nos quatro conjuntos de Planos de Ataque. O plano de {zone:1455} fica no extremo oeste do acampamento, e os outros três mais a leste. {npc:2091}, um elite, fica afastado, a sudeste: {quest:98221} não precisa dele.",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "{item:3337}: os Saqueadores e Corre-brejos do acampamento",

	-- Step 26: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "Siga a estrada para leste até {area:1025}; {npc:1244} fica junto ao rio. O sílex de {quest:277} veio com você da sua última visita a {zone:1437}.",

	-- Step 27: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "{npc:270637} acampa entre os Corre-charcos, logo a oeste de {npc:1244}.",
	-- {area:1038} Dragonmaw Gates · {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Incisivos de Rasgaqueixo: dos raptores perto de {area:1038}, no circuito de {zone:1437} de 30-40/01-hillsbrad-foothills",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same loop"] = "{quest:98246}: os ovos de Rasgaqueixo, no mesmo circuito",

	-- Step 28: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "A leste de {npc:270637}: {npc:2093} fica ao lado da estrada.",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "{npc:2093}: para {npc:2094} em Menethil",

	-- Step 29: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "Rastejantes do Pântano ao longo do rio",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "Ao noroeste de {npc:2093}, até o rio: Rastejantes do Pântano se escondem nas poças e ao longo das margens dele, por todo o caminho para oeste até {area:1024}. Siga para oeste ao longo dele até juntar doze e depois volte para leste, até {npc:1244}.\nCuidado: fora de combate, os Rastejantes do Pântano ficam furtivos de vez em quando, então costumam estar escondidos e difíceis de ver.",

	-- Step 30: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "{quest:98283}, um raptor elite, no circuito de {zone:1437} de 30-40/01-hillsbrad-foothills",

	-- Step 31: Captain Stoutfist
	-- {area:150} Menethil Harbor · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern · {npc:2094} James Halloran
	["Back west along the road to {area:150}: {npc:2104} stands on the top floor of {area:2103}, {npc:1217} in the {area:2104} south of it, {npc:2094} by the docks on the way to the boat."] = "De volta a oeste pela estrada até {area:150}: {npc:2104} fica no último andar de {area:2103}, {npc:1217} na {area:2104}, ao sul dela, {npc:2094} junto às docas, no caminho para o barco.",
	["On the top floor"] = "No último andar",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Para a catapulta Presa do Dragão, no circuito de {zone:1437} de 30-40/01-hillsbrad-foothills",
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["{npc:1217}, in the {area:2104}"] = "{npc:1217}, na {area:2104}",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "Para {npc:1284} em {zone:1453}, no fim deste guia",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "{npc:2094}, junto às docas, no caminho até o barco",

	-- Step 32: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "O barco para {area:442} sai da outra ponta do cais oeste de Menethil.",

	-- Step 33: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "{npc:3649} fica na ponta norte de {area:442}.",
	-- {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on 03-darkshore-return's first {area:442} stop)"] = "A resposta de Alexston, se você ainda a carrega (a rota a entrega na primeira parada em {area:442} de 03-darkshore-return)",

	-- Step 34: Auberdine
	-- {npc:3693} Terenthis
	["{npc:3693} stands by the flight master."] = "{npc:3693} fica junto ao mestre de voo.",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "{npc:3693}: a escolta de Volcor, do fim de {zone:1439}",

	-- Step 35: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Voe para {area:415}",

	-- Step 36: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {area:415} Astranaar
	["{npc:3845} stands by {area:415}'s flight master."] = "{npc:3845} fica junto ao mestre de voo de {area:415}.",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "Para {quest:4581} em {area:2358}",

	-- Step 37: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, lá dentro",

	-- Step 38: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria e {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "Os dois ficam juntos no extremo oeste da estrada, a sudoeste de {area:415}.",

	-- Step 39: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Siga a estrada para leste até o {area:419}; {npc:3916} fica junto ao poço lunar.",

	-- Step 40: Dartol's Rod
	["Dartol's Rod"] = "Bastão de Transformação de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Os Ancientes Enlouquecidos e Ancientes Fenescidos ao norte do poço lunar carregam a {item:5475}; o baú gasto que ela abre fica entre eles.",

	-- Step 41: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Pegue o túnel para {area:419}; o tomo está nas ruínas no extremo oeste.",

	-- Step 43: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Siga a estrada para leste até os acampamentos de sátiros de {area:429}; {npc:3920} se esconde na borda deles.",

	-- Step 44: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} lidera os sátiros de {area:429}; ele carrega o galho.",

	-- Step 45: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, o posto avançado dos elfos noturnos no extremo leste da estrada: {npc:3848} fica lá.",

	-- Step 46: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432}: vá matando estes pelo caminho",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "O acampamento dos Renegados fica na mata ao sul de {area:2358}.\nBaús enferrujados ficam em volta dos acampamentos furbolg Umbrárvore a oeste dos Renegados; abra até achar o do pomo.\nCuidado: Renegados não elite de nível 28-30 guardam o acampamento. Alguns estão furtivos, e os que ficam em volta da mesa costumam vir juntos.",

	-- Step 47: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "O {npc:3931} anda pela margem do {quest:1035}, a sudoeste dos baús; o {object:669176} está ao norte do lago, no caminho.\nCuidado: outros monstros, alguns debaixo d'água, ficam perto da ilha. Limpe-os antes para não entrarem na briga quando você puxar o Oráculo.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} em {area:415}",

	-- Step 48: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "",

	-- Step 49: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "Entrada de {area:432}",

	-- Step 50: Insane druids
	["Insane druids"] = "Druidas insanos",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Os três druidas estão dentro de {area:432}, afastados uns dos outros: entre pela boca, ao sul do acampamento dos Renegados, não por cima da colina acima deles. {npc:3940} está nos salões do leste, {npc:3941} no ponto mais fundo, no extremo nordeste, e {npc:3942} no extremo oeste.\nCuidado: a toca tem muitos monstros que renascem rápido, incluindo mortos-vivos furtivos e patrulhas, então monstros extras costumam entrar na luta.",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}, dentro de {area:432}",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}, dentro de {area:432}",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}, dentro de {area:432}",

	-- Step 51: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "O {object:19901} fica no acampamento dos sátiros em {area:430}, mais a leste pela estrada.\nCuidado: os Ladinos Malmíscar de {area:428} costumam ficar furtivos, e {area:430} tem sátiros lançadores de feitiço.",

	-- Step 53: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "O segundo {object:19901} fica no vale de {area:428}, no caminho para oeste.",

	-- Step 55: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "O santuário fica na colina logo a sudeste do poço lunar; suba pela trilha sinuosa.",

	-- Step 57: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "{npc:3691} e {npc:3961} estão na estalagem; {npc:3894} está no prédio logo ao sul dela.",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "{npc:3961}, na estalagem",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "{npc:3894}, dentro do prédio ao sul da estalagem",

	-- Step 58: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, um furbolg intocado pela corrupção, fica ao sul da estrada abaixo de {area:421}.",

	-- Step 59: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} e os guardas dele acampam logo a leste de {npc:3897}.\nCuidado: lobos e aranhas andam perto do acampamento e podem entrar na briga. Alguns lobos andam em dupla.",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "{item:5388}, de {npc:3696}",

	-- Step 61: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "A oeste de {npc:3897}, pelas colinas do sul, até {area:416}: Melyria e {npc:3901} ficam juntas ao lado dele.",

	-- Step 62: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "Ao norte, até {area:413}.",

	-- Step 63: Astranaar
	-- {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["South-east along the road to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "Ao sudeste pela estrada até {area:415}: {npc:3691} na estalagem, o mestre de voo no extremo oeste.",

	-- Step 64: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Voe para {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Mestre de voo de {area:415}",

	-- Step 66: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Voe para {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "{npc:1571} é o mestre de voo junto à estalagem de Menethil.",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 68: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Sacerdotes de {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} e {npc:258785} estão no {object:32386}, na {object:32362}.",

	-- Step 69: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "Metrô para {zone:1453}",

	-- Step 70: Cathedral of Light
	["Cathedral of Light"] = "Catedral da Luz",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Pegue o {area:2257} em {object:171524} até o {object:28027} de {zone:1453}, depois ande até a {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, na Catedral da Luz",

	-- Step 71: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Só se você saqueou {quest:337} em {zone:1431}",

	-- Step 72: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "De volta à Catedral da Luz: {npc:928} fica lá dentro.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Para {npc:2228} em {area:271}: guarde-o",

	-- Step 73: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} e {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, a loja de queijos no {object:2096}",

	-- Step 74: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Próximo: voe até {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to {area:150}: {npc:2104} stands on the top floor of {area:2103}."] = "De volta a oeste pela estrada até {area:150}: {npc:2104} fica no último andar de {area:2103}.",
	-- ["In {zone:1453}, join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Em {zone:1453}, junte as duas metades do pendente em {item:15885} e lance {spell:18960}: {npc:11802} está em {area:2361}. Depois {npc:11800}, em {area:2361}, leva Druidas direto para {area:702}. {npc:11802} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- ["Inside"] = "Lá dentro",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\nFen Creepers hide in the marsh pools north-west of the {area:1025}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "Dragonetes vermelhos enchem as colinas a oeste dos portões, Maddened Rotclaws, {area:1025}, e Rasgaqueixos, as encostas do norte; Neru fica no nordeste (use {item:279996}).\nRastejantes do Pântano se escondem nas poças do brejo a noroeste de {area:1025}.\nCuidado: fora de combate, os Rastejantes do Pântano lançam Furtividade de tempos em tempos, então ficam furtivos e difíceis de ver.",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "As relíquias ficam na própria escavação. {npc:1353}, um Rasgaqueixo grande, ronda o vale dos raptores logo a oeste.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Os três druidas ficam juntos no acampamento dos Renegados ao sul de {area:2358}.\nCuidado: o covil tem muitos monstros que renascem rápido, incluindo mortos-vivos furtivos e patrulhas, então é comum vir monstro a mais.",
	-- ["{area:1025}: kill these as you meet them"] = "{area:1025}: vá matando estes pelo caminho",
	-- ["{item:15885}: join the two halves"] = "{item:15885}: junte as duas metades",
	-- ["{npc:3649} stands at the north end of {area:442}, {npc:3693} and {npc:3694} by the flight master."] = "{npc:3649} fica no extremo norte de {area:442}, {npc:3693} e {npc:3694}, junto ao mestre de voo.",
	-- ["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649}: a resposta do Aleixo, se você a pegou em {zone:1453}",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}, na estalagem",
	-- ["{npc:3694}: for {npc:3691} in {area:415}"] = "{npc:3694}: para {npc:3691} em {area:415}",
}
