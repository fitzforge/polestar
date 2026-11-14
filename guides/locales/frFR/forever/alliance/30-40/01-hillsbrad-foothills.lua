-- French (frFR): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Angerfang Encampment
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518} : pour {npc:2104}",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Au sud-est depuis Menethil, vers {area:1036} des Dragonmaw : la première catapulte se dresse en chemin, et {object:671518} se trouve dans le camp.",

	-- Step 4: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:2091} est un élite de niveau 32 : la plupart des classes le battent seules au niveau 34, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.\nAttention : des lanceurs de sorts se tiennent de chaque côté de lui, et au moins l'un d'eux lui est lié : il se joint au combat quand vous l'attirez. Des centurions et des capitaines non élites sont répartis autour de son cercle de tentes.",

	-- Step 5: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:271462}, {npc:271338}, {npc:271458} et {npc:271460} sont des élites de niveau 32, chacun appelé en utilisant la {item:279996} à côté de lui. Passez-les si vous êtes seul. {npc:271462} se dresse dans les collines du sud-est.",

	-- Step 6: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "Au nord-est vers {area:1038} : {npc:271338} se tient aux portes (utilisez la {item:279996}).",

	-- Step 7: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038} : tuez-les au passage",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "Les dragonnets nichent dans les collines au nord-est de {area:1036} ; {quest:98283} rôde plus au nord, et les raptors Tranchegueule chassent sur les hautes terres en montant vers {area:205}.\n{quest:98283} est élite : mieux vaut grouper.",

	-- Step 8: Razormaw nests
	["Razormaw nests"] = "Nids de Tranchegueule",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "Les Œufs de Tranchegueule parfaits pour {quest:98246} se trouvent dans les nids des raptors, dans les collines autour de {quest:98283}.",

	-- Step 9: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "{npc:271458} se dresse dans les collines entre {area:1038} et {area:205} (utilisez la {item:279996}).",

	-- Step 10: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "Des Griffes pourries affolées parcourent la {area:1025} autour de {npc:1244} ; l'une d'elles lâche la chair. {npc:1244} n'accepte la quête qu'avec aussi la tête de {quest:98283}.",

	-- Step 11: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "Avec la tête de {quest:98283} et la chair",

	-- Step 12: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "Au nord par la route jusqu'à {area:205}. {npc:1071} et {npc:1075} se tiennent ensemble dans le camp des nains, du côté est de la route ; les ruines des nains {object:147516}, à l'ouest, sont pleines d'élites.",

	-- Step 13: Captive Fire Elemental
	-- {npc:271481} Captive Fire Elemental · {object:147516} Dark Iron · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:271481} est retenu tout à l'ouest des ruines des nains {object:147516}, après des nains élites de niveau 27-30, et {npc:1364} (34, élite) peut se trouver parmi eux. Ramenez-le vers l'est hors des ruines, puis rendez la quête à {npc:1072}, dans le camp. Passez-la si vous êtes seul.",

	-- Step 14: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "{npc:271460} se dresse dans les ruines de {area:205} (utilisez la {item:279996}).",

	-- Step 15: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- {area:205} Dun Modr · {area:880} Thandol Span · {npc:1075} Rhag Garmason
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["North along the road from {area:205} towards the {area:880}: Ebenezer Rustlocke's corpse lies under the span. Rustlocke's parchment goes back to {npc:1075}.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "Au nord par la route depuis {area:205} vers le {area:880} : le cadavre d'Ebenezer Rustlocke gît sous le pont. Le parchemin de Rustlocke retourne à {npc:1075}.\nDeux Saboteurs Sombrefer élites se tiennent près du cadavre, à l'intérieur du pont : attirez-les un par un, ou fouillez le cadavre et ressortez en courant.",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}, à l'intérieur",
	["the same corpse"] = "le même cadavre",

	-- Step 16: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "Redescendez la route jusqu'à {area:205} : {npc:1075} veut que les explosifs des nains {object:147516}, sous l'autre extrémité du pont, soient détruits.",

	-- Step 17: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "{object:2704}",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "De l'autre côté du {area:880} : la cache d'explosifs des Sombrefer se trouve à son extrémité côté Arathi.",

	-- Step 18: Waterlogged Envelope
	["Underwater"] = "Sous l'eau",

	-- Step 19: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "Encore {npc:1075}",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "Retraversez le pont et redescendez la route par {area:205} en direction du sud.",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "pour {npc:2700} à {area:320}, dans 05-arathi-highlands",

	-- Step 21: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:270637} Howin Kindfeather
	["The root core from your {area:17732} run: {npc:1244} stands by the river, just east of {npc:270637}."] = "Le cœur de racine de votre expédition dans {area:17732} : {npc:1244} se tient près de la rivière, juste à l'est de {npc:270637}.",

	-- Step 22: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "{quest:98246} : les œufs",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "Sous terre",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Pour {npc:2916} à {zone:1455}, à la fin de ce guide",

	-- Step 24: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, south of the road west."] = "Le {item:270865} de votre expédition dans {area:17732} : {npc:1077} est sous terre dans ses fouilles, au sud de la route vers l'ouest.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, sous terre",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077} : pour {npc:5387} à {zone:1455}, à la fin de ce guide",

	-- Step 25: Menethil Harbor
	["West along the road to Menethil."] = "À l'ouest par la route jusqu'au Port de Menethil.",
	["On the top floor"] = "Au dernier étage",

	-- Step 26: Menethil Harbor
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "{npc:4455}, près de la porte du donjon : pour {quest:1132} à Theramore, dans le prochain guide",

	-- Step 27: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2104} se tient au dernier étage de {area:2103} : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "{npc:2104} : pour {npc:270637}, en revenant vers l'est par la route",

	-- Step 28: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "Revenez vers l'est par la route jusqu'à la {area:1025} : {npc:270637} campe parmi les Courfangeux, juste à l'ouest de {npc:1244}. Puis retournez à l'ouest jusqu'à Menethil pour le bateau.",

	-- Step 29: Level 30.8
	["Level 30.8"] = "Niveau 30.8",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "Vous avez passé {quest:474} et n'avez pas atteint 30.8 ? Tuez les murlocs Branchie-bleue sur la côte au sud de Menethil jusqu'au niveau 30.8. Ou, en groupe, faites plutôt le donjon {area:133} ou le donjon {area:796} (Cimetière).",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "tuez en boucle : {npc:1418}",

	-- Step 31: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Bateau pour {area:271}",

	-- Step 32: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "En descendant du bateau, remontez la jetée jusqu'en ville : {npc:2711} et le lieutenant Farren se tiennent près de l'auberge, {npc:2430} à l'étage, {npc:2382} à l'est ; le maître de vol est à l'extrémité nord, {npc:2381} et {npc:2438} entre elle et l'auberge, Maleb dans l'hôtel de ville, du côté ouest.\n{npc:2366} ne propose peut-être pas {quest:98463} sur Forever : si elle ne la propose pas, passez-la.",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711} : sa piste mène en Arathi",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "{npc:2228}, à l'intérieur",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, à l'auberge : pour {area:35} (04-stranglethorn-vale)",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "{npc:2430}, à l'étage",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382} : les lions viendront plus tard",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, chez {npc:2381}",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}, à l'intérieur",

	-- Step 33: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "{npc:2438} confectionne une cape en fourrure de yéti pour quiconque lui apporte une {item:3719} ({skill:165}) et un {item:2997} ({skill:197}) ; aucun marchand ne vend l'un ou l'autre, donc cette étape n'apparaît que si vous portez les deux.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "{npc:2438}, entre le maître de vol et l'auberge : il veut aussi une {item:3719} et un {item:2997}",

	-- Step 34: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Aileron déchiré",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "Les murlocs Aileron déchiré se pressent dans {area:295}, au sud-ouest d'{area:271}.\nAttention : un camp abrite un groupe serré d'Oracles qui attaquent tous ensemble.",

	-- Step 35: Farren
	["Farren"] = "Farren",
	["Inside"] = "À l'intérieur",

	-- Step 36: Murloc heads
	["Murloc heads"] = "Têtes de murloc",
	["Back to the same murlocs; not every one drops a head."] = "Retournez voir les mêmes murlocs ; tous ne lâchent pas de tête.",

	-- Step 38: Daggerspine naga
	["Daggerspine naga"] = "Nagas Daguéchine",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Les nagas tiennent le rivage au sud-est de {area:271}.",

	-- Step 39: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "Un rapport pour {object:2117} ; à l'intérieur",

	-- Step 41: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}; you deliver it after the Syndicate camp."] = "{npc:251493} se tient au nord-ouest du maître de vol, sur le chemin de la grotte des yétis, au nord.\n{quest:98059} : {npc:251493} vous remet une {item:279386} pour le conseil de {area:287}, dans les fermes à l'ouest d'{area:271} ; vous la livrez après le camp du Syndicat.",

	-- Step 42: Yeti cave
	["Yeti cave"] = "Grotte des yétis",
	-- {area:271} Southshore · {area:277} Foothill Caverns · {npc:13602} The Abominable Greench
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp.\nStay in the {area:277}: the cave further north has Mountain and Giant Yetis (32-34) in pairs and {npc:13602}, a level 36 elite."] = "Les yétis vivent dans la grotte des collines au nord d'{area:271}, sur le chemin du camp du Syndicat, plus au nord.\nRestez dans {area:277} : la grotte plus au nord abrite des Yétis des montagnes et des Yétis géants (32-34) par deux, et {npc:13602}, un élite de niveau 36.",

	-- Step 43: Alterac Mountains
	["Syndicate camp"] = "Camp du Syndicat",

	-- Step 44: Syndicate camp
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "Le camp du Syndicat se trouve à la frontière d'Alterac, au nord de {area:287}, à l'ouest de {area:272} (Horde) ; les documents sont dans le camp, et ses Détrousseurs et Larrons sont les membres du Syndicat que veut Maleb.",

	-- Step 45: Hillsbrad Fields
	-- {area:286} Hillsbrad Fields
	["South-west from the Syndicate camp to the {area:286} farms."] = "Au sud-ouest du camp du Syndicat, jusqu'aux fermes de {area:286}.",

	-- Step 46: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "Conseil de {area:287}",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "Utilisez la {item:279386} au conseil de {area:287}.",

	-- Step 47: Snapjaws
	["Snapjaws"] = "Gueules d'acier",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Les tortues Gueule d'acier se prélassent le long de la rivière à l'est de {area:271}, au sud de {area:272} (Horde).",

	-- Step 49: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:271} Southshore
	["{area:271} flight master"] = "Maître de vol d'{area:271}",

	-- Step 50: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "{npc:1356}, {npc:2916} et {npc:5637} se tiennent dans {object:32356}, au nord-est du maître de vol.",
	["Level 30 and 32 spells"] = "Sorts des niveaux 30 et 32",

	-- Step 53: Sara Balloo
	-- {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["{npc:2695}: for King Magni, on the same {zone:1455} stop"] = "{npc:2695} : pour le roi Magni, lors de la même escale à {zone:1455}",

	-- Step 55: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Volez jusqu'à {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 56: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "La fromagerie dans {object:2096}.",

	-- Step 57: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} attend à la Taverne du Cochon siffleur, dans {object:2100} ; lui et ses deux voyous vous attaquent, mais s'arrêtent une fois vaincus.",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "Battez {npc:4961} et ses voyous : ils abandonnent",

	-- Step 58: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} entraîne les guerriers dans {object:2100}, près de la Taverne du Cochon siffleur. {npc:6236} attend sur {area:720}, dans {zone:1413}, sur la route de {area:392} bien plus tard (40-50/01).",

	-- Step 60: Cathedral of Light
	["Cathedral of Light"] = "Cathédrale de la Lumière",

	-- Step 62: Mage Quarter
	-- {npc:2708} Archmage Malin · {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} and {npc:4078} are in the {object:2164}; {npc:5081} south of the {object:2101}."] = "{npc:2708} et {npc:4078} sont dans {object:2164} ; {npc:5081} au sud de {object:2101}.",
	-- {npc:4078} Collin Mauren · {area:2240} Mirage Raceway
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{npc:4078}: the Saltstone Basilisks at the {area:2240} drop the scales, in the next guide"] = "{npc:4078} : les Basilics du sel gemme de {area:2240} lâchent les écailles, dans le prochain guide",

	-- Step 63: Druid training
	["Druid training"] = "Entraînement de druide",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "{zone:1455} n'a pas de maître des druides : {npc:5504} se tient à {zone:1453}, au nord-ouest de {object:2101}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Une nouvelle {item:279996}, pour les quatre gardiens titans des {zone:1437}",
	-- ["A report for {object:2117}"] = "Un rapport pour {object:2117}",
	-- ["Back south down the road to the excavation site."] = "Redescendez la route vers le sud jusqu'au site de fouilles.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Détruisez les quatre plans d'attaque du camp pour {quest:98221}.",
	-- ["Fly to {area:415}"] = "Prendre un vol pour {area:415}",
	-- ["Fly to {zone:1453}"] = "Volez jusqu'à {zone:1453}",
	-- ["Follow the road east to {area:118}."] = "Suivez la route vers l'est jusqu'à {area:118}.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Suivez la route vers le sud par le pont jusqu'à {area:205}, à l'extrémité côté {zone:1437}, où {npc:1075} attend.",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Pour {npc:2916} à {zone:1455}, à la fin de ce guide",
	-- ["From {npc:2432} in {area:271}"] = "Depuis {npc:2432} à {area:271}",
	-- ["Golm"] = "Golm",
	-- ["Hearth to {area:2104}"] = "Pierre de foyer vers {area:2104}",
	-- ["If you skipped {quest:474}, grind here to level 31.23 to stay on the route's plan."] = "Si vous avez passé {quest:474}, tuez des monstres ici jusqu'au niveau 31.23 pour suivre le plan de l'itinéraire.",
	-- ["Level 31.23"] = "Niveau 31.23",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Au nord par la route jusqu'à {area:205}. {npc:271460} se dresse dans les ruines (utilisez la {item:279996}) ; {npc:271481} est retenu du côté ouest : ramenez-le à {npc:1072}.",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Au nord-est, vers {area:1038} : les {npc:271373} y sont retenus, et {npc:271338} se dresse aux portes (utilisez la {item:279996}).",
	-- ["Off the boat, {npc:251493} is the first you meet, north-west of the flight master."] = "En descendant du bateau, {npc:251493} est le premier que vous rencontrez, au nord-ouest du maître de vol.",
	-- ["On the way"] = "En chemin",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Prenez tout en ville avant de partir. En descendant du bateau, {npc:251493} est le premier que vous croisez, au nord-ouest du maître de vol ; {npc:2381} et {npc:2438} se tiennent entre le maître de vol et l'auberge, Farren et {npc:2366} à l'auberge, Maleb à l'hôtel de ville.",
	-- ["Pick up everything in town before heading out. {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Prenez tout en ville avant de partir. {npc:2381} et {npc:2438} se tiennent entre le maître de vol et l'auberge, Farren et {npc:2366} à l'auberge, Maleb à l'hôtel de ville.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Des Dragonnets rouges peuplent les collines à l'ouest des portes, des Griffes pourries affolées {area:1025}, des tranchegueules les pentes nord ; Neru se dresse au nord-est (utilisez la {item:279996}).\n{quest:98283} est élite : mieux vaut grouper.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Des Dragonnets rouges peuplent les collines à l'ouest des portes, des Griffes pourries affolées la {area:1025}, des tranchegueules les pentes nord ; {npc:271458} se dresse au nord-est (utilisez la {item:279996}).\n{quest:98283} est élite : mieux vaut grouper.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Au sud, vers {area:1036} des Dragonmaw ; {object:671518} se trouve dans le camp.",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Les Goaz Warders se dressent juste à l'ouest du camp de Whelgar : utilisez la {item:279996} qu'il vous a donnée à côté de l'un d'eux.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Les murlocs Aileron déchiré grouillent sur {area:295}, au sud-ouest de {area:271}.",
	-- ["The Villards"] = "Les Villard",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "L'étape suivante, Vaincre Nek'rosh, vous oppose à un chef élite : passez-la.",
	-- ["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "L'étape suivante, {quest:474}, vous oppose à un chef élite : passez-la.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Les yétis vivent dans la grotte des collines au nord de {area:271}, sur votre retour vers le sud.",
	-- ["To {area:2104}"] = "Vers {area:2104}",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "À l'ouest vers les fermes de {area:287} : posez la {item:279386} sur la table des registres de l'hôtel de ville, où se tiennent {npc:2335} et les conseillers.",
	-- ["Whelps, raptors and {npc:271458}"] = "Dragonnets, raptors et {npc:271458}",
	-- ["{area:287} town hall"] = "Hôtel de ville de {area:287}",
	-- ["{area:287}'s town hall"] = "L'hôtel de ville de {area:287}",
	-- ["{area:442} flight master"] = "Maître de vol d'{area:442}",
	-- ["{npc:1071} stands in the dwarves' camp."] = "{npc:1071} se tient dans le camp des nains.",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244} : {quest:98283}, un raptor élite",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} se tient dans {area:2103} ; {npc:2094} et {npc:270844} se tiennent ensemble près de la porte nord.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} se tient dans {area:2103} ; {npc:2094} se tient près de la porte nord.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104} : pour {npc:270637}",
	-- ["{npc:211033}: only offered once you have handed in library books (the Library Books guide)"] = "{npc:211033} : proposée seulement une fois que vous avez rendu des livres de la bibliothèque (le guide Livres de la bibliothèque)",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} veut aussi une {item:3719}, un {item:2997} et du {item:2321} : fabriqués ou achetés ; la cape se rend plus tard, à votre retour à {area:271}.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844} : pour {npc:3649} à {area:442} (02-desolace)",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:880}; {npc:271322} a short walk further north-east."] = "{npc:5683} attend au nord de {area:205}, près du {area:880} ; {npc:271322} à quelques pas plus au nord-est.",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} attend au nord de {area:205}, près de {area:881} ; {npc:271322} un peu plus loin au nord-est.",
}
