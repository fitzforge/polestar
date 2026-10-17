-- Portuguese (Brazil) (ptBR): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kadrak
	-- {area:380} Crossroads · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale · {item:16783} Bundle of Reports
	["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "De {area:380}, siga a estrada para o norte. {npc:8582} fica na torre de vigia de {area:1703}, onde a estrada entra em {zone:1440}. Abra o {item:16783} que ele lhe der.",

	-- Step 2: Warsong Scout
	-- {npc:12862} Warsong Scout
	["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Continue para o norte pela estrada. O {npc:12862} espera no acampamento madeireiro do Brado Guerreiro, ao sul de Machadada.",

	-- Step 3: Splintertree Post
	-- {area:431} Splintertree Post
	["{area:431} is just north up the road."] = "{area:431} fica logo ao norte, subindo a estrada.",

	-- Step 4: Night Run
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run
	["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} fica em {area:428}, o acampamento do Brado Guerreiro logo a nordeste de Machadada, ao lado do quadro de caçadas.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "Os alvos de caça de {npc:12696} (Ursangous, Shadumbra, Garraguda) são para a próxima visita a {zone:1440}, no nível 27.",

	-- Step 5: Warsong Outrider
	-- {npc:12864} Warsong Outrider · {area:428} Night Run · {area:430} Satyrnaar
	["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "O {npc:12864} patrulha a estrada a leste de {area:428} rumo a {area:430}.",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "No caminho para oeste, {npc:267214} está preso numa ravina ao sul da estrada principal, a sudeste de {area:415}. Cervos Galhassombra e Ursos do Vale Gris vagam pela mata em volta.",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Conduza o {npc:271181} de {npc:267214} para fora da ravina até a estrada principal em até quatro minutos; se a canalização quebrar, peça a {npc:267214} de novo.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, na estrada",

	-- Step 8: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand
	["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Cavalgue para oeste pela estrada principal através de {zone:1440}, passando por {area:415} (Aliança: fique na estrada), até o litoral. {area:2897} fica em {area:414}, no noroeste. As outras missões de lá são para a próxima visita, no nível 27.",

	-- Step 9: Naga heads
	["Naga heads"] = "Cabeças de naga",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Toda naga Iracauda ao longo da praia ao norte do posto deixa cair cabeças.",

	-- Step 11: Back to Kadrak
	-- {npc:8582} Kadrak
	["Back to {npc:8582}"] = "De volta a {npc:8582}",
	-- {area:431} Splintertree Post · {area:1703} Mor'shan Rampart
	["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Voe até {area:431} e cavalgue para o sul pela estrada até {area:1703}.",

	-- Step 12: Malaka'jin
	-- {area:380} Crossroads · {zone:1413} Barrens · {area:2539} Malaka'jin
	["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Cavalgue para o sul até {area:380} e depois para oeste pela estrada, saindo de {zone:1413} rumo às Torres de Pedra. A aldeia troll de {area:2539} fica na entrada do cânion.",

	-- Step 13: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "A estrada sobe para o norte como {area:1076}. {quest:1483} tem uma cabana onde a estrada se divide para leste rumo a {area:461}.",

	-- Step 14: Windshear Crag
	-- {area:461} Windshear Crag · {npc:4276} Piznik
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "A leste de Zé, a Empreendimentos S.A. está desmatando {area:461}; um dos Operadores leva as plantas. {npc:4276} minera na pequena mina do lado leste: fique com ele enquanto minera, capangas da Empreendimentos S.A. vêm atrás dele.",

	-- Step 15: Ziz Fizziks
	-- {area:392} Ratchet
	["Sputtervalve in {area:392}: the next guide passes there"] = "Cobogó em {area:392}: o próximo guia passa por lá",

	-- Step 16: Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Follow the road west to {area:460}."] = "Siga a estrada para oeste até {area:460}.",
	-- {npc:11860} Maggran Earthbinder · {area:1718} Great Lift
	["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}: Grish está no {area:1718}, no próximo guia",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Pedras Solares Lampejantes das harpias Furissangue",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, do lado de fora do portão",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} em Zoram'gar, no nível 27",

	-- Step 17: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Sementes de Gaia",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "As Sementes de Gaia ficam na grama em volta da margem sul de {area:464}, ao norte de Rocha do Sol.",

	-- Step 18: Stonetalon Peak
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Siga a estrada para o norte rumo a {area:467}. Ginetes Galhados pastam pelo caminho; as Feras de Seiva, os Corredores do Crepúsculo e os Dragões Encantados vagam pela mata abaixo do pico, e os druidas cenarianos ocupam o bosque de lá.",

	-- Step 19: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "A próxima missão de {npc:4198}, Ornanos, fica no lado da Aliança de {zone:1440}. Pule-a.",

	-- Step 20: The Charred Vale
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "A sudoeste da Rocha do Sol fica o {area:465}, queimado. Plante as Sementes de Gaia nos montes de terra no fundo do vale; os elementais de fogo deixam cair {item:16312}. Harpias e Emboscadoras Furissangue fazem ninho no lado norte, Matadoras e Plumerrantes ao sul.",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Montes de Terra de Gaia",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, de qualquer harpia Furissangue",

	-- Step 21: Sun Rock Retreat
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, lá em cima na saliência",
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, ao lado de {npc:11862}",

	-- Step 22: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Ride back down the {area:1076} to {area:2539}."] = "Desça de volta por {area:1076} até {area:2539}.",

	-- Step 23: To the Undercity
	-- {area:1497} Undercity
	["To the {area:1497}"] = "Para {area:1497}",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:1497} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter (no name in this language: may be words)
	["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Cavalgue para leste até {area:380} e voe para {zone:1454}. Pegue o zepelim nas torres do lado de fora de {zone:1454} até {zone:1420}; {area:1497} fica abaixo de {area:153}. O mestre dos morcegos fica no {object:36078}.",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter (no name in this language: may be words) · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Fale com {npc:10181}, no {object:36126}: {quest:93739}",

	-- Step 24: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter (no name in this language: may be words)
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606} fica no {object:36070}.",

	-- Step 25: Beren's Peril
	-- {area:272} Tarren Mill · {zone:1458} Undercity · {area:228} Sepulcher · {area:231} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone (no name in this language: may be words)
	["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Se você já conhece a rota de voo de {area:272}, voe para lá e pule para {area:272}. Senão, voe de {zone:1458} para {area:228} e cavalgue para o sul pela estrada, passando por Lenhardente. Os mortos-vivos Corvinalle assombram as ruínas de {area:231}, a leste da estrada, no sudeste da floresta; um {npc:1973} deixa cair o {item:271343} que leva ao {object:645153}.",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, de um {npc:1973}",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}, das Almas Torturadas entre as ruínas",

	-- Step 26: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone (no name in this language: may be words) · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Use o {npc:212753} no {object:645153} para um sacrifício voluntário e mate o {npc:212753} que responder. {quest:95883} é elite: recomenda-se formar grupo.",

	-- Step 27: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "De volta à estrada para o sul. Onde ela vira para leste rumo a {area:287}, {npc:2214} espera em {area:285}.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Darthalia em {area:272}",

	-- Step 28: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Siga a estrada para leste ao longo do rio e depois para nordeste, subindo as colinas até {area:272}.",
}
