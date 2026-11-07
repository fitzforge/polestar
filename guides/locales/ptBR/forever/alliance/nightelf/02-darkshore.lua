-- Portuguese (Brazil) (ptBR): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "O barco atraca a oeste do vilarejo. O mestre de voo fica na colina ao sul da estalagem; os recrutadores de missões estão espalhados pela rua principal.",
	["The WANTED poster outside the inn"] = "O cartaz de PROCURA-SE em frente à estalagem",

	-- Step 2: The beach
	["The beach"] = "A praia",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Maretiscos correm pela costa abaixo do vilarejo; {quest:983} fica na praia logo ao sul das docas. Manguais da Costa Negra nadam nas águas rasas. A {object:175207} está na costa logo ao sul do vilarejo.",

	-- Step 3: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, no extremo norte do vilarejo",

	-- Step 4: Auberdine
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, by the inn"] = "{npc:3666}, junto à estalagem",

	-- Step 5: The skeletal turtle
	["The skeletal turtle"] = "A tartaruga esquelética",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, na praia a oeste do cais; debaixo d'água",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Ursos e o acampamento Bosquenero",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "Mate Ursocardos Raivosos nas colinas a leste de {area:442} e depois suba até o acampamento furbolg a sudeste deles: nada para matar ainda.",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} fica na borda norte das ruínas. Altaneiras Amaldiçoadas, Altaneiros Contorcidos e {npc:2178} assombram o lugar; o fantasma de {npc:3667} caminha entre eles, e a coruja {npc:270196} circula a leste. As duas tábuas estão nas ruínas; uma {quest:4722} está na costa a oeste delas.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Relíquias dos Altaneiros",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Leia {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Leia {object:17189}",

	-- Step 8: The red crystal
	["The red crystal"] = "O cristal vermelho",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Suba as montanhas a leste de {area:447}; o {object:175524} fica numa saliência.",

	-- Step 9: Plagued bears
	["Plagued bears"] = "Ursos empestados",
	-- {area:442} Auberdine · {item:7586} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {item:7586} on one and lead it back to him."] = "Ursocardos Raivosos andam pelas colinas logo a leste de {area:442}. Use a {item:7586} num deles e leve-o de volta até ele.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "os Ursocardos Raivosos mais perto de {npc:3701}",

	-- Step 10: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {object:17183} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Para o norte pelas colinas. {npc:3650} espera nas ruínas de {quest:954}; Capetas Selvagens e Duendes Torpes lotam as ruínas, e Sátiros Deth'ryll a borda leste. A {object:17183} fica junto à estrada a oeste das ruínas; uma {quest:4723} está na praia no caminho até ele.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Brincos de Capeta",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: Sátiros Deth'ryll",

	-- Step 11: Hearth to Auberdine
	-- {area:442} Auberdine
	["Hearth to {area:442}"] = "Pedra de Regresso para {area:442}",

	-- Step 12: Auberdine
	["Fill the tube at the moonwell in the village"] = "Encha o tubo no poço lunar do vilarejo",

	-- Step 13: Blackwood furbolgs
	["Blackwood furbolgs"] = "Furbolgs Bosqueneros",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Desbravadores Bosqueneros e Vozes-do-vento Bosqueneros ocupam o acampamento a sudeste de {area:442}.",

	-- Step 14: The southern beaches
	["The southern beaches"] = "As praias do sul",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Siga a costa para o sul passando por {area:447}: uma {quest:4728} está na costa a oeste do Bosque, outra mais ao sul perto de {area:450}. Mais três restos estão mais a sudoeste, entre Oráculos e Caçamarés Brumagris (18-20): o guia os deixa para a última volta, quando você estiver mais perto do nível deles.",

	-- Step 15: The red crystal
	["Back north-east into the mountains to the crystal."] = "Volte para nordeste, pelas montanhas, até o cristal.",

	-- Step 17: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Barco para {area:17203}",

	-- Step 18: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",

	-- Step 19: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11867} ({object:2096}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 20: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Já que está aqui: aprenda Espadas com {npc:11867} ({object:2096}, 10 pratas); espada na mão principal faz o Ladino subir de nível sem tropeço.",

	-- Step 22: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 23: Shaman trainer
	["Shaman trainer"] = "Instrutor de xamã",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} em {zone:1426}; {area:87} não tem instrutor de xamã",

	-- Step 24: Druid trainer
	["Druid trainer"] = "Instrutor de druida",
	-- {npc:270459} Alfina Nightgaze · {zone:1416} Alterac Mountains · {area:87} Goldshire
	["{npc:270459} in {zone:1416}; {area:87} has no druid trainer"] = "{npc:270459} em {zone:1416}; {area:87} não tem instrutor de druida",

	-- Step 28: Ameth'Aran
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "A chama arde no sul de {area:447}.",

	-- Step 33: Into Elwynn Forest
	-- {area:12} Elwynn Forest
	["Into {area:12}"] = "Rumo a {area:12}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Into {area:148}"] = "Rumo a {area:148}",
}
