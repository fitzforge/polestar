-- French (frFR): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Maîtres de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entraînez-vous pendant que vous êtes à {zone:1458} : les maîtres se trouvent dans {object:36070}, {object:36073} et {object:36082} (paladins : {npc:260093}).",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038} se tient dans l'Apothicarium.",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038} : le cœur de Stormheart, de {zone:1441}",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Prendre un vol pour {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Maître de vol de {zone:1458}",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk · {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow
	["{npc:2229}, {npc:2410} and {npc:2437} are inside the inn; {npc:2770} stands outside it."] = "{npc:2229}, {npc:2410} et {npc:2437} sont dans l'auberge ; {npc:2770} se tient devant.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, à l'intérieur",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, à l'intérieur",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410} : {quest:93680}, la {item:279469} est près des traîtres",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, à l'intérieur",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide"] = "{npc:2770} : pour {npc:2771} à {area:321}, plus loin dans ce guide",
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, pour {npc:2333}",

	-- Step 6: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["Follow the road north out of {area:272} into the Alterac foothills: {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Suivez la route vers le nord depuis {area:272} dans les contreforts d'Alterac : {quest:535} attend près du camp du Syndicat. Il ne propose sa course que si vous avez l'Infiltration de {npc:2229} : donnez-lui tout de suite la bière, et sa récompense est la Missive du Syndicat que veut Krusk. Une missive du Syndicat trouvée ici fait aussi l'affaire : si vous en avez une dans vos sacs, le guide passe {quest:535}.",

	-- Step 7: Syndicate missives
	["Syndicate missives"] = "Missives du Syndicat",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one."] = "Seulement si vous n'avez pas obtenu la missive de {quest:535} : les Détrousseurs et Voleurs du Syndicat (32-34) autour des camps à l'ouest de la route portent aussi des missives ; environ un sur trois en laisse tomber une.",

	-- Step 8: Alterac Mountains
	-- {npc:246848} Kirin Tor Guard
	["West along the foot of the hills, south of the road: a {npc:246848} (55) walks that road from the north-east down into the traitors' camp."] = "Vers l'ouest au pied des collines, au sud de la route : un {npc:246848} (55) parcourt cette route depuis le nord-est jusqu'au camp des traîtres.",
	-- {area:279} Dalaran
	["South of the {area:279} crater's camp"] = "Au sud du camp du cratère de {area:279}",

	-- Step 9: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "Le cratère de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard · Kirin Tor Enforcers = {npc:276215} Kirin Tor Enforcer
	["From the south, walk up into the camp below the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together in the camp, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens: the ones on the camp's west side are furthest from the Guard's road.\nCareful: Kirin Tor Guards (55) attack the Horde on sight, and one of them patrols the road that comes down into the camp from the north-east and walks right up to the traitors: he has killed many players here. Watch for him, let him walk back up the road, then pull the traitors. Many of the camp's guards stand in linked pairs and others patrol alone. Arcane Sentries (55, elite) and Kirin Tor Enforcers (55) stand around the violet dome itself: keep to the camp below the rim."] = "Par le sud, montez dans le camp sous le dôme violet de {area:279}. {npc:2411}, {npc:2412} et {npc:2413} (33-34) se tiennent ensemble dans le camp, {npc:2414} (35) un peu à l'ouest ; chacun porte un fragment de Pierre de sang. Les Gardes-boucliers et Théurgistes (31-33) autour d'eux laissent tomber les Runes gravées usées : ceux du côté ouest du camp sont les plus éloignés de la route du Garde.\nAttention : les Gardes du Kirin Tor (55) attaquent la Horde à vue, et l'un d'eux patrouille sur la route qui descend dans le camp depuis le nord-est et va jusqu'aux traîtres : il a tué beaucoup de joueurs ici. Surveillez-le, laissez-le remonter la route, puis attirez les traîtres. De nombreux gardes du camp sont liés par deux et attaquent ensemble ; d'autres patrouillent seuls. Des Sentinelles arcaniques (55, élites) et des Massacreurs du Kirin Tor (55) se tiennent autour du dôme violet lui-même : restez dans le camp sous le rebord.",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "{item:279469} : un objet à ramasser, près des traîtres",
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Worn Stone Tokens, from the Shield Guards and Theurgists on the camp's west side"] = "Runes gravées usées, sur les Gardes-boucliers et Théurgistes du côté ouest du camp",

	-- Step 11: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east along the foothills to {area:272}: everything from the first loop is handed in inside the inn."] = "Revenez vers l'est le long des contreforts jusqu'à {area:272} : tout ce qui vient de la première boucle se rend dans l'auberge.",

	-- Step 13: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north up the road past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Remontez la route vers le nord au-delà du camp de {quest:535} jusqu'à {area:280}, le village tenu par le Syndicat (35-37). {npc:2431} porte la {item:3704} ; {quest:503} est enfermé dans une cage, dans la maison du côté nord.\nAttention : des espions camouflés du Syndicat rôdent dans {area:280}, et les bâtiments abritent de nombreux membres du Syndicat, dont des mages.",
	["Inside"] = "À l'intérieur",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Trouvez où {quest:503} est retenu, au dernier étage",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, au dernier étage",
	-- {npc:2229} Krusk · {npc:2423} Lord Aliden Perenolde · {area:1339} Lordamere Lake
	["{npc:2229} will offer {npc:2423} (41, in his manor far up {area:1339}) for this: leave it, he is over your level."] = "{npc:2229} proposera ensuite {npc:2423} (41, dans son manoir loin au nord du {area:1339}) : laissez tomber, il est au-dessus de votre niveau.",

	-- Step 14: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707} : tuez-les au passage",
	-- {area:280} Strahnbrad · {area:1357} Gallows' Corner · {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["From {area:280} follow the road south-west to {area:1357} and on west to the ruins north of the {area:279} crater, along the lake shore. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Depuis {area:280}, suivez la route vers le sud-ouest jusqu'à {area:1357}, puis continuez vers l'ouest jusqu'aux ruines au nord du cratère de {area:279}, le long de la rive du lac. Les Invocateurs de Dalaran mènent des Elémentaires asservis ; les brassards tombent sur les élémentaires. Attention : des Sentinelles arcaniques (55, élites) et des Gardes du Kirin Tor (55) gardent le dôme lui-même et attaquent la Horde : restez au bord extérieur des ruines et ne montez pas jusqu'au dôme.",

	-- Step 15: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Retour à {area:272}",
	-- {area:272} Tarren Mill
	["Hearth back to {area:272} (your hearthstone is bound there), or walk back south-east along the road out of Alterac."] = "Utilisez votre Pierre de foyer pour retourner à {area:272} (elle y est liée), ou revenez à pied vers le sud-est par la route qui sort d'Alterac.",

	-- Step 16: Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth back to {area:272}: your hearthstone is bound there."] = "Utilisez votre Pierre de foyer pour retourner à {area:272} : elle y est liée.",
	["The magus offers a dungeon errand next: leave it."] = "Le magus propose ensuite une mission de donjon : laissez-la.",

	-- Step 17: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "La route vers l'est par le {area:1057}",

	-- Step 18: Boulderfist camp
	["Boulderfist camp"] = "Camp Rochepoing",
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Sortez de {area:272} vers l'est par le {area:1057} et suivez la route vers l'est. Les Ogres Rochepoing et les Exécuteurs (32-34) campent au sud de la route, au sud du {area:313} ; les Exécuteurs restent dans la grotte.",
	["Below ground"] = "Sous terre",

	-- Step 19: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Suivez la route vers l'est. Les éclats violets brillent juste à côté de la route, un peu à l'ouest de {area:321}.",

	-- Step 20: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "La forteresse orque au bout est de la route. {npc:2851}, la maîtresse des coursiers du vent, se tient près de la porte.\n{npc:15126} ne propose le {quest:8263} qu'une fois que vous êtes Amical auprès des Profanateurs ({zone:1461}) : passez-le s'il ne le propose pas.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, près de la porte",
	-- {npc:12920} Doctor Gregory Victor · {skill:129} First Aid
	["{npc:12920}, at the south gate. If {npc:12920} offers nothing, another player may be running his {skill:129} quest Triage: he can be busy for a few minutes. Wait, then talk to him again."] = "{npc:12920}, à la porte sud. Si {npc:12920} ne propose rien, un autre joueur fait peut-être sa quête de {skill:129}, Triage : il peut être occupé quelques minutes. Attendez, puis parlez-lui à nouveau.",

	-- Step 21: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Quêtes de Stromgarde en groupe",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "La {quest:639} de {npc:2703} tombe sur les membres élites du Syndicat (35-38) dans les ruines de Stromgarde, à l'ouest des Hautes-terres. Excellente XP si vous avez un groupe pour cela : la route passe par Stromgarde en allant au cercle intérieur.",

	-- Step 22: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Au nord-est de Trépas-d'Orgrim, les kobolds Drywhisker exploitent la gorge ; les Kobolds à l'entrée, et les Fouilleurs et les Géomètres plus loin, lâchent tous des Particules de Myzrael.\nAttention : chaque type de kobold fuit chercher de l'aide quand sa vie est basse (les Kobolds à 30 %, les Géomètres et les Fouilleurs à 15 %), ce qui peut en attirer d'autres.",

	-- Step 23: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} se trouvent tout au fond de la gorge.",

	-- Step 24: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Chaque {object:180105} est un anneau de pierres levées ; la clé repose sur la pierre en son centre. Le cercle de l'est se trouve sur les collines au nord-ouest de {area:321}.\nAttention : chaque pierre centrale est gardée par environ trois élémentaires proches du niveau 39, qui attaquent ensemble si vous cliquez sur la pierre sans les avoir éliminés : des Exilés ardents à l'ouest, des Exilés foudroyants au cercle extérieur, des Exilés grimpeurs à l'est.",

	-- Step 25: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Au sud de Trépas-d'Orgrim, les trolls Fanécorce tiennent le village dans les collines. Des Lanceurs de haches gardent les huttes extérieures ; les Sorciers-docteurs et les Chasseurs de têtes tiennent le cœur du village. Attention : les trois types de trolls fuient chercher de l'aide à 15 % de vie, ce qui peut attirer d'autres trolls des camps voisins.",

	-- Step 26: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "Raptors des Hautes-terres et Rampants des plaines",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "En revenant vers le nord, des Trotteurs des Hautes-terres parcourent les collines tout autour de {area:321} et laissent tomber les yeux ; au sud, les Rampants des plaines (32-33) tissent leurs toiles dans l'herbe : ils portent la soie d'araignée.",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "{item:278225}, sur les Rampants des plaines",

	-- Step 27: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}: the doctor stands at the south gate."] = "Retournez au nord à {area:321} : le docteur se tient à la porte sud.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate. If he won't take the silk, another player may be running Triage: wait a few minutes and talk to him again."] = "{npc:12920}, à la porte sud. S'il refuse la soie, un autre joueur fait peut-être Triage : attendez quelques minutes et parlez-lui à nouveau.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, à la porte sud",

	-- Step 28: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Les Brutes Rochepoing campent devant la salle des ogres, loin au sud-ouest de {area:321} ; les Magus se tiennent parmi elles. Attirez-les un par un.",

	-- Step 29: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptors charognards",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Des Charognards des hautes-terres ({npc:2561}) (36-37) chassent dans le sud des hautes-terres, une meute au nord de {area:316} et une autre dans la plaine à son ouest. Attirez-les un par un.",

	-- Step 30: Go'shek Farm
	["Go'shek Farm"] = "Ferme de Go'shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "La cabane-laboratoire de {npc:2733} se trouve à la ferme de Go'shek, au nord-est de la plaine des raptors, sur le chemin du retour vers {area:321} ; la caisse de {item:278462} est à l'intérieur.",

	-- Step 31: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Retour à {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "Retournez au nord-est à {area:321}.",

	-- Step 32: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Quêtes Rochepoing en groupe",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "La {quest:678} suivante de {npc:2771} et la {quest:680} de {npc:2772} concernent les ogres élites (38-40) du quartier ogre de Stromgarde, lors de la même sortie de groupe que le Sceau.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, à côté de lui",

	-- Step 33: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Allez vers l'ouest ; le cercle extérieur se dresse au milieu des Hautes-terres.",

	-- Step 34: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "Le cercle ouest se trouve près du {area:1057}, au nord-ouest du cercle extérieur.",

	-- Step 35: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Le cercle intérieur se trouve au sud du cercle ouest, à l'est de Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "La tâche suivante de la pierre demande Fozruk, un élite de niveau 42 qui rôde à l'ouest de {area:321} : laissez-la.",

	-- Step 36: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "À l'ouest du cercle intérieur, les ruines de Stromgarde : le Syndicat tient la moitié est (le Sceau tombe sur ses Conjurateurs, Rôdeurs et Mages), les Rochepoing la moitié ouest, près de la {area:325} ({npc:2773} attend dans l'une des maisons sans toit à côté).",

	-- Step 37: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Allez vers le sud jusqu'à la crique des gobelins sur la côte sud. {npc:2766} monte la garde sur la falaise au-dessus.",

	-- Step 38: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Escortez le professeur en haut de la colline jusqu'à la grotte au-dessus de la crique et protégez-le pendant qu'il travaille. Deux élémentaires d'eau de niveau 40 lui tendent une embuscade là-haut, et ils sont insensibles au givre. Retenez-les à l'entrée de la grotte, loin de lui : si le combat a lieu dans la grotte, il s'y joint au lieu de travailler et d'autres élémentaires continuent d'arriver.",

	-- Step 40: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328} : tuez-les au passage",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "À l'ouest de la crique, les Ecumeurs ({npc:2595}) et Sorcières Daguéchine (38-40) tiennent le rivage : attirez-les un par un. Les deux épaves gisent dans les hauts-fonds au large, les cartes et journaux à l'intérieur ; les gemmes reposent au fond de la mer autour des épaves.",
	["Underwater"] = "Sous l'eau",

	-- Step 41: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "pour {npc:2487} à {area:35}, vers le niveau 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "Le prochain guide traverse le {area:880} vers {zone:1437} et se dirige vers {zone:1418}.",

	-- Step 42: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Seulement si vous avez fait Stromgarde en groupe : retournez à {area:321} pour rendre ses quêtes, puis continuez jusqu'au {area:880}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Head back east to {area:272}."] = "Retournez vers l'est jusqu'à {area:272}.",
	-- ["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Sortez de {area:272} vers l'est par le {area:1057}. Le Syndicat tient le manoir fortifié et sa ferme au nord de la route ; ses Bandits de grand chemin, Mercenaires et Rôdeurs portent les Amulettes de pierre de sang.\nAttention : les Bandits de grand chemin (niveau 30-31) peuvent être en Furtivité, donc cachés quand vous approchez.",
	-- ["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Allez vers le nord au-delà du camp de Valik jusqu'à {area:280}, le village tenu par le Syndicat (35-37). {npc:2431} porte la {item:3704} ; {quest:503} est enfermé dans une cage, dans la maison du côté nord.\nAttention : des espions camouflés du Syndicat rôdent dans {area:280}, et les bâtiments abritent de nombreux membres du Syndicat, dont des mages.",
	-- ["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Allez vers le nord-ouest à travers les montagnes jusqu'au manoir de Perenolde, sur la rive nord du {area:1339}. {quest:507} (41) attend dans une pièce à l'étage : il se protège d'un bouclier, vous endort et se soigne sous la moitié de sa vie. {npc:2317} se tient à côté de lui.",
	-- ["Perenolde manor"] = "Manoir de Perenolde",
	-- ["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Longez la rive du lac vers le sud jusqu'aux ruines autour du cratère de {area:279}. Les Invocateurs de Dalaran mènent des Esclaves élémentaires ; les brassards tombent sur les esclaves. Attention : des Sentinelles arcaniques (55, élites) et des Gardes du Kirin Tor (55) gardent le dôme lui-même et attaquent la Horde : restez au bord extérieur des ruines et ne montez pas jusqu'au dôme.",
	-- ["The {object:1763} poster by the inn"] = "L'affiche {object:1763} près de l'auberge",
	-- ["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "À l'ouest du cercle intérieur, les ruines de Stromgarde : le Syndicat tient la moitié est (le Sceau tombe sur ses Conjurateurs, Rôdeurs et Mages ; {npc:2783} est parmi eux), les Rochepoing la moitié ouest, près de la {area:325} ({npc:2773} attend dans l'une des maisons sans toit à côté).",
	-- ["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} attend à l'intérieur de l'auberge de {area:272}, en redescendant la route vers le sud.",
	-- ["{npc:2229}, inside the inn"] = "{npc:2229}, à l'intérieur de l'auberge",
	-- ["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) porte la tête. Il n'apparaît qu'à un endroit à la fois : la cave de l'auberge de {area:280}, ou l'un des camps de tentes du Syndicat sur les hauteurs au nord et au nord-ouest du village, qui se trouvent sur votre chemin vers le manoir de Perenolde. Si vous l'avez déjà rencontré en libérant {quest:503}, cette étape est faite.",
	-- ["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "La {quest:671} suivante de {npc:2706}, c'est {npc:2783}, un démoniste élite de niveau 40 dans le quartier du Syndicat de Stromgarde.",
	-- ["{quest:671} with a group"] = "{quest:671} en groupe",
}
