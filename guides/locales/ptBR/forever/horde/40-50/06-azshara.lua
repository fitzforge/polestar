-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe até {object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "Mestre de voo de {area:75}",

	-- Step 3: To Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["To {object:3202}"] = "Para {object:3202}",
	-- {area:75} Stonard · {area:117} Grom'gol Base Camp
	["The flight from {area:75} lands at {area:117}."] = "O voo de {area:75} pousa em {area:117}.",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Mestre de voo de {object:3202}",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Continue para o sul até {area:35}. {npc:7406} tem sua oficina no anel superior da baía.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}, lá dentro",
	["Only once all three robots are home"] = "Só depois que os três robôs estiverem em casa",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}, na estalagem",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "{npc:2487}, na varanda do mesmo prédio",

	-- Step 7: The Bloodsail ships
	["The Bloodsail ships"] = "Os navios da Vela Sangrenta",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "Ao sul de Angra do Butim, três navios da Vela Sangrenta ficam ao largo de {area:43}: {npc:2550}, {npc:2548} e {npc:2546} ficam cada um num convés, com suas tripulações. Nade até lá e vá de navio em navio.",

	-- Step 9: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {quest:8552} pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 15: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Volte para {object:3202}",

	-- Step 16: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:818} (elite nível 47) pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.\nCuidado: dois guardas elite lançadores de feitiço, por volta do nível 45, ficam com {npc:818} e entram na luta junto com ele.",
	["Below ground"] = "No subterrâneo",

	-- Step 20: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 22: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Siga para {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Siga para o leste pela estrada que sai do Posto Machadada. {npc:11548} espera em {area:1235}, logo ao lado da estrada, a poucos passos a oeste de {area:3137}, da Aliança: chegue pelo oeste e fique longe das Sentinelas de Azshara e de Jarrodenes (elite).",

	-- Step 23: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}: vá matando estes pelo caminho",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "As Aparições Altaneiras assombram as ruínas logo ao norte do santuário; os Sátiros Haldarr acampam um pouco mais ao norte.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117} anda por {area:1235}: procure dentro do círculo no mapa",

	-- Step 24: Level 50
	["Level 50"] = "Nível 50",
	-- {quest:4493} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar · {zone:1447} Azshara · {area:2100} Maraudon · {area:1417} Sunken Temple
	["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it. Or, with a group, run the {area:2100} dungeon or the {area:1417} dungeon instead."] = "Complete aqui até o nível 50: {quest:4493}, de {npc:7010} em {zone:1454}, no fim de {zone:1447}, exige isso. Ou, em grupo, faça a masmorra {area:2100} ou a masmorra {area:1417}.",
	-- {npc:6125} Haldarr Satyr
	["grind on {npc:6125}"] = "mate {npc:6125} até subir",

	-- Step 25: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Volte até {npc:11548} no santuário; fique a oeste dos guardas de {area:3137}.",

	-- Step 26: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Siga a estrada para o norte até {area:1237}, o acampamento da Horda.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, na borda leste do acampamento: não dá experiência, só um teleporte para a Torre de Azshara",

	-- Step 28: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Penas Intactas de Hipogrifo",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Os Hipogrifos Cabeça-de-trovão voam sobre as colinas logo ao sul de {area:1237}.",

	-- Step 30: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Siga para o nordeste até o acampamento do goblin nos penhascos acima de {area:1227}.",

	-- Step 31: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "O acampamento dos elfos sangrentos fica logo ao sul de {npc:8420}. As quatro peças de equipamento dele estão nos caixotes em volta do acampamento.",

	-- Step 33: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: vá matando estes pelo caminho",
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Siga para o sudoeste até as ruínas. As quatro tabuletas ficam entre as ruínas, guardadas por nagas Iralisca; qualquer Sirena ou Mirmidão pode carregar a runa de {npc:8420}.",

	-- Step 34: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Volte para o nordeste até {npc:8420}.",

	-- Step 35: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Volte para o oeste até {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Guarde as entregas para {npc:4046}, {npc:8659} e {npc:6522}: você passa por {zone:1456}, {zone:1454} e {zone:1458} mais tarde.",

	-- Step 36: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "A torre de Tauriel fica no penhasco logo ao norte de {area:1237}; a trilha sobe pelo lado norte.",
	["Upstairs"] = "No andar de cima",

	-- Step 38: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Mestre de voo de {area:1237}",

	-- Step 39: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, no Drag",

	-- Step 40: Orgrimmar
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Guarde o pagamento de {npc:8659} e {quest:3504} de Ag'tor: eles voltam para {area:1237} numa visita futura.",

	-- Step 41: Paladin trainer
	["Paladin trainer"] = "Instrutor de paladino",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {zone:1454} não tem instrutor de paladino",

	-- Step 42: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Voe para {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 43: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Voe para {zone:1456}; fica no caminho para {area:1099}. Ainda não tem a rota de voo? Voe para {area:378} e siga para o oeste por {zone:1412}. Hamuul e {npc:4046} ficam em {area:1639}; Druidas e Paladinos treinam aqui ({npc:3033}, {npc:246344}).",

	-- Step 44: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 45: Thunder Bluff
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} é coletado no próximo guia; o pagamento de {npc:4046} volta para {npc:8587} depois.",

	-- Step 46: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Voe para {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 47: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: os ursos ficam em {zone:1448}",

	-- Step 48: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Hipogrifos Esfiapluma",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Os hipogrifos fazem ninho nas colinas a sudoeste do acampamento. Mate um e use o Recipiente de Muisec no corpo.",

	-- Step 50: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Dardejantes",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "As dragoletas voam pelo bosque logo a oeste do acampamento. Use o recipiente em cada uma que matar.",

	-- Step 52: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Andarilhos Errantes da Floresta",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Os arvorosos vagam pelas estradas da floresta entre o acampamento e o meio de {zone:1444}; são poucos, então procure ao longo das trilhas.",

	-- Step 55: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: vá matando estes pelo caminho",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray · Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Os Elementais do Mar e os Borrifos do Mar vão e vêm pela praia em volta do cais.\nOs Terrâmbulos e os Gigantes do Penhasco andam pelas colinas ao norte do cais. Dê uma zapeada em cada um com o {item:18904} antes: encolhidos, deixam de ser elite. Todo gigante zapeado deixa cair resíduo; use também o Recipiente de Muisec no corpo dele.",

	-- Step 57: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Volte para {area:1099}",

	-- Step 58: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voar para {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Mestre de voo de {area:1099}",

	-- Step 59: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, ao lado do mestre de voo",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "O piche de {npc:7876} e as amostras de Almofarrista vêm de {zone:1449}.",

	-- Step 60: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Siga a estrada para o sul até {area:1938}; {npc:7771} acampa ao lado. Daqui a estrada para o oeste desce até {zone:1449}, onde começa o próximo guia.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Guarde {quest:3444}: o baú de {npc:7771} é aberto numa visita futura.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Voe de {area:1237} para {zone:1454}, saia pelo portão principal até as torres de zepelim e pegue o zepelim para {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Voe para {area:1497}",
	-- ["Follow the road north out of {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "Siga a estrada para o norte, saindo de {area:35}; os basiliscos tomam sol nas rochas a leste dela, no meio da selva, no caminho de volta a {object:3202}. Os estilhaços deles caem com frequência.",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Siga a estrada para o sul; os basiliscos tomam sol nas pedras a leste dela, no meio da selva. Os fragmentos caem com frequência.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "No mestre de voo de {area:3317}, voe para {area:1497}.",
	-- ["Highborne and Haldarr satyrs"] = "Altaneiros e Sátiros Haldarr",
	-- ["Ironjaw Basilisks"] = "Basiliscos Ferroqueixo",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Guarde {area:1417} para {npc:7771} em {zone:1446}.",
	-- ["Ride into {area:16}"] = "Siga para {area:16}",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Siga para o noroeste até {area:1108}; {npc:14637} espera no cais.",
	-- ["Sea elementals"] = "Elementais do mar",
	-- ["Take the zeppelin back to {zone:1454}."] = "Pegue o zepelim de volta para {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Pegue o zepelim para {zone:1454} na torre do lado de fora de {zone:1458} e depois voe para {area:431}.",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Os Terrâmbulos e Gigantes do Penhasco vagam pelas colinas ao norte do cais. Use primeiro {item:18904} em cada um: encolhidos, deixam de ser elite. Todo gigante encolhido deixa resíduo; use também o Recipiente de Muisec no corpo.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Os Elementais do Mar e Borrifos do Mar vagam pela costa em volta do cais.",
	-- ["The {object:2076} beside {npc:2519}"] = "{object:2076} ao lado de {npc:2519}",
	-- ["Zapped giants"] = "Gigantes encolhidos",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: os ursos ficam em {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} fica no {object:36082}.",
}
