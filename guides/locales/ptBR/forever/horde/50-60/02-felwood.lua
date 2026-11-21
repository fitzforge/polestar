-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Ele acampa junto a {area:202}, a sudeste de {area:200}.",
	["Inside"] = "Lá dentro",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "Lobos Doentes",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "Os lobos vagam pelos campos entre Andorhal, {area:200} e {area:202}. Termine-os na volta para o leste. Cuidado: os maiores têm nível 54: puxe um de cada vez.",

	-- Step 3: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Casa da fazenda de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "O diário fica na casa da fazenda, o armário fica lá dentro e a casinha fica atrás dela. Um {npc:10816} leva a chave da casinha; {npc:10836} sai quando você abre a casinha e leva a chave do armário.",

	-- Step 4: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands guide's sweep at about 55."] = "",

	-- Step 6: High Executor Derrington
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "Você perdeu isto na visita anterior da rota a esta região: vem primeiro agora. É rápido e abre as missões seguintes.\nPegue {object:176092} no caixote ao lado de Arcabuz para {quest:5096}.",

	-- Step 7: Scarlet forward camp
	["Scarlet forward camp"] = "Acampamento avançado Escarlate",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "De {area:152}, siga a estrada para leste até {zone:1422}. As barracas da Cruzada Escarlate ficam logo depois da Fazenda Pedravil, entre {area:199} e {area:200}. Incendeie a barraca de comando com a {object:176092} e finque o estandarte do Flagelo. Cuidado: os Escarlates em volta das barracas chegam ao nível 54 e os Invocadores lançam feitiços: chegue pelo lado mais próximo da barraca de comando e deixe os outros em paz.",

	-- Step 8: The Bulwark
	-- {area:152} The Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Cavalgue para sudoeste, passando pela fazenda Pedravil, e siga a estrada para o oeste de volta a {area:152}.",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "As torres de vigia de Arcabuz e o caldeirão de Vandis ficam para uma visita posterior: guarde-as.",

	-- Step 10: Paladin trainer
	["Paladin trainer"] = "Instrutor de paladino",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152} em {zone:1420}; {zone:1454} não tem instrutor de paladino",

	-- Step 11: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 12: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "O centro de {zone:1454}",

	-- Step 13: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659} recebe as garras de ravassauro de Un'Goro; ele fica no {object:172960}, a uma curta caminhada do centro da cidade.",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 14: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Voe para {area:1237}",
	-- {zone:1447} Azshara · {zone:1454} Orgrimmar
	["{zone:1447} is a short flight from {zone:1454}: its quests are 51-55, at your level now."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 15: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, uma varinha dos arcanistas elfos sangrentos",

	-- Step 16: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: vá matando estes pelo caminho",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Siga para o leste até as ruínas na costa. As quatro tábuas estão entre as ruínas, guardadas por nagas Açoitadores (52-55): puxe um de cada vez.",

	-- Step 17: Ruins of Eldarath
	-- {area:1231} Southridge Beach
	["Fill Cuely's four vials at the tide pools on the shore, from {area:1231} north up the coast; Spitelash naga patrol between them."] = "",
	-- {item:10691} Filled Vial Labeled #1 · {area:1231} Southridge Beach
	["{item:10691}: the tide pool on {area:1231}"] = "",
	["#2, north along the shore"] = "",

	-- Step 18: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Escavadores Makrinni",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Os Escavadores Makrinni (50-51) cavam nas areias logo a leste das ruínas, no caminho para nordeste; eles e os esconderijos enterrados ali fornecem os Fragmentos de Tesouro Altaneiro.",

	-- Step 19: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Continue para nordeste pelo centro de {zone:1447}: {npc:235903} acampa junto à estrada.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, os sátiros ao norte do acampamento dos elfos sangrentos",

	-- Step 20: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Siga para nordeste até o acampamento do goblin nos penhascos acima da {area:1227}, logo ao norte dos elfos sangrentos.",

	-- Step 21: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Os elfos sangrentos acampam nos penhascos a nordeste, junto à {area:1227}. As quatro peças de equipamento de {npc:8420} estão nos caixotes em volta do acampamento; os Arcanistas Elfos Sangrentos carregam a varinha de {npc:247473}.\nCuidado: um {npc:250023}, elite de nível 55-57, fica na borda oeste do acampamento: enfrente os elfos sangrentos pelo lado leste dele.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, dos Arcanistas Elfos Sangrentos",

	-- Step 22: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "O acampamento da {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "O acampamento de Rimtori fica no extremo leste do acampamento-base. Leia o {object:151286} lá: no Forever, o Tomo Sin'dorei ao lado pede então os selos dos três oficiais do acampamento.",

	-- Step 23: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Cada um dos três oficiais do acampamento (53) carrega um selo: {npc:247006} no centro do acampamento, {npc:247013} no extremo leste e {npc:246991}, que patrulha a metade oeste: enfrente-o no lado leste da patrulha, onde a Seta aponta.\nCuidado: o {npc:250023}, elite de nível 55-57, fica na borda oeste do acampamento, perto do fim da patrulha de Hawkhelm: espere Hawkhelm voltar para o leste.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, de {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, de {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, de {npc:247013}",

	-- Step 24: Magus Rimtori
	-- {npc:8578} Magus Rimtori
	["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Rimtori is level 55, and which crystal is linked to him is random: each of the other two summons a hostile infernal instead. Start at full health."] = "",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: para {npc:8587} em {area:1237}",

	-- Step 25: The Legashi satyrs
	["The Legashi satyrs"] = "Os sátiros Legashi",
	-- {npc:235903} Ekkal · {npc:235892} Prince Halanox
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind.\nCareful: {npc:235892} (55, elite) stands among the satyrs at the north-east end of their hills, around 67,19: take the satyrs nearer the camp and leave him be."] = "",

	-- Step 26: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "Volte para noroeste até {npc:8420}.",

	-- Step 27: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Siga para o sul até a borda norte das {area:1221}. As Sirenas e os Mirmidões Iralisca (50-52) dali carregam a runa de {npc:8420}; ela não cai com frequência, então avance pela borda até conseguir.",

	-- Step 28: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "Volte para o norte até {npc:8420} com a runa e depois siga para sudoeste pela estrada.",

	-- Step 29: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "Para sudoeste pela estrada: {npc:235903} recebe os sátiros.",

	-- Step 30: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Volte para oeste até {area:1237}.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, para {npc:4485} em {zone:1454}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: o tomo vai para {npc:3326} em {zone:1454}",
	-- {npc:8659} Jes'rimon · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {npc:6522} Andron Gant · {zone:1458} Undercity
	["Keep the deliveries: {npc:8659}, {npc:4485} and {npc:3326} are in {zone:1454} next, Magatha in {zone:1456} and {npc:6522} in the {zone:1458} on the next guides."] = "",

	-- Step 31: Sanath Lim-yo
	-- {area:1237} Valormok · {npc:8379} Archmage Xylem
	["Ride east from {area:1237} to Sanath's camp at the foot of the cliff and get off your mount: he teleports you up to {npc:8379}'s tower."] = "",

	-- Step 32: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "O aprendiz no alto da torre manda você de volta para baixo.",
	["Upstairs"] = "No andar de cima",

	-- Step 34: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Mestre de voo de {area:1237}",

	-- Step 35: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3326} Zevrost · {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- {npc:8659} Jes'rimon · {npc:8587} Jediga
	["{npc:8659}: his payment goes back to {npc:8587}, on the flight out"] = "",

	-- Step 36: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 37: Druid trainer
	["Druid trainer"] = "Instrutor de druida",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} em {zone:1412}; {zone:1454} não tem instrutor de druida",

	-- Step 38: Fly to Valormok
	-- {zone:1448} Felwood · {area:1237} Valormok · {npc:8587} Jediga · {npc:8659} Jes'rimon · {area:431} Splintertree Post
	["{zone:1448} is next: fly by way of {area:1237}, where {npc:8587} takes {npc:8659}'s payment, then on to {area:431}."] = "",

	-- Step 40: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Voe para {area:431}",

	-- Step 42: Emerald Sanctuary
	["The druids' camp is just past the border."] = "O acampamento dos druidas fica logo depois da fronteira.",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}, ao lado de {npc:10921}: {quest:86577}, os órgãos dos ursos e lobos de {zone:1448}",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, na borda sul do acampamento",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}, no lado oeste do acampamento",

	-- Step 43: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "A aldeia dos furbolgs Lenha Morta fica logo ao sul do Santuário. Cada morte de Lenha Morta também aumenta sua reputação com {area:1769}; guarde as penas de cocar.",

	-- Step 44: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Sul de {area:1763}",
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: pull the cultists and hounds away from him."] = "",

	-- Step 46: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "O poço lunar de {area:1763}",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "De volta ao norte, até {area:1763}. Encha o cantil de Greta no poço lunar corrompido no meio do acampamento do sul.",

	-- Step 47: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "O acampamento da Horda logo ao norte de {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: os corujursos ficam em {zone:1452}",

	-- Step 48: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "A leste do Posto Peçonha, o vale de crateras onde vagam as Feras e os Horrores Entrópicos. Mate dois de cada, depois vá até cada uma das três crateras de água vil.",
	["Southern crater"] = "Cratera do sul",
	["Western crater"] = "Cratera do oeste",
	["Northern crater"] = "Cratera do norte",

	-- Step 49: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "A Estátua de Malorne fica logo ao sul do vale, junto à estrada para o norte: o bibelô dela inicia uma missão para {npc:9996} em {area:1997}.",

	-- Step 50: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber · {npc:10920} Kelek Skykeeper
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	-- was: ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Siga a estrada para nordeste até {area:1767}. Os Rasgamusgos e Retalhadores Lenhatorta do lado leste da mata levam cada um um {item:11503}; Ursos-cinzentos Garraivosos e Assoladores Patavil vagam pela mesma mata para Talo."
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958}, dos ursos Garraivosos",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959}, dos lobos Patavil",

	-- Step 51: Irontree Woods
	["Below ground"] = "No subterrâneo",

	-- Step 52: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {quest:6031} Runecloth · {area:1769} Timbermaw Hold
	["Only from Friendly with the Timbermaw: {npc:11557}, in the tunnel near its {zone:1448} mouth, gives {quest:6031} then (the {area:1769} reputation guide gets you there)."] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; below ground"] = "",

	-- Step 53: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "A estrada termina em {npc:15395}, do lado de fora do túnel de {area:1769}, no extremo nordeste.",

	-- Step 54: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nIf one drops a {quest:8470} (about one kill in thirty), right-click it; don't stay to farm one. {npc:11558} in {area:1769} takes it only from Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): now if they already are, or on the last guide's pass of the cave."] = "",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop from the Deadwood furbolgs"] = "",

	-- Step 55: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Guarde {quest:8465} para {zone:1452}.",

	-- Step 56: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She speaks to you only from Neutral with the Timbermaw."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} anda por aqui: procure dentro do círculo no mapa",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "Caiu uma {item:13140}: use-a para iniciar a missão e depois liberte {npc:11018} da jaula dela em {area:1770}, a caverna no extremo norte de {area:1763}.",
	-- ["Back at the {area:2479}."] = "De volta a {area:2479}.",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "De volta a {area:1762}, os furbolgs Lenha Morta (53-54) ficam perto do túnel e cada morte aumenta sua reputação com os Presamatos.",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Cuidado: os Vigias do Covil têm nível 53-54 e os Vingadores de Lenha Morta 54-55; chamam aliados num raio de 25 m quando ficam abaixo de 50% de vida e fogem atrás de ajuda abaixo de 15%.\nContinue matando-os até um soltar {quest:8470}, cerca de uma morte em trinta, e então clique nele com o botão direito: {npc:11558}, em {area:1769}, aceita-o quando os Presamatos estiverem Neutros com você, agora, se já estiverem, ou quando o último guia passar pela caverna de novo no nível 59.",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Cuidado: os Vigias do Covil são nível 53-54; chamam aliados num raio de 25 metros quando ficam abaixo de 50% de vida e saem correndo atrás de ajuda abaixo de 15%.",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Cuidado: os Vigias do Covil têm nível 53-54; chamam aliados num raio de 25 m quando ficam abaixo de 50% de vida e fogem atrás de ajuda abaixo de 15%.\nAbaixo do nível 54.54, continue lutando contra os Lenha Morta aqui depois da contagem de {npc:15395}: as entregas em {area:1769} e em {area:2479} levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Cuidado: os Vigias do Covil têm nível 53-54; chamam aliados num raio de 25 m quando ficam abaixo de 50% de vida e fogem atrás de ajuda abaixo de 15%.\nAbaixo do nível 54.54, continue lutando contra os Lenha Morta aqui depois da contagem de {npc:15395}: as entregas em {area:1769} e em {area:2479} levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.\nContinue matando-os até um soltar {quest:8470}, cerca de uma morte em trinta, e então clique nele com o botão direito: {npc:11558}, em {area:1769}, aceita-o quando os Presamatos estiverem Neutros com você, agora, se já estiverem, ou quando o último guia passar pela caverna de novo no nível 59.",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "Atravesse o rio para o leste até {area:2627}, a cidade em ruínas no noroeste de {zone:1423}. {npc:12384} fica numa cabana na borda dela.",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "As torres de vigia de Arcabuz, o caldeirão de Vandis e o barril de {npc:11615} ficam para uma visita posterior: guarde-as.",
	-- ["Diseased Grizzlies"] = "Ursos-cinzentos Doentes",
	-- ["Fly to the {area:1497}"] = "Voe para {area:1497}",
	-- ["Fly to {area:272}"] = "Voe para {area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Siga a estrada para nordeste até {area:1767}. Os Rasgamusgo e Retalhadores Lenhatorta do lado leste da mata carregam cada um {item:11503}; Ursos-cinzentos Garraivosos e Assoladores Patavil andam pela mesma mata para Talo, e os órgãos deles são para {npc:10920}.\nOs Vigias do Covil de Lenha Morta (53-54) e os Vingadores (54-55) de {area:1762} vêm a seguir: abaixo do nível 54, continue caçando os ursos-cinzentos e os assoladores (51-52) aqui até o 54. As entregas seguintes em {area:1769}, em {area:2479} e em {area:1997} levam você quase até o nível 55. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:1584}.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Siga a estrada para nordeste até {area:1767}. Os Rasgamusgos e Retalhadores Lenhatorta do lado leste da mata levam cada um um {item:11503}; Ursos-cinzentos Garraivosos e Assoladores Patavil vagam pela mesma mata para Talo.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Siga a estrada para nordeste até {area:1767}. Os Rasgamusgo e Retalhadores Lenhatorta do lado leste da mata carregam cada um {item:11503}; Ursos-cinzentos Garraivosos e Assoladores Patavil andam pela mesma mata para Talo. Abaixo do nível 54.21, continue caçando os ursos-cinzentos e os assoladores: as entregas em {area:1997} e em {area:2479} levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
	-- ["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Siga a estrada para noroeste. O sul de {area:1763}, em volta do poço lunar corrompido, é ocupado por sectários, adeptos, guardas e cães do Shadow Council.",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "Do mestre de voo de {area:2268}, voe para {area:1497}.",
	-- ["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "A próxima caçada dele, os Ursos-cinzentos Enfermos (55-56), fica para a visita às Terras Pestilentas por volta do nível 58.",
	-- ["Jadefire moonwell"] = "Poço lunar Flamejade",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "Guarde A pequena Pâmela: a Pâmela fica em {area:2262}, que você visita de novo mais tarde.",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "Guarde o galho: {npc:5770} está em {zone:1456}.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Guarde o embrulho: {npc:10781} está em {area:1497}.",
	-- ["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "Guarde {quest:5142}: Pâmela está em {area:2262}, visitada de novo mais tarde.",
	-- ["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Guarde {quest:5158}: {npc:5901} está em {zone:1413}.",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "Guarde {quest:6164}: {npc:12384} o recebe de volta na parada de {area:2627} do guia de {zone:1423}.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Cavaleiros e magos trabalham em {area:192}; os socorristas e caçadores acampam ao sul dele.",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Saia de {area:1497} e cavalgue para o leste pela estrada através de {zone:1420}, passando por {area:152}. A fazenda Pedravil é a primeira ao longo da estrada; {npc:10778} espera na casa.",
	-- ["Level 52.63"] = "Nível 52.63",
	-- ["Level 53"] = "Nível 53",
	-- ["Level 53.02"] = "Nível 53.02",
	-- ["Level 53.2"] = "Nível 53.2",
	-- ["Level 53.34"] = "Nível 53.34",
	-- ["Level 54.1"] = "Nível 54.1",
	-- ["Level 54.45"] = "Nível 54.45",
	-- ["Level 54.54"] = "Nível 54.54",
	-- ["Level 54.7"] = "Nível 54.7",
	-- ["Level 54.87"] = "Nível 54.87",
	-- ["Level 55"] = "Nível 55",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "Só com 5 Penas do Cocar de Lenha Morta",
	-- ["Radley and Durgen"] = "Eiras e Durgen",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Cavalgue de volta para o sul, passando por {area:1763}, até o poço lunar corrompido dos sátiros Flamejade, e encha ali o frasquinho de {npc:9996}.",
	-- ["Ride back south-east to the Sanctuary."] = "Cavalgue de volta para sudeste até o Santuário.",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Volte a {area:1497}, pegue o zepelim para {zone:1454} e voe para {area:431}. Siga a estrada para o oeste saindo do Posto Machadada e pegue a bifurcação para o norte até {zone:1448}.",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Cavalgue de volta para o oeste atravessando o rio e siga até {area:192}; {npc:11610} se esconde na colina a nordeste dele.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Siga para leste até as ruínas na costa. Encha os quatro frascos de Cuely nas poças de maré ao longo da praia; nagas Iralisca patrulham entre elas.",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Cavalgue para o norte pelas colinas do leste; {npc:1855} mora numa casinha junto a {area:2619}, na fronteira com {zone:1423}.",
	-- ["Ride north up the road again."] = "Cavalgue de novo para o norte pela estrada.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cavalgue para noroeste até Andorhal. {npc:10667} espera na estalagem em ruínas do lado oeste da cidade; os esqueletos lá dentro são 54-57, então fique pelas bordas.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Cavalgue para o sul, passando por {area:202}, até {area:197}; a casa de {npc:10927} fica junto à estrada, e o monumento de {npc:10936} está no cemitério atrás dela. Mate os Lobos Doentes que encontrar nos campos pelo caminho.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "Siga a estrada para o sul através de {area:361} até o Santuário.",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "Siga a estrada para o sul através de {zone:1448} até o Santuário.",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Cavalgue para o oeste até {area:192}; {npc:11610} se esconde na colina a nordeste dele.",
	-- ["Ror stands at the far south end of {area:1761}."] = "Ror fica no extremo sul de {area:1761}.",
	-- ["Scarlet Crusade"] = "Cruzada Escarlate",
	-- ["Scarlet forward camp"] = "Acampamento avançado Escarlate",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Entre na caverna: {npc:11558} fica logo na entrada.",
	-- ["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Leve o gatinho ao mesmo poço lunar e solte-o ali com {item:12565}; quando ele virar um {npc:10042}, leve-o de volta a {npc:9996} e clique nele para entregá-lo.",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Leve o gatinho ao mesmo poço lunar e solte-o ali; quando ele virar um {npc:10042}, leve-o de volta a {npc:9996} e clique nele para entregá-lo.",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Os Anais estão entre os Tomos Mofados na prefeitura de Andorhal; abra-os até achar o certo.",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "A aldeia dos furbolgs Lenha Morta, logo a oeste do túnel. {npc:9462} (56) fica entre eles. {npc:11557}, um furbolg amistoso, fica no extremo norte da aldeia.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "A aldeia dos furbolgs Lenha Morta fica logo ao sul do Santuário. Cada morte de Lenha Morta também aumenta sua reputação com {area:1769}; guarde as penas de cocar.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "A vila dos furbolgs de Lenha Morta fica logo ao sul do Santuário. Toda morte de Lenha Morta também aumenta sua reputação com {area:1769}; guarde as penas de cocar. Continue matando-os até o nível 53.92: as próximas entregas do Santuário e {area:1763} exigem isso. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:1584}.",
	-- ["The Jadefire moonwell"] = "O poço lunar Flamejade",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Os sátiros Legashi (51-52) ocupam as colinas ao norte do acampamento dos elfos sangrentos: {npc:235903} quer cinco de cada tipo.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "As barracas da Cruzada Escarlate ficam entre {area:199} e {area:200}. Incendeie a barraca de comando com a {object:176092} e finque o estandarte do Flagelo.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "Os ursos vagam pelas colinas ao norte e a leste de {area:202}.",
	-- ["The bears roam the hills north and east of the {area:202}. Below level 53.02, keep hunting them after the eighth: the hand-ins at the {area:202} take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Os ursos andam pelas colinas ao norte e a leste de {area:202}. Abaixo do nível 53.02, continue caçando-os depois do oitavo: as entregas em {area:202} levam você ao nível 54. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:1584}.",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "O livro fica na estalagem em ruínas de {area:2627}; os mortos-vivos da cidade são nível 54-56, então puxe-os um de cada vez.\nOs Grandes Cupinzeiros ficam espalhados pelas colinas a leste de {area:2627}. Use o {item:15042} em cada cupinzeiro por que passar.",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "A súcubo {npc:9518} espera no meio de {area:1763}, ao lado de {npc:11020}.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Os lobos vagam pelos campos entre Andorhal, {area:200} e {area:202}. Termine-os na volta para o leste.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "Através de {area:1769}",
	-- ["To {zone:1448}"] = "Para {zone:1448}",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complete aqui até o nível 52.63 antes das entregas em {area:200}: elas levam você ao nível 53. Os Espreitadores Carniceiros (52-53) a oeste do acampamento Escarlate estão no seu nível; os Magos e Cavaleiros Escarlates (54-56) são de nível mais alto. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Complete aqui até o nível 53 antes que {npc:10739} mande você atrás dos Ursos-cinzentos Doentes (55-56): os Espreitadores Carniceiros (52-53) no caminho de {area:200} para {area:202} estão no seu nível. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:1584}.",
	-- ["Top up here to level 53.02 before the hand-ins at {area:202}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Complete aqui até o nível 53.02 antes das entregas em {area:202}: elas levam você ao nível 54. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:1584}.",
	-- ["Top up here to level 53.2 before the hand-ins at {area:152}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Complete aqui até o nível 53.2 antes das entregas em {area:152}: elas levam você ao nível 54. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:1584}.",
	-- ["Top up here to level 53.34 before the hand-ins at {area:1763}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Complete aqui até o nível 53.34 antes das entregas em {area:1763}: elas levam você ao nível 54. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:1584}.",
	-- ["Top up here to level 54.1 before the hand-ins at {area:361}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Complete aqui até o nível 54.1 antes das entregas em {area:361}: elas levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
	-- ["Top up here to level 54.45 before the hand-ins at {area:1769}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Complete aqui até o nível 54.45 antes das entregas em {area:1769}: elas levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
	-- ["Top up here to level 54.54 before the hand-ins at {area:2479}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Complete aqui até o nível 54.54 antes das entregas em {area:2479}: elas levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
	-- ["Top up here to level 54.7 before the hand-ins at {area:1997} : they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Complete aqui até o nível 54.7 antes das entregas em {area:1997}: elas levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
	-- ["Top up here to level 54.87 before the hand-ins in {zone:1452}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Complete aqui até o nível 54.87 antes das entregas em {zone:1452}: elas levam você ao nível 55. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Entre no túnel de {area:1769} ao lado de {npc:15395} e nunca ataque os furbolgs Presamatos lá dentro. O túnel dá em {zone:1452}; siga a estrada para o leste até {area:2255}, a cidade goblin onde o próximo guia começa.",
	-- ["Walk {npc:11018} out of {area:1770} and keep her alive until she is out of the cave."] = "Leve {npc:11018} para fora de {area:1770} e mantenha-a viva até ela sair da caverna.",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "mate Vingadores de Lenha Morta em {area:1762}, {zone:1448}",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "mate Cavaleiros Escarlates em {area:192}, {zone:1422}",
	-- ["grind on {npc:10605}"] = "mate {npc:10605} até subir",
	-- ["grind on {npc:1816}"] = "mate {npc:1816} até subir",
	-- ["grind on {npc:1817}"] = "mate {npc:1817} até subir",
	-- ["grind on {npc:1821}"] = "mate {npc:1821} até subir",
	-- ["grind on {npc:7101}"] = "mate {npc:7101} até subir",
	-- ["grind on {npc:7125}"] = "mate {npc:7125} até subir",
	-- ["grind on {npc:7153}"] = "mate {npc:7153} até subir",
	-- ["grind on {npc:7155}"] = "mate {npc:7155} até subir",
	-- ["grind on {npc:7156}"] = "mate {npc:7156} até subir",
	-- ["grind on {npc:7157}"] = "mate {npc:7157} até subir",
	-- ["grind on {npc:8957}"] = "mate {npc:8957} até subir",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Os Escarlates de {area:190} são de nível 58-60. Entre até o ponto alto marcado no seu mapa, observe a cidade e saia.",
	-- ["{area:2268} flight master"] = "Mestre de voo de {area:2268}",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}: mate estes conforme os encontrar",
	-- ["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, no poço lunar Flamejade",
	-- ["{npc:10840} stands at the south end of the {area:197} graveyard, where the road from {area:272} comes in."] = "{npc:10840} fica na ponta sul do cemitério de {area:197}, onde chega a estrada vinda de {area:272}.",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, no extremo sul do cemitério",
	-- ["{npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it."] = "A casa de {npc:10927} fica junto à estrada, e o monumento de {npc:10936} está no cemitério atrás dela.",
	-- ["{npc:10927}, upstairs"] = "{npc:10927}, no andar de cima",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, no subterrâneo",
	-- ["{npc:11018}, below ground"] = "{npc:11018}, no subterrâneo",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, no subterrâneo",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: guarde 30 {quest:6031} para ele; ele só negocia a partir de Neutro com os Presamatos",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}: guarde 30 {quest:6031} para ele; ele só negocia a partir de Neutro com os Presamatos; no subterrâneo",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, na entrada do túnel",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: os Presamatos só falam com você a partir de Neutro; anda por aqui: procure dentro do círculo no mapa",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "A última tarefa de {npc:11610} exige nível 53. Os Cavaleiros e Magos Escarlates (54-55) que trabalham no acampamento madeireiro logo a sudoeste dela são o acampamento mais próximo.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} fica a leste do acampamento madeireiro; {npc:11611} guarda a estrada a nordeste de {npc:11610}, rumo a {area:190}.",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "As caçadas de {npc:1855} ficam em {zone:1423}: guarde-as para depois.",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}, logo a oeste do acampamento",
	-- ["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, no lado oeste do Santuário",
	-- ["{npc:9996}'s kitten"] = "O gatinho da {npc:9996}",
	-- ["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- ["{object:175894}, beside the house"] = "{object:175894}, ao lado da casa",
	-- ["{object:175924}, inside"] = "{object:175924}, lá dentro",
	-- ["{quest:5058}, inside"] = "{quest:5058}, lá dentro",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} vai para {area:2268}: guarde-a para depois.",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}: os mortos-vivos de {area:2627} as deixam cair enquanto você usa a {item:12846}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, um saque raro",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "As missões de {zone:1452} são de nível 55-58. Abaixo do 55 depois das entregas a {npc:9996}? Os furbolgs Lenha Morta (53-55) de {area:1762} estão no seu nível e no caminho para o túnel de {area:1769}, ao norte: mate-os até o nível 55. Cada morte também aumenta sua reputação com os Presamatos. Cuidado: os Vigias do Covil e os Vingadores chamam aliados próximos abaixo de metade da vida e fogem atrás de ajuda quando quase mortos: puxe um de cada vez pela borda da vila. É um complemento longo para quem segue só esta rota. Ou, em grupo, faça a masmorra {area:1584} ou a masmorra {area:1417}.",
}
