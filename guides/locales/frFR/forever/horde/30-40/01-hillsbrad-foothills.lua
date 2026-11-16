-- French (frFR): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "Pour les personnages de niveau 29 à 31 : {quest:527}, les tâches de {area:272} et les gnolls des contreforts, tous à votre niveau ou en dessous.",

	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "Maître de vol de {area:484}",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "Prenez un vol de {area:484} pour {area:1638} et allez vous entraîner auprès de {npc:3033} sur {area:1639} ; de là, continuez en vol jusqu'à la Croisée.",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "Prenez un vol de {area:484} pour {area:392}. {npc:5901} campe sur la côte, à quelques pas au sud de la ville ; de {area:392}, continuez en vol jusqu'à la Croisée.",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "{npc:5901} : votre {item:6637}, pour le brasero",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "Vol pour la Croisée",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 7: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows · {zone:1454} Orgrimmar
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428} se tient à côté du maître de vol de la Croisée. {quest:1145} est disponible dès le niveau 29 ; en dessous, l'étape à {zone:1454} du guide suivant s'en charge.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428} : pour {npc:4485} à {zone:1454}",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	["Crossroads flight master"] = "Maître de vol de la Croisée",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:4949} attend dans le fort Grommash, dans la {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Grommash Hold, si vous l'avez",

	-- Step 10: Train
	["Train"] = "Entraînement",
	["Train your new spells."] = "Apprenez vos nouveaux sorts.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "{npc:4485} se tient dans la {object:172958}, sur le chemin de la grande porte.",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "pour {npc:4483} aux {area:439} : guide suivant",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 13: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "{npc:260093} forme les Paladins à {zone:1458}.",

	-- Step 14: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Maître de vol de {zone:1458}",

	-- Step 15: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Prenez un vol pour {area:228}. Le {object:113791} se dresse sur la colline juste au sud-ouest : battez la Manifestation d'eau corrompue à côté, placez ses brassards dans le brasero, parlez à la {npc:5895} et gardez l'{item:7813} pour {npc:5901}. De {area:228}, continuez en vol jusqu'à {area:272}.",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "{item:6637} : buvez-le près de la pierre levée pour voir l'élémentaire",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "pour {npc:5901} : guide suivant",

	-- Step 16: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Prendre un vol pour {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "Maître de vol du {area:228}",

	-- Step 18: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "L'affiche de {quest:567} est près de l'auberge ; l'{npc:2216} se tient à l'intérieur. {npc:2393}, le cuisinier près de l'auberge, veut de la viande de tortue et vend les épices nécessaires.",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "{quest:567}, l'affiche près de l'auberge",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, à l'intérieur",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393} : {quest:7321}, les Happe-mâchoires de la rivière au sud du village",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{item:3713}, chez {npc:2393}",

	-- Step 19: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "Vous avez manqué les premières courses de Darthalia, du guide {area:287} 22-25 : elles passent d'abord maintenant. Elles sont quelques niveaux en dessous du vôtre et rapides, et elles ouvrent la suite de {quest:527} dans ce guide.",

	-- Step 20: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229} veut que ses deux éclaireurs soient libérés de {area:275}.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, à l'intérieur",

	-- Step 21: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "À l'ouest après les collines, jusqu'aux fermes à l'est du village d'{area:287}. {npc:232} travaille le champ près de la ferme du nord, {npc:2403} celui plus au sud-est ; il y a des Ouvriers agricoles et des Fermiers partout.\nAttention : des Gardes du Kirin Tor (55) patrouillent dans les champs et sur les routes d'{area:287} et attaquent la Horde : guettez-les et ne vous mettez pas sur leur chemin.",

	-- Step 22: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "Retournez vers l'est à {area:272}.",

	-- Step 23: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "Paysans d'Hillsbrad",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "Retour aux champs : les Paysans travaillent au sud des fermes. Attention : un paysan qui s'enfuit et atteint l'hôtel de ville peut ramener des renforts ; les ralentissements ou les immobilisations les empêchent de s'échapper.",

	-- Step 26: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "Au sud-est de Moulin-de-Tarren. Drull et {npc:2238} sont enchaînés dans les bâtiments de la cour du donjon : {npc:2427} porte la {item:3467} et {npc:2428} la {item:3499}, tous deux dans le donjon. Tuez-les, puis ouvrez les deux serrures.",
	["Drull's ball and chain"] = "Boulet et chaîne de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Boulet et chaîne de {npc:2238}",

	-- Step 27: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "Retour à {area:272}.",

	-- Step 28: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "La rivière au sud de {area:272} : tuez-les au passage",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "Au sud de {area:272}, le long de la rivière : des Happe-mâchoires (29) se prélassent sur les berges jusqu'aux collines au-dessus d'{area:271}. Certains portent de la {item:3712}.",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "{item:3712}, sur les Happe-mâchoires",

	-- Step 29: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "Au sud du coude de la rivière, les gnolls Groin-de-boue (26-28) campent dans les collines au-dessus de {area:290} ; les fleurs poussent parmi leurs tentes. Les chamans soignent et appellent leurs alliés : attirez-les en premier.",

	-- Step 30: North of Southshore
	["North of Southshore"] = "Au nord d'Austrivage",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "Depuis les fleurs, remontez vers le nord le long de la rivière puis allez à l'ouest jusqu'au village d'{area:287}, bien au nord d'{area:271} (ses gardes sont niveau 55).",

	-- Step 31: The smithy
	["The smithy"] = "La forge",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "À l'ouest à travers les contreforts jusqu'au village d'{area:287} : la forge se trouve en son centre. {npc:2404} et ses apprentis travaillent à la forge ; le {object:1736} est empilé à côté. Le {npc:2449} se promène près de la forge ; {npc:2451} travaille le champ au sud-est du village.",
	["Inside"] = "À l'intérieur",

	-- Step 32: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "pour le {npc:2055}, lors de l'étape à {zone:1458} à la fin de ce guide",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "{npc:2429}, dans le village : {item:3708}, sur les yétis en route vers l'hôtel de ville",

	-- Step 33: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "À l'ouest de Moulin-de-Tarren, les Yétis des grottes et les Yétis féroces (30-32) remplissent {area:277}, dans les collines ; environ un sur seize porte le bâtonnet. Restez dans ces cavernes : les Yétis des montagnes et les Yétis géants (32-34) de la grotte plus au nord le portent aussi, mais ils frappent fort et viennent par deux.",

	-- Step 34: Town hall
	["Town hall"] = "Hôtel de ville",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Continuez jusqu'au village de {area:287}, au sud-ouest des grottes des yétis. L'hôtel de ville est du côté ouest du village : {npc:2335} (30) et {npc:2448} sont à l'intérieur avec le registre de la ville ; la proclamation est affichée juste à côté. Des conseillers se promènent dans le village.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, à l'intérieur",

	-- Step 35: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "La course suivante de Thaivand, les flammes, vous envoie parmi les Yétis des montagnes et les Yétis géants (32-34) et jusqu'à la tombe d'Helcular dans {area:271} : laissez-la.",

	-- Step 36: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "Pour votre expédition dans City of Dalaran, plus loin dans ce guide : {npc:2278} se tient à {area:272}, à quelques pas à l'est de {npc:2410}.",

	-- Step 37: City of Dalaran
	["City of Dalaran"] = "City of Dalaran",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "City of Dalaran est un donjon pour un groupe de cinq, vers les niveaux 28 à 33, sous le dôme violet. Sans la {item:277507}, entrez par la canalisation d'égout au nord-ouest du cratère : la flèche y mène.\nÀ l'intérieur : {npc:247126} est pour {npc:2278}. {npc:268743}, dans les égouts, donne Opportunistic Education et la reprend là-bas.",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986} : {npc:247126}, à l'intérieur",

	-- Step 39: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Dirigez-vous vers le sud-ouest au-delà du village d'{area:287} jusqu'à la {area:288}. Des mineurs travaillent dans les galeries ; le {npc:2305} (30) et le {npc:2450} (29) sont tout au fond.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "Dans {area:288}",

	-- Step 40: Level 30
	["Level 30"] = "Niveau 30",
	-- {npc:2410} Magus Wordeen Voidglare · {area:272} Tarren Mill · {zone:1454} Orgrimmar · {area:288} Azurelode Mine · {zone:1437} Wetlands
	-- plural, as words: Torn Fin Muckdwellers = {npc:2374} Torn Fin Muckdweller
	["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "Les quêtes de {npc:2410} lors de la prochaine étape à {area:272} et Alliance Relations à {zone:1454}, première étape du guide suivant, sont proposées à partir du niveau 30. Pas encore 30 ? Les Marche-boue et Cours-la-côte Aileron déchiré (28-30) peuplent la côte au sud de la {area:288}, à quelques pas : tuez-les jusqu'au niveau 30. Leurs Oracles (30-31) lancent des sorts depuis le rivage plus à l'est. Ou, en groupe, faites plutôt le donjon Excavation Site (dans les {zone:1437}).",
	["Torn Fin murlocs"] = "Murlocs Aileron déchiré",
	-- {npc:2375} Torn Fin Coastrunner
	["grind on {npc:2375}"] = "tuez en boucle : {npc:2375}",

	-- Step 41: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "Terminez la {item:3712}",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "Il vous manque encore de la {item:3712} (dix au total) ? Les Claquemâchoires bordent la rivière à l'est de {area:272}, sur le chemin du retour de la mine.",

	-- Step 42: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "Au nord-est, retour à {area:272}, en passant bien au nord d'{area:271} (ses gardes sont de niveau 55).",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215} : sa {quest:539} suivante et l'épée de {npc:2419} sont des quêtes de groupe élites à {area:290} : ne les prenez qu'avec un groupe",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "{npc:2229}, à l'intérieur : Infiltration, faite lors du passage 38-39 (son Syndicat est 32-35)",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "Gardez Infiltration dans votre journal : son Syndicat (32-35) est au-dessus de votre niveau pour l'instant, et le guide 38-39 (Alterac et Arathi) la traite lors de sa première boucle à {area:272}.",

	-- Step 43: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "Voidglare, Bel'varil et {npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410} et le {npc:2437} sont dans l'auberge, {npc:2770} juste devant. Leurs quêtes sont proposées à partir du niveau 30 ; en dessous, la première étape du guide 38-39 à {area:272} les prend.",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "{npc:2410}, à l'intérieur : {quest:544}, pour le passage 38-39 (les traîtres du cratère de {area:279} sont 33-35)",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410} : {quest:93680}, avec {quest:544} lors du passage 38-39",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "{npc:2437}, à l'intérieur : {quest:556}, avec le cratère lors du passage 38-39",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "{npc:2770}, devant l'auberge : les ogres Rochepoing (32-34) lors du passage 38-39 en Arathi",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "Gardez-les dans votre journal : leurs camps ont deux à quatre niveaux de plus que vous pour l'instant, et le guide 38-39 les traite lors de sa première boucle à {area:272} et à {area:321}.",

	-- Step 44: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "{quest:96986} de votre expédition dans City of Dalaran : {npc:2278}, à quelques pas à l'est de {npc:2410}.",

	-- Step 45: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "{quest:539} en groupe",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "La dernière bataille de Darthalia a lieu à {area:290}, le fort nain au sud-est d'{area:271} : tous les nains y sont élites (28-32), {npc:2304} aussi. Excellente XP si vous avez un groupe pour cela.",

	-- Step 46: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "{quest:547} en groupe",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "L'épée de {npc:2419} tombe sur ces mêmes nains de {area:290} (environ une fois sur douze).",

	-- Step 47: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "Nettoyez {area:290} en partant de la porte ; les nains fuient chercher de l'aide à 30 % de vie.",

	-- Step 48: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "pour {npc:2425} à {zone:1458}, à la fin de ce guide",

	-- Step 50: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Maître de vol de {area:272}",

	-- Step 51: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055} se tient dans l'Apothicarium, dans le {object:36126}.",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "La quête suivante de Faranell, {quest:513}, demande un {item:3388} ({skill:171}) et la côte de {area:287} : laissez-la.",

	-- Step 52: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "{npc:2425} se tient à côté de Sylvanas dans le {object:36126}.",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "{npc:2425} : la recommandation de Darthalia",

	-- Step 53: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038} se tient dans l'Apothicarium. Sa quête {quest:97985} vise Stormheart, un élite de niveau 30 qui arpente le canyon à l'est du {area:484}, sur le chemin du prochain guide vers les {area:439}.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038} : revenez le voir lors de la prochaine étape à {zone:1458}, vers le niveau 38",

	-- Step 54: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Maîtres de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entraînez-vous pendant que vous êtes à {zone:1458} : les maîtres se trouvent dans {object:36070}, {object:36073} et {object:36082} (paladins : {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "Retournez dans les grottes des yétis à l'ouest de {area:272} avec le {item:3710}. Le chemin se divise juste après l'entrée : la {object:1768} brûle au niveau supérieur, à droite, la {object:1769} au niveau inférieur, à gauche, après d'autres yétis.",
	-- ["Back north to {area:321}."] = "Retournez vers le nord à {area:321}.",
	-- ["Back to {area:272}"] = "Retour à {area:272}",
	-- ["Below ground"] = "Sous terre",
	-- ["Boulderfist camp"] = "Camp Rochepoing",
	-- ["Daggerspine naga"] = "Nagas Daguéchine",
	-- ["Daggerspine shore"] = "Rivage des Daguéchine",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Suivez la route au nord de {area:272} jusqu'aux contreforts d'Alterac. {quest:535} attend près du camp du Syndicat ; donnez-lui la bière.",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "Pour les personnages de niveau 29 à 33, mais la plupart des quêtes ici sont de niveau 32-34, quelques-unes jusqu'à 36 : c'est voulu, pour leur expérience. Le Syndicat, les gardes de {area:279} et les ogres Rochepoing sont de niveau 31-35 : attirez-les un par un.",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Depuis {area:271}, remontez vers le nord après {area:272} et suivez la route jusque dans les contreforts d'Alterac. {quest:535} attend près du camp du Syndicat. Il ne propose sa course que tant que vous avez « Infiltration » de {npc:2229} : donnez-lui tout de suite la bière, et sa récompense est la Missive du Syndicat que veut Krusk. Une missive du Syndicat obtenue ici fait la même chose : avec une missive dans vos sacs, le guide passe {quest:535}.",
	-- ["Head back north to {area:272}."] = "Retournez vers le nord jusqu'à {area:272}.",
	-- ["Head back south down the road to {area:272}."] = "Redescendez la route vers le sud jusqu'à {area:272}.",
	-- ["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Sortez de {area:272} vers l'est par le {area:1057} et suivez la route vers l'est. Les Ogres Rochepoing et les Exécuteurs (32-34) campent au sud de la route, au sud du {area:313} ; les Exécuteurs restent dans la grotte.",
	-- ["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north, down the slope above the town. Southshore Guards (55) stand at the graveyard's north-west corner and south-east of the grave: walk in between them, hand the quest in and leave the way you came."] = "Allez vers l'est jusqu'au cimetière d'{area:271}, à la lisière nord-est de la ville : la tombe d'Helcular se trouve parmi les autres. Abordez-la par le nord, en descendant la pente au-dessus de la ville. Des Gardes d'Austrivage (55) se tiennent à l'angle nord-ouest du cimetière et au sud-est de la tombe : passez entre eux, rendez la quête et repartez par où vous êtes venu.",
	-- ["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Dirigez-vous vers le sud au-delà du village de {area:287} jusqu'à la {area:288}. Des mineurs travaillent dans les galeries ; {npc:2305} (30) et {npc:2450} (29) sont tout au fond.",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp. Arcane Sentries (55, elite) and Kirin Tor Guards (55) stand around the violet dome itself: keep to the camp below the rim."] = "Allez vers l'ouest le long du pied des montagnes jusqu'au dôme violet de {area:279}. {npc:2411}, {npc:2412} et {npc:2413} (33-34) se tiennent ensemble à l'intérieur du bord est du cratère, {npc:2414} (35) un peu à l'ouest d'eux ; chacun porte un morceau de pierre de sang. Les Gardes-boucliers et les Théurges (31-33) autour d'eux lâchent les Runes gravées usées. Attention : de nombreux gardes se tiennent par paires liées et d'autres patrouillent seuls autour du camp. Des Sentinelles arcaniques (55, élites) et des Gardes du Kirin Tor (55) se tiennent autour du dôme violet lui-même : restez dans le camp sous le bord.",
	-- ["Highland raptors and Plains Creepers"] = "Raptors des Hautes-terres et Rampants des plaines",
	-- ["Level 31"] = "Niveau 31",
	-- ["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "La course suivante de Lydon est un tonneau de stout de Shindigger à rapporter de la cave de {area:290}, le fort nain élite au sud-est d'{area:271} : ne la prenez que si vous y allez en groupe.",
	-- ["North of Southshore's graveyard"] = "Au nord du cimetière d'Austrivage",
	-- ["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "En revenant vers le nord, des Trotteurs des Hautes-terres parcourent les collines tout autour de {area:321} et laissent tomber les yeux ; au sud, les Rampants des plaines (32-33) tissent leurs toiles dans l'herbe : ils portent la soie d'araignée.",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "Seulement si la missive de {quest:535} ne vous est pas parvenue : les Détrousseurs et Larrons du Syndicat (32-34) autour des camps à l'ouest de la route portent aussi des missives ; environ un sur trois en laisse tomber une. Attention : au niveau 31-32, ils sont encore au-dessus de vous et se tiennent serrés, avec des Sorciers (34-35) parmi eux : attirez-les un par un depuis le bord du camp.",
	-- ["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "Placez le {object:1729} sur la {object:1728} à côté de l'auberge ; à l'étage",
	-- ["Shindigger keg"] = "Tonneau de Shindigger",
	-- ["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Au sud de Trépas-d'Orgrim, les trolls Fanécorce tiennent le village dans les collines. Des Lanceurs de haches gardent les huttes extérieures ; les Sorciers-docteurs et les Chasseurs de têtes tiennent le cœur du village. Attention : les trois types de trolls fuient chercher de l'aide à 15 % de vie, ce qui peut attirer d'autres trolls des camps voisins.",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "Au sud-ouest, les Yétis des grottes et les Yétis féroces (30-32) remplissent {area:277}, dans les collines à l'ouest de {area:272} ; environ un sur seize porte le bâtonnet. Restez dans ces cavernes : les Yétis des montagnes et les Yétis géants (32-34) de la grotte plus au nord le portent aussi, mais au niveau 29-30 ils frappent fort et viennent par deux.",
	-- ["Syndicate missives"] = "Missives du Syndicat",
	-- ["The Daggerspine naga line the shore south-east of the town."] = "Les nagas Daguéchine bordent le rivage au sud-est de la ville.",
	-- ["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "Les tonneaux de stout de Shindigger se trouvent dans la cave de {area:290}, le fort nain au sud-est d'{area:271}, à côté de {npc:2304} (32) ; tous les nains y sont élites (28-32).",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Les Détrousseurs et Larrons du Syndicat (32-33) autour des camps à l'ouest de la route portent les missives ; environ un sur trois en laisse tomber une.",
	-- ["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "Les murlocs Aileron déchiré campent sur les plages au sud-ouest de la baie d'{area:271}, en contrebas de la mine.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Le tonneau se trouve avec quelques autres au camp du Syndicat, sur la côte sud-est de {area:287}.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "La forteresse orque au bout est de la route. {npc:2851}, la maîtresse des coursiers du vent, se tient près de la porte.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "La forteresse orque au bout est de la route. {npc:2851}, la maîtresse des coursiers du vent, se tient près de la porte.\n{npc:15126} ne propose le {quest:8263} qu'une fois que vous êtes Amical auprès des Profanateurs ({zone:1461}) : passez-le s'il ne le propose pas.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "La troisième flamme brûle dans la plus petite grotte, en haut des collines au nord des cavernes.\nAttention : des Yétis géants et des Yétis des montagnes (32-34) entourent la flamme, souvent par deux, et Gueule-glacée, un yéti rare (37), rôde tout près. Au niveau 30-31, ils sont au-dessus de votre niveau : attirez les yétis un par un depuis l'entrée de la grotte avant d'utiliser le Bâtonnet, et guettez Gueule-glacée avant d'entrer.",
	-- ["The {area:279} crater"] = "Le cratère de {area:279}",
	-- ["The {area:279} crater's eastern rim"] = "Le bord est du cratère de {area:279}",
	-- ["Torn Fin beach"] = "Plage des Aileron déchiré",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "À l'ouest à travers les contreforts jusqu'au village d'{area:287} : la forge se trouve en son centre. {npc:2404} et ses apprentis travaillent à la forge ; la {object:1736} est empilée à côté.",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "Avec un {item:3388} dans vos sacs, {npc:2055} propose {quest:513} dans l'Apothicarium ; {npc:2216} prend l'élixir à {area:272}.",
	-- ["grind on {npc:2248}"] = "tuez en boucle : {npc:2248}",
	-- ["grind on {npc:2562}"] = "tuez en boucle : {npc:2562}",
	-- ["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the City of Dalaran dungeon instead."] = "{quest:544}, {quest:556} et {quest:676}, à {area:272}, sont proposées à partir du niveau 30. En dessous ? Continuez à tuer les yétis de ces grottes jusqu'au niveau 30. Ou, en groupe, faites plutôt le donjon City of Dalaran.",
	-- ["{area:321} flight master"] = "Maître de vol de {area:321}",
	-- ["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the City of Dalaran dungeon instead."] = "Les quêtes de {area:321} sont de niveau 32-36. En dessous de 31 ? Continuez à tuer les Ogres et Exécuteurs Rochepoing de ce camp jusqu'au niveau 31. Ou, en groupe, faites plutôt le donjon City of Dalaran.",
	-- ["{item:278225}, from Plains Creepers"] = "{item:278225}, sur les Rampants des plaines",
	-- ["{item:279469}: an object to loot, by the traitors"] = "{item:279469} : un objet à ramasser, près des traîtres",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388} : hôtel des ventes ou un alchimiste, pour {quest:513}.",
	-- ["{item:3703}, for {npc:2333}"] = "{item:3703}, pour {npc:2333}",
	-- ["{npc:12920}, at the south gate"] = "{npc:12920}, à la porte sud",
	-- ["{npc:2229} now offers {npc:2316} (level 36), Bel'varil Bracers of Binding and Voidglare Dalaran Patrols: leave them for the 38-39 visit, which takes them on its first {area:272} stop."] = "{npc:2229} propose maintenant {npc:2316} (niveau 36), Bracers of Binding de Bel'varil et Dalaran Patrols de Voidglare : gardez-les pour le passage à 38-39, qui les prend à sa première halte à {area:272}.",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229} veut que ses deux éclaireurs soient libérés de {area:275} avant de vous confier « Infiltration ».",
	-- ["{npc:2410}, inside"] = "{npc:2410}, à l'intérieur",
	-- ["{npc:2410}, inside: offered from level 30"] = "{npc:2410}, à l'intérieur : proposée à partir du niveau 30",
	-- ["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410} : {quest:93680}, la {item:279469} est près des traîtres",
	-- ["{npc:2437}, inside"] = "{npc:2437}, à l'intérieur",
	-- ["{npc:2437}, inside: offered from level 30"] = "{npc:2437}, à l'intérieur : proposée à partir du niveau 30",
	-- ["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "Guile of the Raptor de {npc:2706}, la {quest:677} suivante de {npc:2771} et Ward Restocking du docteur attendent le passage à 38-39.",
	-- ["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "{npc:2706} : les membres du Syndicat de sa quête sont près de la route venant de {area:272}, lors du passage à 38-39",
	-- ["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "{npc:2770} : pour {npc:2771} à {area:321}, plus loin dans ce guide (à partir du niveau 30)",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}, près de la porte",
	-- ["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} se tient à côté du maître de vol de la Croisée.",
	-- ["{quest:513} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "{quest:513} demande un {item:3388}, un objet d'{skill:171} : achetez-en un à l'hôtel des ventes si vous le pouvez (ou demandez à un alchimiste). Le texte de la quête parle de « fort », mais il faut bien un {item:3388}. Pas d'élixir : passez les étapes de l'élixir à {area:287}.",
	-- ["{quest:515} with a group"] = "{quest:515} en groupe",
}
