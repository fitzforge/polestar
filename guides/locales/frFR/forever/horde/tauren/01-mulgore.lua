-- French (frFR): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "Vous commencez sur la mesa de {area:221}. {npc:2980} et le chef se tiennent près de la grande tente au centre.",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "Les Trotteurs des plaines parcourent l'herbe tout autour du camp.",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "{npc:3059}, le maître des guerriers",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}, la maîtresse des chasseurs",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}, la maîtresse des chamans au camp",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}, le maître des druides à côté de lui",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {item:4755} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991} est assise près de la tente au bord est du camp ; la {item:4755} est posée à côté d'elle.",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775} se tient à l'extrémité ouest du camp, à l'angle nord-ouest des collines où rôdent les Pumas des montagnes : prenez sa quête, chassez les pumas de là vers le sud et l'est, puis remontez voir {npc:2980}.",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:3209}, à côté de {npc:2980}",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "Suivez le chemin vers le sud hors du camp jusqu'à la tente du prophète, au pied des collines.",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "Le sanctuaire d'An'she et Mu'sha",
	-- {object:660739} Ritual Fire
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "L'encens se consume en dix minutes : courez tout droit vers l'est le long des collines du sud jusqu'au {object:660739}.",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "Les Sangliers de guerre paissent au nord du sanctuaire ; les huran Dos-hirsute tiennent le ravin au nord-est. {npc:8554} se tient à son extrémité est, et la {object:3076} gît par terre dans le camp.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "Retournez à l'ouest jusqu'au camp.",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888} se tient au {area:221}. {quest:1516} requiert le niveau 4, que vous atteignez avec les quêtes rendues ici.",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "Retournez à l'est jusqu'à {area:358} : les Chamans Dos-hirsute s'y tiennent parmi les huran.",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "Retournez voir {npc:5888} au camp. La {npc:5891} attend sur la mesa à l'est du camp : buvez-y le {item:6635} pour la voir, puis rapportez le {item:6656} à la prophétesse.",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888} : {npc:5873} et votre {item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "Suivez la route vers le nord en quittant {area:220}. {npc:265810} attend sur la route juste au sud de {area:222} ; /sit près de son feu de camp jusqu'à obtenir {spell:1229451}.",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "/sit près du feu de camp de Kaga jusqu'à obtenir {spell:1229451}",

	-- Step 16: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "Parlez à {npc:3067}",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "Les Loups des prairies et les Trotteurs des plaines adultes parcourent les plaines autour du village.",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "Le puits se trouve au sud-est du village.",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130} et {quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}, un loup solitaire, rôde dans les plaines à l'ouest du village. Les Traqueurs des prairies et les Pumas des basses plaines parcourent les plaines au nord et à l'ouest du village.",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "Retour à Sabot-de-Sang",
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}, pour {npc:3057} à {zone:1456}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}, pour Hamuul à {zone:1456}",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "Quête de {npc:3063} : battez trois Guerriers novices (ou des joueurs en duel) à côté de lui.",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} se tient au bord nord du village. Kyle veut de la {item:287505} prise sur les trotteurs des plaines.",

	-- Step 26: Thunderhorn Water Well
	-- {item:4809} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {item:4808} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "Le puits se trouve au nord du village. Les Pierres de puits sont autour du puits, les {item:4809} gisent sous les arbres voisins. Tuez loups, pumas, trotteurs et rapaces en chemin pour {quest:766} et {quest:761}.",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}, à l'extrémité nord du village",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "Les Rapaces planent au-dessus des plaines tout autour de Sabot-de-Sang.",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988} campe près du {area:396}, au sud-est de Sabot-de-Sang.",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789} se tient dans {area:821}, un peu à l'est du puits.",

	-- Step 31: Galak centaurs and Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Galak centaurs and Prairie Wolf Alphas"] = "Centaures galak et Loups Alpha des prairies ({npc:2960})",
	-- {area:821} Rolling Plains
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "Les centaures galak campent dans les plaines au nord des {area:821} ; Herak le Pilleur les dirige. Des Loups Alpha des prairies ({npc:2960}) rôdent parmi les loups.",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "La caravane détruite se trouve au nord-ouest des centaures, à l'est de la route de {zone:1456}.",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "Terminez le cœur de loup, le fémur de puma, l'écaille de trotteur et le gésier de rapace dans les plaines autour du village.",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "Retournez au sud-est jusqu'au {area:396}.",

	-- Step 37: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "Les gobelins exploitent la mine dans les collines au nord-est du puits. {quest:765} se tient au fond de la mine ; ses {item:281031} lancent {quest:98424}, et les autres pages se trouvent dans la mine.",

	-- Step 38: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "Traversez vers le nord-ouest au-delà de {zone:1456} jusqu'au {area:398}, à l'extrême nord de {zone:1412}.",

	-- Step 39: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "Les harpies Furie-des-vents tiennent {area:819}, au nord et à l'ouest du puits.",

	-- Step 40: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984} se tient au bord du {area:404}, au sud du puits.",

	-- Step 41: Dwarven Digging
	-- {area:404} Bael'dun Digsite · {area:222} Bloodhoof Village
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "Les nains du {area:404} portent les Piolets de prospecteur. Brisez-les à la forge de {area:222}.",

	-- Step 42: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "Les gnolls crin-pâle tiennent {area:818}, au sud du site de fouilles et à l'ouest de Sabot-de-Sang. {npc:272203} est retenu dans leur camp : escortez-le dehors.",

	-- Step 45: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "Allez au nord jusqu'à {area:225}, à l'est de {zone:1456}. {npc:3233} se tient au pied des rochers ; les Intrus Dos-hirsute creusent dans le cimetière et l'{npc:2994} attend au sommet.",
	-- {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["Flatland Prowlers roam the plains around {area:225}"] = "Les Rôdeurs des basses plaines parcourent les plaines autour de {area:225}",

	-- Step 46: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "Prenez un ascenseur jusqu'aux mesas. {npc:2995} s'occupe des coursiers du vent sur le piton central ; {npc:3057} se tient dans la grande tente.",

	-- Step 47: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} veut de l'encens tauren : achetez ses quatre ingrédients à {npc:3014} l'herboriste, {npc:3012} la fournisseuse en enchantement, {npc:3005} le fournisseur en travail du cuir et {npc:3027} le fournisseur en cuisine, puis combinez-les en {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, chez {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, chez {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, chez {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, chez {npc:3027}",

	-- Step 48: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Utilisez l'{item:278078} sur le tapis et le brûleur de cérémonie, sur la falaise sud de {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Répandez l'{item:278078} depuis {area:1641}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441} : pour {quest:860} à {area:380}",

	-- Step 50: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769} : pour {npc:3448} à {area:380}",

	-- Step 52: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "{npc:6746}, sur le piton central, vous envoie voir {npc:3033} sur {area:1639}.",

	-- Step 53: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361} ; {quest:5930} se trouve dans les bois du nord-ouest.",

	-- Step 54: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and ride north to {area:1639}."] = "Utilisez votre Pierre de foyer pour aller à {area:222} et remontez au nord jusqu'à {area:1639}.",

	-- Step 55: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Redescendez à {area:222} et apprivoisez avec le {item:15908} : un {npc:2956} dans les plaines, un {npc:2959} au nord du village, un Rapace au nord-ouest.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Apprivoisez-le avec le {item:15908}",

	-- Step 56: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "La pierre se dresse dans le col qui sort de {zone:1412}, sur votre route vers l'est. Utilisez-y la {item:15710} et vainquez Lunegriffe.",

	-- Step 57: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "Quittez {zone:1412} par le col sud-est et suivez la route jusqu'à {area:380}. {quest:860} se tient près de l'auberge, {npc:3448} à la porte sud. Le guide {zone:1413} commence ici.",

	-- Step 58: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "Quêtes de classe à rendre à {area:1638}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "Les Sangliers de guerre paissent au nord du sanctuaire ; les huran Dos-hirsute tiennent le ravin au nord-est. {npc:8554} se tient à son extrémité est, et la {item:4851} gît par terre dans le camp.",
	-- ["Galak centaurs and {npc:2958} Alphas"] = "Centaures galak et Loups Alpha ({npc:2958})",
	-- ["Tame Beast"] = "Apprivoiser une bête",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. {npc:2958} Alphas roam among the wolves."] = "Les centaures galak campent dans les plaines au nord de {area:821} ; Herak les mène. Les Loups Alpha des prairies ({npc:2958}) rôdent parmi les loups.",
	-- ["The {area:380}"] = "{area:380}",
}
