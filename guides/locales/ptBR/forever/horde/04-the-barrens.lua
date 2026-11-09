-- Portuguese (Brazil) (ptBR): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Crossroads
	["Fly to Crossroads"] = "Voe para a Encruzilhada",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 2: The road west
	["The road west"] = "",
	["The road west past Seereth's camp"] = "",

	-- Step 3: Malaka'jin
	-- {npc:3995} Witch Doctor Jin'Zil · {area:2539} Malaka'jin · {area:1076} Webwinder Path
	["Follow the road west past Regthar's bunkers and Seereth's camp into Stonetalon: {npc:3995} waits below ground in {area:2539}, at the foot of the {area:1076}."] = "Siga a estrada para oeste, passando pelos bunkers de Regthar e pelo acampamento de Seereth, até Torres de Pedra: {npc:3995} espera no subterrâneo em {area:2539}, ao pé de {area:1076}.",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "{npc:3995}, no subterrâneo",

	-- Step 4: Sun Rock Retreat
	-- {area:1076} Webwinder Path · {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["Up the {area:1076} past {npc:4201} and west to {area:460}."] = "Suba {area:1076}, passando por {npc:4201}, e vá para oeste até {area:460}.",
	-- {npc:11862} Tsunaman · {npc:12736} Je'neu Sancrea
	["{npc:11862}: {npc:12736} at Zoram'gar, next guide"] = "{npc:11862}: {npc:12736} em Zoram'gar, no próximo guia",
	-- {npc:11860} Maggran Earthbinder · {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["{npc:11860}: {npc:12576} is at the {area:1718}, later in this guide"] = "{npc:11860}: {npc:12576} fica em {area:1718}, mais adiante neste guia",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Pedras Solares Lampejantes das harpias Furissangue",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, do lado de fora do portão",

	-- Step 5: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Sementes de Gaia",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "As Sementes de Gaia ficam na grama em volta da margem sul de {area:464}, ao norte de Rocha do Sol.\nCuidado: as Asaltivas em volta do lago podem vir em bando.",

	-- Step 6: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "{zone:1442}: vá matando estes pelo caminho",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Siga a estrada para o norte rumo a {area:467}. Ginetes Galhados pastam pelo caminho; as Feras de Seiva, os Corredores do Crepúsculo e os Dragões Encantados vagam pela mata abaixo do pico, e os druidas cenarianos ocupam o bosque de lá.",

	-- Step 7: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "A próxima missão de {npc:4198}, Ornanos, fica no lado da Aliança de {zone:1440}. Pule-a.",

	-- Step 8: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "{area:465}: vá matando estes pelo caminho",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "A sudoeste da Rocha do Sol fica o {area:465}, queimado. Plante as Sementes de Gaia nos montes de terra no fundo do vale; os elementais de fogo deixam cair {item:16312}. Harpias e Emboscadoras Furissangue fazem ninho no lado norte, Matadoras e Plumerrantes ao sul.",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, de qualquer harpia Furissangue",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Montes de Terra de Gaia",

	-- Step 9: Sun Rock Retreat
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, ao lado de {npc:11862}",
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, lá em cima na saliência",

	-- Step 10: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "Desça de volta por {area:1076} até {area:2539}.",

	-- Step 11: To Camp Taurajo
	-- {area:378} Camp Taurajo
	["To {area:378}"] = "",

	-- Step 12: Camp Taurajo
	-- {area:2539} Malaka'jin · {area:378} Camp Taurajo
	["From {area:2539} follow the road east to Seereth's camp, then south-east across the plains to {area:378}."] = "De {area:2539}, siga a estrada para leste até o acampamento de Seereth, depois para sudeste pelas planícies até {area:378}.",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, na borda norte do acampamento",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, na jaula",

	-- Step 13: Grunt Logmar
	-- {npc:5911} Grunt Logmar · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["{npc:5911} stands by the flight master. His {npc:268623} (23) is elite: grouping up is advised; the two Encroaching Soldiers are not."] = "{npc:5911} fica ao lado do mestre de voo. O {npc:268623} dele (23) é elite: recomenda-se formar grupo; os dois Soldados Invasores não.",
	-- {npc:5911} Grunt Logmar · {npc:3341} Gann Stonespire
	["{npc:5911}: the soldiers and the pillager camp just east of {npc:3341}, on the way south"] = "{npc:5911}: os soldados e o pilhador acampam logo a leste de {npc:3341}, no caminho para o sul",

	-- Step 15: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "A cabana de {npc:5899} fica na crista acima do bebedouro dos javaligs, ao sul de {area:378}, no caminho até {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: o odre vermelho de {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: o odre azul é enchido em {zone:1440}, no próximo guia",

	-- Step 16: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan · {npc:14242} Sulhasa
	["{npc:3341} walks the road south toward {area:359}, between about 46,75 and 46,81: if he isn't at the arrow, follow the road until you meet him. {npc:14242} sits up in the tree just east of the road at 47.9,77.5."] = "{npc:3341} anda pela estrada para o sul, rumo a {area:359}, entre cerca de 46,75 e 46,81: se ele não estiver na seta, siga a estrada até encontrá-lo. {npc:14242} fica empoleirado na árvore logo a leste da estrada, em 47.9,77.5.",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "{npc:3341} anda por {area:1701}: procure dentro do círculo no mapa",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, no alto da árvore logo a leste de {npc:3341}",

	-- Step 17: Wrongly Blamed, Justly Corrected
	-- {npc:14242} Sulhasa · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["A few steps east of {npc:14242}'s tree, a small camp: two Encroaching Soldiers and the {npc:268623} for Logmar. The {npc:268623} is elite: grouping up is advised."] = "A poucos passos a leste da árvore de {npc:14242}, um acampamento pequeno: dois Soldados Invasores e o {npc:268623} de Logmar. O {npc:268623} é elite: recomenda-se formar grupo.",

	-- Step 18: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "Ao sul de Gann, os anões de Bael'dun escavam em {area:359}. Escavadores e Encarregados trabalham no buraco; {npc:3392} (26) está com o diário: puxe-o sozinho.\nCuidado: Escavadores (nível 21-22) e Encarregados (nível 22-23) saem correndo atrás de ajuda quando caem para 15% de vida, então mais anões podem entrar na briga.",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "{npc:3375} anda por {area:359}: procure dentro do círculo no mapa",

	-- Step 19: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "A oeste de Gann, os Crinavalha ocupam {area:1701}. {npc:3436} fica no lado leste, {npc:3434} ao sul, {npc:3435} na ponta oeste. Lok (25) e os Belicosos (24-25) estão alguns níveis acima de você; {npc:5859}, um elite raro, às vezes anda pela serra: deixe-o em paz. Desbravadores e Espreitadores deixam cair o Punhal, Videntes a Varinha, Belicosos o Escudo de Guerra. {quest:885}, uma serpente alada vermelha rara, sobrevoa a serra: a pena dela inicia uma missão.\nCuidado: os Espreitadores Crinavalha se movem furtivos e atacam com {spell:1752}, então podem entrar na briga sem aviso.",

	-- Step 20: Field to Clear
	-- {npc:3341} Gann Stonespire · {npc:3238} Stormhide
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["On the way back east to {npc:3341}: Hecklefang Stalkers and {npc:3238} lizards roam the plain between the ridge and his camp."] = "No caminho de volta para o leste, até {npc:3341}: Espreitadores Presavaia e lagartos {npc:3238} andam pela planície entre a serra e o acampamento dele.",
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "{npc:4128} anda por {area:1156}: procure dentro do círculo no mapa",

	-- Step 22: Bael'dun fortress
	["Bael'dun fortress"] = "Fortaleza de Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "Os Soldados, Carabineiros e Oficiais de Bael'dun guardam a fortaleza no lado leste da escavação; os três itens caem deles.\nCuidado: os Carabineiros (nível 24-25) atiram de 5 a 30 metros, então os que estiverem perto podem entrar na briga à distância.",

	-- Step 24: The flying machine
	["The flying machine"] = "A máquina voadora",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "A máquina voadora dos anões fica na plataforma dentro do sítio de escavação.",

	-- Step 26: Great Lift
	-- {area:1718} Great Lift
	["The top of the {area:1718}"] = "",

	-- Step 27: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "A sudoeste de Bael Modan, {npc:12576} espera no alto de {area:1718}.",

	-- Step 28: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "{area:1718}",
	-- {npc:10079} Brave Moonhorn · {area:1718} Great Lift · {npc:12576} Grish Longrunner
	["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "{npc:10079} fica no alto de {area:1718}, ao lado de {npc:12576}.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, no alto do elevador",

	-- Step 31: Grunt Logmar
	-- {npc:5911} Grunt Logmar
	["{npc:5911}, beside the flight master"] = "{npc:5911}, ao lado do mestre de voo",

	-- Step 32: Fly to Crossroads
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "Mestre de voo de {area:378}",

	-- Step 33: The Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, no alto da torre",

	-- Step 34: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voe para {area:392}",
	["Crossroads flight master"] = "Mestre de voo da Encruzilhada",

	-- Step 35: Merchant Coast
	-- {quest:874} Mahren Skyseer · {area:392} Ratchet
	["{quest:874} camps on the shore just north of {area:392}'s flight master."] = "{quest:874} acampa na praia logo ao norte do mestre de voo de {area:392}.",

	-- Step 36: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, um grande manguadonte, nada nas águas rasas da {area:391}, a leste de {npc:3388}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Ajude {npc:261366}: fique ao lado dele quando {npc:261367} e os fuzileiros de {area:21} subirem a serra",
	-- ["Back to the {area:380}"] = "De volta a {area:380}",
	-- ["Bristleback camps"] = "Acampamentos Costagulha",
	-- ["Bruuz"] = "Bruuz",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Lance {spell:18960}. Taurens: juntem as duas metades do pingente em {area:2362}, na margem noroeste do lago, antes de falar com {npc:11802} em {area:2361}.",
	-- ["Dogran is chained up in the quilboar camp west of the road."] = "Dogran está acorrentado no acampamento de javatuscos a oeste da estrada.",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doraso, o mestre de mantícoras, fica na torre em {object:172982}.",
	-- ["Down the {area:458} to {area:378} again."] = "Desça {area:458} até {area:378} de novo.",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Para o leste pelas planícies, rumo à costa: a prata roubada está num ninho de raptores a noroeste de {area:385}.",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Para o leste, até {area:382}. {npc:3439} fica dentro do acampamento da Empreendimentos S.A.; {npc:3445} carrega a chave.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Encha o {item:7766} no bebedouro dos javatuscos",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule comanda o acampamento da Empreendimentos S.A. na ponta leste de {area:382}. Ele ataca estranhos: selecione-o e use /saudar antes que ele ataque.",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Volte voando para {area:380}. O próximo guia começa aqui e segue a estrada para o norte até {area:1703} e {zone:1440}.",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Voe para {area:1637} para treinar as habilidades de nível 20. {npc:3354} fica em {object:172958}, {npc:5892} em {object:172957}.",
	-- ["Fly to {area:1637} to train."] = "Voe para {area:1637} para treinar.",
	-- ["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Voe para {area:1638} e treine as habilidades de nível 20: {npc:3033} fica em {area:1639}.",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Voe para {area:1638} para treinar: {npc:3033} fica em {area:1639}.",
	-- ["Follow the {area:458} south to {area:378}."] = "Siga {area:458} para o sul até {area:378}.",
	-- ["He gives you the {item:15826}"] = "Ele dá a você {item:15826}",
	-- ["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Em seguida ele oferece {quest:1838} (1838, nível 30): ela exige {area:1717} e manda você por toda Kalimdor e pelos Reinos do Leste. O guia da classe Guerreiro {quest:1838} cobre essa missão.",
	-- ["Hearth to the {area:380}"] = "Regresse para {area:380}",
	-- ["Keep it: the {object:107045} is beside {area:272}"] = "Guarde-a: {object:107045} fica ao lado de {area:272}",
	-- ["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Guarde-a: {npc:12696} em {zone:1440}, próximo guia",
	-- ["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Guarde-a: {npc:5875} em {zone:1454}, no fim deste guia",
	-- ["Level 20"] = "Nível 20",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Para o norte, até {area:383}. {npc:3682} acampa abaixo das colinas; {npc:261366}, o eremita na serra atrás dele, só tem trabalho para você depois que {npc:3682} mandar você subir.",
	-- ["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "Na volta por {area:458} até {area:378}: os Saqueadores Crinavalha entre os acampamentos Costagulha, dos dois lados da estrada ao norte do acampamento, carregam {item:277277}. Entregue-os a {npc:3432} na última parada em {area:380}.",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Siga para o norte de {area:380} até {area:384} e encha o {item:15842} em {object:19464}, depois volte a {npc:3448} em {area:380}. Sem {skill:182}? {npc:3490}, ao lado dele, vende {item:2449}, três por vez até repor o estoque.",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Patriarcas da Savana vagam pelas planícies a leste das colinas, e as Armadilhas Disparadas ficam entre eles. {quest:876} lidera as harpias Asabruxa nas colinas a oeste.",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Ao sul do Acampamento Taurajo, Montes de Terra Silitídeos se espalham por {area:390}; os ovos ficam neles, e Enxameadores Silitídeos saem para defendê-los. Ceifadores Silitídeos são raros: se vir um, mate-o pela cabeça.",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Ao sul de Gann, os anões de Bael'dun escavam em {area:359}. Escavadores e Encarregados trabalham no fosso; {npc:3392} (26) carrega o diário: puxe-o sozinho.",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Fique em furtividade: {npc:7287} carrega a chave da torre; Gallywix e o cofre dele ficam no alto. Gallywix é elite: é recomendado formar um grupo.",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Garrafoices Helióscamos caçam nas planícies ao sul de {area:380}, em volta de {area:1697}; eles deixam cair os chifres. Entregue-os na próxima passagem por {area:392}.",
	-- ["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Taurens: {npc:11957} espera na colina ao sul, acima da ponte. Celonatos: {npc:272054} fica ao sul das pontes gêmeas. Depois, as tocas a leste do lago: saia da forma, clique na estátua da entrada para ganhar cinco minutos de furtividade, evite os espíritos lá dentro e pegue uma de cada relíquia; {item:280680} fica ao pé da estátua do gato branco.",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Os Soldados, Carabineiros e Oficiais de Bael'dun guardam a fortaleza no lado leste da escavação; os três itens caem deles.",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Os acampamentos dos javatuscos Costagulha se espalham pelas planícies ao norte de {area:378}, dos dois lados de {area:458}. Todo Costagulha deixa cair uma presa; a esposa de {npc:3432} jaz na borda norte. Guarde um {item:5075}. {quest:883}, um kodo cinza, às vezes passa por aqui: o casco dele inicia uma missão.",
	-- ["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Os Feitores e Seguranças da Empreendimentos S.A. na mina do canto nordeste da zona deixam cair {item:5097}.",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "As antenas somem quinze minutos depois de cair, então colete-as agora, na volta para o norte: mate Enxameadores e Rastejantes Silitídeos nos montes de {area:390} até ter cinco, depois regresse para {area:378} imediatamente.",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "As missões de classe de nível 20 em {zone:1454} ({npc:3354}, {npc:5892}, os instrutores de Bruxo e Ladino) só são oferecidas a partir do nível 20, então complete o nível aqui antes de voar. Os Filhotes de Falcotrom (18) nas planícies a sudoeste de {area:380} e os Kolkar (14-15) em {area:388} são as criaturas mais próximas que valem a pena; falta bem menos de um nível.",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Os piratas acampam na praia ao sul de {area:392}; {npc:3467} fica na ponta sul.",
	-- ["The {area:2363}"] = "{area:2363}",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:172960} is the canyon under the {object:172982}."] = "O {object:172960} é o cânion sob o {object:172982}.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} fica na borda norte de {area:382}, junto à torre da Empreendimentos S.A. Contém {item:15883} para {quest:30}.",
	-- ["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Falcotrons Raspa-nuvens voam em círculos sobre as mesmas planícies ao sul do acampamento.",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Cabeças-de-trovão pastam nas planícies logo ao sul de {area:378}. {quest:884}, um lagarto-trovão azul, vaga entre eles: a Ponta da Cauda dele inicia uma missão.",
	-- ["Twitching Antennae"] = "Antenas Agitadas",
	-- ["Twitching Antennae from the silithid"] = "Antenas Agitadas dos silitídeos",
	-- ["Venture Co. tower"] = "Torre da Empreendimentos S.A.",
	-- ["While you are in the dig: {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Já que está na escavação: {npc:3421} se esconde na borda sul da escavação; {object:3646} fica no fundo do fosso.",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Manivela pilota o retalhador para fora do acampamento: fique com ele e mate o que o atacar. {npc:3442} o recebe em {area:392}.",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "mate Filhotes de Falcotrom a sudoeste de {area:380}",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, mais ao sul pela costa. Os Fuzileiros e as Preservadoras de Theramore (15-16) deixam cair as medalhas; {npc:3393} (20) e os dois canhoneiros (19) ficam na fortaleza e nas muralhas, e é por eles que o forte ficou para agora.",
	-- ["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: Kodos Perdidos dos Sertões nas planícies em volta do acampamento kolkar",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: use uma metade em {area:2362}",
	-- ["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} de {npc:3490}; herbalistas colhem nas planícies",
	-- ["{item:2449}: herbalists pick it here"] = "{item:2449}: herbalistas colhem aqui",
	-- ["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798}, em {area:2361}, leva druidas voando até lá",
	-- ["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: as boas-vindas de {npc:3033}",
	-- ["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: use {item:15826} nelas; elas vagam pelas planícies em volta de {area:380}",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} nada no porto, logo além do cais de {area:392}. {npc:209797} é elite: é recomendado formar um grupo.",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391}, em {area:272}, ensina Venenos: guarde-a",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} treina Paladinos em {area:1638}. Você ainda não tem rota de voo lá: voe para {area:378}, siga para o oeste por {zone:1412}, suba um elevador e pegue a rota de voo com {npc:2995} no platô central.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} e seus fuzileiros ocupam a caravana destruída ao sul de {npc:261366}.",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, na planície entre {npc:3341} e a serra",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} espera num pequeno acampamento mais ao sul, na estrada para {area:359}.",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}; {npc:14242} sits up in the tree just east of him."] = "{npc:3341} espera num pequeno acampamento mais ao sul, na estrada para {area:359}; {npc:14242} fica no alto da árvore, logo a leste dele.",
	-- ["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} fica no posto de vigia kolkar logo a oeste de {area:380}.",
	-- ["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} fica no acampamento kolkar a noroeste de {npc:3389}.",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} anda entre os Kolkar em {area:388}, a sudeste de {area:380}.",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} lidera os Kolkar na margem oeste de {area:387}, ao sul de {npc:3389}. Entregue a cabeça dele a {npc:3389} na última parada em {area:380}.",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} fica em {object:172960}. Selecione-o e digite /saudar para concluir {quest:2460}.",
	-- ["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: os ovos ficam em {area:390}, mais tarde",
	-- ["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Guarde-a: Kadrak em {area:1703}, próximo guia",
	-- ["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} oferece {quest:95774} depois que {quest:4921} for entregue",
	-- ["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, ao lado do mestre de mantícoras. Guarde-a: {quest:1483} fica na Cordilheira das Torres de Pedra, mais tarde",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}, no cais",
	-- ["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} está acorrentado dentro do forte. Fale com ele para iniciar a escolta e fique perto: soldados de Theramore atacam na saída. Ele leva você de volta a {area:392}.",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vive em {area:2539}, a aldeia troll logo na entrada da Cordilheira das Torres de Pedra, no fim da estrada a oeste de {npc:3389}.",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} fica em {object:172960}. Use {item:6626} no círculo de invocação ali e derrote a súcubo para vinculá-la.",
	-- ["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} acampa ao lado da estrada a leste de {area:380}.",
	-- ["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, logo a oeste de {npc:3341}",
	-- ["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} espera na colina ao sul de {area:392}, no caminho para o norte.",
	-- ["{npc:5909}, a few steps away"] = "{npc:5909}, a poucos passos",
	-- ["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} fica em {object:172961}, no lado oeste da cidade.",
	-- ["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} em {zone:1458}, daqui a dois guias",
	-- ["{object:3646}; below ground"] = "{object:3646}; no subterrâneo",
	-- ["{object:3972} poster"] = "cartaz {object:3972}",
	-- ["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, junto a {area:382}",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, um grande raptor Helióscamo, caça nas planícies ao norte da estrada de {area:392} para {area:380}.",
}
