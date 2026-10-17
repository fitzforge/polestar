-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
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
	-- {area:2268} Light's Hope Chapel · {area:1497} Undercity
	["From {area:2268}'s flight master, fly to the {area:1497}."] = "Do mestre de voo de {area:2268}, voe para {area:1497}.",

	-- Step 2: Janice Felstone
	-- {area:1497} Undercity · {zone:1420} Tirisfal Glades · {area:152} Bulwark · {npc:10778} Janice Felstone
	["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Saia de {area:1497} e cavalgue para o leste pela estrada através de {zone:1420}, passando por {area:152}. A fazenda Pedravil é a primeira ao longo da estrada; {npc:10778} espera na casa.",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house"] = "{object:175894}, ao lado da casa",
	-- {npc:10781} Royal Overseer Bauhaus · {area:1497} Undercity
	["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Guarde o embrulho: {npc:10781} está em {area:1497}.",

	-- Step 3: Scarlet forward camp
	["Scarlet forward camp"] = "Acampamento avançado Escarlate",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "As barracas da Cruzada Escarlate ficam entre {area:199} e {area:200}. Incendeie a barraca de comando com a {object:176092} e finque o estandarte do Flagelo.",

	-- Step 4: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Casa da fazenda de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "O diário fica na casa da fazenda, o armário fica lá dentro e a casinha fica atrás dela. Um {npc:10816} leva a chave da casinha; {npc:10836} sai quando você abre a casinha e leva a chave do armário.",

	-- Step 5: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Ele acampa junto a {area:202}, a sudeste de {area:200}.",

	-- Step 6: Sorrow Hill
	-- {area:202} Writhing Haunt · {area:197} Sorrow Hill · {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Cavalgue para o sul, passando por {area:202}, até {area:197}; a casa de {npc:10927} fica junto à estrada, e o monumento de {npc:10936} está no cemitério atrás dela. Mate os Lobos Doentes que encontrar nos campos pelo caminho.",
	-- {npc:10840} Argent Officer Pureheart
	["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, no extremo sul do cemitério",
	-- {quest:5142} Little Pamela · {area:2262} Darrowshire
	["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "Guarde {quest:5142}: Pâmela está em {area:2262}, visitada de novo mais tarde.",

	-- Step 7: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cavalgue para noroeste até Andorhal. {npc:10667} espera na estalagem em ruínas do lado oeste da cidade; os esqueletos lá dentro são 54-57, então fique pelas bordas.",

	-- Step 8: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Os Anais estão entre os Tomos Mofados na prefeitura de Andorhal; abra-os até achar o certo.",

	-- Step 9: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} vai para {area:2268}: guarde-a para depois.",

	-- Step 10: Diseased Wolves
	["Diseased Wolves"] = "Lobos Doentes",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Os lobos vagam pelos campos entre Andorhal, {area:200} e {area:202}. Termine-os na volta para o leste.",

	-- Step 12: Diseased Grizzlies
	["Diseased Grizzlies"] = "Ursos-cinzentos Doentes",
	-- {area:202} Writhing Haunt
	["The bears roam the hills north and east of the {area:202}."] = "Os ursos vagam pelas colinas ao norte e a leste de {area:202}.",

	-- Step 13: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "Guarde o galho: {npc:5770} está em {zone:1456}.",

	-- Step 14: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Cavalgue para o norte pelas colinas do leste; {npc:1855} mora numa casinha junto a {area:2619}, na fronteira com {zone:1423}.",
	-- {npc:1855} Tirion Fordring · {zone:1423} Eastern Plaguelands
	["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "As caçadas de {npc:1855} ficam em {zone:1423}: guarde-as para depois.",

	-- Step 15: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Cavalgue para o oeste até {area:192}; {npc:11610} se esconde na colina a nordeste dele.",

	-- Step 16: Scarlet Crusade
	["Scarlet Crusade"] = "Cruzada Escarlate",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Cavaleiros e magos trabalham em {area:192}; os socorristas e caçadores acampam ao sul dele.",

	-- Step 18: Radley and Durgen
	["Radley and Durgen"] = "Eiras e Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} fica a leste do acampamento madeireiro; {npc:11611} guarda a estrada a nordeste de {npc:11610}, rumo a {area:190}.",

	-- Step 20: Northridge Lumber Camp
	-- {npc:11610} Kirsta Deepshadow
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "A última tarefa de {npc:11610} exige nível 53. Os Cavaleiros e Magos Escarlates (54-55) que trabalham no acampamento madeireiro logo a sudoeste dela são o acampamento mais próximo.",
	-- {area:192} Northridge Lumber Camp · {zone:1422} Western Plaguelands
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "mate Cavaleiros Escarlates em {area:192}, {zone:1422}",

	-- Step 22: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Os Escarlates de {area:190} são de nível 58-60. Entre até o ponto alto marcado no seu mapa, observe a cidade e saia.",

	-- Step 24: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Cavalgue para sudoeste, passando pela fazenda Pedravil, e siga a estrada para o oeste de volta a {area:152}.",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "As torres de vigia de Arcabuz, o caldeirão de Vandis e o barril de {npc:11615} ficam para uma visita posterior: guarde-as.",

	-- Step 25: To Felwood
	-- {zone:1448} Felwood
	["To {zone:1448}"] = "Para {zone:1448}",
	-- {area:1497} Undercity · {zone:1454} Orgrimmar · {area:431} Splintertree Post · {zone:1448} Felwood
	["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Volte a {area:1497}, pegue o zepelim para {zone:1454} e voe para {area:431}. Siga a estrada para o oeste saindo do Posto Machadada e pegue a bifurcação para o norte até {zone:1448}.",

	-- Step 26: Emerald Sanctuary
	["The druids' camp is just past the border."] = "O acampamento dos druidas fica logo depois da fronteira.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "{npc:9529}, logo a oeste do acampamento",

	-- Step 27: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Sul de {area:1763}",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Siga a estrada para noroeste. O sul de {area:1763}, em volta do poço lunar corrompido, é ocupado por sectários, adeptos, guardas e cães do Shadow Council.",

	-- Step 28: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "Só se uma {item:13140} tiver caído: use-a para iniciar a missão, depois liberte {npc:11018} da jaula em {area:1770}, a caverna no extremo norte de {area:1763}, e escolte-a para fora.",

	-- Step 29: Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "Cavalgue de volta para sudeste até o Santuário.",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, na borda sul do acampamento",

	-- Step 30: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "A aldeia dos furbolgs Lenha Morta fica logo ao sul do Santuário. Cada morte de Lenha Morta também aumenta sua reputação com {area:1769}; guarde as penas de cocar.",

	-- Step 31: Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "Só com 5 Penas do Cocar de Lenha Morta",

	-- Step 32: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "O poço lunar de {area:1763}",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "De volta ao norte, até {area:1763}. Encha o cantil de {npc:10922} no poço lunar corrompido no meio do acampamento do sul.",

	-- Step 33: Rakaiah
	-- {npc:11018} Arko'narin · {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Só se você resgatou {npc:11018}: a súcubo {npc:9518} espera no meio de {area:1763}, ao lado de {npc:11020}.",

	-- Step 34: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "O acampamento da Horda logo ao norte de {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: os corujursos ficam em {zone:1452}",

	-- Step 35: The Jadefire moonwell
	["The Jadefire moonwell"] = "O poço lunar Flamejade",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Cavalgue de volta para o sul, passando por {area:1763}, até o poço lunar corrompido dos sátiros Flamejade, e encha ali o frasquinho de {npc:9996}.",

	-- Step 37: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "O gatinho da {npc:9996}",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Leve o gatinho ao mesmo poço lunar e solte-o ali; quando ele virar um {npc:10042}, leve-o de volta a {npc:9996} e clique nele para entregá-lo.",
	["Jadefire moonwell"] = "Poço lunar Flamejade",

	-- Step 39: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "A leste do Posto Peçonha, o vale de crateras onde vagam as Feras e os Horrores Entrópicos. Mate dois de cada, depois vá até cada uma das três crateras de água vil.",
	["Southern crater"] = "Cratera do sul",
	["Western crater"] = "Cratera do oeste",
	["Northern crater"] = "Cratera do norte",

	-- Step 40: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Siga a estrada para nordeste até {area:1767}. Os Rasgamusgos e Retalhadores Lenhatorta do lado leste da mata levam cada um um {item:11503}; Ursos-cinzentos Garraivosos e Assoladores Patavil vagam pela mesma mata para Talo.",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "A estrada termina em {npc:15395}, do lado de fora do túnel de {area:1769}, no extremo nordeste.",

	-- Step 42: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "A aldeia dos furbolgs Lenha Morta, logo a oeste do túnel. {npc:9462} (56) fica entre eles. {npc:11557}, um furbolg amistoso, fica no extremo norte da aldeia.",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: guarde 30 {quest:6031} para ele; ele só negocia a partir de Neutro com os Presamatos",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, um saque raro",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Guarde {quest:8465} para {zone:1452}.",

	-- Step 44: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "Siga a estrada para o sul através de {zone:1448} até o Santuário.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, no lado oeste do Santuário",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Guarde {quest:5158}: {npc:5901} está em {zone:1413}.",

	-- Step 45: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "Ror fica no extremo sul de {area:1761}.",

	-- Step 46: Bloodvenom Post
	["Ride north up the road again."] = "Cavalgue de novo para o norte pela estrada.",

	-- Step 47: Felpaw Village
	-- {area:1762} Felpaw Village
	["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "De volta a {area:1762}, os furbolgs Lenha Morta (53-54) ficam perto do túnel e cada morte aumenta sua reputação com os Presamatos.",
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "mate Vingadores de Lenha Morta em {area:1762}, {zone:1448}",
	-- {npc:11558} Kernda
	["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, na entrada do túnel",

	-- Step 48: Through Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Through {area:1769}"] = "Através de {area:1769}",
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien · {zone:1452} Winterspring · {area:2255} Everlook
	["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Entre no túnel de {area:1769} ao lado de {npc:15395} e nunca ataque os furbolgs Presamatos lá dentro. O túnel dá em {zone:1452}; siga a estrada para o leste até {area:2255}, a cidade goblin onde o próximo guia começa.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:152}"] = "{area:152}",
}
