-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Cavalgue para o sudeste até {area:355}, o templo escalonado Ramatorpe no sul das {zone:1425}, e suba até o topo. Qiaga e {npc:8636} (elite, 50) ficam lá em cima: toque o topo e desça logo.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Cavalgue para o norte até {area:351}, no meio das {zone:1425}. Lodos Verdes e Gosmas Jade rastejam por toda a volta.",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "Use a Pedra de Regresso para {area:348}.",
	["Hearthstone on cooldown? Ride back north-west."] = "Pedra de Regresso em recarga? Cavalgue de volta para o noroeste.",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "para {quest:2990} em {area:1438}, depois",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "Voe de {area:348} para {area:42}.",

	-- Step 6: The bloodmages
	["The bloodmages"] = "Os Magos Sangrentos",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Cavalgue para o leste por {zone:1430} até {zone:1435} e desça a estrada para o sul até {zone:1419}. O acampamento dos Magos Sangrentos é a primeira parada à beira da estrada.",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Siga primeiro pela estrada para o leste até a fortaleza: o {item:6091} expira uma hora depois de {area:42}, e as feras dos Magos Sangrentos levam mais tempo que isso.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, no alto da fortaleza",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "A próxima tarefa de {npc:8022}, {item:9471}, é uma missão de {area:978}: pule.",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "Javalis e basiliscos",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Javalis Jubacinza e Basiliscos Itarrubra dividem as encostas a sudoeste da fortaleza. Fique longe dos Javiltuscos mais ao sul: são nível 52.",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "Escorpódes e rasgarrindos",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Cavalgue para o oeste: Rasgarrindos Famintas vagam pelas colinas secas logo ao sul do acampamento dos Magos Sangrentos; Aguilhantes Escorpódes (nível 50) correm pelo meio do norte. Abutres {npc:5982} circulam sobre tudo. Puxe um de cada vez.",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "A segunda etapa dos Magos Sangrentos paga pelas mesmas partes com um item de bônus e sem experiência: pule.",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "Cavalgue de volta para o leste até {area:1438} e voe para {area:144}.",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "Cavalgue para o leste pela margem sul do lago até o acampamento de Bandaferro.",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "A escavação de {area:1517}",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Cavalgue para o sul pelo desfiladeiro até a borda norte de {zone:1418}: os Troggs da Abóbada de Pedra escavam ali, fora de {area:1517}. As urnas entalhadas e os aglomerados de cogumelos magenta ficam nas cavernas e túneis deles, fora da masmorra.",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Cavalgue de volta para o norte até o acampamento de Bandaferro.",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Voe de {area:144} para {area:150}, pegue o barco para {area:442} e voe para {area:702}.",
	["the book on her table"] = "o livro na mesa dela",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "A próxima tarefa de {npc:7907} vai para {zone:1446}: pule.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: guarde-a; as penas vêm no fim do guia de {zone:1428}",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Templo da Lua",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Atravesse o portal para {zone:1457}. O Templo da Lua fica no sul da cidade.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, ao lado dela",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, no alto da árvore",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "o solo vem de {zone:1449}, depois",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Os instrutores de druida ficam no Enclave; {zone:1455} não tem nenhum",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "De volta a {area:144}",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Use a Pedra de Regresso para {area:144}. O guia de {zone:1427} começa em {area:1446}: daqui, cavalgue para o sul até {zone:1418}, para o oeste passando pela cidade da Horda, {area:340}, e suba a trilha até a garganta.",
}
