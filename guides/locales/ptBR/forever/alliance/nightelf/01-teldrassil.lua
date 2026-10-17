-- Portuguese (Brazil) (ptBR): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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

	-- Step 2: The Balance of Nature
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Grells = {npc:1988} Grell · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "Sabres-da-noite Jovens e Javalis-espinho Jovens vagueiam ao redor de {area:256}. Os Capetas carregam {item:3297} no bosque a oeste da árvore, onde ficam os Totens de Masca-pinho.",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "De volta a {area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}: um sigilo para {npc:3596}",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}, na rampa da árvore",
	-- {npc:3595} Shanda
	["{npc:3595}, inside the tree"] = "{npc:3595}, dentro da árvore",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}: lance {spell:1259799} e Fusão Sombria e depois entregue a {npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}, a leste da árvore",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "Ao norte, para {area:257}",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {npc:1994} Githyiss the Vile
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "Sabres-da-noite Sarnentos e Javalis-espinho vagueiam ao norte de {area:256}, a caminho da caverna. {npc:8584} espera entre as árvores a oeste da entrada da caverna; {npc:1994} fica bem no fundo.",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders"] = "Aranhas Lenhateia",

	-- Step 5: Aldrassil
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer"] = "{npc:3593}, o instrutor de guerreiro",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}, a instrutora de caçador",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}, o instrutor de ladino",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}, a instrutora de sacerdote, dentro da árvore",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}, o instrutor de druida em {area:256}",

	-- Step 7: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917} e o antídoto",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom · Grells = {npc:1988} Grell
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406} ficam no fundo de {area:257}: pegue o caminho central e vire à esquerda na bifurcação, até a saliência alta. Os Capetas deixam cair Cogumelos Jacinto; os Lírios Lunapétala crescem junto aos lagos ao norte de {area:256}.",

	-- Step 8: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}, no topo da árvore",

	-- Step 9: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "O poço lunar e {npc:8584}",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {quest:3522} Iverron's Antidote
	["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "O poço lunar fica ao norte de {area:256}; {npc:8584} está um pouco mais a noroeste. {quest:3522} dura cinco minutos: encha o frasco e vá direto até ele.",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "Use o {item:5185} no poço lunar",

	-- Step 10: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "De volta ao topo de {area:256}. {object:654846} está ao lado dele.",

	-- Step 11: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "Saia de {area:188} pela trilha a sudeste de {area:256}: {npc:6780} fica ao lado dela, onde ela desce em direção à estrada para {area:186}.",

	-- Step 12: Dolanaar
	-- {area:188} Shadowglen · {area:186} Dolanaar
	["Follow the road south-west out of {area:188} to {area:186}."] = "Siga a estrada para o sudoeste, saindo de {area:188}, até {area:186}.",
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}, junto à fogueira",
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}, ao sul da estalagem",

	-- Step 13: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150} fica junto à estrada, logo a leste de {area:186}, a caminho de {area:260}.",

	-- Step 14: Zenn's Bidding and the Starbreeze moonwell
	-- {quest:488} Zenn's Bidding
	["{quest:488} and the Starbreeze moonwell"] = "{quest:488} e o poço lunar do Vilarejo Brisastral",
	-- {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "Sabres-da-noite, Corujas Estrígidas e Tocaieiras Lenhateia vivem ao longo da estrada para o leste. O poço lunar fica na borda oeste de {area:260}.",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "Use o {item:5619} no poço lunar",
	-- {npc:2150} Zenn Foulhoof
	["{npc:2150}, on the way back"] = "{npc:2150}, no caminho de volta",

	-- Step 15: Dolanaar quests
	-- {area:186} Dolanaar
	["{area:186} quests"] = "Missões de {area:186}",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "Use /sentar junto à fogueira de {npc:265811} até receber {spell:1229451}",
	-- {npc:6286} Zarrin
	["Speak with {npc:6286}, south of the inn"] = "Fale com {npc:6286}, ao sul da estalagem",

	-- Step 17: East to Starbreeze Village
	-- {area:260} Starbreeze Village
	["East to {area:260}"] = "Ao leste, para {area:260}",
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {object:126158} Tallonkai's Dresser
	-- plural, as words: Fel Cones = {object:1673} Fel Cone · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "As Pinhas Vis ficam sob as árvores ao redor de {area:186} e de {npc:2150}. Sabres-da-noite e Tocaieiras Lenhateia continuam vagando pela estrada para o leste. {object:126158} está na casa da colina, no extremo leste da aldeia.",
	["Nightsabers"] = "Sabres-da-noite",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "Tocaieiras Lenhateia",

	-- Step 19: Lake Al'Ameth
	-- {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Ao sul de Zenn Cascovil. {npc:2080} cuida das mudas dele na margem; Brotos de Açoitadeira e Muscoides vagueiam ao redor dele, e {quest:919} crescem entre eles.",

	-- Step 20: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}, na estrada a oeste da aldeia",

	-- Step 21: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "Entrada de {area:258}",

	-- Step 22: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038} espera dentro da caverna, no fundo ou em cima da saliência; mantenha-se à direita.",

	-- Step 23: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "A estrada para {zone:1457}",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "Emboscadores Masca-pinho se escondem ao longo da estrada a oeste de {area:258}.",

	-- Step 24: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "O túmulo fica ao sul da estrada. {npc:275744} está presa lá dentro, {npc:7317} dorme nas profundezas, e os quatro baús de relíquias ficam nas salas inferiores.",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "Xamãs Masca-pinho",
	-- {npc:7318} Rageclaw
	["{npc:7318}, in the den"] = "{npc:7318}, na toca",

	-- Step 25: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "Escolte {npc:275744} para fora do túmulo; {npc:2081}, em {area:186}, recebe o relatório.",
	["Walk Lynessa out and keep her alive"] = "Leve Lynessa para fora e mantenha-a viva",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}, fora do túmulo",

	-- Step 26: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "A sudoeste do túmulo. O poço lunar fica junto aos lagos.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "Use o {item:5621} no poço lunar",

	-- Step 27: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold."] = "Ao sul dos lagos. {object:6751} cresce junto ao Acampamento Masca-pinho.",

	-- Step 28: Hearth to Dolanaar
	-- {area:186} Dolanaar
	["Hearth to {area:186}"] = "Regresse para {area:186}",

	-- Step 29: Ferocitas the Dream Eater
	-- {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "Místicos Masca-pinho e Ferócitas, o Comedor de Sonhos, acampam a nordeste de {area:260}. Ferócitas deixa cair o {item:8049}: abra-o para obter a joia.",
	-- {npc:3567} Tallonkai Swiftroot · {area:186} Dolanaar
	["{npc:3567}, back in {area:186}"] = "{npc:3567}, de volta a {area:186}",

	-- Step 30: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {area:264} Oracle Glade
	["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "Pegue a estrada para o noroeste a partir de {area:186}, em direção a {area:264}; ela está ferida à beira da estrada.",

	-- Step 31: Oracle Glade
	-- {object:6752} Strange Fronded Plant (no name in this language: may be words)
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "O poço lunar fica no meio da clareira. {object:6752} cresce no extremo norte dela.",
	-- {item:5623} Amethyst Phial
	["Use the {item:5623} at the moonwell"] = "Use o {item:5623} no poço lunar",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}, junto ao poço lunar",

	-- Step 32: Bloodfeather harpies
	["Bloodfeather harpies"] = "Harpias Plumassangue",
	["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "As Harpias Plumassangue fazem ninho nas encostas a oeste e ao norte da clareira.",

	-- Step 33: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "De volta ao poço lunar.",

	-- Step 34: The named harpies
	["The named harpies"] = "As harpias nomeadas",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034} e {npc:272044} voam logo a oeste do poço lunar, {npc:272046} mais ao norte.",

	-- Step 35: Sentinel Arynia again
	["Sentinel Arynia again"] = "Sentinela Arynia de novo",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words)
	["{object:673378}, just west of the moonwell"] = "{object:673378}, logo a oeste do poço lunar",

	-- Step 36: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "Ande para o sul pelo lado oeste da ilha. Ursal, o Espancador, ronda o extremo sul, abaixo de {area:478}.",

	-- Step 37: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "Para o nordeste a partir do covil de Ursal, de volta a {area:186}.",
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

	-- Step 38: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "A sudeste de Dolanaar, até {npc:2080}. Brotos de Açoitadeira vagueiam ao redor dele na margem.",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}: {quest:922}, em {zone:1457}, a recebe",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "{object:7510}, ao lado dele",

	-- Step 39: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "{area:186} de novo",

	-- Step 40: Taming the Beast
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

	-- Step 41: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "Pegue de novo a estrada para o noroeste a partir de {area:186}; ela continua à beira da estrada, a caminho de {zone:1457}.",

	-- Step 42: Darnassus
	-- {zone:1457} Darnassus · {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7316} Sister Aquinne
	["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "Siga a estrada para o oeste até {zone:1457}. {npc:4241} fica em {area:1659}, logo na entrada da cidade. {npc:3516} está em {area:1658}, no extremo norte da cidade, e {quest:922} logo ao sul; {npc:4092} e {npc:7999} estão no Templo da Lua, no extremo sul. {npc:7316} está no oeste da cidade, a caminho do portal rosa que desce até a Vila de Rut'theran.",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}, em {area:1658}",
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}, em {area:1658}: {spell:5149}",
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}, em {area:1658}",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}, no Templo da Lua",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}, acima de {npc:4092}",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}, no Templo da Lua: Fragmentos Estelares",

	-- Step 43: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "Pegue o portal para descer até {area:702}. {npc:10118} fica no cais, {npc:3838} junto aos hipogrifos.",

	-- Step 45: Moonglade
	-- {area:442} Auberdine · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {area:702} Rut'theran Village
	["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Aprenda a rota de voo de {area:442} na colina ao sul da estalagem e depois lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5929} fica no bosque a noroeste. Aprenda a rota de voo de {area:493} em {area:2361} e voe para {area:702} (passando por {area:442}).",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Fale com {quest:5929}",

	-- Step 46: Back to Darnassus
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "Pegue o portal para subir de {area:702} até {npc:4217} em {area:1658}.",

	-- Step 47: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Desça de volta até {area:702} e voe para {area:442}. {object:177525} fica nas colinas logo a leste da vila: use o {item:15208} ali, derrote Lunagarra e fale com {npc:12144}.",

	-- Step 48: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "Voe para {area:702} mais uma vez e pegue o portal para subir até {npc:4217}; depois volte voando para {area:442} para pegar o barco.",

	-- Step 49: Auberdine
	-- {npc:4200} Laird · {zone:1453} Stormwind
	["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "A banca de peixe de {npc:4200} fica perto do cais. Depois pegue o barco para {zone:1453}.",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "Barco para {zone:1453}",
	-- {area:17203} Stormwind Harbor · {zone:1429} Elwynn Forest · {zone:1436} Westfall
	["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "De {area:17203}, atravesse os portões da cidade até {zone:1429} e siga a estrada para o oeste até {zone:1436}.",

	-- Step 50: Defensive Stance
	-- {object:2100} Old Town · {npc:5480} Ilsa Corbin · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "Do porto, entre em {object:2100}. {npc:5480} treina guerreiros ali; {npc:6089} e {npc:6090} ficam juntos perto de {object:2152}. {npc:6090} luta com você pela caneca dele.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:264}"] = "{area:264}",
}
