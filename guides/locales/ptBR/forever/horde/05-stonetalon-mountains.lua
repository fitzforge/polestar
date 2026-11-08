-- Portuguese (Brazil) (ptBR): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Taskmaster Fizzule
	-- {item:8051} Flare Gun
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the Sludge Fen. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads. {npc:8582} stands on the watch tower of the Mor'shan Rampart where the road enters {zone:1440}."] = "",

	-- Step 4: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} fica no acampamento de lenhadores. Os Vanguardeiros elfos noturnos rondam a mata a sudeste dele; eles ficam furtivos, então fique atento.",

	-- Step 5: Splintertree Post
	["Splintertree Post"] = "",
	-- {npc:12696} Senani Thunderheart
	["Splintertree Post is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at Night Run come first, then the vendors."] = "",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of Astranaar. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Conduza o {npc:271181} de {npc:267214} para fora da ravina até a estrada principal em até quatro minutos; se a canalização quebrar, peça a {npc:267214} de novo.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, na estrada",

	-- Step 8: Zoram'gar Outpost
	["Zoram'gar Outpost"] = "",
	-- {zone:1440} Ashenvale · {npc:12719} Marukai · {npc:12721} Mitsuwa · {npc:12757} Karang Amakkar · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past Astranaar (Alliance: keep to the road), to the coast. Zoram'gar Outpost is on the Zoram Strand in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "",
	-- {npc:12721} Mitsuwa
	["{npc:12721}: the troll charms are in Thistlefur Hold, east of the outpost"] = "",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "",

	-- Step 9: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "",
	["Naga brazier"] = "Braseiro naga",

	-- Step 10: Naga heads
	["Naga heads"] = "Cabeças de naga",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Toda naga Iracauda ao longo da praia ao norte do posto deixa cair cabeças.",

	-- Step 11: Zoram'gar Outpost
	["Back to the outpost before heading east to Thistlefur."] = "",

	-- Step 12: Thistlefur Village
	["Thistlefur Village"] = "",
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold.\nCareful: A Shaman at 15% health or lower runs off to find help, which can pull extra furbolgs."] = "",

	-- Step 13: Thistlefur Hold
	["Thistlefur Hold"] = "Toca dos Pelocardo",
	-- {npc:12818} Ruul Snowhoof · {npc:3987} Dal Bloodclaw
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to Night Run.\nCareful: Two scripted ambushes occur, each made up of three Thistlefurs (a Shaman, a Pathfinder and an Avenger, Ursa or Den Watcher): the first when you come back to the tunnel's fork inside the cave, the second just beyond the gate where {npc:3987} roams."] = "",
	["Below ground"] = "",
	-- {npc:12818} Ruul Snowhoof
	["{npc:12818}, below ground"] = "",

	-- Step 14: Zoram'gar Outpost
	-- {npc:12757} Karang Amakkar · {zone:1440} Ashenvale
	["Back west to Zoram'gar. {npc:12757} offers King of the Foulweald now; leave it for the next {zone:1440} visit at 26, when the walk east passes the Foulweald."] = "",

	-- Step 15: Splintertree Post
	-- {npc:12837} Yama Snowhoof
	["Fly to Splintertree Post: {npc:12837} waits in the inn for news of Ruul."] = "",
	-- {npc:12837} Yama Snowhoof
	["{npc:12837}, inside the inn"] = "",

	-- Step 16: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	-- {zone:1454} Orgrimmar
	["Back out of the inn to the flight master and fly to {zone:1454}."] = "",
	["Splintertree Post flight master"] = "",

	-- Step 17: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 18: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 20: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} fica em {object:172960}. Use {item:6626} no círculo de invocação ali e derrote a súcubo para vinculá-la.",

	-- Step 21: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "",
	-- {npc:2391} Serge Hinott · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:2391} in {object:1772} teaches Poisons: keep it"] = "",

	-- Step 23: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 24: The Sepulcher
	-- {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road to the Sepulcher. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "",
	-- {npc:1937} Apothecary Renferrel · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:1937}: Lydon in {object:1772}, next guide"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, south-east of Ambermill"] = "",

	-- Step 25: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "",
	-- {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around Ambermill, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone (no name in this language: may be words)
	["In the ruins of {quest:516}: The Ravenclaw undead haunt the ruins of {quest:516} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, de um {npc:1973}",
	-- {object:645153} Offering Stone (no name in this language: may be words) · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "",

	-- Step 27: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone (no name in this language: may be words) · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Use o {npc:212753} no {object:645153} para um sacrifício voluntário e mate o {npc:212753} que responder. {quest:95883} é elite: recomenda-se formar grupo.",

	-- Step 29: Southpoint Tower
	["Southpoint Tower"] = "",
	-- {npc:2214} Deathstalker Lesh
	["Back on the road south. Where it turns east into Hillsbrad, {npc:2214} waits at Southpoint Tower."] = "",
	-- {npc:2214} Deathstalker Lesh · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:2214}: Darthalia in {object:1772}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "De volta à estrada para o sul. Onde ela vira para leste rumo a {area:287}, {npc:2214} espera em {area:285}.",
	-- ["Back to {npc:8582}"] = "De volta a {npc:8582}",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "A leste de Zé, a Empreendimentos S.A. está desmatando {area:461}; um dos Operadores leva as plantas. {npc:4276} minera na pequena mina do lado leste: fique com ele enquanto minera, capangas da Empreendimentos S.A. vêm atrás dele.",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Voe até {area:431} e cavalgue para o sul pela estrada até {area:1703}.",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Siga a estrada para leste ao longo do rio e depois para nordeste, subindo as colinas até {area:272}.",
	-- ["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Siga a estrada para o norte rumo a {area:467}. Ginetes Galhados pastam pelo caminho; as Feras de Seiva, os Corredores do Crepúsculo e os Dragões Encantados vagam pela mata abaixo do pico, e os druidas cenarianos ocupam o bosque de lá.",
	-- ["Follow the road west to {area:460}."] = "Siga a estrada para oeste até {area:460}.",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "De {area:380}, siga a estrada para o norte. {npc:8582} fica na torre de vigia de {area:1703}, onde a estrada entra em {zone:1440}. Abra o {item:16783} que ele lhe der.",
	-- ["Gaea Dirt Mounds"] = "Montes de Terra de Gaia",
	-- ["Gaea Seeds"] = "Sementes de Gaia",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Se você já conhece a rota de voo de {area:272}, voe para lá e pule para {area:272}. Senão, voe de {zone:1458} para {area:228} e cavalgue para o sul pela estrada, passando por Lenhardente. Os mortos-vivos Corvinalle assombram as ruínas de {area:231}, a leste da estrada, no sudeste da floresta; um {npc:1973} deixa cair o {item:271343} que leva ao {object:645153}.",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Continue para o norte pela estrada. O {npc:12862} espera no acampamento madeireiro do Brado Guerreiro, ao sul de Machadada.",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "No caminho para oeste, {npc:267214} está preso numa ravina ao sul da estrada principal, a sudeste de {area:415}. Cervos Galhassombra e Ursos do Vale Gris vagam pela mata em volta.",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "Desça de volta por {area:1076} até {area:2539}.",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Cavalgue para leste até {area:380} e voe para {zone:1454}. Pegue o zepelim nas torres do lado de fora de {zone:1454} até {zone:1420}; {area:1497} fica abaixo de {area:153}. O mestre dos morcegos fica no {object:36078}.",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Cavalgue para o sul até {area:380} e depois para oeste pela estrada, saindo de {zone:1413} rumo às Torres de Pedra. A aldeia troll de {area:2539} fica na entrada do cânion.",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Cavalgue para oeste pela estrada principal através de {zone:1440}, passando por {area:415} (Aliança: fique na estrada), até o litoral. {area:2897} fica em {area:414}, no noroeste. As outras missões de lá são para a próxima visita, no nível 27.",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "A sudoeste da Rocha do Sol fica o {area:465}, queimado. Plante as Sementes de Gaia nos montes de terra no fundo do vale; os elementais de fogo deixam cair {item:16312}. Harpias e Emboscadoras Furissangue fazem ninho no lado norte, Matadoras e Plumerrantes ao sul.",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Fale com {npc:10181}, no {object:36126}: {quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "Cobogó em {area:392}: o próximo guia passa por lá",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "As Sementes de Gaia ficam na grama em volta da margem sul de {area:464}, ao norte de Rocha do Sol.",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "A estrada sobe para o norte como {area:1076}. {quest:1483} tem uma cabana onde a estrada se divide para leste rumo a {area:461}.",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "O {npc:12864} patrulha a estrada a leste de {area:428} rumo a {area:430}.",
	-- ["To the {area:1497}"] = "Para {area:1497}",
	-- ["{area:431} is just north up the road."] = "{area:431} fica logo ao norte, subindo a estrada.",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}, das Almas Torturadas entre as ruínas",
	-- ["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, de qualquer harpia Furissangue",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Pedras Solares Lampejantes das harpias Furissangue",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}: Grish está no {area:1718}, no próximo guia",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, ao lado de {npc:11862}",
	-- ["{npc:11862}, up on the ledge"] = "{npc:11862}, lá em cima na saliência",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} fica em {area:428}, o acampamento do Brado Guerreiro logo a nordeste de Machadada, ao lado do quadro de caçadas.",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "Os alvos de caça de {npc:12696} (Ursangous, Shadumbra, Garraguda) são para a próxima visita a {zone:1440}, no nível 27.",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} em Zoram'gar, no nível 27",
	-- ["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Darthalia em {area:272}",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "A próxima missão de {npc:4198}, Ornanos, fica no lado da Aliança de {zone:1440}. Pule-a.",
	-- ["{npc:4198}, outside the gate"] = "{npc:4198}, do lado de fora do portão",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606} fica no {object:36070}.",
}
