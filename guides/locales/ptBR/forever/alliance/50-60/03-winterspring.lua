-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
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

	-- Step 4: Everlook's inn
	-- {area:2255} Everlook
	["{area:2255}'s inn"] = "Estalagem de {area:2255}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands · {zone:1452} Winterspring · {area:2255} Everlook
	["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Sua Pedra de Regresso não está vinculada a {zone:1455} (o guia de {zone:1425} vincula você lá, e este guia sai de {zone:1452} por ela): vincule-a a {area:2255}, para as viagens de volta à cidade.",

	-- Step 5: Everlook
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}: guarde para as Terras Pestilentas; lá dentro",
	-- {npc:11754} Meggi Peppinrocker · {area:2255} Everlook
	["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} anda por {area:2255}: procure dentro do círculo no mapa",

	-- Step 7: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Siga a estrada para oeste até o acampamento de {npc:9298}, ao lado das fontes termais.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Guarde-o: Gregan em {zone:1444} prepara o elixir mais tarde",

	-- Step 8: Level 55 at Frostfire Hot Springs
	-- {area:2246} Frostfire Hot Springs
	["Level 55 at {area:2246}"] = "Nível 55 em {area:2246}",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:14047} Runecloth · {area:1584} Blackrock Depths · {area:2577} Dire Maul
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Primeiro, complete aqui até o nível 55 com os Desbravadores (53-54) na borda do acampamento: os Vigias do Covil lá dentro são 55-56. Matá-los aumenta sua reputação com os Presamatos e enche suas bolsas de {item:14047} para Meilosh. Ou, em grupo, faça {area:1584} ou {area:2577}.",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "mate {npc:7442} até subir",

	-- Step 9: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: vá matando estes pelo caminho",
	-- {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {item:14047} Runecloth
	["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "Qualquer furbolg daqui pode soltar {item:12771} (cerca de um em dez: vem dentro das mortes que essas missões exigem) e {quest:8471} (cerca de um em trinta): clique com o botão direito no que cair. Guarde {item:14047} que os furbolgs soltam para Meilosh.",

	-- Step 10: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "O caldeirão Lenha Morta em {zone:1448}: guarde-o",

	-- Step 11: Level 55.05
	["Level 55.05"] = "Nível 55.05",
	-- {area:2255} Everlook · {area:2246} Frostfire Hot Springs · {area:1769} Timbermaw Hold · {quest:8471} Winterfall Ritual Totem · {area:1584} Blackrock Depths · {area:2577} Dire Maul
	["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "Complete aqui até o nível 55.05 antes das entregas em {area:2255}: elas levam você ao nível 56. Mate os furbolgs Invernosos acampados perto de {area:2246} (Desbravadores, Totêmicos, Vigias do Covil): matá-los aumenta sua reputação com o Domínio dos Presamatos, que as missões daqui e a travessia de {area:1769} exigem, um deles solta {quest:8471} e eles enchem suas bolsas com as trinta Runatramas que Meilosh pede. Ou, em grupo, faça {area:1584} ou {area:2577}.",

	-- Step 12: Winterfall Ritual Totem
	["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "Qualquer furbolg Invernoso pode soltar o totem, cerca de uma morte em trinta: se a rodada para completar o nível não trouxe um, continue matando-os aqui até soltar, depois clique nele com o botão direito.",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Para Kernda em {area:1769}: guarde-o",

	-- Step 13: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "As ruínas ficam em volta do lago congelado ao sul de {area:2253}. Pegue os quatro fragmentos de relíquia caídos nas ruínas e as Penas Lunamarca no chão onde os plumacuns vagam.",

	-- Step 14: Ice Thistle Hills: kill these as you meet them
	-- {area:2247} Ice Thistle Hills
	["{area:2247}: kill these as you meet them"] = "{area:2247}: vá matando estes pelo caminho",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind · Chillwind Ravagers = {npc:7449} Chillwind Ravager
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "Os yetis Cardo de Gelo vivem nas colinas ao sul de {area:2244}, as Quimeras Ventogelante no vale em direção a {area:2255}.\nCuidado: os Yetis Cardo de Gelo são 55-56 e as Quimeras 55-57: pegue os Ladinos Cardo de Gelo (53-55) e os Filhotes de Ventogelante (53-55) na borda das colinas e deixe os Assoladores de Ventogelante (57-59) em paz.",

	-- Step 16: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "De volta às colinas: só as Matriarcas Cardo de Gelo (56-57) e os Patriarcas (57-58) têm os chifres.\nCuidado: pegue as Matriarcas na borda das colinas, uma de cada vez, e deixe os Patriarcas: os chifres caem dos dois.",

	-- Step 17: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Em {npc:10978}, perto da estalagem",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} e {npc:10977} vêm depois",
	-- {npc:10978} Legacki · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10978} with {item:12928}"] = "Assuste {npc:10978} com {item:12928}",

	-- Step 18: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Para {zone:1455}",
	-- {zone:1455} Ironforge · {area:3197} Chillwind Camp · {area:2255} Everlook
	["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "Sua Pedra de Regresso ainda está vinculada a {zone:1455}: de lá, o grifo para o {area:3197} é cerca de dez minutos mais rápido que o voo de {area:2255} para a Ilha Theramore e o navio.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Estalagem de {zone:1455}",

	-- Step 20: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle · {object:32356} Hall of Explorers (no name in this language: may be words) · {zone:1448} Felwood
	["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616} trabalha no {object:32356}: entregue a ele os jarros de gosma de {zone:1448} agora, de passagem.",
	-- {zone:1451} Silithus
	["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "Os jarros são enchidos na visita a Un'Goro do guia de {zone:1451}: guarde-o",

	-- Step 21: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Voe para o {area:3197}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 22: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Mestre de voo de {area:2255}",

	-- Step 23: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",

	-- Step 24: Fly to Chillwind Camp
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 25: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Purocoração, Dumah, Punho Valente e MacDonnell ficam no meio do acampamento, perto do mestre de voo.",
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: os cupins vêm depois, em {area:2627}",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838}: as torres de vigia ficam em Andorhal, guarde",

	-- Step 26: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Caldeirão de {area:199}",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "Saia do acampamento para noroeste até {area:199}, a oeste de Andorhal: {npc:11075} (53) guarda o caldeirão entre os Carniçais Grasnantes (54).",

	-- Step 27: Chillwind Camp
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["Back to {npc:11053} at {area:3197}."] = "Volte para {npc:11053} no {area:3197}.",
	-- {npc:11053} High Priestess MacDonnell · {area:200} Dalson's Tears
	["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053}: o caldeirão fica em {area:200}, guarde-o",

	-- Step 28: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "Na estrada para leste saindo do {area:3197}, a casa de fazenda de {npc:10927} fica em {area:197}: {quest:5142} dela vai para o mesmo fantasma em {area:2262}.",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: guarde-o para {area:2262}",

	-- Step 29: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739} fica junto à fazenda em {area:202}, na estrada para leste até {zone:1423}.",
	["Inside"] = "Lá dentro",

	-- Step 30: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Rumo a {zone:1423}",

	-- Step 32: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Siga a estrada do sul para leste até as {zone:1423}; as ruínas de {area:2262} ficam ao sul dela. O fantasma de {npc:10926} brinca junto à casa em ruínas no extremo sul.",

	-- Step 33: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "A boneca de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "As três partes da boneca estão nas casas em ruínas de {area:2262}; pegar uma pode chamar fantasmas. Junte-as na boneca.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "{item:12886}; lá dentro",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "{item:12888}; lá dentro",

	-- Step 34: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, nas {zone:1422}: guarde-a",

	-- Step 35: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Siga a estrada para leste atravessando a zona até a capela.",
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "A próxima tarefa de {npc:11063}, em {area:2264}, é entre Flagelo de nível 57-60: pule-a.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: Zaeldarr é elite de nível 54",

	-- Step 36: The Undercroft
	-- {area:2261} The Undercroft
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr é elite: melhor ir em grupo. Ele espera no fundo de {area:2261}, a cripta no sudoeste da zona.",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "{item:15785}; no subterrâneo",

	-- Step 37: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "O próximo guia começa aqui e voa para o {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "De volta às colinas: só as Matriarcas e os Patriarcas Cardo de Gelo carregam os chifres.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "De volta às colinas: só as Matriarcas e os Patriarcas Cardo de Gelo levam os chifres. Continue matando yetis até o nível 54: as missões de plumacuns de Harlo ficam vermelhas antes disso.",
	-- ["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: o {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa. Só existem 3, e elas renascem a cada 15 min.",
	-- ["Fly to {area:271}"] = "Voar para {area:271}",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Siga a estrada do sul para leste até as {area:139}; as ruínas de {area:2262} ficam ao sul dela. O fantasma de {npc:10926} brinca junto à casa em ruínas no extremo sul.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Siga as instruções de {npc:9298} até a entrada do {area:2256}, passando pelos gigantes Friomalho: passe por eles um de cada vez.",
	-- ["Free Darrowshire Spirits: talk to them"] = "Liberte os Espíritos da Vila das Flechas: fale com eles",
	-- ["From {area:271}, ride north up the road through Alterac to {area:3197}."] = "De {area:271}, siga para o norte pela estrada por Alterac até {area:3197}.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Yetis Cardo de Gelo vivem nas colinas ao sul da {area:2244}, Quimeras Ventogelantes no vale rumo a {area:2255}.",
	-- ["Optional: {area:1417}"] = "Opcional: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Pegue os suprimentos em volta da carroça e tome de volta o amuleto de {npc:10301} dos corujursos próximos.",
	-- ["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cavalgue para o norte até {area:2627}. {npc:12384} mora na cabana em ruínas, e o livro de recibos dele está na estalagem em ruínas ali perto.",
	-- ["Ride north-west back to the village."] = "Cavalgue para noroeste de volta à aldeia.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cavalgue para sudeste descendo o vale até o caixote danificado de {npc:10301} na neve em {area:2245}, com a carroça destruída dele logo a leste.",
	-- ["Ride west along the road to the night elf village."] = "Cavalgue para oeste pela estrada até a aldeia dos elfos noturnos.",
	-- ["Ride west along the road to {npc:10301}."] = "Cavalgue para oeste pela estrada até {npc:10301}.",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Abaixo do nível 54 depois dos yetis? Fazer o {area:1417} (50-54) em grupo em vez de farmar leva você lá mais rápido. Volte a {area:2255} depois.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "O Flagelo em volta de {area:2264}, a oeste da capela, deixa cair os dois tipos de Pedra do Flagelo; Espíritos da Vila das Flechas surgem deles: fale com cada um para libertá-lo.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "O Flagelo ao redor de {area:2264}, a oeste da capela, solta os dois tipos de Pedra do Flagelo; Espíritos da Vila das Flechas surgem delas: fale com cada um para libertá-lo.\nCuidado: {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasa assim que a luta começa. Existem apenas 3, e elas reaparecem a cada 15 min.",
	-- ["The Winterfall camp"] = "O acampamento dos Invernosos",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "A aldeia dos furbolgs Invernosos fica a leste de {area:2255}: Xamãs (56-57), Vigias do Covil (55-56) e Ursinos (57-58), todos acima de você. Mate os Xamãs primeiro, eles curam, e atraia pelas bordas. {npc:10738}, na caverna dos fundos, é elite: fique longe.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Qualquer furbolg daqui pode deixar cair um {item:12771} (cerca de um em dez) e, raramente, um {quest:8471}: clique com o botão direito no que cair. Guarde o {quest:6031} que os furbolgs deixam cair para Meilosh.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Qualquer furbolg daqui pode soltar {item:12771} (cerca de um em dez: vem dentro das mortes que essas missões exigem) e {quest:8471} (cerca de um em trinta: vem dentro das mortes para completar o nível): clique com o botão direito no que cair. Guarde {item:14047} que os furbolgs soltam para Meilosh.\nO resto do trabalho de {zone:1452} é de nível 55-58: fique neste acampamento até o nível 54, para que suas primeiras mortes também contem para {npc:9298} e {npc:11556}.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Os furbolgs Invernosos do oeste deixam cair as contas.",
	-- ["The {area:2247}"] = "As {area:2247}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for."] = "Complete aqui até o nível 55.05 antes das entregas em {area:2255}: elas levam você ao nível 56. Mate os furbolgs Invernosos acampados perto de {area:2246} (Desbravadores, Totêmicos, Vigias do Covil): matá-los aumenta sua reputação com o Domínio dos Presamatos, que as missões daqui e a travessia de {area:1769} exigem, um deles solta {quest:8471} e eles enchem suas bolsas com as trinta Runatramas que Meilosh pede.",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Atravesse {area:1769} até {zone:1448} e voe para os Reinos do Leste ({area:442}, o navio para {area:150}). Voe até {area:271} e cavalgue para o norte pela estrada através de Alterac até o {area:3197}.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Sua Pedra de Regresso não está vinculada a {zone:1455} (o guia de {zone:1425} vincula você lá no nível 47, e este guia sai de {zone:1452} por ela): vincule-a a {area:2255}, para as viagens de volta à cidade.",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "farme {npc:7460} nas {area:2247}, {zone:1452}",
	-- ["{area:2269}: kill these as you meet them"] = "{area:2269}: vá matando estes pelo caminho",
	-- ["{item:12383}, 110 yd north"] = "{item:12383}, 110 metros ao norte",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, item raro",
	-- ["{npc:10301}'s camp"] = "Acampamento de {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Suprimentos de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: guarde os dois para as Terras Pestilentas",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: guarde as duas para as Terras Pestilentas; lá dentro",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} é elite de nível 54",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} guarda a entrada de {area:1769}, a noroeste de {npc:9298}.",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: guarde-o para {area:2262}",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: guarde para {area:2262}; lá dentro",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} é elite: é recomendado formar grupo. Ele espera no fundo da {area:2261}, a cripta no sudoeste da zona.",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, nas {area:28}: guarde-a",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, para Meilosh mais tarde",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, item raro",
}
