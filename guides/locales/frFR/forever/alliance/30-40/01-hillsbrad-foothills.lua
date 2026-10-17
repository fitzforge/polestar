-- French (frFR): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran
	["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} se tient dans {area:2103} ; {npc:2094} se tient près de la porte nord.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}"] = "{npc:2104} : pour {npc:270637}",

	-- Step 2: Prospector Whelgar
	-- {area:118} Whelgar's Excavation Site
	["Follow the road east to {area:118}."] = "Suivez la route vers l'est jusqu'à {area:118}.",

	-- Step 3: Goaz Warder
	-- {item:279996} Goaz Stone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Les Goaz Warders se dressent juste à l'ouest du camp de Whelgar : utilisez la {item:279996} qu'il vous a donnée à côté de l'un d'eux.",

	-- Step 4: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Une nouvelle {item:279996}, pour les quatre gardiens titans des {zone:1437}",

	-- Step 5: The Green Belt
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Suivez la route vers le nord-est jusqu'à la {area:1025} : {npc:270637} campe au bord, {npc:1244} un peu plus à l'est.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244} : {quest:98283}, un raptor élite",

	-- Step 6: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Au sud, vers {area:1036} des Dragonmaw : la première catapulte se dresse en chemin, et {object:671518} se trouve dans le camp.",
	["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "L'étape suivante, Vaincre Nek'rosh, vous oppose à un chef élite : passez-la.",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518} : pour {npc:2104}",

	-- Step 7: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} se dresse dans les collines du sud-est : utilisez la {item:279996} à côté.",

	-- Step 8: Dragonmaw Gates
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 9: Whelps, raptors and Neru
	-- {npc:271458} Neru
	["Whelps, raptors and {npc:271458}"] = "Dragonnets, raptors et {npc:271458}",
	-- {area:1025} The Green Belt · {npc:271458} Neru · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Des Dragonnets rouges peuplent les collines à l'ouest des portes, des Griffes pourries affolées la {area:1025}, des tranchegueules les pentes nord ; {npc:271458} se dresse au nord-est (utilisez la {item:279996}).\n{quest:98283} est élite : mieux vaut grouper.",

	-- Step 10: The Green Belt
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Pour le roi Magni à {zone:1455}, à la fin de ce guide",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Au nord par la route jusqu'à {area:205}. {npc:271460} se dresse dans les ruines (utilisez la {item:279996}) ; {npc:271481} est retenu du côté ouest : ramenez-le à {npc:1072}.",

	-- Step 12: The Villards
	["The Villards"] = "Les Villard",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:881} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} attend au nord de {area:205}, près de {area:881} ; {npc:271322} un peu plus loin au nord-est.",

	-- Step 13: Prospector Whelgar
	["Back south down the road to the excavation site."] = "Redescendez la route vers le sud jusqu'au site de fouilles.",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Pour {npc:2916} à {zone:1455}, à la fin de ce guide",

	-- Step 14: Menethil Harbor
	["West along the road to Menethil."] = "À l'ouest par la route jusqu'au Port de Menethil.",

	-- Step 15: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Bateau pour {area:271}",

	-- Step 16: Southshore
	-- {npc:251493} Captain McManus · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Prenez tout en ville avant de partir. En descendant du bateau, {npc:251493} est le premier que vous croisez, au nord-ouest du maître de vol ; {npc:2381} et {npc:2438} se tiennent entre le maître de vol et l'auberge, Farren et {npc:2366} à l'auberge, Maleb à l'hôtel de ville.",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, chez {npc:2381}",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382} : les lions viendront plus tard",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, à l'auberge : pour {area:35} (04-stranglethorn-vale)",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711} : sa piste mène en Arathi",

	-- Step 17: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Aileron déchiré",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Les murlocs Aileron déchiré grouillent sur {area:295}, au sud-ouest de {area:271}.",

	-- Step 18: Farren
	["Farren"] = "Farren",

	-- Step 19: Murloc heads
	["Murloc heads"] = "Têtes de murloc",
	["Back to the same murlocs; not every one drops a head."] = "Retournez voir les mêmes murlocs ; tous ne lâchent pas de tête.",

	-- Step 21: Daggerspine naga
	["Daggerspine naga"] = "Nagas Daguéchine",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Les nagas tiennent le rivage au sud-est de {area:271}.",

	-- Step 22: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}"] = "Un rapport pour {object:2117}",

	-- Step 23: Snapjaws
	["Snapjaws"] = "Gueules d'acier",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Les tortues Gueule d'acier se prélassent le long de la rivière à l'est de {area:271}, au sud de {area:272} (Horde).",

	-- Step 24: Syndicate camp
	["Syndicate camp"] = "Camp du Syndicat",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "Le camp du Syndicat se trouve à la frontière d'Alterac, au nord de {area:287}, à l'ouest de {area:272} (Horde) ; les documents sont dans le camp.",

	-- Step 25: Yeti cave
	["Yeti cave"] = "Grotte des yétis",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Les yétis vivent dans la grotte des collines au nord de {area:271}, sur votre retour vers le sud.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} veut aussi une {item:3719}, un {item:2997} et du {item:2321} : fabriqués ou achetés ; la cape se rend plus tard, à votre retour à {area:271}.",

	-- Step 26: Hillsbrad's town hall
	-- {area:287} Hillsbrad
	["{area:287}'s town hall"] = "L'hôtel de ville de {area:287}",
	-- {area:287} Hillsbrad · {item:279386} Sealed Company Request · {npc:2335} Magistrate Burnside
	["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "À l'ouest vers les fermes de {area:287} : posez la {item:279386} sur la table des registres de l'hôtel de ville, où se tiennent {npc:2335} et les conseillers.",
	-- {area:287} Hillsbrad
	["{area:287} town hall"] = "Hôtel de ville de {area:287}",

	-- Step 28: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "Volez jusqu'à {zone:1453}",
	-- {npc:2432} Darla Harris · {area:271} Southshore
	["From {npc:2432} in {area:271}"] = "Depuis {npc:2432} à {area:271}",

	-- Step 29: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "La fromagerie dans {object:2096}.",

	-- Step 30: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} attend à la Taverne du Cochon siffleur, dans {object:2100} ; lui et ses deux voyous vous attaquent, mais s'arrêtent une fois vaincus.",

	-- Step 31: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} entraîne les guerriers dans {object:2100}, près de la Taverne du Cochon siffleur. {npc:6236} attend sur {area:720}, dans {zone:1413}, sur la route de {area:392} bien plus tard (40-50/01).",

	-- Step 33: Cathedral of Light
	["Cathedral of Light"] = "Cathédrale de la Lumière",

	-- Step 34: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} est dans {object:2164} ; {npc:211033} près du canal ; {npc:5081} au sud de {object:2101}.",

	-- Step 36: Druid training
	["Druid training"] = "Entraînement de druide",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} n'a pas de maître des druides : entraînez-vous auprès de {npc:5504} à {zone:1453} avant le tram.",

	-- Step 37: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}.",
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	["Level 30 and 32 spells"] = "Sorts des niveaux 30 et 32",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Détruisez les quatre plans d'attaque du camp pour {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Volez jusqu'à {zone:1453}",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Suivez la route vers le nord-est jusqu'à {area:1025} : {npc:270637} campe au bord, {npc:1244} un peu plus à l'est.",
	-- ["Golm"] = "Golm",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Au nord-est, vers {area:1038} : les {npc:271373} y sont retenus, et {npc:271338} se dresse aux portes (utilisez la {item:279996}).",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Des Dragonnets rouges peuplent les collines à l'ouest des portes, des Griffes pourries affolées {area:1025}, des tranchegueules les pentes nord ; Neru se dresse au nord-est (utilisez la {item:279996}).\n{quest:98283} est élite : mieux vaut grouper.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Au sud, vers {area:1036} des Dragonmaw ; {object:671518} se trouve dans le camp.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} se tient dans {area:2103} ; {npc:2094} et {npc:270844} se tiennent ensemble près de la porte nord.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844} : pour {npc:3649} à {area:442} (02-desolace)",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} n'a pas de maître des druides : entraînez-vous auprès de {npc:5504} à {zone:1453} avant le tram.",
}
