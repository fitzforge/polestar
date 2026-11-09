-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe para {object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "Mestre de voo de {area:75}",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 4: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 6: Riding at 40
	["Riding at 40"] = "Montaria no 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Equitação exige nível 40 e custa 100 ouros; aprendê-la dá a você uma montaria. {npc:4752} ensina os Orcs em {object:172958}, junto ao canil de {npc:3362}. Celonatos aprendem com {npc:265756} em {area:17684}, em {area:16638}, na Ilha de Zefras, com um Vagavento: o barco celeste para a ilha sai dos penhascos ao sul de {area:17045}, ao norte de {zone:1456}, mais ou menos a cada cinco minutos. As outras montarias da sua raça custam 20 ouros cada: Colecionáveis, Montarias · Nível 40 tem um guia para cada uma.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instrutor de montaria",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Lobos: {npc:3362}, ao lado de {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Montaria e Vagaventos: {npc:265756}, em {area:17684}, {area:16638}, na Ilha de Zefras.",

	-- Step 8: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "Equitação exige nível 40 e custa 100 ouros; aprendê-la dá a você uma montaria. Cada raça aprende com o instrutor da própria raça: o seu é {npc:7953} em {area:367}, a uma curta cavalgada ao sul de {zone:1454}, pela estrada de {zone:1411}, com os raptores de Zjolnir (20 ouros cada) ao lado dele. Depois, volte a cavalo até o mestre de voo de {zone:1454}.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptores: Zjolnir, ao lado de {npc:7953} em {area:367}.",

	-- Step 9: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Voe para {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 11: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "Seu instrutor fica em {zone:1456}: {npc:3033} (Druidas) em {area:1639}, {npc:246344} (Paladinos).",

	-- Step 13: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "Equitação exige nível 40 e custa 100 ouros; aprendê-la dá a você uma montaria. Cada raça aprende com o instrutor da própria raça: o seu é {npc:3690} em {area:222}, com os kodos de {npc:3685} (20 ouros cada) ao lado dele. Depois, suba a cavalo de volta ao mestre de voo de {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instrutor de montaria",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, ao lado de {npc:3690} em {area:222}.",

	-- Step 14: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Voe para {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 16: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} para o Corcel Vil",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "Voe de {zone:1454} para {area:392}; {npc:6251} fica na colina acima das docas.",

	-- Step 17: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 20: Mirage Raceway
	-- {area:484} Freewind Post · {zone:1446} Tanaris · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["The road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "A estrada de {area:484} a {zone:1446} passa por {area:2240}, nas {area:439}: {npc:4454} fica no acampamento dos gnomos ao lado da trilha, {npc:4630} e {npc:4709} perto do acampamento dos goblins. {npc:4630} primeiro, depois {npc:4709}, que sai correndo para manter Rizzle ocupado; depois pegue os planos de Rizzle no acampamento dos gnomos e leve-os de volta a {npc:4630}.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}: {quest:1137}, de Martek em {zone:1418}",

	-- Step 21: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Para {area:976}",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} é a cidade goblin murada logo depois da fronteira de {zone:1446}.",

	-- Step 23: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}: vá matando estes pelo caminho",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Os bandidos e ladrões acampam nas dunas a leste de {area:976}. Qualquer Errante pode carregar um cantil: guarde dez, cinco para cada recompensa do Rastamala.\nCuidado: os Ladinos Errantes (nível 43-44) andam furtivos, então podem chegar sem ser vistos.",
	["water pouches in your bags"] = "bolsas de água nas bolsas",

	-- Step 25: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Siga para o nordeste até o porto goblin na costa.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, lá dentro",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, lá dentro",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}: os guinchadores vivem em {zone:1444}, na próxima visita a {zone:1444}",

	-- Step 26: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}: vá matando estes pelo caminho",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Ao sul pela costa, os piratas dos Mares do Sul ocupam a enseada. {npc:7883} e a carga roubada ficam no cais, lá no fundo. Qualquer pirata pode deixar cair um chapéu, os sequestradores mais que todos.\nCuidado: dois ou três piratas ficam com {npc:7883}, e muitos outros piratas da vila entram na briga assim que ela começa.",
	["Upstairs"] = "No andar de cima",

	-- Step 27: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}: vá matando estes pelo caminho",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Os magos das sombras, ladinos e assassinos acampam a sudeste de {area:976}.\nA sudeste de Geringontzan, os bandidos Errantes acampam nas dunas; {npc:7847} fica no acampamento do leste.\nCuidado: os Ladinos Errantes ficam furtivos fora de combate, então ladinos escondidos podem entrar numa briga que você começar num acampamento.\nCuidado: dois Ladinos Errantes furtivos acompanham o Califa aonde ele for. No acampamento onde ele surge, dois magos das sombras e seus lacaios estão perto o bastante para entrar na luta. Lá perto das torres dá para enfrentá-lo sem eles.",

	-- Step 28: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "Siga a cavalo para nordeste de volta ao porto: {npc:7881}, a {npc:15165} e o Chefe de Segurança recebem o que {area:1336} deu a você. {area:976} fica a oeste dele.",
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "para {area:35}, por volta do nível 50",

	-- Step 30: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 32: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777} anda por {area:1099}: procure dentro do círculo no mapa",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, por volta do nível 45",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, lá dentro",

	-- Step 33: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "Ao norte dos gnolls, os ogros ocupam um posto no alto de uma colina; puxe os Ogros-magos até você. O cobalto está nos montes de terra em volta do posto, e o pergaminho fica no chão lá dentro.",

	-- Step 34: Woodpaw north camp
	["Woodpaw north camp"] = "Acampamento Patábua do norte",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "Os gnolls Patábua acampam nas colinas logo a noroeste de Mojache; qualquer um pode deixar cair uma juba.\nCuidado: todo gnoll Patábua, menos o Macho Alfa, sai correndo atrás de ajuda com 15% de vida, o que pode trazer mais gnolls para a briga.",

	-- Step 35: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: daqui a uma hora",

	-- Step 36: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}: vá matando estes pelo caminho",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "Os dardejantes esvoaçam sobre o bosque logo a oeste de Mojache; quase todos deixam cair uma asa. Os Machos Alfa Patábua lideram os acampamentos a sudoeste dele: mate-os dentro de uma hora.\nCuidado: a maioria dos Machos Alfa fica em acampamentos pequenos de tenda com mais 2 a 4 gnolls que entram na briga, e outros gnolls patrulham entre os acampamentos.",

	-- Step 38: Grimtotem camp
	["Grimtotem camp"] = "Acampamento Temível Totem",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "Os taurens Temível Totem acampam ao lado do bosque dos Dardejantes; Saqueadores, Naturalistas e Xamãs carregam chifres.",

	-- Step 39: Woodpaw battle map
	["Woodpaw battle map"] = "Mapa de batalha Patábua",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "O mapa de batalha fica no acampamento Patábua ao sul de Mojache.",

	-- Step 40: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "para {zone:1454}, por volta do nível 45",

	-- Step 41: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "A colmeia Zukk'ash se entoca nas colinas a sudeste do acampamento; {quest:7731} espera na câmara mais funda.",

	-- Step 42: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}: vá matando estes pelo caminho",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Siga para o oeste, saindo da colmeia, até as ruínas dos ogros abaixo de {area:1105}. Xamãs, Bruxos e Espancadores as ocupam; os Lordes-magos na ponta sul carregam o orbe.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234} anda por {area:2522}: procure dentro do círculo no mapa",

	-- Step 43: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "Yetis de {area:1105}",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "A noroeste das ruínas, os yetis têm a toca em {area:1105}; todo yeti de lá pode deixar cair um couro grosso.",

	-- Step 44: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "Só com o transmissor de emergência: qualquer fera, gnoll ou ogro em {zone:1444} pode deixá-lo cair, cerca de uma morte em cem; use-o para iniciar a missão. O robô fica numa pequena caverna no lado norte de {area:1105}, logo a noroeste das ruínas. Escolte-o até o cais em {area:1108}; yetis e gorilas emboscam vocês no caminho. A recompensa dele espera em {area:35}, para uma visita posterior.\nCuidado: três emboscadas surgem durante a escolta, e o robô avisa antes de cada uma. A primeira é de 3 yetis, logo depois que o robô sai da caverna e sobe rumo à estrada. A segunda é de 3 gorilas, na trilha que corre ao longo do penhasco. A terceira é de cerca de 4 gnolls, um deles lançador de feitiços, onde a rota desvia rumo ao cais.",

	-- Step 45: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "os yetis Cortifúria, na próxima visita a {zone:1444}",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}: para {npc:7010}, em {zone:1454}",

	-- Step 46: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Mestre de voo de {area:1099}",

	-- Step 47: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172961} Valley of Spirits (no name in this language: may be words)
	["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "Voe para {zone:1454}. Os irmãos Droffers têm a loja deles no Drag.\n{object:172958}, depois {object:172960} e {object:172961}.",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "para {zone:1425}, por volta do nível 48",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Eastern Wastewander camps"] = "Acampamentos Errantes do leste",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Voe para {area:1637}. Os irmãos Droffers têm sua loja no Drag.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Voe para {area:484}, desça pelo elevador a leste do posto, atravesse as salinas e siga para o sul até {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Voe para {area:484} e siga para o oeste pelos cânions, passando por {area:2237}; a estrada sobe para a selva de {zone:1444} e segue até {area:1099}.",
	-- ["Fly to {area:75}"] = "Voe para {area:75}",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Vagaventos: {npc:265756}, em {area:16638}, na Ilha de Zefras.",
	-- ["Hearth to {area:1099}"] = "Regresse para {area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Continue para o oeste até a costa. Os Olhabismos e Estalagarras da Areia nas praias deixam cair o sinalizador de socorro do OOX-22/FE em cerca de uma morte a cada quarenta: se cair, use-o para iniciar a missão.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Só com o sinalizador de socorro: o robô fica numa pequena caverna no lado norte de {area:1105}. Escolte-o até o cais na {area:1108}; yetis e gorilas emboscam você no caminho. A recompensa espera em {area:35} para uma visita futura.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Volte para o noroeste de {area:1978} até {area:75} e voe para {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Volte para o oeste até {area:976}.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Siga para o oeste até o meio de {zone:1444}. Mate um {npc:5308}, use {item:10699} no corpo e mate o espírito que surgir.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:3690} em {area:222}, com os kodos de {npc:3685} (20 de ouro cada) ao lado. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:4773} em {area:159}, com os cavalos esqueléticos de {npc:4731} (20 de ouro cada) ao lado dela. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:7953} em {area:367}, no litoral de {zone:1411}, com os raptores de Zjolnir (20 de ouro cada) ao lado. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. {npc:4752} ensina Orcs em {object:172958}, junto ao canil de {npc:3362}; não se conhece instrutor de montaria celonato, então os Celonatos também tentam {npc:4752}. As outras montarias da sua raça custam 20 de ouro cada: Colecionáveis, Montarias · Nível 40 tem um guia para cada.",
	-- ["Rogue Vale screechers"] = "Guinchadores Errantes do Vale",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Cavalos esqueléticos: {npc:4731}, ao lado de {npc:4773} em {area:159}.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Ao sul pela costa, os piratas dos Mares do Sul ocupam a enseada. {npc:7883} e a carga roubada ficam no cais, no fundo dela. Qualquer pirata pode deixar cair um chapéu, os Sequestradores com mais frequência.",
	-- ["Southern Gordunni ruins"] = "Ruínas Gordunni do sul",
	-- ["Southern Wastewander camps"] = "Acampamentos Errantes do sul",
	-- ["Sprite darters and Woodpaw alphas"] = "Dardejantes e Machos Alfa Patábua",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Os gnolls Patábua acampam nas colinas logo a noroeste de Mojache; qualquer um deles pode deixar cair uma juba.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Os Bandidos e Ladrões Errantes acampam nas dunas a leste de {area:976}. Todo Errante pode carregar uma bolsa de água: guarde dez, cinco para cada recompensa de Rastamala.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Os Magos das Sombras, Ladinos e Assassinos Errantes acampam a sudeste de {area:976}.",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Os Dardejantes voejam sobre o bosque logo a oeste de Mojache; quase todos deixam cair uma asa. Os Machos Alfa Patábua lideram os acampamentos a sudoeste dele: mate-os dentro de uma hora.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "O zepelim para {object:3202} sai da torre logo a nordeste do portão principal de {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "O zepelim para {zone:1454} sai da torre ao lado de {object:3202}; ele pousa logo fora do portão principal de {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, a mestre de voo, fica logo a leste da torre do zepelim. Voe para {area:75}: o próximo guia começa lá.",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Seu instrutor fica em {area:1638}: {npc:3033} (Druidas) em {area:1639}, {npc:246344} (Paladinos). Voe para lá de {zone:1454} e depois siga para {area:484}.",
	-- ["Zeppelin to {object:3202}"] = "Zepelim para {object:3202}",
	-- ["Zeppelin tower"] = "Torre do zepelim",
	-- ["the {object:150075} in the square"] = "{object:150075} na praça",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} é a cidade goblin murada logo depois da fronteira de {area:440}.",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, instrutora de montaria",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: os guinchadores vivem em {zone:1444}",
}
