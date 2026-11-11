-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "Cavalgue para sudeste até {area:355}, o templo em degraus dos Ramatorpe no sul de {zone:1425}, e suba até o topo. Qiaga e {npc:8636} (elite, 50) ficam lá em cima: encoste no topo e desça na hora.\nCuidado: trolls elite guardam a plataforma do topo, entre eles {npc:7996} e {npc:8636}, junto com vários Adivinhos Ramatorpe. Os adivinhos lançam feitiços e estão ligados ao resto do grupo.",

	-- Step 2: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "Cavalgue para o norte até {area:351}, no meio de {zone:1425}. Lodos Verdes e Gosmas Jade rastejam em toda a volta.\nCuidado: panteras andam furtivas pela área.",

	-- Step 3: Aerie Peak
	["Inside"] = "Lá dentro",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "{npc:5636}, lá dentro",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "para {quest:2990} em {area:1438}, depois",

	-- Step 4: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Voe para {area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Mestre de voo de {area:348}",

	-- Step 5: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 6: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Metrô para {zone:1453}",

	-- Step 8: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Voe para {area:69}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",

	-- Step 9: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Mestre de voo de {area:2418}",

	-- Step 10: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Voe para {area:144}",

	-- Step 11: Thelsamar
	-- {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth here: the {zone:1427} guide starts from {area:144}."] = "Defina sua Pedra de Regresso aqui: o guia de {zone:1427} começa em {area:144}.",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Mestre de voo de {area:144}",

	-- Step 15: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} fica no andar de cima, acima de {npc:7916}: suba por dentro, a seta não diferencia os andares.",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "A próxima tarefa de {npc:7907} vai para {zone:1446}: pule.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: guarde-a; as penas vêm no fim do guia de {zone:1428}",
	["the book on her table"] = "o livro na mesa dela",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Templo da Lua",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Atravesse o portal para {zone:1457}. O Templo da Lua fica no sul da cidade.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, ao lado dela",

	-- Step 21: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, no alto da árvore",

	-- Step 23: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "o solo vem de {zone:1449}, depois",

	-- Step 24: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal para {zone:1438}",

	-- Step 25: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Voe para {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Mestre de voo de {area:702}",

	-- Step 26: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Barco para {area:17203}",

	-- Step 27: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Voar para {area:42}",

	-- Step 30: The bloodmages
	["The bloodmages"] = "Os Magos Sangrentos",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "O acampamento dos magos sangrentos é a primeira parada ao lado da estrada que entra em {zone:1419}, a noroeste de {area:1438}.",

	-- Step 31: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Siga primeiro pela estrada para o leste até a fortaleza: o {item:6091} expira uma hora depois de {area:42}, e as feras dos Magos Sangrentos levam mais tempo que isso.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, no alto da fortaleza",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "A próxima tarefa de {npc:8022}, {item:9471}, é uma missão de {area:978}: pule.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}, no andar de cima",

	-- Step 32: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}: vá matando estes pelo caminho",
	-- {npc:5982} Black Slayer · {spell:5416} Venom Sting · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time.\nAshmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "Cavalgue para oeste: as Rasgarrindos Famintas andam pelas colinas secas logo ao sul do acampamento dos magos sangrentos; os Aguilhantes Escorpóde (nível 50) correm pelo meio do norte. Abutres {npc:5982} rondam por cima de tudo. Puxe um de cada vez.\nJavalis Jubacinza e Basiliscos Itarrubra dividem as encostas a sudoeste da fortaleza. Passe longe dos Javiltuscos mais ao sul: são nível 52.\nCuidado: os Aguilhantes Escorpóde usam {spell:5416}; {npc:8301} ainda derruba você.",

	-- Step 33: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "A segunda etapa dos Magos Sangrentos paga pelas mesmas partes com um item de bônus e sem experiência: pule.",

	-- Step 34: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "Mestre de voo de {area:1438}",

	-- Step 35: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, último andar",

	-- Step 36: The Bloodsail captains
	["The Bloodsail captains"] = "Os capitães da Vela Sangrenta",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "Os três navios da Vela Sangrenta estão ancorados ao largo da costa, logo ao sul de {area:35}: {npc:2550} (45) e {npc:2548} (46) nos conveses mais próximos, {npc:2546} (48) na nau capitânia, cada um com uma tripulação de 42-45 piratas. Nade até lá, limpe cada convés a partir da borda e puxe um de cada vez.",

	-- Step 38: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {quest:8552} pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 42: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:1494} (elite nível 52) pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Javalis Jubacinza e Basiliscos Itarrubra dividem as encostas a sudoeste da fortaleza. Fique longe dos Javiltuscos mais ao sul: são nível 52.",
	-- ["Back to {area:144}"] = "De volta a {area:144}",
	-- ["Back to {area:38}"] = "De volta a {area:38}",
	-- ["Boars and basilisks"] = "Javalis e basiliscos",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Voe de {area:144} para {area:150}, pegue o barco para {area:442} e voe para {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Voe de {area:348} para {area:42}.",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Use a Pedra de Regresso para {area:144}. O guia de {zone:1427} começa em {area:1446}: daqui, cavalgue para o sul até {zone:1418}, para o oeste passando pela cidade da Horda, {area:340}, e suba a trilha até a garganta.",
	-- ["Hearth to {area:348}."] = "Use a Pedra de Regresso para {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "Pedra de Regresso em recarga? Cavalgue de volta para o noroeste.",
	-- ["Into {area:3}"] = "Rumo a {area:3}",
	-- ["Portal to {area:141}"] = "Portal para {area:141}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Cavalgue de volta para o leste até {area:1438} e voe para {area:144}.",
	-- ["Ride back north to Ironband's camp."] = "Cavalgue de volta para o norte até o acampamento de Bandaferro.",
	-- ["Ride back west along the loch to {area:144}."] = "Volte para oeste pelo lago até {area:144}.",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "Cavalgue para o leste pela margem sul do lago até o acampamento de Bandaferro.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Cavalgue para o leste por {zone:1430} até {zone:1435} e desça a estrada para o sul até {zone:1419}. O acampamento dos Magos Sangrentos é a primeira parada à beira da estrada.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Cavalgue para o norte até {area:351}, no meio das {zone:1425}. Lodos Verdes e Gosmas Jade rastejam por toda a volta.",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Cavalgue para o sul pelo desfiladeiro até a borda norte de {area:3}: os Troggs da Abóbada de Pedra escavam ali, fora de {area:1517}. As urnas entalhadas e os aglomerados de cogumelos magenta ficam nas cavernas e túneis deles, fora da masmorra.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Cavalgue para o sudeste até {area:355}, o templo escalonado Ramatorpe no sul das {zone:1425}, e suba até o topo. Qiaga e {npc:8636} (elite, 50) ficam lá em cima: toque o topo e desça logo.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Cavalgue para o oeste: Rasgarrindos Famintas vagam pelas colinas secas logo ao sul do acampamento dos Magos Sangrentos; Aguilhantes Escorpódes (nível 50) correm pelo meio do norte. Abutres {npc:5982} circulam sobre tudo. Puxe um de cada vez.",
	-- ["Scorpoks and snickerfangs"] = "Escorpódes e rasgarrindos",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Os instrutores de druida ficam no Enclave; {zone:1455} não tem nenhum",
	-- ["The {area:1517} dig"] = "A escavação de {area:1517}",
	-- ["{item:8047}; below ground"] = "{item:8047}; no subterrâneo",
	-- ["{npc:1470}, below ground"] = "{npc:1470}, no subterrâneo",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{object:2743}; below ground"] = "{object:2743}; no subterrâneo",
}
