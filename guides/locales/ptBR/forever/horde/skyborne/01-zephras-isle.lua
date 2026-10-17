-- Portuguese (Brazil) (ptBR): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "Você acorda em {area:16635}, no norte da ilha. {npc:251362} fica junto ao caminho, e {npc:251361} no centro da aldeia.",

	-- Step 2: Thendal Grove
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "Cirromoscas Irritantes e {npc:250873} vagam pelo bosque logo a sudeste da aldeia.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "De volta a {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: um bilhete do seu instrutor",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}: examine {item:282418}",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "fale com {npc:257554}",

	-- Step 4: The watchtower
	["The watchtower"] = "A torre de vigia",
	-- {spell:1259416} Walk on Air
	["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "Suba a torre de vigia da aldeia, pule do topo e use {spell:1259416} para descer flutuando.",

	-- Step 5: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "As tarefas de {npc:251361}",

	-- Step 6: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "Pedras Eólicas Brutas",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "As Pedras Eólicas Brutas são cristais azuis nas encostas em volta da aldeia.",

	-- Step 8: The standing stones
	["The standing stones"] = "Os monólitos",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363} fica em {area:17678}, a leste da aldeia. {npc:251143} e Convertidos Al'Aketh se reúnem logo ao norte dela. {object:460001} fica logo a nordeste dela: lance sua habilidade racial {spell:1259686} ao lado.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "Lance {spell:1259686} perto de {object:460001}",

	-- Step 9: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "A rainha paira no extremo sudeste do bosque, no caminho de volta dos monólitos.",

	-- Step 10: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "Entregas em {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: leia {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, na torre de vigia",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, na torre de vigia",
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, at the village centre"] = "{npc:251374}, no centro da aldeia",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, o instrutor de druidas, no térreo da árvore atrás de {npc:251361}",

	-- Step 11: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374} stands in the village."] = "{npc:251374} fica na aldeia.",

	-- Step 12: Scrawny Ursera
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926} rondam as encostas a sudoeste da aldeia, no caminho para {npc:252095}.",

	-- Step 13: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095} espera em {area:16622}, a sudoeste da aldeia. O acampamento Al'Aketh fica logo depois dela; {npc:256935} o lidera.",

	-- Step 14: Signet of Akir
	-- {npc:252095} Hanaa Nightwind
	["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "Os sectários Al'Aketh no acampamento depois de {npc:252095} carregam o sinete.",

	-- Step 15: Urs'anah
	-- {npc:251115} Urs'anah
	["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "O covil dos Ursera fica a oeste da aldeia. {npc:251115}, a matriarca deles, fica no fundo.",

	-- Step 16: Leaving Thendal Village
	-- {area:16635} Thendal Village
	["Leaving {area:16635}"] = "Saindo de {area:16635}",

	-- Step 17: Call of Earth
	-- {npc:251374} Windshaper Boro · {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374} manda você para {area:16988}, logo a leste da aldeia: beba {item:6635} lá para ver {npc:251166} e depois leve {item:6656} de volta para ele.",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}: {npc:5873} e o seu {item:5175}",

	-- Step 18: Shen'dar Village
	-- {area:16624} Shen'dar Village
	["Follow the road south to {area:16624}, in the middle of the isle."] = "Siga a estrada para o sul até {area:16624}, no meio da ilha.",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "fale com {npc:251902}",

	-- Step 19: Raan Wildwind's campfire
	-- {npc:263664} Raan Wildwind
	["{npc:263664}'s campfire"] = "A fogueira de {npc:263664}",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest · {npc:251905} Zerril Softbreeze
	["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "Sente-se junto à fogueira de {npc:263664} (digite /sit) até receber o bônus {spell:1229451}, depois encontre {npc:251905} na fogueira de cozinhar.",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "Use /sentar junto à fogueira de {npc:263664} até receber {spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["talk to {npc:251905}"] = "fale com {npc:251905}",

	-- Step 20: Welcome to Shen'dar Village
	-- {npc:251902} Illaya Amberwind
	["Talk to {npc:251902}"] = "Fale com {npc:251902}",
	-- {npc:254089} Coriella Calmbreeze
	["Talk to {npc:254089}"] = "Fale com {npc:254089}",
	["the bounty board"] = "o quadro de recompensas",

	-- Step 21: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Garraltivas e Vagaventos",
	-- {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "Garraltivas e Vagaventos dividem os prados ao sul da aldeia. Guarde {item:5469} para {npc:251905}; os ovos vêm depois, dos hipogrifos.",

	-- Step 22: High Order Apprentices
	-- plural, as words: High Order Apprentices = {npc:257521} High Order Apprentice
	["High Order Apprentices"] = "Aprendizes da Alta Ordem",
	["The apprentices practise north-east of the village."] = "Os aprendizes treinam a nordeste da aldeia.",

	-- Step 23: The highland bandits
	["The highland bandits"] = "Os Bandidos do Planalto",
	["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Os acampamentos dos bandidos ficam a nordeste da aldeia; Bennic \"Malevento\" ocupa o acampamento mais alto. Os bandidos carregam as pedras eólicas roubadas.",

	-- Step 24: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "Entregas em {area:16624}",

	-- Step 25: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} espreita ao sul da aldeia, entre as Garraltivas. {npc:254589} é elite: recomenda-se formar grupo.",

	-- Step 26: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529} fica ao sul de Shen'dar. {npc:257065} encontra você na entrada; reviste o guarda-roupa na casa atrás dele.",
	["search the wardrobe"] = "revistar o guarda-roupa",

	-- Step 27: Constable Aonda
	-- {area:16624} Shen'dar Village
	["Back to {area:16624} with what you found."] = "Volte a {area:16624} com o que encontrou.",

	-- Step 28: Havoc in the Highlands
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "De volta a {quest:92529}: Tempestários e {npc:251662} enchem a aldeia, os Baús de Suprimentos ficam entre as casas e {npc:251966} espera no extremo sudeste.",

	-- Step 29: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "Siga para sudoeste até {area:17674}. {npc:252155} está no topo; {item:254871} está ao lado dele.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "fale com {npc:252155}",

	-- Step 30: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "Aanders e os guardas caídos estão logo a sudoeste da torre. Pegue a pena de Raani e o sinete Cantonegro dos corpos.",

	-- Step 31: Hippogryph nests
	["Hippogryph nests"] = "Ninhos de hipogrifo",
	-- {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	-- plural, as words: Small Eggs = {item:6889} Small Egg
	["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "Os ninhos de hipogrifo ficam a noroeste da torre, a oeste de {quest:92529}; a Matriarca fica no extremo oeste. {item:263493} fica no chão em volta deles, e os hipogrifos deixam cair os Ovos Pequenos.",

	-- Step 32: Shen'dar Village, last time
	-- {area:16624} Shen'dar Village
	["{area:16624}, last time"] = "{area:16624}, última vez",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "Ande para o norte até {area:16624}; se faltar {item:5469}, complete nos Vagaventos pelo caminho.",

	-- Step 33: To Valanaar
	-- {area:16638} Valanaar · {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "Pegue a estrada para sudeste até {area:16638}, a cidade dos Celonatos na costa sul. {npc:257006} e {npc:252448} ficam na borda oeste.",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Ouça a história de {npc:252448}",

	-- Step 34: Windsong Crawlers
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers"] = "Rastejantes Cantéolo",
	["The crawlers scuttle along the shore south-west of town."] = "Os rastejantes correm pela praia a sudoeste da cidade.",

	-- Step 36: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Saltacéus",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "Saltacéus saltitam pelos campos logo a oeste de Valennia.",

	-- Step 37: Ayessa Dawnsinger
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "fale com {npc:251968}",

	-- Step 38: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083} fica em {area:16626}, logo a noroeste da cidade.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "Ouça {npc:256083}",

	-- Step 39: Wind Hollows and Construct Parts
	-- {object:616467} Construct Parts (no name in this language: may be words)
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows and {object:616467}"] = "Abantesmas do Vento e {object:616467}",
	-- {area:16638} Valanaar · {object:616467} Construct Parts (no name in this language: may be words)
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "Abantesmas do Vento flutuam pelas planícies em volta de {area:16638}. As primeiras {object:616467} ficam a oeste da estrada do pomar.",

	-- Step 41: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663} fica a oeste de {area:16638}, pela estrada costeira.",
	-- {npc:252800} Aamelia Windfield
	["Talk to {npc:252800}"] = "Fale com {npc:252800}",

	-- Step 42: The orchard
	["The orchard"] = "O pomar",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "Maçãs-dos-raios e pó de asaleve estão espalhados pelo pomar; Bandidos Famintos o saqueiam. Vagaventos pastam nos campos a leste dele. O constructo quebrado flutua na borda norte do pomar.",

	-- Step 44: Bandit Highwaymen
	["Bandit Highwaymen"] = "Bandoleiros Bandidos",
	-- {object:616468} Construct Parts · {area:16638} Valanaar
	["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "Os bandoleiros ocupam as colinas a nordeste do pomar. Mais {object:616468} ficam perto da estrada para {area:16638}.",

	-- Step 45: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Diga a {npc:252800} que você está pronto",

	-- Step 46: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448} e {npc:256083}",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {item:15908} Taming Rod · {npc:254588} Windsong Crawler · {npc:251707} Ornery Galestrider · {npc:250874} Vuldren Alpha · {area:16663} Windfield Orchard · {npc:254411} Quel'dora Quickgale
	["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{npc:252389}, em {area:16638}, entrega a você um {item:15908} três vezes: dome um {npc:254588} junto aos lagos a noroeste da cidade, um {npc:251707} nos campos a oeste da cidade e um {npc:250874} em {area:16663}, voltando a ela após cada um. {npc:254411} fica ao lado dela.",

	-- Step 48: Belathaan Brightwish
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} espera na estrada ao norte de {area:16638}, na direção de {area:16629}.",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359} fica no lado leste de {area:16638}.",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Siga para nordeste até {area:17675}. O acampamento Al'Aketh fica logo a oeste, com {npc:252666} no extremo norte. Todo sectário pode deixar cair um amuleto de pedra eólica.",

	-- Step 52: Urs'endris
	-- {npc:255853} Urs'endris
	["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853} espera junto às cachoeiras logo ao norte da torre de vigia.",

	-- Step 53: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "De volta a {area:16638}",

	-- Step 54: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377} fica no meio de {area:16638}.",

	-- Step 55: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382} fica no lado oeste de {area:16638}.",

	-- Step 56: The turncoat
	["The turncoat"] = "O traidor",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "A casa do traidor fica em {area:16626}, a noroeste de {area:16638}. {npc:273017} espera por perto; seus assassinos espreitam em volta da casa.",
	["search the dead cultist in the house"] = "revistar o sectário morto na casa",

	-- Step 57: Ur'endra
	-- {npc:258443} Ur'endra
	["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443} vaga pelas encostas logo ao sul da casa do traidor.",

	-- Step 58: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "Leve a Tocha da Chama Latente para {npc:268592} no Shrine of Flames, a sudoeste de {area:16638}, em {area:16626}.",

	-- Step 59: Skypriest Faladiel
	-- {area:16638} Valanaar
	["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Faladiel fica na colina a oeste das cachoeiras, ao norte de {area:16638}.",

	-- Step 60: Kuramaa
	-- {npc:268592} Olariaan Swiftburn · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Volte a {npc:268592} e depois siga para oeste, entrando em {area:16623}: a casa de {npc:268605} fica nas colinas ao sul dos lagos dos Rastejantes Cantéolo.",

	-- Step 61: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "Volte a {npc:268592}. Espere ele acender {npc:268762} e leve a chama direto para {npc:268679} ao lado de {npc:252382} em {area:16638} antes que o tempo acabe.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {npc:2523}, o seu {item:5176} e {item:263412}",

	-- Step 62: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "fale com {npc:252476}",

	-- Step 63: Desperate Times
	-- {npc:252383} Valennia Stormfist
	["Talk to {npc:252383}"] = "Fale com {npc:252383}",
	-- {npc:251968} Ayessa Dawnsinger
	["Talk to {npc:251968}"] = "Fale com {npc:251968}",
	-- {npc:252383} Valennia Stormfist
	["talk to {npc:252383}"] = "fale com {npc:252383}",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris
	["On the way north, back to {npc:255853} by the falls."] = "No caminho para o norte, volte a {npc:255853} junto às cachoeiras.",

	-- Step 65: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629} fica ao norte de {area:16638}. Abra caminho entre os guardas até {npc:253576}, no lado leste.",
	-- {npc:253576} Hyusaa Quickbreeze
	["Talk to {npc:253576}"] = "Fale com {npc:253576}",

	-- Step 66: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196} guarda {item:263993} no lado oeste do santuário.",

	-- Step 67: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "Siga para o norte, entrando em {area:16631}; {npc:257944} acampa na borda sul.",

	-- Step 68: Shadowgale Forest
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105} cresce em volta do acampamento de {npc:257944}, e Shriekings voam sobre ele. O acampamento Al'Aketh a leste dela guarda {item:265141}.",

	-- Step 69: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "{npc:257944} de novo",

	-- Step 70: The Al'Aketh camp
	["The Al'Aketh camp"] = "O acampamento Al'Aketh",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130} e {npc:258134} estão no acampamento do culto a leste de {npc:257944}. {npc:254151} fica na borda. Haalien também deixa cair {quest:94490}: leia para iniciar a próxima missão. Para {quest:94489}, entre no Nightfang Den, cure 7 druidas feridos e encontre {npc:258130}.",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Encontre {npc:258130}",
	["Heal the injured druids in the Nightfang Den"] = "Cure os druidas feridos no Nightfang Den",

	-- Step 71: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "{npc:257944}, última vez",

	-- Step 72: Windsong Lake
	-- {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Os pertences dos refugiados estão ao longo da margem norte de {area:16625}; {npc:259013} fica no extremo noroeste.",

	-- Step 73: The Strange Hermit
	-- {area:16625} Windsong Lake · {item:257128} Zephyrseed
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "O eremita mora na margem oeste de {area:16625}. Pinhas de {item:257128} crescem ao sul dele; as Abantesmas do Vento flutuam a leste do lago.",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "fale com {npc:251684}",

	-- Step 74: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {npc:251968} Ayessa Dawnsinger
	["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "Pegue o portal até {area:16630} e junte-se a {npc:252475} e {npc:251968} contra a Alta-sacerdotisa.",

	-- Step 77: The airship
	["The airship"] = "O dirigível",
	-- {area:16638} Valanaar · {zone:1412} Mulgore
	["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "O dirigível da Horda atraca na borda sudoeste de {area:16638}. Embarque nele até Kalimdor; ele pousa no norte de {zone:1412}.",
	["Horde airship"] = "Dirigível da Horda",

	-- Step 78: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "Norte de {zone:1412}",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "Você deixa a ilha de vez. {npc:259119} espera onde o dirigível pousa.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}: guarde-a, Thrall em {zone:1454} vem dois guias depois",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}, junto ao pouso: para {npc:3033} em {zone:1456}",

	-- Step 79: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638} fica ao lado do pouso: suba por um elevador e aprenda a rota de voo com {npc:2995}, o mestre de mantícoras.",

	-- Step 80: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} quer incenso tauren: compre as quatro partes de {npc:3014}, a herborista, {npc:3012}, a fornecedora de encantamento, {npc:3005}, o fornecedor de couraria, e {npc:3027}, o fornecedor de culinária, depois combine-as em {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, de {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, de {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, de {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, de {npc:3027}",

	-- Step 81: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Use {item:278078} no tapete cerimonial e no incensário do penhasco voltado para o sul em {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Espalhe {item:278078} a partir de {area:1641}",

	-- Step 83: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033} treina druidas em {area:1639}. Ele ensina {spell:18960}; as boas-vindas de {npc:11802} esperam sua viagem com {spell:499}, por volta do nível 23 (forever/horde/04-the-barrens).",

	-- Step 84: The Crossroads
	-- {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {zone:1413} Barrens · {area:458} Gold Road · {area:380} The Crossroads
	["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Saia de {zone:1456} por um elevador e siga a estrada para o sul passando por {area:222} e pelo desfiladeiro leste até {zone:1413}; do desfiladeiro, pegue {area:458} para o norte até a {area:380}, a cidade da Horda no meio de {zone:1413}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre de mantícoras",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
}
