-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Voe para a {area:2268}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Mestre de voo de {area:272}",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Os itens de {quest:5168} estão nas próximas zonas das Terras Pestilentas: guarde-a.",

	-- Step 3: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: vá matando estes pelo caminho",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "Os Cães Pestilentos e seus filhotes miúdos andam pelas margens do lago a sudoeste da capela; Quirópragos e Vermes Carniceiros dividem o terreno.\nA espada estilhaçada está no chão, a noroeste do lago.",

	-- Step 4: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "O campeão da {npc:15193} ocupa a casa da {area:2260}, ao norte da {area:2261}.",

	-- Step 5: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Cães Pestilentos Miúdos e Quirópragos vagam pelas colinas ao norte de {area:2260}, e Vermes Carniceiros rastejam entre eles; avance para o norte rumo a {area:2627}.",

	-- Step 6: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "O fantasma {npc:11140} fica junto a uma cabana na {area:2627}, no canto noroeste.",
	["Inside"] = "Lá dentro",

	-- Step 7: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: vá matando estes pelo caminho",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Cães Pestilentos Frenéticos e Quirópragos Monstruosos dividem os campos em volta do {area:2272} e da {area:2271}, ao sul de {area:2273}.",

	-- Step 8: Eastern Plaguelands: kill these as you meet them
	-- {area:2275} Northpass Tower · {area:2622} Pestilent Scar
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Blighted Horrors = {npc:8521} Blighted Horror
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Os Patrulheiros, Trilheiros e Mateiros alto-élficos guardam o pavilhão perto de {area:2275}; o Registro está lá dentro. Os Patrulheiros chegam ao nível 60: puxe um de cada vez. Quirópragos Nóxios voam sobre os campos no caminho.\nO crânio fica em {area:2622}, entre Horrores Empesteados e Monstruosidades da Peste.",
	["Underwater"] = "Debaixo d'água",

	-- Step 9: Pathstrider
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} anda por {area:2276}: procure dentro do círculo no mapa",

	-- Step 10: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant
	["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "Cavalgue para o sul, saindo do pavilhão, até {area:2264}, na estrada. {item:15447} estraga em dez minutos: mate rápido o Flagelo da vila e reúna as sete peças com {item:15454} de uma vez.\nCuidado: Serviçais Evanescentes chamam ajuda num raio de 25 metros quando caem a 40% de vida. Fora de combate, eles também ficam invisíveis com {spell:10228}. Se o pedido de ajuda acontecer dentro da vila, muitos monstros podem entrar na briga. Lutar perto da periferia reduz esse risco.",

	-- Step 11: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Volte para oeste até a {area:2260}.",

	-- Step 13: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:11897} é elite de nível 60: a maioria das classes encara sozinha no nível 62, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 15: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Voe para {area:1497}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Mestre de voo de {area:2268}",

	-- Step 16: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 17: Orgrimmar
	-- {npc:10880} Warcaller Gorlach · {npc:7776} Talo Thornhoof · {quest:7492} Camp Mojache
	["{npc:10880}, outside the front gate on the way in: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}, do lado de fora do portão da frente, na entrada: para {npc:7776} em {quest:7492}, no fim deste guia",

	-- Step 18: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "Voe para {area:1997}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 19: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Voe para {area:1638}",

	-- Step 20: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033} (Druidas) treina em {area:1639}, {npc:246344} (Paladinos) também na cidade.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} no {area:1639}; {npc:246344}",

	-- Step 21: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 23: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Suba a estrada para o norte. O caldeirão fica em {area:1762}, logo a sudoeste de {area:1769}; os furbolgs Lenha Morta de lá são hostis.",

	-- Step 24: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Só se {quest:8471} caiu para você: {npc:11558} espera na entrada de {area:1769} pelo lado de {zone:1448}, e só fala com você com reputação Neutra com os Presamatos.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} anda por aqui: procure dentro do círculo no mapa",

	-- Step 26: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atravesse {area:1769} e pegue o ramo do túnel para {zone:1450}. {npc:11801} está em {area:2361}.",

	-- Step 27: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 28: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "As duas missões levam a {zone:1451}: guarde-as.",

	-- Step 30: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Volte pelo túnel, pegue a saída para {zone:1452} e siga para o sul até {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086} fica em {zone:1448}, numa viagem futura: guarde-a.",

	-- Step 31: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Ferujas Lunamarcas",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Siga para leste até {area:2255} e saia dela para o norte; as Ferujas Lunamarcas vagam pelas colinas das encostas sul de {area:2241}. Puxe uma de cada vez.",

	-- Step 33: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voar para {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Mestre de voo de {area:2255}",

	-- Step 34: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} é um fantasma no cemitério logo ao norte de {area:976}; a Lápide Suspeita fica ao sul dele, fora da muralha da cidade.",

	-- Step 35: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Use {item:12928} em {npc:7583}, a menina goblin em {area:976}. {npc:10977} e {npc:10978} levam o susto mais adiante na rota.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "",

	-- Step 36: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "A máquina {object:142071}",

	-- Step 37: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} volta para {npc:8737} na Cratera Un'Goro: guarde-a.",

	-- Step 38: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto à estrada da {area:1336}, ao sul de {area:976}.",

	-- Step 39: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Voe para {area:1099}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 40: Camp Mojache
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}, a few steps from the flight master"] = "{npc:7776}, a poucos passos do mestre de voo",
	-- {area:2577} Dire Maul
	["His next task is for the {area:2577} dungeon: leave it."] = "A próxima tarefa dele é da masmorra {area:2577}: deixe para lá.",

	-- Step 41: Ruins of Isildien
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Voe para o {area:1099}. Os ninhos de hipogrifo ficam no sul de {zone:1444}; cada um guarda um ovo para o {object:142071}.",

	-- Step 42: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Voe para {area:541}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Mestre de voo de {area:1099}",

	-- Step 43: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "O voo pousa em {area:541}: {npc:9997} fica ao lado do mestre de voo, e {npc:8737}, junto à caverna a poucos passos. O trabalho de {npc:9997} fica em Un'Goro, na volta para o norte do próximo guia.",
	-- {quest:3941} A Gnome's Assistance · {npc:9117} J.D. Collie · {area:541} Marshal's Refuge
	["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "{quest:3941} vai para {npc:9117} na caverna daqui, na volta do próximo guia a {area:541}: guarde-a.",

	-- Step 44: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "O desfiladeiro vindo de Un'Goro sai no {area:3077}, o cemitério no nordeste de {zone:1451}. {npc:13220} fica entre os túmulos.",

	-- Step 45: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {quest:1123} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "Cavalgue para sudoeste até as ruínas da {area:2738}. O {object:179565} para {quest:1123} fica dentro de uma das casas em ruínas.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Um pergaminho rasgado está na entrada da {area:2261}, a cripta ao sul da {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Volte pelo túnel, pegue a saída para {area:618} e siga para o sul até {area:2246}.",
	-- ["Back to {area:1638}"] = "De volta a {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Voe para {zone:1458}, pegue o zepelim para {zone:1454} e siga voando para {area:1638}.",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Voe para o {area:541}, depois siga para sudoeste pela Cratera Un'Goro até o desfiladeiro que leva a {zone:1451}. O próximo guia começa em {area:3077}, onde o desfiladeiro termina.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atravesse {area:1769} e pegue o ramo do túnel para {area:493}. {npc:11801} está em {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya se esconde entre os trolls Esfolamusgo de {area:2273}, no canto nordeste.",
	-- ["Hameya's mound"] = "O monte de Hameya",
	-- ["Hameya's scroll"] = "O pergaminho de Hameya",
	-- ["Hippogryph eggs"] = "Ovos de hipogrifo",
	-- ["On to {zone:1451}"] = "Rumo a {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "No {area:1641}. Tenha Lã, Seda e Magitrama na bolsa.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Cães Pestilentos e seus filhotes vagam pelas margens do lago a sudoeste da capela.",
	-- ["Ride east out of the {area:1497} along the road; the {area:152} guards the way into the {area:28}."] = "Siga a cavalo para leste, saindo da {area:1497}, pela estrada; {area:152} guarda o caminho para {area:28}.",
	-- ["Sword of Marduk"] = "Espada de Marduk",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Os Patrulheiros, Trilheiros e Mateiros altos elfos guardam o pavilhão perto da {area:2275}; os Arquivos estão lá dentro. Os Patrulheiros chegam ao nível 60: puxe um de cada vez. Quirópragos Nóxios sobrevoam os campos no caminho.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "A espada estilhaçada está no chão a noroeste do lago.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "O crânio está na {area:2622}, entre Horrores Empesteados e Monstruosidades da Peste.",
	-- ["The western hills"] = "As colinas do oeste",
	-- ["The {area:2622}"] = "A {area:2622}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "O {object:177675} fica logo atrás da {area:2261}.",
	-- ["Upstairs"] = "No andar de cima",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} estraga em dez minutos: mate rápido o Flagelo da cidade e moa as sete partes com o {item:15454} na hora.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "A fazenda de {npc:10778} é a primeira a leste de {area:152}. Os Carniçais Grasnantes da fazenda carregam a outra metade do pingente dela; {npc:11075} guarda o caldeirão no campo.\nCuidado: um ou dois mortos-vivos costumam lutar ao lado dele, e mais mestres da caldeira podem atacar depois que você usar o caldeirão.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "O campeão de {npc:15193} ocupa a casa da {area:2260}.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "O mestre de voo de {object:1661} fica na torre oeste do {object:36078}, fora das muralhas.",
}
