-- French (frFR): the guide forever/alliance/40-50/01b-riverglades (forever/alliance/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16724} Farholde Keep
	["About 90 quests in Forever's new zone, from {area:16724}: the level for its port and Western Front."] = "Environ 90 quêtes dans la nouvelle zone de Forever, depuis {area:16724} : le niveau pour son port et le Front occidental.",

	-- Step 1: Ironforge flight master
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",
	-- {zone:1426} Dun Morogh · {zone:1455} Ironforge · {area:69} Lakeshire
	["The Stranglethorn guide leaves Dwarves and Gnomes at their riding trainer in {zone:1426}: ride back west into {zone:1455}, where the flight to {area:69} leaves from the gryphon master."] = "Le guide de Strangleronce laisse les Nains et les Gnomes à leur maître de monte à {zone:1426} : retournez vers l'ouest jusqu'à {zone:1455}, d'où part le vol vers {area:69} auprès du maître des griffons.",

	-- Step 2: Into the Riverglades
	-- {zone:2548} Riverglades
	["Into the {zone:2548}"] = "Vers {zone:2548}",
	-- {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass · {zone:2548} Riverglades · {area:16737} Bristle Hills
	["Fly from {zone:1455} to {area:69} in Redridge, then follow the road north out of town and up through {area:2417}: it comes down into the western {zone:2548} by the {area:16737}."] = "Volez de {zone:1455} à {area:69} dans les Carmines, puis suivez la route vers le nord hors de la ville et montez par {area:2417} : elle redescend dans l'ouest de {zone:2548} près de {area:16737}.",
	-- {zone:2548} Riverglades
	["The western {zone:2548}"] = "L'ouest de {zone:2548}",

	-- Step 3: Scout Bolain
	-- {npc:260026} Scout Bolain · {zone:1434} Stranglethorn Vale · {npc:256881} Overlord Kilgar
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["{npc:260026} waits beside the road east of the pass.\nThis guide is written for levels 41-45: the route comes here at about 41, after {zone:1434}. The port's second wave and the Western Front's camps in the north are 43-45, with elite Twilight Enforcers (45) on patrol and {npc:256881} (46, elite) for groups only: below 41, do Stranglethorn first."] = "",

	-- Step 4: Southern Watch
	-- {area:16744} Southern Watch
	["Follow the road east to {area:16744}, the Alliance outpost above the river. The gnolls you passed on the way in are Captain Dalton's job: you go back for them after the lumber camp."] = "Suivez la route vers l'est jusqu'à {area:16744}, l'avant-poste de l'Alliance au-dessus de la rivière. Les gnolls croisés en arrivant sont l'affaire du capitaine Dalton : vous y retournerez après le camp de bûcherons.",
	-- {quest:95148} Southern Watch Gnoll Report · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95148}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95148} : pour {npc:257558} à {area:16724}, gardez-la",

	-- Step 5: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906} est un gnoll élite (niveau 40) qui erre dans les camps sud-ouest de {area:16737} : il est conseillé de grouper.",

	-- Step 6: Turner's Logging Camp
	-- {npc:256438} Halligan Turner
	["North up the road to the lumber camp. {npc:256438} runs it; his third job, the saplings, comes once his plant food is in."] = "Remontez la route vers le nord jusqu'au camp de bûcherons. {npc:256438} le dirige ; sa troisième tâche, les jeunes arbres, vient une fois son engrais rendu.",

	-- Step 7: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp on the slopes all the way from the hills west of the lumber camp to the pass you came in by. The stolen saw blades lie only in the western camps, near the pass.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "Vers l'ouest dans {area:16737} : les gnolls des Carmines campent sur les pentes, des collines à l'ouest du camp de bûcherons jusqu'au col par lequel vous êtes arrivé. Les lames de scie volées se trouvent seulement dans les camps de l'ouest, près du col.\nAttention : {npc:255906}, un gnoll élite (niveau 40), erre dans les camps sud-ouest : éloignez les gnolls de lui avant de les attaquer.",

	-- Step 9: Cedric Dalton
	-- {npc:262399} Gelinda Coppergleam
	["Take the gnoll reward now if you're short of 41. If it brings you to 41, head for {npc:262399}; otherwise go to the Holmsby farm and leave the dragonkin for the return from Turner's camp."] = "",

	-- Step 10: Cedric Dalton
	-- {quest:94679} Snargl's Snout
	["{quest:94679}, if already in your bag"] = "",

	-- Step 11: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam · {area:16744} Southern Watch
	["{npc:262399} camps by the Cinderscale hollow, west of {area:16744}."] = "",

	-- Step 13: The Cinderscale hollow
	["The Cinderscale hollow"] = "Le creux Écaille-de-cendre",
	-- {item:271611} Cubic Draconia
	["The whelps nest in the hollow; the level 41–42 warriors guard its back beside the {item:271611}. Leave Scaldaron, the rare elite drake, alone."] = "",

	-- Step 14: Cubic Draconia
	-- {item:271611} Cubic Draconia
	["Pick up the {item:271611} at the back of the hollow. The warriors guarding it reach level 42."] = "",

	-- Step 17: Holmsby farm
	["Holmsby farm"] = "La ferme des Holmsby",
	-- {area:16744} Southern Watch
	["Follow the river road to the Holmsby farm, south of {area:16744}."] = "",

	-- Step 18: Benjy Wheeler
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner
	["North-east across the fields to {area:16725}: {npc:258317} wants the Mudfin murlocs on the river thinned out, the same murlocs whose heads {npc:256438} needs, so one pass along the river does both."] = "Au nord-est à travers les champs jusqu'à {area:16725} : {npc:258317} veut qu'on réduise le nombre de murlocs Aileron-fangeux de la rivière, ceux-là mêmes dont {npc:256438} veut les têtes, donc un seul passage le long de la rivière fait les deux.",

	-- Step 19: Meadowsbrook and the river
	-- {area:16735} Meadowsbrook
	["{area:16735} and the river"] = "{area:16735} et la rivière",
	-- {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner · {npc:258588} Jumbo Crawfish · {npc:258935} Curly · {npc:259049} Robbie Holmsby · {area:16735} Meadowsbrook · {npc:263380} Ghostmaw
	-- plural, as words: Mudfin Warriors = {npc:258574} Mudfin Warrior
	["Back south-west along the river: kill the Mudfin Warriors and Oracles on the banks for {npc:258317} (they drop {npc:256438}'s heads) and the {npc:258588} in the shallows for the shells. {npc:258935}, one of {npc:256438}'s lumberjacks, is stuck on the bank just north-west of the murlocs; {npc:259049}'s hat lies on the riverbank among them; the fresh manure is in the fields of {area:16735}, between the river and the farm. {npc:263380}, an elite (level 42), prowls the river: if he comes your way, back off and let him pass."] = "Redescendez la rivière vers le sud-ouest : tuez les Guerriers et Oracles aileron-fangeux sur les berges pour {npc:258317} (ils lâchent les têtes de {npc:256438}) et les {npc:258588} dans les hauts-fonds pour les carapaces. {npc:258935}, un des bûcherons de {npc:256438}, est coincé sur la berge juste au nord-ouest des murlocs ; le chapeau de {npc:259049} se trouve sur la berge parmi eux ; le fumier frais est dans les champs de {area:16735}, entre la rivière et la ferme. {npc:263380}, un élite (niveau 42), rôde le long de la rivière : s'il vient vers vous, reculez et laissez-le passer.",

	-- Step 21: Watcher Fredericks
	-- {npc:259051} Watcher Fredericks · {area:16744} Southern Watch
	["{npc:259051} keeps the west end of {area:16744}."] = "{npc:259051} se tient à l'extrémité ouest de {area:16744}.",

	-- Step 22: Cedric Dalton
	-- {area:16744} Southern Watch
	["Tell Captain Dalton about the gnoll infestation while you're at {area:16744}, then head north to Turner's camp."] = "",

	-- Step 24: Turner's Logging Camp
	["North up the road to the lumber camp."] = "Remontez la route vers le nord jusqu'au camp de bûcherons.",

	-- Step 25: Saplings
	["Saplings"] = "Jeunes arbres",
	-- {npc:256438} Halligan Turner · {item:266161} Tree Sprouting Kit
	["Use {npc:256438}'s {item:266161} on bare ground around the camp: five saplings."] = "Utilisez le {item:266161} de {npc:256438} sur un sol nu autour du camp : cinq jeunes arbres.",

	-- Step 26: Hurley
	-- {npc:258963} Hurley · {npc:258935} Curly · {quest:94861} Helping Hands · {npc:263380} Ghostmaw
	["{npc:258963} stands at the camp's south end. He sets off for {npc:258935}, south-east of the camp, as soon as you take {quest:94861}: go with him and keep the attackers off, and wait if {npc:263380} is in sight. If it fails, {npc:258963} offers the quest again."] = "{npc:258963} se tient au sud du camp. Il part chercher {npc:258935}, au sud-est du camp, dès que vous acceptez {quest:94861} : accompagnez-le et repoussez les assaillants, et attendez si {npc:263380} est en vue. En cas d'échec, {npc:258963} redonne la quête.",
	-- {npc:258963} Hurley · {npc:258935} Curly
	["go with {npc:258963} to save {npc:258935}"] = "accompagnez {npc:258963} pour sauver {npc:258935}",

	-- Step 28: Wheeler's Grange
	-- {area:16724} Farholde Keep · {npc:258317} Benjy Wheeler · {area:16725} Wheeler's Grange
	["East along the road towards {area:16724}: hand {npc:258317} his murlocs as you pass {area:16725}."] = "Vers l'est sur la route en direction de {area:16724} : rendez ses murlocs à {npc:258317} en passant par {area:16725}.",

	-- Step 29: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257087} Gretchen Mayberry · {npc:260070} Bertrand Ironbrow · {npc:260080} Ember Bladewhisper · {npc:263613} Brother Lowley · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["On east along the road to {area:16724}. {npc:257087}, the gryphon master, stands at its western gate; {npc:260070} and {npc:260080} are on the way in, {npc:263613} tends the wounded by the barracks, {npc:257558} and {npc:257591} wait in the keep at the east end, and the inn is in the south of the walls."] = "Continuez vers l'est sur la route jusqu'à {area:16724}. {npc:257087}, la maîtresse des griffons, se tient à la porte ouest ; {npc:260070} et {npc:260080} sont sur le chemin, {npc:263613} soigne les blessés près de la caserne, {npc:257558} et {npc:257591} attendent dans le donjon à l'extrémité est, et l'auberge est au sud de l'enceinte.",
	-- {npc:257087} Gretchen Mayberry
	["{npc:257087}, at the western gate"] = "{npc:257087}, à la porte ouest",
	-- {npc:257558} Demar Brant
	["{npc:257558}, in the keep"] = "{npc:257558}, dans le donjon",
	-- {quest:94877} Saving Sunnyglade
	["{quest:94877}: for later in this guide"] = "{quest:94877} : pour plus tard dans ce guide",
	-- {npc:257591} Ashe Amberhall · {quest:94881} Curious Trinkets
	["{npc:257591}: {quest:94881}, for later in this guide"] = "{npc:257591} : {quest:94881}, pour plus tard dans ce guide",
	-- {quest:94879} Scraps of Knowledge
	["{quest:94879}, for later in this guide"] = "{quest:94879}, pour plus tard dans ce guide",
	-- {npc:259863} Cassandra Wheeler · {quest:95330} Love Thy Neighbor · {area:16736} Turner's Logging Camp
	["{npc:259863}, by the inn: {quest:95330}, for {area:16736} later in this guide"] = "{npc:259863}, près de l'auberge : {quest:95330}, pour {area:16736} plus tard dans ce guide",
	-- {npc:257595} Barracks Master Harlan
	["{npc:257595}, at the inn"] = "{npc:257595}, à l'auberge",

	-- Step 30: The cathedral
	["The cathedral"] = "La cathédrale",
	-- {npc:262031} Sister Rowland · {area:16724} Farholde Keep · {npc:272437} Marla Bell · {npc:271742} Abbot Schuncke
	["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} sells the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} garde la vieille cathédrale, au coin sud-ouest de {area:16724}. Les chauves-souris nichent à son étage supérieur ; {npc:272437} vend les bougies sacrées à côté ; les tombes se trouvent dans le cimetière de la chapelle.\n{npc:271742}, un élite de niveau 53, se tient dans la cathédrale : il vous laisse tranquille, ne l'attaquez donc jamais et éloignez les chauves-souris de lui.",
	-- {item:17028} Holy Candle · {npc:272437} Marla Bell
	["{item:17028}, from {npc:272437}"] = "{item:17028}, auprès de {npc:272437}",
	-- {item:269997} Bundle of Candles
	["{item:269997}, on the graves"] = "{item:269997}, sur les tombes",

	-- Step 31: Wheeler's Grange
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler
	["West to {area:16725}: {npc:258317} stands by the farmhouse."] = "À l'ouest vers {area:16725} : {npc:258317} se tient près de la ferme.",

	-- Step 32: The stables
	["The stables"] = "Les écuries",
	["Search around the stables south of the farmhouse for the horses' tracks; the bundles of hay lie around the farm."] = "Fouillez les alentours des écuries au sud de la ferme pour trouver les traces des chevaux ; les bottes de foin sont éparpillées dans la ferme.",

	-- Step 34: The coyote den
	["The coyote den"] = "La tanière des coyotes",
	-- {npc:258522} Sootfur
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The coyotes den in the hills south of the farm: {npc:258522}, the big dark one, sits at the back of it; the Plains Coyotes around it drop the pelts."] = "Les coyotes ont leur tanière dans les collines au sud de la ferme : {npc:258522}, le grand sombre, se tient au fond ; les Coyotes des plaines autour lâchent les peaux.",

	-- Step 35: The lost horse
	["The lost horse"] = "Le cheval perdu",
	["One of Benjy's horses ran north up the river, past the farm. Give it the feed, then lead it home."] = "L'un des chevaux de Benjy s'est enfui vers le nord en remontant la rivière, au-delà de la ferme. Donnez-lui le fourrage, puis ramenez-le chez lui.",
	-- {area:16725} Wheeler's Grange
	["walk it back to {area:16725}"] = "ramenez-le à pied jusqu'à {area:16725}",

	-- Step 37: Foreman's Crate
	-- {area:16729} Terral's Watch
	["North up the track towards {area:16729}: the foreman's crate lies by the road."] = "Au nord par le chemin vers {area:16729} : la caisse du contremaître se trouve au bord de la route.",

	-- Step 38: Terral's Watch
	-- {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{npc:259352} holds {area:16729}, the tower on the plains north-east of the crate."] = "{npc:259352} tient {area:16729}, la tour dans les plaines au nord-est de la caisse.",

	-- Step 39: The plains
	["The plains"] = "Les plaines",
	-- {quest:95983} A Feast for Buzzards · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Poachers = {npc:259052} Rog'mar Poacher
	["The Rog'mar Poachers hunt the plains north of the tower; the Wildplains lions roam among them. A picked carcass lies in the grass east of the tower: its skull starts {quest:95983}.\nCareful: {npc:263380}, an elite (level 42), hunts along the river west of the plains: keep an eye on the riverbank."] = "Les Braconniers de Rog'mar chassent dans les plaines au nord de la tour ; les lions des plaines sauvages rôdent parmi eux. Une carcasse décharnée gît dans l'herbe à l'est de la tour : son crâne lance {quest:95983}.\nAttention : {npc:263380}, un élite (niveau 42), chasse le long de la rivière à l'ouest des plaines : surveillez la berge.",

	-- Step 40: Terral's Watch
	-- {quest:94928} A Few Furs for Friz · {area:16727} Powderfuse Port
	["{quest:94928}: for {area:16727}, keep it"] = "{quest:94928} : pour {area:16727}, gardez-la",
	-- {quest:95984} Song of the Strider · {npc:263367} Sleebo Fizzlespout
	["{quest:95984}: for later, where the tallstriders graze by {npc:263367}'s workshop; keep it"] = "{quest:95984} : pour plus tard, là où les trotteurs paissent près de l'atelier de {npc:263367} ; gardez-la",
	-- {quest:95064} Preventative Measures · {area:16743} Rog'mar
	["{quest:95064}: for later, at the Horde's training grounds north of {area:16743}"] = "{quest:95064} : pour plus tard, au camp d'entraînement de la Horde au nord de {area:16743}",
	-- {quest:96125} In Need of Relief · {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["{quest:96125}: for {npc:259057} in {area:16726}, keep it"] = "{quest:96125} : pour {npc:259057} à {area:16726}, gardez-la",
	-- {quest:95426} Rog'mar Supplies
	["{quest:95426}: for later, the same training grounds"] = "{quest:95426} : pour plus tard, au même camp d'entraînement",

	-- Step 41: Farholde Keep
	-- {area:16724} Farholde Keep
	["South back to {area:16724}."] = "Retournez au sud jusqu'à {area:16724}.",
	-- {quest:96009} High Stakes · {area:16736} Turner's Logging Camp
	["{quest:96009}: for {area:16736} later in this guide"] = "{quest:96009} : pour {area:16736}, plus loin dans ce guide",

	-- Step 42: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch · {npc:259859} Wheatley
	["{npc:263380} is an elite (level 42) who hunts along the river between {area:16725} and {area:16729}, on your way north later in this guide: grouping up is advised. The poster hangs by the keep; {npc:259859}, who takes the fang, stands south of the inn."] = "{npc:263380} est un élite (niveau 42) qui chasse le long de la rivière entre {area:16725} et {area:16729}, sur votre chemin vers le nord plus loin dans ce guide : il est conseillé de grouper. L'affiche est accrochée près du donjon ; {npc:259859}, qui prend le croc, se tient au sud de l'auberge.",
	-- {object:645166} WANTED! (no name in this language: may be words)
	["the {object:645166} poster"] = "l'affiche {object:645166}",

	-- Step 43: WANTED: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo · {area:16743} Rog'mar
	["{npc:263071} is an elite (level 42) at the Horde's training grounds north of {area:16743}, where this guide goes later: grouping up is advised."] = "{npc:263071} est un élite (niveau 42) au camp d'entraînement de la Horde au nord de {area:16743}, où ce guide passe plus tard : il est conseillé de grouper.",
	-- {object:707245} Wanted (no name in this language: may be words)
	["the {object:707245} poster"] = "l'affiche {object:707245}",

	-- Step 44: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch
	["{npc:263380}, the elite, hunts along the river between {area:16725} and {area:16729}, on your way north."] = "{npc:263380}, l'élite, chasse le long de la rivière entre {area:16725} et {area:16729}, sur votre chemin vers le nord.",

	-- Step 45: Sunnyglade
	-- {area:16729} Terral's Watch · {area:16743} Rog'mar · {area:16723} Sunnyglade · {npc:259158} Fuzzle
	["Cross the river north of {area:16729} and stay west of {area:16743}, the Horde fort. Start at Elbrim's farm on {area:16723}'s north-eastern edge, then head west to Claire and {npc:259158}. The cult's ritual circles are just south of them."] = "",

	-- Step 46: Into Sunnyglade's cave
	-- {area:16723} Sunnyglade
	["Into {area:16723}'s cave"] = "",
	-- {area:16723} Sunnyglade · {npc:256831} Apprentice Claire
	["The cave mouth is on {area:16723}'s eastern side. Follow the passage west to {npc:256831}; her marker is inside, not on the hillside above."] = "",
	-- {area:16723} Sunnyglade
	["{area:16723} cave mouth"] = "",

	-- Step 48: Fuzzle
	-- {npc:259158} Fuzzle
	["Leave the cave and look for {npc:259158} in the cage south of Claire."] = "",
	-- {npc:259158} Fuzzle
	["{npc:259158} in his cage, not the end of his escort"] = "",

	-- Step 49: The Twilight cult
	["The Twilight cult"] = "Le culte du Crépuscule",
	-- {area:16723} Sunnyglade · {item:266148} Farmers' Mementos · {item:4338} Mageweave Cloth · {npc:263613} Brother Lowley · {area:16724} Farholde Keep · {quest:94885} Field Marshal's Log · {npc:256899} Chogg'Zac · {npc:263380} Ghostmaw
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["The cultists fill the streets and fields of {area:16723}. Start at the ritual circles in the middle (fill Claire's catalyst there), work west through the burnt houses to the edge of town, then back north-east to the loose soil west of Elbrim's farm: bury the {item:266148} the Twilight Raiders drop there. The charms, pages and finger bones drop from the cultists.\nKeep the {item:4338} they drop: {npc:263613} in {area:16724} asks for twenty when you are back there. Now and then a cultist drops the {quest:94885}: right-click it to start the quest.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass; players died here more than anywhere else in the zone.\n{npc:263380}, the river's elite (level 42), can wander up from the south-western fields: let him pass."] = "Les cultistes remplissent les rues et les champs de {area:16723}. Commencez aux cercles rituels au centre (remplissez-y le catalyseur de Claire), progressez vers l'ouest à travers les maisons brûlées jusqu'à la lisière du village, puis revenez au nord-est jusqu'à la terre meuble à l'ouest de la ferme d'Elbrim : enterrez-y les {item:266148} que lâchent les Écumeurs du Crépuscule. Les charmes, pages et phalanges tombent sur les cultistes.\nGardez l'{item:4338} qu'ils lâchent : {npc:263613} à {area:16724} vous en demande vingt à votre retour. De temps en temps, un cultiste lâche {quest:94885} : faites un clic droit dessus pour commencer la quête.\nAttention : {npc:256899}, un ogre élite (niveau 41), arpente les rues ouest de {area:16723}, vers 44-47,47-52. Attirez les cultistes vers vous et laissez-le passer ; c'est ici que les joueurs sont le plus morts dans la zone.\n{npc:263380}, l'élite de la rivière (niveau 42), peut remonter depuis les champs du sud-ouest : laissez-le passer.",
	-- {item:269990} Crystal Catalyst
	["fill the {item:269990} at the ritual circles"] = "remplissez le {item:269990} aux cercles rituels",
	-- {object:621813} Loose Soil (no name in this language: may be words) · {item:266148} Farmers' Mementos
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["{object:621813}, west of Elbrim's farm: each grave takes one of the {item:266148} the Twilight Raiders drop, so loot five first"] = "{object:621813}, à l'ouest de la ferme d'Elbrim : chaque tombe demande un des {item:266148} que les Twilight Raiders laissent tomber, récupérez-en cinq d'abord",
	-- {quest:94885} Field Marshal's Log
	["{quest:94885}: only if a cultist dropped the log"] = "{quest:94885} : seulement si un cultiste a lâché le journal",

	-- Step 50: Back into Sunnyglade's cave
	-- {area:16723} Sunnyglade
	["Back into {area:16723}'s cave"] = "",
	["Return by the eastern cave mouth to give Claire the filled catalyst."] = "",

	-- Step 52: Back to Claire with news of the cultists
	["Back to Claire with news of the cultists"] = "",
	["The eastern cave mouth leads back to Claire. Tell her about the cultists inside."] = "",

	-- Step 54: Cut Off the Heads
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{npc:256899}, the two-headed ogre, is an elite (level 41) at the western edge of {area:16723}: grouping up is advised. Claire then has the filled catalyst for {npc:257591} in {area:16724}."] = "{npc:256899}, l'ogre à deux têtes, est un élite (niveau 41) à la lisière ouest de {area:16723} : il est conseillé de grouper. Claire vous confie ensuite le catalyseur rempli pour {npc:257591} à {area:16724}.",

	-- Step 55: Back to Claire with the heads
	["Back to Claire with the heads"] = "",
	-- {area:16723} Sunnyglade
	["Take the heads through the cave mouth on the east side of {area:16723}."] = "",

	-- Step 57: Back to Claire for the filled catalyst
	["Back to Claire for the filled catalyst"] = "",
	["If you left after giving Claire the heads, use the cave mouth to collect her delivery for Farholde."] = "",

	-- Step 58: Claire's message for Farholde
	["Claire's message for Farholde"] = "",
	-- {quest:94884} An Unsettling Discovery · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{quest:94884}: for {npc:257591} in {area:16724}"] = "{quest:94884} : pour {npc:257591} à {area:16724}",

	-- Step 59: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158} veut quitter {area:16723} : escortez-le vers l'ouest jusqu'à son trésor à la lisière du village et protégez-le des cultistes.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "menez {npc:259158} hors de {area:16723} jusqu'à son trésor, à l'ouest de la ville",

	-- Step 60: Farmer Elbrim
	["Back east through the town to Elbrim's farm: the doll and the locket are in the burnt farmhouse beside it."] = "Retournez vers l'est à travers la ville jusqu'à la ferme d'Elbrim : la poupée et le médaillon sont dans la ferme incendiée à côté.",

	-- Step 61: The Rog'mar training grounds
	-- {area:16743} Rog'mar
	["The {area:16743} training grounds"] = "Le terrain d'entraînement de {area:16743}",
	-- {area:16743} Rog'mar · {npc:263071} Blademaster Kaijo · {npc:263615} Krek the Noxious
	-- plural, as words: Rog'mar Grunts = {npc:255996} Rog'mar Grunt
	["North-east of Elbrim's farm, the Horde drills its trainees in the fields north of {area:16743}. Stay north of the fort: its guards are far above your level. The supply crates lie around the drill grounds. Three elites work this ground: {npc:263071} (42) walks among the trainees, {npc:263615} (42) lurks at the north end, and Komuk (45), a Horde elite, patrols the hills to the east; give each of them room.\nCareful: Rog'mar Grunts (55) guard the fort's north wall, around 59,39 to 61,41. Leave the crates and trainees by the wall and take the ones further north, around 57-61,34-37."] = "Au nord-est de la ferme d'Elbrim, la Horde entraîne ses recrues dans les champs au nord de {area:16743}. Restez au nord du fort : ses gardes sont d'un niveau bien supérieur au vôtre. Les caisses de ravitaillement sont autour du terrain d'exercice. Trois élites s'y trouvent : {npc:263071} (42) circule parmi les recrues, {npc:263615} (42) rôde à l'extrémité nord, et Komuk (45), un élite de la Horde, patrouille dans les collines à l'est ; gardez vos distances avec chacun d'eux.\nAttention : des Grunts de Rog'mar (55) gardent le mur nord du fort, vers 59,39 à 61,41. Laissez les caisses et les recrues près du mur et prenez celles plus au nord, vers 57-61,34-37.",

	-- Step 62: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo
	["{npc:263071}, the elite, walks the training grounds."] = "{npc:263071}, l'élite, parcourt le terrain d'entraînement.",

	-- Step 63: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "L'atelier de {npc:263367}",
	-- {area:16743} Rog'mar · {npc:263367} Sleebo Fizzlespout · {area:16726} Bolder'ok
	["South-east, round {area:16743}'s east side, to {npc:263367}'s workshop on the hill. Komuk and the {area:16726} ogres walk the road east of the fort: let them pass before you cross it."] = "Au sud-est, en contournant {area:16743} par l'est, jusqu'à l'atelier de {npc:263367} sur la colline. Komuk et les ogres de {area:16726} parcourent la route à l'est du fort : laissez-les passer avant de la traverser.",

	-- Step 64: The tallstriders and the marsh
	["The tallstriders and the marsh"] = "Les haut-trotteurs et le marais",
	-- plural, as words: Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Roving Tallstriders graze the meadows south-west of the workshop; further south-west the marsh bubbles with gas: fill the vials at the vents."] = "Les Haut-trotteurs en maraude paissent dans les prairies au sud-ouest de l'atelier ; plus au sud-ouest, le marais bouillonne de gaz : remplissez les fioles aux évents.",

	-- Step 65: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower stands just south-west of the marsh."] = "La tour de {npc:259352} se dresse juste au sud-ouest du marais.",
	-- {quest:95066} The Rog'mar Situation · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95066}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95066} : pour {npc:257558} au {area:16724}, gardez-la",

	-- Step 66: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257591} Ashe Amberhall · {npc:257558} Demar Brant · {area:16723} Sunnyglade · {npc:263089} Tessa Dawnbright · {npc:263613} Brother Lowley
	["South across the plains to {area:16724}: {npc:257591} and {npc:257558} stand together in the keep at the east end, {npc:257591} first, her news is what Brant's next orders wait on. With {area:16723} saved, {npc:263089} by the orchard and {npc:263613} by the barracks have work for you too."] = "Au sud à travers les plaines jusqu'au {area:16724} : {npc:257591} et {npc:257558} se tiennent ensemble dans le donjon à l'extrémité est, {npc:257591} d'abord, car les prochains ordres de Brant dépendent de ses nouvelles. {area:16723} étant sauvée, {npc:263089} près du verger et {npc:263613} près de la caserne ont aussi du travail pour vous.",
	-- {quest:94907} A Small Favor
	["{quest:94907}: for later in this guide"] = "{quest:94907} : pour plus tard dans ce guide",
	-- {quest:95329} Out in the Field · {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{quest:95329}: for {npc:259352} at {area:16729}, keep it"] = "{quest:95329} : pour {npc:259352} à {area:16729}, gardez-la",
	-- {quest:94886} The Western Front
	["{quest:94886}: for later in this guide"] = "{quest:94886} : pour plus tard dans ce guide",
	-- {npc:263613} Brother Lowley · {item:4338} Mageweave Cloth · {area:16723} Sunnyglade
	["{npc:263613}: twenty {item:4338}, from {area:16723}'s cultists and the pirates; hand it in when you are back"] = "{npc:263613} : vingt {item:4338}, sur les cultistes et les pirates de {area:16723} ; rendez-la à votre retour",

	-- Step 67: Tessa Dawnbright
	-- {npc:263089} Tessa Dawnbright
	["{npc:263089} stands west of the inn, by the orchard: the apples hang on the trees around it."] = "{npc:263089} se tient à l'ouest de l'auberge, près du verger : les pommes pendent aux arbres alentour.",

	-- Step 68: Coyote pelts
	["Coyote pelts"] = "Peaux de coyote",
	-- {area:16725} Wheeler's Grange
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The Plains Coyotes roam west and south-west of the keep, towards {area:16725}."] = "Les Coyotes des plaines rôdent à l'ouest et au sud-ouest du donjon, vers {area:16725}.",

	-- Step 69: Tessa Dawnbright
	-- {quest:95961} Stepped Out · {npc:263120} Gray Dawnbright · {area:16727} Powderfuse Port
	["{quest:95961}: for {npc:263120} in {area:16727}, keep it"] = "{quest:95961} : pour {npc:263120} à {area:16727}, gardez-la",

	-- Step 70: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16729} Terral's Watch
	["{npc:263315}, an elite lion (level 41), prowls the plains north of {area:16729}, on your way back north: grouping up is advised."] = "{npc:263315}, un lion élite (niveau 41), rôde dans les plaines au nord de {area:16729}, sur votre chemin de retour vers le nord : il est conseillé de former un groupe.",

	-- Step 72: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to {npc:263367}'s workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "Au nord-est jusqu'à l'atelier de {npc:263367}. Le test de résistance de {npc:263367} est un combat contre son G45-B4G à côté de l'atelier : rendez la quête une fois qu'il est vaincu.",
	["the stress test: beat G45-B4G beside the workshop"] = "le test de résistance : battez G45-B4G à côté de l'atelier",

	-- Step 73: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:263120} Gray Dawnbright · {npc:255894} Innkeeper Zizplink · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz · {npc:260487} Gritta Chumwater · {npc:260565} Kor'gar · {npc:260560} Krikshank
	["East down the road to {area:16727}, the goblins' harbour. {npc:255897} keeps a stall at the west end of the docks; {npc:263120}, {npc:255894} and {npc:259962} are at the inn, and {npc:259961} works the north pier. Zizplink's drink needs three things the port's traders sell: the chum from {npc:260487}, the degreaser and the old poison from {npc:260565} and {npc:260560}, by {npc:255897}'s stall."] = "Suivez la route vers l'est jusqu'à {area:16727}, le port des gobelins. {npc:255897} tient un étal à l'extrémité ouest des quais ; {npc:263120}, {npc:255894} et {npc:259962} sont à l'auberge, et {npc:259961} travaille sur la jetée nord. La boisson de Zizplink demande trois choses vendues par les marchands du port : l'appât de {npc:260487}, le dégraissant et le vieux poison de {npc:260565} et {npc:260560}, près de l'étal de {npc:255897}.",
	-- {quest:95059} Frazzlespark's Crate · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95059}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95059} : pour {npc:257558} au {area:16724}, gardez-la",
	-- {item:271657} Fresh Chum · {npc:260487} Gritta Chumwater
	["{item:271657}, from {npc:260487}"] = "{item:271657}, auprès de {npc:260487}",
	-- {item:271653} Goblin Degreaser · {npc:260565} Kor'gar
	["{item:271653}, from {npc:260565}"] = "{item:271653}, auprès de {npc:260565}",
	-- {item:271654} Expired Poison · {npc:260560} Krikshank
	["{item:271654}, from {npc:260560}"] = "{item:271654}, auprès de {npc:260560}",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "L'affiche {object:628948} près de l'auberge : {npc:260235}",

	-- Step 74: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001} est un élite (niveau 42) sur la rive sud : il est conseillé de former un groupe.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "L'affiche {object:628948} près de l'auberge",

	-- Step 75: The murlocs, south-west
	["The murlocs, south-west"] = "Les murlocs, au sud-ouest",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "Au sud-ouest le long du rivage depuis le port : les murlocs d'eau salée campent sur les plages. En chemin, une peau peinte est tendue à côté du sentier : elle lance {quest:95260} pour {npc:260231} sur les quais.",

	-- Step 77: Back through the port
	["Back through the port"] = "Retour par le port",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "Revenez vers le nord le long du rivage : rendez les murlocs et la peau sur les quais en allant vers les rampants.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms are for later"] = "{quest:95261} : les entrailles des bêtes viennent au passage ; les champignons sont pour plus tard",

	-- Step 78: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "Les rampants et {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962} and the spittle for Zizplink, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "Au nord le long de la plage depuis les quais : les rampants donnent la viande pour {npc:259962} et la salive pour Zizplink, et leurs entrailles comptent pour {npc:260231}. {npc:260235}, un gros crabe, court sur les rochers à l'est des quais. {npc:259758}, un élite rare de niveau 49, parcourt cette côte des quais jusqu'au camp des pirates : si vous le voyez, restez bien à l'écart.",

	-- Step 80: Powderfuse Port: Fimbo Greasemitz's pincer
	-- {area:16727} Powderfuse Port · {npc:259962} Fimbo Greasemitz
	["{area:16727}: {npc:259962}'s pincer"] = "",

	-- Step 81: Fimbo Greasemitz's shore meal
	-- {npc:259962} Fimbo Greasemitz
	["{npc:259962}'s shore meal"] = "",

	-- Step 84: Before the Eastsea camp
	["Before the Eastsea camp"] = "",
	-- {npc:259758} Gul'gash · {area:796} Scarlet Monastery
	-- plural, as words: Shore Crawlers = {npc:256807} Shore Crawler
	["Pay any ready shore rewards at Powderfuse first. If you still need 42, stay on the beach with the level 39–40 Shore Crawlers. The musketeers on the cliffs can be 43. Let {npc:259758}, the rare elite, pass before pulling. A group can run the {area:796} instead."] = "",
	-- {area:16727} Powderfuse Port
	-- plural, as words: Shore Crawlers = {npc:256807} Shore Crawler
	["Shore Crawlers beside {area:16727}"] = "",

	-- Step 85: The Eastsea pirates
	["The Eastsea pirates"] = "Les pirates de la mer de l'Est",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "Au nord-est le long de la côte jusqu'au camp des pirates sur les falaises. Les boucaniers et les mousquetaires portent les marchandises de contrebande. {npc:259758} parcourt aussi le camp : surveillez-le.",

	-- Step 87: Wharfmaster Whizzbuzz
	-- {quest:95122} Unchecked Expansion
	["{quest:95122}: when you return to the northern cliffs"] = "",

	-- Step 91: Gray Dawnbright and Zizplink
	-- {npc:263120} Gray Dawnbright
	["{npc:263120} and Zizplink"] = "",

	-- Step 93: Friz Frazzlespark
	-- {npc:260390} Captain Bentcoin
	["Carry this to {npc:260390} when you visit the cliffs at 44"] = "",

	-- Step 95: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "{item:268632} en chemin",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42), Komuk (a Horde elite, 45) and {npc:263380} (elite, 42) range over the zone's wilds: take your beasts away from them."] = "La plupart des bêtes de {zone:2548} laissent tomber des {item:268632} pour {npc:260231} : les rampants du rivage sur cette côte et les sangliers sur la crête à l'ouest des pirates.\nAttention : {npc:257001} (élite, 42), Komuk (un élite de la Horde, 45) et {npc:263380} (élite, 42) rôdent dans les étendues sauvages de la zone : éloignez vos bêtes d'eux.",

	-- Step 96: Level 44.4 on the Eastsea pirates
	["Level 44.4 on the Eastsea pirates"] = "Niveau 44.4 sur les pirates de Mer-de-l'Est",
	-- {npc:259758} Gul'gash · {area:1517} Uldaman
	["Before the second wave: its raiders and bombardiers reach 45. At 43 the strongest are still two levels above you. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:257901} Eastsea Buccaneer
	["grind on {npc:257901}"] = "tuez des {npc:257901}",

	-- Step 97: The pirates' second wave
	["The pirates' second wave"] = "La deuxième vague des pirates",
	-- {npc:259758} Gul'gash
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. They stand close together: pull them one at a time. {npc:259758}, a rare elite of level 49, roams these cliffs and the beach below: if you see him, keep well away."] = "Au nord le long de la côte depuis le port : les pillards et bombardiers de Mer-de-l'Est se sont retranchés sur les pentes à l'ouest du camp des boucaniers, parmi leurs barils de poudre. Ils sont proches les uns des autres : attirez-les un par un. {npc:259758}, un élite rare de niveau 49, rôde sur ces falaises et la plage en contrebas : si vous le voyez, restez bien à l'écart.",

	-- Step 98: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "Vers l'est le long des falaises jusqu'au bout du camp des pirates : {npc:260390} attend au bord de l'eau, {npc:260391} à côté de lui.",

	-- Step 99: Wharfmaster Whizzbuzz: the raiders
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the raiders"] = "",

	-- Step 100: Wharfmaster Whizzbuzz: the kegs
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the kegs"] = "",

	-- Step 101: Wharfmaster Whizzbuzz: the ships
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the ships"] = "",

	-- Step 103: The pirates' ships
	["The pirates' ships"] = "Les navires des pirates",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} patrols the top deck of the middle ship. Once she's down, go below deck for the loot chest in the hold. Keep an eye out for {npc:259758} on the way."] = "",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, le navire sud",
	["Open Lamora's chest in the hold"] = "",
	["the middle ship"] = "le navire du milieu",
	["the northern ship"] = "le navire nord",

	-- Step 104: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "Champignons cadavériques",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "À l'ouest du navire nord, montez sur la crête : les Champignons cadavériques poussent parmi les rochers, près du camp des ogres du Crépuscule. Les Brochepâles adultes de la crête donnent aussi des entrailles.",

	-- Step 105: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:259057} Dunston Willis
	["North-west to {area:16726}, the ogres' town. Its ogres side with the Horde and attack you on sight, and Clugfist on his hill in the middle is an elite (level 50): keep to the town's north-eastern edge, where {npc:259057} hides."] = "Au nord-ouest jusqu'à {area:16726}, la ville des ogres. Ses ogres sont alliés à la Horde et vous attaquent à vue, et Poing-Serré, sur sa colline au centre, est un élite (niveau 50) : restez à la lisière nord-est de la ville, où se cache {npc:259057}.",

	-- Step 106: Gronok's Key
	-- {npc:263749} Gronok the Butcher · {npc:259057} Dunston Willis · {item:275043} Bloodmaster's Ring
	["{npc:263749} (level 44) carries the key: he paces the lanes south of {npc:259057}'s hut.\nThe {item:275043} lies just west of the lanes: its fighters (elites, 41-45) only fight in a bout, so leave them be."] = "{npc:263749} (niveau 44) porte la clé : il arpente les allées au sud de la hutte de {npc:259057}.\nL'{item:275043} se trouve juste à l'ouest des allées : ses combattants (élites, 41-45) ne se battent que lors d'un affrontement, laissez-les tranquilles.",

	-- Step 107: Dunston Willis
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["Free him, then get him out: {npc:259057} fights his way out of {area:16726}, and you keep the ogres off him. If he falls, take the quest from him again."] = "Libérez-le, puis sortez-le de là : {npc:259057} se fraie un chemin hors de {area:16726}, et vous tenez les ogres à l'écart. S'il tombe, reprenez la quête auprès de lui.",

	-- Step 108: Dunston Willis: the way out
	-- {npc:259057} Dunston Willis
	["{npc:259057}: the way out"] = "",
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["help {npc:259057} break out of {area:16726}"] = "aidez {npc:259057} à s'échapper de {area:16726}",

	-- Step 109: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "Terminez les {item:268632}",
	-- {npc:259758} Gul'gash
	["South-east out of the hills towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "Sortez des collines vers le sud-est en direction du port : les rampants des rivages sur la plage au nord des quais donnent les entrailles le plus vite. {npc:259758} descend aussi sur cette plage.",

	-- Step 110: Powderfuse Port: the charges
	-- {area:16727} Powderfuse Port
	["{area:16727}: the charges"] = "",

	-- Step 111: Wharfmaster Whizzbuzz: Lamora
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: Lamora"] = "",

	-- Step 113: Argo Brinewhistle
	-- {quest:95267} The Monster Surfaces
	["{quest:95267}: the monster in the shallows south-west of the port"] = "",

	-- Step 114: The Monster Surfaces
	-- {npc:260231} Argo Brinewhistle · {item:268647} Big Ball o' Bait · {npc:257001} Old Rot-Chum
	["At the junk in the shallows south-west of the port, use {npc:260231}'s {item:268647}. Kill the threshadon that comes to the bait and take its head. Give {npc:257001}, the elite that walks this shore, plenty of room."] = "",
	-- {item:268647} Big Ball o' Bait
	["{item:268647} at the junk"] = "",
	["Loot the summoned threshadon's head"] = "",

	-- Step 116: The meadows
	["The meadows"] = "Les prairies",
	-- {npc:263367} Sleebo Fizzlespout
	["West of the port, the wildflowers grow in the meadows below {npc:263367}'s workshop."] = "À l'ouest du port, les fleurs sauvages poussent dans les prairies sous l'atelier de {npc:263367}.",

	-- Step 117: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257558} Demar Brant
	["South-west across the plains to {area:16724}: {npc:257558} in the keep at the east end."] = "Traversez les plaines vers le sud-ouest jusqu'au {area:16724} : {npc:257558} est dans le donjon, à l'extrémité est.",

	-- Step 118: Demar Brant
	-- {quest:94887} Saving Marshal Ryan
	["{quest:94887}: for later in this guide"] = "{quest:94887} : pour plus tard dans ce guide",

	-- Step 121: Brother Lowley
	-- {npc:263613} Brother Lowley · {npc:262031} Sister Rowland
	["{npc:263613} tends the wounded beside the barracks: bandage three of his soldiers, then he has a note for {npc:262031} in the cathedral."] = "{npc:263613} soigne les blessés près de la caserne : bandez trois de ses soldats, puis il vous remet une note pour {npc:262031}, dans la cathédrale.",
	-- {item:272126} Makeshift Bandages
	-- plural, as words: Wounded Soldiers = {npc:263614} Wounded Soldier
	["{item:272126}, on the Wounded Soldiers beside him"] = "{item:272126}, sur les Soldats blessés à côté de lui",

	-- Step 122: Farholde Keep, the west side
	-- {area:16724} Farholde Keep
	["{area:16724}, the west side"] = "{area:16724}, côté ouest",
	-- {npc:263089} Tessa Dawnbright · {npc:259859} Wheatley
	["West through the keep: {npc:263089} by the orchard, then the cathedral and {npc:259859} south of the inn if you have their errands."] = "Traversez le fort vers l'ouest : {npc:263089} près du verger, puis la cathédrale et {npc:259859} au sud de l'auberge si vous avez leurs commissions.",

	-- Step 123: Sister Rowland
	-- {quest:96084} Something's in the Water
	["{quest:96084}: for later in this guide"] = "{quest:96084} : pour plus tard dans ce guide",

	-- Step 125: Something's in the Water
	-- {area:16729} Terral's Watch · {npc:262031} Sister Rowland
	["North past {area:16729}: fill {npc:262031}'s phial in the marsh water north-east of the tower."] = "Au nord après {area:16729} : remplissez la fiole de {npc:262031} dans l'eau du marais au nord-est de la tour.",

	-- Step 126: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower."] = "La tour de {npc:259352}.",

	-- Step 128: Turner's Logging Camp
	-- {area:16736} Turner's Logging Camp · {npc:263380} Ghostmaw
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["West across the river to {area:16736}: the Peasant Woodpiles around the camp give the wood bundles.\nCareful: {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "Traversez la rivière vers l'ouest jusqu'au {area:16736} : les Tas de bois de paysan autour du camp donnent les fagots.\nAttention : {npc:263380}, un élite (niveau 42), rôde le long de la rivière près du camp : s'il vient vers vous, reculez et laissez-le passer.",

	-- Step 129: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam
	["From Turner's camp follow the road south-west to {npc:262399}'s camp."] = "",

	-- Step 135: The Western Front
	-- {npc:256881} Overlord Kilgar
	-- plural, as words: Twilight Champions = {npc:256799} Twilight Champion · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["Careful: the Western Front is written for level 44 and up. Its Twilight Champions are 43-44 and its Thralls 44, Twilight Enforcers (elites, 45) patrol through the camps, and {npc:256881} (46, elite) is for a group only. Below 44, top up on the Eastsea pirates by the port first, or come back with a friend."] = "",

	-- Step 136: Sergeant Riftan
	-- {area:16685} Twilight's Shroud · {npc:258023} Sergeant Riftan
	["North up the long valley towards {area:16685}: {npc:258023} holds a small camp below the Twilight cult's fortress."] = "Remontez vers le nord la longue vallée en direction de {area:16685} : {npc:258023} tient un petit camp sous la forteresse du culte du Crépuscule.",

	-- Step 137: The Twilight camps
	["The Twilight camps"] = "Les camps du Crépuscule",
	-- {npc:258652} Twilight Thrall · {npc:257591} Ashe Amberhall · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The cult's camps fill the valley north and west of Riftan. Free the captive Farholde Scouts as you find them, and kill a {npc:258652} for {npc:257591}: her soulstone takes it. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them."] = "Les camps du culte remplissent la vallée au nord et à l'ouest de Riftan. Libérez les Éclaireurs de Farholde captifs au fil de votre chemin, et tuez un {npc:258652} pour {npc:257591} : sa pierre d'âme le capture. Des Massacreurs du Crépuscule (élites, niveau 45) patrouillent dans les camps : observez leur trajet avant chaque attaque. {npc:256881} et {npc:256891} (élites, 46) tiennent la forteresse au fond de la vallée : attirez les cultistes loin d'eux.",
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout
	["free five captive Farholde Scouts"] = "libérez cinq Éclaireurs de Farholde captifs",
	-- {npc:258652} Twilight Thrall
	["kill a {npc:258652}"] = "tuez un {npc:258652}",

	-- Step 138: Marshal Ryan
	-- {npc:257250} Marshal Ryan · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	["{npc:257250} lies wounded among the camps at the valley's western edge.\nCareful: {npc:256881} and {npc:256891} (elites, 46) hold the fortress north of him: come at Ryan from the south."] = "{npc:257250} gît blessé parmi les camps, à la lisière ouest de la vallée.\nAttention : {npc:256881} et {npc:256891} (élites, 46) tiennent la forteresse au nord de lui : approchez Ryan par le sud.",
	-- {npc:257250} Marshal Ryan
	["find {npc:257250} and talk to him"] = "trouvez {npc:257250} et parlez-lui",
	-- {quest:94892} Dying Wish · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:94892}: for {npc:257558} in {area:16724}"] = "{quest:94892} : pour {npc:257558} au {area:16724}",

	-- Step 139: The ogre mine
	["The ogre mine"] = "La mine des ogres",
	-- plural, as words: Twilight Subjugators = {npc:260996} Twilight Subjugator · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine, driven by the Twilight Subjugators.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in, and pull the miners and Subjugators back out to you."] = "Au nord des camps, le culte fait travailler des mineurs ogres dans une mine, sous la férule des Subjugueurs du Crépuscule.\nAttention : des Massacreurs du Crépuscule (élites, niveau 45) passent devant l'entrée de la mine en traversant les camps. Attendez qu'un d'eux soit passé avant d'entrer, et attirez les mineurs et les Subjugueurs vers l'extérieur.",

	-- Step 141: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881} est un élite (niveau 46) dans la forteresse au fond de la vallée, entouré des Massacreurs : un groupe est conseillé.",
	-- {quest:94891} News to Farholde · {npc:257591} Ashe Amberhall
	["{quest:94891}: for {npc:257591}"] = "{quest:94891} : pour {npc:257591}",

	-- Step 142: Back to Farholde Keep
	-- {area:16724} Farholde Keep
	["Back to {area:16724}"] = "Retour au {area:16724}",
	-- {area:16724} Farholde Keep
	["Your hearthstone is bound at {area:16724}'s inn: use it, or ride back south to the keep."] = "Votre pierre de foyer est liée à l'auberge du {area:16724} : utilisez-la, ou rentrez au donjon en chevauchant vers le sud.",

	-- Step 143: Farholde Keep
	-- {npc:260070} Bertrand Ironbrow · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["From the inn: {npc:260070} on the way in, then {npc:257558} and {npc:257591} in the keep."] = "Depuis l'auberge : {npc:260070} en entrant, puis {npc:257558} et {npc:257591} dans le donjon.",

	-- Step 145: Demar Brant
	-- {quest:94893} Delivering Closure · {npc:278088} Abigail Lawson · {zone:1453} Stormwind
	["{quest:94893}: for {npc:278088} in {zone:1453}"] = "{quest:94893} : pour {npc:278088} à {zone:1453}",

	-- Step 146: The Twilight Threat
	-- {npc:257558} Demar Brant · {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:257558}: Kilgar's head for {npc:1748} in {object:2117}"] = "{npc:257558} : la tête de Kilgar pour {npc:1748} au {object:2117}",

	-- Step 147: Sister Rowland
	-- {npc:262031} Sister Rowland
	["{npc:262031}, in the cathedral at the keep's south-west corner."] = "{npc:262031}, dans la cathédrale à l'angle sud-ouest du donjon.",

	-- Step 148: Stormwind
	-- {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind · {npc:278088} Abigail Lawson · {object:2098} Cathedral Square
	["{npc:257087} flies to {zone:1453}. {npc:278088} waits in the {object:2098}."] = "{npc:257087} assure les vols pour {zone:1453}. {npc:278088} attend sur la {object:2098}.",

	-- Step 150: Train before the Badlands
	-- {zone:1418} Badlands
	["Train before the {zone:1418}"] = "Entraînez-vous avant les {zone:1418}",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1425} Hinterlands · {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}, and the {zone:1418} & {zone:1425} guide passes none: {npc:257087} flies to {zone:1453}, where you train before you go on."] = "Il n'y a aucun maître de classe dans {zone:2548}, et le guide des {zone:1418} et des {zone:1425} n'en croise aucun : {npc:257087} assure les vols pour {zone:1453}, où vous vous entraînez avant de continuer.",

	-- Step 151: Your class trainer
	["Your class trainer"] = "Votre maître de classe",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}: train here in {zone:1453} before you fly on."] = "Il n'y a aucun maître de classe dans {zone:2548} : entraînez-vous ici, à {zone:1453}, avant de reprendre le vol.",

	-- Step 152: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 153: Shaman trainer
	["Shaman trainer"] = "Maître des chamans",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind · {zone:1418} Badlands · {zone:1425} Hinterlands · {area:1537} Ironforge · {area:144} Thelsamar
	["No shaman trainer stands in the {zone:2548} or in {zone:1453}, and the {zone:1418} & {zone:1425} guide passes none: fly to {area:1537} and train there; {area:144} is a short flight on."] = "Il n'y a aucun maître des chamans dans {zone:2548} ni à {zone:1453}, et le guide des {zone:1418} et des {zone:1425} n'en croise aucun : volez jusqu'à {area:1537} pour vous y entraîner ; {area:144} n'est qu'à un court vol de là.",

	-- Step 154: Leave Stormwind
	-- {zone:1453} Stormwind
	["Leave {zone:1453}"] = "Quittez {zone:1453}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1453} Stormwind · {object:2096} Trade District
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}. {zone:1453}'s gryphon master stands in the {object:2096}."] = "Le guide suivant commence dans les {zone:1418}, au sud du {zone:1432} : volez jusqu'à {area:144}. Le maître des griffons de {zone:1453} se trouve dans le {object:2096}.",

	-- Step 155: Loch Modan
	-- {area:144} Thelsamar · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["No flight path to {area:144} yet: go to {zone:1455} (by the {area:2257} from {zone:1453}), ride out of its gates east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "Pas encore de trajet aérien vers {area:144} : allez à {zone:1455} (par le {area:2257} depuis {zone:1453}), sortez par ses portes vers l'est à travers {zone:1426} et le tunnel jusqu'au {zone:1432}, puis suivez la route jusqu'à {area:144}.",

	-- Step 156: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Prendre un vol pour {area:144}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}."] = "Le guide suivant commence dans les {zone:1418}, au sud du {zone:1432} : volez jusqu'à {area:144}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east along the road to {area:16744}."] = "Retournez vers l'est par la route jusqu'à {area:16744}.",
	-- ["Back past {area:16744} and south to the Holmsbys' farm by the river."] = "Repassez par {area:16744} et descendez au sud jusqu'à la ferme des Holmsby, au bord de la rivière.",
	-- ["Back to the port, from the north pier west through the docks."] = "Retournez au port, depuis la jetée nord vers l'ouest à travers les quais.",
	-- ["Back to the port."] = "Retournez au port.",
	-- ["Before the second wave: its raiders and bombardiers (43-45) and the pirates' ships after them are a level over you below 44.4. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "Avant la deuxième vague : ses pillards et bombardiers (43-45), puis les navires des pirates, ont un niveau de plus que vous en dessous de 44.4. Complétez sur les boucaniers et mousquetaires du premier camp (41-43), à son extrémité sud-ouest, loin du port. {npc:259758}, un élite rare de niveau 49, rôde sur ces falaises : si vous le voyez, restez bien à l'écart. Ou, en groupe, faites plutôt le donjon d'{area:1517}.",
	-- ["Down to the port."] = "Descendez au port.",
	-- ["North from {area:16724}, past {area:16729} and across the river, to {area:16723}, the farm town the Twilight cult holds; keep clear of {area:16743}, the Horde's fort east of the town. {npc:259158} the kobold hides in the middle of the town, {npc:256831} at its eastern edge, and {npc:258697} waits at his farm on the north-eastern edge."] = "Au nord depuis {area:16724}, après {area:16729} et de l'autre côté de la rivière, jusqu'à {area:16723}, le village agricole tenu par le culte du Crépuscule ; restez à l'écart de {area:16743}, le fort de la Horde à l'est du village. {npc:259158} le kobold se cache au milieu du village, {npc:256831} à sa lisière est, et {npc:258697} attend dans sa ferme à la lisière nord-est.",
	-- ["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} (level 45) stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way."] = "Retournez encore une fois aux falaises des pirates. Posez les charges de Whizzbuzz sur les trois navires amarrés sous le camp, du sud au nord ; {quest:95124} (niveau 45) se tient près de celui du milieu, avec son coffre de butin à côté d'elle. Méfiez-vous de {npc:259758} en chemin.",
	-- ["South-west past {area:16744}: {npc:262399}, a prospector, has camped by the Cinderscale dragonkin's hollow."] = "Au sud-ouest après {area:16744} : {npc:262399}, une prospectrice, a établi son camp près du creux des draconiens Écaille-de-cendre.",
	-- ["The whelps nest all over the hollow; the warriors (level 41-42) guard its back, by the {item:271611}. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "Les dragonnets nichent dans tout le creux ; les guerriers (niveau 41-42) en gardent le fond, près de la {item:271611}. Scaldaron, un drake élite rare, peut aussi s'y trouver : laissez-le tranquille sauf si vous êtes en groupe.",
	-- ["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "Le {npc:260244} rôde dans les hauts-fonds au sud-ouest du port, sous les plages des murlocs. {npc:257001}, un élite, arpente le rivage tout près : gardez vos distances.",
	-- ["{item:17028}, from {npc:272437}"] = "{item:17028}, auprès de {npc:272437}",
	-- ["{npc:260026} waits beside the road east of the pass."] = "{npc:260026} attend au bord de la route à l'est du col.",
	-- ["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} hands out the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} garde la vieille cathédrale, au coin sud-ouest de {area:16724}. Les chauves-souris nichent à son étage supérieur ; {npc:272437} distribue les bougies sacrées à côté ; les tombes se trouvent dans le cimetière de la chapelle.\n{npc:271742}, un élite de niveau 53, se tient dans la cathédrale : il vous laisse tranquille, ne l'attaquez donc jamais et éloignez les chauves-souris de lui.",
	-- ["{object:621813}: bury the mementos"] = "{object:621813} : enterrez les souvenirs",
	-- ["{quest:95122}: for later in this guide"] = "{quest:95122} : pour plus tard dans ce guide",
	-- ["{quest:95123}: for later in this guide"] = "{quest:95123} : pour plus tard dans ce guide",
	-- ["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267} : une grosse bête dans les hauts-fonds au sud-ouest du port, près de {npc:257001}, l'élite",
	-- ["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293} : pour {npc:260390} au camp des pirates",
	-- ["{quest:95975}: for later, the wildflowers west of the port"] = "{quest:95975} : pour plus tard, les fleurs sauvages à l'ouest du port",
}
