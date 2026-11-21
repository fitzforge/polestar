-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe para {object:3202}",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "Vindo de {zone:2548}: o mestre de voo de {area:340} fica ao pé da fortaleza.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Mestre de voo de {area:340}",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "Mestre de voo de {area:75}",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1435} Swamp of Sorrows · {zone:1458} Undercity · {object:2076} Bubbling Cauldron
	-- was: ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "O voo pousa em {object:3202}. As tarefas mais difíceis de Selva do Espinhaço, trazidas da sua primeira visita, servem para você agora: o chefe Rachacrânio, os acampamentos de Zanzil, os piratas de {area:35}, a costa das nagas e {npc:1514}, antes do zepelim para {zone:1454}. O {object:2076} ao lado de Nimboya tem a Missão do chefe Rachacrânio."
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the {zone:1435} and the {zone:1458}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}: {quest:586}",

	-- Step 4: Tusks and necklaces on the Skullsplitter hunt
	["Tusks and necklaces on the Skullsplitter hunt"] = "",
	-- {npc:737} Kebok · {npc:2519} Kin'weelay
	["The hunters also drop {npc:737}'s tusks and {npc:2519}'s necklaces. Collect any you still need during the cauldron hunt."] = "",

	-- Step 5: Zul'Mamwe
	["Zul'Mamwe"] = "Ruínas de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "Siga para o leste até as ruínas Rachacrânio a leste da mina da Empreendimentos S.A. Os caçadores de cabeças, berserkers e caçadores andam pelas ruínas.\n{npc:1059} (45) carrega a Armadura Quebrada para {quest:586}: ele anda pelas ruínas a sudoeste com dois guardas e às vezes fica numa caverna pequena ali. Puxe os guardas primeiro.\nCuidado: {npc:1060}, um troll elite (nível 44), fica nas ruínas do sul por volta de 47.7,44.3: afaste os caçadores de cabeças e berserkers dele.",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} anda por aqui: procure dentro do círculo no mapa",

	-- Step 6: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back west to {object:3202}."] = "Volte para o oeste até {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "o {object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "{object:2076} de novo: o destino de Yennikan",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}: os basiliscos tomam sol ao lado da estrada ao sul, no caminho para {area:35}",

	-- Step 8: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Ferroqueixo",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Siga para o sul pela estrada rumo a {area:35}; os basiliscos tomam sol nas pedras a leste dela, no meio da selva. Os fragmentos caem com frequência.",
	["Below ground"] = "Debaixo da terra",

	-- Step 9: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "Fantasmas piratas e acampamentos de Zanzil",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	-- was: ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Siga para sudoeste até a selva a nordeste do Vale da Névoa: os três piratas fantasmas assombram o lugar ao lado dos acampamentos de Zanzil. {npc:2535} e {npc:2536} ficam juntos, {npc:2537} mais a leste. Qualquer seguidor de Zanzil pode carregar a mistura.\nCuidado: os Mandingueiros Zanzil (44) lançam feitiços e os acampamentos são lotados: puxe pela borda, um de cada vez. O próprio {npc:2534} (46) fica no acampamento do sul por volta de 39.6,58.6, a poucos passos do fantasma de {npc:2537}: puxe {npc:2537} para o norte ou leste antes de enfrentá-lo."
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and Jon-Jon stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "",

	-- Step 10: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Para o oeste, no Vale da Névoa: {npc:1449} fica entre os gorilas. Qualquer gorila pode deixar cair uma presa: entregue dez a ele e fique por perto; ele invoca três ondas de gorilas, depois {npc:1514}.\nCuidado: as três ondas de gorilas vêm uma após a outra com pouco descanso, depois {npc:1514}. Comece com vida e mana cheias e fique perto de Unbagwa. Algumas classes acham difícil sozinhas: com um amigo fica fácil.",

	-- Step 11: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}: vá matando estes pelo caminho",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 12: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:35} Booty Bay
	["From the north, take the outer shore east of the {area:35} tunnel. Work south-west through the swashbucklers (41-43) into the camp; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Stay ashore."] = "",

	-- Step 13: Bloodsail tents and rowboat
	["Bloodsail tents and rowboat"] = "",
	["Search the tents and the rowboat for both papers; if one place is empty, try the next. Neither paper is on a ship."] = "",

	-- Step 16: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2486} Fin Fizracket · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "Em {area:35}: {npc:2494} no cais, {npc:2486} perto da Estalagem, {npc:2498} dentro dela, MacKinley, {npc:737} e {npc:773} no andar de cima.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, lá dentro",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",

	-- Step 17: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "",
	-- {area:35} Booty Bay · {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["Under 40 on your first {area:35} visit? {npc:2491}, in the inn, {npc:2486}, beside it, and \"Sea Wolf\" MacKinley, on the top floor, have their quests for you now."] = "",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, na estalagem: as garrafas dele dão na costa de {zone:1425}, por volta do nível 48",
	-- {quest:2872} Stoley's Debt · {npc:7881} Stoley · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for {npc:7881} in {zone:1446} on this guide"] = "",

	-- Step 18: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["North into Mistvale, a short ride from {area:35}: {npc:1449} sits among the gorillas. Hand him ten gorilla fangs and stay by him: three waves of gorillas, then {npc:1514}. Start at full health and mana."] = "",

	-- Step 19: Fin Fizracket
	-- {npc:2486} Fin Fizracket
	["{npc:2486}, by the inn"] = "",

	-- Step 20: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",

	-- Step 21: Krazek
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "{npc:773}, no andar de cima: para {quest:2864} em {area:976}, mais adiante neste Guia",

	-- Step 24: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 28: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 29: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then back to the flight master."] = "",

	-- Step 32: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Voe para {area:75}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:75} Stonard · {area:1978} Misty Reed Post
	["Stranglethorn's errands are done: from {object:3202}'s flight master, fly on to {area:75} for the swamp's coast and {area:1978}, which fit you now."] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Mestre de voo de {object:3202}",

	-- Step 33: To Stonard
	-- {area:75} Stonard
	["To {area:75}"] = "Para {area:75}",
	-- {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1431} Duskwood · {zone:1430} Deadwind Pass
	["No flight path to {area:75} yet: ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "",

	-- Step 34: Stonard
	-- {quest:698} Lack of Surplus · {quest:1424} Pool of Tears · {quest:1430} Fresh Meat · {npc:5593} Katar · {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["The Stranglethorn & Swamp guide already finished {quest:698}' first part and the {quest:1424} with you; its {quest:1430} and {npc:5593}'s murlocs are in your log. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, lá dentro",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, no último andar",

	-- Step 35: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Siga a estrada para o oeste; o pergaminho fica à beira da água, no extremo oeste do pântano.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, on the Dustwallow guide"] = "",

	-- Step 36: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Dentesserra",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "Os crocoliscos chafurdam nas poças em volta do antigo acampamento de Galen, logo ao norte de {area:75}, na volta para o leste; cerca de um em quatro deixa cair um flanco.",

	-- Step 37: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "De volta ao leste, passando por {area:75}: os Artefatos Atal'ai ficam na água e nas margens de {quest:1424}.",

	-- Step 38: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} and {npc:5593}."] = "",

	-- Step 39: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403}: vá matando estes pelo caminho",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "As tartaliscas tomam a praia ao sul do posto.\nOs Rastejantes Monstruosos andam pelas praias da costa leste, poucos e espalhados: mate todos que vir, inclusive os da descida desde o poço.\nCuidado: um {npc:272377} (nível 60) anda pela praia sudeste: passe bem longe dele.",
	["Underwater"] = "Debaixo d'água",

	-- Step 41: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Murlocs de Brumalga",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Os Murlocs do Pântano vivem na praia ao sul do posto; os Jogatintas ficam pela margem a leste dele e os Comecarnes mais a oeste, em volta das cabanas na margem oeste.",

	-- Step 43: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "A mesma costa de murlocs de novo: os Jogatintas a leste do posto, os Comecarnes em volta das cabanas do oeste, e os Oráculos entre os dois.",

	-- Step 45: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 49"] = "",

	-- Step 46: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "",
	-- {area:75} Stonard · {area:1497} Undercity · {area:340} Kargath · {npc:5204} Apothecary Zinge · {zone:1454} Orgrimmar
	["From {area:75}'s flight master, fly to the {area:1497} (by way of {area:340}): {npc:5204}'s errands and your {area:1497} training, then the zeppelin from the towers outside the city to {zone:1454}."] = "",

	-- Step 47: Apothecary Zinge
	-- {npc:2934} Keeper Bel'dugur
	["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, no caminho de volta para Zinge",
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "{item:8523} dessas tarefas: guarde-o, a missão Amostras de campo de Tanaris o devolve em {area:976}",

	-- Step 48: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",

	-- Step 49: Riding at 40
	["Riding at 40"] = "Montaria no 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {zone:1454} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	-- was: ["{npc:4773}, riding trainer"] = "{npc:4773}, instrutora de montaria"
	["{npc:4773}, riding trainer"] = "",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	-- was: ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Cavalos esqueléticos: {npc:4731}, ao lado de {npc:4773} em {area:159}."
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "",

	-- Step 50: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 51: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "O centro de {zone:1454}",

	-- Step 52: Orgrimmar
	-- {zone:1458} Undercity
	["the {zone:1458}'s classes trained there on the way"] = "",

	-- Step 53: Riding at 40
	-- {npc:4752} Kildar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Equitação exige nível 40 e custa 100 ouros; aprendê-la dá a você uma montaria. {npc:4752} ensina os Orcs em {object:172958}, junto ao canil de {npc:3362}. Celonatos aprendem com {npc:265756} em {area:17684}, em {area:16638}, na Ilha de Zefras, com um Vagavento: o barco celeste para a ilha sai dos penhascos ao sul de {area:17045}, ao norte de {zone:1456}, mais ou menos a cada cinco minutos. As outras montarias da sua raça custam 20 ouros cada: Colecionáveis, Montarias · Nível 40 tem um guia para cada uma.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instrutor de montaria",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Lobos: {npc:3362}, ao lado de {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Montaria e Vagaventos: {npc:265756}, em {area:17684}, {area:16638}, na Ilha de Zefras.",

	-- Step 55: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "Equitação exige nível 40 e custa 100 ouros; aprendê-la dá a você uma montaria. Cada raça aprende com o instrutor da própria raça: o seu é {npc:7953} em {area:367}, a uma curta cavalgada ao sul de {zone:1454}, pela estrada de {zone:1411}, com os raptores de Zjolnir (20 ouros cada) ao lado dele. Depois, volte a cavalo até o mestre de voo de {zone:1454}.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptores: Zjolnir, ao lado de {npc:7953} em {area:367}.",

	-- Step 56: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Voe para {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 58: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "Seu instrutor fica em {zone:1456}: {npc:3033} (Druidas) em {area:1639}, {npc:246344} (Paladinos).",

	-- Step 60: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "Equitação exige nível 40 e custa 100 ouros; aprendê-la dá a você uma montaria. Cada raça aprende com o instrutor da própria raça: o seu é {npc:3690} em {area:222}, com os kodos de {npc:3685} (20 ouros cada) ao lado dele. Depois, suba a cavalo de volta ao mestre de voo de {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instrutor de montaria",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, ao lado de {npc:3690} em {area:222}.",

	-- Step 61: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Voe para {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 62: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voe para {area:976}",

	-- Step 65: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} para o Corcel Vil",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "Voe de {zone:1454} para {area:392}; {npc:6251} fica na colina acima das docas.",

	-- Step 66: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 72: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "Chegou voando: primeiro as missões de {area:976}, junto ao mestre de voo; depois {area:2240} fica a uma cavalgada curta ao norte, passando a divisa de {zone:1446}.",
	-- {npc:7407} Chief Engineer Bilgewhizzle · {npc:5204} Apothecary Zinge · {item:8523} Field Testing Kit · {zone:1458} Undercity
	["{npc:7407}: {npc:5204}'s {item:8523}, from the {zone:1458}"] = "",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}: the water pouches come from the same Wastewander camps"] = "",

	-- Step 73: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "Para a masmorra {area:978}, no próximo guia: {quest:2864} quer carapaças de escaravelho, e {npc:7804}, a uma curta caminhada do mestre de voo, quer {quest:3042} dos trolls Zangareia.",

	-- Step 74: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "Se chegou voando em {area:976}: o circuito fica a uma cavalgada curta ao norte, passando a divisa de {zone:1446}.\nA estrada de {area:484} a {zone:1446} passa por {area:2240}, nas {area:439}: {npc:4454} fica no acampamento dos gnomos ao lado da trilha, {npc:4630} e {npc:4709} perto do acampamento dos goblins. {npc:4630} primeiro, depois {npc:4709}, que sai correndo para manter Rizzle ocupado; depois pegue os planos de Rizzle no acampamento dos gnomos e leve-os de volta a {npc:4630}.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}: {quest:1137}, de Martek em {zone:1418}",
	-- {npc:4630} Pozzik · {npc:2496} Baron Revilgaz · {area:35} Booty Bay
	["{npc:4630}: {npc:2496}'s word, from {area:35}"] = "",
	-- {npc:4706} Razzeric · {npc:4630} Pozzik
	["{npc:4706}, beside {npc:4630}"] = "{npc:4706}, ao lado de {npc:4630}",

	-- Step 75: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Para {area:976}",

	-- Step 76: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} é a cidade goblin murada logo depois da fronteira de {zone:1446}.",

	-- Step 78: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}: vá matando estes pelo caminho",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	-- was: ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Os bandidos e ladrões acampam nas dunas a leste de {area:976}. Qualquer Errante pode carregar um cantil: Luglunket quer cinco.\nCuidado: os Ladinos Errantes (nível 43-44) andam furtivos, então podem chegar sem ser vistos."
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five, and Bilgewhizzle five more.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",

	-- Step 79: Gadgetzan
	-- {zone:1446} Tanaris
	["Keep the Model 4711-FTZ Power Source Bilgewhizzle gave you: it starts Tanaris Field Sampling, a two-hour timer, for the {zone:1446} guide at about 48, on the way back north from Scrimshank's hive."] = "",

	-- Step 80: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Siga para o nordeste até o porto goblin na costa.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, lá dentro",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, lá dentro",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on this guide's west sweep"] = "",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}, no píer: a tarefa do Friz de {zone:2548}, se você a tiver",

	-- Step 81: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}: vá matando estes pelo caminho",
	-- {npc:7883} Andre Firebeard · {item:9276} Pirate's Footlocker · {item:9250} Ship Schedule · {area:977} Steamwheedle Port
	-- was: ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Ao sul pela costa, os piratas dos Mares do Sul ocupam a enseada. {npc:7883} e a carga roubada ficam no cais, lá no fundo. Qualquer pirata pode deixar cair um chapéu, os sequestradores mais que todos.\nCuidado: dois ou três piratas ficam com {npc:7883} (45), e muitos outros piratas da vila entram na briga assim que ela começa: primeiro puxe os guardas para longe dele."
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first.\nThe cove's pirates sometimes drop a {item:9276}: open it, and if it holds a {item:9250}, read it to start a quest for the Security Chief in {area:977}."] = "",
	["Upstairs"] = "No andar de cima",
	-- {item:9250} Ship Schedule · {item:9276} Pirate's Footlocker
	["{item:9250}, from a {item:9276}"] = "",

	-- Step 82: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}: vá matando estes pelo caminho",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Os magos das sombras, ladinos e assassinos acampam a sudeste de {area:976}.\nA sudeste de Geringontzan, os bandidos Errantes acampam nas dunas; {npc:7847} fica no acampamento do leste.\nCuidado: os Ladinos Errantes ficam furtivos fora de combate, então ladinos escondidos podem entrar numa briga que você começar num acampamento.\nCuidado: dois Ladinos Errantes furtivos acompanham o Califa aonde ele for. No acampamento onde ele surge, dois magos das sombras e seus lacaios estão perto o bastante para entrar na luta. Lá perto das torres dá para enfrentá-lo sem eles.",

	-- Step 83: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "Siga a cavalo para nordeste de volta ao porto: {npc:7881}, a {npc:15165} e o Chefe de Segurança recebem o que {area:1336} deu a você. {area:976} fica a oeste dele.",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "para {area:35}, por volta do nível 51 (40-50/06)",
	-- {npc:7882} Security Chief Bilgewhizzle · {item:9250} Ship Schedule
	["{npc:7882}: the {item:9250}, if the cove gave you one"] = "",

	-- Step 85: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 87: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777} anda por {area:1099}: procure dentro do círculo no mapa",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}: a tarefa de {npc:263190} de {zone:2548}, se você a tiver",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	-- was: ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, por volta do nível 45"
	["{npc:8115}: for {zone:1454}, around level 47"] = "",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, lá dentro",

	-- Step 88: Gordunni Outpost
	-- {npc:222233} Ohk'zi · {item:9466} Orwin's Shovel · {object:144064} Gordunni Dirt Mound (no name in this language: may be words)
	-- was: ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Ao norte dos gnolls, os ogros ocupam um posto no alto de uma colina; puxe os Ogros-magos até você. O cobalto está nos montes de terra em volta do posto, e o pergaminho fica no chão lá dentro.\nCuidado: {npc:222233} (nível 43, elite) fica no posto: puxe os ogros para fora, até você, longe dele."
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him.\nUse {item:9466} on each {object:144064} around the outpost: the arrow goes from mound to mound."] = "",

	-- Step 89: Woodpaw north camp
	["Woodpaw north camp"] = "Acampamento Patábua do norte",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "Os gnolls Patábua acampam nas colinas logo a noroeste de Mojache; qualquer um pode deixar cair uma juba.\nCuidado: todo gnoll Patábua, menos o Macho Alfa, sai correndo atrás de ajuda com 15% de vida, o que pode trazer mais gnolls para a briga.",

	-- Step 90: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: daqui a uma hora",

	-- Step 91: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}: vá matando estes pelo caminho",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "Os dardejantes esvoaçam sobre o bosque logo a oeste de Mojache; quase todos deixam cair uma asa. Os Machos Alfa Patábua lideram os acampamentos a sudoeste dele: mate-os dentro de uma hora.\nCuidado: a maioria dos Machos Alfa fica em acampamentos pequenos de tenda com mais 2 a 4 gnolls que entram na briga, e outros gnolls patrulham entre os acampamentos.",

	-- Step 93: Grimtotem camp
	["Grimtotem camp"] = "Acampamento Temível Totem",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "Os taurens Temível Totem acampam ao lado do bosque dos Dardejantes; Saqueadores, Naturalistas e Xamãs carregam chifres.\nCuidado: {npc:222286} (nível 43, elite) fica no acampamento: puxe os Saqueadores e Xamãs para longe dela.",

	-- Step 94: Woodpaw battle map
	["Woodpaw battle map"] = "Mapa de batalha Patábua",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "O mapa de batalha fica no acampamento Patábua ao sul de Mojache.",

	-- Step 95: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 47"] = "",

	-- Step 96: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "A colmeia Zukk'ash se entoca nas colinas a sudeste do acampamento; {quest:7731} espera na câmara mais funda.\nCuidado: {quest:7731} é nível 47: limpe a colmeia em volta dele e puxe-o sozinho com a vida cheia.",

	-- Step 97: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}: vá matando estes pelo caminho",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "Siga para o oeste, saindo da colmeia, até as ruínas dos ogros abaixo de {area:1105}. Xamãs, Bruxos e Espancadores as ocupam; os Lordes-magos na ponta sul carregam o orbe.\nCuidado: os Lordes-magos (45-46) e os Xamãs atacam à distância e as ruínas estão lotadas: puxe um de cada vez pela beirada.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234} anda por {area:2522}: procure dentro do círculo no mapa",

	-- Step 98: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "Yetis de {area:1105}",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "A noroeste das ruínas, os yetis têm a toca em {area:1105}; todo yeti de lá pode deixar cair um couro grosso.",

	-- Step 99: Rogue Vale screechers
	["Rogue Vale screechers"] = "Guinchadores Errantes do Vale",
	-- {area:1099} Camp Mojache · {area:1105} Feral Scar Vale · {item:10699} Yeh'kinya's Bramble · {npc:8579} Yeh'kinya · {area:977} Steamwheedle Port · {zone:1446} Tanaris
	-- plural, as words: Rogue Vale Screechers = {npc:5308} Rogue Vale Screecher
	["On the way back north-east towards {area:1099}, the Rogue Vale Screechers (44-46) hunt the open ground north of {area:1105}. Kill one, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all; {npc:8579} takes them in {area:977} on your next {zone:1446} visit."] = "",

	-- Step 100: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "Só com o transmissor de emergência: qualquer fera, gnoll ou ogro em {zone:1444} pode deixá-lo cair, cerca de uma morte em cem; use-o para iniciar a missão. O robô fica numa pequena caverna no lado norte de {area:1105}, logo a noroeste das ruínas. Escolte-o até o cais em {area:1108}; yetis e gorilas emboscam vocês no caminho. A recompensa dele espera em {area:35}, para uma visita posterior.\nCuidado: três emboscadas surgem durante a escolta, e o robô avisa antes de cada uma. A primeira é de 3 yetis, logo depois que o robô sai da caverna e sobe rumo à estrada. A segunda é de 3 gorilas, na trilha que corre ao longo do penhasco. A terceira é de cerca de 4 gnolls, um deles lançador de feitiços, onde a rota desvia rumo ao cais.",

	-- Step 101: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "os yetis Cortifúria, na próxima visita a {zone:1444}",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}: para {npc:7010}, em {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "para {zone:1454}, depois de {zone:2652}",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "{zone:2652} é o próximo, a uma cavalgada ao norte de {area:1099}, em {zone:1443}: guarde as entregas de {zone:1454} (Neeru, Zilzibin, {npc:4485}, {npc:7311}) para o voo até lá depois.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "Volte para a cidade. Os capitães dos navios, o próximo pedido de Chifremar, ficam para a sua parada em Selva do Espinhaço por volta do nível 50.",
	-- ["Eastern Wastewander camps"] = "Acampamentos Errantes do leste",
	-- ["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Voe para {area:1637}. Os irmãos Droffers têm sua loja no Drag.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Voe para {area:484}, desça pelo elevador a leste do posto, atravesse as salinas e siga para o sul até {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Voe para {area:484} e siga para o oeste pelos cânions, passando por {area:2237}; a estrada sobe para a selva de {zone:1444} e segue até {area:1099}.",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Voe para {zone:1454}. A partir do mestre de voo: o {object:172960}, depois o Drag, depois o {object:172958}.",
	-- ["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "Voe para {zone:1454}. Os irmãos Droffers têm a loja deles no Drag.\n{object:172958}, depois {object:172960} e {object:172961}.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Vagaventos: {npc:265756}, em {area:16638}, na Ilha de Zefras.",
	-- ["Hearth to {area:1099}"] = "Regresse para {area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Continue para o oeste até a costa. Os Olhabismos e Estalagarras da Areia nas praias deixam cair o sinalizador de socorro do OOX-22/FE em cerca de uma morte a cada quarenta: se cair, use-o para iniciar a missão.",
	-- ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Ao norte dos gnolls, os ogros ocupam um posto no alto de uma colina; puxe os Ogros-magos até você. O cobalto está nos montes de terra em volta do posto, e o pergaminho fica no chão lá dentro.\nCuidado: {npc:222233} (nível 43, elite) fica no posto: puxe os ogros para fora, até você, longe dele.",
	-- ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Siga para sudoeste até a selva a nordeste do Vale da Névoa: os três piratas fantasmas assombram o lugar ao lado dos acampamentos de Zanzil. {npc:2535} e {npc:2536} ficam juntos, {npc:2537} mais a leste. Qualquer seguidor de Zanzil pode carregar a mistura.\nCuidado: os Mandingueiros Zanzil (44) lançam feitiços e os acampamentos são lotados: puxe pela borda, um de cada vez. O próprio {npc:2534} (46) fica no acampamento do sul por volta de 39.6,58.6, a poucos passos do fantasma de {npc:2537}: puxe {npc:2537} para o norte ou leste antes de enfrentá-lo.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Só com o sinalizador de socorro: o robô fica numa pequena caverna no lado norte de {area:1105}. Escolte-o até o cais na {area:1108}; yetis e gorilas emboscam você no caminho. A recompensa espera em {area:35} para uma visita futura.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Volte para o noroeste de {area:1978} até {area:75} e voe para {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Volte para o oeste até {area:976}.",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Siga para o oeste, saindo da colmeia, até as ruínas dos ogros abaixo de {area:1105}. Xamãs, Bruxos e Espancadores as ocupam; os Lordes-magos na ponta sul carregam o orbe.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Siga para o oeste até o meio de {zone:1444}. Mate um {npc:5308}, use {item:10699} no corpo e mate o espírito que surgir.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:3690} em {area:222}, com os kodos de {npc:3685} (20 de ouro cada) ao lado. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:4773} em {area:159}, com os cavalos esqueléticos de {npc:4731} (20 de ouro cada) ao lado dela. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:7953} em {area:367}, no litoral de {zone:1411}, com os raptores de Zjolnir (20 de ouro cada) ao lado. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. {npc:4752} ensina Orcs em {object:172958}, junto ao canil de {npc:3362}; não se conhece instrutor de montaria celonato, então os Celonatos também tentam {npc:4752}. As outras montarias da sua raça custam 20 de ouro cada: Colecionáveis, Montarias · Nível 40 tem um guia para cada.",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Cavalos esqueléticos: {npc:4731}, ao lado de {npc:4773} em {area:159}.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Ao sul pela costa, os piratas dos Mares do Sul ocupam a enseada. {npc:7883} e a carga roubada ficam no cais, no fundo dela. Qualquer pirata pode deixar cair um chapéu, os Sequestradores com mais frequência.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Ao sul pela costa, os piratas dos Mares do Sul ocupam a enseada. {npc:7883} e a carga roubada ficam no cais, lá no fundo. Qualquer pirata pode deixar cair um chapéu, os sequestradores mais que todos.\nCuidado: dois ou três piratas ficam com {npc:7883} (45), e muitos outros piratas da vila entram na briga assim que ela começa: primeiro puxe os guardas para longe dele.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Ao sul pela costa, os piratas dos Mares do Sul ocupam a enseada. {npc:7883} e a carga roubada ficam no cais, lá no fundo. Qualquer pirata pode deixar cair um chapéu, os sequestradores mais que todos.\nCuidado: dois ou três piratas ficam com {npc:7883}, e muitos outros piratas da vila entram na briga assim que ela começa.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Ao sul de Angra do Butim, os Espadachins da Vela Sangrenta acampam em {area:43}; os mapas e as ordens ficam nas barracas deles e no bote ao lado do acampamento maior. Qualquer pirata da Vela Sangrenta pode levar rapé e o olho do {npc:2493}, então continue matando até ter os dois.",
	-- ["Southern Gordunni ruins"] = "Ruínas Gordunni do sul",
	-- ["Southern Wastewander camps"] = "Acampamentos Errantes do sul",
	-- ["Sprite darters and Woodpaw alphas"] = "Dardejantes e Machos Alfa Patábua",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Os gnolls Patábua acampam nas colinas logo a noroeste de Mojache; qualquer um deles pode deixar cair uma juba.",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "A colmeia Zukk'ash se entoca nas colinas a sudeste do acampamento; {quest:7731} espera na câmara mais funda.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Os bandidos e ladrões acampam nas dunas a leste de {area:976}. Qualquer Errante pode carregar um cantil: Luglunket quer cinco.\nCuidado: os Ladinos Errantes (nível 43-44) andam furtivos, então podem chegar sem ser vistos.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Os Bandidos e Ladrões Errantes acampam nas dunas a leste de {area:976}. Todo Errante pode carregar uma bolsa de água: guarde dez, cinco para cada recompensa de Rastamala.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Os bandidos e ladrões acampam nas dunas a leste de {area:976}. Qualquer Errante pode carregar um cantil: guarde dez, cinco para cada recompensa do Rastamala.\nCuidado: os Ladinos Errantes (nível 43-44) andam furtivos, então podem chegar sem ser vistos.",
	-- ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "O voo pousa em {object:3202}. As tarefas mais difíceis de Selva do Espinhaço, trazidas da sua primeira visita, servem para você agora: o chefe Rachacrânio, os acampamentos de Zanzil, os piratas de {area:35}, a costa das nagas e {npc:1514}, antes do zepelim para {zone:1454}. O {object:2076} ao lado de Nimboya tem a Missão do chefe Rachacrânio.",
	-- ["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "O voo pousa em {object:3202}: {npc:2519} e {npc:2465}, depois a torre do zepelim.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Os Magos das Sombras, Ladinos e Assassinos Errantes acampam a sudeste de {area:976}.",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Os Dardejantes voejam sobre o bosque logo a oeste de Mojache; quase todos deixam cair uma asa. Os Machos Alfa Patábua lideram os acampamentos a sudoeste dele: mate-os dentro de uma hora.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "O zepelim para {object:3202} sai da torre logo a nordeste do portão principal de {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "O zepelim para {zone:1454} sai da torre ao lado de {object:3202}; ele pousa logo fora do portão principal de {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, a mestre de voo, fica logo a leste da torre do zepelim. Voe para {area:75}: o próximo guia começa lá.",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "Para o oeste até a costa: os exploradores naga andam pela praia e carregam os feixes de junco; {object:759} borbulha nas colinas logo a leste deles. Depois siga a costa para o sul até {area:35}.",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Seu instrutor fica em {area:1638}: {npc:3033} (Druidas) em {area:1639}, {npc:246344} (Paladinos). Voe para lá de {zone:1454} e depois siga para {area:484}.",
	-- ["Zeppelin to {object:3202}"] = "Zepelim para {object:3202}",
	-- ["Zeppelin tower"] = "Torre do zepelim",
	-- ["for the {zone:1425}, around level 48"] = "para {zone:1425}, por volta do nível 48",
	-- ["for {area:35}, around level 50"] = "para {area:35}, por volta do nível 50",
	-- ["for {zone:1454}, around level 45"] = "para {zone:1454}, por volta do nível 45",
	-- ["the {object:150075} in the square"] = "{object:150075} na praça",
	-- ["water pouches in your bags"] = "bolsas de água nas bolsas",
	-- ["{area:1099} flight master"] = "Mestre de voo de {area:1099}",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} é a cidade goblin murada logo depois da fronteira de {area:440}.",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, no último andar",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}: os {item:5852} de {npc:2496}, se estiver com eles",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, instrutora de montaria",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}, no Drag",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}, no Drag",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",
	-- ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, por volta do nível 45",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: os guinchadores vivem em {zone:1444}",
	-- ["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}: os guinchadores vivem em {zone:1444}, na próxima visita a {zone:1444}",
}
