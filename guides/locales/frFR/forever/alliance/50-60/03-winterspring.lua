-- French (frFR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Vers {zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "",

	-- Step 4: Everlook
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629} : gardez-la pour {area:2262} ; à l'intérieur",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431} : gardez les deux pour les Maleterres ; à l'intérieur",
	-- {npc:11754} Meggi Peppinrocker · {area:2255} Everlook
	["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} se promène autour de {area:2255} : cherchez dans le cercle sur la carte",
	-- {item:12383} Moontouched Feather
	["{item:12383}, 110 yd north"] = "",

	-- Step 6: Ice Thistle Hills: kill these as you meet them
	-- {area:2247} Ice Thistle Hills
	["{area:2247}: kill these as you meet them"] = "{area:2247} : tuez-les au passage",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Les Yétis Chardon de glace vivent dans les collines au sud de {area:2244}, les Chimères Noroît dans la vallée vers {area:2255}.",

	-- Step 7: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Les ruines entourent le lac gelé au sud de {area:2253}. Ramassez les quatre fragments de relique dans les ruines et les Plumes de Chouettard lunaire au sol là où rôdent les Indomptables.",

	-- Step 8: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Suivez la route vers l'ouest jusqu'au camp de {npc:9298} Snowden, près des sources chaudes.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Gardez-le : Gregan Brewspewer, en {zone:1444}, prépare l'élixir plus tard",

	-- Step 9: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246} : tuez-les au passage",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {item:14047} Runecloth · {zone:1452} Winterspring · {area:1584} Blackrock Depths
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}. Or, with a group, run the {area:1584} dungeon instead."] = "",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "",

	-- Step 10: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "Le Chaudron des Mort-bois en {zone:1448} : gardez-la",

	-- Step 11: Level 55.05
	["Level 55.05"] = "Niveau 55.05",
	-- {area:2255} Everlook · {area:2246} Frostfire Hot Springs · {area:1769} Timbermaw Hold · {quest:8471} Winterfall Ritual Totem · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",

	-- Step 12: Winterfall Ritual Totem
	["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Pour Kernda à {area:1769} : gardez-le",

	-- Step 14: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Le village des furbolgs Tombe-hiver s'étend à l'est de {area:2255} : Chamans (56-57), Protecteurs (55-56) et Ursa (57-58) Tombe-hiver, tous plus forts que vous. Tuez d'abord les Chamans, ils soignent, et attirez-les depuis la lisière. {npc:10738}, dans la grotte du fond, est élite : n'y allez pas.",

	-- Step 15: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cornes de yéti en parfait état ({item:12367})",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "",

	-- Step 16: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Sur {npc:10978}, près de l'auberge",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978} : {npc:7583} et {npc:10977} viennent plus tard",

	-- Step 18: Fly to Theramore
	["Fly to Theramore"] = "Volez jusqu'à Theramore",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Maître de vol de {area:2255}",

	-- Step 19: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maître de vol de {area:150}",

	-- Step 22: Chillwind Camp
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["From {area:271}, ride north up the road through Alterac to {area:3197}."] = "",
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616} : les termites viendront plus tard, à {area:2627}",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "",
	-- {npc:11053} High Priestess MacDonnell · {area:200} Dalson's Tears
	["{npc:11053}: the cauldron is at {area:200}, keep it"] = "",

	-- Step 23: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "",
	["Inside"] = "À l'intérieur",

	-- Step 24: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Vers {zone:1423}",

	-- Step 26: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Suivez la route du sud vers l'est jusqu'en {zone:1423} ; les ruines de {area:2262} sont au sud de la route. Le fantôme de {npc:10926} Redpath joue près de la maison en ruine, au bout sud.",

	-- Step 27: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "Poupée de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Les trois morceaux de la poupée sont dans les maisons en ruine de {area:2262} ; en ramasser un peut faire surgir des fantômes. Assemblez-les pour obtenir la poupée.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "{item:12886} ; à l'intérieur",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "{item:12888} ; à l'intérieur",

	-- Step 28: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, en {zone:1422} : gardez-la",

	-- Step 29: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Suivez la route vers l'est à travers la zone jusqu'à la Chapelle de l'Espoir de Lumière.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038} : Zaeldarr le Banni est un élite de niveau 54",

	-- Step 30: Corin's Crossing
	-- {area:2264} Corin's Crossing · {npc:10411} Eye of Naxxramas
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libérez des Esprits de Darrowshire ({npc:11064}) : parlez-leur",

	-- Step 31: The Undercroft
	-- {area:2261} The Undercroft
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr le Banni est élite : il est conseillé de grouper. Il attend au fond de {area:2261}, la crypte au sud-ouest de la zone.",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "{item:15785} ; sous terre",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "Le guide suivant commence ici et vole vers {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Retournez dans les collines : seuls les Matriarches et Patriarches Chardon de glace portent les cornes. Tuez des yétis jusqu'au niveau 54 : avant, les quêtes d'Indomptables de Harlo Barnaby sont rouges.",
	-- ["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Attention : {npc:10411} devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence. Il n'en existe que 3 et ils réapparaissent toutes les 15 min.",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Suivez la route du sud vers l'est jusqu'aux {area:139} ; les ruines de {area:2262} se trouvent au sud de celle-ci. Le fantôme de {npc:10926} joue près de la maison en ruine, à l'extrémité sud.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Suivez les indications de {npc:9298} Snowden jusqu'à l'entrée de {area:2256}, après les Géants Cognegivre : passez-les un par un.",
	-- ["Hearth to {area:2255}"] = "Pierre de foyer vers {area:2255}",
	-- ["Hearth to {area:2268}"] = "Pierre de foyer vers {area:2268}",
	-- ["On the way"] = "En chemin",
	-- ["Optional: {area:1417}"] = "Facultatif : {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Ramassez les fournitures autour du chariot et reprenez l'amulette de {npc:10301} aux chouettards voisins.",
	-- ["Pristine Yeti Horns"] = "Cornes de yéti en parfait état",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la cabane en ruine, et son livre de reçus est dans l'auberge en ruine voisine.",
	-- ["Ride north-west back to the village."] = "Retournez au village au nord-ouest.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Descendez la vallée vers le sud-est jusqu'à la caisse endommagée de {npc:10301} dans la neige à {area:2245}, son chariot détruit juste à l'est.",
	-- ["Ride west along the road to the night elf village."] = "Chevauchez vers l'ouest sur la route jusqu'au village elfe de la nuit.",
	-- ["Ride west along the road to {npc:10301}."] = "Chevauchez vers l'ouest sur la route jusqu'à {npc:10301} Stoneshaper.",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Pas encore niveau 54 après les yétis ? En groupe, faire {area:1417} (50-54) plutôt que tuer des monstres vous y amène plus vite. Revenez ensuite à {area:2255}.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "Le Fléau autour de {area:2264}, à l'ouest de la chapelle, lâche les deux sortes de Pierres du Fléau ; des Esprits de Darrowshire ({npc:11064}) en surgissent : parlez à chacun pour le libérer.",
	-- ["The Winterfall camp"] = "Le camp Tombe-hiver",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Le camp Tombe-hiver de l'ouest est dans les collines entre {npc:11556} et {npc:9298} Snowden. Chaque furbolg ici peut laisser {item:12771} (environ une fois sur dix) et, rarement, {quest:8471} : faites un clic droit sur ce qui tombe. Gardez {quest:6031} laissé par les furbolgs pour Meilosh.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Les furbolgs Tombe-hiver de l'ouest laissent les perles.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56."] = "Montez ici jusqu'au niveau 55.05 avant de rendre les quêtes ({area:2255}) : elles vous font passer au niveau 56.",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Traversez {area:1769} jusqu'en {zone:1448} et poursuivez en vol vers les Royaumes de l'Est ({area:442}, puis le bateau pour {area:150}). Volez jusqu'à {area:271} et remontez la route vers le nord à travers Alterac jusqu'à {area:3197}.",
	-- ["grind on {npc:11552}"] = "tuez en boucle : {npc:11552}",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "tuez des {npc:7460} à {area:2247}, {zone:1452}",
	-- ["{area:2269}: kill these as you meet them"] = "{area:2269} : tuez-les au passage",
	-- ["{item:12367} along the way to {area:2255}"] = "{item:12367} sur le chemin de {area:2255}",
	-- ["{item:12367} on the way"] = "{item:12367} en chemin",
	-- ["{item:12383} on the way"] = "{item:12383} en chemin",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, butin rare",
	-- ["{npc:10301}'s camp"] = "Camp de {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Fournitures de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431} : gardez les deux pour les Maleterres",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, près des tombes au sud de la chapelle",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038} : {npc:12250} est un élite de niveau 54",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} garde l'entrée de {area:1769}, au nord-ouest de {npc:9298} Snowden.",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629} : gardez-la pour {area:2262}",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} est élite : il est conseillé de grouper. Il attend au fond du {area:2261}, la crypte au sud-ouest de la zone.",
	-- ["{npc:7440} along the way to {npc:9298}"] = "{npc:7440} sur le chemin de {npc:9298}",
	-- ["{npc:7441} along the way to {npc:9298}"] = "{npc:7441} sur le chemin de {npc:9298}",
	-- ["{npc:7442} along the way to {npc:9298}"] = "{npc:7442} sur le chemin de {npc:9298}",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, dans les {area:28} : gardez-la",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, pour Meilosh plus tard",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, butin rare",
}
