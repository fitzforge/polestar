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
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "O barco atraca a oeste do vilarejo. O mestre de voo fica na colina ao sul da estalagem; os PNJs de missão ficam espalhados pela rua principal. {npc:3666} fica no andar de cima da estalagem: suba a escada por dentro, a seta não diferencia os andares.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}, no andar de cima da estalagem",

	-- Step 5: The skeletal turtle
	["The skeletal turtle"] = "A tartaruga esquelética",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, na praia a oeste do cais; debaixo d'água",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Ursos e o acampamento Bosquenero",
	-- {area:442} Auberdine · {item:7586} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Ursocardos Raivosos vagam pelas colinas ao sul de {area:442}: use {item:7586} em um para capturá-lo. Depois suba até o acampamento dos furbolgs, logo a leste deles: nada para matar ainda.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "os Ursocardos Raivosos mais perto de {npc:3701}",

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

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {object:17183} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Para o norte pelas colinas. {npc:3650} espera nas ruínas de {quest:954}; Capetas Selvagens e Duendes Torpes lotam as ruínas, e Sátiros Deth'ryll a borda leste. A {object:17183} fica junto à estrada a oeste das ruínas; uma {quest:4723} está na praia no caminho até ele.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Brincos de Capeta",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: Sátiros Deth'ryll",

	-- Step 11: Auberdine
	["Fill the tube at the moonwell in the village"] = "Encha o tubo no poço lunar do vilarejo",

	-- Step 12: Blackwood furbolgs
	["Blackwood furbolgs"] = "Furbolgs Bosqueneros",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Desbravadores Bosqueneros e Vozes-do-vento Bosqueneros ocupam o acampamento a sudeste de {area:442}.",

	-- Step 13: The southern beaches
	["The southern beaches"] = "As praias do sul",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Siga a costa para o sul passando por {area:447}: uma {quest:4728} está na costa a oeste do Bosque, outra mais ao sul perto de {area:450}. Mais três restos estão mais a sudoeste, entre Oráculos e Caçamarés Brumagris (18-20): o guia os deixa para a última volta, quando você estiver mais perto do nível deles.",

	-- Step 14: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "De volta ao norte até {area:447}: a chama arde no sul das ruínas.",

	-- Step 15: The red crystal
	["Back north-east into the mountains to the crystal."] = "Volte para nordeste, pelas montanhas, até o cristal.",

	-- Step 16: Bashal'Aran
	-- {npc:3650} Asterion · {area:442} Auberdine
	["North along the hills to {npc:3650}, then west down to {area:442}."] = "Ao norte pelas colinas até {npc:3650}, depois a oeste, descendo até {area:442}.",

	-- Step 18: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Barco para {area:17203}",

	-- Step 19: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "Ao sair do barco, {npc:268511} fica no porto: a remessa dele vai para a queijaria de {npc:483} no {object:2096}, ao lado do mestre de voo.",

	-- Step 20: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "{npc:483}, na queijaria dela",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "Suba as escadas da loja dela: deixe a remessa em {object:460004}",

	-- Step 21: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646} fica na {object:2098}, a oeste do {object:2096}: a bússola dele está na antiga casa dele em {zone:1436}, no caminho.",

	-- Step 22: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11867} ({object:2096}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 23: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Já que está aqui: aprenda Espadas com {npc:11867} ({object:2096}, 10 pratas); espada na mão principal faz o Ladino subir de nível sem tropeço.",

	-- Step 24: Druid trainer
	["Druid trainer"] = "Instrutor de druida",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504} em {zone:1453}; {area:87} não tem instrutor de druida",

	-- Step 26: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 27: Shaman trainer
	["Shaman trainer"] = "Instrutor de xamã",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} em {zone:1426}; {area:87} não tem instrutor de xamã",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Into {area:148}"] = "Rumo a {area:148}",
}
