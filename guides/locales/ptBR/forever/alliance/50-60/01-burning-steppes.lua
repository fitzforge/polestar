-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "Rumo a {zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "De {area:415}, siga para o leste pela estrada, passando por {area:2358}, até {zone:1447}: {area:1235} fica logo depois da fronteira, no canto sudoeste de {zone:1447}.",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "Para o leste pela estrada até {area:1235}",

	-- Step 2: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "O santuário fica no canto sudoeste de {zone:1447}, ao sul de {area:3137}.",

	-- Step 3: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "Logo a nordeste do santuário: {npc:239822} e {npc:240482} cuidam do acampamento da Aliança em {area:3137}.",

	-- Step 4: Shadowsong Shrine spirits
	-- {area:1235} Shadowsong Shrine
	["{area:1235} spirits"] = "",
	-- {area:3137} Talrendis Point · {area:1235} Shadowsong Shrine
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Ride south-west from {area:3137}. Kill the Highborne Apparitions and Lichlings in the ruins around {area:1235}."] = "",

	-- Step 5: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "Corredores Cascomusgo",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "Os Corredores Cascomusgo (45-47) pastam nas colinas ao norte de {area:3137}, a caminho dos sátiros.",

	-- Step 6: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447}: vá matando estes pelo caminho",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Haldarr satyrs hold the camp north of the shrine. {npc:222478} is held in their camp: free her and walk her out."] = "",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}, no acampamento",
	["Help her escape the camp"] = "Ajude-a a fugir do acampamento",

	-- Step 7: The western shore
	["The western shore"] = "A costa oeste",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "Os Guerreiros Iralisca (46-47) e os Gritadores (47-48) ocupam a costa oeste, a nordeste dos sátiros.",

	-- Step 8: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "De volta para o sudoeste, até {area:3137}.",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}: {quest:88809}, as relíquias caem das nagas do reforço de nível mais adiante",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}: {quest:92345}, para {npc:4217} em {zone:1457}, guarde",

	-- Step 12: Wild honey
	["Wild honey"] = "",
	-- {npc:240482} Berdun Cliffbrew · {item:238501} Pellet Gun · {item:238503} Wild Honey · {area:1237} Valormok
	-- plural, as words: Honey Wasps = {npc:236028} Honey Wasp
	["Shoot a nest with {npc:240482}'s {item:238501}, then loot the Honey Wasps for {item:238503}. Work north through the trees toward Eldarath, away from {area:1237}."] = "",

	-- Step 14: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Siga para o nordeste a partir do santuário: {npc:8405} acampa em {area:1224}, nas colinas acima da estrada.",

	-- Step 15: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "Desmonte antes de falar com {npc:8395}: ele teletransporta você até a torre de {npc:8379}, no penhasco acima do acampamento dele.",

	-- Step 16: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "O aprendiz no alto da torre manda você de volta para baixo.",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "Os elfos sangrentos estão em {area:1220}, no caminho para {npc:8420}",

	-- Step 17: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "Os nagas Iralisca de {area:1221} carregam {item:13815}. As runas de {npc:8507} ficam entre as ruínas: use o {item:10445} dele em cada uma. Os nagas daqui são os que o complemento abaixo pede, então essas mortes contam para ele.",

	-- Step 18: Level 51.3 on the way north
	["Level 51.3 on the way north"] = "Nível 51.3 a caminho do norte",
	-- {npc:8395} Sanath Lim-yo · {npc:8420} Kim'jael · {area:1417} Sunken Temple
	-- plural, as words: Spitelash Myrmidons = {npc:6196} Spitelash Myrmidon
	["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "Complete até o nível 51.3 nos Mirmidões Iralisca (50-51) das ruínas entre o acampamento de {npc:8395} e o norte: os elfos sangrentos no acampamento de {npc:8420} são 51-53. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "mate {npc:6196} até subir",

	-- Step 19: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Os nagas Iralisca destas ruínas deixam cair Relíquias de Eldarath de Truesong, com complemento ou não. {npc:239939} (52) fica nas ruínas de Eldarath, a sudoeste dos Mirmidões: puxe-o sozinho.",

	-- Step 20: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903} acampa junto à estrada para o norte, rumo a {npc:8420}: os sátiros dele estão no acampamento de {npc:8420}.",

	-- Step 21: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Ginetes Cascomusgo",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Os Ginetes Cascomusgo mais próximos pastam nas colinas a nordeste de {area:1224}, em direção a {area:1219}; um rebanho maior vagueia pelo campo aberto ao sul.\nCuidado: os Ginetes Cascomusgo são 52-53, um ou dois níveis acima de você aqui: puxe um de cada vez pela borda do rebanho.",

	-- Step 24: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420} acampa em {area:1219}, no norte; o equipamento dele está espalhado por {area:1220}, logo a sudeste dele.\nCuidado: os Topógrafos Sanguinélficos são 51-52 e os Recuperadores 52-53, com {npc:6647} (53) entre eles: pegue o equipamento pela borda do acampamento e puxe os elfos um de cada vez.\nOs sátiros, ladinos e invocadores infernais de {npc:235903} (51-53) são os Legashi em volta do acampamento de {npc:8420}; os Rouba-almas, Infernizadores e Cavaleiros Negros Legashi (53) mais a leste não fazem parte: fique a oeste deles.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "{item:20028}, dos agrimensores e recuperadores elfos sangrentos",

	-- Step 27: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "Na estrada de volta ao sul, {npc:235903} cuida dos sátiros.",

	-- Step 28: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, cerca de 10%",

	-- Step 29: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "Cavalgue de volta para oeste até o acampamento de {npc:8395} e desmonte: ele teletransporta você de novo até Tauriel.",

	-- Step 31: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "{area:1223}",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "As Sirenas Iralisca vagam pelas ruínas e pela praia ao redor de {area:1223}, logo ao sul de {npc:8395}. Só as Sirenas carregam o coral, não os Urradores.",

	-- Step 32: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "De volta ao alto pelo teletransporte de {npc:8395}.",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "A última tarefa de Tauriel, A destruição de Morphaz, fica em {area:1417}: pule-a.",

	-- Step 34: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "Nade até a pequena ilha na ponta sul de {zone:1447}. Se {npc:8392} não estiver lá, dispare sua {item:10444} para sinalizar a ele e espere que ele pouse.",

	-- Step 35: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back to Truesong at {area:3137} before you hearth."] = "De volta a Truesong em {area:3137} antes de usar a Pedra de Regresso.",

	-- Step 37: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Para {zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Sua Pedra de Regresso está vinculada a {zone:1455} (o guia de {zone:1425} a vincula lá): use-a para voltar à estalagem.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Estalagem de {zone:1455}",

	-- Step 39: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Arquefilis fica ao lado do Rei Magni, em {object:171709}.",

	-- Step 40: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:3701} é uma missão de grupo neste nível: as relíquias ficam entre Aniquiladores de Guerra e Andachamas de 53-55, com {npc:8978} (57) por perto, de dois a cinco níveis acima de você, e a rota não volta a {zone:1428} depois. Vale a pena formar grupo, procure gente para ir junto. Se estiver sozinho, pule.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "As relíquias estão em {zone:1428}: guarde",

	-- Step 41: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Voe para {area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 42: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",

	-- Step 43: The Super Snapper FX
	-- {npc:7977} Gammerita · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:7977} (elite nível 48) pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.\n{npc:7977} anda pela costa de {zone:1425} abaixo de {area:307}, da seta para o sul até cerca de 75,66 e para o norte até cerca de 82,52: se ela não estiver na seta, siga a costa.",

	-- Step 44: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Mestre de voo de {area:348}",

	-- Step 45: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "Siga para o norte saindo de {area:271}, entre em Alterac e vá para oeste até as muralhas de {area:279}: {npc:34365} fica do lado de fora. A missão dela vai para {npc:266524} em {area:1438}, para onde este guia voa depois.",

	-- Step 46: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "Siga para o norte, de {area:271}, pela estrada por Alterac até {area:3197}.",

	-- Step 47: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "{npc:10838} fica no meio do acampamento.",

	-- Step 48: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: vá matando estes pelo caminho",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Esfoladores Descarnados e Carniçais Salivantes andam pelos campos ao norte do acampamento; todo o Flagelo daqui deixa cair Pedras do Flagelo.\nCuidado: esses mortos-vivos percebem você de longe, e outros por perto entram na briga quando um é puxado.\nCuidado: o {npc:10411} (3 no mapa, renascem em 15 min) fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa.",

	-- Step 49: Chillwind Camp
	["Ride back south to the camp."] = "Cavalgue de volta para o sul até o acampamento.",
	-- {area:199} Felstone Field · {zone:1452} Winterspring
	["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "guarde-a: o caldeirão de {area:199} espera a parada em Chillwind do guia de {zone:1452}, por volta do 55",

	-- Step 50: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "Voe para {area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Mestre de voo de {area:3197}",

	-- Step 51: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Voe para {area:69}",

	-- Step 52: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Mestre de voo de {area:2418}",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "Cavalgue para leste, saindo de {area:69}, e suba a passagem até {zone:1428}: {area:2418} fica no alto.",

	-- Step 53: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418} fica no sudeste das Estepes, no alto da passagem que sobe de Cristarrubra.",

	-- Step 54: Level 52 at Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Level 52 at {area:249}"] = "Nível 52 em {area:249}",
	-- {area:249} Dreadmaul Rock · {area:1417} Sunken Temple
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre
	["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "Antes, complete até o nível 52 nos Ogros Pirobucho (50-51) do lado mais próximo de {area:249}, ao norte da Vigia: os Brutamontes no lado leste são 52-53. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- {npc:7033} Firegut Ogre
	["grind on {npc:7033}"] = "mate {npc:7033} até subir",

	-- Step 55: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	-- plural, as words: Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "Os ogros Pirobucho ocupam a grande rocha ao norte da Vigia de Morgan, com os Brutamontes no lado leste.\nCuidado: Cães-magma Fugitivos (nível 60) vagam pelas Estepes, alguns nas encostas a oeste e ao sul de {area:249}: puxe os ogros na própria rocha e olhe em volta antes de cada puxada.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}, no subterrâneo",

	-- Step 56: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "As próximas tarefas de {npc:9177} ({npc:9176} e cinquenta Medalhões Rocha Negra) mandam você para o meio dos orcs Rocha Negra de 55-58 ao pé de {area:254}: pule-as.",

	-- Step 57: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Siga a estrada para o oeste e depois suba para o norte até o acampamento goblin em {area:251}.",

	-- Step 58: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: vá matando estes pelo caminho",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Use {item:12284} em um {npc:7047} nas encostas a leste de {area:251}, logo antes de ele morrer, e depois saqueie a essência que ele deixa.\nCuidado: um {npc:8981} (nível 56, raro) anda pelas encostas perto das crias, e os {npc:7040} e Dracônidas em volta delas são elite: use o Incarcinatrix numa cria da borda e olhe em volta antes de cada puxada.",

	-- Step 59: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron (no name in this language: may be words)
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "As relíquias são as pedras esculpidas espalhadas por {area:250}, em volta de {area:251}: clique nelas até recuperar a informação. Pegue as da borda sul das ruínas, mais perto de {area:251}.\nCuidado: os Aniquiladores de Guerra e Andachamas de Thaurissan das ruínas são 53-55, e {npc:8978} (57) ocupa o acampamento de {object:147516} a sudoeste de {area:251}: pegue as relíquias na borda das ruínas, puxe um de cada vez e fique longe do acampamento.",

	-- Step 60: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Termina com {quest:4808} em {area:2255}, {zone:1452}: guarde-a",

	-- Step 61: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "Abra o {item:10569} de {zone:1427} para pegar o {item:10575} e depois diga a {npc:9459} que você traz a prova dos seus feitos: não há draco para enfrentar.",
	["Below ground"] = "No subterrâneo",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, do tesouro",

	-- Step 63: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:9461} é elite de nível 54: a maioria das classes encara sozinha no nível 56, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 65: Level 52.08
	["Level 52.08"] = "Nível 52.08",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "Se você pulou {quest:4022}, mate monstros aqui até o nível 52.08 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "mate {npc:9690} até subir",

	-- Step 66: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Volte para o leste pela estrada até a Vigia de Morgan.",

	-- Step 67: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Voe para {area:1438}",

	-- Step 68: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "Ardalan fica dentro de {area:1438}.",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}: {quest:87295}, as escamas vêm dos basiliscos mais adiante",

	-- Step 69: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "Siga para o norte saindo de {zone:1419} e entrando em {zone:1435}: o {npc:10996} fica junto à estrada que vem de {zone:1419}. Mantenha distância de {area:75}, a cidade da Horda a nordeste.",

	-- Step 70: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "Ouça a história dele e depois volte para o sul até Kum'isha.",

	-- Step 71: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "De volta a {zone:1419}",
	["Bloodmages' camp"] = "Acampamento dos magos de sangue",

	-- Step 72: The bloodmages
	["The bloodmages"] = "Os magos de sangue",
	["Drazial and Lynnore stand together by the road. Take any beast requests they still offer before riding south."] = "",

	-- Step 73: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}: vá matando estes pelo caminho",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Cavalgue de volta para o sul até {zone:1419} atrás das feras dos magos de sangue: Rasgarrindos Famintos vagam pelas colinas secas ao sul do acampamento dos magos de sangue, Aguilhantes Escorpóde correm pelo meio do norte e abutres {npc:5982} sobrevoam tudo. Javalis Jubacinza e Basiliscos Itarrubra dividem as encostas a sudoeste da fortaleza.\nCuidado: dois elites vagam por aqui: {npc:221740} (50) no meio da zona, por volta de 44,34, e {npc:247015} (55) na crista, por volta de 39,32. Quando vir um, cace em outro lugar.",

	-- Step 75: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha espera em {area:2517}, o morro a sudoeste da fortaleza. Os monstros de {zone:1419} no caminho deixam cair os Fragmentos Imperfeitos de Draenetista; leve o que tiver. Chegue ao morro dela direto da fortaleza, pela estrada, e saia pelo mesmo caminho.\nCuidado: Vilcular, {npc:7664} e Ilifar são todos elite de nível 60. Razelikh usa {spell:2691}, {spell:8255} e Dizimar e, conforme a vida cai, acrescenta {object:141891}, {spell:10854} e por fim Enfurecer com 15%.\nCuidado: {npc:247015}, um elite de nível 55, fica junto ao morro de Kum'isha (por volta de 50,35) e a oeste (por volta de 39,32), e os acampamentos Malho Medonho e Jurassombra ao redor são de nível 53-55: pegue os fragmentos dos monstros no caminho desde a fortaleza, não ao lado dele.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363} anda por aqui: procure dentro do círculo no mapa",

	-- Step 76: The bloodmages
	-- {zone:1419} Blasted Lands
	["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "Cavalgue para o norte até o acampamento dos magos de sangue junto à estrada para {zone:1419}.",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "A segunda etapa dos Magos Sangrentos paga pelas mesmas partes com um item de bônus e sem experiência: pule.",

	-- Step 77: Bernie Heisten
	-- {npc:3546} Bernie Heisten · {area:1438} Nethergarde Keep
	["Back to {npc:3546} in {area:1438} before you hearth."] = "De volta a {npc:3546} em {area:1438} antes de usar a Pedra de Regresso.",

	-- Step 78: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "Use a Pedra de Regresso para voltar à estalagem de {zone:1455}.",

	-- Step 79: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Voe para {area:144}",

	-- Step 82: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Voe para {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Mestre de voo de {area:144}",

	-- Step 85: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "Arquefilis fica ao lado do Rei Magni, em {object:171709}: as relíquias que você leu nas Estepes são dele.",

	-- Step 86: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",

	-- Step 88: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Voe para {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Mestre de voo de {area:442}",

	-- Step 89: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Os coruscantes estão em {zone:1452}: guarde-a",

	-- Step 92: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "O portal em {area:702} leva para cima até {zone:1457}: {npc:9047} espera em {area:1658}, no norte da cidade.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, em {area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} não tem instrutor de druida",

	-- Step 93: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217} fica no andar de cima do prédio dos druidas em {area:1658}: entre pela porta sul.",
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, no andar de cima",

	-- Step 94: Astarii Starseeker
	-- {npc:7740} Gracina Spiritmight · {quest:3378} Prayer to Elune · {npc:4090} Astarii Starseeker
	["On the way to {npc:7740}, give the {quest:3378} to {npc:4090} in the Temple of the Moon."] = "",

	-- Step 95: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740} fica ao lado de Tyrande no Templo da Lua, no sul da cidade.",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, vinda de {area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1422} Western Plaguelands
	["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "Para {npc:5594} em {area:976}, no guia de {zone:1422}: guarde",

	-- Step 96: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal para {zone:1438}",

	-- Step 97: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} fica no andar de cima, acima de {npc:7916}: suba por dentro, a seta não diferencia os andares.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {zone:1438}"] = "De volta a {zone:1438}",
	-- ["Class trainer"] = "Instrutor de classe",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Suba de volta até {npc:8405} em {area:1224}, acima das ruínas.",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Suba até o topo de {area:249} e finque a cabeça no monte de terra fofa.",
	-- ["Druid training"] = "Treinamento de druida",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Voe de {zone:1455} para {area:150} e pegue o barco para {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Voe de {zone:1455} para {area:69}.",
	-- ["Fly to {area:1438}."] = "Voe para {area:1438}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Voe para {area:150} e pegue o barco para {area:442} e depois o barco até {area:702}.",
	-- ["For {zone:1453}: keep it"] = "Para {zone:1453}: guarde",
	-- ["From the {area:442} dock, fly to {area:415}."] = "Do cais de {area:442}, voe para {area:415}.",
	-- ["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32): take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha espera em {area:2517}, o morro a sudoeste da fortaleza. Os monstros de {zone:1419} no caminho deixam cair os Fragmentos Imperfeitos de Draenetista; leve o que tiver.\nCuidado: Vilcular, {npc:7664} e Ilifar são todos elite de nível 60. Razelikh usa {spell:2691}, {spell:8255} e Dizimar e, conforme a vida cai, acrescenta {object:141891}, {spell:10854} e por fim Enfurecer com 15%.\nCuidado: {npc:247015}, um elite de nível 55, fica junto ao morro de Kum'isha (por volta de 50,35) e a oeste (por volta de 39,32): pegue os fragmentos dos monstros no caminho desde a fortaleza, não ao lado dele.",
	-- ["Level 52"] = "Nível 52",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Opcional: {npc:8395} quer duas Penas Intactas de Hipogrifo dos hipogrifos ao redor do acampamento dele. Os dados não indicam experiência para ela.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Opcional: o fantasma de {npc:8888} fica sobre o túmulo dele, na grande corrente dentro de {area:254}, e só os mortos podem vê-lo. Se você morrer perto da montanha de qualquer forma, corra com seu espírito até ele antes de ressuscitar.",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "Sacerdotes e Magos treinaram aqui no fim do guia de Un'Goro",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Leia a tábua no acampamento {object:147516} entre as ruínas, a sudoeste de {area:251}, para copiar a transcrição.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Volte para {area:1438} e voe para {area:348}. As Penas de Coruscante ficam no chão por {zone:1425}, ao sul e a leste de {area:348}, onde as ferujas vagueiam; os monstros daqui agora são de nível bem abaixo do seu.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Siga para o leste pela estrada, saindo de {zone:1440} e entrando em {zone:1447}, até o acampamento das Sentinelas em {area:3137}.",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "Siga para o norte saindo de {zone:1419} e entrando em {zone:1435}: o {npc:10996} fica junto à estrada que vem de {zone:1419}. Mantenha distância de {area:75}, a cidade da Horda a nordeste. Ouça a história dele e depois volte para o sul até Kum'isha.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Siga para o norte saindo de {area:69}, pelo desfiladeiro, até {zone:1428}; {area:2418} fica no alto, no sudeste da região.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Nade até a pequena ilha na ponta sul de {area:16}: {npc:8392} espera junto ao monumento.",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nade até a pequena ilha na ponta sul de {zone:1447}: {npc:8392} espera junto ao monumento.",
	-- ["Thaurissan Relics"] = "Relíquias Thaurissanas",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Os fantasmas Altaneiros assombram as ruínas ao redor do santuário; os sátiros Haldarr ocupam o acampamento logo ao norte dele.",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "Os fantasmas Altaneiros assombram as ruínas ao redor do santuário; os sátiros Haldarr ocupam o acampamento logo ao norte dele. {npc:222478} está presa no acampamento dos sátiros: liberte-a e escolte-a para fora.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Os nagas Iralisca de {area:1221} carregam {item:13815}. As quatro runas de {npc:8507} ficam entre as ruínas: use o {item:10445} dele em cada uma.",
	-- ["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "As Penas de Coruscante estão no chão por {zone:1425}, ao sul e a leste de {area:348}, onde as ferujas andam; os monstros daqui agora estão bem abaixo de você.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Os Ginetes Cascomusgo mais próximos pastam nas colinas a nordeste de {area:1224}, em direção a {area:1219}; um rebanho maior vagueia pelo campo aberto ao sul.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "As relíquias são as pedras entalhadas espalhadas por {area:250} ao redor de {area:251}: clique nelas até recuperar as informações.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "As relíquias são as pedras esculpidas espalhadas por {area:250}, em volta de {area:251}: clique nelas até recuperar a informação.\nLeia a tábua no acampamento de {object:147516} entre as ruínas, a sudoeste de {area:251}, para copiar a transcrição.\nUse {item:12284} em um {npc:7047} nas encostas a leste de {area:251}, logo antes de ele morrer, e depois saqueie a essência que ele deixa.\nCuidado: um {npc:8981} (nível 56, raro) anda pelas encostas perto das crias, e os {npc:7040} e Dracônidas em volta delas são elite: use o Incarcinatrix numa cria da borda e olhe em volta antes de cada puxada.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "O santuário fica no canto sudoeste de {area:16}, ao sul de {area:3137}.",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:7977} (elite nível 48) pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",
	-- ["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon instead."] = "Complete aqui até o nível 52 nos ogros de {area:249}, no caminho para {area:251}: as entregas de lá levam você ao nível 53. Ou, com um grupo, faça a masmorra {area:1417}.",
	-- ["Upstairs"] = "No andar de cima",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Use o {item:12284} em um {npc:7047} nas encostas a leste de {area:251} pouco antes de ele morrer e depois saqueie a essência que ele deixa.",
	-- ["Wildkin feathers"] = "Penas de Coruscante",
	-- ["grind on {npc:6375}"] = "mate {npc:6375} até subir",
	-- ["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "mate {npc:7033}: {npc:9177} dá {quest:4283} a partir do nível 51",
	-- ["grind on {npc:7034}"] = "mate {npc:7034} até subir",
	-- ["{area:199} cauldron"] = "Caldeirão de {area:199}",
	-- ["{item:11467}; inside"] = "{item:11467}; lá dentro",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "O fantasma de {npc:10778} vaga junto à casa da fazenda de {area:199}, a oeste de {area:200}; o embrulho dela está lá dentro.",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} guarda o caldeirão em {area:199}, a oeste de Andorhal.",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}, espera em {area:2517}, a colina a sudoeste da fortaleza. Os monstros de {zone:1419} no caminho deixam cair os Fragmentos Imperfeitos de Draenetista; leve a ele o que você tiver.",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395} quer duas Penas Intactas de Hipogrifo dos hipogrifos Cabeça-de-trovão ao redor do acampamento dele, os mesmos em que você completa o nível aqui: cerca de um em cada três carrega uma.",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} acampa em {area:1219}, no norte; o equipamento dele está espalhado por {area:1220}, logo a sudeste dele.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} e os orcs Rocha Negra ocupam os acampamentos e a fortaleza ao pé de {area:254}, a oeste de {area:251}. Puxe-os um de cada vez; todo orc e worg pode deixar cair um medalhão, então mate-os até ter cinquenta.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176} e os orcs Rocha Negra ocupam os acampamentos e a fortaleza no pé de {area:254}, a oeste de {area:251}. Puxe um de cada vez; todo orc e todo worg pode deixar cair um medalhão, então mate até ter cinquenta.\nCuidado: {npc:9176} tem um guarda ligado a ele que entra na briga, e um segundo soldado patrulha ali perto; limpe a patrulha antes de puxar.\nCuidado: Juramentados do Fogo, elementais de fogo de nível 60, vagam pelas Estepes, alguns entre os acampamentos Rocha Negra: olhe antes de cada puxada e deixe-os passar.",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: os orcs Rocha Negra deixam cair os medalhões, mantenha-a aberta por toda a região",
	-- ["{object:175894}, inside"] = "{object:175894}, lá dentro",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} não tem instrutor de druida: pegue o portal para subir até {zone:1457} e treine em {area:1658}, depois desça de volta até {area:702}.",
}
