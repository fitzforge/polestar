-- Portuguese (Brazil) (ptBR): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Auberdine
	-- {npc:3644} Cerellean Whiteclaw · {npc:3649} Thundris Windweaver · {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village: {npc:3644} waits where the pier meets the shore. Go up to {npc:3649} at the north end of the village first, then down the main street to the inn. The flight master stands on the hill south of the inn. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "O barco atraca a oeste da vila: {npc:3644} espera onde o cais encontra a costa. Suba primeiro até {npc:3649}, na ponta norte da vila, e depois desça a rua principal até a estalagem. O mestre de voo fica na colina ao sul da estalagem. {npc:3666} fica no andar de cima da estalagem: pegue a escada lá dentro, a seta não diferencia os andares.",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, no píer",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, no extremo norte do vilarejo",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649}: para {npc:1646} em {zone:1453}",
	["The WANTED poster outside the inn"] = "O cartaz de PROCURA-SE em frente à estalagem",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}, no andar de cima da estalagem",
	-- {npc:10219} Gwennyth Bly'Leggonde · {zone:1438} Teldrassil
	["{npc:10219} (Night Elves have it from {zone:1438})"] = "{npc:10219} (os Elfos da Noite pegam isso em {zone:1438})",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "{npc:10216}, no cais",

	-- Step 3: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "Só para pescadores: {npc:10216} fica no cais. A {item:12238} dele é pescada do próprio cais.",

	-- Step 4: The beach
	["The beach"] = "A praia",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Maretiscos correm pela costa abaixo do vilarejo; {quest:983} fica na praia logo ao sul das docas. Manguais da Costa Negra nadam nas águas rasas. A {object:175207} está na costa logo ao sul do vilarejo.",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238}: pesque no píer",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "Patas de Rastejante",

	-- Step 5: Auberdine
	-- {quest:3524} Washed Ashore
	-- plural, as words: Beached Sea Turtles = {quest:4722} Beached Sea Turtle
	["{quest:3524}: the Beached Sea Turtles up the coast offer their quests only once it is handed in"] = "{quest:3524}: as Tartarugas Marinhas Encalhadas na costa só oferecem as missões delas depois que ela é entregue",

	-- Step 6: The skeletal turtle
	["The skeletal turtle"] = "A tartaruga esquelética",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, na praia a oeste do cais; debaixo d'água",

	-- Step 7: Plagued bears
	["Plagued bears"] = "Ursos empestados",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "Ursocardos Raivosos vagam pelas colinas logo a leste de {area:442}. Use {quest:2139} em um e leve-o de volta até ele.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "os Ursocardos Raivosos mais perto de {npc:3701}",

	-- Step 8: Rabid Thistle Bear on the way
	-- {npc:2164} Rabid Thistle Bear
	["{npc:2164} on the way"] = "{npc:2164} no caminho",

	-- Step 9: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Ursos e o acampamento Bosquenero",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "Mate Ursocardos Raivosos nas colinas a leste de {area:442} e depois suba até o acampamento furbolg a sudeste deles: nada para matar ainda.",

	-- Step 10: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} fica na borda norte das ruínas. Altaneiras Amaldiçoadas, Altaneiros Contorcidos e {npc:2178} assombram o lugar; o fantasma de {npc:3667} caminha entre eles, e a coruja {npc:270196} circula a leste. As duas tábuas estão nas ruínas; uma {quest:4722} está na costa a oeste delas.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Relíquias dos Altaneiros",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Leia {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Leia {object:17189}",

	-- Step 11: The red crystal
	["The red crystal"] = "O cristal vermelho",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Suba as montanhas a leste de {area:447}; o {object:175524} fica numa saliência.",

	-- Step 13: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Siga as colinas para o norte. {npc:3650} espera nas ruínas de {quest:954}; Capetas Selvagens e Duendes Torpes as enchem, e Sátiros Deth'ryll a borda leste. {quest:1001} fica junto à estrada a oeste das ruínas; uma {quest:4723} está na costa no caminho até ele.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Brincos de Capeta",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: Sátiros Deth'ryll",

	-- Step 14: Auberdine
	["Fill the tube at the moonwell in the village"] = "Encha o tubo no poço lunar do vilarejo",

	-- Step 15: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "Voe de {area:442} para {area:702} e pegue o portal para subir até {npc:4217} em {area:1658}.",

	-- Step 18: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Use {spell:18960}",

	-- Step 19: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:29} Trial of the Lake · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. {quest:29} runs on a timer: no teleport or Hearthstone until {npc:11799} has it. Then fly back to {area:442} from {area:2361}."] = "{npc:11802} fica no andar de cima do prédio dele em {area:2361}: suba por dentro, a seta não diferencia os andares. Os Adornos de Altar ficam nos recipientes no chão de {area:656}, abaixo de {area:2361}: leve um até o {area:2362}, no noroeste, use-o lá e fale com {npc:11799}. {quest:29} corre contra o tempo: nada de teleporte nem Pedra de Regresso até {npc:11799} ficar com ele. Depois voe de volta para {area:442} a partir de {area:2361}.",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122}: encha o amostrador em {area:445}",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de um {object:177785} no lago",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Em {area:2362}",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "As metades do pingente ficam em {zone:1439} e {zone:1436}: mais adiante na rota",

	-- Step 20: Blackwood furbolgs
	["Blackwood furbolgs"] = "Furbolgs Bosqueneros",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Desbravadores Bosqueneros e Vozes-do-vento Bosqueneros ocupam o acampamento a sudeste de {area:442}.",

	-- Step 21: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "{object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "A chama arde no sul de {area:447}.",

	-- Step 22: The red crystal
	["Back north-east into the mountains to the crystal."] = "Volte para nordeste, pelas montanhas, até o cristal.",

	-- Step 23: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Two more beached remains lie on the north shore: near the {area:443} and north of {quest:954}."] = "Siga as colinas para o norte até {area:456} e suba até as cachoeiras. Mais dois restos encalhados estão na costa norte: perto de {area:443} e ao norte de {quest:954}.",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, na cachoeira",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845}: na entrada da caverna junto às cachoeiras",
	-- {item:12237} Fine Crab Chunks · {npc:2233} Encrusted Tide Crawler · {npc:2235} Reef Crawler
	["{item:12237} from {npc:2233} and {npc:2235}, by this stop"] = "{item:12237} de {npc:2233} e {npc:2235}, perto desta parada",

	-- Step 25: Auberdine
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "{item:12347}: encha a {item:12346} no {object:174795}",

	-- Step 26: Mist's Edge
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes; underwater"] = "Olhos de Mangual; debaixo d'água",

	-- Step 27: The bay wrecks
	["The bay wrecks"] = "Os naufrágios da baía",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore.\nCareful: The murlocs inside the wrecks are close together and fast. They often swim through the hull walls and holes, so you will usually pull extra murlocs."] = "Dois naufrágios estão no fundo da baía ao norte de {area:442}; cada um guarda um baú. Tiscorais e Maretiscos Incrustados tomam esta praia.\nCuidado: os murlocs dentro dos naufrágios ficam juntos e são rápidos. Eles costumam nadar pelas paredes e buracos do casco, então quase sempre vem murloc a mais.",
	-- {item:12191} Silver Dawning's Lockbox
	["{item:12191}; underwater"] = "{item:12191}; debaixo d'água",
	-- {item:12192} Mist Veil's Lockbox
	["{item:12192}; underwater"] = "{item:12192}; debaixo d'água",

	-- Step 29: Darkshore: kill these as you meet them
	-- {zone:1439} Darkshore
	["{zone:1439}: kill these as you meet them"] = "{zone:1439}: vá matando estes pelo caminho",
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "Espreitalunas rondam as colinas entre {quest:954} e a torre. {quest:1002} fica na colina a oeste da torre.",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "Presas de Espreitaluna",

	-- Step 31: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["East of Buzzbox 323, {npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "A leste de Caixazorra 323, {npc:3661} se esconde ao pé da torre entre os Fanáticos da Linhagem das Trevas. Guarde a carta dele para Dinis, o Purificador, em {zone:1440}.",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348}: Fanáticos da Linhagem das Trevas",

	-- Step 32: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "A caverna e a {npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls."] = "A caverna fica ao sul das cachoeiras: Galhos de Piolho crescem por toda ela, e o {item:5270} bem no fundo. A {npc:6788} se entoca nas colinas ao sul das cachoeiras.",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks; below ground"] = "Galhos de Piolho; no subterrâneo",
	-- {item:5270} Death Cap
	["{item:5270}; below ground"] = "{item:5270}; no subterrâneo",

	-- Step 33: The northern Blackwood camp
	["The northern Blackwood camp"] = "O acampamento Bosquenero do norte",
	-- {area:456} Cliffspring River · {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell · {item:12355} Talisman of Corruption
	["The furbolg camp south of the {area:456} keeps its Nut, Fruit and Grain Stores by the bonfires. With a sample of each and the {item:12347} in your bags (the {item:12346} is filled at the {object:174795}), use the bowl by the bonfire closest to the river: it summons Xabraxxis, the satyr corruptor, and the {item:12355} lies in his Demon Bag."] = "O acampamento furbolg ao sul de {area:456} guarda as Reservas de Castanha, Fruta e Grão junto às fogueiras. Com uma amostra de cada e a {item:12347} nas bolsas (a {item:12346} se enche no {object:174795}), use a bacia junto à fogueira mais perto do rio: ela invoca Zabraxxis, o sátiro corruptor, e o {item:12355} está na Bolsa Demoníaca dele.",
	["By the bonfire closest to the river: summons Xabraxxis"] = "Junto à fogueira mais perto do rio: invoca Zabraxxis",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}, em {object:177624}",

	-- Step 34: The cave and the Den Mother
	["Careful: If you attack one cub, the other cubs and often the mother join the fight, so expect to take on several at the same time."] = "Cuidado: se você atacar um filhote, os outros filhotes e muitas vezes a mãe entram na briga, então conte com vários de uma vez.",
	-- {npc:6788} Den Mother
	["{npc:6788}, below ground"] = "{npc:6788}, no subterrâneo",

	-- Step 35: Auberdine
	-- {quest:948} Onu · {zone:1439} Darkshore
	["For {quest:948} at the Grove, on {zone:1439}'s southern loop after the trip east"] = "Para {quest:948}, no Bosque, no circuito sul de {zone:1439}, depois da viagem ao leste",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south"] = "De volta ao sul",
	-- ["Back to {npc:11802}"] = "De volta a {npc:11802}",
	-- ["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "Volte a {npc:11802} em {area:2361} e depois voe para {area:702} (passando por {area:442}).",
	-- ["Boat to {zone:1453}"] = "Barco para {zone:1453}",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Adornos de Altar ficam nos recipientes no fundo de {area:656}, abaixo de {area:2361}: leve um até {area:2362} a noroeste, use-o lá e fale com {npc:11799}. Depois voe de volta para {area:442} a partir de {area:2361}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; aprenda a rota de voo de lá se ainda não a tiver.",
	-- ["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Escolte-a para fora da glaive; Therysil recebe a entrega em {zone:1440}",
	-- ["Fine Moonstalker Pelts"] = "Pelagens de Espreitaluna Finas",
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "Siga a costa para nordeste até {area:443}. {quest:951} estão entre as ruínas; Mirmidões Skamatrom, Feiticeiras Skamatrom e Guerreiros Skamatrom as ocupam, e Senhoras das Feras Skamatrom andam pela costa.",
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "Siga a costa para nordeste até {area:443}. {quest:951} estão entre as ruínas; Mirmidões Skamatrom, Feiticeiras Skamatrom e Guerreiros Skamatrom as ocupam.",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "Siga a costa para o sul passando por {area:447}: uma {quest:4728} está na costa a oeste do Bosque, outra mais ao sul perto de {area:450}.",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Siga a costa para o sul passando por {area:447}: uma {quest:4728} está na costa a oeste do Bosque, outra mais ao sul perto de {area:450}. Mais três restos estão mais a sudoeste, entre Oráculos e Caçamarés Brumagris (18-20): o guia os deixa para a última volta, quando você estiver mais perto do nível deles.",
	-- ["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "Siga as colinas para o norte até {area:456} e suba até as cachoeiras. Mais três restos encalhados estão na costa norte: perto de {area:443}, ao norte de {quest:954} e a oeste de {quest:954}.",
	-- ["Follow the road north."] = "Siga a estrada para o norte.",
	-- ["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "Siga a estrada para o sul. {quest:948} é o anciente do Bosque; {npc:270269} e {npc:11218} dormem ao lado dele.",
	-- ["Grizzled Scalps"] = "Escalpos Grisalhos",
	-- ["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "Ursocardos Grisalhos vagam pelas colinas ao redor do Bosque; {quest:1003} fica a oeste dele, no meio deles.",
	-- ["Hearth to {area:442}"] = "Pedra de Regresso para {area:442}",
	-- ["Hearthstone on cooldown? Follow the coast road back south."] = "Pedra de Regresso em recarga? Volte para o sul pela estrada costeira.",
	-- ["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Espreitalunas Machos rondam a mata ao redor da glaive. {object:10076} e {object:12666} ficam no fundo da cratera; {npc:3584} fica no lado norte.",
	-- ["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Elfos Noturnos voam de {area:442} para {area:702}; Celonatos pegam o barco na doca de {area:442} e aprendem lá a rota de voo. Pegue o portal para subir até {npc:4217} em {area:1658}.",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "Siga as colinas para o norte. {npc:3650} espera nas ruínas de {quest:954}; Capetas Selvagens e Duendes Torpes as enchem, e Sátiros Deth'ryll a borda leste. {quest:1001} fica junto à estrada a oeste das ruínas.",
	-- ["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Só se um Discipulo ou Capanga tiver deixado cair {item:5352}: clique com o botão direito nele",
	-- ["Read both tablets"] = "Leia as duas tábuas",
	-- ["Scaber Stalks"] = "Galhos de Piolho",
	-- ["She gives you the {item:15826}"] = "Ela lhe dá o {item:15826}",
	-- ["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "Pegue o portal para subir até {npc:4217} e depois voe de volta para {area:442} para o barco para {zone:1453}.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "Os Brotos Fúngicos Lunares crescem nas cavernas dos luniscantes nas colinas logo a leste de {area:442}; os luniscantes de lá são irritadiços. {item:2449} exige {skill:182}: herbalistas o colhem por toda {zone:1439}, os demais o trazem de {zone:1453} ({npc:1313}) ou da casa de leilões.",
	-- ["The WANTED poster"] = "O cartaz de PROCURA-SE",
	-- ["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "O barco atraca a oeste do vilarejo. O mestre de voo fica na colina ao sul da estalagem; os recrutadores de missões estão espalhados pela rua principal.",
	-- ["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "A caverna fica ao sul das cachoeiras: Galhos de Piolho crescem por toda ela, e o {item:5270} bem no fundo. A {npc:6788} se entoca nas colinas ao sul das cachoeiras; {object:177624} está no acampamento de sátiros ao norte dela.",
	-- ["The naga"] = "Os nagas",
	-- ["The relics of the Barrow Dens"] = "As relíquias dos Templos de Tempesfúria",
	-- ["The southern beaches"] = "As praias do sul",
	-- ["The {area:443}"] = "{area:443}",
	-- ["The {area:448}"] = "{area:448}",
	-- ["The {object:10076}"] = "{object:10076}",
	-- ["The {object:12666}"] = "{object:12666}",
	-- ["Thresher Eyes"] = "Olhos de Mangual",
	-- ["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "Dois naufrágios estão no fundo do mar na baía ao norte de {area:442}; cada um guarda um cofre. Tiscorais e Maretiscos Incrustados ocupam esta costa.",
	-- ["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "{area:450} fica na costa ao sul da praia de {npc:10323}. Proteja o garimpeiro enquanto ele procura o fóssil.",
	-- ["{item:12289}, on the beach west of the docks"] = "{item:12289}, na praia a oeste das docas",
	-- ["{item:15851} and {item:2449}"] = "{item:15851} e {item:2449}",
	-- ["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}: o {object:177792} debaixo d'água na costa norte, a oeste das ruínas",
	-- ["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}: Discipulos do Crepúsculo e Capangas do Crepúsculo",
	-- ["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}, no píer: só com {skill:356}",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323} acampa na praia a oeste da glaive: mate os murlocs na fogueira; ele vem na terceira onda com seu cão. Três restos encalhados estão nas praias ao sul de {area:450}.",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches west and south-west of {area:450}."] = "{npc:10323} acampa na praia a oeste da glaive: mate os murlocs na fogueira; ele vem na terceira onda com seu cão. Três restos encalhados estão nas praias a oeste e a sudoeste de {area:450}.",
	-- ["{npc:10323}'s beach"] = "A praia de {npc:10323}",
	-- ["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218}: a escolta dele até {area:413} é feita no trecho de {zone:1440}",
	-- ["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}: as boas-vindas de Sheldras Lunárvore",
	-- ["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}: use o {item:15826} neles; vagam por toda {zone:1439}",
	-- ["{npc:3616}, at the Grove"] = "{npc:3616}, no Bosque",
	-- ["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661} se esconde ao pé da torre entre os Fanáticos da Linhagem das Trevas. Guarde a carta dele para Dinis, o Purificador, em {zone:1440}.",
	-- ["{npc:3666}, by the inn"] = "{npc:3666}, junto à estalagem",
	-- ["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692} se esconde nas colinas a leste de {area:449}. Ajude-o a voltar à estrada; ele luta no caminho.",
	-- ["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694}: para {npc:3691} em {area:415}, no trecho posterior de {zone:1440}",
	-- ["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} se esconde na ilhota em frente às ruínas. As partes da chave caem de Florestruzes Gigantes (topo), murlocs Brumagris (meio) e Tiscorais Furiosos (base).",
	-- ["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} se esconde na ilhota em frente às ruínas; Senhoras das Feras Escamarraio andam pela costa. As partes da chave caem de Florestruzes Gigantes (topo), murlocs Brumagris (meio) e Tiscorais Furiosos (base).",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003} fica a oeste do Bosque.",
	-- ["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}: {npc:10219} a oferece depois que os nove restos encalhados forem entregues",
	-- ["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Elfos Noturnos) e o {npc:272054} (Celonatos) esperam no sul de {area:493}. As três relíquias ficam em {area:2363}, a leste deles. Relatos das primeiras semanas dizem que uma relíquia não dá saque enquanto outro jogador a saqueia: espere um pouco e tente de novo.",
}
