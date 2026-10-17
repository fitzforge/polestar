-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Voe para {area:1497}",
	-- {area:3317} Revantusk Village · {area:1497} Undercity
	["From {area:3317}'s flight master, fly to the {area:1497}."] = "No mestre de voo de {area:3317}, voe para {area:1497}.",

	-- Step 2: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter (no name in this language: may be words)
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} fica no {object:36082}.",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:431} Splintertree Post
	["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Pegue o zepelim para {zone:1454} na torre do lado de fora de {zone:1458} e depois voe para {area:431}.",

	-- Step 4: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Siga para {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Siga para o leste pela estrada que sai do Posto Machadada. {npc:11548} espera em {area:1235}, logo ao lado da estrada, a poucos passos a oeste de {area:3137}, da Aliança: chegue pelo oeste e fique longe das Sentinelas de Azshara e de Jarrodenes (elite).",

	-- Step 5: Highborne and Haldarr satyrs
	["Highborne and Haldarr satyrs"] = "Altaneiros e Sátiros Haldarr",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "As Aparições Altaneiras assombram as ruínas logo ao norte do santuário; os Sátiros Haldarr acampam um pouco mais ao norte.",

	-- Step 6: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Volte até {npc:11548} no santuário; fique a oeste dos guardas de {area:3137}.",

	-- Step 7: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Siga a estrada para o norte até {area:1237}, o acampamento da Horda.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, na borda leste do acampamento: não dá experiência, só um teleporte para a Torre de Azshara",

	-- Step 8: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Penas Intactas de Hipogrifo",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Os Hipogrifos Cabeça-de-trovão voam sobre as colinas logo ao sul de {area:1237}.",

	-- Step 10: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Siga para o nordeste até o acampamento do goblin nos penhascos acima de {area:1227}.",

	-- Step 11: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "O acampamento dos elfos sangrentos fica logo ao sul de {npc:8420}. As quatro peças de equipamento dele estão nos caixotes em volta do acampamento.",

	-- Step 13: Ruins of Eldarath
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Siga para o sudoeste até as ruínas. As quatro tabuletas ficam entre as ruínas, guardadas por nagas Iralisca; qualquer Sirena ou Mirmidão pode carregar a runa de {npc:8420}.",

	-- Step 14: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Volte para o nordeste até {npc:8420}.",

	-- Step 15: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Volte para o oeste até {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Guarde as entregas para {npc:4046}, {npc:8659} e {npc:6522}: você passa por {zone:1456}, {zone:1454} e {zone:1458} mais tarde.",

	-- Step 16: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "A torre de Tauriel fica no penhasco logo ao norte de {area:1237}; a trilha sobe pelo lado norte.",

	-- Step 18: To Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["To {object:3202}"] = "Para {object:3202}",
	-- {area:1237} Valormok · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Voe de {area:1237} para {zone:1454}, saia pelo portão principal até as torres de zepelim e pegue o zepelim para {object:3202}.",

	-- Step 19: Grom'gol Base Camp
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay
	["The {object:2076} beside {npc:2519}"] = "{object:2076} ao lado de {npc:2519}",

	-- Step 20: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Ferroqueixo",
	["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Siga a estrada para o sul; os basiliscos tomam sol nas pedras a leste dela, no meio da selva. Os fragmentos caem com frequência.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Continue para o sul até {area:35}. {npc:7406} tem sua oficina no anel superior da baía.",
	["Only once all three robots are home"] = "Só depois que os três robôs estiverem em casa",

	-- Step 22: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Volte para {object:3202}",

	-- Step 23: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Take the zeppelin back to {zone:1454}."] = "Pegue o zepelim de volta para {zone:1454}.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, no Drag",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Guarde o pagamento de {npc:8659} e {quest:3504} de Ag'tor: eles voltam para {area:1237} numa visita futura.",

	-- Step 24: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {area:1638}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Voe para {area:1638}; fica no caminho para {area:1099}. Ainda não tem a rota de voo? Voe para {area:378} e siga para o oeste por {zone:1412}. Hamuul e {npc:4046} ficam em {area:1639}; Druidas e Paladinos treinam aqui ({npc:3033}, {npc:246344}).",
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} é coletado no próximo guia; o pagamento de {npc:4046} volta para {npc:8587} depois.",

	-- Step 25: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: os ursos ficam em {zone:1448}",
	-- {area:1417} Sunken Temple · {npc:7771} Marvon Rivetseeker · {zone:1446} Tanaris
	["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Guarde {area:1417} para {npc:7771} em {zone:1446}.",

	-- Step 26: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Hipogrifos Esfiapluma",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Os hipogrifos fazem ninho nas colinas a sudoeste do acampamento. Mate um e use o Recipiente de Muisec no corpo.",

	-- Step 28: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Dardejantes",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "As dragoletas voam pelo bosque logo a oeste do acampamento. Use o recipiente em cada uma que matar.",

	-- Step 30: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Andarilhos Errantes da Floresta",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Os arvorosos vagam pelas estradas da floresta entre o acampamento e o meio de {zone:1444}; são poucos, então procure ao longo das trilhas.",

	-- Step 32: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Siga para o noroeste até {area:1108}; {npc:14637} espera no cais.",

	-- Step 33: Zapped giants
	["Zapped giants"] = "Gigantes encolhidos",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Os Terrâmbulos e Gigantes do Penhasco vagam pelas colinas ao norte do cais. Use primeiro {item:18904} em cada um: encolhidos, deixam de ser elite. Todo gigante encolhido deixa resíduo; use também o Recipiente de Muisec no corpo.",

	-- Step 34: Sea elementals
	["Sea elementals"] = "Elementais do mar",
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Os Elementais do Mar e Borrifos do Mar vagam pela costa em volta do cais.",

	-- Step 36: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Volte para {area:1099}",

	-- Step 37: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, ao lado do mestre de voo",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "O piche de {npc:7876} e as amostras de Almofarrista vêm de {zone:1449}.",

	-- Step 38: Broken Pillar
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Siga a estrada para o sul até {area:1938}; {npc:7771} acampa ao lado. Daqui a estrada para o oeste desce até {zone:1449}, onde começa o próximo guia.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Guarde {quest:3444}: o baú de {npc:7771} é aberto numa visita futura.",
}
