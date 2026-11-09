-- Portuguese (Brazil) (ptBR): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {zone:1429} Elwynn Forest · {quest:174} Look to the Stars · {area:42} Darkshire · {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {object:2096} Trade District
	["Train, then leave by the main gate and follow the road east through {zone:1429}.\n{quest:174} in {area:42} needs a {item:4371}. Its vendors keep only one or two, and {npc:3133} in {area:42} is nearly always sold out: buy one at the Auction House in the {object:2096} on your way out. An engineer can make one too."] = "Treine, depois saia pelo portão principal e siga a estrada para leste por {zone:1429}.\n{quest:174} em {area:42} precisa de {item:4371}. Os vendedores de lá guardam só um ou dois, e {npc:3133} em {area:42} quase sempre está sem estoque: compre um na Casa de Leilões do {object:2096} ao sair. Um engenheiro também pode fazer um.",
	["Level 18 and 20 spells"] = "Feitiços de nível 18 e 20",
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {area:42} Darkshire
	["{item:4371}: the Auction House, for {quest:174} in {area:42}"] = "{item:4371}: Casa de Leilões, para {quest:174} em {area:42}",

	-- Step 2: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda Armas de Haste com {npc:11867} ({object:2096}, 1 ouro); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Armas de Haste com {npc:11867} ({object:2096}, 1 ouro); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 4: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Metrô para {zone:1455}",

	-- Step 5: Shaman training
	["Shaman training"] = "Treino de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} no {object:28027} até {zone:1455}, treine com {npc:258098} e volte de metrô.",

	-- Step 6: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "Voe para {area:108}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",

	-- Step 7: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn."] = "Voe até {area:108} e vá para noroeste até a costa: {object:177790} está no fundo do mar perto da praia. Depois siga para leste pela estrada, por Elwynn.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: o {object:177790}",

	-- Step 8: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "De volta a {zone:1429}",
	-- {zone:1429} Elwynn Forest
	["The road into {zone:1429}"] = "",

	-- Step 9: Elwynn Forest
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",

	-- Step 10: Theocritus
	["On the top floor"] = "No último andar",

	-- Step 11: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Na estrada para leste, depois de {area:91}, saia da ponte para o norte até {area:86}. {npc:6172} está caído ao sul do lago: use o {item:6866} nele. Os Teurgos Proscritos Défias em volta dele carregam a {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Use o {item:6866} em {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Teurgos Proscritos Défias",

	-- Step 12: Three Corners
	-- {area:1002} Three Corners · {zone:1431} Duskwood
	["The road east through Elwynn crosses into Redridge at {area:1002}, where the roads to Redridge, {zone:1431} and Elwynn meet: south to {zone:1431} first."] = "A estrada para leste por Elwynn cruza para Cristarrubra em {area:1002}, onde se encontram as estradas para Cristarrubra, {zone:1431} e Elwynn: primeiro ao sul, até {zone:1431}.",

	-- Step 14: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire · {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133}, in the house beside {npc:276}, keeps only one and is usually sold out. Without one, right-click the quest in the guide window and skip it.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "Siga a estrada para o sul a partir de {area:1002} até {zone:1431}; {area:42} fica no lado leste da floresta.\nSem {item:4371} para {quest:174}? {npc:3133}, na casa ao lado de {npc:276}, guarda só um e costuma estar sem estoque. Sem ele, clique com o botão direito na missão na janela do guia e pule-a.\nA casa de {npc:276} fica no extremo leste da cidade. {npc:3133} vende artigos de engenharia na casa ao lado.",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, no extremo norte da cidade",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "{npc:265}, na casa dela junto à taberna; lá dentro",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}, lá dentro",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taberna Corvo Escarlate",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, na prefeitura",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, na prefeitura",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, na casa atrás da prefeitura",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "{npc:633}, na ponta sul da cidade; lá dentro",
	-- {npc:633} Elaine Carevin · {npc:288} Jitters · {quest:163} Raven Hill
	["{npc:633}: {npc:288}, at {quest:163}"] = "{npc:633}: {npc:288}, em {quest:163}",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, de {npc:3133}, se não tiver nenhum",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, lá dentro",
	-- {npc:302} Blind Mary
	["For {npc:302}, on the hill south-east of town"] = "Para {npc:302}, no morro a sudeste da cidade",

	-- Step 15: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "{area:121}: vá matando estes pelo caminho",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "Guerreiros e Magos Descarnados andam entre os túmulos a sudeste de {area:42}, abaixo da casa de {npc:302} no morro. Todo esqueleto de {zone:1431} pode deixar cair um {item:2378}.\nCuidado: como os esqueletos ficam perto uns dos outros, entrar correndo costuma puxar vários de uma vez.",

	-- Step 16: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} fica ao sul da estrada, em {area:245}.",

	-- Step 17: Raven Hill
	-- {quest:163} Raven Hill · {object:673515} Memory of Valor (no name in this language: may be words) · {npc:288} Jitters
	["Continue west to {quest:163}. The {object:673515} glows by the ruined house south of the road; {npc:288} hides in the house at the west end of the village."] = "Continue para oeste até {quest:163}. {object:673515} brilha perto da casa em ruínas ao sul da estrada; {npc:288} se esconde na casa do extremo oeste da vila.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor (no name in this language: may be words)
	["{item:281046}, from the {object:673515}"] = "{item:281046}, de {object:673515}",
	-- {npc:272} Chef Grual · {area:42} Darkshire
	["for {npc:272} in {area:42}"] = "para {npc:272} em {area:42}",

	-- Step 18: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Siga a estrada para noroeste, passando o cemitério, até o acampamento de {npc:311}, no extremo oeste da floresta. {npc:893} fica ao lado de {npc:311}.",

	-- Step 19: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "{area:1097}: vá matando estes pelo caminho",
	-- {npc:289} Abercrombie · {area:1097} The Hushed Bank · {quest:163} Raven Hill · {npc:311} Sven Yorgen · {zone:1436} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders are the small spiders, and few: most crawl along the {area:1097} west of {quest:163}, fewer up north towards {npc:311}'s camp; they drop the venom too. Every ghoul of the cemetery's northern half can drop a fang. Wolves and the bigger spiders share the {zone:1436} border, so pull with care."] = "Lobos Hediondos Raivosos vagam pelos bosques em volta do cemitério e de {npc:289}, e Lobos Hediondos Famintos pelas colinas a nordeste dele. Veneracnas Pigmeias são as aranhas pequenas, e poucas: a maioria rasteja pela {area:1097}, a oeste de {quest:163}, e menos ao norte, em direção ao acampamento de {npc:311}; elas também soltam o veneno. Todo carniçal da metade norte do cemitério pode soltar uma presa. Lobos e as aranhas maiores dividem a divisa com {zone:1436}, então puxe com cuidado.",
	-- {item:1130} Vial of Spider Venom
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Venom Web Spiders = {npc:217} Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "{item:1130}: Veneracnas Pigmeias, Venaracnas e Reclusas Verdes",

	-- Step 20: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "O barraco do eremita fica na mata a nordeste de {area:492}.",

	-- Step 21: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}: vá matando estes pelo caminho",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "O cemitério fica ao norte do vilarejo. Horrores Descarnados e Malévolos Descarnados andam pela metade sul. {npc:522}, um elite, vaga entre os túmulos: fique longe dele.",

	-- Step 22: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "Volte para leste pela estrada até {area:245}.",

	-- Step 23: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "O monte de terra solta fica ao sul da casa da fazenda, junto ao velho toco.",

	-- Step 24: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "{npc:268}, lá dentro",
	-- {npc:272} Chef Grual
	["{npc:272}, in the Scarlet Raven Tavern"] = "{npc:272}, na Scarlet Raven Tavern",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, junto à prefeitura",

	-- Step 26: Redridge Mountains
	-- {area:42} Darkshire · {area:1002} Three Corners
	["Back north along the road from {area:42} to {area:1002}."] = "De volta ao norte pela estrada, de {area:42} até {area:1002}.",

	-- Step 27: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:903} stands by the road next to her."] = "Siga a estrada pela margem sul de {area:68} até o mestre de grifos. {npc:903} fica na estrada ao lado dela.",

	-- Step 28: Lake Everstill's murlocs: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}'s murlocs: kill these as you meet them"] = "Murlocs de {area:68}: vá matando estes pelo caminho",
	-- {area:68} Lake Everstill
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore of {area:68}, just east of the gryphons and the bridge. Any of them can carry a fin."] = "Carniceiros e Chamarés Murloc ocupam a margem sul de {area:68}, logo a leste dos grifos e da ponte. Qualquer um deles pode carregar uma nadadeira.",

	-- Step 29: Lakeshire
	-- {npc:381} Dockmaster Baren · {npc:900} Bailiff Conacher · {npc:342} Martie Jainrose · {npc:382} Marshal Marris · {quest:98386} Alther's Mill
	["Cross the long bridge north into town: {npc:381} on the docks, {npc:900} in the town hall, the innkeeper in the inn, {npc:342} in her garden at the west end. {npc:382}'s Blackrock quests and {quest:98386} came with you from your first Redridge visit."] = "Atravesse a ponte longa para o norte, em direção à cidade: {npc:381}, nas docas, {npc:900}, na prefeitura, o estalajadeiro, na estalagem, e {npc:342}, na horta dela, na ponta oeste. As missões Rocha Negra de {npc:382} e {quest:98386} vieram com você desde a sua primeira visita a Cristarrubra.",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "{npc:900}, na prefeitura",
	["The Wanted poster by the inn"] = "O cartaz de procura-se perto da estalagem",

	-- Step 30: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire · {npc:342} Martie Jainrose
	["{npc:345} (level 24) roots around the pen just west of {area:69}, beside {npc:342}'s garden. Pull him away from the other boars and fight at full health."] = "{npc:345} (nível 24) fuça em volta do chiqueiro logo a oeste de {area:69}, ao lado da horta de {npc:342}. Afaste-o dos outros javalis e lute com a vida cheia.",

	-- Step 31: Martie Jainrose
	-- {npc:342} Martie Jainrose
	["{npc:342}'s garden is at the west end of town."] = "A horta de {npc:342} fica na ponta oeste da cidade.",

	-- Step 32: Lakeshire
	-- {npc:342} Martie Jainrose
	["Back east through town from {npc:342}'s garden: two Wanted posters hang on the town hall doorway."] = "De volta a leste pela cidade, saindo da horta de {npc:342}: dois cartazes de PROCURA-SE ficam na porta da prefeitura.",
	["The Wanted poster on the town hall doorway"] = "O cartaz de PROCURA-SE na porta da prefeitura",
	["The Wanted poster beside it"] = "O cartaz de PROCURA-SE ao lado dele",

	-- Step 33: Alther's Mill
	-- {quest:98386} Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Tarantula Eggs = {object:673101} Tarantula Egg
	["Greater Tarantulas crawl on the slopes around {quest:98386}, north-east of the lake; their Tarantula Eggs lie on the ground among them: click six."] = "Grandes Tarântulas rastejam pelas encostas ao redor de {quest:98386}, a nordeste do lago; os Ovos de Tarântula ficam no chão entre elas: clique em seis.",

	-- Step 34: Blackrock camps
	["Blackrock camps"] = "Acampamentos Rocha Negra",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies."] = "Ao sudeste do moinho, a oeste dos gnolls de {area:1000}, até os acampamentos da Rocha Negra a leste de {area:2099}. Renegados, Brutos e Vanguardeiros os ocupam; fique a leste da fortaleza, cujos orcs são elite. Suportes de armas e espadas estão espalhados pelos acampamentos; pernis de carne, sacos de grãos e barris de água guardam os suprimentos.",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "{item:280841}: cavaletes de armas e espadas no chão",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "{item:280839}: pernis de carne, sacos de grãos, barris de água",

	-- Step 35: Incinerator Gar'im
	["Gar'im keeps to the cave at the camps' south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast."] = "Incinerador Gar'im fica na caverna no extremo sul dos acampamentos, com seu diabrete e dois orcs. Elite: forme grupo se puder; sozinho, puxe antes os orcs da entrada e interrompa o feitiço de fogo dele.",

	-- Step 36: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: clear the gnolls around him first and fight at full health. Stay out of {area:2099} to the west until the watch tower: its orcs are elite."] = "Ao norte, subindo pelo lado leste do vale. Gnolls Umbrapele o ocupam; {npc:703} (26) e seus dois guardas ficam no extremo norte: limpe antes os gnolls em volta dele e lute com a vida cheia. Fique longe de {area:2099}, a oeste, até a torre de vigia: os orcs de lá são elite.",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: qualquer gnoll Umbrapele",

	-- Step 37: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "A {object:31} fica na borda leste do vale.",

	-- Step 38: Looking Further
	-- {area:2099} Stonewatch Keep
	["West to the intact watch tower beside {area:2099}: climb it and leave the Glyph in the empty jar at the top."] = "A oeste, até a torre de vigia intacta ao lado de {area:2099}: suba nela e deixe o Glifo no pote vazio no alto.",

	-- Step 39: Stonewatch Keep
	-- {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The keep stands beside the tower. {npc:334} (elite) waits in the keep's top room with two guards and a dragon; Blackrock Shadowcasters (elite) and Sentries stand on its west side, so pull one at a time on the way in, and hug the right wall as you enter his room so you don't pull him at once. Elite: group up if you can."] = "A fortaleza fica ao lado da torre. {npc:334} (elite) espera na sala do alto da fortaleza com dois guardas e um dragão; Lança-sombras Rocha Negra (elite) e Sentinelas Rocha Negra ficam no lado oeste, então puxe um de cada vez na subida e vá rente à parede direita ao entrar na sala dele para não puxá-lo de uma vez. Elite: forme grupo se puder.",

	-- Step 40: Render's Valley
	-- {area:95} Redridge Canyons · {area:997} Render's Valley · {area:69} Lakeshire
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["From the keep head back west along the lake's north shore and north up the {area:95} to {area:997}; {area:69}'s hand-ins wait for Keeshan's escort, which ends there. Blackrock Champions camp in the valley."] = "Da fortaleza, volte para oeste pela margem norte do lago e ao norte pelo {area:95} até {area:997}; as entregas de {area:69} esperam a escolta de Keeshan, que termina lá. Campeões Rocha Negra acampam no vale.",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "{npc:435}, no subterrâneo",

	-- Step 41: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan se esconde no extremo norte do vale, na divisa com {zone:1428}. Escolte-o até {area:69}; orcs Rocha Negra emboscam vocês no caminho.",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "{npc:349}, no subterrâneo",

	-- Step 42: Magistrate Solomon: Gath'Ilzogg
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, na prefeitura",

	-- Step 44: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "De volta a {area:69}",
	-- {area:69} Lakeshire · {npc:900} Bailiff Conacher · {npc:344} Magistrate Solomon · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {npc:903} Guard Howe
	["Into {area:69} from the north with Keeshan: {npc:900} and {npc:344} in the town hall, {npc:382} and {npc:341} at the north end of the bridge, then over the bridge to {npc:903} and the gryphons."] = "Entre em {area:69} pelo norte com Keeshan: {npc:900} e {npc:344} na prefeitura, {npc:382} e {npc:341} no extremo norte da ponte, depois atravesse a ponte até {npc:903} e os grifos.",
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, junto aos grifos ao sul da ponte",
	-- {area:42} Darkshire · {zone:1431} Duskwood
	["Next: the gryphon to {area:42} for {zone:1431}'s second loop (05-duskwood)."] = "Em seguida: o grifo até {area:42} para o segundo circuito de {zone:1431} (05-duskwood).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Ronquifuça",
	-- ["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Atravesse a ponte comprida para o norte até a vila. {npc:341} e {npc:382} ficam na ponta norte da ponte, {npc:900} na prefeitura, {npc:381} e {npc:266} nas docas, {npc:343} na estalagem, {npc:342} na horta dela, no extremo oeste.",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "A leste, passe o moinho e atravesse o rio. Gnolls Umbrapele enchem o vale; {npc:703} (26, bem acima de você) os lidera no extremo norte: elimine a escolta dele primeiro e lute com ele com a vida cheia. Fique longe de {area:2099} ao sul: os orcs de lá são elite.",
	-- ["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "Siga a estrada para o sul a partir de {area:1002} até {area:10}; {area:42} fica no lado leste da floresta.\nSem {item:4371} para {quest:174}? {npc:3133} vende na casa ao lado de {npc:276}, em estoque limitado; {npc:1448}, em {area:150}, também vende.\nA casa de {npc:276} fica no extremo leste da cidade. {npc:3133} vende artigos de engenharia na casa ao lado.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Para {npc:3649}, na volta a {area:442} (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "Gnolls rumo a {area:1002}",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "Grandes Tarântulas rastejam pelas encostas em volta do moinho a nordeste do lago.",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Grandes Tarântulas rastejam nas encostas em volta do moinho a nordeste do lago; Renegados Rocha Negra ocupam o próprio moinho.",
	-- ["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Saia de {area:69} rumo ao norte, subindo os {area:95} até o {area:997}. Campeões Rocha Negra acampam no vale.",
	-- ["Lake murlocs"] = "Murlocs do lago",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Carniceiros Murloc e Chamarés ocupam a margem sul a leste da ponte. Qualquer um deles pode levar um {item:1467} ou uma barbatana.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Mestiços de Cristarrubra e outros gnolls ocupam as colinas a leste de {area:1002}, ao norte da estrada; Espancadores de Cristarrubra rondam entre eles, Caçadores Ilegais acampam ao sul da estrada. Condores Hediondos e Grandes Goretuscos vagam pelas mesmas colinas.",
	-- ["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Nade a leste da ponte para dentro do {area:68}; o baú está no fundo do lago.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "O cartaz de PROCURA-SE perto da estalagem: {npc:703}, em {area:1000}",
	-- ["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "A estrada de Elwynn entra em Cristarrubra em {area:1002}. {npc:464} fica onde se encontram as estradas para Cristarrubra e {zone:1431}.",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "O navio de {area:442} atraca em {area:17203}. Suba até a cidade para treinar e falar com {npc:1646}, depois saia pelo portão principal e siga a estrada a leste por {zone:1429}.",
	-- ["Train, then leave by the main gate and follow the road east through {area:12}."] = "Treine, depois saia pelo portão principal e siga a estrada para leste por {area:12}.",
	-- ["{area:68}: kill these as you meet them"] = "{area:68}: vá matando estes pelo caminho",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: qualquer gnoll Umbrapele",
	-- ["{item:280911}: Redridge Thrashers"] = "{item:280911}: Espancadores de Cristarrubra",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}: qualquer orc Rocha Negra",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}: os Renegados Rocha Negra do moinho",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: a carta de Trovejius de {area:442}",
	-- ["{npc:266}, by the docks"] = "{npc:266}, nas docas",
	-- ["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} está na SI:7 em {object:2100}, {npc:6122} no porão do {object:2164} no {object:2101}, {npc:376} na Catedral da Luz.",
	-- ["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: {npc:7024} em {zone:1436} a recebe, no fim de {zone:1431}",
	-- ["{npc:341}: after {quest:89}"] = "{npc:341}: depois de {quest:89}",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, na prefeitura",
	-- ["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {npc:11401} em {zone:1457} a recebe, mais tarde",
	-- ["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {npc:11406} em {zone:1455} a recebe, mais tarde",
	-- ["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {npc:258785} em {zone:1455} a recebe, mais tarde",
	-- ["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {npc:6244} em {zone:1413} a recebe, mais tarde",
	-- ["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "{zone:1431} é a próxima: siga a estrada a oeste até {area:1002}, depois ao sul até {area:42}.",
	-- ["{zone:1453} class quests"] = "Missões de classe em {zone:1453}",
}
