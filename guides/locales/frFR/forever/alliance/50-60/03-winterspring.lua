-- French (frFR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}"] = "{npc:11629} : gardez-la pour {area:2262}",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431} : gardez les deux pour les Maleterres",

	-- Step 2: Starfall Village
	["Ride west along the road to the night elf village."] = "Chevauchez vers l'ouest sur la route jusqu'au village elfe de la nuit.",

	-- Step 3: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Les ruines entourent le lac gelé au sud de {area:2253}. Ramassez les quatre fragments de relique dans les ruines et les Plumes de Chouettard lunaire au sol là où rôdent les Indomptables.",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Suivez la route vers l'ouest jusqu'au camp de {npc:9298} Snowden, près des sources chaudes.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Gardez-le : Gregan Brewspewer, en {zone:1444}, prépare l'élixir plus tard",

	-- Step 5: Salfa
	-- {npc:11556} Salfa · {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} garde l'entrée de {area:1769}, au nord-ouest de {npc:9298} Snowden.",

	-- Step 6: The Winterfall camp
	["The Winterfall camp"] = "Le camp Tombe-hiver",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Le camp Tombe-hiver de l'ouest est dans les collines entre {npc:11556} et {npc:9298} Snowden. Chaque furbolg ici peut laisser {item:12771} (environ une fois sur dix) et, rarement, {quest:8471} : faites un clic droit sur ce qui tombe. Gardez {quest:6031} laissé par les furbolgs pour Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}, butin rare",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}, butin rare",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Pour Kernda à {area:1769} : gardez-le",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}, pour Meilosh plus tard",

	-- Step 7: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "Le Chaudron des Mort-bois en {zone:1448} : gardez-la",

	-- Step 8: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Le village des furbolgs Tombe-hiver s'étend à l'est de {area:2255} : Chamans (56-57), Protecteurs (55-56) et Ursa (57-58) Tombe-hiver, tous plus forts que vous. Tuez d'abord les Chamans, ils soignent, et attirez-les depuis la lisière. {npc:10738}, dans la grotte du fond, est élite : n'y allez pas.",

	-- Step 9: The Ice Thistle Hills
	-- {area:2247} Ice Thistle Hills
	["The {area:2247}"] = "{area:2247}",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Les Yétis Chardon de glace vivent dans les collines au sud de {area:2244}, les Chimères Noroît dans la vallée vers {area:2255}.",

	-- Step 11: Optional: Sunken Temple
	-- {area:1417} Sunken Temple
	["Optional: {area:1417}"] = "Facultatif : {area:1417}",
	-- {area:1417} Sunken Temple · {area:2255} Everlook
	["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Pas encore niveau 54 après les yétis ? En groupe, faire {area:1417} (50-54) plutôt que tuer des monstres vous y amène plus vite. Revenez ensuite à {area:2255}.",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cornes de yéti en parfait état",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Retournez dans les collines : seuls les Matriarches et Patriarches Chardon de glace portent les cornes. Tuez des yétis jusqu'au niveau 54 : avant, les quêtes d'Indomptables de Harlo Barnaby sont rouges.",
	-- {npc:7460} Ice Thistle Patriarch · {area:2247} Ice Thistle Hills · {zone:1452} Winterspring
	["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "tuez des {npc:7460} à {area:2247}, {zone:1452}",

	-- Step 13: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Sur {npc:10978}, près de l'auberge",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978} : {npc:7583} et {npc:10977} viennent plus tard",

	-- Step 14: Starfall Village
	-- {npc:10301} Jaron Stoneshaper
	["Ride west along the road to {npc:10301}."] = "Chevauchez vers l'ouest sur la route jusqu'à {npc:10301} Stoneshaper.",

	-- Step 15: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Camp de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Descendez la vallée vers le sud-est jusqu'à la caisse endommagée de {npc:10301} dans la neige à {area:2245}, son chariot détruit juste à l'est.",

	-- Step 16: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "Fournitures de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Ramassez les fournitures autour du chariot et reprenez l'amulette de {npc:10301} aux chouettards voisins.",

	-- Step 17: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Suivez les indications de {npc:9298} Snowden jusqu'à l'entrée de {area:2256}, après les Géants Cognegivre : passez-les un par un.",

	-- Step 18: Starfall Village
	["Ride north-west back to the village."] = "Retournez au village au nord-ouest.",

	-- Step 21: Winterfall Spirit Beads
	["The western Winterfall furbolgs drop the beads."] = "Les furbolgs Tombe-hiver de l'ouest laissent les perles.",

	-- Step 23: Chillwind Camp
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood · {area:442} Auberdine · {area:150} Menethil Harbor · {area:271} Southshore · {area:3197} Chillwind Camp
	["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Traversez {area:1769} jusqu'en {zone:1448} et poursuivez en vol vers les Royaumes de l'Est ({area:442}, puis le bateau pour {area:150}). Volez jusqu'à {area:271} et remontez la route vers le nord à travers Alterac jusqu'à {area:3197}.",

	-- Step 24: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Suivez la route du sud vers l'est jusqu'en {zone:1423} ; les ruines de {area:2262} sont au sud de la route. Le fantôme de {npc:10926} Redpath joue près de la maison en ruine, au bout sud.",

	-- Step 25: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "Poupée de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Les trois morceaux de la poupée sont dans les maisons en ruine de {area:2262} ; en ramasser un peut faire surgir des fantômes. Assemblez-les pour obtenir la poupée.",

	-- Step 26: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, en {zone:1422} : gardez-la",

	-- Step 27: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Suivez la route vers l'est à travers la zone jusqu'à la Chapelle de l'Espoir de Lumière.",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast
	["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038} : {npc:12250} est un élite de niveau 54",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "Le Fléau autour de {area:2264}, à l'ouest de la chapelle, lâche les deux sortes de Pierres du Fléau ; des Esprits de Darrowshire ({npc:11064}) en surgissent : parlez à chacun pour le libérer.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libérez des Esprits de Darrowshire ({npc:11064}) : parlez-leur",

	-- Step 30: The Undercroft
	-- {npc:12250} Zaeldarr the Outcast · {area:2261} The Undercroft
	["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} est élite : il est conseillé de grouper. Il attend au fond du {area:2261}, la crypte au sud-ouest de la zone.",

	-- Step 31: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la cabane en ruine, et son livre de reçus est dans l'auberge en ruine voisine.",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "Le guide suivant commence ici et vole vers {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr le Banni est élite : il est conseillé de grouper. Il attend au fond de {area:2261}, la crypte au sud-ouest de la zone.",
}
