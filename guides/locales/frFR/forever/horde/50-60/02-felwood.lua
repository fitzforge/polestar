-- French (frFR): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Volez jusqu'à {area:1497}",
	-- {area:2268} Light's Hope Chapel · {area:1497} Undercity
	["From {area:2268}'s flight master, fly to the {area:1497}."] = "Depuis le maître de vol de {area:2268}, volez jusqu'à {area:1497}.",

	-- Step 2: Janice Felstone
	-- {area:1497} Undercity · {zone:1420} Tirisfal Glades · {area:152} Bulwark · {npc:10778} Janice Felstone
	["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Quittez {area:1497} et chevauchez vers l'est sur la route à travers {zone:1420}, en passant {area:152}. La ferme des Felstone est la première ferme sur la route ; {npc:10778} attend dans la maison.",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house"] = "{object:175894}, à côté de la maison",
	-- {npc:10781} Royal Overseer Bauhaus · {area:1497} Undercity
	["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Gardez le colis : {npc:10781} est à {area:1497}.",

	-- Step 3: Scarlet forward camp
	["Scarlet forward camp"] = "Camp avancé écarlate",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Les tentes de la Croisade écarlate se dressent entre {area:199} et {area:200}. Incendiez la tente de commandement avec {object:176092} et plantez la bannière du Fléau.",

	-- Step 4: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Ferme de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "Le journal se trouve dans la ferme, le meuble est à l'intérieur et les latrines sont derrière. Un {npc:10816} porte la clé des latrines ; {npc:10836} sort quand vous ouvrez les latrines et porte la clé du meuble.",

	-- Step 5: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Il campe près du {area:202}, au sud-est de {area:200}.",

	-- Step 6: Sorrow Hill
	-- {area:202} Writhing Haunt · {area:197} Sorrow Hill · {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Chevauchez vers le sud en passant le {area:202} jusqu'à {area:197} ; la maison de {npc:10927} se dresse au bord de la route, et le monument de {npc:10936} est dans le cimetière derrière. Tuez les Loups malades que vous croisez dans les champs en chemin.",
	-- {npc:10840} Argent Officer Pureheart
	["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, à l'extrémité sud du cimetière",
	-- {quest:5142} Little Pamela · {area:2262} Darrowshire
	["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "Gardez {quest:5142} : Pamela est à {area:2262}, que vous revisiterez plus tard.",

	-- Step 7: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Chevauchez vers le nord-ouest jusqu'à Andorhal. {npc:10667} attend dans l'auberge en ruine à l'ouest de la ville ; les squelettes à l'intérieur sont de niveau 54-57, restez donc sur les bords.",

	-- Step 8: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Les annales se trouvent parmi les Tomes moisis ({object:176150}) de l'hôtel de ville d'Andorhal ; ouvrez-les jusqu'à trouver le bon.",

	-- Step 9: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} se rend à {area:2268} : gardez-la pour plus tard.",

	-- Step 10: Diseased Wolves
	["Diseased Wolves"] = "Loups malades",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Les loups parcourent les champs entre Andorhal, {area:200} et le {area:202}. Finissez-les sur le chemin du retour vers l'est.",

	-- Step 12: Diseased Grizzlies
	["Diseased Grizzlies"] = "Grizzlys malades",
	-- {area:202} Writhing Haunt
	["The bears roam the hills north and east of the {area:202}."] = "Les ours parcourent les collines au nord et à l'est du {area:202}.",

	-- Step 13: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "Gardez la branche : {npc:5770} est à {zone:1456}.",

	-- Step 14: Tirion Fordring
	-- {area:2620} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; Tirion lives in a small house by the {area:2620}, at the border with the {zone:1423}."] = "Chevauchez vers le nord le long des collines de l'est ; Tirion vit dans une petite maison au bord de {area:2620}, à la frontière des {zone:1423}.",
	-- {zone:1423} Eastern Plaguelands
	["Tirion's hunts are in the {zone:1423}: keep them for later."] = "Les chasses de Tirion se font dans les {zone:1423} : gardez-les pour plus tard.",

	-- Step 15: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Chevauchez vers l'ouest jusqu'au {area:192} ; {npc:11610} se cache sur la colline au nord-est.",

	-- Step 16: Scarlet Crusade
	["Scarlet Crusade"] = "Croisade écarlate",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Chevaliers et mages travaillent au {area:192} ; les médecins et chasseurs campent au sud.",

	-- Step 18: Radley and Durgen
	["Radley and Durgen"] = "Radley et Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} se tient à l'est du camp de bûcherons ; {npc:11611} garde la route au nord-est de {npc:11610}, en direction d'{area:190}.",

	-- Step 20: Northridge Lumber Camp
	-- {npc:11610} Kirsta Deepshadow
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "La dernière tâche de {npc:11610} demande le niveau 53. Les Chevaliers écarlates ({npc:1833}) et les Magus (54-55) du camp de bûcherons juste au sud-ouest sont le camp le plus proche.",
	-- {area:192} Northridge Lumber Camp · {zone:1422} Western Plaguelands
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "tuez des Chevaliers écarlates ({npc:1833}) au {area:192}, {zone:1422}",

	-- Step 22: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Les Écarlates d'{area:190} sont de niveau 58-60. Entrez jusqu'au point haut marqué sur votre carte, observez la ville, puis repartez.",

	-- Step 24: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Chevauchez vers le sud-ouest en passant la ferme des Felstone et suivez la route vers l'ouest jusqu'à {area:152}.",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "Les tours de guet de Derrington, le chaudron de Vandis et le tonneau de {npc:11615} se font lors d'une visite ultérieure : gardez-les.",

	-- Step 25: To Felwood
	-- {zone:1448} Felwood
	["To {zone:1448}"] = "Vers {zone:1448}",
	-- {area:1497} Undercity · {zone:1454} Orgrimmar · {area:431} Splintertree Post · {zone:1448} Felwood
	["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Retournez à {area:1497}, prenez le zeppelin pour {zone:1454} et volez jusqu'au {area:431}. Suivez la route vers l'ouest en quittant Bois-brisé et prenez l'embranchement nord vers {zone:1448}.",

	-- Step 26: Emerald Sanctuary
	["The druids' camp is just past the border."] = "Le camp des druides se trouve juste après la frontière.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "{npc:9529}, juste à l'ouest du camp",

	-- Step 27: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Sud de {area:1763}",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Suivez la route vers le nord-ouest. Le sud de {area:1763}, autour de son puits de lune corrompu, est tenu par des cultistes, adeptes, gardes du Conseil des ombres et leurs molosses.",

	-- Step 28: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "Seulement si une {item:13140} est tombée : utilisez-la pour lancer la quête, puis libérez {npc:11018} de sa cage au {area:1770}, la grotte à l'extrémité nord de {area:1763}, et escortez-la dehors.",

	-- Step 29: Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "Retournez vers le sud-est jusqu'au Sanctuaire.",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, à la lisière sud du camp",

	-- Step 30: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "Le village des furbolgs Mort-bois se trouve juste au sud du Sanctuaire. Chaque Mort-bois tué augmente aussi votre réputation auprès du {area:1769} ; gardez les plumes de coiffure.",

	-- Step 31: Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "Seulement avec 5 Coiffures de plumes mort-bois ({item:21377})",

	-- Step 32: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "Le puits de lune de {area:1763}",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "Retournez au nord jusqu'à {area:1763}. Remplissez la gourde de {npc:10922} au puits de lune corrompu au milieu du camp sud.",

	-- Step 33: Rakaiah
	-- {npc:11018} Arko'narin · {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Seulement si vous avez sauvé {npc:11018} : la succube {npc:9518} attend au milieu de {area:1763}, à côté de {npc:11020}.",

	-- Step 34: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "Le camp de la Horde juste au nord de {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306} : les chouettards sont à {zone:1452}",

	-- Step 35: The Jadefire moonwell
	["The Jadefire moonwell"] = "Le puits de lune des Jadefeu",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Retournez vers le sud en passant {area:1763} jusqu'au puits de lune corrompu des satyres Jadefeu et remplissez-y la flasque de {npc:9996}.",

	-- Step 37: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "Le chaton de {npc:9996}",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Emmenez le chaton au même puits de lune et relâchez-le là ; une fois changé en {npc:10042}, ramenez-le à {npc:9996} et cliquez dessus pour le lui remettre.",
	["Jadefire moonwell"] = "Puits de lune des Jadefeu",

	-- Step 39: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "À l'est du Poste de la Vénéneuse, le val criblé de cratères où errent les Bêtes d'entropie et les Horreurs. Tuez-en deux de chaque, puis allez à chacun des trois cratères d'eau gangrenée.",
	["Southern crater"] = "Cratère sud",
	["Western crater"] = "Cratère ouest",
	["Northern crater"] = "Cratère nord",

	-- Step 40: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Suivez la route vers le nord-est jusqu'au {area:1767}. Les Ecorcheurs ({npc:7100}) et Déchireurs Crochebois de l'est des bois portent chacun un {item:11503} ; Grizzlys de la griffe colérique et Ravageurs Gangrepatte ({npc:8961}) parcourent les mêmes bois pour Talo.",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "La route se termine à {npc:15395}, devant le tunnel du {area:1769}, à l'extrême nord-est.",

	-- Step 42: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "Le village des furbolgs Mort-bois juste à l'ouest du tunnel. {npc:9462} (56) se tient parmi eux. {npc:11557}, un furbolg amical, est assis à l'extrémité nord du village.",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557} : gardez 30 {quest:6031} pour lui ; il ne commerce qu'à partir de Neutre avec les Grumegueules",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, un butin rare",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Gardez {quest:8465} pour {zone:1452}.",

	-- Step 44: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "Suivez la route vers le sud à travers {zone:1448} jusqu'au Sanctuaire.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, à l'ouest du Sanctuaire",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Gardez {quest:5158} : {npc:5901} est dans {zone:1413}.",

	-- Step 45: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "Ror se tient à l'extrême sud du {area:1761}.",

	-- Step 46: Bloodvenom Post
	["Ride north up the road again."] = "Remontez la route vers le nord.",

	-- Step 47: Felpaw Village
	-- {area:1762} Felpaw Village
	["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "De retour au {area:1762}, les furbolgs Mort-bois (53-54) sont près du tunnel et chaque mort augmente votre réputation auprès des Grumegueules.",
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "tuez des Vengeurs Mort-bois ({npc:7157}) au {area:1762}, {zone:1448}",
	-- {npc:11558} Kernda
	["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, à l'entrée du tunnel",

	-- Step 48: Through Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Through {area:1769}"] = "À travers le {area:1769}",
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien · {zone:1452} Winterspring · {area:2255} Everlook
	["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Entrez dans le tunnel du {area:1769} à côté de {npc:15395} et n'attaquez jamais les furbolgs Grumegueules à l'intérieur. Le tunnel débouche sur {zone:1452} ; suivez la route vers l'est jusqu'à {area:2255}, la ville gobeline où commence le prochain guide.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:152}"] = "{area:152}",
}
