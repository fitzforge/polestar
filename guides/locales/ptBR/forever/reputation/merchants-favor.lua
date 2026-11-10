-- Portuguese (Brazil) (ptBR): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Supply Factions Reputation"] = "Reputação das Facções de Suprimentos",
	-- {npc:10636} Pack Kodo
	["Forever's trade camps: their best recipes, the Minimule and the {npc:10636} need standing, not only Merchant's Favor."] = "Os acampamentos comerciais do Forever: as melhores receitas, o Minimule e {npc:10636} exigem reputação, não só Merchant's Favor.",
	["Profession recipes at Friendly and Honored"] = "Receitas de profissão em Amigável e Honrado",

	-- Step 1: Your first Waylaid Crate or writ
	-- {item:248549} Waylaid Crate
	["Your first {item:248549} or writ"] = "Seu primeiro {item:248549} ou escritura",
	-- {quest:98247} Shipping Label
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["From level 10, mobs anywhere drop Waylaid Crates and sealed writs (Journeyman's, Expert's and Artisan's). Fill a crate with one of the bundles it lists (right-click it), or open a sealed writ: by beta reports, the first time you do either you also get a {quest:98247}. Right-click the label to start its quest. Crates and writs can be traded, so the Auction House sells them too."] = "A partir do nível 10, monstros em qualquer lugar soltam Caixotes Extraviados e escrituras lacradas (de Profissional, de Perito e de Artífice). Encha um caixote com um dos pacotes listados nele (clique com o botão direito) ou abra uma escritura lacrada: segundo relatos do beta, na primeira vez que você faz qualquer um dos dois também ganha {quest:98247}. Clique com o botão direito na etiqueta para iniciar a missão dela. Caixotes e escrituras podem ser trocados, então a Casa de Leilões também vende.",

	-- Step 2: Three Corners: the Shipping Label
	-- {area:1002} Three Corners · {quest:98247} Shipping Label
	["{area:1002}: the {quest:98247}"] = "{area:1002}: {quest:98247}",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256390} Marcy Baker
	["The {faction:2586} camp is at {area:1002}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet in western Redridge. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256390} too, but they pay only Merchant's Favor and silver, never reputation."] = "O acampamento de {faction:2586} fica em {area:1002}, onde as estradas de {zone:1429}, {zone:1431} e {area:69} se encontram, no oeste de Cristarrubra. A etiqueta rende 2000 de reputação uma única vez (e, segundo relatos do beta, 50 de Merchant's Favor): dois terços do caminho até Amigável. Caixotes cheios também vão para {npc:256390}, mas rendem só Merchant's Favor e pratas, nunca reputação.",

	-- Step 3: The Crossroads camp: the Shipping Label
	-- {area:380} The Crossroads · {quest:98248} Shipping Label
	["{area:380} camp: the {quest:98248}"] = "Acampamento de {area:380}: {quest:98248}",
	-- {faction:2587} Durotar Supply and Logistics · {npc:256386} Dokimi
	["The {faction:2587} camp stands just outside the west gate of the Crossroads. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "O acampamento de {faction:2587} fica logo fora do portão oeste da Encruzilhada. A etiqueta rende 2000 de reputação uma única vez (e, segundo relatos do beta, 50 de Merchant's Favor): dois terços do caminho até Amigável. Caixotes cheios também vão para {npc:256386}, mas rendem só Merchant's Favor e pratas, nunca reputação.",

	-- Step 4: Gather your writs
	["Gather your writs"] = "Junte suas escrituras",
	["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, the one its title names. Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "As Escrituras do artífice são a reputação do acampamento: 75 por uma escritura de Oficial, 125 por uma de Perito, 200 por uma de Artesão. Cada uma pede um item fabricado, o que o título dela cita. Fabrique ou compre na Casa de Leilões; você não precisa conhecer a profissão. Cada escritura pode ser feita uma vez por dia, e quantas diferentes você quiser. Pegue a missão só das escrituras cujo item você tem ou vai comprar no caminho (clique com o botão direito na escritura), mantenha a escritura nas bolsas e marque esta etapa: os próximos passos levam a cada cliente para quem você tem uma escritura.",
	["Take the quests of the writs you can fill"] = "Pegue as missões das escrituras que você consegue cumprir",

	-- Step 5: Duskwood writ customers
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers"] = "Clientes de escrituras em {zone:1431}",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}. Customers show no quest mark: right-click them anyway."] = "{npc:3134} fica a cerca de 450 jardas ao norte de {area:42}. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:6048} Shadow Protection Potion
	["{item:6048}, 75 reputation"] = "{item:6048}, 75 de reputação",
	-- {item:4381} Minor Recombobulator
	["{item:4381}, 75 reputation"] = "{item:4381}, 75 de reputação",
	-- {item:2317} Dark Leather Tunic
	["{item:2317}, 75 reputation"] = "{item:2317}, 75 de reputação",
	-- {item:4245} Small Silk Pack
	["{item:4245}, 75 reputation"] = "{item:4245}, 75 de reputação",

	-- Step 6: Stranglethorn Vale writ customers
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers"] = "Clientes de escrituras em {zone:1434}",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {area:1741} Gurubashi Arena · {object:3202} Grom'gol (no name in this language: may be words) · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} tem três clientes: MacKinley “Lobo do Mar” (no último andar da estalagem), {npc:7853}, o engenheiro do transportador goblin, e {npc:2663}. {npc:14508} fica em {area:1741}, a cerca de 800 metros ao sul de {object:3202}; {npc:261961} está no norte da Selva do Espinhaço. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:3485} Green Iron Gauntlets
	["{item:3485}, 75 reputation"] = "{item:3485}, 75 de reputação",
	-- {item:7506} Gnomish Universal Remote
	["{item:7506}, 75 reputation"] = "{item:7506}, 75 de reputação",
	-- {item:4252} Dark Leather Shoulders
	["{item:4252}, 75 reputation"] = "{item:4252}, 75 de reputação",
	-- {item:3388} Lesser Troll's Blood Elixir
	["{item:3388}, 75 reputation"] = "{item:3388}, 75 de reputação",
	-- {item:10048} Colorful Kilt
	["{item:10048}, 75 reputation"] = "{item:10048}, 75 de reputação",

	-- Step 7: Wetlands writ customers
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers"] = "Clientes de escrituras em {zone:1437}",
	-- {npc:8305} Kixxle · {area:205} Dun Modr
	["{npc:8305} stands about 600 yards south of {area:205}. Five Journeyman writs go to him: the most of any customer. Customers show no quest mark: right-click them anyway."] = "{npc:8305} fica a cerca de 600 jardas ao sul de {area:205}. Cinco escrituras de Profissional vão para ele: mais do que qualquer outro cliente. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:5996} Draught of Water Breathing
	["{item:5996}, 75 reputation"] = "{item:5996}, 75 de reputação",
	-- {item:3484} Green Iron Boots
	["{item:3484}, 75 reputation"] = "{item:3484}, 75 de reputação",
	-- {item:8069} Crafted Solid Shot
	["{item:8069}, 75 reputation"] = "{item:8069}, 75 de reputação",
	-- {item:7284} Red Whelp Gloves
	["{item:7284}, 75 reputation"] = "{item:7284}, 75 de reputação",
	-- {item:4321} Spider Silk Slippers
	["{item:4321}, 75 reputation"] = "{item:4321}, 75 de reputação",

	-- Step 8: Arathi Highlands writ customers
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers"] = "Clientes de escrituras em {zone:1417}",
	-- {npc:257296} Muggol Breezebeard · {area:320} Refuge Pointe · {npc:257304} Alyce
	["{npc:257296} is about 250 yards south of {area:320}, {npc:257304} about 700 yards north-west of it. Customers show no quest mark: right-click them anyway."] = "{npc:257296} fica a cerca de 250 jardas ao sul de {area:320}, e {npc:257304} a cerca de 700 jardas a noroeste dele. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:3383} Elixir of Wisdom
	["{item:3383}, 75 reputation"] = "{item:3383}, 75 de reputação",
	-- {item:11128} Golden Rod
	["{item:11128}, 75 reputation"] = "{item:11128}, 75 de reputação",
	-- {npc:789} Kimberly Hiett · {area:69} Lakeshire
	["bring it: engineers make it; {npc:789} in {area:69} lists it (not yet seen in her window up to level 30), or the Auction House"] = "leve até ele: engenheiros fabricam; {npc:789} em {area:69} o vende (ainda não visto no estoque dela até o nível 30), ou a Casa de Leilões",
	-- {item:4384} Explosive Sheep
	["{item:4384}, 75 reputation"] = "{item:4384}, 75 de reputação",
	-- {item:5958} Fine Leather Pants
	["{item:5958}, 75 reputation"] = "{item:5958}, 75 de reputação",
	-- {item:6263} Blue Overalls
	["{item:6263}, 75 reputation"] = "{item:6263}, 75 de reputação",

	-- Step 9: Hillsbrad Foothills writ customers
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers"] = "Clientes de escrituras em {zone:1424}",
	-- {npc:261932} Gorgrash · {npc:3536} Kris Legace · {npc:261928} Webbed Mudsnout Gnoll · {area:271} Southshore
	["{npc:261932} and {npc:3536} are in the east of the foothills; the {npc:261928} hangs in a spider cocoon about 500 yards south-east of {area:271}. Customers show no quest mark: right-click them anyway."] = "{npc:261932} e {npc:3536} ficam no leste do sopé das montanhas; {npc:261928} está pendurado num casulo de aranha a cerca de 500 jardas a sudeste de {area:271}. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:3491} Heavy Bronze Mace
	["{item:3491}, 75 reputation"] = "{item:3491}, 75 de reputação",
	["bring it: craft it or buy it at the Auction House"] = "leve até ele: fabrique ou compre na Casa de Leilões",
	-- {item:6712} Practice Lock
	["{item:6712}, 75 reputation"] = "{item:6712}, 75 de reputação",
	-- {item:7358} Pilferer's Gloves
	["{item:7358}, 75 reputation"] = "{item:7358}, 75 de reputação",
	-- {item:5634} Free Action Potion
	["{item:5634}, 75 reputation"] = "{item:5634}, 75 de reputação",

	-- Step 10: Alterac Mountains writ customers
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers"] = "Clientes de escrituras em {zone:1416}",
	-- {npc:257281} Sos'mol · {npc:257282} Alan Sneeks · {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill
	["{npc:257281} and {npc:257282} are close together in the south-west of the mountains; Syndicate thugs roam around {npc:257282}. {npc:6176} stands on the eastern edge, above {area:272}. Customers show no quest mark: right-click them anyway."] = "{npc:257281} e {npc:257282} ficam perto um do outro, no sudoeste das montanhas; bandidos da Camarilha rondam {npc:257282}. {npc:6176} fica no limite leste, acima de {area:272}. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:3391} Elixir of Ogre Strength
	["{item:3391}, 75 reputation"] = "{item:3391}, 75 de reputação",
	["bring it: leatherworkers make it, or buy it at the Auction House"] = "leve até ele: coureiros fabricam, ou compre na Casa de Leilões",
	-- {item:18662} Heavy Leather Ball
	["{item:18662}, 75 reputation"] = "{item:18662}, 75 de reputação",
	-- {item:5540} Pearl-handled Dagger
	["{item:5540}, 75 reputation"] = "{item:5540}, 75 de reputação",
	-- {item:5507} Ornate Spyglass
	["{item:5507}, 75 reputation"] = "{item:5507}, 75 de reputação",
	-- {item:5766} Lesser Wizard's Robe
	["{item:5766}, 75 reputation"] = "{item:5766}, 75 de reputação",
	-- {item:4317} Phoenix Pants
	["{item:4317}, 75 reputation"] = "{item:4317}, 75 de reputação",

	-- Step 11: Ashenvale writ customers
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers"] = "Clientes de escrituras em {zone:1440}",
	-- {area:431} Splintertree Post · {npc:257315} Ash'alari · {npc:257322} Murache · {npc:257316} Cowardly Peon · {npc:257317} Grembly
	["All four stand around {area:431}: {npc:257315} about 850 yards south-west of it, {npc:257322} to the south, the {npc:257316} about 350 yards south-east and {npc:257317} about 650 yards north-east. Customers show no quest mark: right-click them anyway."] = "Os quatro ficam em volta de {area:431}: {npc:257315} a cerca de 850 jardas a sudoeste, {npc:257322} ao sul, {npc:257316} a cerca de 350 jardas a sudeste e {npc:257317} a cerca de 650 jardas a nordeste. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:3385} Lesser Mana Potion
	["{item:3385}, 75 reputation"] = "{item:3385}, 75 de reputação",
	-- {item:7349} Herbalist's Gloves
	["{item:7349}, 75 reputation"] = "{item:7349}, 75 de reputação",
	-- {item:5541} Iridescent Hammer
	["{item:5541}, 75 reputation"] = "{item:5541}, 75 de reputação",
	-- {item:7048} Azure Silk Hood
	["{item:7048}, 75 reputation"] = "{item:7048}, 75 de reputação",
	-- {item:4383} Moonsight Rifle
	["{item:4383}, 75 reputation"] = "{item:4383}, 75 de reputação",

	-- Step 12: A Heavy Quiver for the writ
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ"] = "Uma {item:7371} para a escritura",
	-- {item:7371} Heavy Quiver · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1458} Undercity
	["Leatherworkers make the {item:7371}; the bow and gun vendors of {zone:1453}, {zone:1455} and the {zone:1458} sell it. Otherwise buy one at the Auction House."] = "Coureiros fabricam a {item:7371}; os vendedores de arcos e armas de fogo de {zone:1453}, {zone:1455} e {zone:1458} o vendem. Do contrário, compre um na Casa de Leilões.",

	-- Step 13: Stonetalon Mountains writ customers
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers"] = "Clientes de escrituras em {zone:1442}",
	-- {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["{npc:4201} has a small hut about 550 yards east of {area:460}. Four Journeyman writs go to him. Customers show no quest mark: right-click them anyway."] = "{npc:4201} tem uma cabana pequena a cerca de 550 jardas a leste de {area:460}. Quatro escrituras de Profissional vão para ele. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:3390} Elixir of Lesser Agility
	["{item:3390}, 75 reputation"] = "{item:3390}, 75 de reputação",
	-- {item:2865} Rough Bronze Leggings
	["{item:2865}, 75 reputation"] = "{item:2865}, 75 de reputação",
	-- {item:4373} Shadow Goggles
	["{item:4373}, 75 reputation"] = "{item:4373}, 75 de reputação",
	-- {item:7371} Heavy Quiver
	["{item:7371}, 75 reputation"] = "{item:7371}, 75 de reputação",

	-- Step 14: Thousand Needles writ customers
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers"] = "Clientes de escrituras em {zone:1441}",
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {area:484} Freewind Post · {npc:4720} Rizzle Brassbolts · {npc:4706} Razzeric · {npc:4496} Goblin Pit Boss · {npc:6548} Magus Tirth
	["All five stand at the {area:2240} on the {area:439}, south-east of {area:484}: {npc:4720}, the chicken \"Plucky\" Johnson, {npc:4706}, the {npc:4496} and {npc:6548}. Customers show no quest mark: right-click them anyway."] = "Os cinco ficam em {area:2240}, em {area:439}, a sudeste de {area:484}: {npc:4720}, a galinha Johnson “Depenado”, {npc:4706}, {npc:4496} e {npc:6548}. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",
	-- {item:8951} Elixir of Defense
	["{item:8951}, 75 reputation"] = "{item:8951}, 75 de reputação",
	-- {item:3848} Big Bronze Knife
	["{item:3848}, 75 reputation"] = "{item:3848}, 75 de reputação",
	-- {item:4380} Big Bronze Bomb
	["{item:4380}, 75 reputation"] = "{item:4380}, 75 de reputação",
	-- {item:4254} Barbaric Gloves
	["{item:4254}, 75 reputation"] = "{item:4254}, 75 de reputação",
	-- {item:6264} Greater Adept's Robe
	["{item:6264}, 75 reputation"] = "{item:6264}, 75 de reputação",

	-- Step 15: Neutral to Friendly
	["Neutral to Friendly"] = "Neutro a Amigável",
	-- {quest:98247} Shipping Label
	["After the {quest:98247}, Friendly is 1000 more: 14 Journeyman writs, 8 Expert or 5 Artisan. Expert and Artisan customers are mostly not in Polestar's data yet: follow the mark the quest puts on your map. Journeyman envelopes drop from mobs of about level 11 to 31; Expert and Artisan ones from higher mobs."] = "Depois de {quest:98247}, Amigável fica a mais 1000: 14 escrituras de Profissional, 8 de Perito ou 5 de Artífice. Os clientes de Perito e Artífice em sua maioria ainda não estão nos dados do Polestar: siga a marca que a missão põe no seu mapa. Os envelopes de Profissional caem de monstros de nível 11 a 31, mais ou menos; os de Perito e Artífice, de monstros mais fortes.",

	-- Step 16: Gather your writs again
	["Gather your writs again"] = "Junte suas escrituras de novo",

	-- Step 17: Duskwood writ customers again
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers again"] = "Clientes de escrituras em {zone:1431} de novo",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}, by the road. Customers show no quest mark: right-click them anyway."] = "{npc:3134} fica a cerca de 450 jardas ao norte de {area:42}, junto à estrada. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",

	-- Step 18: Stranglethorn Vale writ customers again
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers again"] = "Clientes de escrituras em {zone:1434} de novo",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {object:3202} Grom'gol (no name in this language: may be words) · {area:1741} Gurubashi Arena · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} tem três clientes: MacKinley “Lobo do Mar” (no último andar da estalagem), {npc:7853} na plataforma do transportador estilo zepelim e {npc:2663}. {npc:14508} fica a cerca de 800 metros ao sul de {object:3202}, junto a {area:1741}; {npc:261961} está no norte da Selva do Espinhaço. Os clientes não mostram marca de missão: clique com o botão direito neles mesmo assim.",

	-- Step 19: Wetlands writ customers again
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers again"] = "Clientes de escrituras em {zone:1437} de novo",

	-- Step 20: Arathi Highlands writ customers again
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers again"] = "Clientes de escrituras em {zone:1417} de novo",

	-- Step 21: Hillsbrad Foothills writ customers again
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers again"] = "Clientes de escrituras em {zone:1424} de novo",

	-- Step 22: Alterac Mountains writ customers again
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers again"] = "Clientes de escrituras em {zone:1416} de novo",

	-- Step 23: Ashenvale writ customers again
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers again"] = "Clientes de escrituras em {zone:1440} de novo",

	-- Step 24: A Heavy Quiver for the writ again
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ again"] = "Uma {item:7371} para a escritura de novo",

	-- Step 25: Stonetalon Mountains writ customers again
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers again"] = "Clientes de escrituras em {zone:1442} de novo",

	-- Step 26: Thousand Needles writ customers again
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers again"] = "Clientes de escrituras em {zone:1441} de novo",

	-- Step 27: Friendly to Honored
	["Friendly to Honored"] = "Amigável a Honrado",
	-- {skill:197} Tailoring · {skill:165} Leatherworking · {skill:333} Enchanting · {skill:164} Blacksmithing · {skill:202} Engineering · {skill:171} Alchemy · {skill:185} Cooking · {npc:256742} Dianne Softstep · {area:1002} Three Corners · {npc:256672} Kurvelk Shadowhoof · {item:262902} Forged Delivery Receipt · {item:248549} Waylaid Crate · {item:262917} Notarized Shipping Container · {npc:256390} Marcy Baker · {npc:256386} Dokimi · {quest:93862} Crate Return
	["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the Crossroads camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "Amigável abre as primeiras receitas restritas dos vendedores de profissão do acampamento ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) e o Escriba Não Certificado: {npc:256742} em {area:1002}, {npc:256672} no extremo sul do acampamento da Encruzilhada. O {item:262902} do escriba (15 de Favor) transforma um {item:248549} vazio num {item:262917}; entregue-o a {npc:256390} ou {npc:256386} por 50 de reputação ({quest:93862}). Qualquer caixote serve, então compre o mais barato que a Casa de Leilões tiver. Honrado fica a mais 6.000: 80 escrituras de Oficial, 48 de Perito, 30 de Artesão ou 120 devoluções de caixote (1.800 de Favor e 120 caixotes). Misture os dois: toda escritura que você conseguir cumprir, devoluções com o Favor que sobrar. A vantagem de Legado Diplomata soma até 10% a cada ganho.",
	-- {item:262902} Forged Delivery Receipt
	["{item:262902}, 15 Merchant's Favor"] = "{item:262902}, 15 de Merchant's Favor",
	-- {quest:93862} Crate Return
	["{quest:93862}: 50 reputation"] = "{quest:93862}: 50 de reputação",

	-- Step 28: Badlands writ customer
	-- {zone:1418} Badlands
	["{zone:1418} writ customer"] = "Cliente de escrituras em {zone:1418}",
	-- {npc:2921} Lotwil Veriatus · {area:340} Kargath
	["{npc:2921} works about 550 yards east of {area:340}. He is the only Expert customer Polestar's data knows."] = "{npc:2921} trabalha a cerca de 550 jardas a leste de {area:340}. Ele é o único cliente de Perito que os dados do Polestar conhecem.",
	-- {item:6050} Frost Protection Potion
	["{item:6050}, 125 reputation"] = "{item:6050}, 125 de reputação",

	-- Step 29: Honored to Revered
	["Honored to Revered"] = "De Honrado a Reverenciado",
	-- {skill:165} Leatherworking · {skill:164} Blacksmithing · {skill:333} Enchanting · {skill:171} Alchemy · {skill:202} Engineering · {skill:197} Tailoring · {skill:185} Cooking · {item:270887} Advertising License Application · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262896} Forger's Quill
	["Honored opens the rest of the gated recipes ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), the {item:270887} (1,200 Favor from {npc:256389} or {npc:256384}: it starts the quest for a Tradeskill Sign toy) and the scribe's {item:262896} (15 Favor), which swaps a writ you cannot fill for a random one of the same rank. Revered is 12000 more: 160 Journeyman writs, 96 Expert, 60 Artisan, or 240 crate returns (3,600 Favor). Forever's quest data sets no standing limit on Journeyman writs: their customers are the ones in the zone steps above."] = "Honrado abre o resto das receitas restritas ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), o {item:270887} (1.200 de Favor com {npc:256389} ou {npc:256384}: ele inicia a missão de um brinquedo de Placa de Profissões) e a {item:262896} do escriba (15 de Favor), que troca uma escritura que você não consegue cumprir por uma aleatória do mesmo nível. Reverenciado fica a mais 12000: 160 escrituras de Profissional, 96 de Perito, 60 de Artífice ou 240 devoluções de caixote (3.600 de Favor). Os dados de missão do Forever não definem limite de reputação para as escrituras de Profissional: os clientes delas são os dos passos de zona acima.",
	-- {item:270887} Advertising License Application
	["{item:270887}, 1,200 Merchant's Favor"] = "{item:270887}, 1.200 de Merchant's Favor",

	-- Step 30: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {item:284664} Packmule Treat · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {npc:10636} Pack Kodo
	["Revered opens the {item:284664}, the Minimule pet (1,500 Favor from {npc:256389} or {npc:256384}). Exalted is 21000 more: 280 Journeyman writs, 168 Expert, 105 Artisan, or 420 crate returns (6,300 Favor). Keep 6,000 Favor for the {npc:10636} if you want it."] = "Reverenciado abre o {item:284664}, o mascote Minimule (1.500 de Favor com {npc:256389} ou {npc:256384}). Exaltado fica a mais 21000: 280 escrituras de Profissional, 168 de Perito, 105 de Artífice ou 420 devoluções de caixote (6.300 de Favor). Guarde 6.000 de Favor para {npc:10636}, se você o quiser.",
	-- {item:284664} Packmule Treat
	["{item:284664}, 1,500 Merchant's Favor"] = "{item:284664}, 1.500 de Merchant's Favor",

	-- Step 31: Exalted
	["Exalted"] = "Exaltado",
	-- {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262766} Reins of the Pack Kodo · {npc:256736} Huey Sunnydale · {area:1002} Three Corners · {npc:10636} Pack Kodo
	["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the Crossroads camp. The {npc:10636} guide under Collectibles leads you there."] = "Exaltado abre o tabardo do acampamento (200 de Favor) com {npc:256389} ou {npc:256384}, e as {item:262766} (6.000 de Favor; a montaria exige nível 60 e treinamento de equitação de Oficial) com {npc:256736} em {area:1002} ou Okamache no acampamento da Encruzilhada. O guia de {npc:10636} em Colecionáveis leva você até lá.",
	-- {item:262765} Azeroth Commerce Authority Tabard
	["{item:262765}, 200 Merchant's Favor"] = "{item:262765}, 200 de Merchant's Favor",
	-- {item:262764} Durotar Supply and Logistics Tabard
	["{item:262764}, 200 Merchant's Favor"] = "{item:262764}, 200 de Merchant's Favor",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:18662} for the writ"] = "Uma {item:18662} para a escritura",
	-- ["A {item:18662} for the writ again"] = "Uma {item:18662} para a escritura de novo",
	-- ["An {item:4384} for the writ"] = "Um {item:4384} para a escritura",
	-- ["An {item:4384} for the writ again"] = "Um {item:4384} para a escritura de novo",
	-- ["Dokimi"] = "Dokimi",
	-- ["Engineers make the {item:4384}; {npc:789} sells it in {area:69} (Alliance). Otherwise buy one at the Auction House."] = "Engenheiros fabricam o {item:4384}; {npc:789} o vende em {area:69} (Aliança). Do contrário, compre um na Casa de Leilões.",
	-- ["Keep filling Waylaid Crates for Dokimi until Exalted."] = "Continue enchendo Caixotes Extraviados para Dokimi até Exaltado.",
	-- ["Keep filling Waylaid Crates for Dokimi."] = "Continue enchendo Caixotes Extraviados para Dokimi.",
	-- ["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "Continue enchendo Caixotes Extraviados para {npc:214101} até Exaltado.",
	-- ["Keep filling Waylaid Crates for {npc:214101}."] = "Continue enchendo Caixotes Extraviados para {npc:214101}.",
	-- ["Leatherworkers make the {item:18662}, and the Auction House has it. Its only vendor is {npc:14860} at the Darkmoon Faire, which Forever has not shown yet: go there only if the Faire is in town."] = "Coureiros fabricam a {item:18662}, e a Casa de Leilões o tem. O único vendedor dele é {npc:14860}, na Feira da Lua Negra, que o Forever ainda não mostrou: só vá até lá se a Feira estiver na cidade.",
	-- ["Merchant's Favor Reputation"] = "Reputação: Favor Mercantil",
	-- ["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2586} é a facção de profissões da Aliança no Forever. O acampamento fica em {area:1002}, no oeste de {zone:1433}. A partir do nível 10, monstros deixam cair Caixotes Extraviados: encha cada um com os produtos que a etiqueta pede e entregue o {object:1561} a {npc:214101} no acampamento por reputação e Merchant's Favor. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["The {faction:2587} camp stands just outside the west gate of the {area:380}. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "O acampamento de {faction:2587} fica logo fora do portão oeste de {area:380}. A etiqueta rende 2000 de reputação uma única vez (e, segundo relatos do beta, 50 de Merchant's Favor): dois terços do caminho até Amigável. Caixotes cheios também vão para {npc:256386}, mas rendem só Merchant's Favor e pratas, nunca reputação.",
	-- ["{faction:2586} to Exalted"] = "{faction:2586} até Exaltado",
	-- ["{faction:2586} to Friendly"] = "{faction:2586} até Respeitado",
	-- ["{faction:2586} to Honored"] = "{faction:2586} até Honrado",
	-- ["{faction:2586} to Revered"] = "{faction:2586} até Reverenciado",
	-- ["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587} é a facção de profissões da Horda no Forever. O acampamento fica logo fora de {area:380}, em {zone:1413}. A partir do nível 10, monstros deixam cair Caixotes Extraviados: encha cada um com os produtos que a etiqueta pede e entregue o {object:1561} a Dokimi no acampamento por reputação e Merchant's Favor. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{faction:2587} to Exalted"] = "{faction:2587} até Exaltado",
	-- ["{faction:2587} to Friendly"] = "{faction:2587} até Respeitado",
	-- ["{faction:2587} to Honored"] = "{faction:2587} até Honrado",
	-- ["{faction:2587} to Revered"] = "{faction:2587} até Reverenciado",
}
