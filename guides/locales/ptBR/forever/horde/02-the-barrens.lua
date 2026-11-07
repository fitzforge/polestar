-- Portuguese (Brazil) (ptBR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zargh
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3448} at the south gate."] = "Você chega vindo de {area:379}. {npc:3338} fica junto à estalagem; {npc:3448}, no portão sul.",

	-- Step 3: The Crossroads
	-- {npc:3464} Gazrog · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["Helbrim and {npc:3464} by the north gate.\n{npc:3429} and {npc:3449} on the tower platform."] = "Hermógenes e {npc:3464} junto ao portão norte.\n{npc:3429} e {npc:3449} na plataforma da torre.",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: as harpias vêm depois, em {area:383}",

	-- Step 4: On the way
	["On the way"] = "No caminho",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} acampa ao lado da estrada para o leste, rumo a {area:392}.",

	-- Step 12: Razormane camp
	["Razormane camp"] = "Acampamento Crinavalha",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "Rabdomantes, Tecespinhos e Caçadores ocupam o acampamento a leste de {area:380}. As caixas de suprimentos ficam na ponta leste. Guerreiros: {object:58369} fica no acampamento. Xamãs: os javatuscos deixam cair {item:5026}. Mate os Predadores da Savana que encontrar pelas garras.\nCuidado: o baú fica ao lado de uma carroça quebrada, guardado por uma dupla de Crinavalha, incluindo caçadores que podem puxar mais javatuscos para a briga.",

	-- Step 14: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine, as at 10. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "Volte para leste pela ponte e suba a trilha até o santuário de {npc:5900}, como no nível 10. {npc:5900} faz {item:6636} com o piche e o bornal. Use junto ao braseiro ao lado dele para revelar {npc:5893}, mate-a para pegar {item:6655} e depois ponha a brasa no braseiro.",

	-- Step 15: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, seu {item:5176} e o {item:263412}",

	-- Step 18: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Siga a estrada para sudeste até {area:392}, no litoral.",

	-- Step 20: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} é sua base neste guia. Todos de quem você precisa ficam a poucos passos da estalagem.",

	-- Step 21: Razormane Water Seeker on the way
	-- {npc:3267} Razormane Water Seeker
	["{npc:3267} on the way"] = "{npc:3267} no caminho",

	-- Step 22: The Barrens: kill these as you meet them
	-- {area:17} The Barrens
	["{area:17}: kill these as you meet them"] = "{area:17}: vá matando estes pelo caminho",
	-- {area:380} The Crossroads
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north.\nCareful: Sunscale Screechers call nearby allies within 30 yd once below 30% health, so dense packs can pull extra raptors."] = "Pinotes e raptores Helióscamo vagam pelas planícies em volta de {area:380}, mais concentrados ao norte.\nCuidado: os Uivadores Helióscamo chamam aliados num raio de 30 jd quando ficam abaixo de 30% de vida, então bandos cheios podem trazer raptores extras.",

	-- Step 24: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "Zevras Corredoras pastam ao norte e a leste da cidade.",
	["Zhevra"] = "Zevras",

	-- Step 26: Razormane camp
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Os Predadores da Savana caçam nas planícies entre a cidade e o acampamento Crinavalha a leste. No acampamento, Rabdomantes e Tecespinhos ocupam a metade oeste, Caçadores o meio; os caixotes de suprimentos ficam na ponta leste.",

	-- Step 30: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} fica na serra ao norte do acampamento Crinavalha.",

	-- Step 31: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Siga a estrada para leste até o posto acima de {area:814}.",

	-- Step 33: Thunder lizards across the river
	["Thunder lizards across the river"] = "Lagartos trovejantes do outro lado do rio",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam logo depois da ponte, abaixo de {area:379}.",

	-- Step 35: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} espera na margem do rio ao sul de {area:379}, do outro lado da ponte.",

	-- Step 36: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectários de {area:1898}",
	-- {area:1898} Dustwind Gulch · {area:14} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Sectários da Lâmina Ardente ocupam {area:1898}, no norte de {area:14}; eles deixam cair {item:6652}. {item:5026} vem dos Crinavalha na sua próxima visita ao acampamento deles.",

	-- Step 39: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} acampa junto à estrada da {area:380} para {area:392}. O {object:58369} fica no sul do acampamento Crinavalha, logo ao norte dele.",

	-- Step 41: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, no andar de cima",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: o console fica em {area:382}, depois",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "cartaz {object:3972}",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, no cais",

	-- Step 42: Intact Raptor Horn on the way
	-- {item:5055} Intact Raptor Horn
	["{item:5055} on the way"] = "{item:5055} no caminho",

	-- Step 43: The Barrens: kill these as you meet them
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them.\nThe pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Os piratas acampam na praia ao sul de {area:392}. Os montes de peças complicadas estão na areia, no meio deles.\nOs piratas acampam na praia ao sul de {area:392}; {npc:3467} fica na ponta sul.",

	-- Step 45: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Volte pela praia, depois do acampamento pirata: o caixote de botas e o caixote frágil com a lente ficam na ponta sul.",

	-- Step 47: Fly to The Crossroads
	-- {area:380} The Crossroads
	["Fly to {area:380}"] = "Voe para {area:380}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 49: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "Para o sul até o posto de vigia de {npc:3389}, na fronteira kolkar.",

	-- Step 50: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Os poços ficam logo ao norte de {npc:3389}. Entre na água para explorá-los; os Cogumelos Carregados para Hermógenes crescem em volta deles. Mate todo kolkar que encontrar pelas braçadeiras.",

	-- Step 52: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	-- plural, as words: Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "Para oeste até {area:383}. As harpias Asabruxa fazem ninho por toda parte; qualquer uma pode deixar cair uma garra. {quest:819} está nas colinas delas.\nCuidado: há 2 Asabruxas Emboscadoras (nível 17-18). Elas ficam furtivas fora de combate.",

	-- Step 53: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "{object:4141} fica no posto de pesquisa da Empreendimentos S.A. a oeste de {area:382}. Feche as três válvulas em volta da perfuratriz, use o painel de novo e pegue {item:5089} com {npc:3471}, ali do lado.\nCuidado: vários guardas ficam ao alcance das válvulas, renascem em menos de uns 3 minutos e fogem com pouca vida para chamar reforço; monstros por perto também entram na briga se você mexer numa válvula com eles ali.",
	["Inside"] = "Lá dentro",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} em {area:392}: depois, no caminho",

	-- Step 54: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn."] = "{quest:881}, um leão branco, ronda as planícies ao norte do acampamento dos Crinavalha.\nCuidado: Caçadoras da Savana andam em volta do covil. Elas renascem rápido e costumam entrar na briga junto com {quest:881}, então limpe a área antes de soprar o chifre.",

	-- Step 55: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "Pedra de Regresso para {area:392}",

	-- Step 56: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "Para leste até {area:392}, no litoral.",

	-- Step 57: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "De volta ao acampamento Crinavalha. Geomantes e Defensores ocupam a metade leste; {npc:3438} anda entre eles.",

	-- Step 59: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} faz {item:6636} com o piche e o bornal. Use-o junto ao braseiro ao lado dele para revelar a {npc:5893}, mate-a pela {item:6655} e depois coloque a brasa no braseiro.",

	-- Step 63: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "A sudeste da {area:380}. Teste as sementes na fenda borbulhante da margem leste do oásis.",
	["Underwater"] = "Debaixo d'água",

	-- Step 64: The Crossroads
	["Back west along the road."] = "Volte para oeste pela estrada.",

	-- Step 65: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "Para leste até {area:1703}; {npc:9316} fica no acampamento logo ao sul.",

	-- Step 66: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Os baldes de ferramentas com as lesmas ficam em volta da perfuração da Empreendimentos S.A. em {area:382}, a leste de {npc:9316}.",

	-- Step 67: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Para leste até {area:382}. {npc:3439} fica dentro do acampamento da Empreendimentos S.A.; quem está com a chave é {npc:3445}.",

	-- Step 68: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words)
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the next guide's {zone:1454} visit"] = "Guarde: {quest:3923} fica no Vale da Honra, em {zone:1454}, na visita a {zone:1454} do próximo guia",

	-- Step 69: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "As Asabruxas Matadoras ocupam o oeste de {area:383}; são elas que usam os anéis.\nCuidado: algumas harpias emboscadoras furtivas esperam na área e só aparecem quando você chega perto. Uma harpia elite de nível 19 também patrulha por lá.",

	-- Step 71: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Mordeliscas do Oásis rastejam em volta de {area:387}, a sudoeste da {area:380}, e em volta de {area:388}.",

	-- Step 72: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "O próximo guia começa aqui e leva você a {zone:1454} e ao zepelim para {zone:1420}.",
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} em {zone:1421}, no próximo guia",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Sectários da Lâmina Ardente ocupam {area:1898}, no norte de {zone:1411}; eles deixam cair o {item:6652}. O {item:5026} vem dos Crinavalha na sua próxima visita ao acampamento deles.",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Guarde-o: {quest:3923} fica do lado de fora de {zone:1454}; um guia posterior o entrega",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Cavalgantes e Tempestários Kolkar ocupam os acampamentos ao sul de {npc:3389}.",
	-- ["Kolkar camps"] = "Acampamentos kolkar",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Pinotes e raptores Helióscamo vagam pelas planícies em volta da {area:380}, mais densos ao norte.",
	-- ["Plainstriders and raptors"] = "Pinotes e raptores",
	-- ["Raptor nests"] = "Ninhos de raptor",
	-- ["Southsea beach"] = "Praia dos Mares do Sul",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "As Asabruxas Matadoras ocupam o oeste de {area:383}; elas usam os anéis.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Os piratas acampam na praia ao sul de {area:392}. As pilhas de peças complicadas ficam na areia entre eles.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Os três ninhos ficam juntos em {area:1697}, a sudoeste do oásis; Garrafoices Helióscamo os guardam.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "A {object:4141} fica no sítio de pesquisa da Empreendimentos S.A. a oeste de {area:382}. Feche as três válvulas em volta da perfuratriz, use o console de novo e pegue o {item:5089} de {npc:3471}, ao lado.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Volte para o sul até a {area:380}. O próximo guia começa aqui e leva você a {zone:1454} e ao zepelim para {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Volte para oeste pela estrada até a {area:380}.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "Para oeste até {area:383}. As harpias Asabruxa fazem ninho por toda parte; qualquer uma pode deixar cair uma garra. {quest:819} fica nas colinas delas.",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre dos mantícoras",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, um leão branco, ronda as planícies ao norte do acampamento Crinavalha.",
}
