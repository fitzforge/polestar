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
	-- {quest:980} The New Springs
	["{quest:980}, from Krakle in Un'Goro"] = "",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas · {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide. {npc:9298}'s next errand, Strange Sources, is at the mouth of {area:2256} among level 59-60 elites: it waits for the last guide's {zone:1452} loop."] = "",

	-- Step 4: Winterspring
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {npc:9298} Donova Snowden
	["Ride east along the road past {area:2251} to {area:2255} first: its yeti and chimaera errands bring you about a quarter of a level, which the Frostfire furbolg camps want; {npc:9298}'s camps come on the ride back west."] = "",

	-- Step 5: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255} é a cidade goblin no lado leste do vale, depois das colinas das Ferujas.",
	["Gregor's quests lead to other zones: keep them."] = "As missões de Gregor levam a outras zonas: guarde-as.",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, lá dentro",

	-- Step 6: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yetis Cardo de Gelo",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur. Careful: the Ice Thistle Yetis are 55-56: take the 55s one at a time, and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "",

	-- Step 7: Chillwind chimaeras
	["Chillwind chimaeras"] = "Quimeras Ventogelante",
	-- {area:2255} Everlook · {area:2251} Lake Kel'Theril · {area:2245} Mazthoril
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Careful: Chillwind Chimaeras are 55-57: take only the 55s, and the Fledgling Chillwinds (53-55) by {area:2251}, which carry the horns too. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "",

	-- Step 8: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	-- was: ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi: mantenha a missão; os Chifres Impolutos de Yeti ficam para a parada em {area:2255} do Guia de {zone:1423}, por volta do nível 57"
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 56"] = "",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "As Matriarcas e os Patriarcas que carregam os chifres de Umi são de nível 56-58: deixe-os para essa parada posterior.",

	-- Step 9: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Ferujas Furiosas",
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {area:2246} Frostfire Hot Springs
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	-- was: ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Ferujas Furiosas vagam pelas colinas ao norte de {area:2251}, junto à estrada entre {area:2246} e {area:2255}. Cuidado: as maiores são de nível 56: puxe uma de cada vez."
	["Ride back west: Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2255} and {area:2246}. Careful: the biggest are level 56: pull them one at a time."] = "",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: vá matando estes pelo caminho",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	-- was: ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Desbravadores, Vigias do Covil e Totêmicos dividem os acampamentos furbolg em volta das fontes termais; Ferujas Maltrapilhas vagam pelas encostas entre eles. Mate os Totêmicos primeiro. Guarde todo {item:14047} que saquear para Meilosh.\nCuidado: os Vigias do Covil chegam ao nível 56: puxe um de cada vez e fique longe dos totens dos acampamentos."
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers are 55-56: pull the 55s, one at a time, and keep clear of the camps' totems."] = "",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771}: cerca de um furbolg Invernoso em dez carrega um; continue matando-os até cair",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, saque raro dos furbolgs Invernosos",

	-- Step 11: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} é entregue no {object:176091} em {zone:1448}, numa viagem posterior.",

	-- Step 12: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Voe para {area:431}",
	-- {zone:1448} Felwood · {area:2255} Everlook · {area:431} Splintertree Post · {area:1237} Valormok
	["{zone:1448}'s southern hand-ins are next: ride back east to {area:2255}'s flight master, fly to {area:431} (by way of {area:1237}) and ride north into {zone:1448}, so the forest is ridden once, south to north."] = "",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Mestre de voo de {area:2255}",

	-- Step 13: Overlord Ror
	-- {zone:1448} Felwood · {area:1761} Deadwood Village
	["Ride north-west along the road into {zone:1448}. Ror stands at the far south end of {area:1761}, just inside the border."] = "",

	-- Step 14: Emerald Sanctuary
	["North to the druids' camp."] = "",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, no lado oeste do Santuário",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {area:392} Ratchet
	["Keep {quest:5158}: {npc:5901} is by {area:392}, on the next guide."] = "",

	-- Step 15: The Jadefire moonwell
	["The Jadefire moonwell"] = "O poço lunar Flamejade",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride north-west past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "",

	-- Step 16: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["North up the road to {area:1997}."] = "",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring · {zone:1423} Eastern Plaguelands
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{npc:10306}'s Moontouched Owlbeasts are 57-58, in {zone:1452}: keep it for the {zone:1423} guide's {zone:1452} stop."] = "",

	-- Step 17: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "O gatinho da {npc:9996}",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten back to the Jadefire moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, no poço lunar Flamejade",

	-- Step 19: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Voe para {area:1099}",
	-- {area:1997} Bloodvenom Post
	["{area:1997} flight master"] = "",

	-- Step 21: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "O {item:11242} cresce dentro de uma construção em ruínas ao norte do acampamento de {npc:7775}, a leste de {area:1114} das harpias: entre pela parte quebrada da parede.",

	-- Step 22: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "Volte para o sul até {npc:7775}. Guarde o elixir e não o beba ainda: ele mata você, e é assim que você encontra Gaeriyan perto de {area:976} mais tarde.",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}, a recompensa de {npc:7775}",

	-- Step 24: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Voe para {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Mestre de voo da {area:2408}",

	-- Step 25: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881} e {npc:14728} ficam em {area:1641}. Cada doação de Rumstag leva sessenta unidades de Lã, Seda ou Magitrama da sua bolsa: entregue o que tiver, ignore o resto.",

	-- Step 26: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} em {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} espera em {zone:1450}: guarde-a para depois.",

	-- Step 27: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087} compra o {item:11040} cultivado a partir do seu {quest:3761}. {quest:3782} pede dez, e o {item:11020} dá uma tentativa a cada dez minutos: pegue só se você já tiver o grão.",

	-- Step 29: Magatha Grimtotem
	-- {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise
	["{npc:4046} stands on {area:1639}."] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["Delivery to {npc:4046}, from Jediga in {zone:1447}"] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["{npc:4046}'s payment goes back to Jediga in {zone:1447}, which the route doesn't pass again: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Qualquer furbolg Invernoso pode carregar as contas; os acampamentos logo ao sul de {npc:11556} são os mais próximos.",
	-- ["Back at {area:1099}."] = "De volta a {area:1099}.",
	-- ["Back to {area:2255}"] = "De volta a {area:2255}",
	-- ["Below ground"] = "No subterrâneo",
	-- ["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "As duas doações de {item:14047} são entregues mais adiante na rota: guarde sessenta {item:14047} para cada uma, se quiser fazê-las.",
	-- ["Chillwind chimaeras"] = "Quimeras Ventogelante",
	-- ["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- ["From Krakle in Un'Goro"] = "De Gualter, na Cratera Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Acampamento Invernoso das fontes termais",
	-- ["Frostfire Winterfall camps"] = "Acampamentos Invernosos das fontes termais",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "As missões de Gregor e Harlo levam a outras zonas: guarde-as.",
	-- ["Grind to 55"] = "Mate monstros até o nível 55",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Ele fica em {area:1641}. Cada doação pede tecido das suas bolsas; entregue quando tiver, mais adiante na rota.",
	-- ["In the {object:172958}."] = "Em {object:172958}.",
	-- ["In the {object:172961}."] = "Em {object:172961}.",
	-- ["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Em {object:172961}. Cada doação leva sessenta unidades de Lã, Seda ou Magitrama da sua bolsa: entregue o que tiver, ignore o resto.",
	-- ["Level 55.04"] = "Nível 55.04",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Matriarcas e Patriarcas batem forte: puxe um de cada vez.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Desbravadores, Vigias do Covil e Totêmicos dividem os acampamentos furbolg em volta das fontes termais; Ferujas Maltrapilhas vagam pelas encostas entre eles. Mate os Totêmicos primeiro. Guarde todo {item:14047} que saquear para Meilosh.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Desbravadores, Vigias do Covil e Totêmicos dividem os acampamentos furbolg em volta das fontes termais; Ferujas Maltrapilhas vagam pelas encostas entre eles. Mate os Totêmicos primeiro. Guarde todo {item:14047} que saquear para Meilosh.\nCuidado: os Vigias do Covil chegam ao nível 56: puxe um de cada vez e fique longe dos totens dos acampamentos.",
	-- ["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "Ferujas Furiosas vagam pelas colinas ao norte de {area:2251}, junto à estrada entre {area:2246} e {area:2255}.",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Ferujas Furiosas vagam pelas colinas ao norte de {area:2251}, junto à estrada entre {area:2246} e {area:2255}. Cuidado: as maiores são de nível 56: puxe uma de cada vez.",
	-- ["Ride back west to {area:2246}."] = "Volte para oeste até {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Vá para leste e depois desça para o sul por {area:2249}. Os Gigantes Friomalho de lá são elite de nível 59: fique no meio e não pare. A estranha fonte está na entrada de {area:2256}, no extremo sul.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Siga a estrada para oeste passando por {area:2251}; Ferujas Furiosas vagam pelas colinas ao norte dele.",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "As quimeras vagam pelos campos de neve ao sul e a oeste de {area:2255}. Fique longe da caverna de {area:2245}: seus dracônicos azuis são elite.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "A aldeia furbolg ocupa o vale a nordeste de {area:2255}. Mate os Xamãs primeiro; eles curam. {npc:10738}, na caverna ao fundo, é elite: não entre.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "As colinas dos yetis começam logo a sudeste de {area:2255}. Todo yeti deixa cair pelo: cace os Yetis Cardo de Gelo (55-56) e deixe as Matriarcas e os Patriarcas (56-58), cujos chifres ficam para uma visita posterior.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "As colinas dos yetis começam logo a sudeste de {area:2255}. Todo yeti deixa cair pelo; só Matriarcas e Patriarcas deixam cair chifres, então deixe-os para depois da entrega.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Complete aqui até o nível 55.04 antes das entregas em {area:2255}: elas levam você ao nível 56. Os Yetis Cardo de Gelo (55-56) são os de nível mais baixo aqui; as Matriarcas e os Patriarcas (56-58) batem mais forte. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1583} (Inferior).",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "A terceira pegadinha de Umi tem como alvo goblins em {area:976} e na Cratera Un'Goro: guarde-a para depois.",
	-- ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi: mantenha a missão; os Chifres Impolutos de Yeti ficam para a parada em {area:2255} do Guia de {zone:1423}, por volta do nível 57",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "mate {npc:7440} em {area:2244}, {zone:1452}",
	-- ["grind on {npc:7458}"] = "mate {npc:7458} até subir",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, saque raro dos furbolgs Invernosos",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, ao lado dele",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} fica na saída para {zone:1452} do túnel de {area:1769}, ao norte das fontes termais.",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} anda por {area:2255}: procure dentro do círculo no mapa",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "{npc:7775}, um anão, acampa em {area:1137}, a noroeste de {area:1099}. Ele só prepara o {item:11243} a partir de um {item:11242} que você trouxer.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, um anão, acampa em {area:1137}, a noroeste de {area:1099}; ele tem o elixir.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} compra {item:11040} cultivado com o seu {quest:3761}.",
	-- ["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} vem de {npc:7775} em {zone:1444}, mais adiante neste guia.",
	-- ["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",
}
