-- Portuguese (Brazil) (ptBR): the guide forever/exploration/eastern-kingdoms-1-30 (forever/exploration/eastern-kingdoms-1-30.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 1-30"] = "Exploração: {zone:1415} 1-30",

	-- Step 1: Elwynn Forest (1/2)
	-- {zone:1429} Elwynn Forest · {zone:1426} Dun Morogh
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Alliance starts in {zone:1429}; dwarves and gnomes can begin at the {zone:1426} step. 12 areas to discover here, levels 5-10."] = "Descobrir uma área dá experiência proporcional ao nível dela, então isto acompanha a evolução do personagem. A Aliança começa em {zone:1429}; anões e gnomos podem começar na etapa de {zone:1426}. 12 áreas para descobrir aqui, níveis 5-10.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Explorar o mapa-múndi inteiro com um personagem é um Desafio de Legado Forever (1 Ponto de Legado para a conta toda).",
	-- {area:9} Northshire Valley · {zone:1429} Elwynn Forest · {area:87} Goldshire
	["{area:9} opens onto {zone:1429}; {area:87} is south down the road."] = "{area:9} se abre para {zone:1429}; {area:87} fica ao sul, descendo a estrada.",

	-- Step 2: Elwynn Forest (2/2)
	["any one of these names counts"] = "qualquer um destes nomes vale",

	-- Step 3: Westfall (1/2)
	["14 areas to discover here, levels 9-18."] = "14 áreas para descobrir aqui, níveis 9-18.",
	-- {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:120} Westbrook Garrison
	["{zone:1436} borders {zone:1429} to the west: follow the road out past the {area:120}."] = "{zone:1436} faz divisa com {zone:1429} a oeste: siga a estrada passando pela {area:120}.",
	-- {area:108} Sentinel Hill
	["Flight path here: {area:108} (Thor)."] = "Rota de voo aqui: {area:108} (Thor).",

	-- Step 5: Duskwood (1/2)
	["13 areas to discover here, levels 10-30."] = "13 áreas para descobrir aqui, níveis 10-30.",
	-- {zone:1431} Duskwood · {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:42} Darkshire
	["{zone:1431} is east of {zone:1436} and south of {zone:1429}. Its road runs east to {area:42}."] = "{zone:1431} fica a leste de {zone:1436} e ao sul de {zone:1429}. A estrada segue para leste até {area:42}.",
	-- {area:42} Darkshire · {npc:2409} Felicia Maline
	["Flight path here: {area:42} ({npc:2409})."] = "Rota de voo aqui: {area:42} ({npc:2409}).",

	-- Step 7: Redridge Mountains (1/2)
	["11 areas to discover here, levels 15-24."] = "11 áreas para descobrir aqui, níveis 15-24.",
	-- {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood
	["Redridge starts at {area:1002}, where the roads from {zone:1429} and {zone:1431} meet."] = "As Montanhas Cristarrubra começam em {area:1002}, onde as estradas de {zone:1429} e {zone:1431} se encontram.",
	-- {area:69} Lakeshire · {npc:931} Ariena Stormfeather
	["Flight path here: {area:69} ({npc:931})."] = "Rota de voo aqui: {area:69} ({npc:931}).",

	-- Step 9: Dun Morogh (1/3)
	["18 areas to discover here, levels 4-12."] = "18 áreas para descobrir aqui, níveis 4-12.",
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind City · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "Pegue o {area:2257} no {object:28027} de {zone:1453} até {zone:1455} (ou voe até {zone:1455}) e saia da cidade pelos portões.",

	-- Step 12: Loch Modan (1/2)
	["11 areas to discover here, levels 10-18."] = "11 áreas para descobrir aqui, níveis 10-18.",
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:925} Algaz Station
	["Leave {zone:1426} east through the gate tunnel; it opens into {zone:1432} at {area:925}."] = "Saia de {zone:1426} para leste pelo túnel do portão; ele dá em {zone:1432}, em {area:925}.",
	-- {area:144} Thelsamar · {npc:1572} Thorgrum Borrelson
	["Flight path here: {area:144} ({npc:1572})."] = "Rota de voo aqui: {area:144} ({npc:1572}).",

	-- Step 14: Wetlands (1/2)
	["15 areas to discover here, levels 20-30."] = "15 áreas para descobrir aqui, níveis 20-30.",
	-- {area:925} Algaz Station · {area:836} Dun Algaz · {zone:1437} Wetlands
	["From {area:925}, the road north through the {area:836} pass leads into the {zone:1437}."] = "De {area:925}, a estrada para o norte pela passagem de {area:836} leva a {zone:1437}.",
	-- {area:150} Menethil Harbor · {npc:1571} Shellei Brondir
	["Flight path here: {area:150} ({npc:1571})."] = "Rota de voo aqui: {area:150} ({npc:1571}).",
	-- {area:1038} Dragonmaw Gates · {area:1037} Grim Batol
	["the discovery triggers at the {area:1038}: do not go into {area:1037} itself"] = "a descoberta acontece em {area:1038}: não entre em {area:1037} em si",

	-- Step 16: Hillsbrad Foothills (1/2)
	["12 areas to discover here, levels 20-31."] = "12 áreas para descobrir aqui, níveis 20-31.",
	-- {area:881} Thandol Span · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {zone:1424} Hillsbrad Foothills
	["Cross the {area:881} in northern {zone:1437} into the {zone:1417} (level 30+ creatures off the road), follow the road west past {area:320} and on into {zone:1424}."] = "Atravesse a {area:881} no norte de {zone:1437} até {zone:1417} (criaturas de nível 30+ fora da estrada), siga a estrada para oeste passando por {area:320} e continue até {zone:1424}.",
	-- {area:271} Southshore · {npc:2432} Darla Harris
	["Flight path here: {area:271} ({npc:2432})."] = "Rota de voo aqui: {area:271} ({npc:2432}).",
	-- {area:272} Tarren Mill
	["Horde guards: touch the edge of {area:272} and move on"] = "Guardas da Horda: toque a borda de {area:272} e siga em frente",

	-- Step 18: Silverpine Forest (1/2)
	["15 areas to discover here, levels 10-20."] = "15 áreas para descobrir aqui, níveis 10-20.",
	-- {area:287} Hillsbrad · {area:285} Southpoint Tower · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["Follow the road west from {area:287} past {area:285} into {zone:1421}, Horde country with Horde guards at the {area:228}."] = "Siga a estrada para oeste a partir de {area:287}, passando pela {area:285}, até {zone:1421}, território da Horda com guardas da Horda em {area:228}.",
	-- {area:228} Sepulcher
	["Horde guards: touch the edge of {area:228} and move on"] = "Guardas da Horda: toque a borda de {area:228} e siga em frente",

	-- Step 20: Tirisfal Glades (1/3)
	["17 areas to discover here, levels 5-10."] = "17 áreas para descobrir aqui, níveis 5-10.",
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {area:154} Deathknell · {zone:1458} Undercity
	["Silverpine's road north leads into {zone:1420}. {area:159}, {area:154} and the {zone:1458} ruins are Horde ground."] = "A estrada de Pinhaprata para o norte leva a {zone:1420}. {area:159}, {area:154} e as ruínas de {zone:1458} são território da Horda.",
	-- {area:153} Ruins of Lordaeron
	["Horde guards: touch the edge of {area:153} and move on"] = "Guardas da Horda: toque a borda de {area:153} e siga em frente",

	-- Step 21: Tirisfal Glades (2/3)
	-- {area:159} Brill
	["Horde guards: touch the edge of {area:159} and move on"] = "Guardas da Horda: toque a borda de {area:159} e siga em frente",

	-- Step 22: Tirisfal Glades (3/3)
	-- {area:154} Deathknell
	["Horde guards: touch the edge of {area:154} and move on"] = "Guardas da Horda: toque a borda de {area:154} e siga em frente",

	-- Step 23: Tirisfal Glades (1/3)
	-- {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Horde starts in {zone:1420}; orcs, trolls and tauren arrive by zeppelin from {zone:1454}. 17 areas to discover here, levels 5-10."] = "Descobrir uma área dá experiência proporcional ao nível dela, então isto acompanha a evolução do personagem. A Horda começa em {zone:1420}; orcs, trolls e taurens chegam de zepelim vindos de {zone:1454}. 17 áreas para descobrir aqui, níveis 5-10.",
	-- {area:154} Deathknell · {zone:1420} Tirisfal Glades · {area:159} Brill · {zone:1458} Undercity
	["{area:154} opens onto {zone:1420}; {area:159} is east along the road. Orcs, trolls and tauren arrive at the zeppelin tower by the {zone:1458}."] = "{area:154} se abre para {zone:1420}; {area:159} fica a leste pela estrada. Orcs, trolls e taurens chegam à torre do zepelim perto de {zone:1458}.",

	-- Step 26: Silverpine Forest (1/2)
	-- {zone:1421} Silverpine Forest · {zone:1420} Tirisfal Glades · {area:159} Brill
	["{zone:1421} is south of {zone:1420}: follow the road south from {area:159}."] = "{zone:1421} fica ao sul de {zone:1420}: siga a estrada para o sul a partir de {area:159}.",
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["Flight path here: {area:228} ({npc:2226})."] = "Rota de voo aqui: {area:228} ({npc:2226}).",

	-- Step 28: Hillsbrad Foothills (1/2)
	-- {zone:1424} Hillsbrad Foothills · {area:285} Southpoint Tower · {area:272} Tarren Mill · {area:271} Southshore
	["At the south end of Silverpine the road turns east into {zone:1424} by {area:285}. {area:272} in the north-east is the Horde town; {area:271} is Alliance."] = "No extremo sul de Pinhaprata, a estrada vira para leste e entra em {zone:1424} perto da {area:285}. {area:272}, no nordeste, é a cidade da Horda; {area:271} é da Aliança.",
	-- {area:272} Tarren Mill
	["Flight path here: {area:272} (Zarise)."] = "Rota de voo aqui: {area:272} (Clarissa).",

	-- Step 29: Hillsbrad Foothills (2/2)
	-- {area:271} Southshore
	["Alliance guards: touch the edge of {area:271} and move on"] = "Guardas da Aliança: toque a borda de {area:271} e siga em frente",

	-- Step 30: Wetlands (1/2)
	-- {area:287} Hillsbrad · {zone:1417} Arathi Highlands · {area:881} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["Walk east from {area:287} into the {zone:1417} (level 30+ creatures off the road), south to the {area:881} bridge, and across it into the {zone:1437}. {area:150} is an Alliance town."] = "Caminhe para leste a partir de {area:287} até {zone:1417} (criaturas de nível 30+ fora da estrada), para o sul até a {area:881} e atravesse-a até {zone:1437}. {area:150} é uma cidade da Aliança.",

	-- Step 31: Wetlands (2/2)
	-- {area:150} Menethil Harbor
	["Alliance guards: touch the edge of {area:150} and move on"] = "Guardas da Aliança: toque a borda de {area:150} e siga em frente",

	-- Step 32: Loch Modan (1/2)
	-- {area:836} Dun Algaz · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:925} Algaz Station
	["The {area:836} pass in south-eastern {zone:1437} leads down into {zone:1432} by {area:925}."] = "A passagem de {area:836} no sudeste de {zone:1437} desce até {zone:1432}, perto de {area:925}.",

	-- Step 33: Loch Modan (2/2)
	-- {area:144} Thelsamar
	["Alliance guards: touch the edge of {area:144} and move on"] = "Guardas da Aliança: toque a borda de {area:144} e siga em frente",

	-- Step 34: Dun Morogh (1/3)
	-- {area:925} Algaz Station · {zone:1426} Dun Morogh · {area:131} Kharanos · {zone:1455} Ironforge
	["From {area:925} take the tunnel west into {zone:1426}. {area:131} and {zone:1455}'s gates are Alliance ground."] = "De {area:925}, pegue o túnel para oeste até {zone:1426}. {area:131} e os portões de {zone:1455} são território da Aliança.",

	-- Step 35: Dun Morogh (2/3)
	-- {area:809} Gates of Ironforge
	["Alliance guards: touch the edge of {area:809} and move on; any one of these names counts"] = "Guardas da Aliança: toque a borda de {area:809} e siga em frente; qualquer um destes nomes vale",
	-- {area:131} Kharanos
	["Alliance guards: touch the edge of {area:131} and move on"] = "Guardas da Aliança: toque a borda de {area:131} e siga em frente",

	-- Step 36: Dun Morogh (3/3)
	-- {area:132} Coldridge Valley
	["Alliance guards: touch the edge of {area:132} and move on; any one of these names counts"] = "Guardas da Aliança: toque a borda de {area:132} e siga em frente; qualquer um destes nomes vale",

	-- Step 37: Duskwood (1/2)
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:117} Grom'gol Base Camp · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	["Hearth or fly back to the {zone:1458} (or go to {zone:1454}), take the zeppelin to {area:117} in {zone:1434} and walk north along the road into {zone:1431}. Northern Stranglethorn is level 30+ off the road."] = "Use a Pedra de Regresso ou voe de volta para {zone:1458} (ou vá para {zone:1454}), pegue o zepelim até {area:117} em {zone:1434} e caminhe para o norte pela estrada até {zone:1431}. O norte da Selva do Espinhaço é nível 30+ fora da estrada.",
	-- {area:42} Darkshire
	["Alliance guards: touch the edge of {area:42} and move on"] = "Guardas da Aliança: toque a borda de {area:42} e siga em frente",

	-- Step 39: Westfall (1/2)
	-- {zone:1436} Westfall · {zone:1431} Duskwood · {area:108} Sentinel Hill
	["{zone:1436} borders {zone:1431} to the west. {area:108} is an Alliance town."] = "{zone:1436} faz divisa com {zone:1431} a oeste. {area:108} é uma cidade da Aliança.",

	-- Step 40: Westfall (2/2)
	-- {area:108} Sentinel Hill
	["Alliance guards: touch the edge of {area:108} and move on"] = "Guardas da Aliança: toque a borda de {area:108} e siga em frente",

	-- Step 41: Elwynn Forest (1/2)
	["12 areas to discover here, levels 5-10."] = "12 áreas para descobrir aqui, níveis 5-10.",
	-- {zone:1429} Elwynn Forest · {zone:1436} Westfall · {zone:1431} Duskwood · {area:87} Goldshire · {area:9} Northshire Valley · {zone:1453} Stormwind City
	["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429} fica ao norte de {zone:1436} e {zone:1431}. {area:87}, {area:9} e os portões de {zone:1453} são território da Aliança, com guardas.",
	-- {zone:1453} Stormwind City
	["Alliance guards: touch the edge of {zone:1453} and move on; any one of these names counts"] = "Guardas da Aliança: toque a borda de {zone:1453} e siga em frente; qualquer um destes nomes vale",
	-- {area:9} Northshire Valley
	["Alliance guards: touch the edge of {area:9} and move on"] = "Guardas da Aliança: toque a borda de {area:9} e siga em frente",
	-- {area:87} Goldshire
	["Alliance guards: touch the edge of {area:87} and move on"] = "Guardas da Aliança: toque a borda de {area:87} e siga em frente",

	-- Step 43: Redridge Mountains (1/2)
	-- {zone:1429} Elwynn Forest · {area:1002} Three Corners · {area:69} Lakeshire
	["Go east through {zone:1429} to {area:1002}, where Redridge starts. {area:69} is an Alliance town."] = "Vá para leste por {zone:1429} até {area:1002}, onde começam as Montanhas Cristarrubra. {area:69} é uma cidade da Aliança.",
	-- {area:69} Lakeshire
	["Alliance guards: touch the edge of {area:69} and move on"] = "Guardas da Aliança: toque a borda de {area:69} e siga em frente",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:228}"] = "{area:228}",
}
