-- Portuguese (Brazil) (ptBR): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "Você acorda em {area:16635}, no norte da ilha. {npc:251362} fica junto ao caminho, e {npc:251361} no centro da aldeia.",

	-- Step 2: Thendal Grove: kill these as you meet them
	-- {area:16622} Thendal Grove
	["{area:16622}: kill these as you meet them"] = "{area:16622}: vá matando estes pelo caminho",
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "Cirromoscas Irritantes e {npc:250873} vagam pelo bosque logo a sudeste da aldeia.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "De volta a {area:16635}",
	-- {npc:257554} Halaan Hawk-Eye · {npc:263113} Myriaal Mistwake · {npc:251368} Elatrell Featherlight
	["{npc:257554} and {npc:263113} stand at the top of the watchtower, a few steps north-east of {npc:251368}."] = "{npc:257554} e {npc:263113} ficam no alto da torre de vigia, a poucos passos a nordeste de {npc:251368}.",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "fale com {npc:257554}",

	-- Step 4: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "As tarefas de {npc:251361}",
	-- {spell:1259416} Walk on Air · {npc:251361} Rorian the Dayseeker
	["Jump off the top of the watchtower and use {spell:1259416} to float down to {npc:251361}, west of the tower."] = "Pule do alto da torre de vigia e use {spell:1259416} para descer flutuando até {npc:251361}, a oeste da torre.",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: um bilhete do seu instrutor",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}: examine {item:282418}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: leia {item:9547}",
	-- {npc:251374} Windshaper Boro · {npc:251361} Rorian the Dayseeker
	["{npc:251374}, beside {npc:251361}"] = "{npc:251374}, ao lado de {npc:251361}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, o instrutor de druidas, no térreo da árvore atrás de {npc:251361}",
	-- {npc:251373} Xyton Silverwind
	["Boro and {npc:251373}, while you stand beside them"] = "Boro e {npc:251373}, já que você está ali do lado",

	-- Step 5: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "Pedras Eólicas Brutas",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "As Pedras Eólicas Brutas são cristais azuis nas encostas em volta da aldeia.",

	-- Step 7: The standing stones
	["The standing stones"] = "Os monólitos",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363} fica em {area:17678}, a leste da aldeia. {npc:251143} e Convertidos Al'Aketh se reúnem logo ao norte dela. {object:460001} fica logo a nordeste dela: lance sua habilidade racial {spell:1259686} ao lado.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "Lance {spell:1259686} perto de {object:460001}",

	-- Step 8: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "A rainha paira no extremo sudeste do bosque, no caminho de volta dos monólitos.",

	-- Step 9: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "Entregas em {area:16635}",
	-- {npc:251376} Tai'ree Farsight · {npc:251361} Rorian the Dayseeker
	["{npc:251376}, beside {npc:251361}"] = "{npc:251376}, ao lado de {npc:251361}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, na torre de vigia",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, na torre de vigia",

	-- Step 10: Thendal Grove: kill these as you meet them
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind · {npc:251115} Urs'anah
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}.\nThe Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "{npc:250926} rondam as encostas a sudoeste da aldeia, no caminho até {npc:252095}.\nA toca dos Ursera fica a oeste da aldeia. {npc:251115}, a matriarca, espera lá no fundo.",
	["Below ground"] = "No subterrâneo",

	-- Step 11: Back to Thendal Village
	-- {npc:257551} Valreaa Valewind · {npc:251366} Aetheen of the Gales · {npc:252095} Hanaa Nightwind
	["Back up from the den to {npc:257551} and {npc:251366} in the village before heading south-west to {npc:252095}: the road from her camp leads on south to Shen'dar."] = "Suba de volta do covil até {npc:257551} e {npc:251366}, na aldeia, antes de seguir para o sudoeste, rumo a {npc:252095}: a estrada que sai do acampamento dela segue para o sul, até Shen'dar.",

	-- Step 12: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it.\nCareful: {npc:256935} casts shocks; drag him clear of the other cultists before fighting so they don't join in."] = "{npc:252095} espera em {area:16622}, a sudoeste da aldeia. O acampamento Al'Aketh fica logo depois dela; quem manda lá é {npc:256935}.\nCuidado: {npc:256935} solta choques; puxe-o para longe dos outros sectários antes de lutar, senão eles entram na briga.",
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["{item:251924}: the Al'Aketh in {npc:252095}'s camp carry it"] = "{item:251924}: os Al'Aketh no acampamento perto de {npc:252095} carregam um",

	-- Step 13: Windshaper Boro
	-- {area:16635} Thendal Village
	["Back to Boro in {area:16635} with the Signet."] = "De volta a Boro em {area:16635} com o Sinete.",
	-- {item:6635} Earth Sapta · {area:16988} Rise of Spirits · {npc:251166} Minor Manifestation of Earth
	["drink the {item:6635} at the {area:16988}, just east of the village, to see the {npc:251166}"] = "beba {item:6635} em {area:16988}, logo a leste da aldeia, para ver {npc:251166}",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}: {npc:5873} e o seu {item:5175}",

	-- Step 14: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:251523} Constable Aonda · {npc:251902} Illaya Amberwind · {npc:254089} Coriella Calmbreeze · {npc:263664} Raan Wildwind
	["Follow the road south to {area:16624}, in the middle of the isle. {npc:251523} stands on its east side, {npc:251902} in the middle, {npc:254089} just north-west of her, {npc:263664} by the campfire on the west side."] = "Siga a estrada para o sul até {area:16624}, no meio da ilha. {npc:251523} fica no lado leste, {npc:251902} no meio, {npc:254089} logo a noroeste dela, {npc:263664} junto à fogueira no lado oeste.",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "fale com {npc:251902}",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "Use /sentar junto à fogueira de {npc:263664} até receber {spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["{npc:251905}: Camping 101 asks you to learn it"] = "{npc:251905}: Introdução ao acampamento pede que você aprenda",

	-- Step 15: Shen'dar Village: kill these as you meet them
	-- {area:16624} Shen'dar Village
	["{area:16624}: kill these as you meet them"] = "{area:16624}: vá matando estes pelo caminho",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw · Small Eggs = {item:6889} Small Egg
	["Prideclaws and Galestriders share the meadows around {area:16624}; the Galestriders graze thickest just west of it. They drop both the Small Eggs and the {item:5469} for {npc:251905}."] = "As Garraltivas e os Vagaventos dividem as campinas em volta de {area:16624}; os Vagaventos são mais numerosos logo a oeste dela. Eles deixam cair tanto os Ovos Pequenos quanto {item:5469} para {npc:251905}.",

	-- Step 16: Shen'dar Village hand-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} hand-ins"] = "Entregas em {area:16624}",
	-- {npc:251905} Zerril Softbreeze · {npc:251906} Teeri Wellwind · {npc:251991} Taleen Shimmerthread · {npc:252172} Danarii Bellowveil · {npc:251523} Constable Aonda · {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["{npc:251905}, {npc:251906}, {npc:251991}, {npc:252172} and {npc:251523} all stand in {area:16624}. If you are still short of {item:5469}, the Galestriders graze just south of the village."] = "{npc:251905}, {npc:251906}, {npc:251991}, {npc:252172} e {npc:251523} estão todos em {area:16624}. Se ainda faltar {item:5469}, os Vagaventos pastam logo ao sul da aldeia.",

	-- Step 17: Shen'dar Highlands: kill these as you meet them
	-- {area:16623} Shen'dar Highlands
	["{area:16623}: kill these as you meet them"] = "{area:16623}: vá matando estes pelo caminho",
	["The apprentices practise north-east of the village.\nThe bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Os aprendizes treinam a nordeste da aldeia.\nOs acampamentos de bandidos ficam a nordeste da aldeia; Bennic \"Malevento\" manda no acampamento lá de cima. São os bandidos que estão com as pedras eólicas roubadas.",

	-- Step 18: Shen'dar bounty board
	["Shen'dar bounty board"] = "Quadro de recompensas de Shen'dar",
	["the bounty board"] = "o quadro de recompensas",

	-- Step 19: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "Entregas em {area:16624}",

	-- Step 20: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} espreita ao sul da aldeia, entre as Garraltivas. {npc:254589} é elite: recomenda-se formar grupo.",

	-- Step 21: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529} fica ao sul de Shen'dar. {npc:257065} encontra você na entrada; reviste o guarda-roupa na casa atrás dele.",
	["search the wardrobe"] = "revistar o guarda-roupa",

	-- Step 22: Constable Aonda
	-- {npc:251523} Constable Aonda · {area:16624} Shen'dar Village
	["{npc:251523} waits in {area:16624} for what you found in the wardrobe."] = "{npc:251523} espera em {area:16624} pelo que você achou no guarda-roupa.",

	-- Step 23: Shen'dar Highlands: kill these as you meet them
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "De volta a {quest:92529}: Tempestários e {npc:251662} enchem a aldeia, os Baús de Suprimentos ficam entre as casas e {npc:251966} espera no extremo sudeste.",

	-- Step 25: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "Siga para sudoeste até {area:17674}. {npc:252155} está no topo; {item:254871} está ao lado dele.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "fale com {npc:252155}",

	-- Step 26: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "Aanders e os guardas caídos estão logo a sudoeste da torre. Pegue a pena de Raani e o sinete Cantonegro dos corpos.",

	-- Step 27: Shen'dar Highlands: kill these as you meet them
	-- {area:17674} West Pylon Watchtower · {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	["The hippogryph nests are north-west of the {area:17674}, west of {quest:92529}. The Matriarch sits at their western end; {item:263493} lies on the ground around the nests."] = "Os ninhos de hipogrifo ficam a noroeste de {area:17674}, a oeste de {quest:92529}. A Matriarca fica na ponta oeste; {item:263493} está no chão em volta dos ninhos.",

	-- Step 29: Fendaal Windstone
	-- {area:16638} Valanaar · {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["On the road south-east to {area:16638}, {npc:273017} watches the {quest:98512} just north of him."] = "Na estrada para sudeste até {area:16638}, {npc:273017} vigia {quest:98512}, logo ao norte dele.",

	-- Step 30: Valanaar
	-- {npc:252476} Talaanis Shadowsong
	["{npc:252476}, upstairs"] = "{npc:252476}, no andar de cima",
	-- {npc:252383} Valennia Stormfist
	["{npc:252383}, upstairs"] = "{npc:252383}, no andar de cima",

	-- Step 31: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "De volta a {area:16638}",

	-- Step 32: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Saltacéus",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "Saltacéus saltitam pelos campos logo a oeste de Valennia.",

	-- Step 33: Ayessa Dawnsinger
	-- {npc:260628} Valennia Stormfist
	["{npc:260628}, upstairs"] = "{npc:260628}, no andar de cima",
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "fale com {npc:251968}",
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {quest:97243} Call of Fire
	["{npc:252382}, beside {npc:251968}: {quest:97243}"] = "{npc:252382}, ao lado de {npc:251968}: {quest:97243}",

	-- Step 34: Nyalah Brightfire and Alvarion Windfield
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["{npc:257006} and {npc:252448}"] = "{npc:257006} e {npc:252448}",
	-- {npc:257006} Nyalah Brightfire · {area:16638} Valanaar · {npc:252448} Alvarion Windfield
	["{npc:257006} waits inside a house on {area:16638}'s western edge; {npc:252448} is close by."] = "{npc:257006} espera dentro de uma casa na borda oeste de {area:16638}; {npc:252448} está ali pertinho.",
	-- {npc:255940} Donaal Downbreeze
	["Innkeeper {npc:255940}, by the west gate"] = "Estalajadeiro {npc:255940}, junto ao portão oeste",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Ouça a história de {npc:252448}",
	-- {npc:252389} Quel'ana Quickgale · {npc:257006} Nyalah Brightfire · {quest:94978} Taming the Beast
	["{npc:252389}, a few steps west of {npc:257006}: {quest:94978}, the first rod"] = "{npc:252389}, a poucos passos a oeste de {npc:257006}: {quest:94978}, o primeiro bastão",
	-- {npc:257006} Nyalah Brightfire
	["{npc:257006}, inside"] = "{npc:257006}, lá dentro",

	-- Step 35: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083} fica em {area:16626}, logo a noroeste da cidade.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "Ouça {npc:256083}",
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {quest:94003} The Skybreaker Bulwark
	["{npc:252377}, beside {npc:256083}: {quest:94003}"] = "{npc:252377}, ao lado de {npc:256083}: {quest:94003}",

	-- Step 36: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663} fica a oeste de {area:16638}, pela estrada costeira.",

	-- Step 37: The orchard
	["The orchard"] = "O pomar",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "Maçãs-dos-raios e pó de asaleve estão espalhados pelo pomar; Bandidos Famintos o saqueiam. Vagaventos pastam nos campos a leste dele. O constructo quebrado flutua na borda norte do pomar.",
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple
	["Ripe Stormapples"] = "Maçãs-dos-raios Maduras",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Hungry Bandits"] = "Bandidos Famintos",
	-- {npc:268592} Olariaan Swiftburn
	["{npc:268592}, at the Shrine of Flames just south-east of the orchard"] = "{npc:268592}, no Shrine of Flames, logo a sudeste do pomar",

	-- Step 39: Gustberry Lowlands: kill these as you meet them
	-- {area:16626} Gustberry Lowlands
	["{area:16626}: kill these as you meet them"] = "{area:16626}: vá matando estes pelo caminho",
	-- {area:16663} Windfield Orchard
	-- plural, as words: Blood-Stained Bandit Masks = {item:253596} Blood-Stained Bandit Mask
	["The Highwayman Bandits hold the hills north of {area:16663}; they drop the Blood-Stained Bandit Masks."] = "Os Bandoleiros Bandidos tomaram as colinas ao norte de {area:16663}; são eles que deixam cair as Máscaras de Bandido Manchadas de Sangue.",

	-- Step 40: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Diga a {npc:252800} que você está pronto",

	-- Step 41: Shen'dar Highlands: kill these as you meet them
	-- {item:260881} Crystallized Lightning · {npc:256083} Riaani Nightwind
	["The {item:260881} lies in a cave in the hills north-west of {npc:256083}."] = "{item:260881} está numa caverna nas colinas a noroeste de {npc:256083}.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["tame one with {npc:252389}'s first {item:15908} while you are among them"] = "dome um com o primeiro {item:15908} de {npc:252389} enquanto estiver no meio deles",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Dome {npc:254588}",

	-- Step 42: Enchanted Gyrozephyr
	-- {area:16624} Shen'dar Village · {area:16625} Windsong Lake
	-- plural, as words: Enchanted Gyrozephyrs = {item:260883} Enchanted Gyrozephyr
	["The Enchanted Gyrozephyrs lie under water far to the north, east of {area:16624} and south-west of {area:16625}."] = "Os Girozéfiros Encantados estão debaixo d'água, bem ao norte, a leste de {area:16624} e a sudoeste de {area:16625}.",
	["Underwater"] = "Debaixo d'água",

	-- Step 43: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448} e {npc:256083}",

	-- Step 44: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 45: Warlock trainer
	["Warlock trainer"] = "Instrutor de bruxo",
	-- {npc:2127} Rupert Boch · {zone:1420} Tirisfal Glades · {area:16638} Valanaar
	["{npc:2127} in {zone:1420}; {area:16638} has no warlock trainer"] = "{npc:2127} em {zone:1420}; {area:16638} não tem instrutor de bruxo",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod · {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider · Vuldren Alphas = {npc:250874} Vuldren Alpha
	["{npc:252389} takes back the first {item:15908} and hands you two more, one at a time: Ornery Galestriders and Vuldren Alphas roam the fields just north of her. Tame each with its rod and bring the rod back to her. {npc:254411}, beside her, teaches {spell:5149}."] = "{npc:252389} pega de volta o primeiro {item:15908} e entrega mais dois, um de cada vez: Vagaventos Turrões e Vuldrens Alfa andam pelos campos logo ao norte dela. Dome cada um com o seu bastão e devolva o bastão a ela. {npc:254411}, ao lado dela, ensina {spell:5149}.",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Dome {npc:251707}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Dome {npc:250874}",

	-- Step 48: Ayessa Dawnsinger
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} espera na estrada ao norte de {area:16638}, na direção de {area:16629}.",

	-- Step 49: Valennia Stormfist
	["Upstairs"] = "No andar de cima",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["{npc:252359} stands on {area:16638}'s east side. {npc:255853} waits by the falls just north of the {area:17675}: leave town to the north, climb the ridge east of the road and glide down to him with {spell:1259416}."] = "{npc:252359} fica no lado leste de {area:16638}. {npc:255853} espera junto à cachoeira logo ao norte de {area:17675}: saia da cidade pelo norte, suba a crista a leste da estrada e plane até ele com {spell:1259416}.",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Head north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Siga para nordeste até {area:17675}. O acampamento Al'Aketh fica logo a oeste dela, com {npc:252666} na ponta norte. Qualquer sectário pode deixar cair um amuleto de pedra eólica.",
	-- {npc:268602} Skypriest Faladiel
	["{npc:268602}, on the hill west of the falls just north of the watchtower"] = "{npc:268602}, na colina a oeste da cachoeira, logo ao norte da torre de vigia",

	-- Step 53: The turncoat
	["The turncoat"] = "O traidor",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}, just north of {npc:273017}."] = "A casa do vira-casaca fica em {area:16626}, a noroeste de {area:16638}, logo ao norte de {npc:273017}.",
	["search the dead cultist in the house"] = "revistar o sectário morto na casa",
	-- {npc:253372} Dead Cultist
	["{npc:253372}, inside"] = "{npc:253372}, lá dentro",

	-- Step 54: Ur'endra
	-- {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:258443} has her lair in a cave in the bluffs just south of the turncoat's house, where the {area:16623} meet the {area:16626}."] = "{npc:258443} tem o covil numa caverna nos penhascos logo ao sul da casa do traidor, onde {area:16623} encontra {area:16626}.",

	-- Step 56: Olariaan Swiftburn
	-- {item:277267} Faladiel's Heart · {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take {item:277267} to {npc:268592} at the Shrine of Flames, south-west of {area:16638}, then head west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Leve {item:277267} para {npc:268592} no Shrine of Flames, a sudoeste de {area:16638}, e depois siga para oeste em {area:16623}: a casa de {npc:268605} fica nas colinas ao sul dos lagos dos Rastejantes Cantéolo.",

	-- Step 57: Zephras Isle
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",

	-- Step 58: The Eternal Flame
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "Volte a {npc:268592}. Espere ele acender {npc:268762} e leve a chama direto para {npc:268679} ao lado de {npc:252382} em {area:16638} antes que o tempo acabe.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {npc:2523}, o seu {item:5176} e {item:263412}",

	-- Step 59: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "fale com {npc:252476}",

	-- Step 62: Desperate Times
	-- {npc:253844} Valennia Stormfist
	["talk to {npc:253844}"] = "fale com {npc:253844}",

	-- Step 63: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196} guarda {item:263993} no lado oeste do santuário.",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:17675} East Pylon Watchtower · {spell:1259416} Walk on Air
	["On your way north from Valennia, {npc:255853} waits by the falls north-east of you, just north of the {area:17675}: from the ridge above them, glide down with {spell:1259416}."] = "Subindo para o norte depois de Valennia, {npc:255853} espera junto à cachoeira a nordeste, logo ao norte de {area:17675}: da crista acima dela, plane até lá com {spell:1259416}.",

	-- Step 65: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "Siga para o norte, entrando em {area:16631}; {npc:257944} acampa na borda sul.",

	-- Step 66: Shadowgale Forest: kill these as you meet them
	-- {area:16631} Shadowgale Forest
	["{area:16631}: kill these as you meet them"] = "{area:16631}: vá matando estes pelo caminho",
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105} cresce em volta do acampamento de {npc:257944}, e Shriekings voam sobre ele. O acampamento Al'Aketh a leste dela guarda {item:265141}.",

	-- Step 67: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "{npc:257944} de novo",

	-- Step 68: The Al'Aketh camp
	["The Al'Aketh camp"] = "O acampamento Al'Aketh",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130} e {npc:258134} estão no acampamento do culto a leste de {npc:257944}. {npc:254151} fica na borda. Haalien também deixa cair {quest:94490}: leia para iniciar a próxima missão. Para {quest:94489}, entre no Nightfang Den, cure 7 druidas feridos e encontre {npc:258130}.",
	["Heal the injured druids in the Nightfang Den"] = "Cure os druidas feridos no Nightfang Den",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Encontre {npc:258130}",

	-- Step 69: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "{npc:257944}, última vez",

	-- Step 70: The Strange Hermit
	-- {area:16625} Windsong Lake
	["The hermit lives at {area:16625}'s west shore."] = "O eremita mora na margem oeste de {area:16625}.",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "fale com {npc:251684}",

	-- Step 71: Windsong Lake
	-- {item:257128} Zephyrseed · {npc:254344} Endaria Mistgaze · {quest:93736} Unwelcome Spirits · {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow · Wind Hollow Essences = {item:262357} Wind Hollow Essence
	["{item:257128} cones grow south of the hermit; the Wind Hollows drift east of the lake and also drop the Wind Hollow Essences for {npc:254344}'s {quest:93736}. The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Os cones de {item:257128} crescem ao sul do eremita; os Abantesmas do Vento vagam a leste do lago e também deixam cair as Essências de Abantesma do Vento para {quest:93736}, de {npc:254344}. Os pertences dos refugiados ficam ao longo da margem norte de {area:16625}; {npc:259013} está na ponta noroeste dela.",

	-- Step 73: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629} fica ao norte de {area:16638}. Abra caminho entre os guardas até {npc:253576}, no lado leste.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, upstairs"] = "{npc:253590}, no andar de cima",

	-- Step 74: Portal to Rohashi Spires
	-- {area:16630} Rohashi Spires
	["Portal to {area:16630}"] = "Portal para {area:16630}",

	-- Step 75: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {object:617084} Portal to Valanaar (no name in this language: may be words)
	["Take the Portal to {area:16630} in the shrine up to the heights. Fight east along the ledge to the Peacekeepers at its end, ride the wind current up to the upper terrace and tell {npc:252475} you are ready. Leave the {object:617084} up there alone until Rohash has withdrawn; then it takes you straight back to town."] = "Pegue o Portal para {area:16630} no santuário até as alturas. Lute para leste ao longo da saliência até os Pacificadores no fim dela, suba a corrente de vento até o terraço superior e diga a {npc:252475} que você está pronto. Deixe {object:617084} lá em cima em paz até Rohash se retirar; depois ele leva você direto de volta à cidade.",

	-- Step 76: The Fate of Zephras
	-- {npc:254344} Endaria Mistgaze · {npc:251968} Ayessa Dawnsinger
	["{npc:254344}, beside {npc:251968}"] = "{npc:254344}, ao lado de {npc:251968}",

	-- Step 77: Seena Skybreaker
	-- {npc:252377} Seena Skybreaker · {npc:256083} Riaani Nightwind · {area:16638} Valanaar
	["{npc:252377} stands beside {npc:256083}, just north-west of {area:16638}."] = "{npc:252377} fica ao lado de {npc:256083}, logo a noroeste de {area:16638}.",

	-- Step 78: Valanaar
	-- {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {zone:1412} Mulgore · {npc:259119} Alaana Stormwalker
	["{npc:251968} sends you on to Kalimdor. Once you have trained, board the skycutter at the dock on {area:16638}'s south-west edge: it flies to northern {zone:1412}, where {npc:259119} waits."] = "{npc:251968} manda você seguir para Kalimdor. Depois de treinar, embarque no barco celeste no cais da borda sudoeste de {area:16638}: ela voa até o norte de {zone:1412}, onde {npc:259119} espera.",

	-- Step 81: Leave Zephras Isle to Mulgore
	-- {zone:2521} Zephras Isle · {zone:1412} Mulgore
	["Leave {zone:2521} to {zone:1412}"] = "Saia de {zone:2521} rumo a {zone:1412}",

	-- Step 82: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "Norte de {zone:1412}",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "Você deixa a ilha de vez. {npc:259119} espera onde o dirigível pousa.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it: Thrall in {zone:1454}, at the start of the next guide"] = "{npc:259119}: guarde: Thrall em {zone:1454}, no início do próximo guia",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}, junto ao pouso: para {npc:3033} em {zone:1456}",

	-- Step 83: Clarice Foster
	-- {npc:5543} Clarice Foster · {area:2197} Pools of Vision · {area:1640} Spirit Rise
	["{npc:5543} stands in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart."] = "{npc:5543} fica em {area:2197}, a caverna sob {area:1640}: desça por dentro, a seta não distingue os andares.",

	-- Step 85: Traditions of the Bluff
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

	-- Step 86: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 21 (forever/horde/02-the-barrens)."] = "{npc:3033} treina druidas em {area:1639}. Ele ensina {spell:18960}; as boas-vindas de {npc:11802} esperam sua viagem com {spell:499}, por volta do nível 21 (forever/horde/02-the-barrens).",

	-- Step 87: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Use {item:278078} no tapete cerimonial e no incensário do penhasco voltado para o sul em {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Espalhe {item:278078} a partir de {area:1641}",

	-- Step 89: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:199} com {npc:11869} (10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 90: Ansekhwa
	-- {npc:11869} Ansekhwa
	["While you're here: learn Staves from {npc:11869} (10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Cajados com {npc:11869} (10 pratas); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 91: Into Mulgore
	-- {zone:1412} Mulgore
	["Into {zone:1412}"] = "Rumo a {zone:1412}",

	-- Step 92: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "Rumo a {zone:1413}",

	-- Step 94: The Crossroads
	-- {npc:3615} Devrak · {area:380} The Crossroads · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Learn the flight path from {npc:3615} on the tower platform. {area:380}' own quests come after {zone:1421}, in the {zone:1413} guide."] = "Aprenda a rota de voo com {npc:3615} na plataforma da torre. As missões próprias de {area:380} vêm depois de {zone:1421}, no guia de {zone:1413}.",

	-- Step 95: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "Até {zone:1454}",
	-- {area:379} Far Watch Post · {area:815} Southfury River · {zone:1411} Durotar · {zone:1454} Orgrimmar · {quest:95350} Welcome to Azeroth · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["From the Crossroads follow the road north-east to {area:379}, cross the {area:815} into {zone:1411} and keep north to {zone:1454}'s main gate. The next guide starts in {zone:1454}: Thrall takes {quest:95350}, and the zeppelin leaves for {zone:1420} and {zone:1421}."] = "Da Encruzilhada, siga a estrada para nordeste até {area:379}, atravesse {area:815} para {zone:1411} e continue ao norte até o portão principal de {zone:1454}. O próximo guia começa em {zone:1454}: Thrall oferece {quest:95350}, e o zepelim parte para {zone:1420} e {zone:1421}.",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16624} with what you found."] = "Volte a {area:16624} com o que encontrou.",
	-- ["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Volte a {npc:268592} e depois siga para oeste, entrando em {area:16623}: a casa de {npc:268605} fica nas colinas ao sul dos lagos dos Rastejantes Cantéolo.",
	-- ["Bandit Highwaymen"] = "Bandoleiros Bandidos",
	-- ["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "Suba a torre de vigia da aldeia, pule do topo e use {spell:1259416} para descer flutuando.",
	-- ["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Faladiel fica na colina a oeste das cachoeiras, ao norte de {area:16638}.",
	-- ["Follow the road south to {area:16624}, in the middle of the isle."] = "Siga a estrada para o sul até {area:16624}, no meio da ilha.",
	-- ["High Order Apprentices"] = "Aprendizes da Alta Ordem",
	-- ["Hippogryph nests"] = "Ninhos de hipogrifo",
	-- ["Horde airship"] = "Dirigível da Horda",
	-- ["Into {area:17}"] = "Rumo a {area:17}",
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Saia de {zone:1456} por um elevador e siga a estrada para o sul passando por {area:222} e pelo desfiladeiro leste até {zone:1413}; do desfiladeiro, pegue {area:458} para o norte até a {area:380}, a cidade da Horda no meio de {zone:1413}.",
	-- ["Leaving {area:16635}"] = "Saindo de {area:16635}",
	-- ["On the way north, back to {npc:255853} by the falls."] = "No caminho para o norte, volte a {npc:255853} junto às cachoeiras.",
	-- ["Prideclaws and Galestriders"] = "Garraltivas e Vagaventos",
	-- ["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "Garraltivas e Vagaventos dividem os prados ao sul da aldeia. Guarde {item:5469} para {npc:251905}; os ovos vêm depois, dos hipogrifos.",
	-- ["Prideclaws and Galestriders share the meadows south of {area:16624}. The Galestriders drop both the Small Eggs and the {item:5469} for {npc:251905}."] = "Garraltivas e Vagaventos dividem os prados ao sul de {area:16624}. Os Vagaventos deixam cair tanto os Ovos Pequenos quanto {item:5469} para {npc:251905}.",
	-- ["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Siga para nordeste até {area:17675}. O acampamento Al'Aketh fica logo a oeste, com {npc:252666} no extremo norte. Todo sectário pode deixar cair um amuleto de pedra eólica.",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
	-- ["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "Sente-se junto à fogueira de {npc:263664} (digite /sit) até receber o bônus {spell:1229451}, depois encontre {npc:251905} na fogueira de cozinhar.",
	-- ["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "Leve a Tocha da Chama Latente para {npc:268592} no Shrine of Flames, a sudoeste de {area:16638}, em {area:16626}.",
	-- ["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "Pegue o portal até {area:16630} e junte-se a {npc:252475} e {npc:251968} contra a Alta-sacerdotisa.",
	-- ["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "Pegue a estrada para sudeste até {area:16638}, a cidade dos Celonatos na costa sul. {npc:257006} e {npc:252448} ficam na borda oeste.",
	-- ["Talk to {npc:251902}"] = "Fale com {npc:251902}",
	-- ["Talk to {npc:251968}"] = "Fale com {npc:251968}",
	-- ["Talk to {npc:252383}"] = "Fale com {npc:252383}",
	-- ["Talk to {npc:252800}"] = "Fale com {npc:252800}",
	-- ["Talk to {npc:253576}"] = "Fale com {npc:253576}",
	-- ["Talk to {npc:254089}"] = "Fale com {npc:254089}",
	-- ["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "Os sectários Al'Aketh no acampamento depois de {npc:252095} carregam o sinete.",
	-- ["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "O dirigível da Horda atraca na borda sudoeste de {area:16638}. Embarque nele até Kalimdor; ele pousa no norte de {zone:1412}.",
	-- ["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "O covil dos Ursera fica a oeste da aldeia. {npc:251115}, a matriarca deles, fica no fundo.",
	-- ["The airship"] = "O dirigível",
	-- ["The apprentices practise north-east of the village."] = "Os aprendizes treinam a nordeste da aldeia.",
	-- ["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Os acampamentos dos bandidos ficam a nordeste da aldeia; Bennic \"Malevento\" ocupa o acampamento mais alto. Os bandidos carregam as pedras eólicas roubadas.",
	-- ["The crawlers scuttle along the shore south-west of town."] = "Os rastejantes correm pela praia a sudoeste da cidade.",
	-- ["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "O eremita mora na margem oeste de {area:16625}. Pinhas de {item:257128} crescem ao sul dele; as Abantesmas do Vento flutuam a leste do lago.",
	-- ["The highland bandits"] = "Os Bandidos do Planalto",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "Os bandoleiros ocupam as colinas a nordeste do pomar. Mais {object:616468} ficam perto da estrada para {area:16638}.",
	-- ["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "Os ninhos de hipogrifo ficam a noroeste da torre, a oeste de {quest:92529}; a Matriarca fica no extremo oeste. {item:263493} fica no chão em volta deles, e os hipogrifos deixam cair os Ovos Pequenos.",
	-- ["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Os pertences dos refugiados estão ao longo da margem norte de {area:16625}; {npc:259013} fica no extremo noroeste.",
	-- ["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "A casa do traidor fica em {area:16626}, a noroeste de {area:16638}. {npc:273017} espera por perto; seus assassinos espreitam em volta da casa.",
	-- ["The watchtower"] = "A torre de vigia",
	-- ["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "Ande para o norte até {area:16624}; se faltar {item:5469}, complete nos Vagaventos pelo caminho.",
	-- ["Wind Hollows and {object:616467}"] = "Abantesmas do Vento e {object:616467}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "Abantesmas do Vento flutuam pelas planícies em volta de {area:16638}. As primeiras {object:616467} ficam a oeste da estrada do pomar.",
	-- ["Windsong Crawlers"] = "Rastejantes Cantéolo",
	-- ["talk to {npc:251905}"] = "fale com {npc:251905}",
	-- ["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638} fica ao lado do pouso: suba por um elevador e aprenda a rota de voo com {npc:2995}, o mestre de mantícoras.",
	-- ["{area:16624}, last time"] = "{area:16624}, última vez",
	-- ["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926} rondam as encostas a sudoeste da aldeia, no caminho para {npc:252095}.",
	-- ["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374} manda você para {area:16988}, logo a leste da aldeia: beba {item:6635} lá para ver {npc:251166} e depois leve {item:6656} de volta para ele.",
	-- ["{npc:251374} stands in the village."] = "{npc:251374} fica na aldeia.",
	-- ["{npc:251374}, at the village centre"] = "{npc:251374}, no centro da aldeia",
	-- ["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095} espera em {area:16622}, a sudoeste da aldeia. O acampamento Al'Aketh fica logo depois dela; {npc:256935} o lidera.",
	-- ["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359} fica no lado leste de {area:16638}.",
	-- ["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377} fica no meio de {area:16638}.",
	-- ["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382} fica no lado oeste de {area:16638}.",
	-- ["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{npc:252389}, em {area:16638}, entrega a você um {item:15908} três vezes: dome um {npc:254588} junto aos lagos a noroeste da cidade, um {npc:251707} nos campos a oeste da cidade e um {npc:250874} em {area:16663}, voltando a ela após cada um. {npc:254411} fica ao lado dela.",
	-- ["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853} espera junto às cachoeiras logo ao norte da torre de vigia.",
	-- ["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443} vaga pelas encostas logo ao sul da casa do traidor.",
	-- ["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}: guarde-a, Thrall em {zone:1454} vem dois guias depois",
	-- ["{npc:263664}'s campfire"] = "A fogueira de {npc:263664}",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre de mantícoras",
}
