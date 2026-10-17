-- French (frFR): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Gadgetzan
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:976} Gadgetzan · {npc:9619} Torwa Pathfinder
	["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Depuis {area:144}, prenez un vol pour {area:150}, le bateau pour Theramore, puis un vol pour {area:976}. La première quête de {npc:9619} dans le cratère demande le niveau 48 : finissez le niveau ici s'il vous manque.",
	-- {area:976} Gadgetzan
	["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "tuez des Bat-le-désert ou des ogres Cognedune autour de {area:976}",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Chevauchez vers l'ouest hors de {area:976} jusqu'à la longue rampe qui descend dans {zone:1449}. {npc:9619} campe au pied de la rampe, dans le coin sud-est du cratère.",

	-- Step 3: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "Le battrodon mort se trouve au bord de l'eau au nord de {npc:9619}.",

	-- Step 5: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Compagnes de Lar'korwi ({npc:9683}) et le radeau",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Les Compagnes de Lar'korwi ({npc:9683}) rôdent dans la jungle à l'ouest de {npc:9619}. Le radeau échoué gît sur la rive du lac là-bas ; le petit paquetage est dans l'eau à côté. Gardez la boussole, la carte et la clé pour {npc:8737}. N'importe quelle bête du cratère peut lâcher {item:11116} : faites un clic droit dessus.",

	-- Step 7: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {object:157936} Un'Goro Dirt Pile
	["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Chevauchez vers le nord le long du côté est du cratère jusqu'à {area:541}, le camp dans les grottes de la falaise nord. Évitez largement les diablosaures et les stégodons élites. Ramassez désormais chaque Cristal de puissance et chaque {object:157936} sur votre chemin.",
	["Gryfe"] = "Gryfe",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Se termine auprès de {npc:9298} au {zone:1452} : gardez-la",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}, au fond de la grotte",

	-- Step 8: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618} se tient juste devant le refuge.",

	-- Step 9: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} et la jungle est",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Chevauchez vers le sud jusqu'à {area:537}, au milieu du cratère, puis vers l'est dans la jungle orientale. Des amas de cristaux se dressent partout dans le cratère, beaucoup autour de {area:537} : prenez-en quelques-uns de plus de chaque couleur. Les Flagellants ({npc:6509}) et Batteurs Pétale-de-sang lâchent les pétales ; {item:11113} de l'expédition se trouve dans un camp abandonné de la jungle orientale.",

	-- Step 10: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Chevauchez vers le nord jusqu'à {area:1943}, où le robot se tient parmi les gorilles. N'entrez pas dans la grotte profonde.",

	-- Step 11: Zul'Farrak (optional)
	-- {area:978} Zul'Farrak
	["{area:978} (optional)"] = "{area:978} (facultatif)",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Faire {area:978} au lieu de tuer des monstres vous y mène plus vite en groupe. La cité troll se trouve dans le nord-ouest de {zone:1446}, juste au nord de {area:976}.",

	-- Step 12: Grind to 50
	["Grind to 50"] = "Monter au niveau 50",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Les gorilles de {area:1943} viennent en petits groupes et ne laissent encore rien tomber pour vous ; la quête des peaux de {npc:9619} vient plus tard. N'entrez pas dans la grotte la plus profonde : {npc:9622} est de niveau 55.",
	-- {npc:6514} Un'Goro Gorilla · {area:1943} Ironstone Plateau · {zone:1449} Un'Goro Crater
	["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "tuez des {npc:6514} à {area:1943}, {zone:1449}",

	-- Step 13: Marshal's Refuge
	["Ride west back to the refuge."] = "Revenez vers l'ouest jusqu'au refuge.",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Pour {npc:7775} en {zone:1444} : gardez-la",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Le panneau en bois à côté de {npc:9997}",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, à l'entrée du refuge",

	-- Step 14: Northern Pylon
	["Northern Pylon"] = "Le Pylône nord",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "Le pylône se dresse sur la pente à l'est du refuge. Les {npc:9166} tournoient sur les pentes autour : ils comptent pour {npc:9997} et laissent tomber les écailles de {npc:9998}.",

	-- Step 15: The east side
	["The east side"] = "Le côté est",
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Descendez vers le sud par le côté est. Les Jeunes dimeurtrodons paissent dans la jungle est et les {npc:9165} volent près des falaises est ; les deux laissent tomber les écailles de {npc:9998}.",

	-- Step 16: Eastern Pylon
	["Eastern Pylon"] = "Le Pylône est",
	["The pylon stands on the eastern cliffs."] = "Le pylône se dresse sur les falaises est.",

	-- Step 17: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Chevauchez vers le sud le long des falaises est jusqu'à {npc:9619}, au pied de la rampe.",
	["The pelts come after loop 2, on the gorilla plateau"] = "Les peaux viennent après la boucle 2, sur le plateau des gorilles",

	-- Step 18: The Gorishi hive
	["The Gorishi hive"] = "La ruche Gorishi",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {npc:9166} Pterrordax
	["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Chevauchez vers l'ouest depuis {npc:9619} : la ruche silithide occupe le sud du cratère. Utilisez la Fiole rayée sur un couvoir, une salle où pendent des larves. Les guêpes et ouvriers Gorishi laissent tomber {quest:3764} ; les {npc:9166} nichent sur les falaises sud s'il vous faut encore des victimes.",

	-- Step 19: Bones and equipment
	["Bones and equipment"] = "Os et équipement",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Les Os de dinosaure jonchent le sol au sud-ouest, parmi les stégodons : ceux-ci sont élites, ramassez les os autour d'eux et prenez le reste sur les Dimeurtrodons. L'{item:11112} de l'expédition se trouve dans la jungle sud-ouest.",

	-- Step 20: Western Pylon
	["Western Pylon"] = "Le Pylône ouest",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "Le pylône se dresse sur les falaises ouest. Les {npc:9167} volent au-dessus de tout le côté ouest.",

	-- Step 21: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "Remontez vers le nord par la jungle ouest jusqu'au refuge.",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, à l'entrée du refuge",

	-- Step 22: Spraggle Frock
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9999}, l'ami de {npc:9997}, a disparu.",

	-- Step 23: Ironstone Plateau
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Les gorilles vivent sur {area:1943}, à l'est de {area:541}. Gardez leurs peaux pour {npc:9619}. N'entrez pas dans la grotte la plus profonde : {npc:9622} est de niveau 55.",

	-- Step 24: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} est assis sur la pente sud-est de {area:537}, au milieu du cratère.",

	-- Step 25: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escorter {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Menez {npc:9999} vers le nord jusqu'à {area:541}. Quand il s'évanouit, utilisez la {item:11804} sur lui pour le réveiller.",

	-- Step 27: Sunken Temple
	-- {area:1417} Sunken Temple
	["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:1417} au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",

	-- Step 28: Grind to 51
	["Grind to 51"] = "Monter au niveau 51",
	-- {area:982} Noxious Lair · {zone:1446} Tanaris
	["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Les silithides Centipaar rampent autour de {area:982}, dans l'ouest de {zone:1446}, juste à l'est de la rampe du cratère. Les Ouvriers sont les plus faciles à attirer.",
	-- {npc:5458} Centipaar Worker · {area:982} Noxious Lair · {zone:1446} Tanaris
	["grind on {npc:5458} at {area:982}, {zone:1446}"] = "tuez des {npc:5458} à {area:982}, {zone:1446}",

	-- Step 29: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Descendez la rampe dans le cratère : {npc:9619} campe à son pied.",

	-- Step 30: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Le repaire de {npc:9684} se trouve dans la jungle au nord de {npc:9619}, sous les falaises est : utilisez-y la {item:11568}. {npc:9684} est de niveau 56 : commencez avec toute votre vie.",

	-- Step 32: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Chevauchez vers le nord par le côté est jusqu'au plateau des gorilles. {npc:9622}, un gorille de niveau 55, se tient dans sa grotte la plus profonde : éliminez d'abord les gorilles de l'entrée.",

	-- Step 33: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Chevauchez vers l'ouest après {area:541}, puis vers le sud par le côté ouest jusqu'à {area:543} : {npc:10302}, le gobelin, est assis au bord de l'eau.",

	-- Step 34: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Chevauchez vers l'est jusqu'à {area:537}, gravissez-la et utilisez {npc:10541} sur les évents de lave près du sommet.",

	-- Step 36: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Traversez le sud du cratère jusqu'à {npc:9619}, près de la rampe.",

	-- Step 38: Ironforge
	-- {area:144} Thelsamar · {area:1537} Ironforge
	["Fly from {area:144} to {area:1537}."] = "Prenez un vol de {area:144} pour {area:1537}.",

	-- Step 40: Tinker Town
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616} : les limons sont en {zone:1448}, gardez-la",

	-- Step 41: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Quatre estampes de runes en {zone:1447} : gardez-la",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406} : pour Ogtinc en {zone:1447}, gardez-la",

	-- Step 42: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus se tient à côté du roi Magni dans {object:171709}.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Les reliques sont dans {zone:1428} : gardez-la",

	-- Step 43: Bind and train
	["Bind and train"] = "Lier la pierre de foyer et s'entraîner",

	-- Step 44: Xiggs Fuselighter
	-- {object:32359} Military Ward
	["Xiggs waits in the {object:32359}."] = "Xiggs attend dans {object:32359}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. {item:11316} Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Chevauchez vers le sud jusqu'à {area:537}, au milieu du cratère, puis vers l'est dans la jungle est. Des amas de cristaux se dressent partout dans le cratère, beaucoup autour de {area:537} : prenez-en quelques-uns de plus de chaque couleur. Les Flagellants et Batteurs {item:11316} laissent tomber les pétales ; la {item:11113} de l'expédition se trouve dans un camp abandonné de la jungle est.",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "tuez des {npc:5458} à {area:982}, {zone:1446}",
}
