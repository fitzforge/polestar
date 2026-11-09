-- French (frFR): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Crossroads
	["Fly to Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 2: The road west
	["The road west"] = "",
	["The road west past Seereth's camp"] = "",

	-- Step 3: Malaka'jin
	-- {npc:3995} Witch Doctor Jin'Zil · {area:2539} Malaka'jin · {area:1076} Webwinder Path
	["Follow the road west past Regthar's bunkers and Seereth's camp into Stonetalon: {npc:3995} waits below ground in {area:2539}, at the foot of the {area:1076}."] = "",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "{npc:3995}, sous terre",

	-- Step 4: Sun Rock Retreat
	-- {area:1076} Webwinder Path · {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["Up the {area:1076} past {npc:4201} and west to {area:460}."] = "",
	-- {npc:11862} Tsunaman · {npc:12736} Je'neu Sancrea
	["{npc:11862}: {npc:12736} at Zoram'gar, next guide"] = "",
	-- {npc:11860} Maggran Earthbinder · {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["{npc:11860}: {npc:12576} is at the {area:1718}, later in this guide"] = "",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860} : Héliolites lumineuses ({item:277936}) sur les harpies Rougefurie",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, devant la porte",

	-- Step 5: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Graines de Gaea ({item:16205})",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "Les Graines de Gaea se trouvent dans l'herbe autour de la rive sud du {area:464}, au nord du Roc-Soleil.\nAttention : les Fièrailes autour du lac peuvent attaquer en groupe lié.",

	-- Step 6: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "{zone:1442} : tuez-les au passage",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Suivez la route vers le nord en direction du {area:467}. Des Coursiers à ramure ({npc:4018}) paissent en chemin ; Bêtes de sève ({npc:4020}), Coureurs crépusculaires ({npc:4067}) et Dragons-faë ({npc:4016}) parcourent les bois sous le pic, et les druides cénariens tiennent le bosquet là-bas.",

	-- Step 7: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "La quête suivante de {npc:4198}, Ordanus, se trouve du côté Alliance d'{zone:1440}. Passez-la.",

	-- Step 8: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "{area:465} : tuez-les au passage",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Au sud-ouest de Roche-Soleil s'étend le {area:465}. Plantez les Graines de Gaea dans les monticules de terre au fond de la vallée ; les élémentaires de feu lâchent {item:16312}. Harpies et Embusquées Rougefurie nichent au nord, Tueuses et Volplumes au sud.",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, sur n'importe quelle harpie Rougefurie",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Monticules de poussière de Gaea ({object:177929})",

	-- Step 9: Sun Rock Retreat
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, à côté de {npc:11862}",
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, en haut sur la corniche",

	-- Step 10: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "Redescendez {area:1076} jusqu'à {area:2539}.",

	-- Step 11: To Camp Taurajo
	-- {area:378} Camp Taurajo
	["To {area:378}"] = "",

	-- Step 12: Camp Taurajo
	-- {area:2539} Malaka'jin · {area:378} Camp Taurajo
	["From {area:2539} follow the road east to Seereth's camp, then south-east across the plains to {area:378}."] = "",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, au bord nord du camp",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, dans la cage",

	-- Step 13: Grunt Logmar
	-- {npc:5911} Grunt Logmar · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["{npc:5911} stands by the flight master. His {npc:268623} (23) is elite: grouping up is advised; the two Encroaching Soldiers are not."] = "",
	-- {npc:5911} Grunt Logmar · {npc:3341} Gann Stonespire
	["{npc:5911}: the soldiers and the pillager camp just east of {npc:3341}, on the way south"] = "",

	-- Step 15: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "La hutte de {npc:5899} se dresse sur la crête au-dessus du point d'eau des hurans, au sud de {area:378}, sur la route de {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899} : l'outre rouge de {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899} : l'outre bleue se remplit dans {zone:1440}, au guide suivant",

	-- Step 16: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan · {npc:14242} Sulhasa
	["{npc:3341} walks the road south toward {area:359}, between about 46,75 and 46,81: if he isn't at the arrow, follow the road until you meet him. {npc:14242} sits up in the tree just east of the road at 47.9,77.5."] = "",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "{npc:3341} se promène autour de {area:1701} : cherchez dans le cercle sur la carte",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, dans l'arbre juste à l'est de {npc:3341}",

	-- Step 17: Wrongly Blamed, Justly Corrected
	-- {npc:14242} Sulhasa · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["A few steps east of {npc:14242}'s tree, a small camp: two Encroaching Soldiers and the {npc:268623} for Logmar. The {npc:268623} is elite: grouping up is advised."] = "",

	-- Step 18: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "Au sud de Gann, les nains de Bael'dun creusent à {area:359}. Des Excavateurs et des Contremaîtres travaillent dans la fosse ; le {npc:3392} (26) porte le journal : attirez-le seul.\nAttention : les Excavateurs (niveau 21-22) et les Contremaîtres (niveau 22-23) fuient chercher de l'aide une fois à 15 % de vie, d'autres nains peuvent donc rejoindre le combat.",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "{npc:3375} se promène autour de {area:359} : cherchez dans le cercle sur la carte",

	-- Step 19: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "",

	-- Step 20: Field to Clear
	-- {npc:3341} Gann Stonespire · {npc:3238} Stormhide
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["On the way back east to {npc:3341}: Hecklefang Stalkers and {npc:3238} lizards roam the plain between the ridge and his camp."] = "",
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "{npc:4128} se promène autour de {area:1156} : cherchez dans le cercle sur la carte",

	-- Step 22: Bael'dun fortress
	["Bael'dun fortress"] = "Forteresse de Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "Les Soldats, les Fusiliers et les Officiers de Bael'dun gardent la forteresse du côté est des fouilles ; les trois objets viennent d'eux.\nAttention : les Fusiliers (niveau 24-25) utilisent Tir de 5 à 30 m, ceux qui sont proches peuvent donc rejoindre un combat à distance.",

	-- Step 24: The flying machine
	["The flying machine"] = "La machine volante",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "La machine volante des nains repose sur sa plateforme dans le site de fouilles.",

	-- Step 26: Great Lift
	-- {area:1718} Great Lift
	["The top of the {area:1718}"] = "",

	-- Step 27: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "Au sud-ouest de Bael Modan, {npc:12576} attend en haut de {area:1718}.",

	-- Step 28: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "{area:1718}",
	-- {npc:10079} Brave Moonhorn · {area:1718} Great Lift · {npc:12576} Grish Longrunner
	["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, en haut de l'élévateur",

	-- Step 31: Grunt Logmar
	-- {npc:5911} Grunt Logmar
	["{npc:5911}, beside the flight master"] = "",

	-- Step 32: Fly to Crossroads
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "Maître de vol du {area:378}",

	-- Step 33: The Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, en haut de la tour",

	-- Step 34: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voler jusqu'à {area:392}",
	["Crossroads flight master"] = "",

	-- Step 35: Merchant Coast
	-- {quest:874} Mahren Skyseer · {area:392} Ratchet
	["{quest:874} camps on the shore just north of {area:392}'s flight master."] = "",

	-- Step 36: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, un grand battrodon, nage dans les hauts-fonds au large de {area:391}, à l'est de {npc:3388}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Aidez {npc:261366} : restez près de lui quand {npc:261367} et les soldats de marine de {area:21} montent la crête",
	-- ["At the {object:147538}: summons {quest:882}"] = "À l'arbre mort : invoque {quest:882}",
	-- ["Back to the {area:380}"] = "Retour à {area:380}",
	-- ["Back to {area:17}"] = "Retour dans les {area:17}",
	-- ["Back to {area:380}"] = "Retour à la {area:380}",
	-- ["Bristleback camps"] = "Camps Dos-hirsute",
	-- ["Bruuz"] = "Bruuz",
	-- ["Cast {spell:18960}"] = "Lancez {spell:18960}",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Lancez {spell:18960}. Taurens : assemblez les deux moitiés du pendentif au {area:2362}, sur la rive nord-ouest du lac, avant d'aller voir {npc:11802} à {area:2361}.",
	-- ["Dogran is chained up in the quilboar camp west of the road."] = "Dogran est enchaîné dans le camp huran à l'ouest de la route.",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doras, le maître des coursiers du vent, se tient sur la tour de la {object:172982}.",
	-- ["Down the {area:458} to {area:378} again."] = "Redescendez la {area:458} jusqu'au {area:378}.",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "À l'est à travers les plaines vers la côte : l'argent volé se trouve dans un nid de raptors au nord-ouest de {area:385}.",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "À l'est vers la {area:382}. Le {npc:3439} se trouve dans le camp de la KapitalRisk ; {npc:3445} porte la clé.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Remplissez l'{item:7766} au point d'eau des huran",
	-- ["Fizzule is by the Venture Co. tower north of the {area:382}. Before you go near him, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "Fizzule est près de la tour de la KapitalRisk, au nord de {area:382}. Avant de vous approcher de lui, utilisez le {item:8051} pour tirer deux fusées, puis ciblez-le et faites /saluer : il attaque quiconque arrive sans s'être signalé d'abord.",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule dirige le camp de la KapitalRisk à l'extrémité est de la {area:382}. Il attaque les inconnus : ciblez-le et faites /salute avant lui.",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Retour en vol à {area:380}. Le guide suivant commence ici et prend la route du nord vers le {area:1703} et {zone:1440}.",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Volez jusqu'à {area:1637} pour apprendre vos rangs de niveau 20. {npc:3354} est dans la {object:172958}, {npc:5892} dans la {object:172957}.",
	-- ["Fly to {area:1637} to train."] = "Volez jusqu'à {area:1637} pour vous entraîner.",
	-- ["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Volez jusqu'aux {area:1638} et apprenez vos rangs de niveau 20 : {npc:3033} est sur la {area:1639}.",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Volez jusqu'aux {area:1638} pour vous entraîner : {npc:3033} est sur la {area:1639}.",
	-- ["Fly to {area:380}"] = "Prendre un vol pour {area:380}",
	-- ["Follow the {area:458} south to {area:378}."] = "Suivez la {area:458} vers le sud jusqu'au {area:378}.",
	-- ["He gives you the {item:15826}"] = "Il vous donne le {item:15826}",
	-- ["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Il propose ensuite {quest:1838} (1838, niveau 30) : elle demande {area:1717} et vous envoie partout en Kalimdor et dans les Royaumes de l'Est. Le guide de classe Guerrier {quest:1838} la couvre.",
	-- ["Head north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Allez vers le nord depuis la {area:380} jusqu'au {area:384} et remplissez la {item:15842} au bassin du pic de Brume-funeste, puis retournez voir {npc:3448} à la {area:380}. Pas d'{skill:182} ? {npc:3490}, à côté de lui, vend de la {item:2449}, trois à la fois jusqu'à ce qu'il se réapprovisionne.",
	-- ["Hearth to the {area:380}"] = "Pierre de foyer vers {area:380}",
	-- ["Hearth to {area:378}"] = "Pierre de foyer vers le {area:378}",
	-- ["If you skipped {quest:92706}, grind here to level 19.43 to stay on the route's plan."] = "Si vous avez passé {quest:92706}, tuez des monstres ici jusqu'au niveau 19.43 pour rester dans le plan de la route.",
	-- ["Inside"] = "À l'intérieur",
	-- ["Keep it: the {object:107045} is beside {area:272}"] = "Gardez-la : le {object:107045} est à côté d'{area:272}",
	-- ["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Gardez-la : {npc:12696} en {zone:1440}, guide suivant",
	-- ["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Gardez-la : {npc:5875} à {zone:1454}, à la fin de ce guide",
	-- ["Level 19.43"] = "Niveau 19.43",
	-- ["Level 20"] = "Niveau 20",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Au nord vers les {area:383}. {npc:3682} campe au pied des collines ; {npc:261366}, l'ermite sur la crête derrière lui, n'a du travail pour vous qu'une fois que {npc:3682} vous y envoie.",
	-- ["On the top floor"] = "Au dernier étage",
	-- ["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "En redescendant la {area:458} vers le {area:378} : les Pillards tranchecrin parmi les camps Dos-hirsute, de part et d'autre de la route au nord du camp, portent {item:277277}. Rendez-les à {npc:3432} lors de votre dernier arrêt à {area:380}.",
	-- ["Pickpocket {npc:7287} for the tower key before opening the lockbox. Gallywix and his lockbox are at the top; the key does not open that box, which still needs Lockpicking. Gallywix is elite: grouping up is advised. If you postpone this optional job, resume it in the Class guide Poisons (Horde)."] = "Faites les poches du {npc:7287} pour prendre la clé de la tour avant d'ouvrir le coffret. Gallywix et son coffret sont au sommet ; la clé n'ouvre pas ce coffret, qui demande toujours Crochetage. Gallywix est élite : il est conseillé de se grouper. Si vous repoussez cette tâche facultative, reprenez-la dans le guide de classe Poisons (Horde).",
	-- ["Raptor nests"] = "Nids de raptors",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Allez au nord de {area:380} jusqu'au {area:384} et remplissez l'{item:15842} au {object:19464}, puis revenez voir {npc:3448} à {area:380}. Pas d'{skill:182} ? {npc:3490}, à côté de lui, vend de la {item:2449}, trois à la fois jusqu'au réassort.",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Les Patriarches des savanes errent dans les plaines à l'est des collines, et les Pièges déclenchés sont parmi eux. {quest:876} mène aux harpies Ensorçaile dans les collines à l'ouest.",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "Les Patriarches des savanes parcourent les plaines à l'est des collines, et les Pièges déclenchés se trouvent au milieu d'eux. {quest:876} dirige les harpies Ensorçaile dans les collines à l'ouest.\nAttention : le chemin d'accès passe près de harpies embusquées camouflées et d'une harpie élite qui patrouille.",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Au sud du Camp Taurajo, les Antres des silithides parsèment le {area:390} ; les œufs y sont, et des Grouillants silithides sortent pour les défendre. Les Moissonneurs silithides sont rares : si vous en voyez un, tuez-le pour sa tête.",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head.\nCareful: Silithid Swarmers in the area release many tiny adds that interrupt spells; damage shields such as Thorns kill them in one hit."] = "Au sud du camp Taurajo, les Antres des silithides parsèment le {area:390} ; les œufs s'y trouvent, et des Grouillants silithides en sortent pour les défendre. Les Moissonneurs silithides sont rares : si vous en voyez un, tuez-le pour sa tête.\nAttention : les Grouillants silithides de la zone libèrent de nombreux petits monstres qui interrompent les sorts ; les boucliers de dégâts comme Épines les tuent en un coup.",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Au sud de Gann, les nains de Bael'dun creusent à {area:359}. Les Excavateurs de Bael'dun et Contremaîtres de Bael'dun travaillent la fosse ; {npc:3392} (26) porte le journal : attirez-le seul.",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Restez camouflé : {npc:7287} porte la clé de la tour ; Gallywix et son coffret sont au sommet. Gallywix est élite : il est conseillé de se grouper.",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Les Faucheurs solécaille chassent dans les plaines au sud de {area:380}, autour du {area:1697} ; ils laissent les cornes. Rendez-les lors de votre prochain passage à {area:392}.",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}.\nEast across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Les Faucheurs solécaille chassent dans les plaines au sud de la {area:380}, autour de {area:1697} ; ils lâchent les cornes. Rendez-les lors de votre prochain passage à {area:392}.\nVers l'est à travers les plaines, en direction de la côte : l'argent volé se trouve dans un nid de raptors au nord-ouest de {area:385}.",
	-- ["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Taurens : le {npc:11957} attend sur la colline sud au-dessus du pont. Éolides : l'{npc:272054} se tient au sud des ponts jumeaux. Ensuite, les tanières à l'est du lac : quittez votre forme, cliquez sur la statue à l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de chat blanc.",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Les Soldats de Bael'dun, Fusiliers de Bael'dun et Officiers de Bael'dun gardent la forteresse à l'est du site de fouilles ; les trois objets viennent d'eux.",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Les camps des huran Dos-hirsute s'étendent sur les plaines au nord du {area:378}, de part et d'autre de la {area:458}. Chaque Dos-hirsute laisse une défense ; la femme de {npc:3432} gît au bord nord. Gardez un {item:5075}. {quest:883}, un kodo gris, erre parfois ici : son sabot lance une quête.",
	-- ["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Les Surveillants de la KapitalRisk et Massacreurs de la KapitalRisk de la mine au nord-est de la zone laissent l'{item:5097}.",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Les antennes disparaissent quinze minutes après leur butin : ramassez-les maintenant, en remontant vers le nord. Tuez les Grouillants silithides et Rampants silithides près des antres du {area:390} jusqu'à en avoir cinq, puis utilisez tout de suite la Pierre de foyer vers le {area:378}.",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away.\nCareful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds. Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds."] = "Les antennes disparaissent quinze minutes après être tombées : ramassez-les maintenant, sur le chemin du retour vers le nord. Tuez les Grouillants et les Rampants silithides près des antres du {area:390} jusqu'à en avoir cinq, puis utilisez aussitôt votre pierre de foyer vers le {area:378}.\nAttention : les Grouillants silithides (niveau 21-22) lancent {npc:4196} en combat comme hors combat, ce qui fait venir plusieurs petits monstres. Les Rampants silithides (niveau 20-21) lancent régulièrement {npc:5781} en combat, ce qui fait apparaître des monstres en plus.",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Les quêtes de classe de niveau 20 à {zone:1454} ({npc:3354}, {npc:5892}, les maîtres démonistes et voleurs) ne sont proposées qu'à partir du niveau 20 : finissez le niveau ici avant de voler. Les Jeunes faucons-tonnerre (18) dans les plaines au sud-ouest de {area:380} et les kolkars (14-15) à l'{area:388} sont les monstres valables les plus proches ; il vous faut bien moins d'un niveau.",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Les pirates campent sur la plage au sud de {area:392} ; {npc:3467} se tient à son extrémité sud.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Les trois nids sont regroupés dans {area:1697}, au sud-ouest de l'oasis ; des Faucheurs solécaille les gardent.",
	-- ["The {area:2363}"] = "Les {area:2363}",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} est le canyon sous {object:172982}.",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "La {object:177790} se trouve au bord nord de la {area:382}, près de la tour de la KapitalRisk. Elle contient le {item:15883} pour {quest:30}.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} se trouve au bord nord de {area:382}, près de la tour de la KapitalRisk. Il contient le {item:15883} pour {quest:30}.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:209797} (élite de niveau 20) demande un groupe de 2. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",
	-- ["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Les Faucons-tonnerre des nuages tournoient au-dessus des mêmes plaines au sud du camp.",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Les Têtes-tonnerre paissent dans les plaines juste au sud du {area:378}. {quest:884}, un lézard-tonnerre bleu, erre parmi eux : sa pointe caudale lance une quête.",
	-- ["Twitching Antennae"] = "Antennes frémissantes",
	-- ["Twitching Antennae from the silithid"] = "Antennes frémissantes des silithides",
	-- ["Upstairs"] = "À l'étage",
	-- ["Venture Co. tower"] = "Tour de la KapitalRisk",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "À l'ouest de {npc:3341}, les Tranchecrin tiennent la {area:1701}. {npc:3436} est à l'est, {npc:3434} au sud, {npc:3435} à l'extrémité ouest. Lok (25) et les Frénétiques Tranchecrin (24-25) ont quelques niveaux de plus que vous ; {npc:5859}, un élite rare, parcourt parfois la crête : laissez-le. Les Guides Tranchecrin et Traqueurs Tranchecrin laissent le Poignard de Tranchecrin, les Prophètes Tranchecrin la Baguette Tranchecrin carbonisée, les Frénétiques le Bouclier Tranchecrin. Les lézards {npc:3238} et les Traqueuses Jappecroc errent dans la plaine entre Gann et la crête. {quest:885}, une serpent des vents rouge et rare, survole la crête : sa plume lance une quête.",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "À l'ouest de Gann, les Tranchecrin tiennent {area:1701}. {npc:3436} est du côté est, {npc:3434} au sud, {npc:3435} à l'extrémité ouest. Lok (25) et les Frénétiques (24-25) ont quelques niveaux de plus que vous ; {npc:5859}, un élite rare, parcourt parfois la crête : laissez-le. Les Éclaireurs et les Traqueurs lâchent le Poignardeur, les Voyants la Baguette, les Frénétiques le Bouclier de guerre. Des lézards {npc:3238} et des Traqueuses Jappecroc parcourent la plaine entre {npc:3341} et la crête. {quest:885}, un serpent des vents rouge rare, survole la crête : sa plume lance une quête.\nAttention : les Traqueurs Tranchecrin se déplacent camouflés et frappent avec {spell:1752}, ils peuvent donc rejoindre un combat sans prévenir.",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Le Pilote Wizzlecrank sort du camp avec son déchiqueteur : restez avec lui et tuez tout ce qui l'attaque. {npc:3442} le récupère à {area:392}.",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "Wizzlecrank sort du camp avec son déchiqueteur : restez avec lui et tuez tout ce qui l'attaque. {npc:3442} le récupère à {area:392}.\nAttention : la route mène vers l'ouest et monte une rampe. Une fois en haut, deux monstres de la KapitalRisk vous tendent une embuscade.",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "tuez des Jeunes faucons-tonnerre au sud-ouest de {area:380}",
	-- ["grind on {npc:3256}"] = "tuez en boucle : {npc:3256}",
	-- ["the {area:380}"] = "la {area:380}",
	-- ["{area:1697}: kill these as you meet them"] = "{area:1697} : tuez-les au passage",
	-- ["{area:17}: kill these as you meet them"] = "{area:17} : tuez-les au passage",
	-- ["{area:263} of Shadow is the canyon under the {object:172982}."] = "{area:263} de l'Ombre est le canyon sous la {object:172982}.",
	-- ["{area:380} flight master"] = "Maître de vol de la {area:380}",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, sur la côte plus au sud. Les Soldats de marine de Theramore et les Protectrices de Theramore (15-16) laissent les médailles ; {npc:3393} (20) et les deux canonniers (19) se tiennent dans le donjon et sur ses remparts, c'est pourquoi le fort attend jusqu'ici.",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "{area:385}, sur la côte plus au sud. Les Soldats de marine de Theramore et les Préservateurs (15-16) lâchent les médailles ; la {npc:3393} (20) et les deux canonniers (19) se tiennent dans le donjon et sur ses remparts, et c'est à cause d'eux que le fort attend jusqu'à maintenant.\nAttention : chaque cible nommée est liée à un soigneur et à des gardes, et Fairmount a trois soldats de marine en plus avec elle. Tuer d'abord le soigneur facilite le combat.",
	-- ["{area:385}: kill these as you meet them"] = "{area:385} : tuez-les au passage",
	-- ["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "{item:10338}, sur n'importe quel zhévra ; des Étalons zhévra paissent autour de l'arbre",
	-- ["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852} : Kodos égarés des Tarides ({npc:3234}) dans les plaines autour du camp kolkar",
	-- ["{item:15852}: Lost {zone:1413} Kodos on the plains around the Kolkar camp"] = "{item:15852} : Kodos égarés des {zone:1413} dans les plaines autour du camp kolkar",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885} : utilisez une moitié au {area:2362}",
	-- ["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} auprès de {npc:3490} ; les herboristes en cueillent dans les plaines",
	-- ["{item:2449}: herbalists pick it here"] = "{item:2449} : les herboristes en cueillent ici",
	-- ["{item:5055} on the way"] = "{item:5055} en chemin",
	-- ["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} à {area:2361} y emmène les druides",
	-- ["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802} : l'accueil de {npc:3033}",
	-- ["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296} : utilisez le {item:15826} sur elles ; elles errent dans les plaines tout autour de {area:380}",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} nage dans le port, juste au large des quais de {area:392}. {npc:209797} est élite : il est conseillé de se grouper.",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391} à {area:272} enseigne les Poisons : gardez-la",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391} à {area:272} enseigne {spell:2842} : gardez-la",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} forme les Paladins aux {area:1638}. Vous n'avez pas encore ce trajet aérien : volez jusqu'au {area:378}, allez vers l'ouest à travers {zone:1412} et montez par un ascenseur, puis prenez le trajet auprès de {npc:2995} sur la mesa centrale.",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} forme les paladins aux {area:1638}. Vous n'y avez pas encore de trajet aérien : volez jusqu'au {area:378}, traversez {zone:1412} vers l'ouest, montez par un ascenseur et prenez le trajet aérien auprès de {npc:2995} sur le plateau central.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} et ses soldats de marine tiennent la caravane détruite au sud de {npc:261366}.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "Le {npc:262119} et ses soldats de marine tiennent la caravane détruite au sud de {npc:261366}. Les soldats sont liés : en attirer un fait venir les autres. Attirez-les depuis le bord et courez ; ils abandonnent vite la poursuite, vous pouvez donc éclaircir le camp un par un avant d'affronter le caporal.",
	-- ["{npc:3033}: Cat Form"] = "{npc:3033} : Forme de félin",
	-- ["{npc:3033}: Cure Poison"] = "{npc:3033} : Guérison du poison",
	-- ["{npc:3238} along the way to {npc:14242}"] = "{npc:3238} sur le chemin de {npc:14242}",
	-- ["{npc:3238} on the way"] = "{npc:3238} en chemin",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, dans la plaine entre {npc:3341} et la crête",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} attend dans un petit camp plus au sud, sur la route de {area:359}.",
	-- ["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} se tient au poste de guet kolkar juste à l'ouest de {area:380}.",
	-- ["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} se tient dans le camp kolkar au nord-ouest de {npc:3389}.",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} se promène parmi les kolkars à l'{area:388}, au sud-est de {area:380}.",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} mène les kolkars sur la rive ouest de l'{area:387}, au sud de {npc:3389}. Rendez sa tête à {npc:3389} lors de votre dernier arrêt à {area:380}.",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} se tient dans la {object:172960}. Ciblez-le et tapez /salute pour terminer {quest:2460}.",
	-- ["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428} : les œufs sont au {area:390}, plus tard",
	-- ["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Gardez-la : Kadrak au {area:1703}, guide suivant",
	-- ["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} propose {quest:95774} une fois {quest:4921} rendue",
	-- ["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, à côté du maître des coursiers du vent. Gardez-la : {quest:1483} se fait aux Serres-Rocheuses, plus tard",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}, sur le quai",
	-- ["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} est enchaîné dans le fort. Parlez-lui pour lancer l'escorte et restez près de lui : des soldats de Theramore attaquent à la sortie. Il vous ramène à {area:392}.",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vit à {area:2539}, le village troll juste à l'entrée des Serres-Rocheuses, au bout de la route qui part vers l'ouest depuis {npc:3389}.",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} se tient dans la {object:172960}. Utilisez {item:6626} sur le cercle d'invocation et battez la succube pour la lier.",
	-- ["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} campe au bord de la route à l'est de {area:380}.",
	-- ["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, juste à l'ouest de {npc:3341}",
	-- ["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} attend sur la colline au sud de {area:392}, sur votre route vers le nord.",
	-- ["{npc:5909}, a few steps away"] = "{npc:5909}, à quelques pas",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} se tient dans la {object:172961}, du côté ouest de la ville.",
	-- ["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} se tient dans la {object:172961}, à l'ouest de la ville.",
	-- ["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018} : {npc:4606} à {zone:1458}, dans deux guides",
	-- ["{npc:6394}, inside"] = "{npc:6394}, à l'intérieur",
	-- ["{object:3972} poster"] = "Affiche {object:3972}",
	-- ["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458} : {npc:7233}, près de la {area:382}",
	-- ["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "{quest:865}, si elle est encore en cours : des Faucheurs solécaille rôdent parmi les lions",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, un grand raptor solécaille, chasse dans les plaines au nord de la route de {area:392} à {area:380}.",
	-- ["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the {area:380}, and be ready when he arrives."] = "{quest:882}, un grand raptor solécaille, ne vient que sur une proie fraîche : ramassez une {item:10338} sur un zhévra, puis utilisez-la à l'arbre mort au nord-ouest de {area:392}, au nord de la route de la {area:380}, et tenez-vous prêt quand il arrive.",
	-- ["{zone:1454} class quests"] = "Quêtes de classe d'{zone:1454}",
	-- ["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",
}
