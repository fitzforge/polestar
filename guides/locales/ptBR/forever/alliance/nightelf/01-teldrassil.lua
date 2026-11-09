-- Portuguese (Brazil) (ptBR): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "Você começa ao pé de {area:256}, a grande árvore de {area:188}.",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077}, junto à trilha",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992}, ao sul da árvore",

	-- Step 2: Shadowglen: kill these as you meet them
	-- {area:188} Shadowglen
	["{area:188}: kill these as you meet them"] = "{area:188}: vá matando estes pelo caminho",
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "Sabres-da-noite Jovens e Javalis-espinho Jovens vagueiam ao redor de {area:256}. Os Capetas carregam {item:3297} no bosque a oeste da árvore, onde ficam os Totens de Masca-pinho.",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "De volta a {area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}: um sigilo para {npc:3596}",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}, na rampa da árvore",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp; upstairs"] = "{npc:3595}: entre pela entrada da frente da árvore e suba a rampa; no andar de cima",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}: lance {spell:1259799} e Fusão Sombria e depois entregue a {npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}, a leste da árvore",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "Ao norte, para {area:257}",
	-- {area:256} Aldrassil · {npc:1994} Githyiss the Vile · {npc:8584} Iverron
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside. {npc:8584} waits in the trees west of the cave mouth."] = "Sabres-da-noite Sarnentos e Javalis-espinho vagueiam ao norte de {area:256}, a caminho da caverna. {npc:1994} fica bem no fundo. {npc:8584} espera entre as árvores a oeste da entrada da caverna.",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders; below ground"] = "Aranhas Lenhateia; no subterrâneo",

	-- Step 5: Aldrassil
	-- {area:256} Aldrassil · {npc:3593} Alyissia · {npc:3594} Frahun Shadewhisper · {npc:3595} Shanda · {npc:3596} Ayanna Everstride · {npc:3597} Mardant Strongoak
	["The trainers stand upstairs inside {area:256}, along the ramp that winds up the tree: {npc:3593} and {npc:3594} on the first level, {npc:3595} above them, {npc:3596} and {npc:3597} at the top. The arrow cannot tell the levels apart."] = "Os instrutores ficam no andar de cima, dentro de {area:256}, ao longo da rampa que sobe em espiral pela árvore: {npc:3593} e {npc:3594} no primeiro nível, {npc:3595} acima deles, {npc:3596} e {npc:3597} no topo. A seta não diferencia os níveis.",
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer; inside"] = "{npc:3593}, o instrutor de guerreiro; lá dentro",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}, a instrutora de caçador",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}, o instrutor de ladino",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "{npc:3595}, a instrutora de sacerdote: entre pela entrada da frente da árvore e suba a rampa",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}, o instrutor de druida em {area:256}",

	-- Step 6: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917} e o antídoto",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406} ficam no fundo de {area:257}: pegue o caminho central e vire à esquerda na bifurcação, até a saliência alta. Os Capetas deixam cair Cogumelos Jacinto; os Lírios Lunapétala crescem junto aos lagos ao norte de {area:256}.",
	["Grells"] = "Capetas",

	-- Step 8: Shadowglen
	["Below ground"] = "No subterrâneo",
	-- {quest:97236} Fang of Githyiss
	["{quest:97236}; below ground"] = "{quest:97236}; no subterrâneo",

	-- Step 9: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}, no topo da árvore",

	-- Step 10: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "O poço lunar e {npc:8584}",
	-- {area:256} Aldrassil
	["The moonwell sits north of {area:256}."] = "O poço lunar fica ao norte de {area:256}.",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "Use o {item:5185} no poço lunar",

	-- Step 11: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "De volta ao topo de {area:256}. {object:654846} está ao lado dele.",
	["Upstairs"] = "No andar de cima",
	-- {object:654846} Lost Journal
	["{object:654846}, upstairs"] = "{object:654846}, no andar de cima",

	-- Step 12: Iverron's Antidote
	-- {npc:8583} Dirania Silvershine · {area:256} Aldrassil · {npc:8584} Iverron
	["Take the antidote from {npc:8583} at the foot of {area:256} only now, on the way down: it lasts five minutes. {npc:8584} waits north-west, by the cave: go straight on to him."] = "Pegue o antídoto de {npc:8583}, ao pé de {area:256}, só agora, na descida: ele dura cinco minutos. {npc:8584} espera a noroeste, junto à caverna: vá direto até ele.",

	-- Step 13: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "Saia de {area:188} pela trilha a sudeste de {area:256}: {npc:6780} fica ao lado dela, onde ela desce em direção à estrada para {area:186}.",

	-- Step 14: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "Siga a estrada para o sudoeste, saindo de {area:188}. {npc:2150} fica junto a ela, logo a leste de {area:186}.",

	-- Step 15: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}, junto à fogueira",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "Use /sentar junto à fogueira de {npc:265811} até receber {spell:1229451}",
	-- {npc:6286} Zarrin
	["{npc:6286}, south of the inn: Camping 101 asks you to learn it"] = "{npc:6286}, ao sul da estalagem: Introdução ao acampamento pede que você aprenda",

	-- Step 17: Dolanaar
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}, ao sul da estalagem",
	-- {npc:3608} Aldia
	["{npc:3608}, upstairs"] = "{npc:3608}, no andar de cima",
	-- {npc:3567} Tallonkai Swiftroot
	["{npc:3567}, upstairs"] = "{npc:3567}, no andar de cima",
	-- {npc:3600} Laurna Morninglight
	["{npc:3600}, inside"] = "{npc:3600}, lá dentro",

	-- Step 18: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151} patrulha a estrada a oeste da aldeia: se ela não estiver na seta, siga a estrada até encontrá-la.",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}, na estrada a oeste da aldeia",

	-- Step 19: Teldrassil: kill these as you meet them
	-- {quest:940} Teldrassil
	["{quest:940}: kill these as you meet them"] = "{quest:940}: vá matando estes pelo caminho",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}."] = "Sabres-da-noite, Corujas Estrígidas e Tocaieiras Lenhateia andam em volta de {area:186} e pela estrada para leste; as tocaieiras também deixam cair as patas de aranha da receita. O poço lunar fica na borda oeste de {area:260}.",
	["Nightsabers"] = "Sabres-da-noite",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "Tocaieiras Lenhateia",

	-- Step 20: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, between {area:186} and {area:260}."] = "{npc:2150} fica junto à estrada, logo a leste de {area:186}, entre {area:186} e {area:260}.",

	-- Step 21: Starbreeze Village
	-- {npc:2107} Gaerolas Talvethren · {object:126158} Tallonkai's Dresser
	["{npc:2107} stands upstairs in a house in the village, east of the moonwell: go up inside, the arrow cannot tell the floors apart. {object:126158} is in the house on the hill at the east end of the village."] = "{npc:2107} fica no andar de cima de uma casa da vila, a leste do poço lunar: suba por dentro, a seta não diferencia os andares. {object:126158} fica na casa da colina, na ponta leste da vila.",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "Use o {item:5619} no poço lunar",
	-- {object:126158} Tallonkai's Dresser
	["{object:126158}; inside"] = "{object:126158}; lá dentro",

	-- Step 22: Lake Al'Ameth
	-- {npc:2150} Zenn Foulhoof · {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-west of Starbreeze, south of {npc:2150}. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "A sudoeste de Starbreeze, ao sul de {npc:2150}. {npc:2080} cuida das mudas dele na margem; Brotos de Açoitadeira e Muscoides andam em volta dele, e os {quest:919} crescem no meio.",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}: {quest:922}, em {zone:1457}, a recebe",

	-- Step 24: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "Entrada de {area:258}",

	-- Step 25: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038} espera dentro da caverna, no fundo ou em cima da saliência; mantenha-se à direita.",
	-- {npc:2038} Lord Melenas
	["{npc:2038}; below ground"] = "{npc:2038}; no subterrâneo",

	-- Step 26: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "A estrada para {zone:1457}",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "Emboscadores Masca-pinho se escondem ao longo da estrada a oeste de {area:258}.",

	-- Step 27: Sentinel Shayla Nightbreeze
	-- {area:261} Gnarlpine Hold
	["West along the road to the city gate: Shayla stands beside it. Every Gnarlpine furbolg drops fangs: the ambushers on this road, the barrow's and {area:261}'s all count."] = "A oeste pela estrada até o portão da cidade: Shayla fica ao lado dele. Todo furbolg Masca-pinho solta presas: os emboscadores desta estrada, os da toca e os de {area:261} contam todos.",

	-- Step 28: Darnassus
	-- {quest:922} Rellian Greenspyre · {area:1658} Cenarion Enclave · {npc:7316} Sister Aquinne · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade · {item:279378} Lunar Pendant
	["Into the city through the gate. {quest:922} is just south of the {area:1658} at the north end, {npc:7316} in the west, {npc:7313} and {npc:8396} in the Temple of the Moon at the south end. On the way back out, use Dalia's {item:279378} at the bank and at the city gate; the other two owls wait for your last visit."] = "Entre na cidade pelo portão. {quest:922} fica logo ao sul de {area:1658}, no extremo norte, {npc:7316} no oeste, {npc:7313} e {npc:8396} no Templo da Lua, no extremo sul. Na saída, use {item:279378}, de Dalia, no banco e no portão da cidade; as outras duas corujas esperam a sua última visita.",
	-- {npc:7313} Priestess A'moora
	["{npc:7313}, in the Temple of the Moon"] = "{npc:7313}, no Templo da Lua",
	-- {npc:8396} Sentinel Dalia Sunblade
	["{npc:8396}, beside her"] = "{npc:8396}, ao lado dela",
	-- {item:279378} Lunar Pendant
	["{item:279378}: the bank, on the way out"] = "{item:279378}: o banco, na saída",
	["the city gate"] = "o portão da cidade",

	-- Step 29: Ban'ethil Barrow Den's entrance
	-- {area:262} Ban'ethil Barrow Den
	["{area:262}'s entrance"] = "Entrada de {area:262}",

	-- Step 30: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms. Its furbolgs drop Shayla's fangs."] = "O túmulo fica ao sul da estrada. {npc:275744} está presa lá dentro, {npc:7317} dorme nas profundezas, e os quatro baús de relíquias ficam nas salas inferiores. Os furbolgs de lá soltam as presas de Shayla.",
	-- {item:5220} Gnarlpine Fang
	["{item:5220}: any Gnarlpine furbolg"] = "{item:5220}: qualquer furbolg Masca-pinho",
	-- {npc:7317} Oben Rageclaw
	["{npc:7317}, below ground"] = "{npc:7317}, no subterrâneo",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "Xamãs Masca-pinho",
	-- {npc:7318} Rageclaw · {area:736} Ban'ethil Hollow
	["{npc:7318}, in the den; walks around {area:736}: look inside the circle on the map"] = "{npc:7318}, no covil; anda por {area:736}: procure dentro do círculo no mapa",

	-- Step 31: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "Escolte {npc:275744} para fora do túmulo; {npc:2081}, em {area:186}, recebe o relatório.",
	["Walk Lynessa out and keep her alive"] = "Leve Lynessa para fora e mantenha-a viva",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}, fora do túmulo",

	-- Step 32: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "A sudoeste do túmulo. O poço lunar fica junto aos lagos.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "Use o {item:5621} no poço lunar",

	-- Step 33: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs."] = "Ao sul das águas. A {object:6751} cresce junto ao Acampamento; os furbolgs em volta dela soltam o resto das presas.",

	-- Step 35: Seek Redemption!
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {npc:7234} Ferocitas the Dream Eater
	-- plural, as words: Fel Cones = {object:1673} Fel Cone
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}: pick them up on the road east and hand them to {npc:2150} on the way to {npc:7234}."] = "Pinhas Vis estão embaixo das árvores em volta de {area:186} e de {npc:2150}: pegue na estrada para leste e entregue a {npc:2150} no caminho até {npc:7234}.",

	-- Step 36: Ferocitas the Dream Eater
	-- {npc:7234} Ferocitas the Dream Eater · {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel.\nCareful: {npc:7234} waits near the camp fire with mystics around him, so pulling him without adds is hard."] = "Místicos Masca-pinho e {npc:7234} acampam a nordeste de {area:260}. {npc:7234} deixa cair o {item:8049}: abra para pegar a joia.\nCuidado: {npc:7234} fica perto da fogueira com místicos em volta, então é difícil puxá-lo sozinho.",
	-- {item:8049} Gnarlpine Necklace · {npc:7234} Ferocitas the Dream Eater
	["{item:8049}, from {npc:7234}"] = "{item:8049}, de {npc:7234}",

	-- Step 37: Dolanaar
	-- {area:264} Oracle Glade · {area:186} Dolanaar · {npc:3567} Tallonkai Swiftroot
	["The road west to the {area:264} runs through {area:186}: hand {npc:3567} the jewel on the way."] = "A estrada para oeste até {area:264} passa por {area:186}: entregue a joia a {npc:3567} no caminho.",

	-- Step 38: Sentinel Shayla Nightbreeze
	-- {area:186} Dolanaar
	["West along the road from {area:186}: Shayla still stands beside it, before the turn north to the glade."] = "A oeste pela estrada, a partir de {area:186}: Shayla ainda fica ao lado dela, antes da curva para o norte, rumo à clareira.",

	-- Step 39: The Wellspring River
	-- {area:265} Wellspring River
	["The {area:265}"] = "{area:265}",
	-- {area:265} Wellspring River
	-- plural, as words: Mossy Tumors = {item:5170} Mossy Tumor
	["North from the road the path to the glade crosses the {area:265}: the timberlings along it drop the Mossy Tumors."] = "Ao norte da estrada, o caminho para a clareira atravessa {area:265}: os muscoides ao longo dele soltam os Tumores Musguentos.",
	-- {item:5170} Mossy Tumor
	["{item:5170}: timberlings"] = "{item:5170}: muscoides",

	-- Step 40: Oracle Glade
	-- {object:6752} Strange Fronded Plant (no name in this language: may be words)
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "O poço lunar fica no meio da clareira. {object:6752} cresce no extremo norte dela.",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}, junto ao poço lunar",
	-- {item:18152} Amethyst Phial
	["Use the {item:18152} at the moonwell"] = "Use o {item:18152} no poço lunar",

	-- Step 41: Bloodfeather harpies
	["Bloodfeather harpies"] = "Harpias Plumassangue",
	-- {quest:938} Mist
	["The Bloodfeather harpies nest on the slopes west and north of the glade. {quest:938}, an injured sabercat, lies by the glade's west wall among them: lead her back to Sentinel Arynia at the moonwell before her time runs out.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "As harpias Plumassangue fazem ninho nas encostas a oeste e ao norte da clareira. {quest:938}, uma gata-de-sabre ferida, está junto à parede oeste da clareira, no meio delas: leve-a de volta até a Sentinela Arynia Rasganimbus, no poço lunar, antes que o tempo dela acabe.\nCuidado: as harpias ficam amontoadas, então costuma vir harpia a mais. Há lançadoras de feitiço misturadas.",
	-- {quest:938} Mist
	["{quest:938}, by the west wall"] = "{quest:938}, junto à parede oeste",
	-- {quest:938} Mist
	["Lead {quest:938} to the moonwell"] = "Leve {quest:938} até o poço lunar",

	-- Step 42: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "De volta ao poço lunar.",

	-- Step 43: The named harpies
	["The named harpies"] = "As harpias nomeadas",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034} e {npc:272044} voam logo a oeste do poço lunar, {npc:272046} mais ao norte.",

	-- Step 44: Lady Sathrah
	-- {object:6752} Strange Fronded Plant (no name in this language: may be words) · {npc:272046} Witchmother Arysa · {area:266} Wellspring Lake · {npc:7319} Lady Sathrah
	["The {object:6752} grows at the glade's north end, on the way: then north of {npc:272046}, along the island's northern edge by {area:266}, {npc:7319}, a level 12 spider, lurks."] = "{object:6752} cresce no extremo norte da clareira, no caminho: depois, ao norte de {npc:272046}, ao longo da margem norte da ilha, junto a {area:266}, {npc:7319}, uma aranha de nível 12, espreita.",

	-- Step 45: Sentinel Arynia again
	["Sentinel Arynia again"] = "Sentinela Arynia de novo",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words)
	["{object:673378}, just west of the moonwell"] = "{object:673378}, logo a oeste do poço lunar",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words) · {zone:1457} Darnassus
	["the same {object:673378}: Fandral in {zone:1457} takes it"] = "o mesmo {object:673378}: Fandral, em {zone:1457}, o recebe",

	-- Step 46: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}.\nCareful: Gnarlpine of roughly level 9-12 crowd the camp and sit close together, so it is easy to pull several at once. Take them on singly before you engage Ursal."] = "Ande para o sul pelo lado oeste da ilha. Ursal ronda o extremo sul, abaixo de {area:478}.\nCuidado: Masca-pinhos de nível 9-12 lotam o acampamento e ficam bem juntos, então é fácil puxar vários de uma vez. Enfrente um de cada vez antes de encarar o Ursal.",

	-- Step 47: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "Para o nordeste a partir do covil de Ursal, de volta a {area:186}.",
	-- {npc:6094} Byancie
	["{npc:6094}, inside"] = "{npc:6094}, lá dentro",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "{item:3371} de {npc:3614}, ao lado de {npc:6094}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}: {npc:11401}, em {zone:1457}, a recebe",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "{item:159} de {npc:6736}, para {npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "Fandral Guenelmo, em {zone:1457}, a recebe",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}: {npc:4217}, em {zone:1457}, a recebe",
	-- {npc:3598} Kyra Windblade · {quest:1684} Elanaria · {zone:1457} Darnassus
	["{npc:3598}, the warrior trainer: {quest:1684} in {zone:1457} takes it"] = "{npc:3598}, a instrutora de guerreiro: quem recebe é {quest:1684}, em {zone:1457}",

	-- Step 48: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "A sudeste de Dolanaar, até {npc:2080}. Brotos de Açoitadeira vagueiam ao redor dele na margem.",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "{object:7510}, ao lado dele",

	-- Step 49: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "{area:186} de novo",
	-- {npc:6094} Byancie · {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr
	["{npc:6094} takes a {item:159} with the fronds and the vial: if you drank yours, buy another from {npc:6736} in this inn before you hand in."] = "{npc:6094} recebe uma {item:159} junto com as folhas e o frasco: se você bebeu a sua, compre outra com {npc:6736} nesta estalagem antes de entregar.",

	-- Step 50: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Cada missão de Dazalar lhe dá um {item:15908}: use-o na fera indicada e depois leve o bastão de volta para ele em {area:186}. Tocaieiras Lenhateia rastejam ao redor da aldeia; Espreitadores Sabre-da-noite e Guinchadoras Estrígidas vagueiam pelo bosque ao sul dela.",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}: dome-a com o {item:15908}",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}: dome-o com o {item:15908}",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}: dome-a com o {item:15908}",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "{npc:4146}, em {zone:1457}, a recebe",

	-- Step 51: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "Pegue de novo a estrada para o noroeste a partir de {area:186}; ela continua à beira da estrada, a caminho de {zone:1457}.",

	-- Step 52: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "Rumo a {zone:1457}",
	-- {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace
	["{npc:4241}, on the {area:1659} just inside the city"] = "{npc:4241}, em {area:1659}, logo na entrada da cidade",

	-- Step 54: Elanaria
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}, just inside the city."] = "{quest:1684} fica em {area:1660}, logo na entrada da cidade.",

	-- Step 55: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:736} Ban'ethil Hollow · {quest:1684} Elanaria
	["Back out of the city gate and east along the road: {quest:1683} stands south of it, by {area:736}. Bring his horn back to {quest:1684}."] = "Saia de novo pelo portão da cidade e siga a estrada para leste: {quest:1683} fica ao sul dela, perto de {area:736}. Leve o chifre dele de volta a {quest:1684}.",

	-- Step 57: Darnassus
	-- {zone:1457} Darnassus · {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace · {area:3425} Cenarion Hold · {npc:4241} Mydrannul · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade
	["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "Siga a estrada para oeste até {zone:1457} e use {item:279378} na estalagem de {area:1659} e na boca do túnel abaixo de {area:3425}, para as duas últimas corujas. {npc:4241} fica em {area:1659}, logo na entrada da cidade. {npc:3516} está em {area:1658}, no extremo norte da cidade, {quest:922} logo ao sul dele; {npc:4092}, {npc:7999}, {npc:7313} e {npc:8396} estão no Templo da Lua, no extremo sul.",
	-- {npc:4088} Elanaria · {area:1660} Warrior's Terrace · {spell:71} Defensive Stance
	["{npc:4088}, on the {area:1660}: {spell:71}"] = "{npc:4088}, em {area:1660}: {spell:71}",
	-- {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace
	["{item:279378}: the inn on the {area:1659}"] = "{item:279378}: a estalagem de {area:1659}",

	-- Step 59: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}, em {area:1658}",

	-- Step 60: Cenarion Enclave
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}, em {area:1658}: {spell:5149}",

	-- Step 62: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}, em {area:1658}",
	-- {area:3425} Cenarion Hold
	["the tunnel mouth below {area:3425}, on the way south"] = "a boca do túnel abaixo de {area:3425}, no caminho para o sul",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}, no Templo da Lua",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}, acima de {npc:4092}",
	-- {quest:2520} Sathrah's Sacrifice
	["{quest:2520}, standing in the temple's central fountain"] = "{quest:2520}, na fonte central do templo",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}, no Templo da Lua: Fragmentos Estelares",

	-- Step 63: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Cajados com {npc:11866} ({area:1660}, 10 pratas); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 64: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Já que está aqui: aprenda Cajados com {npc:11866} ({area:1660}, 10 pratas); enquanto você sobe de nível, um cajado traz mais atributos de feitiço que uma arma de uma mão.",

	-- Step 65: Portal to Teldrassil
	-- {quest:940} Teldrassil
	["Portal to {quest:940}"] = "Portal para {quest:940}",

	-- Step 66: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine · {area:442} Auberdine · {npc:4200} Laird
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs. Once you have {quest:6342}, talk to {npc:3838} again and choose the flight to {area:442}: it is free and lands beside {npc:4200}. If the flight map opens instead, close it and talk to him again holding Shift."] = "Desça pelo portal até {area:702}. {npc:10118} fica no cais, {npc:3838} junto aos hipogrifos. Quando tiver {quest:6342}, fale de novo com {npc:3838} e escolha o voo para {area:442}: é de graça e pousa ao lado de {npc:4200}. Se abrir o mapa de voo, feche e fale com ele de novo segurando Shift.",
	-- {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine
	["talk to {npc:3838} again: free with {quest:6342}"] = "fale de novo com {npc:3838}: de graça com {quest:6342}",

	-- Step 67: Auberdine
	-- {npc:3841} Caylais Moonfeather · {npc:4200} Laird
	["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Aprenda a rota de voo com {npc:3841} onde você pousar. A barraca de peixe de {npc:4200} fica logo ao norte dela, junto ao cais.\nO barco atraca a oeste da vila. O mestre de voo fica no morro ao sul da estalagem; quem dá missões está espalhado pela rua principal.",
	["The WANTED poster outside the inn"] = "O cartaz de PROCURA-SE em frente à estalagem",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart"] = "{npc:3666}, no andar de cima da estalagem: pegue a escada lá dentro, a seta não diferencia os andares",

	-- Step 68: Return to Nessa
	-- {area:702} Rut'theran Village · {npc:3841} Caylais Moonfeather · {item:16263} Laird's Response · {npc:10118} Nessa Shadowsong · {area:442} Auberdine
	["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442}."] = "Voe de volta a {area:702} a partir de {npc:3841}, entregue {item:16263} a {npc:10118} no cais, depois voe de volta a {area:442}.",

	-- Step 69: The Long Wash
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Maretiscos correm pela costa abaixo do vilarejo; {quest:983} fica na praia logo ao sul das docas. Manguais da Costa Negra nadam nas águas rasas. A {object:175207} está na costa logo ao sul do vilarejo.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "Patas de Rastejante: os Maretiscos",

	-- Step 70: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, no extremo norte do vilarejo",

	-- Step 71: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "Só para pescadores: {npc:10216} fica no cais. A {item:12238} dele é pescada do próprio cais.",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "{npc:10216}, no cais",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5929} fica na mata ao noroeste. Depois {npc:11800}, em {area:2361}, leva Druidas direto para {area:702}, sem precisar de rota de voo. {npc:11802} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Fale com {quest:5929}",

	-- Step 73: Back to Darnassus
	-- {npc:10118} Nessa Shadowsong · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:10118} stands on the Rut'theran dock where you land. Then take the portal up to {npc:4217} in the {area:1658}."] = "{npc:10118} fica no cais de Rut'theran, onde você pousa. Depois suba pelo portal até {npc:4217}, em {area:1658}.",

	-- Step 76: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Desça de volta até {area:702} e voe para {area:442}. {object:177525} fica nas colinas logo a leste da vila: use o {item:15208} ali, derrote Lunagarra e fale com {npc:12144}.",

	-- Step 77: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442}."] = "Voe para {area:702} mais uma vez e pegue o portal para subir até {npc:4217}; depois volte voando para {area:442}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {zone:1453}"] = "Barco para {zone:1453}",
	-- ["East to {area:260}"] = "Ao leste, para {area:260}",
	-- ["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "As Pinhas Vis ficam sob as árvores ao redor de {area:186} e de {npc:2150}. Sabres-da-noite e Tocaieiras Lenhateia continuam vagando pela estrada para o leste. {object:126158} está na casa da colina, no extremo leste da aldeia.",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "Siga a estrada para o sudoeste, saindo de {area:188}, até {area:186}.",
	-- ["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "Siga a estrada para o oeste até {zone:1457}. {npc:4241} fica em {area:1659}, logo na entrada da cidade. {npc:3516} está em {area:1658}, no extremo norte da cidade, e {quest:922} logo ao sul; {npc:4092} e {npc:7999} estão no Templo da Lua, no extremo sul. {npc:7316} está no oeste da cidade, a caminho do portal rosa que desce até a Vila de Rut'theran.",
	-- ["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "Do porto, entre em {object:2100}. {npc:5480} treina guerreiros ali; {npc:6089} e {npc:6090} ficam juntos perto de {object:2152}. {npc:6090} luta com você pela caneca dele.",
	-- ["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "De {area:17203}, atravesse os portões da cidade até {zone:1429} e siga a estrada para o oeste até {zone:1436}.",
	-- ["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "Místicos Masca-pinho e Ferócitas, o Comedor de Sonhos, acampam a nordeste de {area:260}. Ferócitas deixa cair o {item:8049}: abra-o para obter a joia.",
	-- ["Hearth to {area:186}"] = "Regresse para {area:186}",
	-- ["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Aprenda a rota de voo de {area:442} na colina ao sul da estalagem e depois lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5929} fica no bosque a noroeste. Aprenda a rota de voo de {area:493} em {area:2361} e voe para {area:702} (passando por {area:442}).",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "Sabres-da-noite, Corujas Estrígidas e Tocaieiras Lenhateia vivem ao longo da estrada para o leste. O poço lunar fica na borda oeste de {area:260}.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "Sabres-da-noite, Corujas Estrígidas e Tocaieiras Lenhateia rondam por todo {area:186} e ao longo da estrada para o leste. O poço lunar fica na borda oeste de {area:260}.",
	-- ["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Ao sul de Zenn Cascovil. {npc:2080} cuida das mudas dele na margem; Brotos de Açoitadeira e Muscoides vagueiam ao redor dele, e {quest:919} crescem entre eles.",
	-- ["South of the pools. The {object:6751} grows by the Hold."] = "Ao sul dos lagos. {object:6751} cresce junto ao Acampamento Masca-pinho.",
	-- ["Speak with {npc:6286}, south of the inn"] = "Fale com {npc:6286}, ao sul da estalagem",
	-- ["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "Pegue o portal para descer até {area:702}. {npc:10118} fica no cais, {npc:3838} junto aos hipogrifos.",
	-- ["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "Pegue o portal para subir de {area:702} até {npc:4217} em {area:1658}.",
	-- ["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "Pegue a estrada para o noroeste a partir de {area:186}, em direção a {area:264}; ela está ferida à beira da estrada.",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "As Harpias Plumassangue fazem ninho nas encostas a oeste e ao norte da clareira.",
	-- ["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "O túmulo fica ao sul da estrada. {npc:275744} está presa lá dentro, {npc:7317} dorme nas profundezas, e os quatro baús de relíquias ficam nas salas inferiores.",
	-- ["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "O poço lunar fica ao norte de {area:256}; {npc:8584} está um pouco mais a noroeste. {quest:3522} dura cinco minutos: encha o frasco e vá direto até ele.",
	-- ["The {area:264}"] = "{area:264}",
	-- ["Tide Crawlers scuttle along the shore below the village; {object:17182} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Maretiscos correm pela praia abaixo da vila; a {object:17182} fica na praia logo ao sul do cais. Manguais da Costa Negra nadam na água rasa. A {object:175207} está na praia logo ao sul da vila.",
	-- ["Use the {item:5623} at the moonwell"] = "Use o {item:5623} no poço lunar",
	-- ["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "Ande para o sul pelo lado oeste da ilha. Ursal, o Espancador, ronda o extremo sul, abaixo de {area:478}.",
	-- ["Webwood Spiders"] = "Aranhas Lenhateia",
	-- ["{area:186} quests"] = "Missões de {area:186}",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150} fica junto à estrada, logo a leste de {area:186}, a caminho de {area:260}.",
	-- ["{npc:2150}, on the way back"] = "{npc:2150}, no caminho de volta",
	-- ["{npc:3567}, back in {area:186}"] = "{npc:3567}, de volta a {area:186}",
	-- ["{npc:3593}, the warrior trainer"] = "{npc:3593}, o instrutor de guerreiro",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595}, dentro da árvore",
	-- ["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}, a instrutora de sacerdote, dentro da árvore",
	-- ["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "A banca de peixe de {npc:4200} fica perto do cais. Depois pegue o barco para {zone:1453}.",
	-- ["{npc:7318}, in the den"] = "{npc:7318}, na toca",
	-- ["{npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "{npc:8584} fica um pouco mais a noroeste. {quest:3522} dura cinco minutos: encha o frasco e vá direto até ele.",
	-- ["{quest:488} and the Starbreeze moonwell"] = "{quest:488} e o poço lunar do Vilarejo Brisastral",
}
