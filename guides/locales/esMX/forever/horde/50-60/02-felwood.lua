-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:2268} Light's Hope Chapel · {area:1497} Undercity
	["From {area:2268}'s flight master, fly to the {area:1497}."] = "Desde el maestro de vuelo de {area:2268}, vuela a {area:1497}.",

	-- Step 2: Janice Felstone
	-- {area:1497} Undercity · {zone:1420} Tirisfal Glades · {area:152} Bulwark · {npc:10778} Janice Felstone
	["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Sal de {area:1497} y cabalga al este por el camino a través de {zone:1420}, pasando {area:152}. La granja de Piedramácula es la primera granja del camino; {npc:10778} espera en la casa.",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house"] = "{object:175894}, junto a la casa",
	-- {npc:10781} Royal Overseer Bauhaus · {area:1497} Undercity
	["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Guarda el paquete: {npc:10781} está en {area:1497}.",

	-- Step 3: Scarlet forward camp
	["Scarlet forward camp"] = "Campamento avanzado Escarlata",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Las tiendas de la Cruzada Escarlata están entre {area:199} y {area:200}. Quema la tienda de mando con {object:176092} y planta el estandarte de la Plaga.",

	-- Step 4: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Granja de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "El diario está en la granja, el armario está dentro y el retrete está detrás. Un {npc:10816} lleva la llave del retrete; {npc:10836} sale cuando abres el retrete y lleva la llave del armario.",

	-- Step 5: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Acampa junto a {area:202}, al sureste de {area:200}.",

	-- Step 6: Sorrow Hill
	-- {area:202} Writhing Haunt · {area:197} Sorrow Hill · {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Cabalga al sur pasando {area:202} hasta {area:197}; la casa de {npc:10927} está junto al camino, y el monumento de {npc:10936} está en el cementerio detrás. Mata los lobos malsanos que encuentres en los campos por el camino.",
	-- {npc:10840} Argent Officer Pureheart
	["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, en el extremo sur del cementerio",
	-- {quest:5142} Little Pamela · {area:2262} Darrowshire
	["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "Guarda {quest:5142}: Pamela está en {area:2262}, que visitarás de nuevo más adelante.",

	-- Step 7: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cabalga al noroeste hacia Andorhal. {npc:10667} espera en la posada en ruinas del lado oeste del pueblo; los esqueletos de dentro son de nivel 54-57, así que no te alejes de los bordes.",

	-- Step 8: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Las Crónicas están entre los libros enmohecidos del ayuntamiento de Andorhal; ábrelos hasta encontrar el correcto.",

	-- Step 9: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} va a {area:2268}: guárdala para más adelante.",

	-- Step 10: Diseased Wolves
	["Diseased Wolves"] = "Lobos malsanos",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Los lobos deambulan por los campos entre Andorhal, {area:200} y {area:202}. Termínalos en el camino de vuelta al este.",

	-- Step 12: Diseased Grizzlies
	["Diseased Grizzlies"] = "Osos pardos malsanos",
	-- {area:202} Writhing Haunt
	["The bears roam the hills north and east of the {area:202}."] = "Los osos deambulan por las colinas al norte y al este de {area:202}.",

	-- Step 13: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "Guarda la rama: {npc:5770} está en {zone:1456}.",

	-- Step 14: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Cabalga al norte por las colinas del este; {npc:1855} vive en una casita junto a {area:2619}, en la frontera con {zone:1423}.",
	-- {npc:1855} Tirion Fordring · {zone:1423} Eastern Plaguelands
	["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "Las cacerías de {npc:1855} están en {zone:1423}: guárdalas para más adelante.",

	-- Step 15: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Cabalga al oeste hasta {area:192}; {npc:11610} se esconde en la colina al noreste.",

	-- Step 16: Scarlet Crusade
	["Scarlet Crusade"] = "Cruzada Escarlata",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Los caballeros y magus trabajan en {area:192}; los médicos y cazadores acampan al sur.",

	-- Step 18: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} está al este del aserradero; {npc:11611} vigila el camino al noreste de {npc:11610}, hacia {area:190}.",

	-- Step 20: Northridge Lumber Camp
	-- {npc:11610} Kirsta Deepshadow
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "La última tarea de {npc:11610} requiere nivel 53. Los caballeros y magus Escarlata (54-55) que trabajan en el aserradero justo al suroeste de ella son el campamento más cercano.",
	-- {area:192} Northridge Lumber Camp · {zone:1422} Western Plaguelands
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "farmea caballeros Escarlata en {area:192}, {zone:1422}",

	-- Step 22: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Los Escarlata de {area:190} son de nivel 58-60. Entra cabalgando hasta el punto alto marcado en tu mapa, observa el pueblo y sal.",

	-- Step 24: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Cabalga al suroeste pasando la granja de Piedramácula y sigue el camino al oeste de vuelta a {area:152}.",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "Las atalayas de Derrington, la caldera de Vandis y la barrica de {npc:11615} se hacen en una visita posterior: guárdalas.",

	-- Step 25: To Felwood
	-- {zone:1448} Felwood
	["To {zone:1448}"] = "A {zone:1448}",
	-- {area:1497} Undercity · {zone:1454} Orgrimmar · {area:431} Splintertree Post · {zone:1448} Felwood
	["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Cabalga de vuelta a {area:1497}, toma el zepelín a {zone:1454} y vuela a {area:431}. Sigue el camino al oeste fuera del Puesto del Hachazo y toma el desvío al norte hacia {zone:1448}.",

	-- Step 26: Emerald Sanctuary
	["The druids' camp is just past the border."] = "El campamento de los druidas está justo pasada la frontera.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "{npc:9529}, justo al oeste del campamento",

	-- Step 27: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Sur de {area:1763}",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Sigue el camino al noroeste. El sur de {area:1763}, alrededor de su pozo de la luna corrupto, lo ocupan sectarios, adeptos, guardias y canes del Consejo de la Sombra.",

	-- Step 28: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "Solo si cayó una {item:13140}: úsala para iniciar la misión, luego libera a {npc:11018} de su jaula en {area:1770}, la cueva del extremo norte de {area:1763}, y escóltala afuera.",

	-- Step 29: Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "Cabalga de vuelta al sureste hasta el Santuario.",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, en el borde sur del campamento",

	-- Step 30: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "La aldea de los fúrbolgs Muertobosque está justo al sur del Santuario. Cada Muertobosque que mates también sube tu reputación con {area:1769}; guarda las plumas de penacho.",

	-- Step 31: Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "Solo con 5 plumas de penacho de Muertobosque",

	-- Step 32: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "El pozo de la luna de {area:1763}",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "De vuelta al norte a {area:1763}. Llena la cantimplora de {npc:10922} en el pozo de la luna corrupto en medio del campamento sur.",

	-- Step 33: Rakaiah
	-- {npc:11018} Arko'narin · {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Solo si rescataste a {npc:11018}: la súcubo {npc:9518} espera en medio de {area:1763}, junto a {npc:11020}.",

	-- Step 34: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "El campamento de la Horda justo al norte de {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: las lechubestias están en {zone:1452}",

	-- Step 35: The Jadefire moonwell
	["The Jadefire moonwell"] = "El pozo de la luna Fuego de Jade",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Cabalga de vuelta al sur pasando {area:1763} hasta el pozo de la luna corrupto de los sátiros Fuego de Jade y llena allí el frasquito de {npc:9996}.",

	-- Step 37: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "El gatito de {npc:9996}",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Lleva al gatito al mismo pozo de la luna y suéltalo allí; cuando se haya convertido en un {npc:10042}, llévaselo a {npc:9996} y haz clic en él para entregarlo.",
	["Jadefire moonwell"] = "Pozo de la luna Fuego de Jade",

	-- Step 39: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "Al este de Puesto del Veneno, la cañada de cráteres donde deambulan las bestias entrópicas ({npc:9878}) y los horrores. Mata dos de cada uno y luego camina hasta cada uno de los tres cráteres de agua vil.",
	["Southern crater"] = "Cráter sur",
	["Western crater"] = "Cráter oeste",
	["Northern crater"] = "Cráter norte",

	-- Step 40: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Sigue el camino al noreste hasta {area:1767}. Los arrancamusgos y machacadores Alabeo del lado este del bosque llevan cada uno un {item:11503}; los pardos Zarpira y los devastadores Zarpayel deambulan por el mismo bosque para Talo.",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "El camino termina en {npc:15395}, fuera del túnel de {area:1769}, en el extremo noreste.",

	-- Step 42: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "La aldea de los fúrbolgs Muertobosque justo al oeste del túnel. {npc:9462} (56) está entre ellos. {npc:11557}, un fúrbolg amistoso, está sentado en el extremo norte de la aldea.",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: guárdale 30 {quest:6031}; solo comercia a partir de Neutral con los Fauces de Madera",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, botín raro",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Guarda {quest:8465} para {zone:1452}.",

	-- Step 44: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "Cabalga al sur por el camino a través de {zone:1448} hasta el Santuario.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, en el lado oeste del Santuario",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Guarda {quest:5158}: {npc:5901} está en {zone:1413}.",

	-- Step 45: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "Ror está en el extremo sur de {area:1761}.",

	-- Step 46: Bloodvenom Post
	["Ride north up the road again."] = "Cabalga otra vez al norte por el camino.",

	-- Step 47: Felpaw Village
	-- {area:1762} Felpaw Village
	["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "De vuelta en {area:1762}, los fúrbolgs Muertobosque (53-54) están cerca del túnel y cada muerte sube tu reputación con los Fauces de Madera.",
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "farmea vengadores Muertobosque en {area:1762}, {zone:1448}",
	-- {npc:11558} Kernda
	["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, en la entrada del túnel",

	-- Step 48: Through Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Through {area:1769}"] = "A través de {area:1769}",
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien · {zone:1452} Winterspring · {area:2255} Everlook
	["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Entra en el túnel de {area:1769} junto a {npc:15395} y nunca ataques a los fúrbolgs Fauces de Madera de dentro. El túnel sale a {zone:1452}; sigue el camino al este hasta {area:2255}, el pueblo goblin donde empieza la siguiente guía.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:152}"] = "{area:152}",
}
