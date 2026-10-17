-- Portuguese (Brazil) (ptBR): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "Você começa na mesa da {area:221}. {npc:2980} e o chefe ficam junto à grande tenda no centro.",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "Pinotes vagam pelo capim em volta de todo o acampamento.",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "{npc:3059}, o instrutor de guerreiro",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}, a instrutora de caçador",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}, a instrutora de xamã no acampamento",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}, o instrutor de druida ao lado dele",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {item:4755} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991} fica sentada junto à tenda na borda leste do acampamento; o {item:4755} está ao lado dela.",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775} fica no extremo oeste do acampamento, no canto noroeste das colinas onde rondam os Pumas da Montanha: pegue a missão dele, cace os pumas dali para o sul e o leste e depois volte até {npc:2980}.",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:3209}, ao lado de {npc:2980}",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "Siga a trilha para o sul saindo do acampamento até a tenda do Vidente, no sopé das colinas.",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "O santuário de An'she e Mu'sha",
	-- {object:660739} Ritual Fire
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "O incenso se apaga em dez minutos: corra direto para o leste pelas colinas do sul até a {object:660739}.",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "Javaliços pastam ao norte do santuário; os javatuscos Costagulha ocupam a ravina a nordeste. {npc:8554} fica no extremo leste dela, e o {object:3076} está no chão do acampamento.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "Volte para oeste até o acampamento.",

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
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "Fale com {npc:3067}",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "Lobos-da-pradaria e Pinotes Adultos vagam pelas planícies em volta da aldeia.",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "O poço fica a sudeste da aldeia.",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130} e {quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}, um lobo solitário, ronda as planícies a oeste da aldeia. Espreitadores-da-pradaria e Pumas das Estepes vagam pelas planícies ao norte e a oeste dela.",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "De volta a Casco Sangrento",
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}, para {npc:3057} em {zone:1456}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}, para Hamuul em {zone:1456}",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "Missão de {npc:3063}: vença três Guerreiros Novatos (ou jogadores em duelos) ao lado dele.",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} fica na borda norte da aldeia. Kyle quer {item:287505} de pinotes.",

	-- Step 26: Thunderhorn Water Well
	-- {item:4809} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {item:4808} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "O poço fica ao norte da aldeia. Pedras de Poço ficam em volta do poço, e {item:4809} fica sob as árvores próximas. Mate lobos, pumas, pinotes e rapineiros no caminho para {quest:766} e {quest:761}.",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}, no extremo norte da aldeia",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "Rapineiros planam sobre as planícies em volta de Casco Sangrento.",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988} acampa junto ao {area:396}, a sudeste de Casco Sangrento.",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789} fica nas {area:821}, um pouco a leste do poço.",

	-- Step 31: Galak centaurs and Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Galak centaurs and Prairie Wolf Alphas"] = "Centauros Galath e Lobos-da-pradaria Alfa",
	-- {area:821} Rolling Plains
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "Os centauros Galath acampam nas planícies ao norte de {area:821}; Herak os lidera. Os Lobos-da-pradaria Alfa vagam entre os lobos.",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "A caravana destruída fica a noroeste dos centauros, a leste da estrada para {zone:1456}.",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "Termine o coração de lobo, o fêmur de puma, a escama de pinote e a moela de rapineiro nas planícies em volta da aldeia.",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "Volte para sudeste até o {area:396}.",

	-- Step 37: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "Os goblins exploram a mina nas colinas a nordeste do poço. {quest:765} fica no fundo da mina; os {item:281031} dele iniciam {quest:98424}, e as outras páginas estão dentro da mina.",

	-- Step 38: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "Atravesse para noroeste, passando por {zone:1456}, até o {area:398}, no extremo norte de {zone:1412}.",

	-- Step 39: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "As harpias Ventofúria ocupam o {area:819}, ao norte e a oeste do poço.",

	-- Step 40: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984} fica na borda do {area:404}, ao sul do poço.",

	-- Step 41: Dwarven Digging
	-- {area:404} Bael'dun Digsite · {area:222} Bloodhoof Village
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "Os anões do {area:404} carregam as Picaretas do Prospector. Destrua-as na forja da {area:222}.",

	-- Step 42: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "Os gnolls Jubalba ocupam a {area:818}, ao sul do sítio de escavação e a oeste de Casco Sangrento. {npc:272203} está preso no acampamento deles: leve-o para fora.",

	-- Step 45: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "Siga para o norte até o {area:225}, a leste de {zone:1456}. {npc:3233} fica no pé das rochas; os Traiçoeiros Costagulha cavam no cemitério e o {npc:2994} espera no alto.",
	-- {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["Flatland Prowlers roam the plains around {area:225}"] = "Predadores das Estepes vagam pelas planícies em volta do {area:225}",

	-- Step 46: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "Suba um elevador até as mesas. {npc:2995} cuida das serpes na elevação central; {npc:3057} fica na grande tenda de lá.",

	-- Step 47: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} quer incenso tauren: compre as quatro partes de {npc:3014}, a herborista, {npc:3012}, a fornecedora de encantamento, {npc:3005}, a fornecedora de couraria, e {npc:3027}, o fornecedor de culinária, depois combine-as em {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, de {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, de {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, de {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, de {npc:3027}",

	-- Step 48: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Use o {item:278078} no tapete cerimonial e no incensário do penhasco virado para o sul do {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Espalhe o {item:278078} do alto do {area:1641}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}: para {quest:860} em {area:380}",

	-- Step 50: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}: para {npc:3448} em {area:380}",

	-- Step 52: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "{npc:6746}, na elevação central, manda você até {npc:3033} no {area:1639}.",

	-- Step 53: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; o {quest:5930} fica na mata a noroeste.",

	-- Step 54: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and ride north to {area:1639}."] = "Use a Pedra de Regresso para ir à {area:222} e siga para o norte até o {area:1639}.",

	-- Step 55: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Desça até a {area:222} e domestique com a {item:15908}: um {npc:2956} nas planícies, um {npc:2959} ao norte da aldeia e um Rapineiro a noroeste.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestique-o com a {item:15908}",

	-- Step 56: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "A {object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "A pedra fica no desfiladeiro que sai de {zone:1412}, no seu caminho para o leste. Use o {item:15710} lá e derrote Lunagarra.",

	-- Step 57: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "Saia de {zone:1412} pelo desfiladeiro sudeste e siga a estrada até {area:380}. {quest:860} fica junto à estalagem, {npc:3448} no portão sul. O guia de {zone:1413} começa aqui.",

	-- Step 58: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "Entregas de classe em {area:1638}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:380}"] = "{area:380}",
}
