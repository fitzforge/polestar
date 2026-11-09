-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Rumo a {zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} fica bem na saída de {zone:1452} do túnel de {area:1769}, por onde você sai.",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "Siga para o sul saindo do túnel: {npc:9298} acampa entre as poças fumegantes de {area:2246}, no oeste do vale.",
	["Linken's letter"] = "A carta de Linken",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} vem de {npc:7775} em {zone:1444}, mais adiante neste guia.",

	-- Step 4: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: vá matando estes pelo caminho",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Desbravadores, Vigias do Covil e Totêmicos dividem os acampamentos furbolg em volta das fontes termais; Ferujas Maltrapilhas vagam pelas encostas entre eles. Mate os Totêmicos primeiro. Guarde todo {item:14047} que saquear para Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771}: cerca de um furbolg Invernoso em dez carrega um; continue matando-os até cair",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, saque raro dos furbolgs Invernosos",

	-- Step 5: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} é entregue no {object:176091} em {zone:1448}, numa viagem posterior.",

	-- Step 6: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Ferujas Furiosas",
	-- {area:2251} Lake Kel'Theril · {area:2246} Frostfire Hot Springs · {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "Ferujas Furiosas vagam pelas colinas ao norte de {area:2251}, junto à estrada entre {area:2246} e {area:2255}.",

	-- Step 8: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255} é a cidade goblin no lado leste do vale, depois das colinas das Ferujas.",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "As missões de Gregor e Harlo levam a outras zonas: guarde-as.",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, lá dentro",

	-- Step 9: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yetis Cardo de Gelo",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "As colinas dos yetis começam logo a sudeste de {area:2255}. Todo yeti deixa cair pelo; só Matriarcas e Patriarcas deixam cair chifres, então deixe-os para depois da entrega.",

	-- Step 11: Level 55.04
	["Level 55.04"] = "Nível 55.04",
	-- {area:2255} Everlook · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Complete aqui até o nível 55.04 antes das entregas em {area:2255}: elas levam você ao nível 56. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1583} (Inferior).",
	-- {npc:7460} Ice Thistle Patriarch
	["grind on {npc:7460}"] = "mate {npc:7460} até subir",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Matriarcas e Patriarcas batem forte: puxe um de cada vez.",
	["Below ground"] = "No subterrâneo",

	-- Step 13: Chillwind chimaeras
	["Chillwind chimaeras"] = "Quimeras Ventogelante",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "As quimeras vagam pelos campos de neve ao sul e a oeste de {area:2255}. Fique longe da caverna de {area:2245}: seus dracônicos azuis são elite.",

	-- Step 14: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "A terceira pegadinha de Umi tem como alvo goblins em {area:976} e na Cratera Un'Goro: guarde-a para depois.",

	-- Step 15: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "A aldeia furbolg ocupa o vale a nordeste de {area:2255}. Mate os Xamãs primeiro; eles curam. {npc:10738}, na caverna ao fundo, é elite: não entre.",

	-- Step 16: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Voe para {area:1099}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Mestre de voo de {area:2255}",

	-- Step 18: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, um anão, acampa em {area:1137}, a noroeste de {area:1099}; ele tem o elixir.",

	-- Step 20: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Voe para {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Mestre de voo da {area:2408}",

	-- Step 21: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881} e {npc:14728} ficam em {area:1641}. Cada doação de Rumstag leva sessenta unidades de Lã, Seda ou Magitrama da sua bolsa: entregue o que tiver, ignore o resto.",

	-- Step 22: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} em {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} espera em {zone:1450}: guarde-a para depois.",

	-- Step 23: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087} compra o {item:11040} cultivado a partir do seu {quest:3761}. {quest:3782} pede dez, e o {item:11020} dá uma tentativa a cada dez minutos: pegue só se você já tiver o grão.",

	-- Step 24: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 25: Vehena
	-- {object:172961} Valley of Spirits (no name in this language: may be words)
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Em {object:172961}. Cada doação leva sessenta unidades de Lã, Seda ou Magitrama da sua bolsa: entregue o que tiver, ignore o resto.",

	-- Step 26: Rashona Straglash
	-- {object:172958} Valley of Honor (no name in this language: may be words)
	["In the {object:172958}."] = "Em {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "As duas doações de {item:14047} são entregues mais adiante na rota: guarde sessenta {item:14047} para cada uma, se quiser fazê-las.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Qualquer furbolg Invernoso pode carregar as contas; os acampamentos logo ao sul de {npc:11556} são os mais próximos.",
	-- ["Back at {area:1099}."] = "De volta a {area:1099}.",
	-- ["Back to {area:2255}"] = "De volta a {area:2255}",
	-- ["Chillwind chimaeras"] = "Quimeras Ventogelante",
	-- ["From Krakle in Un'Goro"] = "De Gualter, na Cratera Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Acampamento Invernoso das fontes termais",
	-- ["Frostfire Winterfall camps"] = "Acampamentos Invernosos das fontes termais",
	-- ["Grind to 55"] = "Mate monstros até o nível 55",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Ele fica em {area:1641}. Cada doação pede tecido das suas bolsas; entregue quando tiver, mais adiante na rota.",
	-- ["In the {object:172961}."] = "Em {object:172961}.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Desbravadores, Vigias do Covil e Totêmicos dividem os acampamentos furbolg em volta das fontes termais; Ferujas Maltrapilhas vagam pelas encostas entre eles. Mate os Totêmicos primeiro. Guarde todo {item:14047} que saquear para Meilosh.",
	-- ["Ride back west to {area:2246}."] = "Volte para oeste até {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Vá para leste e depois desça para o sul por {area:2249}. Os Gigantes Friomalho de lá são elite de nível 59: fique no meio e não pare. A estranha fonte está na entrada de {area:2256}, no extremo sul.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Siga a estrada para oeste passando por {area:2251}; Ferujas Furiosas vagam pelas colinas ao norte dele.",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "mate {npc:7440} em {area:2244}, {zone:1452}",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, saque raro dos furbolgs Invernosos",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, ao lado dele",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} fica na saída para {zone:1452} do túnel de {area:1769}, ao norte das fontes termais.",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} anda por {area:2255}: procure dentro do círculo no mapa",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} compra {item:11040} cultivado com o seu {quest:3761}.",
}
