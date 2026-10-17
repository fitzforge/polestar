-- Portuguese (Brazil) (ptBR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} é sua base neste guia. Todos de quem você precisa ficam a poucos passos da estalagem.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre dos mantícoras",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: as harpias vêm depois, em {area:383}",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Pinotes e raptores",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Pinotes e raptores Helióscamo vagam pelas planícies em volta da {area:380}, mais densos ao norte.",

	-- Step 4: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "Zevras Corredoras pastam ao norte e a leste da cidade.",
	["Zhevra"] = "Zevras",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Acampamento Crinavalha",
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Os Predadores da Savana caçam nas planícies entre a cidade e o acampamento Crinavalha a leste. No acampamento, Rabdomantes e Tecespinhos ocupam a metade oeste, Caçadores o meio; os caixotes de suprimentos ficam na ponta leste.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} fica na serra ao norte do acampamento Crinavalha.",

	-- Step 8: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Siga a estrada para leste até o posto acima de {area:814}.",

	-- Step 9: Thunder lizards across the river
	["Thunder lizards across the river"] = "Lagartos trovejantes do outro lado do rio",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam logo depois da ponte, abaixo de {area:379}.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} espera na margem do rio ao sul de {area:379}, do outro lado da ponte.",

	-- Step 12: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectários de {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Sectários da Lâmina Ardente ocupam {area:1898}, no norte de {zone:1411}; eles deixam cair o {item:6652}. O {item:5026} vem dos Crinavalha na sua próxima visita ao acampamento deles.",

	-- Step 13: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} acampa junto à estrada da {area:380} para {area:392}. O {object:58369} fica no sul do acampamento Crinavalha, logo ao norte dele.",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Siga a estrada para sudeste até {area:392}, no litoral.",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: o console fica em {area:382}, depois",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, no cais",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Praia dos Mares do Sul",
	-- {area:392} Ratchet
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Os piratas acampam na praia ao sul de {area:392}. As pilhas de peças complicadas ficam na areia entre eles.",

	-- Step 17: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Volte pela praia, depois do acampamento pirata: o caixote de botas e o caixote frágil com a lente ficam na ponta sul.",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads
	["Walk back west along the road to the {area:380}."] = "Volte para oeste pela estrada até a {area:380}.",

	-- Step 20: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "De volta ao acampamento Crinavalha. Geomantes e Defensores ocupam a metade leste; {npc:3438} anda entre eles.",

	-- Step 21: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} faz {item:6636} com o piche e o bornal. Use-o junto ao braseiro ao lado dele para revelar o {npc:5893}, mate-o pela {item:6655} e depois coloque a brasa no braseiro.",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, seu {item:5176} e o {item:263412}",

	-- Step 23: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, um leão branco, ronda as planícies ao norte do acampamento Crinavalha.",

	-- Step 24: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "A {object:4141} fica no sítio de pesquisa da Empreendimentos S.A. a oeste de {area:382}. Feche as três válvulas em volta da perfuratriz, use o console de novo e pegue o {item:5089} de {npc:3471}, ao lado.",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} em {area:392}: depois, no caminho",

	-- Step 25: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "Para oeste até {area:383}. As harpias Asabruxa fazem ninho por toda parte; qualquer uma pode deixar cair uma garra. {quest:819} fica nas colinas delas.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "Para o sul até o posto de vigia de {npc:3389}, na fronteira kolkar.",

	-- Step 27: The Forgotten Pools
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Os poços ficam logo ao norte de {npc:3389}. Entre na água para explorá-los; os Cogumelos Carregados para Hermógenes crescem em volta deles. Mate todo kolkar que encontrar pelas braçadeiras.",

	-- Step 28: Kolkar camps
	["Kolkar camps"] = "Acampamentos kolkar",
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Kolkar Wranglers = {npc:3272} Kolkar Wrangler
	["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Cavalgantes e Tempestários Kolkar ocupam os acampamentos ao sul de {npc:3389}.",

	-- Step 31: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "A sudeste da {area:380}. Teste as sementes na fenda borbulhante da margem leste do oásis.",

	-- Step 32: Raptor nests
	["Raptor nests"] = "Ninhos de raptor",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Os três ninhos ficam juntos em {area:1697}, a sudoeste do oásis; Garrafoices Helióscamo os guardam.",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "Para leste até {area:392}, no litoral.",

	-- Step 34: The Crossroads
	["Back west along the road."] = "Volte para oeste pela estrada.",

	-- Step 35: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Mordeliscas do Oásis rastejam em volta de {area:387}, a sudoeste da {area:380}, e em volta de {area:388}.",

	-- Step 36: The Crossroads
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} em {zone:1421}, no próximo guia",

	-- Step 37: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "As Asabruxas Matadoras ocupam o oeste de {area:383}; elas usam os anéis.",

	-- Step 38: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "Para leste até {area:1703}; {npc:9316} fica no acampamento logo ao sul.",

	-- Step 39: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Os baldes de ferramentas com as lesmas ficam em volta da perfuração da Empreendimentos S.A. em {area:382}, a leste de {npc:9316}.",

	-- Step 40: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar
	["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Guarde-o: {quest:3923} fica do lado de fora de {zone:1454}; um guia posterior o entrega",

	-- Step 41: The Crossroads
	-- {area:380} The Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Volte para o sul até a {area:380}. O próximo guia começa aqui e leva você a {zone:1454} e ao zepelim para {zone:1420}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:383}"] = "{area:383}",
}
