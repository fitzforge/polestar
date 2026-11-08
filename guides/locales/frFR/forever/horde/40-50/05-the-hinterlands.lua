-- French (frFR): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Fly to {object:1772}"] = "",
	["Thorium Point flight master"] = "",

	-- Step 3: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "Camp de {npc:7801}",
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser
	["Ride north-east from {object:1772} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' Quel'Danil Lodge."] = "",

	-- Step 4: Highvale
	["Highvale"] = "Haut-val",
	-- {npc:7780} Rin'ji
	["The Highvale elves camp around Quel'Danil Lodge. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "",

	-- Step 5: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "À l'est du village, le Tragan violet pousse dans les collines.",
	["Underwater"] = "Sous l'eau",

	-- Step 6: Revantusk Village
	["Revantusk Village"] = "",
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Suivez les routes vers l'est à travers les {zone:1425} jusqu'au village troll de la côte est.",

	-- Step 8: Revantusk Village
	-- {quest:7849} Separation Anxiety · {quest:7845} Kidnapped Elder Torntusk! · {quest:7850} Dark Vessels · {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{quest:7849}, {quest:7845} and {quest:7850} are group quests: they send you into Jintha'Alor, whose trolls are elite (46-50). Take them with a group of three or more; skip them if you are alone, the route has you grind the experience back.\n{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 9: The Overlook Cliffs: kill these as you meet them
	["The Overlook Cliffs: kill these as you meet them"] = "",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Les grosses tortues rampent sur les plages au nord du village. Les bouteilles de Porto Pupellyverbos de {npc:2491} se trouvent aussi sur ces plages, mais sa quête ne fait pas partie de cet itinéraire. Une Gueule d'acier des mers peut laisser tomber la Balise de détresse OOX-09/HL, rarement : gardez-la.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, butin rare",

	-- Step 10: The Overlook Cliffs: kill these as you meet them
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} is a level 48 elite: most classes solo it at level 50, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:7977} est un élite de niveau 48 : la plupart des classes le tuent seules au niveau 50, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",

	-- Step 11: Rin'ji's Secret
	["The secret lies on the Overlook Cliffs, above the beach."] = "",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "pour {npc:7825} à {zone:1458}, vers le niveau 50",

	-- Step 12: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "Le repas de {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Au nord le long de la côte, le panier de pique-nique de {npc:14731} est sur la petite île ; un {npc:14748} le garde.",

	-- Step 14: Shaol'watha: kill these as you meet them
	["Shaol'watha: kill these as you meet them"] = "",
	-- {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko · {npc:2925} Silvermane Howler
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["West of the island, the Vilebranch scalpers hold the temples of Agol'watha and Shaol'watha. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and Skulk Rock. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use Infected Bite. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "",

	-- Step 15: Skulk Rock
	["Skulk Rock"] = "",
	-- {item:8684} Hinterlands Honey Ripple
	["The crates of {item:8684} lie around the abandoned Horde camp at Skulk Rock, among the oozes."] = "",

	-- Step 16: Wildkin Muisek
	["Careful: Stealthed wolves and griffons roam the Valorwind Lake area."] = "",

	-- Step 17: The Altar of Zul: kill these as you meet them
	["The Altar of Zul: kill these as you meet them"] = "",
	-- {npc:8636} Morta'gya the Keeper
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west of the lake, the Vilebranch soothsayers hold the Altar of Zul, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "",

	-- Step 18: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["Only with the distress beacon: the robot sits at the head of the river west of Skulk Rock. Escort it east to the shore beyond the Overlook Cliffs; its reward waits with Oglethorpe in {object:3204}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "",

	-- Step 19: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "pour {npc:6986} à {zone:1454}, vers le niveau 50",

	-- Step 20: Highvale
	["Back west to Quel'Danil Lodge; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "",

	-- Step 21: Jintha'Alor
	["Jintha'Alor"] = "",
	-- {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of Jintha'Alor. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. The trolls inside are elite: stay with your group and keep to the paths."] = "",
	-- {npc:14757} Elder Torntusk
	["{npc:14757}, at the top of Jintha'Alor"] = "",
	["His next request, going on to the Altar of Zul, is for a group."] = "",

	-- Step 22: Revantusk Village
	-- {npc:14731} Lard
	["{npc:14731}, inside"] = "{npc:14731}, à l'intérieur",

	-- Step 23: Revantusk Village
	-- {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 25: Level 49.02
	["Level 49.02"] = "Niveau 49.02",
	-- {quest:7816} Gammerita, Mon!
	["If you skipped {quest:7816} or the Jintha'Alor group quests, grind here to level 49.02 to stay on the route's plan. Or, with a group, run the Maraudon dungeon instead."] = "",
	-- {npc:2505} Saltwater Snapjaw
	["grind on {npc:2505}"] = "tuez en boucle : {npc:2505}",

	-- Step 26: The Atal'ai Exile
	["South-west again, the exile hides by the ruins of Shadra'Alor."] = "",

	-- Step 28: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Au sud du gîte, les trolls Witherbark tiennent leurs villages. Chacun porte un crâne : avec vingt crânes, utilisez {item:15002} pour obtenir la Pique de Nimboya préparée, puis plantez-la dans le village.",

	-- Step 29: Aerie Peak
	["Aerie Peak"] = "",
	["Ride all the way west to the Wildhammer town of Aerie Peak and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "",
	["Aerie Peak well"] = "",

	-- Step 31: Fly to Stonard
	["Fly to Stonard"] = "",
	["Revantusk Village flight master"] = "",

	-- Step 32: Fel'zerul
	["On the top floor"] = "Au dernier étage",

	-- Step 33: The bloodmages
	["The bloodmages"] = "Les mages de sang",
	-- {zone:1419} Blasted Lands
	["Ride west out of Stonard and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "",

	-- Step 34: Serpent's Coil: kill these as you meet them
	["Serpent's Coil: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use Venom Sting; {npc:8301} adds Knockdown."] = "",

	-- Step 35: The bloodmages
	["Ride back north to the bloodmages."] = "Retournez au nord jusqu'aux mages de sang.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Leurs quêtes suivantes redemandent les mêmes morceaux pour un objet d'amélioration et ne rapportent pas d'expérience : laissez-les.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Retournez à l'ouest jusqu'à {area:350} ; les Forestiers et Tireurs d'élite du Haut-val restent près du gîte, les Eclaireurs et Estafettes du Haut-val sur les pentes au sud.",
	-- ["Careful: Stealthed wolves and griffons roam the {area:1883} area."] = "Attention : des loups et des griffons camouflés rôdent dans les environs de {area:1883}.",
	-- ["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "À l'est de la route, les Sangliers cendrés et les Grunters fouillent les pentes près des Basilics Rougepierre. Restez à l'écart des Sangliers infernaux de niveau 52, plus au sud.",
	-- ["Fly to the {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- ["Fly to {area:272}"] = "Prendre un vol pour {area:272}",
	-- ["Fly to {area:321}"] = "Prendre un vol pour {area:321}",
	-- ["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- ["Follow the roads east across the {area:47} to the troll village on the eastern coast."] = "Suivez les routes vers l'est à travers les {area:47} jusqu'au village troll sur la côte est.",
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Suivez les routes vers l'est à travers les {zone:1425} jusqu'au village troll de la côte est.",
	-- ["From {area:1446}'s flight master."] = "Auprès du maître de vol de {area:1446}.",
	-- ["Grind to 48"] = "Montez au niveau 48",
	-- ["Hearth to {area:3317}"] = "Pierre de foyer vers {area:3317}",
	-- ["His next request, going on to the {area:355}, is for a group."] = "Sa demande suivante, qui mène à {area:355}, est pour un groupe.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Le Crâne du veneur Malkhor se trouve sur un tas sous les ruines Vilebranch, les Os du veneur Malkhor sur un tas au pied de {area:354}. Les Calices de sang corrompu sont posés sur les terrasses inférieures, et {npc:14757} est retenu au sommet. Restez sur les chemins : les trolls à l'intérieur sont des élites.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Le Crâne du veneur Malkhor repose sur un tas sous les ruines Vilebranch, ses os sur un tas au pied de {area:354}. Les Calices de {spell:19478} se trouvent sur les terrasses inférieures, et {npc:14757} est retenu au sommet. Restez sur les chemins : les trolls à l'intérieur sont des élites.",
	-- ["If you skipped {quest:7816}, grind here to level 49.02 to stay on the route's plan."] = "Si vous avez passé {quest:7816}, tuez des monstres ici jusqu'au niveau 49.02 pour rester dans le plan de la route.",
	-- ["On the way"] = "En chemin",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "En revenant vers l'est, les Devins Vilebranch tiennent {area:355}, le temple troll au sud des collines centrales. Qiaga la Gardienne et {npc:8636} (élite, 50) se tiennent au sommet : affrontez les devins sur les marches du bas.",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Sur le chemin du retour vers l'est, les devins Vilebranch tiennent l'{area:355}, le temple troll au sud des collines centrales. Qiaga et {npc:8636} (élite, 50) se tiennent au sommet : affrontez les devins sur les marches inférieures.\nAu sud-ouest, les Hurleurs Crins-d'argent parcourent les collines à l'est des villages Witherbark.",
	-- ["Only if you are not level 48 yet."] = "Seulement si vous n'êtes pas encore niveau 48.",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Seulement avec la balise de détresse : le robot se trouve à la source de la rivière, à l'ouest de {area:351}. Escortez-le vers l'est jusqu'au rivage au-delà de {area:307} ; sa récompense vous attend auprès d'Oglethorpe Obnoticus à {area:35}.",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "Seulement avec la balise de détresse : le robot se trouve à la source de la rivière, à l'ouest de {area:351}. Escortez-le vers l'est jusqu'au rivage au-delà de {area:307} ; sa récompense vous attend auprès d'Oglethorpe, à {area:35}.\nAttention : deux embuscades surviennent pendant l'escorte : d'abord trois chouettards, puis trois trolls. Avant chacune, le robot s'arrête et annonce qu'il sent un danger. Des limons, des loups camouflés et une grande tortue le long du chemin peuvent se joindre aux combats, et ils réapparaissent même si vous les avez éliminés avant.",
	-- ["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Allez tout à l'ouest jusqu'à {area:348}, la ville des Wildhammer, et déposez le message près du puits en son centre. La ville est pleine de gardes de l'Alliance : entrez, déposez-le et repartez.",
	-- ["Ride north back to {area:75} and fly to the {area:1497}."] = "Retournez au nord jusqu'à {area:75} et prenez un vol pour {area:1497}.",
	-- ["Ride north-east from {area:272} into the {area:47} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Allez vers le nord-est depuis {area:272} jusqu'aux {area:47}, puis vers l'est par la route ; {npc:7801} campe sur la colline au sud de {area:350}, chez les elfes.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Depuis {area:272}, allez au nord-est jusqu'aux {zone:1425}, puis à l'est le long de la route ; {npc:7801} campe sur la colline au sud de {area:350}, le gîte des elfes.",
	-- ["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Sortez de {area:75} par l'ouest et descendez le canyon vers le sud jusqu'à {zone:1419} ; les deux mages de sang se tiennent au bord de la route, juste à l'entrée.",
	-- ["Saltwater Snapjaws"] = "Gueules d'acier des mers",
	-- ["Silvermane Howlers"] = "Hurleurs Crins-d'argent",
	-- ["South-west again, the exile hides by the ruins of {area:353}."] = "De nouveau au sud-ouest, l'exilé se cache près des ruines de {area:353}.",
	-- ["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Au sud-ouest, les Hurleurs Crins-d'argent rôdent dans les collines à l'est des villages Witherbark.",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Les elfes du Haut-val campent autour de {area:350}. Brûlez le Rapport du Haut-val, les Notes du Haut-val et les Registres du Haut-val dans leurs camps. {npc:7780} est retenu dans le gîte : faites-le sortir et repoussez l'embuscade en chemin.",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "Les elfes de Highvale campent autour de {area:350}. Brûlez le rapport, les notes et les registres dans leurs camps. {npc:7780} est retenu dans le pavillon : faites-le sortir et repoussez l'embuscade en chemin.\nAttention : des groupes d'environ trois elfes attaquent l'escorte, généralement deux fois.",
	-- ["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Les Traqueurs Crins-d'argent, les Chouettards sauvages et les Seigneurs du ciel Bec-rasoir se partagent les collines entre les temples et {area:351}. Utilisez {item:9618} sur les chouettards que vous tuez. Les Seigneurs du ciel Bec-rasoir laissent aussi tomber des Longues plumes élégantes : gardez-en dix pour le deuxième message d'{npc:14738} Moji'ko.",
	-- ["The Vilebranch temples"] = "Les temples Vilebranch",
	-- ["The central hills"] = "Les collines centrales",
	-- ["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Les caisses de {item:8684} se trouvent autour du camp abandonné de la Horde à {area:351}, parmi les limons.",
	-- ["The eastern slopes"] = "Les pentes de l'est",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Les cinq quêtes demandent les mêmes morceaux : récupérez-les tous en un seul passage. À l'ouest de la route, les vautours ({npc:5982}), les Raillecrocs affamées, les Aiguillonneurs scorpok et les basilics Oeil-de-mort se partagent les collines.",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "Les cinq quêtes demandent les mêmes morceaux : ramassez-les tous en un seul passage. À l'ouest de la route, les vautours {npc:5982}, les Raillecrocs affamées, les Aiguillonneurs scorpok et les basilics Deatheye se partagent les collines.\nÀ l'est de la route, les sangliers Ashmane et les Grogneurs fouillent les pentes à côté des basilics Redstone. Restez à l'écart des Sangliers infernaux de niveau 52 plus au sud.\nAttention : les Aiguillonneurs scorpok utilisent {spell:5416} ; {npc:8301} y ajoute Renversement.",
	-- ["The next guide starts here, at {area:3317}."] = "Le guide suivant commence ici, à {area:3317}.",
	-- ["The northern beasts"] = "Les bêtes du nord",
	-- ["The secret lies on the {area:307}, above the beach."] = "Le Secret de Rin'ji se trouve sur {area:307}, au-dessus de la plage.",
	-- ["Vilebranch soothsayers"] = "Devins Vilebranch",
	-- ["Vulture hills"] = "Collines des vautours",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "À l'ouest de l'île, les Scalpeurs Vilebranch tiennent les temples d'{area:1884} et de {area:1917}. Les outils du Forgeron Slagtree se trouvent dans l'un des temples.",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use {spell:7367}. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "À l'ouest de l'île, les scalpeurs Vilebranch tiennent les temples de {area:1884} et de {area:1917}. Les outils de Slagtree se trouvent près de l'un des temples.\nLes Traqueurs Crins-d'argent, les Chouettards sauvages et les Seigneurs du ciel Bec-rasoir se partagent les collines entre les temples et {area:351}. Utilisez le {item:9618} sur les chouettards que vous tuez. Les Seigneurs du ciel lâchent aussi des Longues plumes élégantes : gardez-en dix pour le second message de {npc:14738}.\nAttention : les Traqueurs Crins-d'argent sont de niveau 47-48 et restent camouflés hors combat. De près, ils utilisent {spell:7367}. Quand un {npc:2925} tombe à 50 % de vie ou moins, il appelle à l'aide tout ce qui se trouve à moins de 25 m.",
	-- ["grind on {npc:5982} at the northern hills, {zone:1419}"] = "tuez des {npc:5982} sur les collines du nord, {zone:1419}",
	-- ["{area:1440}: kill these as you meet them"] = "{area:1440} : tuez-les au passage",
	-- ["{area:1446} flight master"] = "Maître de vol de {area:1446}",
	-- ["{area:1917}: kill these as you meet them"] = "{area:1917} : tuez-les au passage",
	-- ["{area:307}: kill these as you meet them"] = "{area:307} : tuez-les au passage",
	-- ["{area:321} flight master"] = "Maître de vol de {area:321}",
	-- ["{area:3317} flight master"] = "Maître de vol de {area:3317}",
	-- ["{area:348} well"] = "Puits de {area:348}",
	-- ["{area:355}: kill these as you meet them"] = "{area:355} : tuez-les au passage",
	-- ["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, au sommet de {area:354}",
	-- ["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741} : pour {zone:1456}, vers le niveau 50",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
}
