-- Portuguese (Brazil) (ptBR): the guide forever/class/hunter/taming-the-beast-alliance (forever/class/hunter/taming-the-beast-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6063} Taming the Beast
	["{quest:6063} (Alliance)"] = "{quest:6063} (Aliança)",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "Seu próprio ajudante no nível 10: três domas de treino com um {item:15908} ensinam {spell:1515}, e depois {spell:5149}.",

	-- Step 1: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "No nível 10, {npc:254084}, instrutora de caçador em {zone:2521}, pode mandar você para {area:16638} com {quest:94007}. É só uma indicação: pule se já estiver em {area:16638}.",

	-- Step 2: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389} em {area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} fica com os instrutores junto ao portão oeste de {area:16638}, com {npc:254411} ao lado.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}: o primeiro {item:15908}",

	-- Step 3: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges. Killing one does not count. Keep each rod: it goes back to {npc:252389}."] = "Os Rastejantes Cantéolo só vivem perto da água: os mais perto correm pela margem a sudoeste de {area:16638}, no meio dos caranguejos. Como o bastão funciona: selecione um rastejante vivo, use o {item:15908} e fique parado durante toda a canalização enquanto ele bate em você; se mexer, revidar ou receber ajuda de alguém, quebra e gasta uma das poucas cargas do bastão. Matar não conta. Guarde cada bastão: ele volta para {npc:252389}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "Use o {item:15908} num rastejante vivo",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Dome {npc:254588}",

	-- Step 4: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "Dispense o rastejante antes (botão direito no retrato do ajudante, {spell:2641}). Os Vagaventos Turrões pastam em {area:16626}, os campos a uma curta caminhada a oeste e sudoeste de {area:16638}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "Use o {item:15908} num vagaventos vivo",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Dome {npc:251707}",

	-- Step 5: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "Dispense o vagaventos. Os Vuldrens Alfa caçam na mesma {area:16626}, um pouco mais ao sul.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "Use o {item:15908} num alfa vivo",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Dome {npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}, ao lado dela: {spell:5149}",

	-- Step 6: Grif Wildheart in Kharanos
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos
	["{npc:1231} in {area:131}"] = "{npc:1231} em {area:131}",
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:11807} Tristane Shadowstone · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:1231}, the hunter trainer at the smithy in {area:131}. The Hunter's Path from {npc:5116} in {zone:1455}, {npc:11807} north-west of {area:131} or {npc:5515} in {zone:1453} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "No nível 10, vá até {npc:1231}, o instrutor de caçador na ferraria de {area:131}. O caminho do caçador, de {npc:5116} em {zone:1455}, {npc:11807} a noroeste de {area:131} ou {npc:5515} em {zone:1453}, também traz você aqui, por um pouco de experiência; é só uma indicação. Está em Elwynn no nível 10? A sequência de {npc:251507}, em {area:87}, ensina o mesmo.",
	-- {npc:1231} Grif Wildheart · {item:15908} Taming Rod
	["{npc:1231}: the first {item:15908}"] = "{npc:1231}: o primeiro {item:15908}",

	-- Step 7: Large Crag Boar
	-- {area:131} Kharanos · {item:15908} Taming Rod · {npc:1231} Grif Wildheart · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar
	["Large Crag Boars (level 6-7) root around the fields west, south and north-west of {area:131} and respawn every 3 minutes. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, being out of range or anyone else's help breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:1231}. The boars use {spell:6268} from 25 yards, so start with the rod, not {spell:75}. Keep each rod: it goes back to {npc:1231}."] = "Os Rochetuscos Grandes (nível 6-7) fuçam pelos campos a oeste, ao sul e a noroeste de {area:131} e renascem a cada 3 minutos. Como o bastão funciona: selecione uma fera viva, use o {item:15908} e fique parado durante toda a canalização enquanto ela bate em você. Se mexer, revidar, ficar fora do alcance ou receber ajuda de alguém, quebra e gasta uma das poucas cargas do bastão; se acabarem, destrua o bastão, abandone a missão e pegue de novo com {npc:1231}. Os javalis usam {spell:6268} de 25 metros, então comece com o bastão, não com {spell:75}. Guarde cada bastão: ele volta para {npc:1231}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "Use o {item:15908} num javali vivo",

	-- Step 8: Snow Leopard
	-- {spell:2641} Dismiss Pet · {area:131} Kharanos
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Juvenile Snow Leopards = {npc:1199} Juvenile Snow Leopard
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Snow Leopards (level 7-8) prowl the slopes south-east of {area:131}, more north-west and west of it; the smaller Juvenile Snow Leopards do not count."] = "Dispense o javali antes (botão direito no retrato do ajudante, {spell:2641}): ajudante de treino solto pode se virar contra você. Os Leopardos da Neve (nível 7-8) rondam as encostas a sudeste de {area:131}, e há mais a noroeste e a oeste; os Leopardos da Neve Juvenis, menores, não contam.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living leopard"] = "Use o {item:15908} num leopardo vivo",

	-- Step 9: Ice Claw Bear
	-- {area:131} Kharanos · {area:77} Anvilmar · {spell:3130} Ice Claw
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Dismiss the leopard. Ice Claw Bears (level 7-8) roam the hills around {area:131}, many south-east of it and more north-west toward {area:77}; their {spell:3130} hits hard, so start at full health."] = "Dispense o leopardo. Os Ursos Garra de Gelo (nível 7-8) andam pelas colinas em volta de {area:131}, muitos a sudeste e mais alguns a noroeste, rumo a {area:77}; a {spell:3130} deles bate forte, então comece com a vida cheia.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living bear"] = "Use o {item:15908} num urso vivo",

	-- Step 10: Belia Thundergranite in Ironforge
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455}"] = "{npc:10090} em {zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1455} Ironforge · {object:32359} Military Ward (no name in this language: may be words)
	["{npc:10090}, the pet trainer, stands in the {object:32390} in {zone:1455}'s {object:32359}, by the hunter trainers."] = "{npc:10090}, a instrutora de ajudantes, fica no {object:32390}, na {object:32359} de {zone:1455}, junto aos instrutores de caçador.",

	-- Step 11: Dazalar in Dolanaar
	-- {npc:3601} Dazalar · {area:186} Dolanaar
	["{npc:3601} in {area:186}"] = "{npc:3601} em {area:186}",
	-- {npc:3601} Dazalar · {area:186} Dolanaar · {npc:3596} Ayanna Everstride · {area:256} Aldrassil · {npc:4146} Jocaste · {zone:1457} Darnassus · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:3601}, the hunter trainer in {area:186}. The Hunter's Path from {npc:3596} at {area:256}, {npc:4146} in {zone:1457}, {npc:5515} in {zone:1453}, {npc:5116} in {zone:1455} or {npc:1231} in {area:131} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "No nível 10, vá até {npc:3601}, o instrutor de caçador em {area:186}. O caminho do caçador, de {npc:3596} em {area:256}, {npc:4146} em {zone:1457}, {npc:5515} em {zone:1453}, {npc:5116} em {zone:1455} ou {npc:1231} em {area:131}, também traz você aqui, por um pouco de experiência; é só uma indicação. Está em Elwynn no nível 10? A sequência de {npc:251507}, em {area:87}, ensina o mesmo.",
	-- {npc:3601} Dazalar · {item:15908} Taming Rod
	["{npc:3601}: the first {item:15908}"] = "{npc:3601}: o primeiro {item:15908}",

	-- Step 12: Webwood Lurker
	-- {area:186} Dolanaar · {item:15908} Taming Rod · {spell:1265843} Web · {npc:3601} Dazalar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers (level 5-6) creep through the woods just north-east, south-west and east of {area:186}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, attacking it or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). Their {spell:1265843} roots you but does not break the channel if you keep still. Keep each rod: it goes back to {npc:3601}."] = "As Tocaieiras Lenhateia (nível 5-6) rastejam pela mata logo a nordeste, sudoeste e leste de {area:186}. Como o bastão funciona: selecione uma fera viva, use o {item:15908} e fique parado durante toda a canalização enquanto ela bate em você; se mexer, atacar ou receber ajuda de alguém, quebra e gasta uma das poucas cargas do bastão (acabaram as cargas: destrua o bastão, abandone a missão e pegue de novo). A {spell:1265843} delas prende você, mas não quebra a canalização se você ficar parado. Guarde cada bastão: ele volta para {npc:3601}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living spider"] = "Use o {item:15908} numa aranha viva",

	-- Step 13: Nightsaber Stalker
	-- {spell:2641} Dismiss Pet · {area:259} Lake Al'Ameth · {area:186} Dolanaar
	-- plural, as words: Nightsaber Stalkers = {npc:2043} Nightsaber Stalker
	["Dismiss the spider first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Nightsaber Stalkers (level 7-8) lie on the hillside south of {area:259}, south of {area:186}; the plain Nightsabers by the village do not count."] = "Dispense a aranha antes (botão direito no retrato do ajudante, {spell:2641}): ajudante de treino solto pode se virar contra você. Os Espreitadores Sabre-da-noite (nível 7-8) ficam deitados na encosta ao sul de {area:259}, ao sul de {area:186}; os Sabres-da-noite comuns perto da vila não contam.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "Use o {item:15908} num espreitador vivo",

	-- Step 14: Strigid Screecher
	-- {area:186} Dolanaar
	-- plural, as words: Strigid Screechers = {npc:1996} Strigid Screecher
	["Dismiss the cat. Strigid Screechers (level 7-8), owls, perch in the woods south, south-west and west of {area:186}."] = "Dispense o felino. As Guinchadoras Estrígidas (nível 7-8), corujas, pousam na mata ao sul, sudoeste e oeste de {area:186}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living owl"] = "Use o {item:15908} numa coruja viva",

	-- Step 15: Jocaste in Darnassus
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457}"] = "{npc:4146} em {zone:1457}",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:4146} Jocaste · {area:1658} Cenarion Enclave
	["Take the road west from {area:186} to {zone:1457}. {npc:4146} stands inside the {area:1658} with the hunter trainers; Silvaria, the pet trainer, is up the ramp next to her."] = "Pegue a estrada para oeste de {area:186} até {zone:1457}. {npc:4146} fica dentro de {area:1658}, com os instrutores de caçador; Silvaria, a instrutora de ajudantes, fica subindo a rampa ao lado dela.",

	-- Step 16: Josephine Carson in Goldshire
	-- {npc:251507} Josephine Carson · {area:87} Goldshire
	["{npc:251507} in {area:87}"] = "{npc:251507} em {area:87}",
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {npc:258930} Isaac Chan · {zone:2521} Zephras Isle
	["At 10 go to {npc:251507}, the hunter trainer who stands with the other trainers by the Lion's Pride Inn in {area:87}; {npc:258930}, the pet trainer, is beside her. Skyborne: this is for one who left {zone:2521} without taming; it teaches the same."] = "No nível 10, vá até {npc:251507}, a instrutora de caçador que fica com os outros instrutores junto à estalagem de {area:87}; {npc:258930}, o instrutor de ajudantes, fica ao lado dela. Celonatos: isto é para quem saiu de {zone:2521} sem domar; ensina o mesmo.",
	-- {npc:251507} Josephine Carson · {item:15908} Taming Rod
	["{npc:251507}: the first {item:15908}"] = "{npc:251507}: o primeiro {item:15908}",

	-- Step 17: Rockhide Boar
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {item:15908} Taming Rod · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar
	["Rockhide Boars (level 7-8) graze in three herds south and south-east of {area:87}, toward the {area:64}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again. The boars use {spell:6268}, so start with the rod, not {spell:75}. Killing a boar does not count. Keep each rod: it goes back to Josephine. A Dwarf or Night Elf who took Josephine's rod instead of their home trainer's is led through {area:87} from here."] = "Os Javalis Couropedra (nível 7-8) pastam em três manadas ao sul e a sudeste de {area:87}, rumo a {area:64}. Como o bastão funciona: selecione uma fera viva, use o {item:15908} e fique parado durante toda a canalização enquanto ela bate em você. Se mexer, revidar, receber cura de alguém ou alguém bater na fera, quebra e gasta uma das poucas cargas do bastão; se acabarem, destrua o bastão, abandone a missão e pegue de novo. Os javalis usam {spell:6268}, então comece com o bastão, não com {spell:75}. Matar javali não conta. Guarde cada bastão: ele volta para a Josefina. Anão ou Elfo Noturno que pegou o bastão da Josefina em vez do instrutor da terra natal segue por {area:87} daqui em diante.",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "Dome {npc:524}",

	-- Step 18: Gray Forest Wolf
	-- {spell:2641} Dismiss Pet · {area:87} Goldshire · {area:18} Crystal Lake
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Gray Forest Wolves (level 7-8) run in the woods east of {area:87}, east of {area:18}."] = "Dispense o javali antes (botão direito no retrato do ajudante, {spell:2641}): ajudante de treino solto pode se virar contra você. Os Lobos Cinza da Floresta (nível 7-8) correm pela mata a leste de {area:87}, a leste de {area:18}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living wolf"] = "Use o {item:15908} num lobo vivo",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "Dome {npc:1922}",

	-- Step 19: Young Forest Bear
	-- {area:87} Goldshire
	-- plural, as words: Young Forest Bears = {npc:822} Young Forest Bear
	["Dismiss the wolf. Young Forest Bears (level 8-9) roam the woods just south of {area:87}, with more south-west and south-east of town."] = "Dispense o lobo. Os Jovens Ursos da Floresta (nível 8-9) andam pela mata logo ao sul de {area:87}, e há mais a sudoeste e sudeste da vila.",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "Dome {npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, ao lado dela: {spell:5149}",

	-- Step 20: Your first pet
	["Your first pet"] = "Seu primeiro ajudante",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} funciona como o bastão: uma fera do seu nível ou abaixo, uma canalização em que você não pode se mexer, e a fera batendo em você o tempo todo. O ajudante fica no nível em que foi domado e sobe junto com você; ele nunca passa do seu nível, então dome um perto do seu. Cada família tem a própria habilidade no Forever (a Investida do javali, por exemplo). Para upar, o felino bate mais forte (Garra e {spell:17253}) e o javali aguenta mais pancada.",
	["Tame a beast of your level to keep"] = "Dome uma fera do seu nível para ficar com ela",
	-- {area:87} Goldshire · {zone:1436} Westfall
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Near {area:87} there are no cats: Prowlers (wolves, level 9-10) roam eastern Elwynn, Longsnouts (boars, 10-11) its far south-west by the {zone:1436} border; at 12-13, Young Goretusks (boars) graze the fields of northern {zone:1436}."] = "Perto de {area:87} não tem felino: Predadores (lobos, nível 9-10) andam pelo leste de Elwynn, Fuçalongas (javalis, 10-11) pelo extremo sudoeste, na divisa com {zone:1436}; no nível 12-13, Gorestuscos Jovens (javalis) pastam nos campos do norte de {zone:1436}.",
	-- {area:131} Kharanos · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Scarred Crag Boars = {npc:1689} Scarred Crag Boar · Mountain Boars = {npc:1190} Mountain Boar
	["Near {area:131}: Snow Leopards (cats, level 7-8) prowl all over {zone:1426}, Scarred Crag Boars (9-10) its east toward {zone:1432}; at 10-11, Mountain Boars roam western {zone:1432}."] = "Perto de {area:131}: Leopardos da Neve (felinos, nível 7-8) rondam toda {zone:1426}, Rochetuscos Cicatrizados (9-10) o leste dela, rumo a {zone:1432}; no nível 10-11, Javalis Montanheses andam pelo oeste de {zone:1432}.",
	-- {area:186} Dolanaar · {zone:1438} Teldrassil
	-- plural, as words: Elder Nightsabers = {npc:2033} Elder Nightsaber · Feral Nightsabers = {npc:2034} Feral Nightsaber
	["Near {area:186}: Elder Nightsabers (cats, level 8-9) and Feral Nightsabers (cats, 10-11) prowl the woods of north-western {zone:1438}."] = "Perto de {area:186}: Sabres-da-noite Anciãos (felinos, nível 8-9) e Sabres-da-noite Ferais (felinos, 10-11) rondam a mata do noroeste de {zone:1438}.",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "Perto de {area:16638}: os Vuldrens Alfa (nível 10), a fera do seu último doma de treino, caçam em {area:16626}; as Matriarcas Guinchote (raptores, nível 9) fazem ninho logo a oeste de {area:16638}; as Urseras Ventosombra (ursos, 10-11) andam pelo norte de {zone:2521}.",
	-- {spell:1584} Feed Pet · {area:87} Goldshire · {zone:1457} Darnassus · {zone:2521} Zephras Isle · {area:131} Kharanos · {area:186} Dolanaar
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Toddrick the butcher in {area:87}, Jaeana in {zone:1457} and the innkeepers on {zone:2521} sell meat; the innkeepers of {area:131} and {area:186} sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}: abra o grimório, use {spell:1584} e clique numa comida que a família do seu ajudante come (a dica do ajudante lista: felinos comem carne e peixe, javalis comem quase tudo). Carne crua saqueada de feras serve. Para comprar: Toddrick, o açougueiro de {area:87}, Jaeana em {zone:1457} e os estalajadeiros de {zone:2521} vendem carne; os estalajadeiros de {area:131} e {area:186} vendem pão. Comida perto do nível do ajudante deixa ele mais feliz; comida bem abaixo rende mais ou menos metade. Não dá para alimentar em combate.",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "Felicidade: a carinha no quadro do ajudante. Ajudante infeliz causa três quartos do dano, e o feliz, um quarto a mais. A felicidade cai devagar, e mais rápido quando o ajudante morre; ajudante infeliz por muito tempo pode fugir.",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "A lealdade cresce com o tempo e com os abates. Cada grau de lealdade aumenta os pontos de treino que você gasta em {spell:5149} (nível do ajudante vezes o grau de lealdade menos um).",
	-- {spell:5149} Beast Training · {area:87} Goldshire · {npc:9980} Shelby Stoneflint · {area:131} Kharanos · {area:186} Dolanaar · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master (Erma in {area:87}, {npc:9980} in {area:131}, Seriadne in {area:186}, {npc:265756} on {zone:2521}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149} (grimório, aba Geral) ensina ao ajudante atual as habilidades que você conhece. Para aprender uma habilidade ou grau novo: deixe o ajudante com um cavalariço (Erma em {area:87}, {npc:9980} em {area:131}, Seriadne em {area:186}, {npc:265756} em {zone:2521}), dome uma fera que tenha a habilidade (a aba de grimório do ajudante mostra o que ela sabe), use a habilidade nas lutas até o jogo dizer que você aprendeu, depois pegue seu ajudante de volta e ensine com {spell:5149}. Um ajudante tem no máximo quatro habilidades ativas.",
	-- {spell:1853} Growl · {npc:258930} Isaac Chan · {area:87} Goldshire · {npc:2879} Karrina Mekenda · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:2878} Peria Lamenur · {area:131} Kharanos · {npc:10090} Belia Thundergranite · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {area:186} Dolanaar · {zone:1457} Darnassus · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar
	["Pet trainers sell {spell:1853} ranks and resistances. Alliance: {npc:258930} in {area:87}, {npc:2879} by the hunter trainers in {zone:1453}'s {object:28027}, {npc:2878} in {area:131}, {npc:10090} in {zone:1455}'s {object:32390}, Keldas in {area:186}, Silvaria in {zone:1457}' Cenarion Enclave, {npc:254411} in {area:16638}."] = "Os instrutores de ajudantes vendem níveis de {spell:1853} e resistências. Aliança: {npc:258930} em {area:87}, {npc:2879} junto aos instrutores de caçador no {object:28027} de {zone:1453}, {npc:2878} em {area:131}, {npc:10090} no {object:32390} de {zone:1455}, Keldas em {area:186}, Silvaria no Enclave Cenariano de {zone:1457}, {npc:254411} em {area:16638}.",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}, {spell:2641} e {spell:982} já estão no seu grimório; {spell:136} vem do seu instrutor no nível 12. Ajudante morto precisa de {spell:982}; um que fica a mais de umas 100 metros é dispensado e volta com {spell:883}.",
}
