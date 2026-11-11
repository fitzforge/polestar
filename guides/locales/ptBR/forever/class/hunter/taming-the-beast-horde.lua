-- Portuguese (Brazil) (ptBR): the guide forever/class/hunter/taming-the-beast-horde (forever/class/hunter/taming-the-beast-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6061} Taming the Beast
	["{quest:6061} (Horde)"] = "{quest:6061} (Horda)",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "Seu próprio ajudante no nível 10: três domas de treino com um {item:15908} ensinam {spell:1515}, e depois {spell:5149}.",

	-- Step 1: Thotar in Razor Hill
	-- {npc:3171} Thotar · {area:362} Razor Hill
	["{npc:3171} in {area:362}"] = "{npc:3171} em {area:362}",
	-- {npc:3171} Thotar · {area:362} Razor Hill · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:11814} Kali Remik · {area:367} Sen'jin Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff
	["At 10 go to {npc:3171}, the hunter trainer inside the barracks in {area:362}. If {npc:3407} in {zone:1454}, {npc:11814} in {area:367} or {npc:3038} in {zone:1456} hands you The Hunter's Path, take it and hand it to {npc:3171} for a little experience; it is only a pointer, and you can take the first rod without it."] = "No nível 10, vá até {npc:3171}, o instrutor de caçador dentro do quartel de {area:362}. Se {npc:3407} em {zone:1454}, {npc:11814} em {area:367} ou {npc:3038} em {zone:1456} der O caminho do caçador, pegue e entregue a {npc:3171} por um pouco de experiência; é só uma indicação, e dá para pegar o primeiro bastão sem ela.",
	-- {npc:3171} Thotar · {item:15908} Taming Rod
	["{npc:3171}: the first {item:15908}"] = "{npc:3171}: o primeiro {item:15908}",

	-- Step 2: Dire Mottled Boar
	-- {area:362} Razor Hill · {item:15908} Taming Rod · {npc:3171} Thotar · {spell:75} Auto Shot
	-- plural, as words: Dire Mottled Boars = {npc:3099} Dire Mottled Boar
	["Dire Mottled Boars (level 6-7) roam just north and west of {area:362}. How the rod works: target a living beast, use the {item:15908} from inside its range and stand still for the whole channel while the beast hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:3171}. The boars charge from 20 yards, so start with the rod, not {spell:75}. The tamed boar becomes your pet for practice. Keep each rod: it goes back to {npc:3171}."] = "Os Mosquetuscos Hediondos (nível 6-7) andam logo ao norte e a oeste de {area:362}. Como o bastão funciona: selecione uma fera viva, use o {item:15908} dentro do alcance e fique parado durante toda a canalização enquanto a fera bate em você. Se mexer, revidar, receber cura de alguém ou alguém bater na fera, quebra e gasta uma das poucas cargas do bastão; se acabarem, destrua o bastão, abandone a missão e pegue de novo com {npc:3171}. Os javalis investem de 20 metros, então comece com o bastão, não com {spell:75}. O javali domado vira seu ajudante de treino. Guarde cada bastão: ele volta para {npc:3171}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "Use o {item:15908} num javali vivo",

	-- Step 3: Surf Crawler
	-- {spell:2641} Dismiss Pet · {area:367} Sen'jin Village · {area:368} Echo Isles
	-- plural, as words: Surf Crawlers = {npc:3107} Surf Crawler · Pygmy Surf Crawlers = {npc:3106} Pygmy Surf Crawler
	["First dismiss the boar (right-click your pet's portrait, {spell:2641}): a released practice pet can turn on you. Surf Crawlers (level 7-8) walk the beaches around {area:367} and the {area:368}; the small Pygmy Surf Crawlers do not count. A crawler runs for help at 15% health, so do not hurt it."] = "Primeiro dispense o javali (botão direito no retrato do ajudante, {spell:2641}): ajudante de treino solto pode se virar contra você. Os Surfatiscos (nível 7-8) andam pelas praias em volta de {area:367} e de {area:368}; os Surfatiscos Pigmeus, pequenos, não contam. O surfatisco foge atrás de ajuda com 15% de vida, então não machuque.",
	-- {item:15908} Taming Rod · {npc:3107} Surf Crawler
	["Use the {item:15908} on a living {npc:3107}"] = "Use o {item:15908} num {npc:3107} vivo",

	-- Step 4: Armored Scorpid
	-- {area:362} Razor Hill · {spell:1494} Track Beasts
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Dismiss the crawler. Armored Scorpids (level 7-8) crawl the dry plains west and south-west of {area:362}, some just south of the road west out of town; {spell:1494} shows them. Their hits can break the channel: start at full health and keep still."] = "Dispense o surfatisco. Os Escorpídeos Encouraçados (nível 7-8) rastejam pelas planícies secas a oeste e sudoeste de {area:362}, alguns logo ao sul da estrada que sai da cidade para oeste; {spell:1494} mostra onde estão. Os golpes deles podem quebrar a canalização: comece com a vida cheia e fique parado.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living scorpid"] = "Use o {item:15908} num escorpídeo vivo",

	-- Step 5: Ormak Grimshot in Orgrimmar
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar
	["{npc:3352} in {zone:1454}"] = "{npc:3352} em {zone:1454}",
	-- {zone:1454} Orgrimmar · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:10088} Xao'tsu
	["Follow the road north to {zone:1454}'s gate. {npc:3352} stands with the hunter trainers in the {object:172958}, up the ramp at the city's east side; {npc:10088}, the pet trainer, is a few steps north of him."] = "Siga a estrada para o norte até o portão de {zone:1454}. {npc:3352} fica com os instrutores de caçador no {object:172958}, subindo a rampa no lado leste da cidade; {npc:10088}, o instrutor de ajudantes, fica a alguns passos ao norte dele.",

	-- Step 6: Yaw Sharpmane at Bloodhoof
	-- {npc:3065} Yaw Sharpmane
	["{npc:3065} at Bloodhoof"] = "{npc:3065} em Casco Sangrento",
	-- {npc:3065} Yaw Sharpmane · {area:222} Bloodhoof Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:3171} Thotar · {area:362} Razor Hill
	["At 10 go to {npc:3065}, who stands at the north edge of {area:222}. The Hunter's Path from {npc:3038} in {zone:1456}, {npc:3407} in {zone:1454} or {npc:3171} in {area:362} also leads here, for a little experience; it is only a pointer."] = "No nível 10, vá até {npc:3065}, que fica na borda norte de {area:222}. O caminho do caçador, de {npc:3038} em {zone:1456}, {npc:3407} em {zone:1454} ou {npc:3171} em {area:362}, também traz você aqui, por um pouco de experiência; é só uma indicação.",
	-- {npc:3065} Yaw Sharpmane · {item:15908} Taming Rod
	["{npc:3065}: the first {item:15908}"] = "{npc:3065}: o primeiro {item:15908}",

	-- Step 7: Adult Plainstrider
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Adult Plainstriders (level 6-7) walk the plains south-west and north-west of {area:222}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). A plainstrider flees at 25% health, so do not damage it first. Keep each rod: it goes back to Yaw."] = "Os Pinotes Adultos (nível 6-7) andam pelas planícies a sudoeste e noroeste de {area:222}. Como o bastão funciona: selecione uma fera viva, use o {item:15908} e fique parado durante toda a canalização enquanto ela bate em você; se mexer, revidar ou receber ajuda de alguém, quebra e gasta uma das poucas cargas do bastão (acabaram as cargas: destrua o bastão, abandone a missão e pegue de novo). O pinote foge com 25% de vida, então não machuque antes. Guarde cada bastão: ele volta para o Yaw.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living plainstrider"] = "Use o {item:15908} num pinote vivo",

	-- Step 8: Prairie Stalker
	-- {spell:2641} Dismiss Pet · {area:222} Bloodhoof Village
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker
	["Dismiss the plainstrider first (right-click the pet portrait, {spell:2641}): a released practice pet may attack you. Prairie Stalkers (level 7-8) roam the grass north of {area:222}."] = "Dispense o pinote antes (botão direito no retrato do ajudante, {spell:2641}): ajudante de treino solto pode atacar você. Os Espreitadores-da-pradaria (nível 7-8) andam pelo capim ao norte de {area:222}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "Use o {item:15908} num espreitador vivo",

	-- Step 9: Swoop
	-- {npc:2970} Swoop
	-- plural, as words: Swoops = {npc:2970} Swoop · Taloned Swoops = {npc:2971} Taloned Swoop
	["Dismiss the stalker. Swoops (level 7-9) glide over the plains north-west and north-east of Bloodhoof; the Taloned Swoops do not count. A {npc:2970}'s knockdown breaks the channel, but it lands only once per channel: start the rod just after it has used it."] = "Dispense o espreitador. Os Rapineiros (nível 7-9) planam sobre as planícies a noroeste e nordeste de Casco Sangrento; os Rapineiros de Gadanho não contam. A derrubada do {npc:2970} quebra a canalização, mas só acontece uma vez por canalização: comece o bastão logo depois que ele usar.",
	-- {item:15908} Taming Rod · {npc:2970} Swoop
	["Use the {item:15908} on a living {npc:2970}"] = "Use o {item:15908} num {npc:2970} vivo",

	-- Step 10: Holt Thunderhorn in Thunder Bluff
	-- {npc:3039} Holt Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:3039} in {zone:1456}"] = "{npc:3039} em {zone:1456}",
	-- {zone:1456} Thunder Bluff · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {npc:10086} Hesuwa Thunderhorn
	["Head north to {zone:1456} and take a lift up. {npc:3039} stands with the hunter trainers on {area:1641}; {npc:10086}, the pet trainer, is nearby."] = "Siga para o norte até {zone:1456} e suba por um elevador. {npc:3039} fica com os instrutores de caçador em {area:1641}; {npc:10086}, a instrutora de ajudantes, fica ali perto.",

	-- Step 11: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "No nível 10, {npc:254084}, instrutora de caçador em {zone:2521}, pode mandar você para {area:16638} com {quest:94007}. É só uma indicação: pule se já estiver em {area:16638}.",

	-- Step 12: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389} em {area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} fica com os instrutores junto ao portão oeste de {area:16638}, com {npc:254411} ao lado.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}: o primeiro {item:15908}",

	-- Step 13: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs a charge. Killing one does not count."] = "Os Rastejantes Cantéolo só vivem perto da água: os mais perto correm pela margem a sudoeste de {area:16638}, no meio dos caranguejos. Como o bastão funciona: selecione um rastejante vivo, use o {item:15908} e fique parado durante toda a canalização enquanto ele bate em você; se mexer, revidar ou receber ajuda de alguém, quebra e gasta uma carga. Matar não conta.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "Use o {item:15908} num rastejante vivo",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Dome {npc:254588}",

	-- Step 14: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "Dispense o rastejante antes (botão direito no retrato do ajudante, {spell:2641}). Os Vagaventos Turrões pastam em {area:16626}, os campos a uma curta caminhada a oeste e sudoeste de {area:16638}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "Use o {item:15908} num vagaventos vivo",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Dome {npc:251707}",

	-- Step 15: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "Dispense o vagaventos. Os Vuldrens Alfa caçam na mesma {area:16626}, um pouco mais ao sul.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "Use o {item:15908} num alfa vivo",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Dome {npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}, ao lado dela: {spell:5149}",

	-- Step 16: Your first pet
	["Your first pet"] = "Seu primeiro ajudante",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} funciona como o bastão: uma fera do seu nível ou abaixo, uma canalização em que você não pode se mexer, e a fera batendo em você o tempo todo. O ajudante fica no nível em que foi domado e sobe junto com você; ele nunca passa do seu nível, então dome um perto do seu. Cada família tem a própria habilidade no Forever (a Investida do javali, por exemplo). Para upar, o felino bate mais forte (Garra e {spell:17253}) e o javali aguenta mais pancada.",
	["Tame a beast of your level to keep"] = "Dome uma fera do seu nível para ficar com ela",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger · Venomtail Scorpids = {npc:3127} Venomtail Scorpid
	["Near {area:362}: Durotar Tigers (cats, level 7-8) roam the south of {zone:1411}, from {area:367} down the coast; Venomtail Scorpids (9-10) the north-west toward {zone:1454}; at 11-12, Savannah Huntresses (cats) prowl the plains around the Crossroads in the {zone:1413}."] = "Perto de {area:362}: Tigres de Durotar (felinos, nível 7-8) rondam o sul de {zone:1411}, de {area:367} descendo pela costa; Escorpídeos Caudaçonha (9-10) o noroeste, rumo a {zone:1454}; no nível 11-12, Caçadoras da Savana (felinos) rondam as planícies em volta da Encruzilhada, em {zone:1413}.",
	-- {zone:1412} Mulgore · {zone:1413} Barrens
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler · Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Near Bloodhoof: Flatland Prowlers (cats, level 9) and Prairie Wolf Alphas (wolves, 9-10) roam the plains of northern {zone:1412}; at 11-12, Savannah Huntresses (cats) prowl around the Crossroads in the {zone:1413}."] = "Perto de Casco Sangrento: Predadores das Estepes (felinos, nível 9) e Lobos-da-pradaria Alfa (lobos, 9-10) andam pelas planícies do norte de {zone:1412}; no nível 11-12, Caçadoras da Savana (felinos) rondam em volta da Encruzilhada, em {zone:1413}.",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "Perto de {area:16638}: os Vuldrens Alfa (nível 10), a fera do seu último doma de treino, caçam em {area:16626}; as Matriarcas Guinchote (raptores, nível 9) fazem ninho logo a oeste de {area:16638}; as Urseras Ventosombra (ursos, 10-11) andam pelo norte de {zone:2521}.",
	-- {spell:1584} Feed Pet · {npc:6928} Innkeeper Grosk · {area:362} Razor Hill · {npc:3025} Kaga Mistrunner · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Grimtak the butcher and {npc:6928} in {area:362} sell meat, {npc:3025} in {zone:1456} and the innkeepers on {zone:2521} too; Bloodhoof's innkeeper and bakers sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}: abra o grimório, use {spell:1584} e clique numa comida que a família do seu ajudante come (a dica do ajudante lista: felinos comem carne e peixe, javalis comem quase tudo). Carne crua saqueada de feras serve. Para comprar: Grimtak, o açougueiro, e {npc:6928}, em {area:362}, vendem carne, e também {npc:3025} em {zone:1456} e os estalajadeiros de {zone:2521}; o estalajadeiro e os padeiros de Casco Sangrento vendem pão. Comida perto do nível do ajudante deixa ele mais feliz; comida bem abaixo rende mais ou menos metade. Não dá para alimentar em combate.",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "Felicidade: a carinha no quadro do ajudante. Ajudante infeliz causa três quartos do dano, e o feliz, um quarto a mais. A felicidade cai devagar, e mais rápido quando o ajudante morre; ajudante infeliz por muito tempo pode fugir.",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "A lealdade cresce com o tempo e com os abates. Cada grau de lealdade aumenta os pontos de treino que você gasta em {spell:5149} (nível do ajudante vezes o grau de lealdade menos um).",
	-- {spell:5149} Beast Training · {npc:9987} Shoja'my · {area:362} Razor Hill · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle · {npc:9988} Xon'cha · {zone:1454} Orgrimmar
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master ({npc:9987} in {area:362}, Seikwa at Bloodhoof, {npc:265756} on {zone:2521}, {npc:9988} in {zone:1454}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149} (grimório, aba Geral) ensina ao ajudante atual as habilidades que você conhece. Para aprender uma habilidade ou grau novo: deixe o ajudante com um cavalariço ({npc:9987} em {area:362}, Seikwa em Casco Sangrento, {npc:265756} em {zone:2521}, {npc:9988} em {zone:1454}), dome uma fera que tenha a habilidade (a aba de grimório do ajudante mostra o que ela sabe), use a habilidade nas lutas até o jogo dizer que você aprendeu, depois pegue seu ajudante de volta e ensine com {spell:5149}. Um ajudante tem no máximo quatro habilidades ativas.",
	-- {spell:1853} Growl · {area:362} Razor Hill · {npc:3688} Reban Freerunner · {npc:10088} Xao'tsu · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:10086} Hesuwa Thunderhorn · {zone:1456} Thunder Bluff · {area:1641} Hunter Rise · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar · {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words)
	["Pet trainers sell {spell:1853} ranks and resistances. Horde: Harruk in {area:362}, {npc:3688} at Bloodhoof, {npc:10088} in {zone:1454}'s {object:172958}, {npc:10086} on {zone:1456}'s {area:1641}, {npc:254411} in {area:16638}, later Grokor in {area:75} and Zudd at {object:3202}."] = "Os instrutores de ajudantes vendem níveis de {spell:1853} e resistências. Horda: Harruk em {area:362}, {npc:3688} em Casco Sangrento, {npc:10088} no {object:172958} de {zone:1454}, {npc:10086} em {area:1641}, em {zone:1456}, {npc:254411} em {area:16638}, e mais tarde Grokor em {area:75} e Zudd em {object:3202}.",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}, {spell:2641} e {spell:982} já estão no seu grimório; {spell:136} vem do seu instrutor no nível 12. Ajudante morto precisa de {spell:982}; um que fica a mais de umas 100 metros é dispensado e volta com {spell:883}.",
}
