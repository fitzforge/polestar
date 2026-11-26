-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3197} Chillwind Camp · {zone:1428} Burning Steppes · {zone:1419} Blasted Lands · {zone:1447} Azshara
	["{area:3197} first, then the {zone:1428} and the {zone:1419}, then {zone:1447}."] = "Primeiro {area:3197}, depois {zone:1428} e {zone:1419}, e então {zone:1447}.",

	-- Step 1: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Para {zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	-- was: ["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Sua Pedra de Regresso está vinculada a {zone:1455} (o guia de {zone:1425} a vincula lá): use-a para voltar à estalagem."
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn from Un'Goro."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Estalagem de {zone:1455}",

	-- Step 2: Mystic Ward
	-- {npc:11406} High Priest Rohan · {npc:8405} Ogtinc · {zone:1447} Azshara
	["{npc:11406}: for {npc:8405} in {zone:1447}, at the end of this guide: keep it"] = "",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, at the end of this guide: keep it"] = "",

	-- Step 4: Courier Hammerfall
	-- {npc:10877} Courier Hammerfall
	["{npc:10877} rides around the city's ring on his ram: catch him as he passes."] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	["For {npc:10838} at {area:3197}, the next stop"] = "",

	-- Step 5: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Arquefilis fica ao lado do Rei Magni, em {object:171709}.",

	-- Step 6: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:3701} é uma missão de grupo neste nível: as relíquias ficam entre Aniquiladores de Guerra e Andachamas de 53-55, com {npc:8978} (57) por perto, de dois a cinco níveis acima de você, e a rota não volta a {zone:1428} depois. Vale a pena formar grupo, procure gente para ir junto. Se estiver sozinho, pule.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "As relíquias estão em {zone:1428}: guarde",

	-- Step 7: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Voe para {area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 8: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",

	-- Step 10: The Super Snapper FX
	-- {item:9328} Super Snapper FX · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["Gammerita need not die: target her and use the {item:9328}. She is a level 48 elite, so keep your distance.\nGammerita walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "",
	-- {item:9328} Super Snapper FX
	["the {item:9328} on Gammerita: no kill"] = "",

	-- Step 11: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Mestre de voo de {area:348}",

	-- Step 12: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "Siga para o norte saindo de {area:271}, entre em Alterac e vá para oeste até as muralhas de {area:279}: {npc:34365} fica do lado de fora. A missão dela vai para {npc:266524} em {area:1438}, para onde este guia voa depois.",

	-- Step 13: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "Siga para o norte, de {area:271}, pela estrada por Alterac até {area:3197}.",

	-- Step 14: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "{npc:10838} fica no meio do acampamento.",

	-- Step 15: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: vá matando estes pelo caminho",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	-- was: ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Esfoladores Descarnados e Carniçais Salivantes andam pelos campos ao norte do acampamento; todo o Flagelo daqui deixa cair Pedras do Flagelo.\nCuidado: esses mortos-vivos percebem você de longe, e outros por perto entram na briga quando um é puxado.\nCuidado: o {npc:10411} (3 no mapa, renascem em 15 min) fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa."
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 16: Chillwind Camp
	["Ride back south to the camp."] = "Cavalgue de volta para o sul até o acampamento.",
	-- {area:199} Felstone Field · {zone:1422} Western Plaguelands
	["keep it: the {area:199} cauldron waits for the {zone:1422} guide"] = "",

	-- Step 17: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "Voe para {area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Mestre de voo de {area:3197}",

	-- Step 18: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Voe para {area:69}",

	-- Step 19: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Mestre de voo de {area:2418}",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "Cavalgue para leste, saindo de {area:69}, e suba a passagem até {zone:1428}: {area:2418} fica no alto.",

	-- Step 20: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418} fica no sudeste das Estepes, no alto da passagem que sobe de Cristarrubra.",

	-- Step 21: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock · {npc:9602} Hahk'Zor · {npc:9604} Gorgon'och
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre · Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: the Firegut Ogres are 50 and the Ogre Mages 51, but the Brutes on the rock's east side are 52: take the ogres on the near side first and pull the Brutes one at a time.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull.\nCareful: the Firegut chiefs {npc:9602} and {npc:9604} (54) stand on the rock's east side among the Brutes: leave them be."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}, no subterrâneo",

	-- Step 22: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "As próximas tarefas de {npc:9177} ({npc:9176} e cinquenta Medalhões Rocha Negra) mandam você para o meio dos orcs Rocha Negra de 55-58 ao pé de {area:254}: pule-as.",

	-- Step 23: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Siga a estrada para o oeste e depois suba para o norte até o acampamento goblin em {area:251}.",

	-- Step 24: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: vá matando estes pelo caminho",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	-- was: ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Use {item:12284} em um {npc:7047} nas encostas a leste de {area:251}, logo antes de ele morrer, e depois saqueie a essência que ele deixa.\nCuidado: um {npc:8981} (nível 56, raro) anda pelas encostas perto das crias, e os {npc:7040} e Dracônidas em volta delas são elite: use o Incarcinatrix numa cria da borda e olhe em volta antes de cada puxada."
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, Volchan (60, a rare fire elemental) roams the hills east of {area:251}, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "",

	-- Step 25: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron (no name in this language: may be words)
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "As relíquias são as pedras esculpidas espalhadas por {area:250}, em volta de {area:251}: clique nelas até recuperar a informação. Pegue as da borda sul das ruínas, mais perto de {area:251}.\nCuidado: os Aniquiladores de Guerra e Andachamas de Thaurissan das ruínas são 53-55, e {npc:8978} (57) ocupa o acampamento de {object:147516} a sudoeste de {area:251}: pegue as relíquias na borda das ruínas, puxe um de cada vez e fique longe do acampamento.",

	-- Step 26: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Termina com {quest:4808} em {area:2255}, {zone:1452}: guarde-a",

	-- Step 27: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight.\nCareful: Volchan (60, a rare fire elemental) roams the hills around {npc:9459}'s cave: if he is about, wait for him to pass."] = "",
	["Below ground"] = "No subterrâneo",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, do tesouro",

	-- Step 29: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	-- was: ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:9461} é elite de nível 54: a maioria das classes encara sozinha no nível 56, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros."
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone."] = "",

	-- Step 31: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Volte para o leste pela estrada até a Vigia de Morgan.",

	-- Step 32: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Voe para {area:1438}",

	-- Step 33: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "Ardalan fica dentro de {area:1438}.",
	-- {npc:266524} Lieutenant Connar · {npc:266508} Sergeant Danneth · {area:1440} Serpent's Coil
	["{npc:266524}: {npc:266508} is in the {area:1440} caverns, on this loop"] = "",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, no alto da fortaleza",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "A próxima tarefa de {npc:8022}, {item:9471}, é uma missão de {area:978}: pule.",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}: {quest:87295}, as escamas vêm dos basiliscos mais adiante",

	-- Step 34: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "Siga para o norte saindo de {zone:1419} e entrando em {zone:1435}: o {npc:10996} fica junto à estrada que vem de {zone:1419}. Mantenha distância de {area:75}, a cidade da Horda a nordeste.",

	-- Step 35: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "Ouça a história dele e depois volte para o sul até Kum'isha.",

	-- Step 36: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "De volta a {zone:1419}",

	-- Step 37: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}: vá matando estes pelo caminho",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol · {npc:8301} Clack the Reaver · {npc:8298} Akubar the Seer · {area:1440} Serpent's Coil · {item:8244} Flawless Draenethyst Sphere
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk · Snickerfang Matriarchs = {npc:272386} Snickerfang Matriarch
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else.\nCareful: {npc:8301} (53, a rare scorpid) walks the north around 47,36, {npc:8298} (54, rare) the middle around 45,48, and Snickerfang Matriarchs (60) roam the ground east of here, between Kum'isha's hill and the {area:1440} (about 54-62, 31-47): give them room.\nAny mob here may drop a {item:8244}: keep it for Kum'isha."] = "",
	-- {item:8244} Flawless Draenethyst Sphere
	["{item:8244}, a rare drop"] = "",

	-- Step 39: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha espera em {area:2517}, o morro a sudoeste da fortaleza. Os monstros de {zone:1419} no caminho deixam cair os Fragmentos Imperfeitos de Draenetista; leve o que tiver. Chegue ao morro dela direto da fortaleza, pela estrada, e saia pelo mesmo caminho.\nCuidado: Vilcular, {npc:7664} e Ilifar são todos elite de nível 60. Razelikh usa {spell:2691}, {spell:8255} e Dizimar e, conforme a vida cai, acrescenta {object:141891}, {spell:10854} e por fim Enfurecer com 15%.\nCuidado: {npc:247015}, um elite de nível 55, fica junto ao morro de Kum'isha (por volta de 50,35) e a oeste (por volta de 39,32), e os acampamentos Malho Medonho e Jurassombra ao redor são de nível 53-55: pegue os fragmentos dos monstros no caminho desde a fortaleza, não ao lado dele.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363} anda por aqui: procure dentro do círculo no mapa",

	-- Step 40: Kum'isha the Collector
	-- {zone:1419} Blasted Lands · {item:8244} Flawless Draenethyst Sphere
	["A {zone:1419} mob dropped a {item:8244}: Kum'isha pays for it too."] = "",

	-- Step 41: Sergeant Danneth
	-- {area:1440} Serpent's Coil · {area:1438} Nethergarde Keep · {npc:7728} Kirith the Damned · {npc:7666} Archmage Allistarj
	-- plural, as words: Snickerfang Matriarchs = {npc:272386} Snickerfang Matriarch · Shadowsworn Cultists = {npc:6004} Shadowsworn Cultist
	["Ride east from Kum'isha's hill to the mouth of the {area:1440} caverns, due south of {area:1438}: Danneth hides just inside.\nCareful: Snickerfang Matriarchs (60) roam the ground between Kum'isha's hill and the caverns: watch for them on the ride and go round them, there and back.\nCareful: Shadowsworn Cultists, Thugs and Adepts (51-52) guard the caves, and the deeper chambers hold {npc:7728} (55, elite) and {npc:7666} (58, elite): stay near the mouth, pull one at a time, and lead Danneth straight out.\nWalk him out of the caves and north to {area:1438}: Connar takes him there."] = "",

	-- Step 42: Nethergarde Keep
	-- {area:1438} Nethergarde Keep · {npc:3546} Bernie Heisten
	["Back north into {area:1438}: Connar, then Danneth again once he is home. {npc:3546} takes his scales here too."] = "",
	-- {npc:34365} Orphan Matron Aria · {zone:1423} Eastern Plaguelands · {area:3197} Chillwind Camp
	["For {npc:34365} in Alterac, on the Western & {zone:1423} guide's ride to {area:3197}: keep it"] = "",

	-- Step 43: The bloodmages
	["The bloodmages"] = "Os magos de sangue",
	-- {zone:1419} Blasted Lands
	["Ride west out of the keep to the bloodmages' camp beside the road into the {zone:1419}."] = "",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "A segunda etapa dos Magos Sangrentos paga pelas mesmas partes com um item de bônus e sem experiência: pule.",

	-- Step 44: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "Use a Pedra de Regresso para voltar à estalagem de {zone:1455}.",

	-- Step 45: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Voe para {area:144}",

	-- Step 48: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Voe para {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Mestre de voo de {area:144}",

	-- Step 50: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "Arquefilis fica ao lado do Rei Magni, em {object:171709}: as relíquias que você leu nas Estepes são dele.",

	-- Step 51: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",

	-- Step 53: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Voe para {area:415}",
	-- {area:442} Auberdine · {area:415} Astranaar · {zone:1448} Felwood · {zone:1457} Darnassus
	["The boat lands in {area:442}: fly straight on to {area:415}. Erelas, Jenal and Gracina take their deliveries on the {zone:1448} guide's {zone:1457} stop, which goes there anyway."] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Mestre de voo de {area:442}",

	-- Step 54: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "Rumo a {zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "De {area:415}, siga para o leste pela estrada, passando por {area:2358}, até {zone:1447}: {area:1235} fica logo depois da fronteira, no canto sudoeste de {zone:1447}.",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "Para o leste pela estrada até {area:1235}",

	-- Step 55: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "O santuário fica no canto sudoeste de {zone:1447}, ao sul de {area:3137}.",

	-- Step 56: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "Logo a nordeste do santuário: {npc:239822} e {npc:240482} cuidam do acampamento da Aliança em {area:3137}.",

	-- Step 57: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "Corredores Cascomusgo",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "Os Corredores Cascomusgo (45-47) pastam nas colinas ao norte de {area:3137}, a caminho dos sátiros.",

	-- Step 58: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447}: vá matando estes pelo caminho",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "Os fantasmas Altaneiros assombram as ruínas ao redor do santuário; os sátiros Haldarr ocupam o acampamento logo ao norte dele. {npc:222478} está presa no acampamento dos sátiros: liberte-a e escolte-a para fora.",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}, no acampamento",

	-- Step 59: The western shore
	["The western shore"] = "A costa oeste",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "Os Guerreiros Iralisca (46-47) e os Gritadores (47-48) ocupam a costa oeste, a nordeste dos sátiros.",

	-- Step 60: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "De volta para o sudoeste, até {area:3137}.",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath · {area:1221} Ruins of Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the {area:1221} ahead"] = "",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus · {zone:1448} Felwood
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, on the {zone:1448} guide: keep it"] = "",

	-- Step 63: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Siga para o nordeste a partir do santuário: {npc:8405} acampa em {area:1224}, nas colinas acima da estrada.",

	-- Step 64: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "Desmonte antes de falar com {npc:8395}: ele teletransporta você até a torre de {npc:8379}, no penhasco acima do acampamento dele.",

	-- Step 65: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "O aprendiz no alto da torre manda você de volta para baixo.",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "Os elfos sangrentos estão em {area:1220}, no caminho para {npc:8420}",

	-- Step 66: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {item:10445} Drawing Kit
	-- was: ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Os nagas Iralisca de {area:1221} carregam {item:13815}. As quatro runas de {npc:8507} ficam entre as ruínas: use o {item:10445} dele em cada uma."
	["The Spitelash naga of the {area:1221} carry {item:13815}. Tymor's runes stand among the ruins: use his {item:10445} on each."] = "",

	-- Step 67: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	-- was: ["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Os nagas Iralisca destas ruínas deixam cair Relíquias de Eldarath de Truesong, com complemento ou não. {npc:239939} (52) fica nas ruínas de Eldarath, a sudoeste dos Mirmidões: puxe-o sozinho."
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "",

	-- Step 68: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903} acampa junto à estrada para o norte, rumo a {npc:8420}: os sátiros dele estão no acampamento de {npc:8420}.",

	-- Step 69: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Ginetes Cascomusgo",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	-- was: ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Os Ginetes Cascomusgo mais próximos pastam nas colinas a nordeste de {area:1224}, em direção a {area:1219}; um rebanho maior vagueia pelo campo aberto ao sul.\nCuidado: os Ginetes Cascomusgo são 52-53, um ou dois níveis acima de você aqui: puxe um de cada vez pela borda do rebanho."
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53: pull them one at a time from the herd's edge."] = "",

	-- Step 72: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420} acampa em {area:1219}, no norte; o equipamento dele está espalhado por {area:1220}, logo a sudeste dele.\nCuidado: os Topógrafos Sanguinélficos são 51-52 e os Recuperadores 52-53, com {npc:6647} (53) entre eles: pegue o equipamento pela borda do acampamento e puxe os elfos um de cada vez.\nOs sátiros, ladinos e invocadores infernais de {npc:235903} (51-53) são os Legashi em volta do acampamento de {npc:8420}; os Rouba-almas, Infernizadores e Cavaleiros Negros Legashi (53) mais a leste não fazem parte: fique a oeste deles.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "{item:20028}, dos agrimensores e recuperadores elfos sangrentos",

	-- Step 75: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "Na estrada de volta ao sul, {npc:235903} cuida dos sátiros.",

	-- Step 76: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, cerca de 10%",

	-- Step 77: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "Cavalgue de volta para oeste até o acampamento de {npc:8395} e desmonte: ele teletransporta você de novo até Tauriel.",

	-- Step 79: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "{area:1223}",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "As Sirenas Iralisca vagam pelas ruínas e pela praia ao redor de {area:1223}, logo ao sul de {npc:8395}. Só as Sirenas carregam o coral, não os Urradores.",

	-- Step 80: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Back north to {npc:8395}'s camp at the foot of the cliff and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 81: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "De volta ao alto pelo teletransporte de {npc:8395}.",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "A última tarefa de Tauriel, A destruição de Morphaz, fica em {area:1417}: pule-a.",

	-- Step 83: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "Nade até a pequena ilha na ponta sul de {zone:1447}. Se {npc:8392} não estiver lá, dispare sua {item:10444} para sinalizar a ele e espere que ele pouse.",
	-- {zone:1455} Ironforge · {zone:1422} Western Plaguelands
	["Tymor in {zone:1455}, on the {zone:1422} guide's {zone:1455} stop: keep it"] = "",

	-- Step 84: Talrendis Point
	-- {area:3137} Talrendis Point · {zone:1448} Felwood
	["Back to Truesong at {area:3137}: {zone:1448}, the next guide, is a short ride west."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Truesong at {area:3137} before you hearth."] = "De volta a Truesong em {area:3137} antes de usar a Pedra de Regresso.",
	-- ["Back to {npc:3546} in {area:1438} before you hearth."] = "De volta a {npc:3546} em {area:1438} antes de usar a Pedra de Regresso.",
	-- ["Back to {zone:1438}"] = "De volta a {zone:1438}",
	-- ["Bloodmages' camp"] = "Acampamento dos magos de sangue",
	-- ["Class trainer"] = "Instrutor de classe",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Suba de volta até {npc:8405} em {area:1224}, acima das ruínas.",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Suba até o topo de {area:249} e finque a cabeça no monte de terra fofa.",
	-- ["Druid training"] = "Treinamento de druida",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Voe de {zone:1455} para {area:150} e pegue o barco para {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Voe de {zone:1455} para {area:69}.",
	-- ["Fly to {area:1438}."] = "Voe para {area:1438}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Voe para {area:150} e pegue o barco para {area:442} e depois o barco até {area:702}.",
	-- ["Fly to {area:702}"] = "Voe para {area:702}",
	-- ["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "Para {npc:5594} em {area:976}, no guia de {zone:1422}: guarde",
	-- ["For {zone:1453}: keep it"] = "Para {zone:1453}: guarde",
	-- ["From the {area:442} dock, fly to {area:415}."] = "Do cais de {area:442}, voe para {area:415}.",
	-- ["Help her escape the camp"] = "Ajude-a a fugir do acampamento",
	-- ["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "Se você pulou {quest:4022}, mate monstros aqui até o nível 52.08 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- ["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32): take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha espera em {area:2517}, o morro a sudoeste da fortaleza. Os monstros de {zone:1419} no caminho deixam cair os Fragmentos Imperfeitos de Draenetista; leve o que tiver.\nCuidado: Vilcular, {npc:7664} e Ilifar são todos elite de nível 60. Razelikh usa {spell:2691}, {spell:8255} e Dizimar e, conforme a vida cai, acrescenta {object:141891}, {spell:10854} e por fim Enfurecer com 15%.\nCuidado: {npc:247015}, um elite de nível 55, fica junto ao morro de Kum'isha (por volta de 50,35) e a oeste (por volta de 39,32): pegue os fragmentos dos monstros no caminho desde a fortaleza, não ao lado dele.",
	-- ["Level 51.3 on the way north"] = "Nível 51.3 a caminho do norte",
	-- ["Level 52"] = "Nível 52",
	-- ["Level 52 at {area:249}"] = "Nível 52 em {area:249}",
	-- ["Level 52.08"] = "Nível 52.08",
	-- ["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "Abra o {item:10569} de {zone:1427} para pegar o {item:10575} e depois diga a {npc:9459} que você traz a prova dos seus feitos: não há draco para enfrentar.",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Opcional: {npc:8395} quer duas Penas Intactas de Hipogrifo dos hipogrifos ao redor do acampamento dele. Os dados não indicam experiência para ela.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Opcional: o fantasma de {npc:8888} fica sobre o túmulo dele, na grande corrente dentro de {area:254}, e só os mortos podem vê-lo. Se você morrer perto da montanha de qualquer forma, corra com seu espírito até ele antes de ressuscitar.",
	-- ["Portal to {zone:1438}"] = "Portal para {zone:1438}",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "Sacerdotes e Magos treinaram aqui no fim do guia de Un'Goro",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Leia a tábua no acampamento {object:147516} entre as ruínas, a sudoeste de {area:251}, para copiar a transcrição.",
	-- ["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Cavalgue de volta para o sul até {zone:1419} atrás das feras dos magos de sangue: Rasgarrindos Famintos vagam pelas colinas secas ao sul do acampamento dos magos de sangue, Aguilhantes Escorpóde correm pelo meio do norte e abutres {npc:5982} sobrevoam tudo. Javalis Jubacinza e Basiliscos Itarrubra dividem as encostas a sudoeste da fortaleza.\nCuidado: dois elites vagam por aqui: {npc:221740} (50) no meio da zona, por volta de 44,34, e {npc:247015} (55) na crista, por volta de 39,32. Quando vir um, cace em outro lugar.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Volte para {area:1438} e voe para {area:348}. As Penas de Coruscante ficam no chão por {zone:1425}, ao sul e a leste de {area:348}, onde as ferujas vagueiam; os monstros daqui agora são de nível bem abaixo do seu.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Siga para o leste pela estrada, saindo de {zone:1440} e entrando em {zone:1447}, até o acampamento das Sentinelas em {area:3137}.",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "Siga para o norte saindo de {zone:1419} e entrando em {zone:1435}: o {npc:10996} fica junto à estrada que vem de {zone:1419}. Mantenha distância de {area:75}, a cidade da Horda a nordeste. Ouça a história dele e depois volte para o sul até Kum'isha.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Siga para o norte saindo de {area:69}, pelo desfiladeiro, até {zone:1428}; {area:2418} fica no alto, no sudeste da região.",
	-- ["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "Cavalgue para o norte até o acampamento dos magos de sangue junto à estrada para {zone:1419}.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Esfoladores Descarnados e Carniçais Salivantes andam pelos campos ao norte do acampamento; todo o Flagelo daqui deixa cair Pedras do Flagelo.\nCuidado: esses mortos-vivos percebem você de longe, e outros por perto entram na briga quando um é puxado.\nCuidado: o {npc:10411} (3 no mapa, renascem em 15 min) fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Nade até a pequena ilha na ponta sul de {area:16}: {npc:8392} espera junto ao monumento.",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nade até a pequena ilha na ponta sul de {zone:1447}: {npc:8392} espera junto ao monumento.",
	-- ["Thaurissan Relics"] = "Relíquias Thaurissanas",
	-- ["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "Os ogros Pirobucho ocupam a grande rocha ao norte da Vigia de Morgan, com os Brutamontes no lado leste.\nCuidado: Cães-magma Fugitivos (nível 60) vagam pelas Estepes, alguns nas encostas a oeste e ao sul de {area:249}: puxe os ogros na própria rocha e olhe em volta antes de cada puxada.",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Os fantasmas Altaneiros assombram as ruínas ao redor do santuário; os sátiros Haldarr ocupam o acampamento logo ao norte dele.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Os nagas Iralisca de {area:1221} carregam {item:13815}. As quatro runas de {npc:8507} ficam entre as ruínas: use o {item:10445} dele em cada uma.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "Os nagas Iralisca de {area:1221} carregam {item:13815}. As runas de {npc:8507} ficam entre as ruínas: use o {item:10445} dele em cada uma. Os nagas daqui são os que o complemento abaixo pede, então essas mortes contam para ele.",
	-- ["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Os nagas Iralisca destas ruínas deixam cair Relíquias de Eldarath de Truesong, com complemento ou não. {npc:239939} (52) fica nas ruínas de Eldarath, a sudoeste dos Mirmidões: puxe-o sozinho.",
	-- ["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "As Penas de Coruscante estão no chão por {zone:1425}, ao sul e a leste de {area:348}, onde as ferujas andam; os monstros daqui agora estão bem abaixo de você.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Os Ginetes Cascomusgo mais próximos pastam nas colinas a nordeste de {area:1224}, em direção a {area:1219}; um rebanho maior vagueia pelo campo aberto ao sul.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Os Ginetes Cascomusgo mais próximos pastam nas colinas a nordeste de {area:1224}, em direção a {area:1219}; um rebanho maior vagueia pelo campo aberto ao sul.\nCuidado: os Ginetes Cascomusgo são 52-53, um ou dois níveis acima de você aqui: puxe um de cada vez pela borda do rebanho.",
	-- ["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "O portal em {area:702} leva para cima até {zone:1457}: {npc:9047} espera em {area:1658}, no norte da cidade.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "As relíquias são as pedras entalhadas espalhadas por {area:250} ao redor de {area:251}: clique nelas até recuperar as informações.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "As relíquias são as pedras esculpidas espalhadas por {area:250}, em volta de {area:251}: clique nelas até recuperar a informação.\nLeia a tábua no acampamento de {object:147516} entre as ruínas, a sudoeste de {area:251}, para copiar a transcrição.\nUse {item:12284} em um {npc:7047} nas encostas a leste de {area:251}, logo antes de ele morrer, e depois saqueie a essência que ele deixa.\nCuidado: um {npc:8981} (nível 56, raro) anda pelas encostas perto das crias, e os {npc:7040} e Dracônidas em volta delas são elite: use o Incarcinatrix numa cria da borda e olhe em volta antes de cada puxada.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "O santuário fica no canto sudoeste de {area:16}, ao sul de {area:3137}.",
	-- ["The wildkin are in {zone:1452}: keep it"] = "Os coruscantes estão em {zone:1452}: guarde-a",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:7977} (elite nível 48) pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:7977} (elite nível 48) pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.\n{npc:7977} anda pela costa de {zone:1425} abaixo de {area:307}, da seta para o sul até cerca de 75,66 e para o norte até cerca de 82,52: se ela não estiver na seta, siga a costa.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:9461} é elite de nível 54: a maioria das classes encara sozinha no nível 56, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",
	-- ["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "Antes, complete até o nível 52 nos Ogros Pirobucho (50-51) do lado mais próximo de {area:249}, ao norte da Vigia: os Brutamontes no lado leste são 52-53. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- ["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon instead."] = "Complete aqui até o nível 52 nos ogros de {area:249}, no caminho para {area:251}: as entregas de lá levam você ao nível 53. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- ["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "Complete até o nível 51.3 nos Mirmidões Iralisca (50-51) das ruínas entre o acampamento de {npc:8395} e o norte: os elfos sangrentos no acampamento de {npc:8420} são 51-53. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- ["Upstairs"] = "No andar de cima",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Use o {item:12284} em um {npc:7047} nas encostas a leste de {area:251} pouco antes de ele morrer e depois saqueie a essência que ele deixa.",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Use {item:12284} em um {npc:7047} nas encostas a leste de {area:251}, logo antes de ele morrer, e depois saqueie a essência que ele deixa.\nCuidado: um {npc:8981} (nível 56, raro) anda pelas encostas perto das crias, e os {npc:7040} e Dracônidas em volta delas são elite: use o Incarcinatrix numa cria da borda e olhe em volta antes de cada puxada.",
	-- ["Wildkin feathers"] = "Penas de Coruscante",
	-- ["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Sua Pedra de Regresso está vinculada a {zone:1455} (o guia de {zone:1425} a vincula lá): use-a para voltar à estalagem.",
	-- ["grind on {npc:6196}"] = "mate {npc:6196} até subir",
	-- ["grind on {npc:6375}"] = "mate {npc:6375} até subir",
	-- ["grind on {npc:7033}"] = "mate {npc:7033} até subir",
	-- ["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "mate {npc:7033}: {npc:9177} dá {quest:4283} a partir do nível 51",
	-- ["grind on {npc:7034}"] = "mate {npc:7034} até subir",
	-- ["grind on {npc:9690}"] = "mate {npc:9690} até subir",
	-- ["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "guarde-a: o caldeirão de {area:199} espera a parada em Chillwind do guia de {zone:1452}, por volta do 55",
	-- ["{area:199} cauldron"] = "Caldeirão de {area:199}",
	-- ["{item:11467}; inside"] = "{item:11467}; lá dentro",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "O fantasma de {npc:10778} vaga junto à casa da fazenda de {area:199}, a oeste de {area:200}; o embrulho dela está lá dentro.",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} guarda o caldeirão em {area:199}, a oeste de Andorhal.",
	-- ["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}: {quest:88809}, as relíquias caem das nagas do reforço de nível mais adiante",
	-- ["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}: {quest:92345}, para {npc:4217} em {zone:1457}, guarde",
	-- ["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217} fica no andar de cima do prédio dos druidas em {area:1658}: entre pela porta sul.",
	-- ["{npc:4217}, upstairs"] = "{npc:4217}, no andar de cima",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}, espera em {area:2517}, a colina a sudoeste da fortaleza. Os monstros de {zone:1419} no caminho deixam cair os Fragmentos Imperfeitos de Draenetista; leve a ele o que você tiver.",
	-- ["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740} fica ao lado de Tyrande no Templo da Lua, no sul da cidade.",
	-- ["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, vinda de {area:976}",
	-- ["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} fica no andar de cima, acima de {npc:7916}: suba por dentro, a seta não diferencia os andares.",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395} quer duas Penas Intactas de Hipogrifo dos hipogrifos Cabeça-de-trovão ao redor do acampamento dele, os mesmos em que você completa o nível aqui: cerca de um em cada três carrega uma.",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} acampa em {area:1219}, no norte; o equipamento dele está espalhado por {area:1220}, logo a sudeste dele.",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}, em {area:1658}",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} e os orcs Rocha Negra ocupam os acampamentos e a fortaleza ao pé de {area:254}, a oeste de {area:251}. Puxe-os um de cada vez; todo orc e worg pode deixar cair um medalhão, então mate-os até ter cinquenta.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176} e os orcs Rocha Negra ocupam os acampamentos e a fortaleza no pé de {area:254}, a oeste de {area:251}. Puxe um de cada vez; todo orc e todo worg pode deixar cair um medalhão, então mate até ter cinquenta.\nCuidado: {npc:9176} tem um guarda ligado a ele que entra na briga, e um segundo soldado patrulha ali perto; limpe a patrulha antes de puxar.\nCuidado: Juramentados do Fogo, elementais de fogo de nível 60, vagam pelas Estepes, alguns entre os acampamentos Rocha Negra: olhe antes de cada puxada e deixe-os passar.",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: os orcs Rocha Negra deixam cair os medalhões, mantenha-a aberta por toda a região",
	-- ["{object:175894}, inside"] = "{object:175894}, lá dentro",
	-- ["{zone:1455} has no druid trainer"] = "{zone:1455} não tem instrutor de druida",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} não tem instrutor de druida: pegue o portal para subir até {zone:1457} e treine em {area:1658}, depois desça de volta até {area:702}.",
}
