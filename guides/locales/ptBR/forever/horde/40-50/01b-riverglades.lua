-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/01b-riverglades (forever/horde/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16743} Rog'mar
	["About 70 quests in Forever's new zone, from the fort of {area:16743}."] = "Cerca de 70 missões na nova zona do Forever, a partir do forte de {area:16743}.",

	-- Step 1: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Voe para {area:340}",
	-- {zone:2548} Riverglades · {area:3} Badlands · {area:657} Harborage · {area:75} Stonard · {area:340} Kargath
	["The {zone:2548} lie south of the {area:3}. Ride east from the {area:657} to {area:75} and fly to {area:340}: the way down into the zone starts there."] = "{zone:2548} ficam ao sul de {area:3}. Siga para leste de {area:657} até {area:75} e voe para {area:340}: o caminho de descida para a zona começa lá.",
	-- {area:75} Stonard
	["{area:75} flight master"] = "Mestre de voo de {area:75}",

	-- Step 2: Into the Riverglades
	-- {area:16591} Riverglades
	["Into the {area:16591}"] = "Rumo a {area:16591}",
	-- {area:16591} Riverglades · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {area:16743} Rog'mar · {npc:258570} Da'grosh
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["New in Forever: this guide follows what players did in the {area:16591}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nFrom {area:340}, ride south-east across the {area:3} to the zone's southern edge: the pass of {area:16685} leads down into the {area:16591}. {area:16743}, the Horde's fort, stands in the middle of the zone, east along the valley.\nCareful: this route starts at about 41, after Stranglethorn and the Swamp. Keep east to {area:16743}. {npc:258570}'s Twilight camps south-west of the pass are 43-46; Twilight Enforcers (45), Kilgar and Morg (46) are elite. Leave the valley for about 44."] = "",

	-- Step 3: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Voe para {area:484}",
	-- {zone:2548} Riverglades · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port · {area:484} Freewind Post · {zone:1441} Thousand Needles · {area:439} Shimmering Flats · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud
	["New in Forever: this guide follows what players did in the {zone:2548}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe {zone:2548} lie across the sea from {zone:1446}: a goblin boat sails from {area:977}, north-east of {area:976}, to {area:16727}. Fly to {area:484} in {zone:1441} and head south-east through the {area:439} to {area:976}. (If you already know {area:340} in the {area:3}, the way in through {area:16685} works too.)"] = "Novidade do Forever: este guia segue o que os jogadores fizeram em {zone:2548}. Se uma etapa estiver errada, avise-nos no Discord ou no GitHub do Polestar e diga qual é a etapa.\n{zone:2548} ficam do outro lado do mar, em frente a {zone:1446}: um barco goblin sai de {area:977}, a nordeste de {area:976}, para {area:16727}. Voe para {area:484} em {zone:1441} e siga para sudeste por {area:439} até {area:976}. (Se você já conhece {area:340} em {area:3}, a entrada por {area:16685} também serve.)",

	-- Step 4: Gadgetzan
	-- {area:976} Gadgetzan
	["Learn {area:976}'s flight path: it saves the ride next time."] = "Aprenda a rota de voo de {area:976}: poupa a cavalgada da próxima vez.",

	-- Step 5: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Barco para {area:16727}",
	-- {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port
	["{area:977} is on the coast north-east of {area:976}: wait on the pier for the goblin boat to {area:16727}."] = "{area:977} fica na costa, a nordeste de {area:976}: espere no píer pelo barco goblin para {area:16727}.",

	-- Step 6: Land at Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Land at {area:16727}"] = "",
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {zone:1446} Tanaris
	["Board at Steamwheedle and ride to {area:16727}. Leave the boat and walk west along the docks to {npc:255897}'s stall. Reaching the {zone:1446} pier is not the crossing."] = "",
	-- {npc:255897} Friz Frazzlespark
	["{npc:255897}, at the west end of the docks"] = "",

	-- Step 7: Powderfuse Port
	-- {npc:255897} Friz Frazzlespark
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{npc:255897} keeps a stall at the west end of the docks. The port's other jobs are for later in this guide: this crate goes to the Horde's fort."] = "Novidade do Forever: se uma etapa estiver errada, avise-nos no Discord ou no GitHub do Polestar e diga qual é a etapa.\n{npc:255897} tem uma barraca na ponta oeste das docas. Os outros serviços do porto ficam para mais adiante neste guia: esta caixa vai para o forte da Horda.",
	-- {quest:95062} Frazzlespark's Crate · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95062}: for {npc:256418} in {area:16743}"] = "{quest:95062}: para {npc:256418} em {area:16743}",

	-- Step 8: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "Oficina de {npc:263367}",
	-- {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["West up the road from the port: {npc:263367} has his workshop on the hill. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "Suba a estrada a oeste do porto: {npc:263367} tem sua oficina na colina. As saídas de gás ficam no brejo a sudoeste dela, na sua primeira caçada para {npc:258031}.",

	-- Step 9: Rog'mar
	-- {area:16743} Rog'mar · {npc:258031} Neza Bloodsnout · {npc:256657} Kreza Darkthorn · {npc:256418} Krom'rosh · {npc:255993} Grakna · {npc:256675} Innkeeper Toka · {npc:263190} Tan'jani
	["West to {area:16743}, the Horde's fort in the middle of the zone. {npc:258031} stands on its east side, {npc:256657} and {npc:256418} in the middle with {npc:255993}, the wind rider master; {npc:256675} and {npc:263190} on the west side."] = "Para oeste até {area:16743}, o forte da Horda no meio da zona. {npc:258031} fica no lado leste, {npc:256657} e {npc:256418} no meio, com {npc:255993}, o mestre das mantícoras; {npc:256675} e {npc:263190} no lado oeste.",
	-- {npc:256418} Krom'rosh · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:256418}: Aggro'gosh's report from {object:3202}, if you carry it"] = "{npc:256418}: o relatório de Aggro'gosh vindo de {object:3202}, se você o tiver",
	-- {npc:255993} Grakna
	["{npc:255993}, in the middle of the fort"] = "{npc:255993}, no meio do forte",
	-- {npc:263190} Tan'jani · {quest:95033} On the Other Side · {npc:8115} Witch Doctor Uzer'i · {area:1099} Camp Mojache · {zone:1444} Feralas
	["{npc:263190}: {quest:95033}, for {npc:8115} at {area:1099} in the {zone:1444} guide"] = "{npc:263190}: {quest:95033}, para {npc:8115} em {area:1099}, no guia de {zone:1444}",

	-- Step 10: Krom'rosh
	-- {npc:256418} Krom'rosh
	["Frazzlespark's crate from the port goes to {npc:256418}, in the middle of the fort."] = "A caixa de Frazzlespark, do porto, vai para {npc:256418}, no meio do forte.",

	-- Step 11: Sleebo Fizzlespout's workshop
	-- {area:16727} Powderfuse Port · {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["East of Rog'mar, on the hill above the road to {area:16727}: {npc:263367} has his workshop there. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "A leste de Rog'mar, na colina acima da estrada para {area:16727}: {npc:263367} tem sua oficina ali. As saídas de gás ficam no brejo a sudoeste dela, na sua primeira caçada para {npc:258031}.",

	-- Step 12: The plains and the marsh
	["The plains and the marsh"] = "As planícies e o brejo",
	-- {area:16729} Terral's Watch · {quest:96103} A Feast for Buzzards
	-- plural, as words: Low Plains Buzzards = {npc:263343} Low Plains Buzzard
	["South-east of Rog'mar the plains run down to {area:16729}. The Low Plains Buzzards circle everywhere; a picked carcass lies in the grass (its skull starts {quest:96103}), and the marsh vents are just past it."] = "A sudeste de Rog'mar, as planícies descem até {area:16729}. Os Urubus das Planícies Baixas voam por toda parte; uma carcaça descarnada está na grama (o crânio dela inicia {quest:96103}), e as saídas do brejo ficam logo depois.",

	-- Step 13: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to the workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "Para nordeste até a oficina. O teste de estresse de {npc:263367} é uma luta contra o G45-B4G dele ao lado da oficina: entregue a missão depois de vencê-lo.",
	["the stress test: beat G45-B4G beside the workshop"] = "o teste de estresse: vença o G45-B4G ao lado da oficina",

	-- Step 14: Neza Bloodsnout
	-- {area:16743} Rog'mar
	["West back to {area:16743}'s east side."] = "De volta a oeste, até o lado leste de {area:16743}.",

	-- Step 15: The vipers and the tallstriders
	["The vipers and the tallstriders"] = "As víboras e os pernaltas",
	-- {npc:257079} Cavalry Scout Alturin · {area:16729} Terral's Watch · {area:16725} Wheeler's Grange
	-- plural, as words: Glade Vipers = {npc:263307} Glade Viper · Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Glade Vipers hide in the long grass south-east of town; the Roving Tallstriders graze beside them. {npc:257079}, an Alliance elite (level 45), rides the road from {area:16729} to {area:16725} along the grass's south-west edge: keep clear of him."] = "As Víboras da Clareira se escondem no capim alto a sudeste da cidade; os Pernaltas Errantes pastam ao lado delas. {npc:257079}, um elite da Aliança (nível 45), cavalga pela estrada de {area:16729} até {area:16725}, ao longo da borda sudoeste do capim: fique longe dele.",

	-- Step 17: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16743} Rog'mar
	["{npc:263315}, an elite lion (level 41), prowls the plains south of {area:16743}, where the lions are: grouping up is advised."] = "{npc:263315}, um leão elite (nível 41), ronda as planícies ao sul de {area:16743}, onde estão os leões: é recomendado formar um grupo.",

	-- Step 18: The lions
	["The lions"] = "Os leões",
	-- {area:16743} Rog'mar · {npc:263315} Ombassa
	["The Wildplains lions roam the plains just south of {area:16743}.\nCareful: {npc:263315}, an elite lion (level 41), prowls the same plains around 59.6,53.2: keep an eye out for him and pull the lions away from where he walks."] = "Os leões das Planícies Selvagens vagam pelas planícies logo ao sul de {area:16743}.\nCuidado: {npc:263315}, um leão elite (nível 41), ronda as mesmas planícies em torno de 59.6,53.2: fique de olho nele e puxe os leões para longe de onde ele anda.",

	-- Step 21: Neza Bloodsnout's elites
	-- {npc:258031} Neza Bloodsnout
	["{npc:258031}'s elites"] = "Os elites de {npc:258031}",

	-- Step 22: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906} é um gnoll elite (nível 40) que perambula pelos acampamentos do sudoeste de {area:16737}: é recomendado formar um grupo.",

	-- Step 24: Turner's Logging Camp
	-- {npc:263380} Ghostmaw
	-- plural, as words: Wood Bundles = {item:271629} Wood Bundle · Peasant Woodpiles = {object:645516} Peasant Woodpile · Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["South-west across the river to the Alliance lumber camp. The lumberjacks carry the axes. Loot Wood Bundles from the Peasant Woodpiles around the camp and use them to fletch Makeshift Stickin' Spears. {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "Atravesse o rio a sudoeste até o acampamento madeireiro da Aliança. Os lenhadores carregam os machados. Saqueie Braçadas de Madeira das Pilhas de Lenha dos Camponeses pelo acampamento e use-as para fazer Lanças de Espetar Improvisadas. {npc:263380}, um elite (nível 42), ronda o rio perto do acampamento: se ele vier na sua direção, recue e deixe-o passar.",
	-- {item:271629} Wood Bundle
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["{item:271629}, from the Peasant Woodpiles"] = "{item:271629}, das Pilhas de Lenha dos Camponeses",
	-- {item:271629} Wood Bundle
	-- plural, as words: Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["{item:271629}: fletch it into Makeshift Stickin' Spears"] = "{item:271629}: transforme em Lanças de Espetar Improvisadas",

	-- Step 25: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp along the slopes and carry the stolen ore. Work south-west through their camps.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "Para o oeste, em {area:16737}: os gnolls de Cristarrubra acampam nas encostas e carregam o minério roubado. Avance para sudoeste pelos acampamentos deles.\nCuidado: {npc:255906}, um gnoll elite (nível 40), vaga pelos acampamentos do sudoeste: puxe os gnolls para longe dele.",

	-- Step 27: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam
	["South-east out of the hills: {npc:262399}, a prospector who deals with both sides, has camped by the Cinderscale dragonkin's hollow."] = "Saia das colinas para sudeste: {npc:262399}, uma garimpeira que negocia com os dois lados, acampou perto da depressão dos dracônicos Escama-de-brasa.",

	-- Step 28: The Cinderscale hollow
	["The Cinderscale hollow"] = "A depressão Escamácinza",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors guard its back, by the {item:271611}. The warriors are level 41-42: pull them one at a time. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "Os filhotes fazem ninho por toda a depressão; os guerreiros guardam o fundo, perto de {item:271611}. Os guerreiros são nível 41-42: puxe um de cada vez. Scaldaron, um draco elite raro, também pode estar por aqui: deixe-o em paz, a menos que tenha um grupo.",

	-- Step 30: Meadowsbrook
	-- {area:16735} Meadowsbrook · {area:16744} Southern Watch · {npc:263380} Ghostmaw
	["East to {area:16735}, the Alliance farm by the river: the farmhands work the fields and the feed satchels lie by the barns. {area:16744}, the Alliance outpost on the road, has guards: pass south of it.\nCareful: {npc:263380}, an elite (level 42), hunts along the river by the farm: keep an eye on the riverbank."] = "Para o leste até {area:16735}, a fazenda da Aliança junto ao rio: os peões trabalham nos campos e as sacolas de ração ficam perto dos celeiros. {area:16744}, o posto avançado da Aliança na estrada, tem guardas: passe ao sul dele.\nCuidado: {npc:263380}, um elite (nível 42), caça ao longo do rio perto da fazenda: fique de olho na margem.",

	-- Step 31: Rog'mar
	-- {area:16743} Rog'mar · {npc:263190} Tan'jani · {npc:256418} Krom'rosh · {npc:256655} Gorg · {npc:256657} Kreza Darkthorn · {npc:258031} Neza Bloodsnout
	["Back to {area:16743}, where your Hearthstone is set: {npc:263190} on the fort's west side first, then {npc:256418}, {npc:256655} by the cook fire, {npc:256657} and {npc:258031} on your way east through the fort."] = "Volte para {area:16743}, onde sua Pedra de Regresso está definida: primeiro {npc:263190}, no lado oeste do forte, depois {npc:256418}, {npc:256655} junto à fogueira, {npc:256657} e {npc:258031} no caminho para o leste pelo forte.",
	-- {npc:256655} Gorg
	["{npc:256655}, by the cook fire"] = "{npc:256655}, junto à fogueira",
	-- {quest:93976} The Goblin Trader · {npc:255897} Friz Frazzlespark · {area:16727} Powderfuse Port
	["{quest:93976}: for {npc:255897} in {area:16727}, keep it"] = "{quest:93976}: para {npc:255897} em {area:16727}, guarde-a",

	-- Step 33: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16743} Rog'mar
	["{npc:263380} is an elite (level 42) who hunts along the river south-west of {area:16743}, by the Farholde camp you go to next: grouping up is advised. The poster hangs in the middle of the fort."] = "{npc:263380} é um elite (nível 42) que caça ao longo do rio a sudoeste de {area:16743}, perto do acampamento de Farholde, para onde você vai em seguida: é recomendado formar um grupo. O cartaz fica no meio do forte.",
	-- {object:645164} WANTED! (no name in this language: may be words)
	["the {object:645164} poster"] = "o cartaz {object:645164}",

	-- Step 34: The training grounds
	["The training grounds"] = "O campo de treinamento",
	-- {npc:256655} Gorg · {item:265066} Hearty Stew · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Trainees = {npc:256749} Rog'mar Trainee
	["North of the fort the Rog'mar Trainees drill: use {npc:256655}'s {item:265066} on them.\nCareful: {npc:263380}, an elite (level 42), can come up from the river south of the fort: let him pass."] = "Ao norte do forte, os Recrutas de Rog'mar treinam: use o {item:265066} de {npc:256655} neles.\nCuidado: {npc:263380}, um elite (nível 42), pode subir do rio ao sul do forte: deixe-o passar.",

	-- Step 36: The river and the Farholde camp
	["The river and the Farholde camp"] = "O rio e o acampamento de Farholde",
	-- {npc:263190} Tan'jani · {npc:257079} Cavalry Scout Alturin · {npc:263380} Ghostmaw
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["South-west of Rog'mar the river runs between the farms: impale the Freshwater Crocolisks with {npc:263190}'s spears. The Alliance trains its scouts and priests at a camp on the far bank. {npc:257079}, the Alliance elite, rides the road just east of the camp: pull the scouts and priests away from it.\nCareful: {npc:263380}, an elite (level 42), hunts along this river: if he comes your way, back off and let him pass."] = "A sudoeste de Rog'mar, o rio corre entre as fazendas: empale os Crocoliscos de Água Doce com as lanças de {npc:263190}. A Aliança treina seus batedores e sacerdotes num acampamento na outra margem. {npc:257079}, o Elite da Aliança, percorre a estrada logo a leste do acampamento: puxe os batedores e sacerdotes para longe dela.\nCuidado: {npc:263380}, um Elite (nível 42), caça ao longo deste rio: se ele vier na sua direção, recue e deixe-o passar.",
	-- {npc:263190} Tan'jani
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["{npc:263190}'s spears, on the Freshwater Crocolisks in the river"] = "",

	-- Step 40: Tran'gul
	-- {npc:256710} Tran'gul · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["{npc:256710} stands beside {npc:256418} in the middle of {area:16743}: now that the Farholde camp has had its lesson, he has work in {area:16723}."] = "{npc:256710} está ao lado de {npc:256418} no meio de {area:16743}: agora que o acampamento de Farholde aprendeu a lição, ele tem trabalho em {area:16723}.",

	-- Step 41: Fuzzle
	-- {area:16723} Sunnyglade · {npc:259158} Fuzzle
	["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158} is in a cage on the south side of town."] = "",
	-- {npc:259158} Fuzzle
	["{npc:259158} in his cage, not the end of his escort"] = "",

	-- Step 42: Sunnyglade
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade
	["The cultists fill the streets and fields; the Shadowmancers on the town's northern side carry the missives. The finger bones drop from all of them.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass."] = "Os cultistas enchem as ruas e os campos; os Necromantes Sombrios no lado norte da cidade levam as missivas. Os ossos de dedo caem de todos eles.\nCuidado: {npc:256899}, um ogro Elite (nível 41), anda pelas ruas a oeste de {area:16723}, por volta de 44-47,47-52. Puxe os cultistas até você e deixe-o passar.",

	-- Step 43: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158} quer sair de {area:16723}: leve-o para o oeste até o tesouro dele na borda da vila e mantenha os cultistas longe dele.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "leve {npc:259158} para fora de {area:16723} até o tesouro dele, a oeste da cidade",

	-- Step 44: Tran'gul
	-- {area:16743} Rog'mar
	["East back to {area:16743}."] = "Volte para o leste até {area:16743}.",
	-- {quest:94727} Digging for Answers · {npc:260931} Clubtoe · {area:16723} Sunnyglade
	["{quest:94727}: for {npc:260931} in {area:16723}"] = "{quest:94727}: para {npc:260931} em {area:16723}",

	-- Step 45: Clubtoe
	-- {area:16723} Sunnyglade · {npc:260931} Clubtoe · {npc:256710} Tran'gul
	["West to {area:16723} again: {npc:260931}, a Twilight miner who wants out, waits at the town's eastern edge. Talk him round, then hand {npc:256710}'s quest in; one of the missing ogres stands a few steps west."] = "Para o oeste até {area:16723} de novo: {npc:260931}, um mineiro do Crepúsculo que quer sair, espera na borda leste da cidade. Convença-o e depois entregue a Missão de {npc:256710}; um dos ogros desaparecidos fica a alguns passos a oeste.",
	-- {npc:260931} Clubtoe
	["talk {npc:260931} round"] = "convença {npc:260931}",
	-- {npc:261208} Twilight Brute
	["{npc:261208}, a few steps west"] = "{npc:261208}, a alguns passos a oeste",

	-- Step 46: The ritual grounds
	["The ritual grounds"] = "Os terrenos do ritual",
	-- {area:16723} Sunnyglade · {npc:256899} Chogg'Zac
	["The ritualists and their empowered brutes gather at the ritual circles in the middle of {area:16723}: wreck five of the circles.\nCareful: {npc:256899}, the elite ogre (level 41), walks through here from the western streets: watch for him before each pull."] = "Os ritualistas e seus brutamontes fortalecidos se reúnem nos círculos de ritual no meio de {area:16723}: destrua cinco dos círculos.\nCuidado: {npc:256899}, o ogro Elite (nível 41), passa por aqui vindo das ruas a oeste: fique de olho nele antes de cada puxada.",
	-- plural, as words: Twilight Ritual Circles = {npc:262006} Twilight Ritual Circle
	["destroy 5 Twilight Ritual Circles"] = "destrua 5 Círculos Ritualísticos do Crepúsculo",

	-- Step 48: Twilight No More!
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:260931} Clubtoe · {quest:95420} Land of Giants · {npc:255829} Clugfist · {quest:94668} Bloodmaster's Ring · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised. {npc:260931} wants both his heads, and the rest of the zone's ogre story waits on them: {quest:95420}, {npc:255829}'s quests and the {quest:94668} in {area:16726}, then {npc:258570}'s camp in the west (about 21,000 XP in all). Skip him and the guide leaves those out."] = "",

	-- Step 49: Chogg'Zac
	["Clear the cultists around him first and come in with full health and mana."] = "",

	-- Step 50: Clubtoe
	-- {quest:95418} Spread the Word · {npc:256710} Tran'gul · {area:16743} Rog'mar
	["{quest:95418}: for {npc:256710} in {area:16743}"] = "{quest:95418}: para {npc:256710} em {area:16743}",

	-- Step 51: Tran'gul
	-- {area:16743} Rog'mar · {npc:260931} Clubtoe · {npc:256710} Tran'gul · {npc:255829} Clugfist
	["East back to {area:16743}: {npc:260931}'s word goes to {npc:256710}, and {npc:256710}'s to {npc:255829}, the ogres' chieftain."] = "Volte para o leste até {area:16743}: a mensagem de {npc:260931} vai para {npc:256710}, e a de {npc:256710} para {npc:255829}, o chefe dos ogros.",
	-- {quest:95420} Land of Giants · {npc:255829} Clugfist · {area:16726} Bolder'ok
	["{quest:95420}: for {npc:255829} in {area:16726}"] = "{quest:95420}: para {npc:255829} em {area:16726}",

	-- Step 52: WANTED: Scoutmaster Vargas
	-- {npc:260211} Scoutmaster Vargas · {npc:256728} Na'zok · {npc:258031} Neza Bloodsnout
	["{npc:260211} is an elite (level 42) at the Alliance scouts' camp in the hills south-east of {npc:256728}, where you go next: grouping up is advised. The poster hangs in the middle of the fort; {npc:258031} takes the eye, later in this guide."] = "{npc:260211} é um Elite (nível 42) no acampamento dos batedores da Aliança nas colinas a sudeste de {npc:256728}, para onde você vai em seguida: recomenda-se formar Grupo. O cartaz fica pendurado no meio do forte; {npc:258031} recebe o olho, mais adiante neste Guia.",
	-- {object:707249} Wanted (no name in this language: may be words)
	["the {object:707249} poster"] = "o cartaz de {object:707249}",

	-- Step 53: Na'zok's camp
	-- {npc:256728} Na'zok
	["{npc:256728}'s camp"] = "O acampamento de {npc:256728}",
	-- {area:16743} Rog'mar · {npc:256728} Na'zok
	["North-east from {area:16743} up into the hills: {npc:256728} watches the Paletusk boars from his camp."] = "A nordeste de {area:16743}, subindo as colinas: {npc:256728} vigia os javalis Presa-pálida do seu acampamento.",

	-- Step 54: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:255829} Clugfist
	["North-west to {area:16726}, the ogres' town. {npc:255829}, its chieftain, sits on the hill. The ogres are friendly while you leave them alone."] = "Para noroeste até {area:16726}, a cidade dos ogros. {npc:255829}, o chefe dela, fica sentado na colina. Os ogros são amistosos enquanto você os deixar em paz.",

	-- Step 57: The Twilight ogres' camp
	["The Twilight ogres' camp"] = "O acampamento dos ogros do Crepúsculo",
	-- {npc:256728} Na'zok · {npc:260973} Klunk · {item:269257} Skullbasher · {npc:260211} Scoutmaster Vargas
	-- plural, as words: Twilight Maulers = {npc:260968} Twilight Mauler · Farholde Ambushers = {npc:260023} Farholde Ambusher
	["The Twilight Maulers and Firecallers camp on the ridge east of {npc:256728}. {npc:260973}, who carries the {item:269257}, stands among them. Just south of the ogres, {npc:260211} (an Alliance elite, level 42) and his Farholde Ambushers hold the scouts' camp: keep north of it unless you came with a group for him."] = "Os Espancadores e os Invoca-fogo do Crepúsculo acampam na serra a leste de {npc:256728}. {npc:260973}, que carrega o {item:269257}, fica no meio deles. Logo ao sul dos ogros, {npc:260211} (um Elite da Aliança, nível 42) e seus Emboscadores de Farholde ocupam o acampamento dos batedores: fique ao norte dele, a menos que tenha vindo com um Grupo para enfrentá-lo.",
	-- {item:269257} Skullbasher · {npc:260973} Klunk
	["{item:269257}, from {npc:260973}"] = "{item:269257}, de {npc:260973}",

	-- Step 59: The paletusks
	["The paletusks"] = "Os Presa-pálida",
	-- {npc:256728} Na'zok
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk · Mature Paletusks = {npc:255851} Mature Paletusk
	["South down the hills, round the west side of the Alliance scouts' camp: tap the Young Paletusks with {npc:256728}'s staff to send them home; the Mature Paletusks around the hills drop the boar meat."] = "Desça as colinas para o sul, contornando o lado oeste do acampamento dos batedores da Aliança: toque os Presa-pálida Jovens com o cajado de {npc:256728} para mandá-los para casa; os Presa-pálida Adultos pelas colinas deixam cair a carne de javali.",
	-- {item:268521} Swineherd's Staff
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk
	["{item:268521}, on the Young Paletusks"] = "{item:268521}, nos Presa-pálida Jovens",
	-- {item:769} Chunk of Boar Meat
	-- plural, as words: Mature Paletusks = {npc:255851} Mature Paletusk
	["{item:769}, from the Mature Paletusks"] = "{item:769}, dos Presa-pálida Adultos",

	-- Step 61: Twilight camp before the escort
	["Twilight camp before the escort"] = "",
	-- {npc:258048} Jom-jom
	["Before taking {npc:258048} home, finish any Maulers and Firecallers you still need here. Stay on the ridge, north of Vargas and his ambushers."] = "",

	-- Step 62: Klunk before the escort
	-- {npc:260973} Klunk
	["{npc:260973} before the escort"] = "",
	-- {item:269257} Skullbasher · {npc:260973} Klunk · {npc:258048} Jom-jom
	["If you still need the {item:269257}, {npc:260973} is at the same camp as {npc:258048}. Take it back with the escort."] = "",

	-- Step 63: Jom-jom's Escape
	-- {npc:258048} Jom-jom · {npc:256728} Na'zok · {area:16726} Bolder'ok
	["{npc:258048} waits by the Twilight ogres' camp north-east of {npc:256728}: take him home to {area:16726} and keep the cultists off him. If he falls, take the quest from him again."] = "{npc:258048} espera junto ao acampamento dos ogros do Crepúsculo, a nordeste de {npc:256728}: leve-o para casa em {area:16726} e mantenha os sectários longe dele. Se ele morrer, pegue a missão com ele de novo.",
	-- {npc:258048} Jom-jom
	["{npc:258048}, in the cave"] = "",
	-- {npc:258048} Jom-jom · {area:16726} Bolder'ok
	["help {npc:258048} reach {area:16726}"] = "ajude {npc:258048} a chegar a {area:16726}",

	-- Step 64: Bolder'ok
	-- {npc:255829} Clugfist · {npc:257062} Jezap Jinglesprocket · {quest:94668} Bloodmaster's Ring
	["Back to {npc:255829} on his hill. {npc:257062} runs the {quest:94668} just below it."] = "De volta a {npc:255829}, na colina dele. {npc:257062} comanda {quest:94668} logo abaixo dela.",

	-- Step 67: Finish Might Makes Right
	-- {quest:95424} Might Makes Right
	["Finish {quest:95424}"] = "",
	-- {npc:255829} Clugfist · {npc:256728} Na'zok
	["If you joined the route with {npc:255829}'s hunt unfinished, the Maulers and Firecallers are at the Twilight camp on the ridge east of {npc:256728}. Stay north of Vargas and his ambushers."] = "",

	-- Step 68: Finish Unworthy Champion
	-- {quest:95425} Unworthy Champion
	["Finish {quest:95425}"] = "",
	-- {npc:260973} Klunk · {item:269257} Skullbasher · {npc:255829} Clugfist
	["{npc:260973} is in the same Twilight camp. Take his {item:269257} back to {npc:255829} with any finished hunt."] = "",

	-- Step 69: Clugfist: the finished hunt
	-- {npc:255829} Clugfist
	["{npc:255829}: the finished hunt"] = "",

	-- Step 70: Clugfist: the recovered Skullbasher
	-- {npc:255829} Clugfist · {item:269257} Skullbasher
	["{npc:255829}: the recovered {item:269257}"] = "",

	-- Step 71: Clugfist
	-- {quest:95428} Clugfist's Decree · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95428}: for {npc:256418} in {area:16743}, later in this guide"] = "{quest:95428}: para {npc:256418} em {area:16743}, mais adiante neste Guia",
	-- {quest:94669} Pay to Play
	["{quest:94669}: the Ring's bouts, one-on-one fights with elites (41-45); a deposit first"] = "{quest:94669}: as lutas do Ringue, duelos contra Elites (41-45); primeiro um depósito",

	-- Step 72: The Bloodmaster's Ring: Buzzbeak
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Buzzbeak"] = "{quest:94670}: Buzzbeak",
	-- {npc:255829} Clugfist · {npc:258626} Mog'thar · {npc:257059} Chub'chob · {npc:257062} Jezap Jinglesprocket
	["Each bout is a fight in the ring below {npc:255829}'s hill against an elite: Buzzbeak (41), Kronk and Bonegnaw (42), {npc:258626} (43), Snufflesnout (44) and {npc:257059} (45). Come in rested, with full health and mana; if a bout goes wrong, {npc:257062} offers it again."] = "Cada luta é no ringue abaixo da colina de {npc:255829}, contra um Elite: Buzzbeak (41), Kronk e Bonegnaw (42), {npc:258626} (43), Snufflesnout (44) e {npc:257059} (45). Chegue descansado, com vida e mana cheias; se uma luta der errado, {npc:257062} a oferece de novo.",
	-- {quest:94670} Bloodmaster's Ring
	["{quest:94670}: Buzzbeak"] = "{quest:94670}: Buzzbeak",
	["beat Buzzbeak"] = "derrote Buzzbeak",

	-- Step 73: The Bloodmaster's Ring: Kronk and Bonegnaw
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Kronk and Bonegnaw"] = "{quest:94670}: Kronk e Bonegnaw",
	["Kronk"] = "Kronk",
	["Bonegnaw"] = "Bonegnaw",

	-- Step 74: The Bloodmaster's Ring: Mog'thar
	-- {quest:94962} Bloodmaster's Ring · {npc:258626} Mog'thar
	["The {quest:94962}: {npc:258626}"] = "{quest:94962}: {npc:258626}",

	-- Step 75: The Bloodmaster's Ring: Snufflesnout and Chub'chob
	-- {quest:94964} Bloodmaster's Ring · {npc:257059} Chub'chob
	["The {quest:94964}: Snufflesnout and {npc:257059}"] = "{quest:94964}: Fuçafocinho e {npc:257059}",
	-- {npc:257062} Jezap Jinglesprocket · {npc:258626} Mog'thar
	["{npc:257062} offers the last two once Gobam's errands are done (players' recordings), which this guide leaves out. They are level 44 and 45: leave them for later if {npc:258626} was a close fight."] = "{npc:257062} oferece as duas últimas depois que as tarefas de Gobam são concluídas (segundo gravações de jogadores), que este Guia deixa de fora. Elas são de nível 44 e 45: deixe-as para depois se a luta contra {npc:258626} foi apertada.",
	["Snufflesnout (44)"] = "Fuçafocinho (44)",
	-- {npc:255829} Clugfist
	["{npc:255829}, on the hill"] = "{npc:255829}, na colina",

	-- Step 76: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz
	["South-east down out of the hills to {area:16727}, the goblins' harbour on the coast. {npc:255897} keeps a stall at the west end of the docks, {npc:259962} cooks by the inn, and {npc:259961} works the north pier."] = "Desça das colinas para sudeste até {area:16727}, o porto dos goblins no litoral. {npc:255897} tem uma banca na ponta oeste das docas, {npc:259962} cozinha junto à Estalagem e {npc:259961} trabalha no píer norte.",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "O cartaz {object:628948} perto da estalagem: {npc:260235}",

	-- Step 77: Wharfmaster Whizzbuzz
	-- {npc:259961} Wharfmaster Whizzbuzz · {item:277974} Twice Reordered Package
	["{npc:259961} on the north pier takes Lozgil's {item:277974}."] = "{npc:259961}, no píer norte, recebe o {item:277974} de Lozgil.",

	-- Step 78: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001} é um elite (nível 42) na costa sul: é recomendado formar um grupo.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "O cartaz {object:628948} perto da estalagem",

	-- Step 79: The murlocs, south-west
	["The murlocs, south-west"] = "Os murlocs, a sudoeste",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "Siga a costa para sudoeste a partir do porto: os murlocs de água salgada acampam nas praias. No caminho, um couro pintado está esticado ao lado da trilha: ele inicia {quest:95260} para {npc:260231} nas docas.",

	-- Step 81: Back through the port
	["Back through the port"] = "De volta pelo porto",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "Volte para o norte pela costa: entregue os murlocs e o couro nas docas a caminho dos rastejadores.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms grow on the ridge west of the pirates"] = "{quest:95261}: as entranhas das feras vêm pelo caminho; os cogumelos crescem na serra a oeste dos piratas",

	-- Step 82: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "Os rastejadores e {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962}, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "Ao norte pela praia a partir das docas: os rastejadores deixam cair a carne para {npc:259962}, e as entranhas deles contam para {npc:260231}. {npc:260235}, um caranguejo grande, anda pelas pedras a leste das docas. {npc:259758}, um Raro Elite de nível 49, percorre esta costa das docas até o acampamento dos piratas: se o vir, mantenha distância.",
	["Keep entrails from these crawlers; the later ridge and beach finish any missing ones."] = "",

	-- Step 87: Before the Eastsea camp
	["Before the Eastsea camp"] = "",
	-- {area:16727} Powderfuse Port
	-- plural, as words: Eastsea Musketeers = {npc:257910} Eastsea Musketeer · Jungle Stalkers = {npc:687} Jungle Stalker
	["The Eastsea Musketeers reach 43. Leave the camp for now. At 40 or 41, if Raptor Mastery is still in your log, the Jungle Stalkers west of the Venture Co. mine in Stranglethorn are 40-41. At 42 resume on the beach north of {area:16727} for the buccaneers and musketeers."] = "",

	-- Step 88: The Eastsea pirates
	["The Eastsea pirates"] = "Os piratas do Mar Leste",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "Siga a costa para nordeste até o acampamento dos piratas nos penhascos. Os bucaneiros e mosqueteiros carregam as mercadorias contrabandeadas. {npc:259758} também anda pelo acampamento: fique de olho nele.",

	-- Step 90: Wharfmaster Whizzbuzz
	["Take the raider and powder-keg jobs for the return to the cliffs at 44."] = "",

	-- Step 94: Friz Frazzlespark
	-- {npc:260390} Captain Bentcoin
	["Keep the delivery for {npc:260390} on the raider visit."] = "",

	-- Step 97: Back to Argo Brinewhistle
	-- {npc:260231} Argo Brinewhistle
	["Back to {npc:260231}"] = "",

	-- Step 98: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "{item:268632} pelo caminho",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42) wanders the shore and {npc:263380} (elite, 42) the river: take your beasts away from them."] = "A maioria das feras em {zone:2548} deixa cair {item:268632} para {npc:260231}: os rastejadores da costa neste litoral e os javalis na serra a oeste dos piratas.\nCuidado: {npc:257001} (Elite, 42) vagueia pela praia e {npc:263380} (Elite, 42) pelo rio: afaste suas feras deles.",

	-- Step 99: Wharfmaster Whizzbuzz: the raiders
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the raiders"] = "",

	-- Step 100: Wharfmaster Whizzbuzz: the powder kegs
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the powder kegs"] = "",

	-- Step 101: Friz Frazzlespark: the captain’s bargain
	-- {npc:255897} Friz Frazzlespark
	["{npc:255897}: the captain’s bargain"] = "",

	-- Step 102: Wharfmaster Whizzbuzz: the ships
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the ships"] = "",

	-- Step 104: Before the raiders
	["Before the raiders"] = "",
	-- {quest:95124} Admiral Lamora · {npc:259961} Wharfmaster Whizzbuzz · {area:43} Wild Shore · {area:35} Booty Bay
	["The raiders and {quest:95124} reach 45. Pause here at {npc:259961} on the north pier. At 42-43, if you still have Keep An Eye Out or Up to Snuff, the pirates on the {area:43} south of {area:35} count; stay on the beach, not the ships. If those are already done, don't make that trip. At 44 resume here for the raiders on the cliffs. You don't need to farm the first camp."] = "",

	-- Step 105: The pirates' second wave
	["The pirates' second wave"] = "A segunda onda dos piratas",
	-- {npc:259758} Gul'gash
	-- plural, as words: Eastsea Raiders = {npc:257915} Eastsea Raider
	-- was: ["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, a level or two over you here: pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "Ao norte pela costa a partir do porto: os saqueadores e bombardeiros do Mar Leste se entrincheiraram nas encostas a oeste do acampamento dos bucaneiros, entre seus barris de pólvora. Fique de olho em {npc:259758} nestes penhascos.\nCuidado: os Saqueadores do Mar Leste são de nível 44-45, um ou dois níveis acima de você aqui: puxe-os um de cada vez da beira das encostas e fique longe do acampamento atrás deles."
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, so pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "",

	-- Step 106: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "Para o leste pelos penhascos até o fim do acampamento dos piratas: {npc:260390} espera junto à água, com {npc:260391} ao lado dele.",

	-- Step 109: Wharfmaster Whizzbuzz
	-- {quest:95124} Admiral Lamora
	["Whizzbuzz gives you the ship charges and the order for {quest:95124}."] = "",

	-- Step 111: Friz Frazzlespark
	-- {npc:260405} Wharfmaster Steamfizzle · {area:977} Steamwheedle Port · {zone:1446} Tanaris
	["Keep the shipping papers for {npc:260405} at {area:977} in {zone:1446}."] = "",

	-- Step 112: The pirates' ships
	["The pirates' ships"] = "Os navios dos piratas",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} patrols the top deck of the middle ship. Once she's down, go below deck for the loot chest in the hold. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, so clear the deck around her first and come in with full health."] = "",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, o navio do sul",
	["Open Lamora's chest in the hold"] = "",
	["the middle ship"] = "o navio do meio",
	["the northern ship"] = "o navio do norte",

	-- Step 113: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "Cogumelos Carne-podre",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "Do navio do norte, siga para oeste e suba a serra: os Cogumelos Carne-podre crescem entre as pedras, perto do acampamento dos ogros do Crepúsculo. Os Presapálidas Maduros na serra também deixam cair entranhas.",

	-- Step 114: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "Termine as {item:268632}",
	-- {npc:259758} Gul'gash
	["South-east back towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "Volte para sudeste rumo ao porto: os rastejadores da costa na praia ao norte das docas são as entranhas mais rápidas. {npc:259758} também desce até esta praia.",

	-- Step 118: Argo Brinewhistle
	-- {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum
	["{npc:260231} can give you the bait for the shallows south-west of the port. {npc:257001}, the elite, walks the same shore."] = "",

	-- Step 119: The Monster Surfaces
	-- {npc:260231} Argo Brinewhistle · {item:268647} Big Ball o' Bait · {npc:257001} Old Rot-Chum
	["At the junk in the shallows south-west of the port, use {npc:260231}'s {item:268647}. Kill the threshadon that comes to the bait and take its head. Give {npc:257001}, the elite that walks this shore, plenty of room."] = "",
	-- {item:268647} Big Ball o' Bait
	["{item:268647} at the junk"] = "",
	["Loot the summoned threshadon's head"] = "",

	-- Step 121: Rog'mar
	-- {area:16743} Rog'mar · {npc:256418} Krom'rosh · {npc:255829} Clugfist · {npc:258570} Da'grosh
	["Back to {area:16743} from the port, where your Hearthstone is set. {npc:256418} in the middle of the fort: {npc:255829}'s word sends him looking for {npc:258570}, his warrior in the west."] = "Volte do porto para {area:16743}, onde sua Pedra de Regresso está vinculada. {npc:256418}, no meio do forte: a palavra de {npc:255829} o faz procurar {npc:258570}, seu guerreiro no oeste.",
	-- {quest:94744} The Wayward Warrior · {npc:258570} Da'grosh · {area:16723} Sunnyglade
	["{quest:94744}: for {npc:258570}, west of {area:16723}"] = "{quest:94744}: para {npc:258570}, a oeste de {area:16723}",

	-- Step 123: Fly to Kargath
	-- {npc:258570} Da'grosh · {npc:256899} Chogg'Zac · {zone:2548} Riverglades · {area:16743} Rog'mar · {npc:255993} Grakna · {area:340} Kargath · {area:3} Badlands
	["The rest of this guide is {npc:258570}'s camp in the west, which waits on {npc:256899}: without him the {zone:2548} end here. Back to {area:16743} from the port, where your Hearthstone is set: {npc:255993}, the wind rider master in the middle of the fort, flies to {area:340} in the {area:3}, where the next guide starts."] = "",

	-- Step 124: Da'grosh
	-- {area:16743} Rog'mar · {area:16723} Sunnyglade · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {npc:256418} Krom'rosh
	["West from {area:16743} through {area:16723} and on up the valley towards {area:16685}: {npc:258570}, {npc:256418}'s wayward warrior, keeps a camp in the hills below the Twilight cult's fortress."] = "Para oeste a partir de {area:16743}, passando por {area:16723} e subindo o vale rumo a {area:16685}: {npc:258570}, o guerreiro desgarrado de {npc:256418}, mantém um acampamento nas colinas abaixo da fortaleza do culto do Crepúsculo.",

	-- Step 125: Crag'rog
	-- {npc:260993} Crag'rog · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:260993}, a {area:16726} ogre, hides in the cave west of {npc:258570}'s camp."] = "{npc:260993}, um ogro de {area:16726}, se esconde na caverna a oeste do acampamento de {npc:258570}.",

	-- Step 126: The Twilight camps
	["The Twilight camps"] = "Os acampamentos do Crepúsculo",
	-- {npc:258570} Da'grosh · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg · {npc:258023} Sergeant Riftan
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer · Farholde Lookouts = {npc:258686} Farholde Lookout
	["The cult's camps fill the valley south and west of {npc:258570}. Free the captive Rog'mar Scouts as you find them. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them. {npc:258023}'s Alliance camp sits at the valley's south end, and its Farholde Lookouts (level 46) attack the Horde: stay north of it."] = "Os acampamentos do culto ocupam o vale ao sul e a oeste de {npc:258570}. Liberte os Batedores Rog'mar cativos conforme encontrá-los. Executores do Crepúsculo (elites, nível 45) patrulham os acampamentos: observe por onde andam antes de cada puxada. {npc:256881} e {npc:256891} (elites, 46) ocupam a fortaleza na cabeceira do vale: afaste os cultistas deles. O acampamento da Aliança de {npc:258023} fica na ponta sul do vale, e seus Vigias de Farholde (nível 46) atacam a Horda: fique ao norte dele.",
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout
	["free five captive Rog'mar Scouts"] = "liberte cinco Batedores Rog'mar cativos",

	-- Step 127: The ogre mine
	["The ogre mine"] = "A mina dos ogros",
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine: talk five of them into rising up against their masters.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in."] = "Ao norte dos acampamentos, o culto faz ogros mineiros trabalharem numa mina: convença cinco deles a se rebelar contra seus mestres.\nCuidado: Executores do Crepúsculo (elites, nível 45) passam pela entrada da mina no caminho pelos acampamentos. Espere um passar antes de entrar.",
	-- plural, as words: Ogre Miners = {npc:260995} Ogre Miner
	["recruit five Ogre Miners"] = "recrute cinco Ogros Mineiros",

	-- Step 130: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881} é um elite (nível 46) na fortaleza no alto do vale, cercado pelos Executores: recomenda-se formar um grupo.",

	-- Step 131: Twilight's Shroud
	-- {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["The next guide flies from {area:340} in the {area:3}: up through {area:16685}, the pass at the valley's north-west end, just north of {npc:258570}'s camp. Coming from {area:16743}, ride west through {area:16723} and keep north of the Twilight camps below the pass."] = "",

	-- Step 132: Kargath
	-- {area:3} Badlands · {area:340} Kargath
	["Across the {area:3} to {area:340}, the Horde fortress built into the cliffs at the zone's western edge: its flight master stands at the foot of the fortress."] = "Atravesse {area:3} até {area:340}, a fortaleza da Horda construída nos penhascos na borda oeste da Zona: o Mestre de voo fica ao pé da fortaleza.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the port, from the north pier west through the docks."] = "De volta ao porto, do píer norte para oeste pelas docas.",
	-- ["Back to the port."] = "De volta ao porto.",
	-- ["Careful: {npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised under 43. Clear the cultists around him first and come in with full health and mana: recorded players of 42-43 killed him alone. {npc:255829}'s quests in {area:16726} wait on this one: skip him and {quest:95420}, the {area:16726} quests and {npc:258570}'s camp in the west go with him (about 21,000 XP); the guide then leaves them out."] = "Cuidado: {npc:256899}, o ogro de duas cabeças na borda oeste de {area:16723}, é um Elite (nível 41): recomenda-se formar Grupo abaixo do nível 43. Limpe os cultistas ao redor dele primeiro e chegue com vida e mana cheias: jogadores registrados de nível 42-43 o mataram sozinhos. As Missões de {npc:255829} em {area:16726} dependem desta: se você o pular, {quest:95420}, as Missões de {area:16726} e o acampamento de {npc:258570} no oeste vão junto (cerca de 21.000 XP); o Guia então as deixa de fora.",
	-- ["Down to the port."] = "Desça até o porto.",
	-- ["New in Forever: this guide follows what players did in the {area:16591}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nFrom {area:340}, ride south-east across the {area:3} to the zone's southern edge: the pass of {area:16685} leads down into the {area:16591}. {area:16743}, the Horde's fort, stands in the middle of the zone, east along the valley."] = "Novidade do Forever: este guia segue o que os jogadores fizeram em {area:16591}. Se uma etapa estiver errada, avise-nos no Discord ou no GitHub do Polestar e diga qual é a etapa.\nDe {area:340}, cavalgue para sudeste por {area:3} até a borda sul da zona: o desfiladeiro de {area:16685} desce até {area:16591}. {area:16743}, o forte da Horda, fica no meio da zona, a leste pelo vale.",
	-- ["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, a level or two over you here: pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "Ao norte pela costa a partir do porto: os saqueadores e bombardeiros do Mar Leste se entrincheiraram nas encostas a oeste do acampamento dos bucaneiros, entre seus barris de pólvora. Fique de olho em {npc:259758} nestes penhascos.\nCuidado: os Saqueadores do Mar Leste são de nível 44-45, um ou dois níveis acima de você aqui: puxe-os um de cada vez da beira das encostas e fique longe do acampamento atrás deles.",
	-- ["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, a level or two over you here: clear the deck around her first and come in with full health."] = "Volte mais uma vez aos penhascos dos piratas. Plante as cargas de Whizzbuzz nos três navios atracados abaixo do acampamento, de sul para norte; {quest:95124} fica junto ao do meio, com seu baú de saque ao lado. Fique de olho em {npc:259758} no caminho.\nCuidado: {quest:95124} é de nível 45, um ou dois níveis acima de você aqui: limpe o convés ao redor dela primeiro e chegue com a vida cheia.",
	-- ["The next guide flies from {area:340} in the {area:3}: north out of {npc:258570}'s valley and up through {area:16685}, the way through to the {area:3}."] = "O próximo Guia parte de voo de {area:340}, em {area:3}: siga para o norte saindo do vale de {npc:258570} e suba por {area:16685}, a passagem para {area:3}.",
	-- ["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244} ronda as águas rasas a sudoeste do porto, abaixo das praias dos murlocs. {npc:257001}, um elite, anda pela costa ali perto: mantenha distância.",
	-- ["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158}, a kobold who wants out, hides in the middle of the town."] = "A oeste de Rog'mar, o culto do Crepúsculo domina a cidade agrícola de {area:16723}. {npc:259158}, um kobold que quer sair, se esconde no meio da cidade.",
	-- ["{npc:255897}: {quest:95296}, for {npc:260405} at {area:977} in the {zone:1444} & {zone:1446} guide"] = "{npc:255897}: {quest:95296}, para {npc:260405} em {area:977}, no Guia de {zone:1444} e {zone:1446}",
	-- ["{npc:263190}'s spears, on the Freshwater Crocolisks"] = "Lanças de {npc:263190}, nos Crocoliscos de Água Doce",
	-- ["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: uma fera grande nas águas rasas a sudoeste do porto, perto de {npc:257001}, o elite",
	-- ["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: para {npc:260390} no acampamento dos piratas",
}
