-- Portuguese (Brazil) (ptBR): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "Você acorda em {area:16622}. {npc:251362} está ao seu lado; {npc:251361} fica a alguns passos a oeste, e {npc:251368} na borda sul do bosque.",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "Vuldrens e Cirromoscas",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873} e Cirromoscas Irritantes vagam pela campina logo a sudeste do bosque.",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "De volta a {area:16622}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: o {item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, na torre de vigia",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: um bilhete do seu instrutor",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: leia o {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, na torre de vigia",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379}, a instrutora de magos: leia o {item:282416} primeiro",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, o instrutor de druidas, no térreo da árvore atrás de {npc:251361}",
	["The class trainers stand together in the grove"] = "Os instrutores de classe ficam juntos no bosque",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "Escute {npc:257554}",
	-- {spell:1259416} Walk on Air
	["Use {spell:1259416}"] = "Use {spell:1259416}",

	-- Step 4: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "Pedras Eólicas Brutas e a {npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "As Pedras Eólicas Brutas brilham no chão logo ao sul do bosque. {quest:92463} paira sobre a campina mais a leste, no caminho até {npc:249363}.",

	-- Step 5: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363} vigia a leste do bosque. Os {npc:251143} e os Convertidos Al'Aketh se reúnem logo ao norte dela; a Linha Ley se ergue mais ao norte: use nela sua habilidade racial {spell:1259705}.",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "Use sua habilidade racial {spell:1259705} na Linha Ley",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "Entregas em {area:16622}",
	["Level 4 spells"] = "Feitiços de nível 4",

	-- Step 7: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926} e {npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926} rondam a mata logo a oeste do bosque; os Catadores Ursera têm a toca mais a oeste, com {npc:251115}, a matriarca, no fundo da toca.",

	-- Step 8: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095} acampa ao sul da toca dos Ursera. Os Bandidos Al'Aketh ocupam o acampamento a sudoeste dela; {npc:256935} fica no meio dele.",

	-- Step 9: Aetheen of the Gales
	["Level 6 spells"] = "Feitiços de nível 6",

	-- Step 10: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "Siga a estrada para o sul até {area:16624}. {npc:263664} acampa junto à fogueira a oeste da aldeia; {npc:251523} e {npc:251903} ficam no centro dela.",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "Fale com {npc:251903} e {npc:254089}, a noroeste da aldeia",

	-- Step 11: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "Use /sentar junto à fogueira de {npc:263664} até receber {spell:1229451}",

	-- Step 12: Village quests
	["Village quests"] = "Missões da aldeia",
	["The bounty board"] = "O quadro de recompensas",

	-- Step 13: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Garraltivas e Vagaventos",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "Garraltivas e Vagaventos vagam pelos campos ao sul da aldeia. Os Vagaventos deixam cair tanto os ovos quanto a carne.",

	-- Step 14: Back to Shen'dar
	["Back to Shen'dar"] = "De volta a Shen'dar",

	-- Step 15: The Highlands bandits
	["The Highlands bandits"] = "Os bandidos do Planalto",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "Os Bandidos do Planalto acampam a nordeste da aldeia. Bennic \"Malevento\" espera no extremo norte do acampamento.",

	-- Step 16: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "Entregas em Shen'dar",

	-- Step 17: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065} espera na entrada de {quest:92529}, ao sul de Shen'dar. {spell:1254832} permite que você ande entre os fiéis.",
	["Search the wardrobe"] = "Revire o guarda-roupa",

	-- Step 19: Havoc in Falaath
	["Havoc in Falaath"] = "Caos em Falaath",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "De volta à {quest:92529}: Tempestários e {npc:251662} enchem a aldeia, os Tempestários carregam os suprimentos roubados e {npc:251966} fica no extremo sul.",

	-- Step 20: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155} guarda a vigia oeste, a sudoeste de Falaath. {npc:256966} e os guardas caídos jazem logo ao sul dela.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "O {item:254871}",

	-- Step 21: The hippogryph roost
	["The hippogryph roost"] = "O ninhal dos hipogrifos",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "Vá para noroeste até os ninhos de hipogrifo nos penhascos do oeste. {item:263493} fica espalhada pelos ninhos; a Matriarca Hipogrifo patrulha entre eles.",

	-- Step 22: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} espreita nas colinas a sudoeste da aldeia, no caminho de volta. {npc:254589} é Elite: recomenda-se formar um grupo.",

	-- Step 23: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "Videntes Noviços Moldavento",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "Os Videntes Noviços treinam na clareira a oeste de Shen'dar.",

	-- Step 24: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "{area:16624} de novo",

	-- Step 25: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "A estrada para {area:16638}",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "Pegue a estrada para sudeste. {npc:257006} e {npc:252448} ficam à beira da estrada a oeste de {area:16638}; Rastejantes Cantéolo ocupam a margem mais a oeste, por volta de 51,70.",

	-- Step 26: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383} e {npc:252476} ficam no extremo norte de {area:16638}; {npc:252475} e {npc:253204}, no extremo sul.",

	-- Step 27: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Saltacéus",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "Saltacéus infestam os campos a oeste de {area:16638}.",

	-- Step 28: The missing scholar
	["The missing scholar"] = "O erudito desaparecido",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "A {object:581822} está junto à trilha a oeste de {area:16638}; o acampamento de Filião fica a noroeste dela, e as Matriarcas Guinchote fazem ninho logo a oeste do acampamento.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "A {object:581822}",
	["Find Fillion and his bedroll"] = "Encontre Filião e o saco de dormir dele",

	-- Step 29: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800} cuida da fazenda nas terras baixas do sudoeste.",

	-- Step 30: The Windfield farm
	["The Windfield farm"] = "A fazenda Windfield",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "Maçãs-dos-raios Maduras e Bandidos Famintos estão no pomar junto à fazenda, {quest:92683} nos campos a nordeste dela, e Vagaventos Turrões por toda parte. O {npc:250929} fica no campo a nordeste da fazenda.",

	-- Step 31: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "{npc:252800} de novo",

	-- Step 32: Bandit Highwaymen
	["Bandit Highwaymen"] = "Bandoleiros Bandidos",
	["The Bandit Highwaymen hold the hills north of the farm."] = "Os Bandoleiros Bandidos ocupam as colinas ao norte da fazenda.",

	-- Step 33: Standing our ground
	["Standing our ground"] = "Firmes na posição",
	-- {npc:252800} Aamelia Windfield · {npc:252863} Ferauu the Bludgeon
	["Stand with {npc:252800} against {npc:252863}"] = "Lute ao lado de {npc:252800} contra {npc:252863}",

	-- Step 34: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "Entregas em {area:16638}",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}: {npc:257196} espera no {area:16629}",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}, o instrutor de magos",

	-- Step 35: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "Cada missão de Quel'ana dá a você um {item:15908}: use-o na fera que ela indicar e depois devolva o bastão a ela em {area:16638}. Rastejantes Cantéolo ocupam a margem a oeste da cidade; Vuldrens Alfa e Vagaventos Turrões vagam por {area:16626}, em volta da fazenda Windfield. A irmã dela, {npc:254411}, fica ao lado.",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}: dome-o com o {item:15908}",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Dome-o com o {item:15908}",

	-- Step 36: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "As Formações de Pedra Eólica",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "As Formações de Pedra Eólica ficam na elevação a oeste do acampamento de Filião.",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}: junto ao santuário do vento ao sul da {quest:92529}",

	-- Step 38: The eastern watchtower
	["The eastern watchtower"] = "A torre de vigia leste",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378} guarda a torre de vigia ao norte de {area:16638}. O acampamento Al'Aketh fica logo a oeste da torre, com os curandeiros por volta de 65,68 e 65,65; {npc:252666} fica no extremo norte. Os Al'Aketh de lá deixam cair Patuás da Pedra Eólica de Al'Aketh.",

	-- Step 39: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}, o desertor",

	-- Step 40: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853} espera junto às cachoeiras a nordeste de {area:16638}. {npc:258443} ronda {area:16623} a oeste de {area:16638}, perto da estrada que você pegará em seguida.",

	-- Step 41: The dead cultist
	["The dead cultist"] = "O sectário morto",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "A noroeste de Valanaar, pela estrada: {npc:273017} vigia os {quest:98512}; o sectário morto jaz logo ao norte dele.",
	["Search the dead cultist"] = "Reviste o sectário morto",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}, no planalto a sudoeste do sectário",

	-- Step 42: Desperate times
	["Desperate times"] = "Tempos desesperados",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "Reúna Valennia, {npc:251968} (a oeste da cidade) e {npc:252475}",
	["Meet Valennia at the gate"] = "Encontre Valennia no portão",

	-- Step 43: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "Volte a {npc:255853}, junto às cachoeiras a nordeste de {area:16638}, no caminho para o santuário ao norte.",

	-- Step 44: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "Abra caminho para o norte até o {area:16629}. Guardiões, Evoca-espíritos e Mestres de Espadas defendem o acesso; {npc:253576} espera na porta do santuário, e {npc:253590} no sacrário interno.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "{npc:253590}, no sacrário",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}: {npc:257196}, a oeste do acesso ao santuário",

	-- Step 45: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "Siga para o norte, entrando em {area:16631}. {npc:257944} acampa na parte leste.",

	-- Step 46: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "Caça-tempestades e Soldados de Infantaria Al'Aketh acampam logo ao norte de {npc:257944} e deixam cair a herança; os Guinchotes a oeste dela deixam cair as penas e garras; o {item:265105} cresce ao longo do riacho a oeste dela.",

	-- Step 47: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "{npc:257944} de novo",

	-- Step 48: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130} e {npc:258134} ficam a nordeste de {npc:257944}; {npc:253622} fica a leste deles. Haalien também deixa cair uma {quest:94490}.",
	-- {npc:258130} Jorel Windsinger
	["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Cure 7 druidas no Covil Presanoite e depois encontre {npc:258130}",

	-- Step 49: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}, a missiva",

	-- Step 50: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159} mora a oeste de {npc:257944}. As Pinhas de Semente-de-zéfiro ficam na mata entre a cabana dele e {npc:257944}.",

	-- Step 51: The refugees' camp
	["The refugees' camp"] = "O acampamento dos refugiados",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "Ao norte das pinhas: os Abantesmas do Vento vagueiam pelo acampamento dos refugiados, os {item:266433} estão entre as tendas e {npc:259013} jaz no extremo norte.",

	-- Step 52: Back to the Hermit
	["Back to the Hermit"] = "De volta ao Eremita",

	-- Step 53: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "Lorthuna espera na costa leste da ilha, a leste do {area:16629}.",

	-- Step 54: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}, o destino de Zefras",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}: {npc:259084} espera junto ao portal Celonato",

	-- Step 55: The skycutter
	["The skycutter"] = "A nave celeste",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "A nave celeste atraca na torre ao sul de {area:16638}. Ela pousa junto ao acampamento do Kirin Tor, na margem do lago a oeste de {area:279}.",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "Nave celeste para {area:279}",

	-- Step 56: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084} fica ao lado do Portal Celonato, onde o zepelim pousa. O portal leva você a {zone:1453}.",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}, ao lado de {npc:259084}: para {npc:5504} em {zone:1453}",

	-- Step 57: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "Bolvar Fordragon fica na sala do trono de {object:2117}, no extremo norte da cidade. Depois saia pelo portão principal rumo a {zone:1436}.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "Para {npc:234} em {area:108}",

	-- Step 58: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}, instrutor de druidas de {zone:1453}, ensina {spell:18960}. As boas-vindas de {npc:11802} aguardam sua viagem de {spell:499} no fim de {zone:1439}.",

	-- Step 59: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} fica no Santuário do Mago, a torre do {object:2101}; ela dá a você um frasco para a cachoeira do {quest:1861}.",

	-- Step 60: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Saia de {zone:1453} pelo portão principal. A cachoeira do {quest:1861} fica a sudoeste dos portões, no caminho para {zone:1436}, a oeste: encha o {item:7207} na base dela.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "Use sua habilidade racial no {object:460002}",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363} vigia a leste do bosque. Os {npc:251143} e os Convertidos Al'Aketh se reúnem logo ao norte dela; o {object:460002} se ergue mais ao norte: use nele sua habilidade racial.",
}
