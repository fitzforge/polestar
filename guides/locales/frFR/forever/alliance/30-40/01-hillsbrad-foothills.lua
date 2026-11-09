-- French (frFR): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "Vers {area:2104}",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "",

	-- Step 4: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "L'étape suivante, {quest:474}, vous oppose à un chef élite : passez-la.",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518} : pour {npc:2104}",

	-- Step 5: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:2091} est un élite de niveau 32 : la plupart des classes le battent seules au niveau 34, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.\nAttention : des lanceurs de sorts se tiennent de chaque côté de lui, et au moins l'un d'eux lui est lié : il se joint au combat quand vous l'attirez. Des centurions et des capitaines non élites sont répartis autour de son cercle de tentes.",

	-- Step 6: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "",

	-- Step 7: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "Au nord-est vers {area:1038} : {npc:271338} se tient aux portes (utilisez la {item:279996}).",

	-- Step 8: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038} : tuez-les au passage",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "",

	-- Step 9: Razormaw nests
	["Razormaw nests"] = "",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "",

	-- Step 10: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "",

	-- Step 11: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "",

	-- Step 12: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "",

	-- Step 13: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "",

	-- Step 14: Captive Fire Elemental
	-- {npc:271481} Captive Fire Elemental · {object:147516} Dark Iron · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "",

	-- Step 15: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "",

	-- Step 16: The Villards
	["The Villards"] = "Les Villard",
	-- {npc:5683} Corma Villard · {area:205} Dun Modr · {area:880} Thandol Span · {npc:271322} Essene Villard · {npc:1075} Rhag Garmason · {quest:87318} Hearts of the Lost
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["{npc:5683} waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east, and Ebenezer Rustlocke's corpse lies under the span beside her. Rustlocke's parchment goes back to {npc:1075}.\n{npc:5683} may not offer {quest:87318} yet: if she doesn't, skip it.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}, à l'intérieur",
	["the same corpse"] = "",

	-- Step 17: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "",

	-- Step 18: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "",

	-- Step 19: Waterlogged Envelope
	["Underwater"] = "Sous l'eau",

	-- Step 20: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "",

	-- Step 22: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "Sous terre",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Pour {npc:2916} à {zone:1455}, à la fin de ce guide",

	-- Step 24: Menethil Harbor
	["West along the road to Menethil."] = "À l'ouest par la route jusqu'au Port de Menethil.",
	["On the top floor"] = "Au dernier étage",
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "",

	-- Step 25: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "",

	-- Step 26: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "",
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Pour le roi Magni à {zone:1455}, à la fin de ce guide",

	-- Step 27: Level 30.8
	["Level 30.8"] = "",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "tuez en boucle : {npc:1418}",

	-- Step 29: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Bateau pour {area:271}",

	-- Step 30: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "",
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

	-- Step 31: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "",

	-- Step 32: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Aileron déchiré",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "Les murlocs Aileron déchiré se pressent dans {area:295}, au sud-ouest d'{area:271}.\nAttention : un camp abrite un groupe serré d'Oracles qui attaquent tous ensemble.",

	-- Step 33: Farren
	["Farren"] = "Farren",
	["Inside"] = "À l'intérieur",

	-- Step 34: Murloc heads
	["Murloc heads"] = "Têtes de murloc",
	["Back to the same murlocs; not every one drops a head."] = "Retournez voir les mêmes murlocs ; tous ne lâchent pas de tête.",

	-- Step 36: Daggerspine naga
	["Daggerspine naga"] = "Nagas Daguéchine",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Les nagas tiennent le rivage au sud-est de {area:271}.",

	-- Step 37: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "Un rapport pour {object:2117} ; à l'intérieur",

	-- Step 39: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}; you deliver it after the Syndicate camp."] = "",

	-- Step 40: Yeti cave
	["Yeti cave"] = "Grotte des yétis",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp."] = "",

	-- Step 41: Alterac Mountains
	["Syndicate camp"] = "Camp du Syndicat",

	-- Step 42: Syndicate camp
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "",

	-- Step 43: Hillsbrad Fields
	-- {area:286} Hillsbrad Fields
	["South-west from the Syndicate camp to the {area:286} farms."] = "",

	-- Step 44: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "",

	-- Step 45: Snapjaws
	["Snapjaws"] = "Gueules d'acier",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Les tortues Gueule d'acier se prélassent le long de la rivière à l'est de {area:271}, au sud de {area:272} (Horde).",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:271} Southshore
	["{area:271} flight master"] = "Maître de vol d'{area:271}",

	-- Step 48: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "",
	["Level 30 and 32 spells"] = "Sorts des niveaux 30 et 32",

	-- Step 52: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",

	-- Step 53: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Volez jusqu'à {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 54: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "La fromagerie dans {object:2096}.",

	-- Step 55: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} attend à la Taverne du Cochon siffleur, dans {object:2100} ; lui et ses deux voyous vous attaquent, mais s'arrêtent une fois vaincus.",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "",

	-- Step 56: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} entraîne les guerriers dans {object:2100}, près de la Taverne du Cochon siffleur. {npc:6236} attend sur {area:720}, dans {zone:1413}, sur la route de {area:392} bien plus tard (40-50/01).",

	-- Step 58: Cathedral of Light
	["Cathedral of Light"] = "Cathédrale de la Lumière",

	-- Step 60: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:5081} south of the {object:2101}."] = "",

	-- Step 61: Druid training
	["Druid training"] = "Entraînement de druide",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Une nouvelle {item:279996}, pour les quatre gardiens titans des {zone:1437}",
	-- ["A report for {object:2117}"] = "Un rapport pour {object:2117}",
	-- ["Back south down the road to the excavation site."] = "Redescendez la route vers le sud jusqu'au site de fouilles.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Détruisez les quatre plans d'attaque du camp pour {quest:98221}.",
	-- ["Fly to {area:415}"] = "Prendre un vol pour {area:415}",
	-- ["Fly to {zone:1453}"] = "Volez jusqu'à {zone:1453}",
	-- ["Follow the road east to {area:118}."] = "Suivez la route vers l'est jusqu'à {area:118}.",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Suivez la route vers le nord-est jusqu'à la {area:1025} : {npc:270637} campe au bord, {npc:1244} un peu plus à l'est.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Suivez la route vers le sud par le pont jusqu'à {area:205}, à l'extrémité côté {zone:1437}, où {npc:1075} attend.",
	-- ["For King Magni in {zone:1455}, at the end of this guide"] = "Pour le roi Magni à {zone:1455}, à la fin de ce guide",
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
	-- ["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Au sud, vers {area:1036} des Dragonmaw : la première catapulte se dresse en chemin, et {object:671518} se trouve dans le camp.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Au sud, vers {area:1036} des Dragonmaw ; {object:671518} se trouve dans le camp.",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Les Goaz Warders se dressent juste à l'ouest du camp de Whelgar : utilisez la {item:279996} qu'il vous a donnée à côté de l'un d'eux.",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "Le camp du Syndicat se trouve à la frontière d'Alterac, au nord de {area:287}, à l'ouest de {area:272} (Horde) ; les documents sont dans le camp.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Les murlocs Aileron déchiré grouillent sur {area:295}, au sud-ouest de {area:271}.",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "L'étape suivante, Vaincre Nek'rosh, vous oppose à un chef élite : passez-la.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Les yétis vivent dans la grotte des collines au nord de {area:271}, sur votre retour vers le sud.",
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
	-- ["{npc:2104}: for {npc:270637}; on the top floor"] = "{npc:2104} : pour {npc:270637} ; au dernier étage",
	-- ["{npc:211033}: only offered once you have handed in library books (the Library Books guide)"] = "{npc:211033} : proposée seulement une fois que vous avez rendu des livres de la bibliothèque (le guide Livres de la bibliothèque)",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} veut aussi une {item:3719}, un {item:2997} et du {item:2321} : fabriqués ou achetés ; la cape se rend plus tard, à votre retour à {area:271}.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844} : pour {npc:3649} à {area:442} (02-desolace)",
	-- ["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} est dans {object:2164} ; {npc:211033} près du canal ; {npc:5081} au sud de {object:2101}.",
	-- ["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} se dresse dans les collines du sud-est : utilisez la {item:279996} à côté.",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:880}; {npc:271322} a short walk further north-east."] = "{npc:5683} attend au nord de {area:205}, près du {area:880} ; {npc:271322} à quelques pas plus au nord-est.",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} attend au nord de {area:205}, près de {area:881} ; {npc:271322} un peu plus loin au nord-est.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} n'a pas de maître des druides : entraînez-vous auprès de {npc:5504} à {zone:1453} avant le tram.",
}
