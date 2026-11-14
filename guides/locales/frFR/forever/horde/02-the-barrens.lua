-- French (frFR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} The Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {npc:5810} Uzzek
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {area:379} sits just above it on the {zone:1413} side. {npc:3337}, {quest:809} and {npc:5810} stand together."] = "Quittez {zone:1454} par la grande porte et suivez la route vers le sud à travers {zone:1411}, puis vers l'ouest par le pont de la {area:814} : le {area:379} se trouve juste au-dessus, du côté des {zone:1413}. {npc:3337}, {quest:809} et {npc:5810} se tiennent ensemble.",
	-- {npc:3337} Kargal Battlescar · {quest:840} Conscript of the Horde · {zone:1411} Durotar
	["{npc:3337}: {quest:840}, from {zone:1411}"] = "{npc:3337} : {quest:840}, depuis {zone:1411}",
	-- {quest:809} Ak'Zeloth · {npc:3337} Kargal Battlescar · {npc:3216} Neeru Fireblade · {zone:1454} Orgrimmar
	["{quest:809}, beside {npc:3337}: from {npc:3216} in {zone:1454}"] = "{quest:809}, à côté de {npc:3337} : de la part de {npc:3216} à {zone:1454}",

	-- Step 3: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {npc:5810} Uzzek · {area:379} Far Watch Post
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {npc:5810} stands at {area:379} just above it, on the road to the Crossroads."] = "Quittez {zone:1454} par la grande porte et suivez la route vers le sud à travers {zone:1411}, puis vers l'ouest par le pont de la {area:814} : {npc:5810} se tient au {area:379}, juste au-dessus, sur la route de la Croisée.",

	-- Step 4: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "Vous arrivez du {area:379}. {npc:3489} et {npc:3338} se tiennent près de l'auberge, Helbrim et {npc:3464} près de la porte nord ; {npc:3615}, {npc:3429} et {npc:3449} sur la plateforme de la tour.",
	-- {npc:3390} Apothecary Helbrim · {quest:1358} Sample for Helbrim
	["{npc:3390}: {quest:1358}, from Zinge"] = "{npc:3390} : {quest:1358}, de la part de Zinge",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "{npc:3615}, sur la tour",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449} : les harpies viendront plus tard, dans {area:383}",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} campe au bord de la route à l'est, vers {area:392}.",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Camp Tranchecrin",
	-- {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the Crossroads. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "Le camp Tranchecrin se trouve à l'est de la Croisée. Guerriers : le {object:58369} se trouve dans le camp. Chamans : les huttiers lâchent le {item:5026}.\nAttention : le coffre est à côté d'un chariot cassé, gardé par deux Tranchecrin, dont des chasseurs qui peuvent attirer d'autres huttiers dans le combat.",

	-- Step 7: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "Camp Tranchecrin : les huttiers de {npc:3429}",
	-- {npc:3429} Thork
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "Tant que vous êtes dans le camp : les Sourciers et les Tisseuses d'épines de {npc:3429} dans sa moitié ouest, les Chasseurs au milieu, les caisses de ravitaillement à son extrémité est.\nAttention : les Dévoreuses et les Berserkers tranchecrin (18-19) sont des élites ; ils se tiennent au nord-est du camp, à côté des caisses de ravitaillement : attirez les hurans un par un loin d'eux.",

	-- Step 9: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine again. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "Retournez vers l'est par le pont et remontez le sentier jusqu'au sanctuaire de {npc:5900}. {npc:5900} fabrique {item:6636} avec le goudron et la bourse. Utilisez-le près du brasero à côté de lui pour révéler {npc:5893}, tuez-la pour obtenir {item:6655}, puis placez la braise dans le brasero.",

	-- Step 11: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907} : {npc:2523}, votre {item:5176} et le {item:263412}",

	-- Step 13: The Crossroads
	-- {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn: {npc:3338} by the inn, Helbrim and {npc:3464} by the north gate, then up the tower to {npc:3615}, the wind rider master, {npc:3429} and {npc:3449}, and {npc:3448} at the south gate on the way out."] = "{area:380} est votre base pour ce guide. Tous ceux dont vous avez besoin se tiennent à quelques pas de l'auberge : {npc:3338} près de l'auberge, Helbrim et {npc:3464} près de la porte nord, puis en haut de la tour {npc:3615}, le maître des coursiers du vent, {npc:3429} et {npc:3449}, et {npc:3448} à la porte sud en sortant.",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, en haut de la tour",

	-- Step 14: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "Têtes de raptor en chemin",
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the Crossroads, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "Les raptors Solécaille parcourent les plaines au nord et à l'est de la Croisée, et environ trois sur quatre lâchent une tête : tuez ceux que vous croisez en chemin. Attention : les Hurleurs solécaille appellent leurs alliés à moins de 30 m une fois sous 30 % de vie.",

	-- Step 15: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "Becs de trotteur des plaines en chemin",
	-- {zone:1413} The Barrens
	["Plainstriders roam the plains all over the {zone:1413}, and about one in four drops a beak: kill the ones you pass on the way."] = "Les Trotteurs des plaines parcourent les plaines partout dans les {zone:1413}, et environ un sur quatre lâche un bec : tuez ceux que vous croisez en chemin.",

	-- Step 16: Razormane camp
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "Dans le camp, les Sourciers et les Tisseuses d'épines tiennent la moitié ouest, les Chasseurs le milieu ; les caisses de ravitaillement sont à son extrémité est.\nLes Trotteurs des plaines d'ici comptent pour les becs.\nAttention : les Dévoreuses et les Berserkers tranchecrin (18-19) sont des élites ; ils se tiennent au nord-est du camp, à côté des caisses de ravitaillement : attirez les hurans un par un loin d'eux.",

	-- Step 17: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "Finir les Becs de trotteur des plaines",
	["Still short of seven? Plainstriders are thickest on the plains north of the Crossroads, along the road north."] = "Pas encore les sept ? Les Trotteurs des plaines sont les plus nombreux dans les plaines au nord de la Croisée, le long de la route du nord.",

	-- Step 19: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "Les Messagers zhévras paissent le long de la route vers l'est en direction de {area:392} : prenez leurs sabots en sortant.",

	-- Step 20: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Suivez la route vers le sud-est jusqu'à {area:392}, sur la côte.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, à l'étage",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442} : la console est dans {area:382}, plus tard",
	-- {npc:16227} Bragok · {npc:3442} Sputtervalve
	["{npc:16227}, beside {npc:3442}"] = "{npc:16227}, à côté de {npc:3442}",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Affiche {object:3972}",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, sur le quai",
	-- {quest:1492} Wharfmaster Dizzywig · {area:381} Boulder Lode Mine
	["{quest:1492}: the emerald comes from the {area:381}, later"] = "{quest:1492} : l'émeraude vient de la {area:381}, plus tard",

	-- Step 21: The Barrens: kill these as you meet them
	-- {zone:1413} The Barrens
	["{zone:1413}: kill these as you meet them"] = "{zone:1413} : tuez-les au passage",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}: the piles of complicated parts lie in the sand among them, and {npc:3467} stands at the camp's southern end."] = "Les pirates campent sur la plage au sud de {area:392} : les tas de pièces compliquées sont dans le sable au milieu d'eux, et le {npc:3467} se tient à l'extrémité sud du camp.",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {area:385} Northwatch Hold
	["{npc:3391}: the crates lie at the south end of the beach camp, on the walk to {area:385} at 18"] = "{npc:3391} : les caisses se trouvent à l'extrémité sud du camp de la plage, sur le trajet vers le {area:385} au niveau 18",

	-- Step 23: Fly to Crossroads
	["Fly to Crossroads"] = "Prendre un vol pour la Croisée",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 25: Gur'ak
	-- {npc:267310} Gur'ak · {quest:97003} Chol'aruk the Ravener · {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:3438} Kreenig Snarlsnout
	["{npc:267310} stands on the north-east side of the Crossroads. {quest:97003} is a group quest: {npc:267307} is a level 20 elite boar in the Razormane's {area:1699} cave, east of the town, where the route goes back for {npc:3438} later."] = "{npc:267310} se tient dans la partie nord-est de la Croisée. {quest:97003} est une quête de groupe : {npc:267307} est un sanglier élite de niveau 20 dans la grotte de {area:1699} des Tranchecrin, à l'est de la ville, où l'itinéraire revient plus tard pour {npc:3438}.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["West to {npc:3389}'s watch post on the Kolkar border."] = "À l'ouest vers le poste de guet de {npc:3389}, à la frontière kolkar.",

	-- Step 27: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "Les bassins se trouvent juste au nord de {npc:3389}. Entrez dans l'eau pour les explorer ; les Champignons chargés pour Helbrim poussent autour. Tuez chaque kolkar sur votre passage pour les brassards. {npc:3394} se tient dans le camp kolkar à l'ouest des bassins.",

	-- Step 28: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis
	["{npc:3389}: {npc:3395} walks with the Kolkar at the {area:388}, later"] = "{npc:3389} : {npc:3395} marche avec les kolkars à {area:388}, plus tard",

	-- Step 29: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "Vers l'ouest jusqu'à {area:383}. Les harpies Ensorçaile nichent partout ; n'importe laquelle peut lâcher une serre. {quest:819} se trouve dans leurs collines. Les Rôdeurs des savanes chassent dans les plaines entre {npc:3389} et les collines : prenez leurs griffes en chemin.\nAttention : il y a 2 Embusquées Ensorçaile (niveau 17-18). Elles restent camouflées grâce à Furtivité tant qu'elles ne sont pas en combat.",

	-- Step 30: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "La {object:4141} se trouve sur le site de recherche de la KapitalRisk, à l'ouest de {area:382}. Fermez les trois vannes autour de la foreuse, utilisez à nouveau la console, puis prenez la {item:5089} sur l'{npc:3471}, juste à côté.\nAttention : plusieurs gardes se tiennent à portée d'aggro des vannes, réapparaissent en moins de 3 minutes environ et fuient à faible vie pour ramener de l'aide ; les monstres proches se joignent aussi au combat si vous utilisez une vanne près d'eux.",
	["Inside"] = "À l'intérieur",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: on the next {area:392} stop"] = "{npc:3442} à {area:392} : lors de la prochaine étape à {area:392}",

	-- Step 31: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout · {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them. Careful: Razormane Flesheaters and Berserkers (18-19) are elites in the camp's north-east, near {npc:3438} and the supply crates, and {npc:267307} (20, elite) lies in the cave under {area:1699} beside them: pull {npc:3438} and the quilboar away from them one at a time, and leave the cave alone unless you are in a group."] = "Retour au camp Tranchecrin. Les Géomanciennes et les Défenseurs tiennent sa moitié est ; {npc:3438} se promène parmi eux. Attention : les Dévoreuses et les Berserkers tranchecrin (18-19) sont des élites au nord-est du camp, près de {npc:3438} et des caisses de ravitaillement, et {npc:267307} (20, élite) se trouve dans la grotte sous {area:1699}, à côté d'eux : attirez {npc:3438} et les hurans un par un loin d'eux, et laissez la grotte tranquille sauf si vous êtes en groupe.",

	-- Step 32: Chol'aruk
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:267307} (level 20 elite) needs a group of 3 and sits deep in the cave under {area:1699}, past the Razormane Flesheaters and Berserkers (18-19, elite). Skip it if you are alone."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:267307} (élite de niveau 20) demande un groupe de 3 et se tient au fond de la grotte sous {area:1699}, après les Dévoreuses et les Berserkers tranchecrin (18-19, élites). Passez-le si vous êtes seul.",

	-- Step 33: The Crossroads
	-- {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3432} Mankrik · {npc:3448} Tonga Runetotem · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:383} Dry Hills · {quest:853} Apothecary Zamah · {zone:1456} Thunder Bluff
	["{npc:3338} by the inn first, then Helbrim by the north gate, {npc:3429} and {npc:3449} on the tower platform, {npc:3432} by the inn, and {npc:3448} at the south gate last. His seed test waits for the {npc:3395} pass at the {area:388}: go straight on north-west to the {area:383}. After the spores Helbrim offers {quest:853}, a delivery to {zone:1456} within 45 minutes: this route doesn't go there, so leave it (Druids take it on the next Crossroads stop, right before their flight to {zone:1456})."] = "{npc:3338} près de l'auberge d'abord, puis Helbrim près de la porte nord, {npc:3429} et {npc:3449} sur la plateforme de la tour, {npc:3432} près de l'auberge, et {npc:3448} à la porte sud en dernier. Son test des graines attend le passage pour {npc:3395} à {area:388} : continuez tout droit vers le nord-ouest jusqu'à {area:383}. Après les spores, Helbrim propose {quest:853}, une livraison à {zone:1456} en moins de 45 minutes : cet itinéraire n'y va pas, laissez-la donc (les druides la prennent à l'arrêt suivant à la Croisée, juste avant leur vol pour {zone:1456}).",
	-- {npc:3432} Mankrik
	["{npc:3432}: his wife lies at the north edge of the Bristleback camps, later"] = "{npc:3432} : sa femme gît à la lisière nord des camps Dos-hirsute, plus tard",
	-- {npc:3448} Tonga Runetotem · {area:388} Stagnant Oasis · {npc:3395} Verog the Dervish
	["{npc:3448}: the bubbling fissure at the {area:388}, on the {npc:3395} pass"] = "{npc:3448} : la fissure bouillonnante à {area:388}, lors du passage pour {npc:3395}",

	-- Step 35: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "Au nord-ouest jusqu'à {area:383} : les Tueuses Ensorçaile en tiennent l'extrémité ouest ; ce sont elles qui portent les anneaux.\nAttention : des harpies embusquées et camouflées attendent dans la zone et restent cachées jusqu'à ce que vous approchiez. Une harpie élite de niveau 19 patrouille aussi par là.",

	-- Step 37: Raptor Horns
	-- {quest:881} Echeyakee · {area:383} Dry Hills · {item:5055} Intact Raptor Horn · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["On the way east to {quest:881}: Sunscale Scytheclaws prowl the plains east of the {area:383}; any of them can drop an {item:5055} for {npc:3446} in {area:392}."] = "En allant vers l'est jusqu'à {quest:881} : des Faucheurs solécaille rôdent dans les plaines à l'est des {area:383} ; n'importe lequel peut lâcher une {item:5055} pour {npc:3446} à {area:392}.",

	-- Step 38: Echeyakee
	-- {quest:881} Echeyakee
	["South-east on the way back to the Crossroads: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "Au sud-est, sur le chemin du retour vers la Croisée : {quest:881}, un lion blanc, rôde dans les plaines au nord du camp Tranchecrin.\nAttention : des Chasseresses des savanes errent autour du repaire. Elles réapparaissent vite et rejoignent souvent le combat aux côtés de {quest:881} : éliminez-les avant de souffler dans la corne.\nLes raptors Solécaille d'ici comptent pour les têtes.",

	-- Step 39: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "Finir les Têtes de raptor",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Lashtails = {npc:3254} Sunscale Lashtail
	["Still short of twelve? Sunscale Lashtails and Screechers roam the plains north-east of the Crossroads, on the way back south from {quest:881}'s lair."] = "Pas encore les douze ? Les Flagellants et les Hurleurs solécaille parcourent les plaines au nord-est de la Croisée, sur le chemin du retour vers le sud depuis le repaire de {quest:881}.",

	-- Step 40: The Crossroads
	-- {npc:3464} Gazrog · {npc:3338} Sergra Darkthorn · {npc:3449} Darsok Swiftdagger · {npc:3429} Thork
	["In from the north gate: {npc:3464} first, {npc:3338} by the inn, then up to {npc:3449} and {npc:3429} on the tower platform, where the flight master stands."] = "Entrez par la porte nord : d'abord {npc:3464}, {npc:3338} près de l'auberge, puis montez voir {npc:3449} et {npc:3429} sur la plateforme de la tour, où se tient le maître de vol.",
	-- {npc:3464} Gazrog · {quest:3281} Stolen Silver · {area:385} Northwatch Hold
	["{npc:3464}: the {quest:3281}, in a raptor nest north-west of {area:385}"] = "{npc:3464} : l'{quest:3281}, dans un nid de raptor au nord-ouest du {area:385}",
	-- {npc:3390} Apothecary Helbrim · {zone:1456} Thunder Bluff
	["{npc:3390}: 45 minutes, for Zamah on the {zone:1456} step next"] = "{npc:3390} : 45 minutes, pour Zamah à l'étape suivante, à {zone:1456}",
	-- {npc:3338} Sergra Darkthorn
	["{npc:3338}: the raptor nests south of the Crossroads"] = "{npc:3338} : les nids de raptors au sud de la Croisée",
	-- {npc:3449} Darsok Swiftdagger · {quest:876} Serena Bloodfeather · {area:383} Dry Hills
	["{npc:3449}, on the tower: {quest:876} leads the harpies in the {area:383}"] = "{npc:3449}, sur la tour : {quest:876} mène les harpies des {area:383}",
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}, on the tower, from level 17. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}, sur la tour, dès le niveau 17. Gardez-la : Kadrak au {area:1703}, guide suivant",

	-- Step 41: Thunder Bluff
	-- {area:1638} Thunder Bluff · {quest:853} Apothecary Zamah · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from the Crossroads to {area:1638}. {quest:853} waits in the {area:2197}, the cave under {area:1640}: hand in the spores there first, while their time runs. Then {npc:3033} trains you on {area:1639}."] = "Volez de la Croisée à {area:1638}. {quest:853} attend dans {area:2197}, la grotte sous la {area:1640} : rendez-y d'abord les spores, tant que leur temps court. Ensuite, {npc:3033} vous entraîne sur la {area:1639}.",
	-- {quest:853} Apothecary Zamah · {area:2197} Pools of Vision
	["{quest:853}, in the {area:2197}"] = "{quest:853}, dans {area:2197}",

	-- Step 42: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Lancez {spell:18960}",

	-- Step 43: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:28} Trial of the Lake
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}. {quest:28} runs on a timer: no teleport or Hearthstone until {npc:11799} has it."] = "{npc:11802} se tient à l'étage de son bâtiment à {area:2361} : montez par l'intérieur, la flèche ne distingue pas les étages. Les Colifichets du sanctuaire reposent au fond du {area:656} et disparaissent en quelques minutes : nagez avec l'un d'eux directement jusqu'au {area:2362}, sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}. {quest:28} est minutée : ni téléportation ni pierre de foyer tant que {npc:11799} ne l'a pas.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127} : {area:384}, guide suivant",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, dans un {object:177785} au fond du lac",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Au {area:2362}",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, à {area:2362}",
	-- {quest:30} Trial of the Sea Lion · {area:382} Sludge Fen · {area:287} Hillsbrad
	["{quest:30}, carried: one half pendant in the {area:382} in this guide, the other underwater off Silverpine on the way to {area:287} at 21; the pendant is handed in after {area:287}"] = "{quest:30}, à garder : une moitié de pendentif dans le {area:382} dans ce guide, l'autre sous l'eau au large de la forêt des Pins-Argentés sur le chemin d'{area:287} au niveau 21 ; le pendentif se rend après {area:287}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} à {area:2361} y emmène les druides",

	-- Step 44: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} straight on to {area:392}."] = "Prenez un vol depuis les {zone:1456} directement jusqu'à {area:392}.",

	-- Step 45: Fly to Ratchet
	["Crossroads flight master"] = "Maître de vol de la Croisée",

	-- Step 47: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {area:392} Ratchet
	["{npc:3446}, beside the {object:3972} poster: take it now if he did not offer it on the first {area:392} stop"] = "{npc:3446}, à côté de l'affiche {object:3972} : prenez-la maintenant s'il ne l'a pas proposée lors de la première halte à {area:392}",

	-- Step 48: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED
	["{npc:3446}, beside the {object:3972} poster"] = "{npc:3446}, à côté de l'affiche {object:3972}",

	-- Step 49: Mebok Mizzyrix
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {quest:1491} Smart Drinks
	["For your {area:718} run: {npc:3446}'s next errand, {quest:1491}."] = "Pour votre expédition dans {area:718} : la mission suivante de {npc:3446}, {quest:1491}.",

	-- Step 51: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks · {area:1076} Webwinder Path
	["{npc:3442}: keep it, {quest:1483} is on the {area:1076} in Stonetalon, at the end of this guide"] = "{npc:3442} : gardez-la, {quest:1483} se trouve sur le {area:1076}, dans les Serres-Rocheuses, à la fin de ce guide",
	-- {npc:3442} Sputtervalve · {npc:9316} Wenikee Boltbucket · {area:382} Sludge Fen
	["{npc:3442}: {npc:9316} stands on the road north of the Crossroads, on the way to the {area:382}"] = "{npc:3442} : {npc:9316} se tient sur la route au nord de la Croisée, sur le chemin du {area:382}",

	-- Step 52: Bruuz
	-- {npc:209797} Bruuz
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:209797} (élite de niveau 20) demande un groupe de 2. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",

	-- Step 53: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:3391} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- Step 54: Raptor nests
	["Raptor nests"] = "Nids de raptors",
	-- {area:392} Ratchet · {area:1697} Raptor Grounds · {item:5165} Sunscale Feather
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["South-west from {area:392} across the plains to the {area:1697}: the three nests sit together south-west of the oasis, and Sunscale Scytheclaws guard them. Each nest needs a {item:5165}: kill Sunscale raptors (most drop one) until you have three, then use a feather at each nest."] = "Au sud-ouest de {area:392}, traversez les plaines jusqu'à {area:1697} : les trois nids se trouvent ensemble au sud-ouest de l'oasis, et des Faucheurs solécaille les gardent. Chaque nid demande une {item:5165} : tuez des raptors solécaille (la plupart en laissent tomber une) jusqu'à en avoir trois, puis utilisez une plume à chaque nid.",

	-- Step 55: Raptor Grounds: kill these as you meet them
	-- {area:1697} Raptor Grounds
	["{area:1697}: kill these as you meet them"] = "{area:1697} : tuez-les au passage",
	-- {area:1697} Raptor Grounds · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet · {area:385} Northwatch Hold
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains around the {area:1697}; they drop the horns. {npc:3446} takes them when the escort brings you back to {area:392}.\nSouth-east toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Les Faucheurs solécaille chassent dans les plaines autour de {area:1697} ; ils lâchent les cornes. {npc:3446} les prend quand l'escorte vous ramène à {area:392}.\nAu sud-est vers la côte : l'argent volé se trouve dans un nid de raptor au nord-ouest du {area:385}.",

	-- Step 56: Stolen Booty
	-- {area:385} Northwatch Hold
	["East to the beach, at the south end of the pirate camp: the crate of boots and the fragile crate with the lens sit there, a short walk north of {area:385}."] = "À l'est jusqu'à la plage, à l'extrémité sud du camp pirate : la caisse de bottes et la caisse fragile avec la lentille s'y trouvent, à quelques pas au nord de {area:385}.",

	-- Step 57: Northwatch Hold: kill these as you meet them
	-- {area:385} Northwatch Hold
	["{area:385}: kill these as you meet them"] = "{area:385} : tuez-les au passage",
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast just south of the pirate camp. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "{area:385}, sur la côte juste au sud du camp des pirates. Les Soldats de marine et les Préservateurs de Theramore (15-16) lâchent les médailles ; {npc:3393} (20) et les deux canonniers (19) se tiennent dans le donjon et sur ses murs, et c'est pour eux que le fort attend jusqu'à maintenant.\nAttention : chaque cible nommée est liée à un soigneur et à des gardes, et Fairmount a trois soldats de marine de plus avec elle. Tuer d'abord le soigneur facilite le combat.",
	["On the top floor"] = "Au dernier étage",
	["Upstairs"] = "À l'étage",

	-- Step 58: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} est enchaîné dans le fort. Parlez-lui pour lancer l'escorte et restez près de lui : des soldats de Theramore attaquent à la sortie. Il vous ramène à {area:392}.",

	-- Step 66: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Head north from the Crossroads to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the Crossroads. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Allez vers le nord depuis la Croisée jusqu'au {area:384} et remplissez l'{item:15842} au {object:19464}, puis retournez voir {npc:3448} à la Croisée. Pas d'{skill:182} ? {npc:3490}, à côté de lui, vend de la {item:2449}, trois à la fois jusqu'à son réapprovisionnement.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} auprès de {npc:3490} ; les herboristes en cueillent dans les plaines",

	-- Step 67: Kolkar camp
	["Kolkar camp"] = "Camp kolkar",
	-- {npc:3389} Regthar Deathgate · {item:2449} Earthroot
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "Des Kodos égarés des Tarides parcourent les plaines autour du camp kolkar au nord-ouest de {npc:3389} ; les herboristes y cueillent aussi de la {item:2449}.",

	-- Step 68: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Au nord vers les {area:383}. {npc:3682} campe au pied des collines ; {npc:261366}, l'ermite sur la crête derrière lui, n'a du travail pour vous qu'une fois que {npc:3682} vous y envoie.",

	-- Step 69: The Barrens: kill these as you meet them
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "Les Patriarches des savanes parcourent les plaines à l'est des collines, et les Pièges déclenchés se trouvent au milieu d'eux. {quest:876} dirige les harpies Ensorçaile dans les collines à l'ouest.\nAttention : le chemin d'accès passe près de harpies embusquées camouflées et d'une harpie élite qui patrouille.",
	-- {quest:865} Raptor Horns
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "{quest:865}, si elle est encore en cours : des Faucheurs solécaille rôdent parmi les lions",

	-- Step 72: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "Le {npc:262119} et ses soldats de marine tiennent la caravane détruite au sud de {npc:261366}. Les soldats sont liés : en attirer un fait venir les autres. Attirez-les depuis le bord et courez ; ils abandonnent vite la poursuite, vous pouvez donc éclaircir le camp un par un avant d'affronter le caporal.",

	-- Step 73: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Aidez {npc:261366} : restez près de lui quand {npc:261367} et les soldats de marine de {area:21} montent la crête",

	-- Step 74: Wenikee Boltbucket
	-- {npc:261366} Walton · {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["East from {npc:261366} toward the {area:382}: {npc:9316} stands at the camp on the road north of the Crossroads."] = "À l'est depuis {npc:261366} en direction de {area:382} : {npc:9316} se tient au camp sur la route au nord de la Croisée.",

	-- Step 75: Ignition
	-- {npc:3439} Wizzlecrank's Shredder · {area:382} Sludge Fen · {npc:3445} Supervisor Lugwizzle
	["{npc:3439} stands inside the Venture Co. camp in the {area:382}; {npc:3445} carries the key."] = "Le {npc:3439} se trouve dans le camp de la KapitalRisk, dans {area:382} ; le {npc:3445} porte la clé.",

	-- Step 76: Strange Lockbox
	-- {object:177794} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177794} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177794} se trouve au bord nord de {area:382}, près de la tour de la KapitalRisk. Il contient le {item:15883} pour {quest:30}.",

	-- Step 77: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "Wizzlecrank sort du camp avec son déchiqueteur : restez avec lui et tuez tout ce qui l'attaque. {npc:3442} le récupère à {area:392}.\nAttention : la route mène vers l'ouest et monte une rampe. Une fois en haut, deux monstres de la KapitalRisk vous tendent une embuscade.",

	-- Step 78: Nugget Slugs
	-- {area:382} Sludge Fen
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}."] = "Les seaux à outils avec les rondelles se trouvent autour du site de forage de la KapitalRisk, dans {area:382}.",

	-- Step 79: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Les Surveillants de la KapitalRisk et Massacreurs de la KapitalRisk de la mine au nord-est de la zone laissent l'{item:5097}.",

	-- Step 80: Wenikee Boltbucket
	-- {npc:9316} Wenikee Boltbucket
	["West from the mine to {npc:9316}'s camp, then south down the road to the Crossroads."] = "À l'ouest de la mine jusqu'au camp de {npc:9316}, puis descendez la route vers le sud jusqu'à la Croisée.",
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the {zone:1454} trip at 20"] = "Gardez-le : {quest:3923} se fait dans la {object:172958} d'{zone:1454}, lors du passage à {zone:1454} au niveau 20",

	-- Step 81: the Crossroads
	["the Crossroads"] = "la Croisée",
	-- {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["South down the road to the Crossroads: {npc:3449} stands on the tower platform, {npc:3448} at the south gate."] = "Descendez la route vers le sud jusqu'à la Croisée : {npc:3449} se tient sur la plateforme de la tour, {npc:3448} à la porte sud.",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Il vous donne le {item:15826}",

	-- Step 82: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {npc:3448} Tonga Runetotem
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Test {npc:3448}'s seeds at the bubbling fissure on the oasis' east bank while you are there."] = "{npc:3395} se promène parmi les Kolkar à {area:388}, au sud-est de la Croisée. Testez les graines de {npc:3448} à la fissure bouillonnante sur la rive est de l'oasis pendant que vous y êtes.",
	["Underwater"] = "Sous l'eau",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the Crossroads"] = "{npc:12296} : utilisez l'{item:15826} sur elles ; elles parcourent les plaines tout autour de la Croisée",
	-- {npc:12296} Sickly Gazelle
	["Cure {npc:12296}"] = "Soignez : {npc:12296}",

	-- Step 83: Bristleback camps
	["Bristleback camps"] = "Camps Dos-hirsute",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {npc:3430} Mangletooth · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. {npc:3432}'s wife lies at their north edge, on your way south. Leave the quilboar for now: {npc:3430} in {area:378} wants the same camps cleared. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Les camps des huttiers Dos-hirsute s'étendent sur les plaines au nord du {area:378}, de part et d'autre de la {area:458}. La femme de {npc:3432} gît à leur lisière nord, sur votre chemin vers le sud. Laissez les huttiers pour l'instant : {npc:3430}, au {area:378}, veut qu'on nettoie ces mêmes camps. {quest:883}, un kodo gris, erre parfois par ici : son sabot lance une quête.",

	-- Step 84: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Suivez la {area:458} vers le sud jusqu'au {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, dans la cage",

	-- Step 85: Bramblescar
	-- {npc:3432} Mankrik · {npc:3430} Mangletooth · {item:5075} Blood Shard
	["Back north into the Bristleback camps. Any Bristleback can drop a tusk for {npc:3432}, so collect them while you kill these for {npc:3430}. Keep one {item:5075}."] = "Retournez vers le nord dans les camps Dos-hirsute. N'importe quel Dos-hirsute peut lâcher une défense pour {npc:3432}, alors ramassez-les pendant que vous tuez ceux-ci pour {npc:3430}. Gardez un {item:5075}.",

	-- Step 88: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran · {item:5075} Blood Shard · {npc:3430} Mangletooth · {area:378} Camp Taurajo
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate. Keep the {item:5075}: {npc:3430} takes it on the next stop in {area:378}."] = "Remontez la {area:458} vers le nord jusqu'à la Croisée : {npc:3448} à la porte sud, {npc:3432} près de l'auberge, {npc:3428} à l'ouest de la porte nord. Gardez l'{item:5075} : {npc:3430} la prendra lors du prochain passage au {area:378}.",
	-- {npc:3448} Tonga Runetotem · {area:387} Lushwater Oasis · {npc:3396} Hezrul Bloodmark · {zone:1454} Orgrimmar
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3448}: the Oasis Snapjaws at {area:387}, with {npc:3396} after the {zone:1454} trip"] = "{npc:3448} : les Gueules d'acier des oasis à {area:387}, avec {npc:3396} après le voyage à {zone:1454}",
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} propose {quest:95774} une fois {quest:4921} rendue",
	-- {npc:3428} Korran · {area:390} Field of Giants · {area:378} Camp Taurajo · {zone:1454} Orgrimmar
	["{npc:3428}: the eggs are in the {area:390}, south of {area:378}, after the {zone:1454} trip"] = "{npc:3428} : les œufs sont dans le {area:390}, au sud du {area:378}, après le passage à {zone:1454}",

	-- Step 89: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:1637} Orgrimmar · {npc:3615} Devrak
	["Train your level 20 ranks in {area:1637} now: fly from {npc:3615} on the Crossroads' tower."] = "Apprenez maintenant vos rangs du niveau 20 à {area:1637} : prenez un vol auprès de {npc:3615}, sur la tour de la Croisée.",

	-- Step 90: Orgrimmar
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "{npc:3354} est dans la {object:172958}, {npc:5892} dans la {object:172957}.",

	-- Step 91: Valley of Honor
	-- {quest:3923} Rilli Greasygob · {object:172958} Valley of Honor
	["{quest:3923} stands by the {object:172958}'s water, east of the Drag."] = "{quest:3923} se tient au bord de l'eau de la {object:172958}, à l'est de la Herse.",

	-- Step 92: Shenthul
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382} on the next guide's walk north"] = "{quest:2458} : {npc:7233}, près du {area:382}, sur le trajet vers le nord du guide suivant",

	-- Step 93: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Quêtes de classe à {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} se tient dans {object:172961}, à l'ouest de la ville.",

	-- Step 94: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} est le canyon sous {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, à quelques pas",

	-- Step 95: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} se tient dans la {object:172961}, à l'ouest de la ville.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018} : {npc:4606} à {zone:1458}, dans deux guides",

	-- Step 97: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["Train your level 20 ranks: {npc:246344} teaches Paladins in {area:1638}; {zone:1454} has no Paladin trainer. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "Apprenez vos rangs du niveau 20 : {npc:246344} forme les Paladins aux {area:1638} ; {zone:1454} n'a pas de maître Paladin. Vous n'avez pas encore ce trajet aérien : volez jusqu'au {area:378}, allez vers l'ouest à travers {zone:1412} et montez par un ascenseur, puis prenez le trajet auprès de {npc:2995} sur la mesa centrale.",

	-- Step 99: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:499} Cat Form · {spell:526} Cure Poison · {zone:1450} Moonglade · {npc:11798} Bunthen Plainswind · {area:392} Ratchet
	["Fly from the Crossroads to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}. {spell:499} and {spell:526} follow in {zone:1450} on the same trip, then {npc:11798} flies you back here and on to {area:392}."] = "Prenez un vol depuis la Croisée jusqu'aux {area:1638} et apprenez vos rangs du niveau 20 : {npc:3033} est sur la {area:1639}. {spell:499} et {spell:526} suivent à {zone:1450} lors du même voyage, puis {npc:11798} vous ramène ici en vol et continue jusqu'à {area:392}.",

	-- Step 100: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "Lancez {spell:18960}. {npc:11802} se tient à l'étage de son bâtiment à {area:2361} : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- Step 102: Moonglade
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} se tient à l'étage de son bâtiment à {area:2361} : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- Step 103: Moonglade
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802} : l'accueil de {npc:3033}",

	-- Step 104: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	-- plural, as words: Territorial Terrans = {npc:230558} Territorial Terran
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. Careful: the spirits are Territorial Terrans (level 60) that kill whoever they see: stay off their paths, and click the statue again before the stealth runs out."] = "Taurens : le {npc:11957} attend sur la colline sud au-dessus du pont. Éolides : l'{npc:272054} se tient au sud des ponts jumeaux. Ensuite, les tanières à l'est du lac : quittez votre forme, cliquez sur la statue à l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de chat blanc. Attention : les esprits sont des Territorial Terrans (niveau 60) qui tuent quiconque ils voient : restez hors de leurs trajets, et cliquez de nouveau sur la statue avant la fin du camouflage.",

	-- Step 107: Fly to Ratchet
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} on to {area:392}."] = "Prenez un vol depuis les {zone:1456} jusqu'à {area:392}.",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 108: Fly to Ratchet
	-- {area:392} Ratchet · {object:172982} Valley of Strength
	["Fly on to {area:392} from Doras on the tower in the {object:172982}."] = "Continuez en vol jusqu'à {area:392} depuis Doras, sur la tour de la {object:172982}.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 110: Ratchet: Wailing Caverns quests
	-- {area:392} Ratchet · {area:718} Wailing Caverns
	["{area:392}: {area:718} quests"] = "{area:392} : quêtes de {area:718}",
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {npc:3665} Crane Operator Bigglefuzz · {npc:3396} Hezrul Bloodmark
	["Your {area:718} quests, if you have not taken them yet: {npc:3446} beside the {object:3972} poster, {npc:3665} on the dock by the flight master. The run is later in this guide, after {npc:3396}."] = "Vos quêtes de {area:718}, si vous ne les avez pas encore prises : {npc:3446} à côté de l'affiche {object:3972}, {npc:3665} sur le quai près du maître de vol. L'expédition se fait plus loin dans ce guide, après {npc:3396}.",

	-- Step 111: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} attend sur la colline au sud de {area:392}, sur votre route vers le nord.",

	-- Step 112: Ishamuhale
	-- {quest:882} Ishamuhale · {item:10338} Fresh Zhevra Carcass · {object:147538} Dead Tree (no name in this language: may be words) · {area:392} Ratchet
	["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the Crossroads, and be ready when he arrives."] = "{quest:882}, un grand raptor solécaille, ne vient que sur une proie fraîche : prenez une {item:10338} sur un zhévra, puis utilisez-la près de {object:147538} au nord-ouest de {area:392}, au nord de la route de la Croisée, et soyez prêt quand il arrive.",
	-- {item:10338} Fresh Zhevra Carcass
	-- plural, as words: Zhevra Chargers = {npc:3426} Zhevra Charger
	["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "{item:10338}, sur n'importe quel zhévra ; des Étalons zhévra paissent autour de l'arbre",
	-- {object:147538} Dead Tree (no name in this language: may be words) · {quest:882} Ishamuhale
	["At the {object:147538}: summons {quest:882}"] = "À l'arbre mort : invoque {quest:882}",

	-- Step 113: Gazrog
	-- {npc:3464} Gazrog
	["{npc:3464}, by the Crossroads' north gate"] = "{npc:3464}, près de la porte nord de la Croisée",

	-- Step 116: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vit à {area:2539}, le village troll juste à l'entrée des Serres-Rocheuses, au bout de la route qui part vers l'ouest depuis {npc:3389}.",

	-- Step 117: To Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["To {npc:3389}"] = "Vers {npc:3389}",

	-- Step 119: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {npc:3448} Tonga Runetotem
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. He walks that shore, from about 46,36 in the north to 46,42 in the south: if he isn't at the arrow, follow the shore until you meet him. Hand his head to {npc:3389} on your last Crossroads stop. Oasis Snapjaws crawl in the oasis' water there: their shells are for {npc:3448}."] = "{npc:3396} mène les Kolkar sur la rive ouest de {area:387}, au sud de {npc:3389}. Il parcourt cette rive, d'environ 46,36 au nord à 46,42 au sud : s'il n'est pas à la flèche, suivez la rive jusqu'à le trouver. Rendez sa tête à {npc:3389} lors de votre dernier arrêt à la Croisée. Des Gueules d'acier des oasis rampent là dans l'eau de l'oasis : leurs carapaces sont pour {npc:3448}.",

	-- Step 120: Nalpak and Ebru
	-- {npc:5767} Nalpak · {npc:5768} Ebru
	["{npc:5767} and {npc:5768}"] = "{npc:5767} et {npc:5768}",
	-- {area:718} Wailing Caverns · {npc:5767} Nalpak · {npc:5768} Ebru
	["For your {area:718} run: {npc:5767} and {npc:5768} stand in a hidden cave in the rocks above the entrance, at the north end of the oasis' west shore: climb up from the west side. Follow the arrow up."] = "Pour votre expédition dans {area:718} : {npc:5767} et {npc:5768} se tiennent dans une grotte cachée dans les rochers au-dessus de l'entrée, à l'extrémité nord de la rive ouest de l'oasis : grimpez par le côté ouest. Suivez la flèche vers le haut.",

	-- Step 121: Wailing Caverns
	-- {area:718} Wailing Caverns · {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:5767} Nalpak · {npc:3655} Mad Magglish · {item:5334} 99-Year-Old Port · {npc:5768} Ebru · {item:6464} Wailing Essence · {npc:3678} Disciple of Naralex · {npc:3654} Mutanus the Devourer · {item:10441} Glowing Shard · {area:392} Ratchet · {npc:8418} Falla Sagewind
	["{area:718} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its mouth is just north of {npc:3396}'s shore, at the north end of {area:387}, under {npc:5767}'s cave.\nIn the caves before the portal: {npc:3655}, stealthed, with the {item:5334} (he moves between a few spots and comes back slowly: leave him if he's gone). Inside: the Deviates for {npc:5768}, and their hides for {npc:5767} (they drop rarely: one run may not be enough, so leave the rest for another run), {item:6464} from the Ectoplasms. After the four Fanglords, the {npc:3678} at the entrance leads you to Naralex: {npc:3654} drops the {item:10441}: its quest (someone in {area:392}, then {npc:8418} above the caverns) is not on this route; the Dungeons page's hand-in guide takes it."] = "{area:718} est un donjon pour un groupe de cinq, vers les niveaux 17 à 24, et une expédition complète prend environ une heure. Son entrée se trouve juste au nord de la rive de {npc:3396}, à l'extrémité nord de {area:387}, sous la grotte de {npc:5767}.\nDans les grottes avant le portail : {npc:3655}, camouflé, avec le {item:5334} (il se déplace entre quelques endroits et réapparaît lentement : laissez-le s'il n'est pas là). À l'intérieur : les Déviants pour {npc:5768}, et leurs peaux pour {npc:5767} (elles tombent rarement : une expédition peut ne pas suffire, alors gardez le reste pour une autre expédition), {item:6464} sur les Ectoplasmes. Après les quatre Seigneurs du Croc, le {npc:3678} à l'entrée vous mène à Naralex : {npc:3654} lâche le {item:10441} : sa quête (quelqu'un à {area:392}, puis {npc:8418} au-dessus des cavernes) ne fait pas partie de cet itinéraire ; le guide des rendus de la page Donjons s'en charge.",
	-- {item:6464} Wailing Essence
	["{item:6464}: the Ectoplasms"] = "{item:6464} : les Ectoplasmes",

	-- Step 122: Nalpak
	["Back out of the caverns and up to the cave above the entrance."] = "Ressortez des cavernes et montez jusqu'à la grotte au-dessus de l'entrée.",

	-- Step 124: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last Crossroads stop."] = "En redescendant la {area:458} vers le {area:378} : les Pillards Tranchecrin, parmi les camps Dos-hirsute de part et d'autre de la route au nord du camp, portent les {item:277277}. Remettez-les à {npc:3432} lors de votre dernière halte à la Croisée.",

	-- Step 125: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Redescendez la {area:458} jusqu'au {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Gardez-la : {npc:12696} en {zone:1440}, guide suivant",
	-- {npc:6394} Ruga Ragetotem
	["{npc:6394}, inside"] = "{npc:6394}, à l'intérieur",

	-- Step 127: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran est enchaîné dans le camp huran à l'ouest de la route.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, on the next guide's {zone:1454} stop"] = "Gardez-la : {npc:5875} à {zone:1454}, lors de la halte à {zone:1454} du guide suivant",

	-- Step 128: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Les Têtes-tonnerre paissent dans les plaines juste au sud du {area:378}. {quest:884}, un lézard-tonnerre bleu, erre parmi eux : sa pointe caudale lance une quête.",

	-- Step 129: Jorn Skyseer
	-- {quest:1824} Trial at the Field of Giants · {npc:6394} Ruga Ragetotem
	["Warriors: take {quest:1824} from {npc:6394} now: it runs for 30 minutes from the accept. The eggs and the antennae come first, at the same mounds, then straight back to {npc:6394}; the thunderhawks after."] = "Guerriers : prenez maintenant {quest:1824} auprès de {npc:6394} : elle dure 30 minutes à partir de son acceptation. Les œufs et les antennes d'abord, aux mêmes monticules, puis retournez directement voir {npc:6394} ; les faucons-tonnerre ensuite.",

	-- Step 130: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer
	["South of Camp Taurajo, the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them.\nCareful: Silithid Swarmers in the area release many tiny adds that interrupt spells; damage shields such as Thorns kill them in one hit."] = "Au sud du camp Taurajo, les Monticules silithides parsèment le {area:390} ; les œufs s'y trouvent, et des Essaimeurs silithides en sortent pour les défendre.\nAttention : les Essaimeurs silithides du secteur libèrent de nombreuses petites créatures qui interrompent les sorts ; les boucliers de dégâts comme Épines les tuent en un coup.",

	-- Step 131: Twitching Antennae
	["Twitching Antennae"] = "Antennes frémissantes",
	-- {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo · {npc:4196} Silithid Swarm · {npc:5781} Silithid Creeper Egg · {npc:3253} Silithid Harvester
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Creepers = {npc:3250} Silithid Creeper
	["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the same mounds until you have five, then take them straight to {npc:6394} in {area:378}, before the thunderhawks. Careful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds; Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds. A {npc:3253} (24, rare) also wanders the mounds: leave it."] = "Les antennes disparaissent quinze minutes après être tombées : tuez les Essaimeurs et les Rampants silithides aux mêmes monticules jusqu'à en avoir cinq, puis apportez-les directement à {npc:6394} au {area:378}, avant les faucons-tonnerre. Attention : les Essaimeurs silithides (niveau 21-22) lancent {npc:4196} en combat comme hors combat, ce qui fait venir plusieurs petits renforts ; les Rampants silithides (niveau 20-21) lancent régulièrement {npc:5781} en combat, ce qui fait apparaître des renforts supplémentaires. Un {npc:3253} (24, rare) erre aussi sur les monticules : laissez-le.",
	["Twitching Antennae from the silithid"] = "Antennes mobiles sur les silithides",

	-- Step 132: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Back north into {area:378} before the antennae fade: {npc:6394} is inside."] = "Retournez au nord au {area:378} avant que les antennes ne disparaissent : {npc:6394} est à l'intérieur.",

	-- Step 133: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the plains south of the camp."] = "Les Faucons-tonnerre des nuages tournoient au-dessus des plaines au sud du camp.",

	-- Step 134: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {item:7766} Empty Brown Waterskin
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}: fill the {item:7766} at the watering hole below it."] = "La hutte de {npc:5899} se dresse sur la crête au-dessus du point d'eau des huttiers, au sud du {area:378} : remplissez l'{item:7766} au point d'eau en contrebas.",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Remplissez l'{item:7766} au point d'eau des huttiers",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {area:287} Hillsbrad
	["Keep it: the {object:107045} is beside {area:272}, on the {area:287} guide"] = "Gardez-la : le {object:107045} est à côté de {area:272}, dans le guide de {area:287}",

	-- Step 135: Camp Taurajo
	-- {area:378} Camp Taurajo
	["Back north into {area:378} on the way to the Crossroads: Jorn takes the thunderhawk wings."] = "Revenez vers le nord jusqu'au {area:378} sur le chemin de la Croisée : Jorn prend les ailes de faucon-tonnerre.",

	-- Step 136: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate."] = "Remontez la {area:458} vers le nord jusqu'à la Croisée : {npc:3448} à la porte sud, {npc:3432} près de l'auberge, {npc:3428} à l'ouest de la porte nord.",

	-- Step 137: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878} camps beside the road east of the Crossroads."] = "{npc:5878} campe au bord de la route à l'est de la Croisée.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Il propose ensuite {quest:1838} (1838, niveau 30) : elle demande {area:1717} et vous envoie partout en Kalimdor et dans les Royaumes de l'Est. Le guide de classe Guerrier {quest:1838} la couvre.",

	-- Step 139: Counterattack!
	-- {npc:3389} Regthar Deathgate · {npc:9456} Warlord Krom'zar
	["Speak to {npc:3389} again to start the attack: the Kolkar charge the bunkers just west of him in waves. Fight beside the grunts until {npc:9456} (elite, 20) arrives with two bodyguards, usually from the south, then click the banner over his body."] = "Parlez de nouveau à {npc:3389} pour lancer l'attaque : les kolkars chargent les bunkers juste à l'ouest de lui, par vagues. Combattez aux côtés des grunts jusqu'à l'arrivée de {npc:9456} (élite, 20) avec deux gardes du corps, en général par le sud, puis cliquez sur la bannière au-dessus de son corps.",

	-- Step 140: Seereth Stonebreak's camp
	-- {npc:4049} Seereth Stonebreak
	["{npc:4049}'s camp"] = "Camp de {npc:4049}",

	-- Step 141: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["{npc:4049} and {npc:11857} share the camp on the road west to Stonetalon."] = "{npc:4049} et {npc:11857} partagent le camp sur la route de l'ouest vers les Serres-Rocheuses.",
	-- {npc:4049} Seereth Stonebreak · {area:461} Windshear Crag
	["{npc:4049}: the Venture loggers at {area:461}"] = "{npc:4049} : les bûcherons de la KapitalRisk à la {area:461}",

	-- Step 142: Grimtotem camp
	["Grimtotem camp"] = "Le camp Totem sinistre",
	-- {npc:11857} Makaba Flathoof
	["The Grimtotem camp is just north of {npc:11857}, a short walk off the road: Ruffians and Mercenaries stand among the tents."] = "Le camp Totem sinistre se trouve juste au nord de {npc:11857}, à quelques pas de la route : des Voyous et des Mercenaires se tiennent parmi les tentes.",

	-- Step 143: Makaba Flathoof
	-- {npc:11857} Makaba Flathoof
	["Back down to {npc:11857}."] = "Redescendez jusqu'à {npc:11857}.",
	-- {npc:11858} Grundig Darkcloud · {area:1076} Webwinder Path
	["{npc:11858} waits up the {area:1076}"] = "{npc:11858} attend en haut du {area:1076}",

	-- Step 144: To Malaka'jin
	-- {area:2539} Malaka'jin
	["To {area:2539}"] = "Vers {area:2539}",

	-- Step 145: Malaka'jin
	-- {npc:4049} Seereth Stonebreak · {area:2539} Malaka'jin
	["Follow the road on west from {npc:4049} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Continuez sur la route vers l'ouest depuis {npc:4049} jusque dans les Serres-Rocheuses. Le village troll de {area:2539} se trouve à l'entrée du canyon.",
	-- {npc:12816} Xen'Zilla · {area:1076} Webwinder Path
	["{npc:12816}: the spiders along the {area:1076}"] = "{npc:12816} : les araignées le long du {area:1076}",

	-- Step 146: Webwinder Path: kill these as you meet them
	-- {area:1076} Webwinder Path
	["{area:1076}: kill these as you meet them"] = "{area:1076} : tuez-les au passage",
	-- {area:2539} Malaka'jin · {npc:11858} Grundig Darkcloud
	-- plural, as words: Grimtotem Brutes = {npc:11912} Grimtotem Brute · Deepmoss Creepers = {npc:4005} Deepmoss Creeper
	["North up the road from {area:2539}: {npc:11858} and his Grimtotem Brutes hold the bend in the road, and the Deepmoss Creepers and Venomspitters lurk in the webs on both sides of the path all the way up."] = "Remontez la route vers le nord depuis {area:2539} : {npc:11858} et ses Brutes Totem sinistre tiennent le virage de la route, et les Rampants de Mousseprofonde et les Crache-venin guettent dans les toiles des deux côtés du chemin jusqu'en haut.",

	-- Step 147: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "La route grimpe vers le nord : c'est {area:1076}. {quest:1483} a une cabane là où la route bifurque vers l'est en direction de {area:461}.",
	-- {quest:1483} Ziz Fizziks
	["{quest:1483}, inside"] = "{quest:1483}, à l'intérieur",

	-- Step 148: Windshear Crag
	-- {area:461} Windshear Crag
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints."] = "À l'est de Ziz, la KapitalRisk rase la {area:461} ; l'un des Opérateurs porte les plans.",
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["Venture Co. Loggers, all over the clear-cut"] = "Bûcherons de la KapitalRisk, partout dans la coupe rase",

	-- Step 149: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} on the east side of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "La défense de {npc:4276} est difficile seul à ce niveau : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. Passez-la si vous êtes seul.\n{npc:4276} creuse au fond de la {area:2160}, du côté est de la falaise, après ses kobolds (niveaux 19-23). Parlez-lui, puis gardez-le en vie pendant cinq minutes pendant qu'il mine : une douzaine de kobolds ou plus l'attaquent par vagues, d'abord des combattants au corps à corps, puis des lanceurs de sorts, et les kobolds de la mine réapparaissent dans le combat. S'il meurt, la quête échoue.",
	-- {npc:4276} Piznik
	["{npc:4276}, below ground"] = "{npc:4276}, sous terre",

	-- Step 150: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}, à l'intérieur",

	-- Step 151: Ziz Fizziks
	-- {npc:4201} Ziz Fizziks · {npc:3442} Sputtervalve · {area:392} Ratchet · {zone:1413} The Barrens
	["{npc:4201}: for {npc:3442}, beside {area:392}'s flight master at the end of the {zone:1413} & Stonetalon guide"] = "{npc:4201} : pour {npc:3442}, à côté du maître de vol de {area:392}, à la fin du guide {zone:1413} et Serres-Rocheuses",

	-- Step 152: Kaya Flathoof
	-- {area:1076} Webwinder Path · {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud · {area:2538} Camp Aparaje
	["On the way back down the {area:1076}, {npc:11856} is held in {npc:11858}'s hut at the bend in the road. Once you take her quest she walks straight off south-east to {area:2538}, the burned village, without waiting: stay close, or the quest fails.\nCareful: Three Grimtotems ambush her at the burned village and go for her, not you: pull them off her and kill their caster quickly."] = "En redescendant {area:1076}, {npc:11856} est retenue dans la hutte de {npc:11858}, au tournant de la route. Une fois sa quête acceptée, elle part directement vers le sud-est jusqu'à {area:2538}, le village incendié, sans vous attendre : restez près d'elle, sinon la quête échoue.\nAttention : trois Totem sinistre lui tendent une embuscade au village incendié et s'en prennent à elle, pas à vous : détournez-les d'elle et tuez vite leur lanceur de sorts.",
	-- {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud
	["{npc:11856}, inside {npc:11858}'s hut"] = "{npc:11856}, dans la hutte de {npc:11858}",

	-- Step 153: Malaka'jin
	-- {area:2539} Malaka'jin · {npc:12816} Xen'Zilla
	["West from the burned village to {area:2539}: {npc:12816} stands just outside it, before the village."] = "À l'ouest du village incendié, jusqu'à {area:2539} : {npc:12816} se tient juste à l'extérieur, avant le village.",

	-- Step 155: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["East along the road to {npc:4049} and {npc:11857}'s camp, on the way back out of Stonetalon."] = "Suivez la route vers l'est jusqu'au camp de {npc:4049} et {npc:11857}, sur le chemin de la sortie des Serres-Rocheuses.",
	-- {npc:11857} Makaba Flathoof · {npc:11864} Tammra Windfield · {area:460} Sun Rock Retreat · {zone:1413} The Barrens
	["{npc:11857}: keep it, {npc:11864} at {area:460} in the {zone:1413} & Stonetalon guide"] = "{npc:11857} : gardez-la, {npc:11864} à {area:460}, dans le guide {zone:1413} et Serres-Rocheuses",
	-- {zone:1413} The Barrens · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["The next guide goes north-east across the {zone:1413} to the {area:1703} and {zone:1440}."] = "Le guide suivant traverse les {zone:1413} vers le nord-est jusqu'au {area:1703}, puis en {zone:1440}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Retour au camp Tranchecrin. Les Géomanciennes et les Défenseurs tiennent sa moitié est ; {npc:3438} se promène parmi eux.",
	-- ["Back west along the road."] = "Revenez vers l'ouest par la route.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Les Sectateurs de la Lame ardente tiennent {area:1898}, dans le nord de {area:14} ; ils lâchent la {item:6652}. Le {item:5026} vient des Tranchecrin, lors de votre prochaine visite de leur camp.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Les Sectateurs de la Lame ardente tiennent {area:1898}, dans le nord de {zone:1411} ; ils laissent tomber la {item:6652}. Le {item:5026} vient des Tranchecrin lors de votre prochaine visite à leur camp.",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "À l'est de Ziz, la KapitalRisk rase {area:461} ; l'un des Opérateurs porte les plans. {npc:4276} creuse dans la petite mine du côté est : restez avec lui pendant qu'il mine, des brutes de la KapitalRisk viennent s'en prendre à lui.\nAttention : les kobolds arrivent par vagues. La première vague est composée de combattants au corps à corps, la seconde y ajoute des lanceurs de sorts. Les monstres normaux de la mine réapparaissent vite et peuvent rejoindre le combat pendant les vagues. Un groupe est recommandé.",
	-- ["East to {area:392}, on the coast."] = "À l'est vers {area:392}, sur la côte.",
	-- ["Follow the road east to the outpost above the {area:814}."] = "Suivez la route vers l'est jusqu'à l'avant-poste au-dessus de {area:814}.",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Gardez-la : {quest:3923} se tient devant {zone:1454} ; un guide ultérieur la rend",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Les Querelleurs et les Légions-tempête kolkar tiennent les camps au sud de {npc:3389}.",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Les Gueules d'acier des oasis rampent autour de {area:387}, au sud-ouest de la {area:380}, et autour de {area:388}.",
	-- ["On the way"] = "En chemin",
	-- ["Over the {area:814} bridge below {area:379} and south along the {zone:1411} bank to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "Traversez le pont de {area:814} sous {area:379} puis longez la rive de {zone:1411} vers le sud jusqu'à un sentier étroit qui monte dans la montagne : {npc:5900} garde le sanctuaire au sommet. Attention aux bords en montant, et redescendez par le même sentier.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Les Trotteurs des plaines et les raptors solécaille parcourent les plaines tout autour de la {area:380}, surtout au nord.",
	-- ["Plainstriders and raptors"] = "Trotteurs des plaines et raptors",
	-- ["Raptor nests"] = "Nids de raptors",
	-- ["South-east of the Crossroads. Test the seeds at the bubbling fissure on the oasis' east bank; {npc:3448} takes the result on the next Crossroads stop, so carry on north-west to the {area:383} from here."] = "Au sud-est de la Croisée. Testez les graines à la fissure bouillonnante sur la rive est de l'oasis ; {npc:3448} prendra le résultat lors du prochain passage à la Croisée, alors continuez d'ici vers le nord-ouest jusqu'à {area:383}.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Au sud-est de la {area:380}. Testez les graines à la fissure bouillonnante sur la rive est de l'oasis.",
	-- ["Southsea beach"] = "Plage des Mers du sud",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Les Rôdeurs des savanes chassent dans les plaines entre la ville et le camp Tranchecrin à l'est. Dans le camp, les Sourciers et les Tisseuses d’épines tiennent la moitié ouest, les Chasseurs le centre ; les caisses de ravitaillement se trouvent à l'extrémité est.",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Les Tueuses Ensorçaile tiennent l'ouest de {area:383} ; elles portent les anneaux.",
	-- ["The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Le prochain guide commence ici et vous emmène à {zone:1454}, puis au zeppelin pour les {zone:1420}.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Les pirates campent sur la plage au sud de {area:392}. Les tas de pièces compliquées se trouvent dans le sable parmi eux.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Les trois nids se trouvent ensemble à {area:1697}, au sud-ouest de l'oasis ; des Faucheurs solécaille les gardent.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "La {object:4141} se trouve sur le site de recherche de la KapitalRisk à l'ouest de {area:382}. Fermez les trois vannes autour du foreur, utilisez de nouveau la console, puis prenez la {item:5089} sur {npc:3471}, à côté.",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Thun'grim campe au bord de la route de {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Les Lézards-tonnerre et les Foudroyants paissent juste de l'autre côté du pont, sous {area:379}.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Les Lézards-tonnerre et les Foudroyants paissent juste de l'autre côté du pont, sous {area:379}.\nAttention : Halikor, un élite de niveau 12, rôde sur {area:369} parmi les lézards : repérez-le avant d'attirer quoi que ce soit.",
	-- ["Thunder lizards across the river"] = "Lézards-tonnerre de l'autre côté de la rivière",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Revenez vers le sud jusqu'à la {area:380}. Le guide suivant commence ici et vous emmène à {zone:1454} et au zeppelin pour {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Revenez vers l'ouest par la route jusqu'à la {area:380}.",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "Sourciers, Tisseuses d'épines et Chasseurs Tranchecrin tiennent le camp à l'est de {area:380}. Les caisses de provisions se trouvent à son extrémité est. Guerriers : {object:58369} se trouve dans le camp. Chamans : les huttiers lâchent {item:5026}. Tuez les Rôdeurs des savanes que vous croisez pour leurs griffes.\nAttention : le coffre se trouve à côté d'un chariot cassé, gardé par une paire de Tranchecrin, dont des chasseurs qui peuvent attirer d'autres huttiers dans le combat.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "À l'ouest vers {area:383}. Les harpies Ensorçaile y nichent partout ; chacune peut laisser tomber une serre. {quest:819} se trouve dans leurs collines.",
	-- ["Zhevra"] = "Zhévras",
	-- ["Zhevra Runners graze north and east of town."] = "Les Messagers zhévra paissent au nord et à l'est de la ville.",
	-- ["{area:1898} cultists"] = "Sectateurs de {area:1898}",
	-- ["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} est votre base pour ce guide. Tous ceux dont vous avez besoin se tiennent à quelques pas de l'auberge.",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885} : utilisez une moitié au {area:2362}",
	-- ["{item:5055} on the way"] = "{item:5055} en chemin",
	-- ["{npc:3033}: Cat Form"] = "{npc:3033} : Forme de félin",
	-- ["{npc:3033}: Cure Poison"] = "{npc:3033} : Guérison du poison",
	-- ["{npc:3267} on the way"] = "{npc:3267} en chemin",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Oasis Snapjaws crawl in the water around it: their shells are for {npc:3448}."] = "{npc:3395} se promène parmi les Kolkar à {area:388}, au sud-est de la Croisée. Des Gueules d'acier des oasis rampent dans l'eau tout autour : leurs carapaces sont pour {npc:3448}.",
	-- ["{npc:3448}: the Oasis Snapjaws at the {area:388}, with {npc:3395}"] = "{npc:3448} : les Gueules d'acier des oasis à {area:388}, avec {npc:3395}",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, le maître des coursiers du vent",
	-- ["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} campe au bord de la route de la {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",
	-- ["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} fabrique le {item:6636} avec le goudron et la bourse. Utilisez-le près du brasero à côté de lui pour révéler la {npc:5893}, tuez-la pour obtenir la {item:6655}, puis placez la braise dans le brasero.",
	-- ["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} attend sur la berge au sud de {area:379}, de l'autre côté du pont.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} se tient sur la crête au nord du camp Tranchecrin.",
	-- ["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301} : {area:228} en {zone:1421}, guide suivant",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, un lion blanc, rôde dans les plaines au nord du camp Tranchecrin.",
}
