-- French (frFR): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "Pour les personnages de niveau 49 à 50, mais la plupart des quêtes ici sont de niveau 51-53 : c'est voulu, pour leur expérience. Cette première visite se limite à la moitié est du cratère, où les bêtes sont de niveau 48-52 : attirez-les une par une ; les pylônes, les ossements et la ruche attendront la visite suivante d'Un'Goro, vers le niveau 56.",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 3: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} se tient sur les quais où accoste le bateau.",

	-- Step 4: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	["Theramore flight master"] = "Maître de vol de Theramore",

	-- Step 5: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "Le vol depuis Theramore atterrit à {area:976}.",

	-- Step 7: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "Chevauchez vers l'ouest jusqu'à la ruche Centipaar dans les dunes. N'importe quel Centipaar peut laisser tomber des parties d'insecte.\nAttention : les Traînards Centipaar lancent {npc:4196} en combat comme hors combat, ce qui fait apparaître de petits renforts qui vous interrompent.",

	-- Step 8: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Chevauchez vers le sud jusqu'au camp des ogres. Il est rempli de brutes et d'exécuteurs (46-48) ; {npc:12046} (49) se tient au milieu, entouré de gardes : éliminez-les d'abord.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}, sous terre",

	-- Step 9: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362} : tuez-les au passage",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "Chevauchez vers l'ouest jusqu'à {quest:3362}. Les collecteurs de rosée laissent tomber les glandes ; seules certaines sont pleines, gardez donc la chargée. Des Chardonniers noueux et des façonneurs de racines occupent aussi la vallée.\nAttention : les chardonniers se déplacent beaucoup, vous pouvez facilement attirer des monstres en trop.",

	-- Step 10: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "Revenez vers le nord-est jusqu'à {area:976} : {npc:11758} se tient du côté est de la ville.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",

	-- Step 11: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Chevauchez vers le sud après le {area:1938} jusqu'au {area:981}, les tunnels Hazzali ; l'équipement de Scrimshank se trouve tout au fond.\nAttention : un insecte garde l'équipement. De nombreux insectes patrouillent dans les tunnels, certains de niveau 50, et les combats attirent souvent des renforts.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593} ; sous terre",

	-- Step 12: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1428} Burning Steppes
	["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "Pour {npc:7740} à {zone:1457}, à la fin du guide des {zone:1428} : gardez-le",

	-- Step 14: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Chevauchez vers l'ouest hors de {area:976} jusqu'à la longue rampe qui descend dans {zone:1449}. {npc:9619} campe au pied de la rampe, dans le coin sud-est du cratère.",

	-- Step 15: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "Le cadavre de Threshadon gît au bord de l'eau, au nord de {npc:9619}.\nAttention : des Ravasaures peau-de-venin (50-51) chassent le long de l'eau : attirez-les un par un avant de fouiller la carcasse.\nN'importe quel ravasaure peut laisser tomber une {item:280459} : faites un clic droit dessus, {npc:9619} la prend.",

	-- Step 16: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}, si un ravasaure a laissé tomber l'écaille",
	-- {area:1943} Ironstone Plateau
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "Les gorilles du {area:1943} portent les peaux : gardez-la pour la deuxième visite d'Un'Goro, vers le niveau 56",

	-- Step 17: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Compagnes de Lar'korwi ({npc:9683}) et le radeau",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Les Compagnes de Lar'korwi ({npc:9683}) rôdent dans la jungle à l'ouest de {npc:9619}. Le radeau échoué gît sur la rive du lac là-bas ; le petit paquetage est dans l'eau à côté. Gardez la boussole, la carte et la clé pour {npc:8737}. N'importe quelle bête du cratère peut lâcher {item:11116} : faites un clic droit dessus.",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "{object:161504}, sous l'eau",

	-- Step 18: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "Retournez vers l'est voir {npc:9619} avec les glandes.",

	-- Step 19: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Chevauchez vers le nord-ouest jusqu'au refuge.\nGardez vos distances avec les diablosaures et les stégodons élites. Ramassez désormais chaque {npc:271301} et chaque {object:157936} que vous croisez.",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998} : ses écailles viennent des jeunes bêtes de la jungle à l'est",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, au fond du refuge",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Se termine auprès de {npc:9298} au {zone:1452} : gardez-la",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, au fond de la grotte ; sous terre",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}, {npc:9271}, {npc:9270} et {npc:9618} ont des quêtes parmi des monstres de niveau 51-55 : gardez-les pour la deuxième visite d'Un'Goro, vers le niveau 56.",

	-- Step 20: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} et la jungle de l'est",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "Chevauchez vers l'est dans la jungle de l'est : les Flagellants et Batteurs Pétale-de-sang (48-50) lâchent les pétales et {quest:3764}. Des amas de cristaux se dressent partout dans le cratère, nombreux au pied de {area:537} : prenez-en quelques-uns de plus de chaque couleur.\nAttention : les Brasiers vivants (54-55) arpentent le sommet de {area:537}, et les Écorcheurs et Trappeurs Pétale-de-sang (51-53) tiennent le sud de la jungle : prenez vos cristaux au pied de la crête et vos pétales au nord.\nÉcailles pour {npc:9998} : les {npc:9165} (48-50) planent au nord-est de la jungle et les Jeunes dimeurtrodons (49-50) paissent à côté. Il n'y en a que dix : les Dimeurtrodons (51) en lisière ouest de la jungle, un peu à l'ouest des Batteurs, lâchent aussi les écailles. Ils ont un niveau de plus que vous : prenez-les un par un.",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316}, sur les Flagellants et les Batteurs",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764}, sur les Batteurs et les tas de terre",

	-- Step 21: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "Des amas de cristaux se dressent partout dans le cratère. Les Seigneurs du goudron (53-54) des fosses et les limons alentour (50-54) sont plus forts que vous : prenez les amas en lisière nord-est de la jungle, parmi les Flagellants et les jeunes bêtes (48-50).",

	-- Step 22: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, sous terre",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Pour {npc:7775} en {zone:1444} : gardez-la",

	-- Step 23: Level 49.79
	["Level 49.79"] = "Niveau 49.79",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "Toujours en dessous du niveau 49.79 après les rendus du refuge ? Tuez des Flagellants et Batteurs Pétale-de-sang (48-50) dans la jungle de l'est, là où vous avez pris les pétales, avant de quitter le cratère.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "tuez en boucle : {npc:6511}",

	-- Step 24: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Prendre un vol pour {area:415}",
	-- {zone:1455} Ironforge · {zone:1427} Searing Gorge · {zone:1440} Ashenvale · {zone:1447} Azshara
	["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "Les quêtes de {zone:1455} ont été prises à la fin du guide de la {zone:1427} : prenez directement un vol pour {zone:1440} afin de rejoindre {zone:1447}.",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Maître de vol du {area:541}",

	-- Step 25: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Vers {zone:1455}",

	-- Step 26: Mystic Ward
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406} : pour Ogtinc en {zone:1447}, gardez-la",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "{npc:7312}, le maître des mages : pour {npc:8395} en {zone:1447}, gardez-la",

	-- Step 29: Fly to Astranaar
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus se tient à côté du roi Magni dans {object:171709}.",
	-- ["Below ground"] = "Sous terre",
	-- ["Bind and train"] = "Lier la pierre de foyer et s'entraîner",
	-- ["Bones and equipment"] = "Os et équipement",
	-- ["Class trainer"] = "Maître de classe",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Traversez le sud du cratère jusqu'à {npc:9619}, près de la rampe.",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Les Os de dinosaure jonchent le sol au sud-ouest, parmi les stégodons : ceux-ci sont élites, ramassez les os autour d'eux et prenez le reste sur les Dimeurtrodons. L'{item:11112} de l'expédition se trouve dans la jungle sud-ouest.",
	-- ["Eastern Pylon"] = "Le Pylône est",
	-- ["Escort {npc:9999}"] = "Escorter {npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "Prenez un vol de {area:144} pour {area:1537}.",
	-- ["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "Pour les personnages de niveau 49 à 50, mais la plupart des quêtes ici sont de niveau 51-53 : c'est voulu, pour leur expérience. Les bêtes du cratère sont de niveau 48-55 et les silithides Gorishi 51-54 : attirez-les un par un.",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "Quatre estampes de runes en {zone:1447} : gardez-la",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Depuis {area:144}, prenez un vol pour {area:150}, le bateau pour Theramore, puis un vol pour {area:976}. La première quête de {npc:9619} dans le cratère demande le niveau 48 : finissez le niveau ici s'il vous manque.",
	-- ["From {area:392}, fly to {area:976}."] = "Depuis {area:392}, prenez un vol pour {area:976}.",
	-- ["Grind to 50"] = "Monter au niveau 50",
	-- ["Grind to 51"] = "Monter au niveau 51",
	-- ["Gryfe"] = "Gryfe",
	-- ["Hearth to {area:2101}"] = "Pierre de foyer vers {area:2101}",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Menez {npc:9999} vers le nord jusqu'à {area:541}. Quand il s'évanouit, utilisez la {item:11804} sur lui pour le réveiller.",
	-- ["Level 50.4"] = "Niveau 50.4",
	-- ["Northern Pylon"] = "Le Pylône nord",
	-- ["Pterrordax"] = "Pterreurdactyles",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Descendez la rampe dans le cratère : {npc:9619} campe à son pied.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Chevauchez vers l'est jusqu'à {area:1943}, où le robot se tient parmi les gorilles. N'entrez pas dans la grotte profonde.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Chevauchez vers l'est jusqu'à {area:537}, gravissez-la et utilisez {npc:10541} sur les évents de lave près du sommet.",
	-- ["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Chevauchez vers le nord le long du côté est du cratère jusqu'à {area:541}, le camp dans les grottes de la falaise nord. Évitez largement les diablosaures et les stégodons élites. Ramassez désormais chaque Cristal de puissance et chaque {object:157936} sur votre chemin.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Chevauchez vers le nord par le côté est jusqu'au plateau des gorilles. {npc:9622}, un gorille de niveau 55, se tient dans sa grotte la plus profonde : éliminez d'abord les gorilles de l'entrée.",
	-- ["Ride north along the western jungle back to the refuge."] = "Remontez vers le nord par la jungle ouest jusqu'au refuge.",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Chevauchez vers le nord jusqu'à {area:1943}, où le robot se tient parmi les gorilles. N'entrez pas dans la grotte profonde.",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Chevauchez vers le sud le long des falaises est jusqu'à {npc:9619}, au pied de la rampe.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "Descendez vers le sud par le côté est. Les Jeunes dimeurtrodons paissent dans la jungle est et les {npc:9165} volent près des falaises est ; les deux laissent tomber les écailles de {npc:9998}. La caisse se trouve au camp abandonné dans la jungle est.",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Chevauchez vers le sud jusqu'à {area:537}, au milieu du cratère, puis vers l'est dans la jungle orientale. Des amas de cristaux se dressent partout dans le cratère, beaucoup autour de {area:537} : prenez-en quelques-uns de plus de chaque couleur. Les Flagellants ({npc:6509}) et Batteurs Pétale-de-sang lâchent les pétales ; {item:11113} de l'expédition se trouve dans un camp abandonné de la jungle orientale.",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. {item:11316} Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Chevauchez vers le sud jusqu'à {area:537}, au milieu du cratère, puis vers l'est dans la jungle est. Des amas de cristaux se dressent partout dans le cratère, beaucoup autour de {area:537} : prenez-en quelques-uns de plus de chaque couleur. Les Flagellants et Batteurs {item:11316} laissent tomber les pétales ; la {item:11113} de l'expédition se trouve dans un camp abandonné de la jungle est.",
	-- ["Ride south-west past {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; Pterrordax nest on the southern cliffs if you still need kills.\nCareful: Gorishi silithids are level 51-54 and cast {spell:8137} or {spell:14120} in melee; Gorishi Workers have a 50% chance to call for help within 25 yd once they fall below 45% health."] = "Chevauchez vers le sud-ouest en passant {npc:9619} : la ruche des silithides occupe le sud du cratère. Utilisez la fiole à prélèvement sur une couveuse, une salle aux larves suspendues. Les guêpes et les ouvriers Gorishi lâchent {quest:3764} ; des Pterreurdactyles nichent sur les falaises du sud s'il vous faut encore des victimes.\nAttention : les silithides Gorishi sont de niveau 51-54 et lancent {spell:8137} ou {spell:14120} au corps à corps ; les Ouvriers Gorishi ont 50 % de chances d'appeler à l'aide dans un rayon de 25 m quand leur vie passe sous 45 %.",
	-- ["Ride west back to the refuge."] = "Revenez vers l'ouest jusqu'au refuge.",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Retournez vers l'ouest jusqu'au refuge.\nGardez vos distances avec les diablosaures et les stégodons élites. Ramassez désormais chaque {npc:271301} et chaque {object:157936} que vous croisez.",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Chevauchez vers l'ouest depuis {npc:9619} : la ruche silithide occupe le sud du cratère. Utilisez la Fiole rayée sur un couvoir, une salle où pendent des larves. Les guêpes et ouvriers Gorishi laissent tomber {quest:3764} ; les {npc:9166} nichent sur les falaises sud s'il vous faut encore des victimes.",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Chevauchez vers l'ouest en sortant de {area:976} jusqu'à la longue rampe qui descend dans le {area:490}. {npc:9619} campe au pied de la rampe, dans le coin sud-est du cratère.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Chevauchez vers l'ouest après {area:541}, puis vers le sud par le côté ouest jusqu'à {area:543} : {npc:10302}, le gobelin, est assis au bord de l'eau.",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:1417} au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Faire {area:978} au lieu de tuer des monstres vous y mène plus vite en groupe. La cité troll se trouve dans le nord-ouest de {zone:1446}, juste au nord de {area:976}.",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "Toujours en dessous du niveau 49.79 après les rendus du refuge ? Tuez des Pterreurdactyles sur les pentes à l'est de {area:541} avant de quitter le cratère.",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Les silithides Centipaar rampent autour de {area:982}, dans l'ouest de {zone:1446}, juste à l'est de la rampe du cratère. Les Ouvriers sont les plus faciles à attirer.",
	-- ["The Gorishi hive"] = "La ruche Gorishi",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "Le battrodon mort se trouve au bord de l'eau au nord de {npc:9619}.",
	-- ["The east side"] = "Le côté est",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Les gorilles vivent sur {area:1943}, à l'est de {area:541}. Gardez leurs peaux pour {npc:9619}. N'entrez pas dans la grotte la plus profonde : {npc:9622} est de niveau 55.",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Les gorilles de {area:1943} viennent en petits groupes et ne laissent encore rien tomber pour vous ; la quête des peaux de {npc:9619} vient plus tard. N'entrez pas dans la grotte la plus profonde : {npc:9622} est de niveau 55.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Les peaux viennent après la boucle 2, sur le plateau des gorilles",
	-- ["The pylon stands on the eastern cliffs."] = "Le pylône se dresse sur les falaises est.",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "Le pylône se dresse sur la pente à l'est du refuge. Des Pterreurdactyles tournoient sur les pentes alentour : ils comptent pour Spraggle et lâchent les écailles de {npc:9998}.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "Le pylône se dresse sur la pente à l'est du refuge. Les {npc:9166} tournoient sur les pentes autour : ils comptent pour {npc:9997} et laissent tomber les écailles de {npc:9998}.",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "Le pylône se dresse sur les falaises ouest. Les {npc:9167} volent au-dessus de tout le côté ouest.",
	-- ["The relics are in the {zone:1428}: keep it"] = "Les reliques sont dans {zone:1428} : gardez-la",
	-- ["The wooden sign beside {npc:9997}"] = "Le panneau en bois à côté de {npc:9997}",
	-- ["Top up here to level 49.51 before the hand-ins at {area:541}: they take you to level 50."] = "Complétez ici jusqu'au niveau 49.51 avant les rendus de quêtes au {area:541} : ils vous font passer au niveau 50.",
	-- ["Top up here to level 50.4 before the hand-ins at {area:3137}: they take you to level 51."] = "Complétez ici jusqu'au niveau 50.4 avant les rendus de quêtes à {area:3137} : ils vous font passer au niveau 51.",
	-- ["Western Pylon"] = "Le Pylône ouest",
	-- ["Xiggs waits in the {object:32359}."] = "Xiggs attend dans {object:32359}.",
	-- ["grind on Pterrordax"] = "tuez des Pterreurdactyles en boucle",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "tuez des Bat-le-désert ou des ogres Cognedune autour de {area:976}",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "tuez des {npc:5458} à {area:982}, {zone:1446}",
	-- ["grind on {npc:6116}"] = "tuez en boucle : {npc:6116}",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "tuez des {npc:6514} à {area:1943}, {zone:1449}",
	-- ["grind on {npc:9164}"] = "tuez en boucle : {npc:9164}",
	-- ["grind on {npc:9167}"] = "tuez en boucle : {npc:9167}",
	-- ["{area:144} flight master"] = "Maître de vol de {area:144}",
	-- ["{area:490}: kill these as you meet them"] = "{area:490} : tuez-les au passage",
	-- ["{area:978} (optional)"] = "{area:978} (facultatif)",
	-- ["{item:11830} on the way"] = "{item:11830} en chemin",
	-- ["{item:11834} on the way"] = "{item:11834} en chemin",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734} : le guide précédent vous ramène ici par la pierre de foyer, cette étape se coche donc généralement aussitôt",
	-- ["{npc:7564}, once he has brewed the elixir: a few seconds"] = "{npc:7564}, une fois qu'il a préparé l'élixir : quelques secondes",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, au fond de la grotte",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616} : les limons sont en {zone:1448}, gardez-la",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618} se tient juste devant le refuge.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Le repaire de {npc:9684} se trouve dans la jungle au nord de {npc:9619}, sous les falaises est : utilisez-y la {item:11568}. {npc:9684} est de niveau 56 : commencez avec toute votre vie.",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9999}, l'ami de {npc:9997}, a disparu.",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998}, à l'entrée du refuge",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, à l'entrée du refuge",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} est assis sur la pente sud-est de {area:537}, au milieu du cratère.",
}
