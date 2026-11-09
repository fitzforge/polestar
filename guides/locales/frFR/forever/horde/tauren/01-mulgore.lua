-- French (frFR): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "Vous commencez sur la mesa de {area:221}. {npc:2980} et le chef se tiennent près de la grande tente au centre.",
	-- {npc:2981} Chief Hawkwind
	["{npc:2981}, inside"] = "{npc:2981}, à l'intérieur",

	-- Step 2: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {object:2907} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {object:2907} stands next to her."] = "{npc:2991} est assise près de la tente au bord est du camp ; {object:2907} est posée à côté d'elle.",

	-- Step 3: Camp Narache: kill these as you meet them
	-- {area:221} Camp Narache
	["{area:221}: kill these as you meet them"] = "",
	-- {npc:2980} Grull Hawkwind
	["Plainstriders roam the mesa all around the camp: take their meat and feathers on the way back to {npc:2980}."] = "",

	-- Step 4: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer; inside"] = "{npc:3059}, le maître des guerriers ; à l'intérieur",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}, la maîtresse des chasseurs",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}, la maîtresse des chamans au camp",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}, le maître des druides à côté de lui",
	["Inside"] = "À l'intérieur",

	-- Step 5: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775} se tient à l'extrémité ouest du camp, à l'angle nord-ouest des collines où rôdent les Pumas des montagnes : prenez sa quête, chassez les pumas de là vers le sud et l'est, puis remontez voir {npc:2980}.",

	-- Step 6: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind · {area:221} Camp Narache
	["{npc:3209}, next to {npc:2980}; walks around {area:221}: look inside the circle on the map"] = "{npc:3209}, à côté de {npc:2980} ; se promène dans {area:221} : cherchez à l'intérieur du cercle sur la carte",

	-- Step 7: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "Suivez le chemin vers le sud hors du camp jusqu'à la tente du prophète, au pied des collines.",

	-- Step 8: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "Le sanctuaire d'An'she et Mu'sha",
	-- {object:660739} Ritual Fire
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "L'encens se consume en dix minutes : courez tout droit vers l'est le long des collines du sud jusqu'au {object:660739}.",

	-- Step 9: Red Cloud Mesa: kill these as you meet them
	-- {area:220} Red Cloud Mesa
	["{area:220}: kill these as you meet them"] = "{area:220} : tuez-les au passage",
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "Les Sangliers de guerre paissent au nord du sanctuaire ; les huran Dos-hirsute tiennent le ravin au nord-est. {npc:8554} se tient à son extrémité est, et la {object:3076} gît par terre dans le camp.",
	["Below ground"] = "Sous terre",

	-- Step 10: Deathskip to Red Cloud Mesa
	-- {area:220} Red Cloud Mesa
	["Deathskip to {area:220}"] = "Mort volontaire jusqu'à {area:220}",
	-- {npc:2954} Bristleback Battleboar · {npc:6491} Spirit Healer
	["Die to the mobs at 63.7,78.4 ({npc:2954}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "Laissez-vous tuer par les monstres en 63.7,78.4 ({npc:2954}) : mourir là vous envoie à ce cimetière. Libérez votre esprit et acceptez la résurrection du {npc:6491}.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "Retournez à l'ouest jusqu'au camp.",
	-- {npc:3209} Brave Windfeather · {area:221} Camp Narache
	["{npc:3209} walks around {area:221}: look inside the circle on the map"] = "{npc:3209} se promène autour de {area:221} : cherchez dans le cercle sur la carte",

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
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "Suivez la route vers le nord pour quitter {area:220}. {npc:265810} attend sur la route juste au sud de {area:222} ; /sit près de son feu de camp jusqu'à obtenir {spell:1229451}.",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "/sit près du feu de camp de Kaga jusqu'à obtenir {spell:1229451}",

	-- Step 16: Bloodhoof Village
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "Quête de {npc:3063} : battez trois Guerriers novices (ou des joueurs en duel) à côté de lui.",
	-- {npc:3222} Brave Wildrunner · {area:222} Bloodhoof Village
	["{npc:3222} walks around {area:222}: look inside the circle on the map"] = "{npc:3222} se promène autour de {area:222} : cherchez dans le cercle sur la carte",

	-- Step 17: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["{npc:3067}: Camping 101 asks you to learn it"] = "{npc:3067} : la quête Camping 101 vous demande de l'apprendre",

	-- Step 18: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "Les Loups des prairies et les Trotteurs des plaines adultes parcourent les plaines autour du village.",
	-- {object:2910} Well Stone
	["{object:2910}, 170 yd east"] = "",

	-- Step 20: Winterhoof Water Well
	-- {npc:2988} Morin Cloudstalker · {quest:99079} Longwalker Malah · {area:821} Rolling Plains
	["The well lies south-east of the village. {npc:2988} camps beside it, and {quest:99079} stands on the {area:821} a little east."] = "",
	-- {npc:2988} Morin Cloudstalker
	["{npc:2988} walks around here: look inside the circle on the map"] = "{npc:2988} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 22: Mulgore: kill these as you meet them
	-- {zone:1412} Mulgore
	["{zone:1412}: kill these as you meet them"] = "{zone:1412} : tuez-les au passage",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}, un loup solitaire, rôde dans les plaines à l'ouest du village. Les Traqueurs des prairies et les Pumas des basses plaines parcourent les plaines au nord et à l'ouest du village.",

	-- Step 23: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} se tient au bord nord du village. Kyle veut de la {item:287505} prise sur les trotteurs des plaines.",

	-- Step 24: Thunderhorn Water Well
	-- {item:287505} Tender Strider Meat
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["The well lies north of the village. Adult Plainstriders graze around it: they drop the {item:287505} for Kyle."] = "",

	-- Step 25: Bloodhoof Village
	-- {npc:277154} Kyle the Frenzied · {item:287505} Tender Strider Meat
	["{npc:277154} runs around the village: give him the {item:287505}"] = "{npc:277154} court dans le village : donnez-lui {item:287505}",
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}, à l'extrémité nord du village",

	-- Step 26: Galak Camp: kill these as you meet them
	-- {area:474} Galak Camp
	["{area:474}: kill these as you meet them"] = "{area:474} : tuez-les au passage",
	-- {npc:275789} Malah Longwind
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas roam among the wolves on the plains around {npc:275789} and the Galak camp to the east."] = "Les Loups Alpha des prairies rôdent parmi les loups dans les plaines autour de {npc:275789} et du camp galak à l'est.",

	-- Step 27: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "La caravane détruite se trouve au nord-ouest des centaures, à l'est de la route de {zone:1456}.",

	-- Step 29: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "Retournez au sud-est jusqu'au {area:396}.",

	-- Step 30: Galak centaurs
	["Galak centaurs"] = "Centaures galak",
	["The Galak centaurs camp on the plains east of the well; Herak leads them."] = "",

	-- Step 31: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "Les gobelins exploitent la mine dans les collines au nord-est du puits. {quest:765} se tient au fond de la mine ; ses {item:281031} lancent {quest:98424}, et les autres pages se trouvent dans la mine.",

	-- Step 32: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "Traversez vers le nord-ouest au-delà de {zone:1456} jusqu'au {area:398}, à l'extrême nord de {zone:1412}.",

	-- Step 33: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984} se tient au bord du {area:404}, au sud du puits.",

	-- Step 34: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "Les harpies Furie-des-vents tiennent {area:819}, au nord et à l'ouest du puits.",

	-- Step 35: Dwarven Digging
	-- {area:404} Bael'dun Digsite
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the dwarves' forge in the digsite."] = "Les nains du {area:404} portent les Piolets de prospecteur. Brisez-les à la forge des nains, sur le site de fouilles.",
	-- {item:4703} Broken Tools
	["{item:4703}, at the digsite forge"] = "{item:4703}, à la forge du site de fouilles",

	-- Step 36: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "Les gnolls crin-pâle tiennent {area:818}, au sud du site de fouilles et à l'ouest de Sabot-de-Sang. {npc:272203} est retenu dans leur camp : escortez-le dehors.",
	-- {npc:2950} Palemane Skinner · {area:16677} Bristleback Retreat
	["{npc:2950} walks around {area:16677}: look inside the circle on the map"] = "{npc:2950} se promène autour de {area:16677} : cherchez dans le cercle sur la carte",
	-- {npc:2951} Palemane Poacher
	["{npc:2951}, below ground"] = "{npc:2951}, sous terre",

	-- Step 37: Bloodhoof Village
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}, pour {npc:3057} à {zone:1456}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}, pour Hamuul à {zone:1456}",

	-- Step 38: Yaw Sharpmane
	-- {npc:3065} Yaw Sharpmane · {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker · {npc:2970} Swoop
	["{npc:3065} stands at the north end of {area:222}. Tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a {npc:2970} to the north-west."] = "{npc:3065} se tient à l'extrémité nord de {area:222}. Apprivoisez avec {item:15908} : un {npc:2956} dans les plaines, un {npc:2959} au nord du village, un {npc:2970} au nord-ouest.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Apprivoisez-le avec le {item:15908}",

	-- Step 40: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "Allez au nord jusqu'à {area:225}, à l'est de {zone:1456}. {npc:3233} se tient au pied des rochers ; les Intrus Dos-hirsute creusent dans le cimetière et l'{npc:2994} attend au sommet.",
	-- {item:5203} Flatland Prowler Claw · {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["{item:5203}: Flatland Prowlers roam the plains around {area:225}"] = "{item:5203} : les Rôdeurs des basses plaines parcourent les plaines autour de {area:225}",

	-- Step 41: Thunder Bluff
	-- {npc:3057} Cairne Bloodhoof
	["{npc:3057}'s tent"] = "",

	-- Step 42: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "Prenez un ascenseur jusqu'aux mesas. {npc:2995} s'occupe des coursiers du vent sur le piton central ; {npc:3057} se tient dans la grande tente.",

	-- Step 43: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} veut de l'encens tauren : achetez ses quatre ingrédients à {npc:3014} l'herboriste, {npc:3012} la fournisseuse en enchantement, {npc:3005} le fournisseur en travail du cuir et {npc:3027} le fournisseur en cuisine, puis combinez-les en {item:278078}.",
	-- {npc:2987} Eyahn Eagletalon · {npc:269068} Eylah Sunhorn
	["{npc:2987}, beside {npc:269068}"] = "",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, chez {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, chez {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, chez {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, chez {npc:3027}",
	-- {npc:6746} Innkeeper Pala · {quest:5922} Moonglade
	["{npc:6746}, at the south end of the central rise: the hearth from {quest:5922} brings you back here"] = "{npc:6746}, à l'extrémité sud du piton central : la pierre de foyer après {quest:5922} vous ramène ici",
	-- {npc:6746} Innkeeper Pala · {quest:5926} Heeding the Call · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746}: {quest:5926}, for {npc:3033} on {area:1639}"] = "{npc:6746} : {quest:5926}, pour {npc:3033} sur {area:1639}",

	-- Step 44: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Utilisez l'{item:278078} sur le tapis et le brûleur de cérémonie, sur la falaise sud de {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Répandez l'{item:278078} depuis {area:1641}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn
	["{npc:3441}: for {quest:860} at the Crossroads"] = "",
	-- {npc:3039} Holt Thunderhorn · {npc:3041} Torm Ragetotem
	["{npc:3039}, beside {npc:3041}"] = "{npc:3039}, à côté de {npc:3041}",

	-- Step 46: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "Tant que vous y êtes : apprenez {spell:199} auprès de {npc:11869} (10 pièces d'argent) ; les armes à deux mains font monter un guerrier le plus vite.",

	-- Step 47: Ansekhwa
	-- {npc:11869} Ansekhwa
	["While you're here: learn Staves from {npc:11869} (10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Tant que vous y êtes : apprenez les Bâtons auprès de {npc:11869} (10 pièces d'argent) ; l'arme de mêlée d'un chasseur compte surtout pour ses caractéristiques, et les armes à deux mains en apportent le plus.",

	-- Step 48: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 49: Rogue trainer
	["Rogue trainer"] = "Maître des voleurs",
	-- {npc:3155} Rwag · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:3155} in {zone:1411}; {zone:1412} has no rogue trainer"] = "{npc:3155} ({zone:1411}) ; {zone:1412} n'a pas de maître des voleurs",

	-- Step 50: Warlock trainer
	["Warlock trainer"] = "Maître des démonistes",
	-- {npc:3156} Nartok · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:3156} in {zone:1411}; {zone:1412} has no warlock trainer"] = "{npc:3156} ({zone:1411}) ; {zone:1412} n'a pas de maître des démonistes",

	-- Step 52: Clarice Foster
	-- {npc:5543} Clarice Foster · {area:2197} Pools of Vision · {area:1640} Spirit Rise
	["{npc:5543} stands in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:5906} Xanis Flameweaver · {npc:5543} Clarice Foster · {area:1640} Spirit Rise
	["{npc:5906}, a few steps from {npc:5543} on {area:1640}"] = "{npc:5906}, à quelques pas de {npc:5543} sur {area:1640}",

	-- Step 54: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem
	["{npc:5769}: for {npc:3448} at the Crossroads"] = "",

	-- Step 55: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} trains druids in the Cenarion Circle's tent on {area:1639}."] = "{npc:3033} entraîne les druides dans la tente du Cercle cénarien sur {area:1639}.",

	-- Step 56: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 57: Back to Thunder Bluff
	-- {area:1639} Elder Rise
	["Cross to {area:1639}."] = "",

	-- Step 58: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "La pierre se dresse dans le col qui sort de {zone:1412}, sur votre route vers l'est. Utilisez-y la {item:15710} et vainquez Lunegriffe.",

	-- Step 59: Into Mulgore
	-- {zone:1412} Mulgore
	["Into {zone:1412}"] = "Vers {zone:1412}",

	-- Step 60: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "Vers les {zone:1413}",

	-- Step 62: The Crossroads
	-- {zone:1412} Mulgore · {npc:3448} Tonga Runetotem · {quest:860} Sergra Darkthorn · {npc:3615} Devrak · {area:380} The Crossroads · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the Crossroads. {npc:3448} stands at the south gate, {quest:860} by the inn, {npc:3615} on the tower platform. {area:380}' own quests come after {zone:1421}, in the {zone:1413} guide."] = "",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, le maître des coursiers du vent",

	-- Step 63: Jahan Hawkwing
	-- {npc:3483} Jahan Hawkwing · {npc:3615} Devrak · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem
	["{npc:3483} sells armor on the north side of the Crossroads. His bundle goes to {npc:3615}, who sends it with you on the flight to {zone:1456} you take for {npc:3033} anyway."] = "",

	-- Step 64: Class turn-in in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-in in {area:1638}"] = "Quête de classe à rendre à {area:1638}",
	-- {npc:8359} Ahanu
	["{npc:8359}, by the wind riders on the central rise"] = "{npc:8359}, près des coursiers du vent sur le piton central",

	-- Step 66: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "Vers {zone:1454}",
	-- {area:379} Far Watch Post · {area:815} Southfury River · {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["From the Crossroads follow the road north-east to {area:379}, cross the {area:815} into {zone:1411} and keep north to {zone:1454}'s main gate. The next guide starts in {zone:1454} and takes the zeppelin to {zone:1420} and {zone:1421}."] = "",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Bloodhoof"] = "Retour à Sabot-de-Sang",
	-- ["Back to {area:17}"] = "Retour dans {area:17}",
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "Les Sangliers de guerre paissent au nord du sanctuaire ; les huran Dos-hirsute tiennent le ravin au nord-est. {npc:8554} se tient à son extrémité est, et la {item:4851} gît par terre dans le camp.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "Lancez {spell:18960}. {npc:11802} se trouve à {area:2361} ; {quest:5930} se trouve dans les bois du nord-ouest.",
	-- ["Class turn-ins in {area:1638}"] = "Quêtes de classe à rendre à {area:1638}",
	-- ["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "Terminez le cœur de loup, le fémur de puma, l'écaille de trotteur et le gésier de rapace dans les plaines autour du village.",
	-- ["Flatland Prowlers roam the plains around {area:225}"] = "Les Rôdeurs des basses plaines parcourent les plaines autour de {area:225}",
	-- ["Galak centaurs and Prairie Wolf Alphas"] = "Centaures galak et Loups Alpha des prairies ({npc:2960})",
	-- ["Galak centaurs and {npc:2958} Alphas"] = "Centaures galak et Loups Alpha ({npc:2958})",
	-- ["Hearth to {area:1638} and cross to {area:1639}."] = "Pierre de foyer vers {area:1638}, puis traversez jusqu'à {area:1639}.",
	-- ["Hearth to {area:222} and ride north to {area:1639}."] = "Utilisez votre Pierre de foyer pour aller à {area:222} et remontez au nord jusqu'à {area:1639}.",
	-- ["Into {area:17}"] = "Vers {area:17}",
	-- ["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {area:17} guide starts here.\n{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "Quittez {zone:1412} par le col du sud-est et suivez la route jusqu'à {area:380}. {quest:860} se tient près de l'auberge, {npc:3448} à la porte sud. Le guide de {area:17} commence ici.\n{area:380} est votre base pour ce guide. Tous ceux dont vous avez besoin se tiennent à quelques pas de l'auberge.",
	-- ["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "Quittez {zone:1412} par le col sud-est et suivez la route jusqu'à {area:380}. {quest:860} se tient près de l'auberge, {npc:3448} à la porte sud. Le guide {zone:1413} commence ici.",
	-- ["On the way"] = "En chemin",
	-- ["Plainstriders roam the grass all around the camp."] = "Les Trotteurs des plaines parcourent l'herbe tout autour du camp.",
	-- ["Prairie Wolf Alphas"] = "Loups Alpha des prairies",
	-- ["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Redescendez à {area:222} et apprivoisez avec le {item:15908} : un {npc:2956} dans les plaines, un {npc:2959} au nord du village, un Rapace au nord-ouest.",
	-- ["Speak with {npc:3067}"] = "Parlez à {npc:3067}",
	-- ["Swoops glide over the plains all around Bloodhoof."] = "Les Rapaces planent au-dessus des plaines tout autour de Sabot-de-Sang.",
	-- ["Tame Beast"] = "Apprivoiser une bête",
	-- ["The Galak centaurs camp on the plains east of the well; {npc:275767} leads them."] = "Les centaures galak campent dans les plaines à l'est du puits ; {npc:275767} les mène.",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "Les centaures galak campent dans les plaines au nord des {area:821} ; Herak le Pilleur les dirige. Des Loups Alpha des prairies ({npc:2960}) rôdent parmi les loups.",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. {npc:2958} Alphas roam among the wolves."] = "Les centaures galak campent dans les plaines au nord de {area:821} ; Herak les mène. Les Loups Alpha des prairies ({npc:2958}) rôdent parmi les loups.",
	-- ["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "Les nains du {area:404} portent les Piolets de prospecteur. Brisez-les à la forge de {area:222}.",
	-- ["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "Le puits se trouve au nord du village. Les Pierres de puits sont autour du puits, les {item:4809} gisent sous les arbres voisins. Tuez loups, pumas, trotteurs et rapaces en chemin pour {quest:766} et {quest:761}.",
	-- ["The well lies north of the village. Well Stones sit around the well, {object:2912} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "Le puits se trouve au nord du village. Les Pierres de puits sont autour du puits, {object:2912} gît sous les arbres voisins. Tuez loups, pumas, trotteurs et rapaces en chemin pour {quest:766} et {quest:761}.",
	-- ["The well lies north of the village. Well Stones sit around the well, {object:2912} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}; the plainstriders also drop the {item:287505} for Kyle."] = "Le puits se trouve au nord du village. Des Pierres du puits ({object:2910}) sont posées autour du puits, et {object:2912} se trouve sous les arbres voisins. Tuez loups, couguars, trotteurs des plaines et plongeurs en chemin pour {quest:766} et {quest:761} ; les trotteurs lâchent aussi {item:287505} pour Kyle.",
	-- ["The well lies south-east of the village."] = "Le puits se trouve au sud-est du village.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["To {area:1637}"] = "Vers {area:1637}",
	-- ["{item:4739} along the way to {npc:2980}"] = "{item:4739} sur le chemin de {npc:2980}",
	-- ["{item:4740} along the way to {npc:2980}"] = "{item:4740} sur le chemin de {npc:2980}",
	-- ["{item:4848} along the way to {area:221}"] = "{item:4848} sur le chemin de {area:221}",
	-- ["{item:4849} along the way to {area:221}"] = "{item:4849} sur le chemin de {area:221}",
	-- ["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789} se tient dans {area:821}, un peu à l'est du puits.",
	-- ["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} se tient au bord nord du village. Kyle veut de la {item:287505} prise sur les trotteurs des plaines.",
	-- ["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988} campe près du {area:396}, au sud-est de Sabot-de-Sang.",
	-- ["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991} est assise près de la tente au bord est du camp ; la {item:4755} est posée à côté d'elle.",
	-- ["{npc:3059}, the warrior trainer"] = "{npc:3059}, le maître des guerriers",
	-- ["{npc:3209}, next to {npc:2980}"] = "{npc:3209}, à côté de {npc:2980}",
	-- ["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441} : pour {quest:860} à {area:380}",
	-- ["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449} : les harpies viendront plus tard, dans {area:383}",
	-- ["{npc:3483} sells armor on the north side of the {area:380}. His bundle goes to {npc:3615}, who sends it with you on the flight to {zone:1456} you take for {npc:3033} anyway."] = "{npc:3483} vend des armures du côté nord de {area:380}. Son paquet va à {npc:3615}, qui vous le confie pour le vol vers {zone:1456} que vous prenez de toute façon pour {npc:3033}.",
	-- ["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769} : pour {npc:3448} à {area:380}",
	-- ["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "{npc:6746}, sur le piton central, vous envoie voir {npc:3033} sur {area:1639}.",
	-- ["{object:2910} on the way"] = "{object:2910} en chemin",
	-- ["{quest:96130} and {quest:756}"] = "{quest:96130} et {quest:756}",
}
