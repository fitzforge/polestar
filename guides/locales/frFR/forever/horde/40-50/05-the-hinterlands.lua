-- French (frFR): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- {area:1446} Thorium Point
	["From {area:1446}'s flight master."] = "Auprès du maître de vol de {area:1446}.",

	-- Step 2: The bloodmages
	["The bloodmages"] = "Les mages de sang",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Sortez de {area:75} par l'ouest et descendez le canyon vers le sud jusqu'à {zone:1419} ; les deux mages de sang se tiennent au bord de la route, juste à l'entrée.",

	-- Step 3: The northern beasts
	["The northern beasts"] = "Les bêtes du nord",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Les cinq quêtes demandent les mêmes morceaux : récupérez-les tous en un seul passage. À l'ouest de la route, les vautours ({npc:5982}), les Raillecrocs affamées, les Aiguillonneurs scorpok et les basilics Oeil-de-mort se partagent les collines.",

	-- Step 4: The eastern slopes
	["The eastern slopes"] = "Les pentes de l'est",
	["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "À l'est de la route, les Sangliers cendrés et les Grunters fouillent les pentes près des Basilics Rougepierre. Restez à l'écart des Sangliers infernaux de niveau 52, plus au sud.",

	-- Step 5: The bloodmages
	["Ride back north to the bloodmages."] = "Retournez au nord jusqu'aux mages de sang.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Leurs quêtes suivantes redemandent les mêmes morceaux pour un objet d'amélioration et ne rapportent pas d'expérience : laissez-les.",

	-- Step 6: Grind to 48
	["Grind to 48"] = "Montez au niveau 48",
	["Only if you are not level 48 yet."] = "Seulement si vous n'êtes pas encore niveau 48.",
	["Vulture hills"] = "Collines des vautours",
	-- {npc:5982} Black Slayer · {zone:1419} Blasted Lands
	["grind on {npc:5982} at the northern hills, {zone:1419}"] = "tuez des {npc:5982} sur les collines du nord, {zone:1419}",

	-- Step 7: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity
	["Ride north back to {area:75} and fly to the {area:1497}."] = "Retournez au nord jusqu'à {area:75} et prenez un vol pour {area:1497}.",

	-- Step 8: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- {npc:6741} Innkeeper Norman · {zone:1456} Thunder Bluff
	["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741} : pour {zone:1456}, vers le niveau 50",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Prendre un vol pour {area:272}",

	-- Step 10: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "Camp de {npc:7801}",
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Depuis {area:272}, allez au nord-est jusqu'aux {zone:1425}, puis à l'est le long de la route ; {npc:7801} campe sur la colline au sud de {area:350}, le gîte des elfes.",

	-- Step 11: Highvale
	["Highvale"] = "Haut-val",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Les elfes du Haut-val campent autour de {area:350}. Brûlez le Rapport du Haut-val, les Notes du Haut-val et les Registres du Haut-val dans leurs camps. {npc:7780} est retenu dans le gîte : faites-le sortir et repoussez l'embuscade en chemin.",

	-- Step 12: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Au sud du gîte, les trolls Witherbark tiennent leurs villages. Chacun porte un crâne : avec vingt crânes, utilisez {item:15002} pour obtenir la Pique de Nimboya préparée, puis plantez-la dans le village.",

	-- Step 13: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "À l'est du village, le Tragan violet pousse dans les collines.",

	-- Step 14: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "De nouveau au sud-ouest, l'exilé se cache près des ruines de {area:353}.",

	-- Step 15: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Suivez les routes vers l'est à travers les {zone:1425} jusqu'au village troll de la côte est.",

	-- Step 16: Saltwater Snapjaws
	-- plural, as words: Saltwater Snapjaws = {npc:2505} Saltwater Snapjaw
	["Saltwater Snapjaws"] = "Gueules d'acier des mers",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Les grosses tortues rampent sur les plages au nord du village. Les bouteilles de Porto Pupellyverbos de {npc:2491} se trouvent aussi sur ces plages, mais sa quête ne fait pas partie de cet itinéraire. Une Gueule d'acier des mers peut laisser tomber la Balise de détresse OOX-09/HL, rarement : gardez-la.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, butin rare",

	-- Step 17: Rin'ji's Secret
	-- {area:307} Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "Le Secret de Rin'ji se trouve sur {area:307}, au-dessus de la plage.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "pour {npc:7825} à {zone:1458}, vers le niveau 50",

	-- Step 18: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "Le repas de {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Au nord le long de la côte, le panier de pique-nique de {npc:14731} est sur la petite île ; un {npc:14748} le garde.",

	-- Step 19: The Vilebranch temples
	["The Vilebranch temples"] = "Les temples Vilebranch",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "À l'ouest de l'île, les Scalpeurs Vilebranch tiennent les temples d'{area:1884} et de {area:1917}. Les outils du Forgeron Slagtree se trouvent dans l'un des temples.",

	-- Step 20: The central hills
	["The central hills"] = "Les collines centrales",
	-- {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Les Traqueurs Crins-d'argent, les Chouettards sauvages et les Seigneurs du ciel Bec-rasoir se partagent les collines entre les temples et {area:351}. Utilisez {item:9618} sur les chouettards que vous tuez. Les Seigneurs du ciel Bec-rasoir laissent aussi tomber des Longues plumes élégantes : gardez-en dix pour le deuxième message d'{npc:14738} Moji'ko.",

	-- Step 21: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Les caisses de {item:8684} se trouvent autour du camp abandonné de la Horde à {area:351}, parmi les limons.",

	-- Step 22: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Seulement avec la balise de détresse : le robot se trouve à la source de la rivière, à l'ouest de {area:351}. Escortez-le vers l'est jusqu'au rivage au-delà de {area:307} ; sa récompense vous attend auprès d'Oglethorpe Obnoticus à {area:35}.",

	-- Step 23: Silvermane Howlers
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["Silvermane Howlers"] = "Hurleurs Crins-d'argent",
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Au sud-ouest, les Hurleurs Crins-d'argent rôdent dans les collines à l'est des villages Witherbark.",

	-- Step 24: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Retournez à l'ouest jusqu'à {area:350} ; les Forestiers et Tireurs d'élite du Haut-val restent près du gîte, les Eclaireurs et Estafettes du Haut-val sur les pentes au sud.",

	-- Step 25: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "pour {npc:6986} à {zone:1454}, vers le niveau 50",

	-- Step 26: Vilebranch soothsayers
	["Vilebranch soothsayers"] = "Devins Vilebranch",
	-- {area:355} Altar of Zul · {npc:8636} Morta'gya the Keeper
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "En revenant vers l'est, les Devins Vilebranch tiennent {area:355}, le temple troll au sud des collines centrales. Qiaga la Gardienne et {npc:8636} (élite, 50) se tiennent au sommet : affrontez les devins sur les marches du bas.",

	-- Step 27: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Le Crâne du veneur Malkhor se trouve sur un tas sous les ruines Vilebranch, les Os du veneur Malkhor sur un tas au pied de {area:354}. Les Calices de sang corrompu sont posés sur les terrasses inférieures, et {npc:14757} est retenu au sommet. Restez sur les chemins : les trolls à l'intérieur sont des élites.",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, au sommet de {area:354}",
	-- {area:355} Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "Sa demande suivante, qui mène à {area:355}, est pour un groupe.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Allez tout à l'ouest jusqu'à {area:348}, la ville des Wildhammer, et déposez le message près du puits en son centre. La ville est pleine de gardes de l'Alliance : entrez, déposez-le et repartez.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Puits de {area:348}",

	-- Step 30: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "Le guide suivant commence ici, à {area:3317}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Suivez les routes vers l'est à travers {zone:1425} jusqu'au village troll de la côte est.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Le Crâne du veneur Malkhor repose sur un tas sous les ruines Vilebranch, ses os sur un tas au pied de {area:354}. Les Calices de {spell:19478} se trouvent sur les terrasses inférieures, et {npc:14757} est retenu au sommet. Restez sur les chemins : les trolls à l'intérieur sont des élites.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Depuis {area:272}, allez au nord-est jusqu'à {zone:1425}, puis à l'est le long de la route ; {npc:7801} campe sur la colline au sud de {area:350}, le gîte des elfes.",
}
