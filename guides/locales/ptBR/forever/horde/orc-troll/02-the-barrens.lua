-- Portuguese (Brazil) (ptBR): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "Você chega do {area:379}. {npc:3338} fica junto à estalagem; {npc:3429} e {npc:3449}, na plataforma da torre; Helbrim e {npc:3464}, junto ao portão norte; {npc:3448}, no portão sul.",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Pinotes e raptores",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Pinotes e raptores Helióscamo vagam pelas planícies em volta da {area:380}.",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "Zevras e raptores",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "Zevras Corredoras pastam nas mesmas planícies; termine as cabeças de raptor no caminho.",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}, na plataforma da torre: requer nível 12",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} acampa ao lado da estrada para o leste, rumo a {area:392}.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} fica na crista ao norte do acampamento Crinavalha, a leste da {area:380}.",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900} espera na margem de {zone:1411} do {area:814}, a leste do acampamento Crinavalha.",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectários da {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "Sectários da Lâmina Ardente ocupam a {area:1898} no norte de {zone:1411}, perto da {area:370}; eles derrubam a {item:6652}.",

	-- Step 10: Razormane camp
	["Razormane camp"] = "Acampamento Crinavalha",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Rabdomantes, Tecespinhos e Caçadores Crinavalha ocupam o acampamento a leste da {area:380}. As caixas de suprimentos ficam no extremo leste. Guerreiros: o {object:58369} fica no acampamento. Xamãs: os javatuscos derrubam o {item:5026}. Mate os Predadores da Savana que encontrar pelas garras.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} faz a {item:6636} com o piche e a bolsa. Use-a junto ao braseiro ao lado dele para revelar a {npc:5893}, mate-a para pegar a {item:6655} e coloque a brasa no braseiro.",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, o seu {item:5176} e o {item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Siga a estrada para sudeste até {area:392}, na costa.",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, no cais",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Praia dos Mares do Sul",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "Os piratas acampam na praia ao sul de {area:392}. As pilhas de peças complicadas estão dentro e em volta do acampamento.",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "De volta ao acampamento pirata: as botas estão na caixa marcada {object:3767}, no extremo sul do acampamento, e a lente na caixa Frágil logo a leste dela.",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "De volta à {area:380}",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Suba a estrada de volta até a {area:380}. Predadores da Savana caçam ao longo dela e nas planícies a oeste da cidade: termine as garras antes de entregá-las.",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} fica no posto de vigia Kolkar logo a oeste da {area:380}.",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "Acampamentos Kolkar e {area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Os acampamentos Kolkar se espalham a noroeste de {npc:3389}; qualquer Kolkar pode derrubar {quest:855}. {area:386} ficam no meio deles, com Cogumelos Carregados em volta da água. Predadores da Savana vagam pelas mesmas planícies.",
	["Wade into the pools to explore them"] = "Entre nos charcos para explorá-los",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "Harpias Asabruxa",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "As harpias fazem ninho nos {area:383}, a noroeste de {area:386}; qualquer uma pode derrubar uma garra.",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Siga para leste até o local de pesquisa da Empreendimentos S.A., a oeste do {area:382}. Use o {object:4141}, feche as três válvulas em volta da perfuratriz, use o console de novo e pegue a {item:5089} de {npc:3471}.",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "O covil de {quest:881} fica ao sul do {area:382}, a nordeste da {area:380}. Use lá a trompa que {npc:3338} lhe deu para atrair o leão branco. Depois use a Pedra de Regresso para {area:392}.",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "No caminho de volta para a {area:380}, o acampamento Crinavalha de novo: Geomantes e Defensores Crinavalha ocupam a metade leste; {npc:3438} anda entre eles.",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "O oásis fica a sudeste da {area:380}. Teste as sementes na fissura borbulhante no meio da água.",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "A {area:1697} fica a sudoeste do oásis. As Garrafoices Helióscamos derrubam as penas que você usa nos três ninhos.",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Mordeliscas do Oásis lotam a água do {area:387}, a sudoeste da {area:380}.",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "Siga a estrada para o norte até a {area:1703}; {npc:9316} fica logo ao sul dela.",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "Os Baldes de Ferramentas ficam em volta do acampamento da Empreendimentos S.A. no {area:382}, a leste de {npc:9316}.",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "Asabruxas Matadoras",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "As Matadoras ocupam o extremo oeste dos {area:383}, depois das harpias que você enfrentou antes; elas derrubam os anéis.",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "evolua com Asabruxas Matadoras nos {area:383}, {zone:1413}",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "De volta à {area:380}; o próximo guia começa aqui.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:386}"] = "{area:386}",
}
