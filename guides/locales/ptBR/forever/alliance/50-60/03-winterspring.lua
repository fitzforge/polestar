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

	-- Step 4: Everlook
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: guarde para {area:2262}; lá dentro",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: guarde as duas para as Terras Pestilentas; lá dentro",
	-- {npc:11754} Meggi Peppinrocker · {area:2255} Everlook
	["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} anda por {area:2255}: procure dentro do círculo no mapa",
	-- {item:12383} Moontouched Feather
	["{item:12383}, 110 yd north"] = "{item:12383}, 110 metros ao norte",

	-- Step 6: Ice Thistle Hills: kill these as you meet them
	-- {area:2247} Ice Thistle Hills
	["{area:2247}: kill these as you meet them"] = "{area:2247}: vá matando estes pelo caminho",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Yetis Cardo de Gelo vivem nas colinas ao sul da {area:2244}, Quimeras Ventogelantes no vale rumo a {area:2255}.",

	-- Step 7: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "As ruínas ficam em volta do lago congelado ao sul de {area:2253}. Pegue os quatro fragmentos de relíquia caídos nas ruínas e as Penas Lunamarca no chão onde os plumacuns vagam.",

	-- Step 8: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Siga a estrada para oeste até o acampamento de {npc:9298}, ao lado das fontes termais.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Guarde-o: Gregan em {zone:1444} prepara o elixir mais tarde",

	-- Step 9: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: vá matando estes pelo caminho",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {item:14047} Runecloth · {zone:1452} Winterspring · {area:1584} Blackrock Depths
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}. Or, with a group, run the {area:1584} dungeon instead."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Qualquer furbolg daqui pode soltar {item:12771} (cerca de um em dez: vem dentro das mortes que essas missões exigem) e {quest:8471} (cerca de um em trinta: vem dentro das mortes para completar o nível): clique com o botão direito no que cair. Guarde {item:14047} que os furbolgs soltam para Meilosh.\nO resto do trabalho de {zone:1452} é de nível 55-58: fique neste acampamento até o nível 54, para que suas primeiras mortes também contem para {npc:9298} e {npc:11556}. Ou, com um grupo, faça a masmorra {area:1584}.",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "mate {npc:7442} até subir",

	-- Step 10: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "O caldeirão Lenha Morta em {zone:1448}: guarde-o",

	-- Step 11: Level 55.05
	["Level 55.05"] = "Nível 55.05",
	-- {area:2255} Everlook · {area:2246} Frostfire Hot Springs · {area:1769} Timbermaw Hold · {quest:8471} Winterfall Ritual Totem · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Complete aqui até o nível 55.05 antes das entregas em {area:2255}: elas levam você ao nível 56. Mate os furbolgs Invernosos acampados perto de {area:2246} (Desbravadores, Totêmicos, Vigias do Covil): matá-los aumenta sua reputação com o Domínio dos Presamatos, que as missões daqui e a travessia de {area:1769} exigem, um deles solta {quest:8471} e eles enchem suas bolsas com as trinta Runatramas que Meilosh pede. Ou, com um grupo, faça a masmorra {area:1584} ou a masmorra {area:1583} (Inferior).",

	-- Step 12: Winterfall Ritual Totem
	["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "Qualquer furbolg Invernoso pode soltar o totem, cerca de uma morte em trinta: se a rodada para completar o nível não trouxe um, continue matando-os aqui até soltar, depois clique nele com o botão direito.",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Para Kernda em {area:1769}: guarde-o",

	-- Step 14: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "A aldeia dos furbolgs Invernosos fica a leste de {area:2255}: Xamãs (56-57), Vigias do Covil (55-56) e Ursinos (57-58), todos acima de você. Mate os Xamãs primeiro, eles curam, e atraia pelas bordas. {npc:10738}, na caverna dos fundos, é elite: fique longe.",

	-- Step 15: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "De volta às colinas: só as Matriarcas e os Patriarcas Cardo de Gelo carregam os chifres.",

	-- Step 16: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Em {npc:10978}, perto da estalagem",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} e {npc:10977} vêm depois",

	-- Step 18: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Mestre de voo de {area:2255}",

	-- Step 19: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 22: Chillwind Camp
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["From {area:271}, ride north up the road through Alterac to {area:3197}."] = "De {area:271}, siga para o norte pela estrada por Alterac até {area:3197}.",
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: os cupins vêm depois, em {area:2627}",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838}: as torres de vigia ficam em Andorhal, guarde",
	-- {npc:11053} High Priestess MacDonnell · {area:200} Dalson's Tears
	["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053}: o caldeirão fica em {area:200}, guarde-o",

	-- Step 23: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739} fica junto à fazenda em {area:202}, na estrada para leste até {zone:1423}.",
	["Inside"] = "Lá dentro",

	-- Step 24: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Rumo a {zone:1423}",

	-- Step 26: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Siga a estrada do sul para leste até as {zone:1423}; as ruínas de {area:2262} ficam ao sul dela. O fantasma de {npc:10926} brinca junto à casa em ruínas no extremo sul.",

	-- Step 27: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "A boneca de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "As três partes da boneca estão nas casas em ruínas de {area:2262}; pegar uma pode chamar fantasmas. Junte-as na boneca.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "{item:12886}; lá dentro",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "{item:12888}; lá dentro",

	-- Step 28: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, nas {zone:1422}: guarde-a",

	-- Step 29: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Siga a estrada para leste atravessando a zona até a capela.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: Zaeldarr é elite de nível 54",

	-- Step 30: Corin's Crossing
	-- {area:2264} Corin's Crossing · {npc:10411} Eye of Naxxramas
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "O Flagelo ao redor de {area:2264}, a oeste da capela, solta os dois tipos de Pedra do Flagelo; Espíritos da Vila das Flechas surgem delas: fale com cada um para libertá-lo.\nCuidado: {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasa assim que a luta começa. Existem apenas 3, e elas reaparecem a cada 15 min.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Liberte os Espíritos da Vila das Flechas: fale com eles",

	-- Step 31: The Undercroft
	-- {area:2261} The Undercroft
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr é elite: melhor ir em grupo. Ele espera no fundo de {area:2261}, a cripta no sudoeste da zona.",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "{item:15785}; no subterrâneo",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "O próximo guia começa aqui e voa para o {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "De volta às colinas: só as Matriarcas e os Patriarcas Cardo de Gelo levam os chifres. Continue matando yetis até o nível 54: as missões de plumacuns de Harlo ficam vermelhas antes disso.",
	-- ["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: o {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa. Só existem 3, e elas renascem a cada 15 min.",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Siga a estrada do sul para leste até as {area:139}; as ruínas de {area:2262} ficam ao sul dela. O fantasma de {npc:10926} brinca junto à casa em ruínas no extremo sul.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Siga as instruções de {npc:9298} até a entrada do {area:2256}, passando pelos gigantes Friomalho: passe por eles um de cada vez.",
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
	-- ["The Winterfall camp"] = "O acampamento dos Invernosos",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Qualquer furbolg daqui pode deixar cair um {item:12771} (cerca de um em dez) e, raramente, um {quest:8471}: clique com o botão direito no que cair. Guarde o {quest:6031} que os furbolgs deixam cair para Meilosh.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Os furbolgs Invernosos do oeste deixam cair as contas.",
	-- ["The {area:2247}"] = "As {area:2247}",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Atravesse {area:1769} até {zone:1448} e voe para os Reinos do Leste ({area:442}, o navio para {area:150}). Voe até {area:271} e cavalgue para o norte pela estrada através de Alterac até o {area:3197}.",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "farme {npc:7460} nas {area:2247}, {zone:1452}",
	-- ["{area:2269}: kill these as you meet them"] = "{area:2269}: vá matando estes pelo caminho",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, item raro",
	-- ["{npc:10301}'s camp"] = "Acampamento de {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Suprimentos de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: guarde os dois para as Terras Pestilentas",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} é elite de nível 54",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} guarda a entrada de {area:1769}, a noroeste de {npc:9298}.",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: guarde-o para {area:2262}",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} é elite: é recomendado formar grupo. Ele espera no fundo da {area:2261}, a cripta no sudoeste da zona.",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, nas {area:28}: guarde-a",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, para Meilosh mais tarde",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, item raro",
}
