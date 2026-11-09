-- Portuguese (Brazil) (ptBR): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "Você começa na mesa da {area:221}. {npc:2980} e o chefe ficam junto à grande tenda no centro.",
	-- {npc:2981} Chief Hawkwind
	["{npc:2981}, inside"] = "{npc:2981}, lá dentro",

	-- Step 2: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {object:2907} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {object:2907} stands next to her."] = "{npc:2991} fica sentada junto à tenda na borda leste do acampamento; {object:2907} está ao lado dela.",

	-- Step 3: Camp Narache: kill these as you meet them
	-- {area:221} Camp Narache
	["{area:221}: kill these as you meet them"] = "{area:221}: vá matando estes pelo caminho",
	-- {npc:2980} Grull Hawkwind
	["Plainstriders roam the mesa all around the camp: take their meat and feathers on the way back to {npc:2980}."] = "Os Pinotes andam pela mesa em volta do acampamento: pegue a carne e as penas deles na volta até {npc:2980}.",

	-- Step 4: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer; inside"] = "{npc:3059}, o instrutor de guerreiro; lá dentro",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}, a instrutora de caçador",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}, a instrutora de xamã no acampamento",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}, o instrutor de druida ao lado dele",
	["Inside"] = "Lá dentro",

	-- Step 5: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775} fica no extremo oeste do acampamento, no canto noroeste das colinas onde rondam os Pumas da Montanha: pegue a missão dele, cace os pumas dali para o sul e o leste e depois volte até {npc:2980}.",

	-- Step 6: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind · {area:221} Camp Narache
	["{npc:3209}, next to {npc:2980}; walks around {area:221}: look inside the circle on the map"] = "{npc:3209}, ao lado de {npc:2980}; anda por {area:221}: procure dentro do círculo no mapa",

	-- Step 7: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "Siga a trilha para o sul saindo do acampamento até a tenda do Vidente, no sopé das colinas.",

	-- Step 8: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "O santuário de An'she e Mu'sha",
	-- {object:660739} Ritual Fire
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "O incenso se apaga em dez minutos: corra direto para o leste pelas colinas do sul até a {object:660739}.",

	-- Step 9: Red Cloud Mesa: kill these as you meet them
	-- {area:220} Red Cloud Mesa
	["{area:220}: kill these as you meet them"] = "{area:220}: vá matando estes pelo caminho",
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "Javaliços pastam ao norte do santuário; os javatuscos Costagulha ocupam a ravina a nordeste. {npc:8554} fica no extremo leste dela, e o {object:3076} está no chão do acampamento.",
	["Below ground"] = "No subterrâneo",

	-- Step 10: Deathskip to Red Cloud Mesa
	-- {area:220} Red Cloud Mesa
	["Deathskip to {area:220}"] = "Atalho fantasma até {area:220}",
	-- {npc:2954} Bristleback Battleboar · {npc:6491} Spirit Healer
	["Die to the mobs at 63.7,78.4 ({npc:2954}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "Morra para os monstros em 63.7,78.4 ({npc:2954}): morrendo ali, você vai parar neste cemitério. Libere o espírito e aceite a ressurreição do {npc:6491}.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "Volte para oeste até o acampamento.",
	-- {npc:3209} Brave Windfeather · {area:221} Camp Narache
	["{npc:3209} walks around {area:221}: look inside the circle on the map"] = "{npc:3209} anda por {area:221}: procure dentro do círculo no mapa",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888} fica na {area:221}. {quest:1516} requer nível 4, que você alcança com as entregas daqui.",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "Volte para leste até a {area:358}: os Xamãs Costagulha ficam entre os javatuscos de lá.",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "Volte até {npc:5888} no acampamento. A {npc:5891} espera na mesa a leste do acampamento: beba a {item:6635} lá para vê-la, depois leve o {item:6656} de volta ao Vidente.",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888}: {npc:5873} e o seu {item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "Siga a estrada para o norte saindo de {area:220}. {npc:265810} espera na estrada logo ao sul de {area:222}; use /sit junto à fogueira dela até ganhar {spell:1229451}.",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "Use /sit junto à fogueira de Kaja até ganhar {spell:1229451}",

	-- Step 16: Bloodhoof Village
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "Missão de {npc:3063}: vença três Guerreiros Novatos (ou jogadores em duelos) ao lado dele.",
	-- {npc:3222} Brave Wildrunner · {area:222} Bloodhoof Village
	["{npc:3222} walks around {area:222}: look inside the circle on the map"] = "{npc:3222} anda por {area:222}: procure dentro do círculo no mapa",

	-- Step 17: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["{npc:3067}: Camping 101 asks you to learn it"] = "{npc:3067}: Introdução ao acampamento pede que você aprenda",

	-- Step 18: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "Lobos-da-pradaria e Pinotes Adultos vagam pelas planícies em volta da aldeia.",
	-- {object:2910} Well Stone
	["{object:2910}, 170 yd east"] = "{object:2910}, 170 metros a leste",

	-- Step 20: Winterhoof Water Well
	-- {npc:2988} Morin Cloudstalker · {quest:99079} Longwalker Malah · {area:821} Rolling Plains
	["The well lies south-east of the village. {npc:2988} camps beside it, and {quest:99079} stands on the {area:821} a little east."] = "O poço fica a sudeste da vila. {npc:2988} acampa ao lado dele, e {quest:99079} fica em {area:821}, um pouco a leste.",
	-- {npc:2988} Morin Cloudstalker
	["{npc:2988} walks around here: look inside the circle on the map"] = "{npc:2988} anda por aqui: procure dentro do círculo no mapa",

	-- Step 22: Mulgore: kill these as you meet them
	-- {zone:1412} Mulgore
	["{zone:1412}: kill these as you meet them"] = "{zone:1412}: vá matando estes pelo caminho",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}, um lobo solitário, ronda as planícies a oeste da aldeia. Espreitadores-da-pradaria e Pumas das Estepes vagam pelas planícies ao norte e a oeste dela.",

	-- Step 23: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} fica na borda norte da aldeia. Kyle quer {item:287505} de pinotes.",

	-- Step 24: Thunderhorn Water Well
	-- {item:287505} Tender Strider Meat
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["The well lies north of the village. Adult Plainstriders graze around it: they drop the {item:287505} for Kyle."] = "O poço fica ao norte da aldeia. Os Pinotes Adultos pastam em volta dele: soltam a {item:287505} para Quico.",

	-- Step 25: Bloodhoof Village
	-- {npc:277154} Kyle the Frenzied · {item:287505} Tender Strider Meat
	["{npc:277154} runs around the village: give him the {item:287505}"] = "{npc:277154} corre pela aldeia feito doido: entregue {item:287505} a ele",
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}, no extremo norte da aldeia",

	-- Step 26: Galak Camp: kill these as you meet them
	-- {area:474} Galak Camp
	["{area:474}: kill these as you meet them"] = "{area:474}: vá matando estes pelo caminho",
	-- {npc:275789} Malah Longwind
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas roam among the wolves on the plains around {npc:275789} and the Galak camp to the east."] = "Os Lobos-da-pradaria Alfa vagam entre os lobos nas planícies em volta de {npc:275789} e do acampamento Galath a leste.",

	-- Step 27: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "A caravana destruída fica a noroeste dos centauros, a leste da estrada para {zone:1456}.",

	-- Step 29: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "Volte para sudeste até o {area:396}.",

	-- Step 30: Galak centaurs
	["Galak centaurs"] = "Centauros Galath",
	["The Galak centaurs camp on the plains east of the well; Herak leads them."] = "Os centauros Galath acampam nas planícies a leste do poço; Herak os lidera.",

	-- Step 31: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "Os goblins exploram a mina nas colinas a nordeste do poço. {quest:765} fica no fundo da mina; os {item:281031} dele iniciam {quest:98424}, e as outras páginas estão dentro da mina.",

	-- Step 32: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "Atravesse para noroeste, passando por {zone:1456}, até o {area:398}, no extremo norte de {zone:1412}.",

	-- Step 33: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984} fica na borda do {area:404}, ao sul do poço.",

	-- Step 34: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "As harpias Ventofúria ocupam o {area:819}, ao norte e a oeste do poço.",

	-- Step 35: Dwarven Digging
	-- {area:404} Bael'dun Digsite
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the dwarves' forge in the digsite."] = "Os anões do {area:404} carregam as Picaretas do Prospector. Destrua-as na forja dos anões, no sítio de escavação.",
	-- {item:4703} Broken Tools
	["{item:4703}, at the digsite forge"] = "{item:4703}, na forja do sítio de escavação",

	-- Step 36: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "Os gnolls Jubalba ocupam a {area:818}, ao sul do sítio de escavação e a oeste de Casco Sangrento. {npc:272203} está preso no acampamento deles: leve-o para fora.",
	-- {npc:2950} Palemane Skinner · {area:16677} Bristleback Retreat
	["{npc:2950} walks around {area:16677}: look inside the circle on the map"] = "{npc:2950} anda por {area:16677}: procure dentro do círculo no mapa",
	-- {npc:2951} Palemane Poacher
	["{npc:2951}, below ground"] = "{npc:2951}, no subterrâneo",

	-- Step 37: Bloodhoof Village
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}, para {npc:3057} em {zone:1456}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}, para Hamuul em {zone:1456}",

	-- Step 38: Yaw Sharpmane
	-- {npc:3065} Yaw Sharpmane · {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker · {npc:2970} Swoop
	["{npc:3065} stands at the north end of {area:222}. Tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a {npc:2970} to the north-west."] = "{npc:3065} fica na ponta norte de {area:222}. Dome com o {item:15908}: um {npc:2956} nas planícies, um {npc:2959} ao norte da aldeia e um {npc:2970} a noroeste.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestique-o com a {item:15908}",

	-- Step 40: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "Siga para o norte até o {area:225}, a leste de {zone:1456}. {npc:3233} fica no pé das rochas; os Traiçoeiros Costagulha cavam no cemitério e o {npc:2994} espera no alto.",
	-- {item:5203} Flatland Prowler Claw · {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["{item:5203}: Flatland Prowlers roam the plains around {area:225}"] = "{item:5203}: Predadores das Estepes vagam pelas planícies em volta do {area:225}",

	-- Step 41: Thunder Bluff
	-- {npc:3057} Cairne Bloodhoof
	["{npc:3057}'s tent"] = "",

	-- Step 42: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "Suba um elevador até as mesas. {npc:2995} cuida das serpes na elevação central; {npc:3057} fica na grande tenda de lá.",

	-- Step 43: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} quer incenso tauren: compre as quatro partes de {npc:3014}, a herborista, {npc:3012}, a fornecedora de encantamento, {npc:3005}, a fornecedora de couraria, e {npc:3027}, o fornecedor de culinária, depois combine-as em {item:278078}.",
	-- {npc:2987} Eyahn Eagletalon · {npc:269068} Eylah Sunhorn
	["{npc:2987}, beside {npc:269068}"] = "{npc:2987}, ao lado de {npc:269068}",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, de {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, de {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, de {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, de {npc:3027}",
	-- {npc:6746} Innkeeper Pala · {quest:5922} Moonglade
	["{npc:6746}, at the south end of the central rise: the hearth from {quest:5922} brings you back here"] = "{npc:6746}, na ponta sul do platô central: a Pedra de Regresso traz você de volta de {quest:5922} para cá",
	-- {npc:6746} Innkeeper Pala · {quest:5926} Heeding the Call · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746}: {quest:5926}, for {npc:3033} on {area:1639}"] = "{npc:6746}: {quest:5926}, para {npc:3033} em {area:1639}",

	-- Step 44: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Use o {item:278078} no tapete cerimonial e no incensário do penhasco virado para o sul do {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Espalhe o {item:278078} do alto do {area:1641}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn
	["{npc:3441}: for {quest:860} at the Crossroads"] = "{npc:3441}: para {quest:860}, na Encruzilhada",
	-- {npc:3039} Holt Thunderhorn · {npc:3041} Torm Ragetotem
	["{npc:3039}, beside {npc:3041}"] = "{npc:3039}, ao lado de {npc:3041}",

	-- Step 46: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:199} com {npc:11869} (10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 47: Ansekhwa
	-- {npc:11869} Ansekhwa
	["While you're here: learn Staves from {npc:11869} (10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Cajados com {npc:11869} (10 pratas); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 48: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 49: Rogue trainer
	["Rogue trainer"] = "Instrutor de ladino",
	-- {npc:3155} Rwag · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:3155} in {zone:1411}; {zone:1412} has no rogue trainer"] = "{npc:3155} em {zone:1411}; {zone:1412} não tem instrutor de ladino",

	-- Step 50: Warlock trainer
	["Warlock trainer"] = "Instrutor de bruxo",
	-- {npc:3156} Nartok · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:3156} in {zone:1411}; {zone:1412} has no warlock trainer"] = "{npc:3156} em {zone:1411}; {zone:1412} não tem instrutor de bruxo",

	-- Step 52: Clarice Foster
	-- {npc:5543} Clarice Foster · {area:2197} Pools of Vision · {area:1640} Spirit Rise
	["{npc:5543} stands in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart."] = "{npc:5543} fica em {area:2197}, a caverna sob {area:1640}: desça por dentro, a seta não distingue os andares.",
	-- {npc:5906} Xanis Flameweaver · {npc:5543} Clarice Foster · {area:1640} Spirit Rise
	["{npc:5906}, a few steps from {npc:5543} on {area:1640}"] = "{npc:5906}, a poucos passos de {npc:5543} em {area:1640}",

	-- Step 54: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem
	["{npc:5769}: for {npc:3448} at the Crossroads"] = "{npc:5769}: para {npc:3448}, na Encruzilhada",

	-- Step 55: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} trains druids in the Cenarion Circle's tent on {area:1639}."] = "{npc:3033} treina druidas na tenda do Círculo Cenariano em {area:1639}.",

	-- Step 56: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5930} fica na mata a noroeste. {npc:11802} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",

	-- Step 57: Back to Thunder Bluff
	-- {area:1639} Elder Rise
	["Cross to {area:1639}."] = "Atravesse até {area:1639}.",

	-- Step 58: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "A {object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "A pedra fica no desfiladeiro que sai de {zone:1412}, no seu caminho para o leste. Use o {item:15710} lá e derrote Lunagarra.",

	-- Step 59: Into Mulgore
	-- {zone:1412} Mulgore
	["Into {zone:1412}"] = "Rumo a {zone:1412}",

	-- Step 60: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "Rumo a {zone:1413}",

	-- Step 62: The Crossroads
	-- {zone:1412} Mulgore · {npc:3448} Tonga Runetotem · {quest:860} Sergra Darkthorn · {npc:3615} Devrak · {area:380} The Crossroads · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the Crossroads. {npc:3448} stands at the south gate, {quest:860} by the inn, {npc:3615} on the tower platform. {area:380}' own quests come after {zone:1421}, in the {zone:1413} guide."] = "Saia de {zone:1412} pela passagem a sudeste e siga a estrada até a Encruzilhada. {npc:3448} fica no portão sul, {quest:860} junto à estalagem, {npc:3615} na plataforma da torre. As missões próprias de {area:380} vêm depois de {zone:1421}, no guia de {zone:1413}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre dos mantícoras",

	-- Step 63: Jahan Hawkwing
	-- {npc:3483} Jahan Hawkwing · {npc:3615} Devrak · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem
	["{npc:3483} sells armor on the north side of the Crossroads. His bundle goes to {npc:3615}, who sends it with you on the flight to {zone:1456} you take for {npc:3033} anyway."] = "{npc:3483} vende armaduras no lado norte da Encruzilhada. O pacote dele vai para {npc:3615}, que manda junto com você no voo para {zone:1456}, que você ia pegar de qualquer jeito por causa de {npc:3033}.",

	-- Step 64: Class turn-in in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-in in {area:1638}"] = "Entrega de classe em {area:1638}",
	-- {npc:8359} Ahanu
	["{npc:8359}, by the wind riders on the central rise"] = "{npc:8359}, junto às mantícoras no platô central",

	-- Step 66: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "Até {zone:1454}",
	-- {area:379} Far Watch Post · {area:815} Southfury River · {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["From the Crossroads follow the road north-east to {area:379}, cross the {area:815} into {zone:1411} and keep north to {zone:1454}'s main gate. The next guide starts in {zone:1454} and takes the zeppelin to {zone:1420} and {zone:1421}."] = "Da Encruzilhada, siga a estrada para nordeste até {area:379}, atravesse {area:815} para {zone:1411} e continue ao norte até o portão principal de {zone:1454}. O próximo guia começa em {zone:1454} e pega o zepelim para {zone:1420} e {zone:1421}.",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Bloodhoof"] = "De volta a Casco Sangrento",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; o {quest:5930} fica na mata a noroeste.",
	-- ["Class turn-ins in {area:1638}"] = "Entregas de classe em {area:1638}",
	-- ["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "Termine o coração de lobo, o fêmur de puma, a escama de pinote e a moela de rapineiro nas planícies em volta da aldeia.",
	-- ["Flatland Prowlers roam the plains around {area:225}"] = "Predadores das Estepes vagam pelas planícies em volta do {area:225}",
	-- ["Galak centaurs and Prairie Wolf Alphas"] = "Centauros Galath e Lobos-da-pradaria Alfa",
	-- ["Hearth to {area:222} and ride north to {area:1639}."] = "Use a Pedra de Regresso para ir à {area:222} e siga para o norte até o {area:1639}.",
	-- ["Into {area:17}"] = "Rumo a {area:17}",
	-- ["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "Saia de {zone:1412} pelo desfiladeiro sudeste e siga a estrada até {area:380}. {quest:860} fica junto à estalagem, {npc:3448} no portão sul. O guia de {zone:1413} começa aqui.",
	-- ["Plainstriders roam the grass all around the camp."] = "Pinotes vagam pelo capim em volta de todo o acampamento.",
	-- ["Prairie Wolf Alphas"] = "Lobos-da-pradaria Alfa",
	-- ["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Desça até a {area:222} e domestique com a {item:15908}: um {npc:2956} nas planícies, um {npc:2959} ao norte da aldeia e um Rapineiro a noroeste.",
	-- ["Speak with {npc:3067}"] = "Fale com {npc:3067}",
	-- ["Swoops glide over the plains all around Bloodhoof."] = "Rapineiros planam sobre as planícies em volta de Casco Sangrento.",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "Os centauros Galath acampam nas planícies ao norte de {area:821}; Herak os lidera. Os Lobos-da-pradaria Alfa vagam entre os lobos.",
	-- ["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "Os anões do {area:404} carregam as Picaretas do Prospector. Destrua-as na forja da {area:222}.",
	-- ["The well lies north of the village. Adult Plainstriders graze around it: they drop the {item:287505} for Kyle."] = "O poço fica ao norte da aldeia. Os Pinotes Adultos pastam em volta dele: soltam a {item:287505} para Quico.",
	-- ["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "O poço fica ao norte da aldeia. Pedras de Poço ficam em volta do poço, e {item:4809} fica sob as árvores próximas. Mate lobos, pumas, pinotes e rapineiros no caminho para {quest:766} e {quest:761}.",
	-- ["The well lies north of the village. Well Stones sit around the well, {object:2912} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "O poço fica ao norte da aldeia. Pedras de Poço ficam em volta do poço, e {object:2912} fica sob as árvores próximas. Mate lobos, pumas, pinotes e rapineiros no caminho para {quest:766} e {quest:761}.",
	-- ["The well lies south-east of the village."] = "O poço fica a sudeste da aldeia.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789} fica nas {area:821}, um pouco a leste do poço.",
	-- ["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} fica na borda norte da aldeia. Kyle quer {item:287505} de pinotes.",
	-- ["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988} acampa junto ao {area:396}, a sudeste de Casco Sangrento.",
	-- ["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991} fica sentada junto à tenda na borda leste do acampamento; o {item:4755} está ao lado dela.",
	-- ["{npc:3059}, the warrior trainer"] = "{npc:3059}, o instrutor de guerreiro",
	-- ["{npc:3209}, next to {npc:2980}"] = "{npc:3209}, ao lado de {npc:2980}",
	-- ["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}: para {quest:860} em {area:380}",
	-- ["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}: para {npc:3448} em {area:380}",
	-- ["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "{npc:6746}, na elevação central, manda você até {npc:3033} no {area:1639}.",
	-- ["{quest:96130} and {quest:756}"] = "{quest:96130} e {quest:756}",
}
