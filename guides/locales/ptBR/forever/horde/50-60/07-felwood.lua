-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 2: Vehena
	-- {object:172961} Valley of Spirits (no name in this language: may be words)
	["In the {object:172961}."] = "Em {object:172961}.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "sessenta {item:14047}",

	-- Step 4: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Voe para {area:431}",

	-- Step 5: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 6: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Voe para {area:431} e siga para o noroeste pela estrada que sai de {zone:1440} para {zone:1448}. {area:2479} é o acampamento dos druidas logo depois da fronteira.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, lá dentro",
	-- {quest:4084} Silver Heart · {item:11172} Silvery Claws · {item:11173} Irontree Heart · {area:1767} Irontree Woods · {npc:9116} Eridan Bluewind
	["{quest:4084}'s {item:11172} and {item:11173} come from {area:1767} on this guide's ride north; {npc:9116} takes them at the end of the guide, back here."] = "",

	-- Step 7: Rakaiah
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {item:13140} Blood Red Key · {area:1763} Jaedenar · {area:1770} Shadow Hold
	["Only if {npc:11019} sent you after {npc:9518} (the {item:13140}'s chain): on the ride north, turn west into {area:1763} and go into {area:1770}, the cave at the back of the camp. {npc:9518} (56) and the remains of Trey Lightforge are inside: kill her first, then the remains take her quest and give the next, which goes back to {npc:11019} at the end of this guide."] = "",

	-- Step 9: Trull Failbane
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Siga a estrada para o norte, passando por {area:1763}, até {area:1997}.",

	-- Step 10: Bloodvenom Post
	-- {npc:10306} Trull Failbane · {quest:4721} Wild Guardians · {area:2255} Everlook · {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{npc:10306}'s last {quest:4721} are the Berserk Owlbeasts north of {area:2255}, on this guide's {zone:1452} loop; he takes them at the end of the guide, back here."] = "",

	-- Step 11: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {item:11172} Silvery Claws · {npc:14524} Vartrus the Ancient
	-- plural, as words: Irontree Wanderers = {npc:7138} Irontree Wanderer · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	-- was: ["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "Cavalgue para o norte, subindo a estrada de {zone:1448}, até {area:1767}; os {quest:5086} escorrem entre as árvores, e a maioria deles deixa cair uma gota.\nCuidado: Andarilhos Ancestrais de Ferrárbol, elites de nível 59, andam entre os {quest:5086}, e {npc:14524} (63, elite) vaga pela mata: enfrente os Horrores na ponta norte de {area:1767}, um de cada vez."
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet. The Irontree Wanderers and Stompers (52-53) there carry {npc:9116}'s {item:11173}, the Angerclaw bears and Felpaw wolves his {item:11172}.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "",

	-- Step 13: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Atravesse o túnel dos Presamatos até {zone:1450}. {npc:11939} lê numa casa em {area:2361}.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} anda por {area:2361}: procure dentro do círculo no mapa",

	-- Step 15: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 16: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Pedaços de Vinhavil, de {npc:11801}, pede {area:2577}. Pule.",

	-- Step 19: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Volte ao túnel dos Presamatos e pegue a saída para {zone:1452}; {npc:9298} acampa junto às fontes termais logo do lado de fora.",
	["From Krakle in Un'Goro, if you didn't bring it to her earlier"] = "",

	-- Step 20: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Os mensageiros andam pela estrada de {area:1769} rumo a {area:2244} em grupinhos; espere na beira da estrada perto de {npc:9298} e mate-os quando passarem. Cada um carrega um caixote.\nCuidado: a entrega faz surgir três ou quatro emboscadores Invernosos de nível 56-57 que atacam você; dá para escapar montado, furtivo ou com {spell:5384}, e depois eles se juntam perto do lago, liberando a próxima missão.",

	-- Step 21: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "A vila de {quest:8464} fica a nordeste de {area:2255}, no caminho de volta de {area:2256} neste guia.",

	-- Step 22: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Com 30 {quest:6031} nas bolsas: siga a estrada para o norte até {area:1769}; {npc:11557} negocia logo depois da entrada.",
	["Below ground"] = "No subterrâneo",

	-- Step 23: Kernda
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if you are Neutral with the Timbermaw now (the {area:1769} reputation guide gets you there): {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} anda por aqui: procure dentro do círculo no mapa",

	-- Step 24: Witch Doctor Mau'ari
	-- {area:2255} Everlook · {npc:11755} Harlo Wigglesworth · {npc:10307} Witch Doctor Mau'ari · {area:2249} Frostwhisper Gorge
	["Ride east along the road to {area:2255}: {npc:11755} sends you to {npc:10307}, who stands in the town, on the way to {area:2249}."] = "",

	-- Step 26: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	-- was: ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Vá para leste e depois desça para o sul por {area:2249}. Os Gigantes Friomalho de lá são elite de nível 59: fique no meio e não pare. A estranha fonte está na entrada de {area:2256}, no extremo sul."
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59-60: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "",

	-- Step 27: Frostmaul Shards
	-- {area:2249} Frostwhisper Gorge · {npc:10198} Kashoch the Reaver
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["The shards lie on the ground along the west side of {area:2249}, among the Frostmaul Giants and Preservers. Careful: the giants are elites of 59-60: pick up the shards that lie clear of them, wait for a patrol to pass, and leave {npc:10198} (60, east side) alone."] = "",

	-- Step 28: Level 59.7
	["Level 59.7"] = "",
	-- {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {npc:11556} Salfa · {npc:10306} Trull Failbane · {npc:9116} Eridan Bluewind · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to about level 59.7 before the last hand-ins: Umi, Vizzie, Mau'ari, {area:2244}, {npc:9298}, {npc:11556}, {npc:10306} and {npc:9116} take you the rest of the way to 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "mate {npc:7446} até subir",

	-- Step 29: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yetis Cardo de Gelo",
	-- {area:2255} Everlook · {item:258323} Missing Mail
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["On the ride north to {area:2255}, the Ice Thistle Yetis (55-56) in the hills south-east of the town carry Vizzie's {item:258323}: four pieces."] = "",

	-- Step 30: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "Cavalgue para o norte até {area:2255}.",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "Assuste {npc:10978} com o {npc:10980}",

	-- Step 31: Everlook
	-- {npc:11118} Innkeeper Vizzie · {quest:93406} Unfrozen Deliveries
	["{npc:11118}, in the inn: {quest:93406}"] = "",

	-- Step 33: Winterfall Village
	-- {area:2255} Everlook · {quest:5121} High Chief Winterfall
	-- was: ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "A vila furbolg ocupa o vale a nordeste de {area:2255}. Mate os Xamãs primeiro; eles curam. {npc:10738} (59, elite) e Xandivious (62) ficam na caverna dos fundos: não entre."
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {quest:5121} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "",

	-- Step 34: Berserk Owlbeasts
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Berserk Owlbeasts"] = "",
	-- {area:2241} Frostsaber Rock · {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["The Berserk Owlbeasts (58-59) roam the slopes of {area:2241}, north of {area:2255} and west of the furbolg valley. Now and then an owlbeast drops a {item:12558}: use it to start {quest:4882}."] = "",

	-- Step 35: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "Volte para oeste pela estrada até {area:2246}.",

	-- Step 36: High Chief Winterfall
	-- {npc:9298} Donova Snowden · {quest:5121} High Chief Winterfall · {area:2244} Winterfall Village · {area:2255} Everlook · {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["A group choice: {npc:9298} sends you after {quest:5121} (59, elite, with his guards) in the cave at the back of {area:2244}, back east past {area:2255}; Xandivious (62) shares the cave: leave him. The High Chief carries a log for {npc:9298}, and her next errand goes to {npc:10920} at the {area:2479}, this guide's last stop."] = "",
	-- {quest:5121} High Chief Winterfall
	["{quest:5121}, in the cave"] = "",
	["the log he carries"] = "",
	-- {npc:9298} Donova Snowden
	["{npc:9298}, back west at the hot springs"] = "",
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["for {npc:10920} at the {area:2479}"] = "",

	-- Step 37: Salfa
	-- {zone:1452} Winterspring
	["North of Donova, at the tunnel's {zone:1452} exit."] = "Ao norte de Donova, na saída do túnel para {zone:1452}.",

	-- Step 38: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "{npc:11556} só aceita as contas depois que {quest:8464} for entregue: qualquer furbolg Invernoso pode carregá-las, e os acampamentos logo ao sul de {npc:11556} são os mais próximos.",
	["Frostfire Winterfall camp"] = "Acampamento Invernoso das fontes termais",

	-- Step 40: Trull Failbane
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post
	["Back through the Timbermaw tunnel and south down the {zone:1448} road to {area:1997}."] = "",

	-- Step 41: Trull Failbane
	-- {quest:4882} Guarding Secrets · {item:12558} Blue-feathered Necklace
	["{quest:4882}, from the {item:12558}"] = "",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["{quest:4882} goes on to {npc:5770} in {zone:1456}, off this route: leave it."] = "",

	-- Step 42: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary · {npc:11019} Jessir Moonbow
	["South along the road to the {area:2479}: {npc:11019}, at its east side, takes Trey Lightforge's remains."] = "",

	-- Step 43: Kelek Skykeeper
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["{npc:10920}, at the {area:2479}, takes the High Chief's words."] = "",

	-- Step 44: Eridan Bluewind
	-- {area:2479} Emerald Sanctuary
	["South along the road to the {area:2479}."] = "",
	-- {npc:9116} Eridan Bluewind · {zone:1446} Tanaris
	["{npc:9116}'s Aquementas leads on to {zone:1446} and Un'Goro: leave it."] = "",
	-- {zone:1454} Orgrimmar · {area:431} Splintertree Post
	["In {zone:1454}: fly from {area:431}"] = "",
	-- {zone:1456} Thunder Bluff
	["In {zone:1456}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Caiu uma {item:13140}: os Impositores, Tecelões Sombrios, Bruxos e Legionários Jaedenar da Fortaleza Sombria às vezes carregam uma. Use-a para iniciar a missão e depois liberte {npc:11018} da jaula no extremo sul da caverna, na saída.",
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Qualquer furbolg Invernoso pode carregar as contas; os acampamentos logo ao sul de {npc:11556} são os mais próximos.",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "Volte ao túnel dos Presamatos e pegue a saída para {area:618}; {npc:9298} acampa junto às fontes termais logo do lado de fora.",
	-- ["Back south to the Sanctuary, a short ride."] = "Volte para o sul até o Santuário, perto daqui.",
	-- ["Corrupted Soul Shards from the cultists, {quest:5887}"] = "Fragmentos de Alma Corrompidos dos cultistas, {quest:5887}",
	-- ["Dungeon instead of grinding"] = "Masmorra em vez de matar monstros",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "Voe para {area:431} e siga para o noroeste pela estrada que sai de {zone:1440} para {area:361}. {area:2479} é o acampamento dos druidas logo depois da fronteira.",
	-- ["From Krakle in Un'Goro"] = "De Gualter, na Cratera Un'Goro",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "De {zone:1458}, pegue o zepelim na torre do lado de fora da cidade para {zone:1454}.",
	-- ["Grind to 60"] = "Mate monstros até o 60",
	-- ["In {zone:1454}: fly from {area:2255}"] = "Em {zone:1454}: voe de {area:2255}",
	-- ["In {zone:1456}: fly from {area:2255}"] = "Em {zone:1456}: voe de {area:2255}",
	-- ["Level 59.9"] = "Nível 59.9",
	-- ["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "Na volta para o sul até Greta, entregue os fragmentos a {npc:9529}, no lado oeste do Santuário.",
	-- ["Only at Neutral with the Timbermaw: {npc:11558} waits at the tunnel mouth of {area:1769}."] = "Só se você estiver Neutro com os Presamatos: {npc:11558} espera na boca do túnel de {area:1769}.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Só se tiver {quest:5087}: os mensageiros andam pela estrada de {area:1769} rumo a {area:2244} em pequenos grupos; espere na estrada perto de {npc:9298} e mate-os quando passarem. Cada um carrega um caixote.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Só se {npc:9298} deu {quest:5086} a você: siga para o norte pela estrada de {area:361} até {area:1767}; os alvos de {quest:5086} escorrem entre as árvores.",
	-- ["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Só com 30 de {quest:6031}, e só se estiver Neutro com os Presamatos: siga a estrada para o norte até {area:1769}; {npc:11557} negocia logo depois da entrada.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Fazer {area:2279}, {area:2057}, o Pico da Rocha Negra Inferior ou {area:1584} em grupo, em vez de matar monstros, leva você lá mais rápido.",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Opcional: em grupo, uma masmorra 55-60 substitui a matança abaixo.",
	-- ["Ride back west to {area:2246}."] = "Volte para oeste até {area:2246}.",
	-- ["Ride east along the road to {area:2255}."] = "Siga a estrada para o leste até {area:2255}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Vá para leste e depois desça para o sul por {area:2249}. Os Gigantes Friomalho de lá são elite de nível 59: fique no meio e não pare. A estranha fonte está na entrada de {area:2256}, no extremo sul.",
	-- ["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "Cavalgue para o norte, subindo a estrada de {zone:1448}, até {area:1767}; os {quest:5086} escorrem entre as árvores, e a maioria deles deixa cair uma gota.\nCuidado: Andarilhos Ancestrais de Ferrárbol, elites de nível 59, andam entre os {quest:5086}, e {npc:14524} (63, elite) vaga pela mata: enfrente os Horrores na ponta norte de {area:1767}, um de cada vez.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Siga para o noroeste até {area:1763}. Os quatro braseiros ficam entre as construções do Concílio das Sombras; use a água purificada em cada um.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "Cavalgue para noroeste até {area:1763}. Os quatro braseiros ficam entre as construções do Concílio das Sombras; use a água purificada em cada um.\nCuidado: monstros do Concílio das Sombras de nível 53-55 lotam a caverna e costumam vir em grupos grandes e ligados, muitos com atordoamento. Melhor ir num grupo de 2 ou 3 jogadores.",
	-- ["South to the Sanctuary once more."] = "Volte mais uma vez para o sul até o Santuário.",
	-- ["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then: she waits at the tunnel mouth of {area:1769} and speaks to you from Neutral with the Timbermaw, which the Deadwood furbolgs of {zone:1448} brought you to."] = "O totem de Lenha Morta de {area:1762}, se {npc:11558} não o aceitou na época: ela espera na boca do túnel de {area:1769} e fala com você a partir de Neutro com os Presamatos, reputação que os furbolgs de Lenha Morta de {zone:1448} lhe deram.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "A vila furbolg ocupa o vale a nordeste de {area:2255}. Mate os Xamãs primeiro; eles curam. {npc:10738} (59, elite) e Xandivious (62) ficam na caverna dos fundos: não entre.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "As missões acabam aqui. Dentilhaços Raivosos rondam {area:2249}, no sul de {area:618}, ao sul da estrada que sai de {area:2255}.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "As missões acabam aqui. Dentilhaços Raivosos rondam {area:2249}, no sul de {zone:1452}, ao sul da estrada que sai de {area:2255}.",
	-- ["The zeppelin towers"] = "As torres dos zepelins",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "Atravesse o túnel dos Presamatos até {area:493}. {npc:11939} lê numa casa em {area:2361}.",
	-- ["Top up here to level 59.9 before the hand-ins at {area:618}: they take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Complete aqui até o nível 59.9 antes das entregas em {area:618}: elas levam você ao nível 60. Ou, em grupo, faça a masmorra {area:2057} ou a masmorra {area:2279}.",
	-- ["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Complete aqui até o nível 59.9 antes das entregas em {zone:1452}: elas levam você ao nível 60. Os Dentilhaços Raivosos (59) de {area:2249}, logo ao norte da fonte estranha, dão muito mais experiência do que os furbolgs de {area:1769}. Ou, em grupo, faça a masmorra {area:2057} ou a masmorra {area:2279}.",
	-- ["Trey Lightforge's remains lie at the edge of the {area:1763} camp, west of the road: they go back to {npc:11019} at the end of this guide."] = "Os restos de Trey Lightforge ficam na borda do acampamento de {area:1763}, a oeste da estrada: eles voltam para {npc:11019} no fim deste guia.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",
	-- ["grind on {npc:7441}"] = "mate {npc:7441} até subir",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "mate {npc:7446} em {area:2249}, {area:618}",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "mate {npc:7446} em {area:2249}, {zone:1452}",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "só se ainda estiver com ela: o guia de {zone:1423} a entrega no caminho",
	-- ["sixty {item:14047}, if you carry them"] = "sessenta {item:14047}, se estiver carregando",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "A próxima missão de {npc:10306}, {quest:4741}, traria você de volta de {area:618}. Pule.",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "A próxima missão de {npc:10306}, {quest:4741}, traria você de volta de {zone:1452}. Pule.",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, no subterrâneo",
	-- ["{npc:11558}, at the tunnel mouth; walks around here: look inside the circle on the map"] = "{npc:11558}, na boca do túnel; anda por aqui: procure dentro do círculo no mapa",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "Coração de prata, de {npc:9116}, pede {item:11173} do norte de {area:361} e uma volta até aqui. Pule.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Coração de prata, de {npc:9116}, pede {item:11173} do norte de {zone:1448} e uma volta até aqui. Pule.",
	-- ["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Depois {npc:9298} manda você atrás de {npc:10738}, um elite na caverna dele. Pule.",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529} fica no lado oeste do Santuário, na saída para {area:1763}. Com {quest:4102} concluída, a missão dela, {quest:5887}, pede seis Fragmentos de Alma Corrompidos: os cultistas do Concílio das Sombras em {area:1763} e {area:1770} deixam cair um a cada três mortes, mais ou menos, e você enfrenta dezenas deles para {npc:10922}.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} e {npc:9517} esperam no fundo de {area:1770}, a caverna no norte de {area:1763}. Limpe o túnel no caminho.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}, {npc:9860} e {npc:9517} esperam no fundo de {area:1770}, a caverna no norte de {area:1763}. Limpe o túnel pelo caminho.\nCuidado: os três chefes lutam juntos. Mate os monstros por perto antes para não puxar inimigo a mais.",
}
