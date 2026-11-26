-- French (frFR): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1422} Western Plaguelands · {area:152} Bulwark · {zone:1447} Azshara · {zone:1448} Felwood
	["{zone:1422} and the {area:152} first, then {zone:1447} and {zone:1448}."] = "D'abord {zone:1422} et {area:152}, puis {zone:1447} et {zone:1448}.",

	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Il campe près du {area:202}, au sud-est de {area:200}.",
	["Inside"] = "À l'intérieur",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "Loups malades",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "Les loups parcourent les champs entre Andorhal, {area:200} et le {area:202}. Finissez-les sur le chemin du retour vers l'est. Attention : les plus gros sont de niveau 54 : attirez-les un par un.",

	-- Step 3: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Ferme de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "Le journal se trouve dans la ferme, le meuble est à l'intérieur et les latrines sont derrière. Un {npc:10816} porte la clé des latrines ; {npc:10836} sort quand vous ouvrez les latrines et porte la clé du meuble.",

	-- Step 4: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands guide's sweep at about 55."] = "",

	-- Step 6: High Executor Derrington
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Vous avez manqué ceci lors du passage précédent de l'itinéraire ici : cela passe d'abord maintenant. C'est rapide et cela ouvre les quêtes qui suivent.",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092} next to Derrington"] = "{item:12814}, dans {object:176092} à côté de Derrington",

	-- Step 7: Box of Incendiaries
	-- {quest:5096} Scarlet Diversions · {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries · {npc:10837} High Executor Derrington
	["{quest:5096} needs a {item:12814} to torch the command tent: take one from the {object:176092} next to {npc:10837}."] = "{quest:5096} demande une {item:12814} pour incendier la tente de commandement : prenez-en une dans {object:176092} à côté de {npc:10837}.",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092}"] = "{item:12814}, dans {object:176092}",

	-- Step 8: Scarlet forward camp
	["Scarlet forward camp"] = "Camp avancé écarlate",
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {item:12814} Flame in a Bottle
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {item:12814} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Depuis {area:152}, suivez la route vers l'est jusqu'aux {zone:1422}. Les tentes de la Croisade écarlate se trouvent juste après la ferme des Felstone, entre {area:199} et {area:200}. Incendiez la tente de commandement avec {item:12814} et plantez la bannière du Fléau. Attention : les Écarlates autour des tentes vont jusqu'au niveau 54 et les invocateurs lancent des sorts : arrivez par le côté le plus proche de la tente de commandement et laissez les autres tranquilles.",

	-- Step 9: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Chevauchez vers le sud-ouest en passant la ferme des Felstone et suivez la route vers l'ouest jusqu'à {area:152}.",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "Les tours de guet de Derrington et le chaudron de Vandis se font lors d'une visite ultérieure : gardez-les.",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "Maître des paladins",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152} ({zone:1420}) ; {zone:1454} n'a pas de maître des paladins",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 13: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "Le centre d'{zone:1454}",

	-- Step 14: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659} takes the ravasaur claws from Un'Goro; he is in {object:172959}, upstairs in one of its tallest buildings."] = "",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 15: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Prendre un vol pour {area:1237}",
	-- {zone:1447} Azshara · {zone:1454} Orgrimmar
	["{zone:1447} is a short flight from {zone:1454}: its quests are 51-55, at your level now."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 16: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473} : {quest:91569}, une baguette sur les arcanistes elfes de sang",

	-- Step 17: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221} : tuez-les au passage",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Chevauchez vers l'est jusqu'aux ruines sur la côte. Les quatre tablettes se trouvent parmi les ruines, gardées par des nagas Fouette-bile (52-55) : attirez-les un par un.",

	-- Step 18: Ruins of Eldarath
	-- {item:10695} Box of Empty Vials · {area:1231} Southridge Beach · {npc:8390} Chemist Cuely · {zone:1458} Undercity
	["Open Cuely's {item:10695} in your bags for the four labelled vials. The tide pools cannot be clicked: stand in each pool and use its own vial from your bags, from {area:1231} north up the coast; Spitelash naga patrol between them. No vials? Abandon the quest and take it again from {npc:8390} in the {zone:1458}."] = "",
	-- {item:10691} Filled Vial Labeled #1 · {area:1231} Southridge Beach
	["{item:10691}: the tide pool on {area:1231}"] = "",
	["#2, north along the shore"] = "",

	-- Step 19: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Fouisseurs makrinni",
	-- {npc:247473} Izvi Gildfizz · {item:246683} Treasure Trowel 3000
	-- plural, as words: Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment · Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["{npc:247473}'s {item:246683}, in your bags, digs up the Highborne Treasure Fragments: use it on the sands just east of the ruins, where the Makrinni Burrowers (50-51) dig, on the way north-east. The Burrowers and the buried caches there give fragments too."] = "",

	-- Step 20: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Continuez au nord-est à travers le centre d'{zone:1447} : {npc:235903} campe près de la route.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903} : {quest:86746}, les satyres au nord du camp des elfes de sang",

	-- Step 21: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Chevauchez au nord-est jusqu'au camp du gobelin sur les falaises au-dessus de {area:1227}, juste au nord des elfes de sang.",

	-- Step 22: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Les elfes de sang campent sur les falaises au nord-est, près de {area:1227}. Les quatre pièces d'équipement de {npc:8420} se trouvent dans les caisses autour du camp ; les Arcanistes elfes de sang portent la baguette de {npc:247473}.\nAttention : un {npc:250023}, un élite de niveau 55-57, se tient à la lisière ouest du camp : occupez-vous des elfes de sang par le côté est.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, sur les Arcanistes elfes de sang",

	-- Step 23: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Le camp de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "Le camp de Rimtori se trouve à l'extrémité est du camp de base. Lisez-y le {object:151286} : sur Forever, le Tome sin'dorei à côté demande ensuite les sceaux des trois officiers du camp.",

	-- Step 24: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Chacun des trois officiers du camp (53) porte un sceau : {npc:247006} au centre du camp, {npc:247013} à son extrémité est, et {npc:246991}, qui patrouille sa moitié ouest : affrontez-le du côté est de sa ronde, là où pointe la Flèche.\nAttention : le {npc:250023}, un élite de niveau 55-57, se tient à la lisière ouest du camp, près du bout de la ronde de Hawkhelm : attendez que Hawkhelm revienne vers l'est.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, sur {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, sur {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, sur {npc:247013}",

	-- Step 25: Magus Rimtori
	-- {quest:91500} An Explosive Gambit · {quest:91497} Seals of the Sin'dorei
	["Back to the Sin'dorei Tome: hand in the seals and take {quest:91500}, which gives you the {quest:91497}. Rimtori does not come from the Tome: stand beside one of the camp's tall crystals and use the {quest:91497} from your bags; its crystal explodes and draws her. Which crystal is linked to her is random: each of the other two summons a hostile infernal instead. She is level 55: start at full health."] = "",
	-- {quest:91497} Seals of the Sin'dorei · {npc:8578} Magus Rimtori
	["Use the {quest:91497} from your bags beside a crystal: {npc:8578} (55) comes to the explosion and drops her head"] = "",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538} : pour {npc:8587} à {area:1237}",

	-- Step 26: The Legashi satyrs
	["The Legashi satyrs"] = "Les satyres legashi",
	-- {npc:235903} Ekkal · {npc:235892} Prince Halanox
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind.\nCareful: {npc:235892} (55, elite) stands among the satyrs at the north-east end of their hills, around 67,19: take the satyrs nearer the camp and leave him be."] = "",

	-- Step 27: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "Retournez au nord-ouest auprès de {npc:8420}.",

	-- Step 28: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Allez au sud jusqu'à la lisière nord des {area:1221}. Les Sirènes et les Myrmidons Fouette-bile (50-52) qui s'y trouvent portent la rune de {npc:8420} ; elle tombe rarement, alors longez la lisière jusqu'à l'obtenir.",

	-- Step 29: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "Retournez au nord auprès de {npc:8420} avec la rune, puis suivez la route vers le sud-ouest.",

	-- Step 30: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "Suivez la route vers le sud-ouest : {npc:235903} prend les satyres.",

	-- Step 31: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Retournez à l'ouest jusqu'à {area:1237}.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576} : {quest:91531}, pour {npc:4485} à {zone:1454}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587} : le tome va à {npc:3326} à {zone:1454}",
	-- {npc:8659} Jes'rimon · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {npc:6522} Andron Gant · {zone:1458} Undercity
	["Keep the deliveries: {npc:8659}, {npc:4485} and {npc:3326} are in {zone:1454} next, Magatha in {zone:1456} and {npc:6522} in the {zone:1458} on the next guides."] = "",

	-- Step 32: Sanath Lim-yo
	-- {area:1237} Valormok · {npc:8379} Archmage Xylem
	["Ride east from {area:1237} to Sanath's camp at the foot of the cliff and get off your mount: he teleports you up to {npc:8379}'s tower."] = "",

	-- Step 33: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "L'apprenti en haut de la tour vous renvoie en bas.",
	["Upstairs"] = "À l'étage",

	-- Step 35: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Maître de vol de {area:1237}",

	-- Step 36: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:4485} is in the {object:172958}, {npc:3326} in the {object:172960}, and {npc:8659} in {object:172959}, upstairs in one of its tallest buildings."] = "",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- {npc:8659} Jes'rimon · {npc:8587} Jediga
	["{npc:8659}: his payment goes back to {npc:8587}, on the flight out"] = "",

	-- Step 37: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 38: Druid trainer
	["Druid trainer"] = "Maître des druides",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} ({zone:1412}) ; {zone:1454} n'a pas de maître des druides",

	-- Step 39: Fly to Valormok
	-- {zone:1448} Felwood · {area:1237} Valormok · {npc:8587} Jediga · {npc:8659} Jes'rimon · {area:431} Splintertree Post
	["{zone:1448} is next: fly by way of {area:1237}, where {npc:8587} takes {npc:8659}'s payment, then on to {area:431}."] = "",

	-- Step 41: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Prendre un vol pour {area:431}",

	-- Step 43: Emerald Sanctuary
	["The druids' camp is just past the border."] = "Le camp des druides se trouve juste après la frontière.",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}, à côté de {npc:10921} : {quest:86577}, les organes des ours et des loups de {zone:1448}",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, à la lisière sud du camp",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}, à l'ouest du camp",

	-- Step 44: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "Le village des furbolgs Mort-bois se trouve juste au sud du Sanctuaire. Chaque Mort-bois tué augmente aussi votre réputation auprès du {area:1769} ; gardez les plumes de coiffe.",

	-- Step 45: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Sud de {area:1763}",
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: pull the cultists and hounds away from him."] = "",

	-- Step 47: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "Le puits de lune de {area:1763}",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "Retournez au nord jusqu'à {area:1763}. Remplissez la gourde de Greta au puits de lune corrompu au milieu du camp sud.",

	-- Step 48: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "Le camp de la Horde juste au nord de {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306} : les chouettards sont à {zone:1452}",

	-- Step 49: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "À l'est du Poste de la Vénéneuse, le val criblé de cratères où errent les Bêtes d'entropie et les Horreurs. Tuez-en deux de chaque, puis allez à chacun des trois cratères d'eau gangrenée.",
	["Southern crater"] = "Cratère sud",
	["Western crater"] = "Cratère ouest",
	["Northern crater"] = "Cratère nord",

	-- Step 50: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "La Statue de Malorne se dresse juste au sud du vallon, près de la route vers le nord : sa babiole lance une quête pour {npc:9996} au {area:1997}.",

	-- Step 51: Irontree Woods
	-- {area:1767} Irontree Woods · {npc:10920} Kelek Skykeeper · {npc:9529} Maybess Riverbreeze · {item:11503} Blood Amber · {area:1768} Irontree Cavern
	-- plural, as words: Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}: Angerclaw Grizzlies and Felpaw Ravagers roam the woods for Talo, and their organs are {npc:10920}'s. {npc:9529}'s {item:11503} comes from the Warpwood elementals inside {area:1768}, next."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958}, sur les ours de la griffe colérique",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959}, sur les loups Gangrepatte",

	-- Step 52: Irontree Woods
	-- {area:1768} Irontree Cavern
	["Below ground: from the Warpwood elementals inside {area:1768}"] = "",

	-- Step 53: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {quest:6031} Runecloth · {area:1769} Timbermaw Hold
	["Only from Friendly with the Timbermaw: {npc:11557}, in the tunnel near its {zone:1448} mouth, gives {quest:6031} then (the {area:1769} reputation guide gets you there)."] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; below ground"] = "",

	-- Step 54: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "La route se termine à {npc:15395}, devant le tunnel du {area:1769}, à l'extrême nord-est.",

	-- Step 55: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nIf one drops a {quest:8470} (about one kill in thirty), right-click it; don't stay to farm one. {npc:11558} in {area:1769} takes it only from Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): now if they already are, or on the last guide's pass of the cave."] = "",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop from the Deadwood furbolgs"] = "",

	-- Step 56: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Gardez {quest:8465} pour {zone:1452}.",

	-- Step 57: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She speaks to you only from Neutral with the Timbermaw."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} se promène par ici : cherchez dans le cercle sur la carte",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "Une {item:13140} est tombée : utilisez-la pour lancer la quête, puis libérez {npc:11018} de sa cage au {area:1770}, la grotte à l'extrémité nord de {area:1763}.",
	-- ["Back at the {area:2479}."] = "De retour au {area:2479}.",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "De retour au {area:1762}, les furbolgs Mort-bois (53-54) sont près du tunnel et chaque mort augmente votre réputation auprès des Grumegueules.",
	-- ["Below ground"] = "Sous terre",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Attention : les Protecteurs sont de niveau 53-54 et les Vengeurs Mort-bois 54-55 ; ils appellent les alliés à moins de 25 m sous 50 % de vie et fuient chercher de l'aide sous 15 %.\nContinuez à les tuer jusqu'à ce que l'un d'eux laisse tomber un {quest:8470}, environ une fois sur trente, puis faites un clic droit dessus : {npc:11558} à {area:1769} le prend dès que les Grumegueules vous sont Neutres, maintenant s'ils le sont déjà, ou quand le dernier guide repasse par la grotte au niveau 59.",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Attention : les Protecteurs Mort-bois sont de niveau 53-54 ; ils appellent leurs alliés à moins de 25 m sous 50 % de vie et fuient chercher de l'aide sous 15 %.",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Attention : les Guetteurs de la tanière sont de niveau 53-54 ; ils appellent les alliés à moins de 25 m sous 50 % de vie et fuient chercher de l'aide sous 15 %.\nEn dessous du niveau 54.54, continuez à combattre les Mort-bois ici après le décompte de {npc:15395} : les quêtes rendues à {area:1769} et au {area:2479} vous amènent au niveau 55. Ou, en groupe, faites plutôt le donjon {area:1584} ou le donjon {area:1417}.\nContinuez à les tuer jusqu'à ce que l'un d'eux laisse tomber un {quest:8470}, environ une fois sur trente, puis faites un clic droit dessus : {npc:11558} à {area:1769} le prend dès que les Grumegueules vous sont Neutres, maintenant s'ils le sont déjà, ou quand le dernier guide repasse par la grotte au niveau 59.",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "Traversez la rivière vers l'est jusqu'à {area:2627}, la ville en ruine au nord-ouest des {zone:1423}. {npc:12384} est assis dans une hutte à sa lisière.",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "Les tours de guet de Derrington, le chaudron de Vandis et le tonneau de {npc:11615} se font lors d'une visite ultérieure : gardez-les.",
	-- ["Diseased Grizzlies"] = "Grizzlys malades",
	-- ["Fly to the {area:1497}"] = "Volez jusqu'à {area:1497}",
	-- ["Fly to {area:272}"] = "Prendre un vol pour {area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Suivez la route vers le nord-est jusqu'au {area:1767}. Les Ecorcheurs et Déchireurs Crochebois de l'est des bois portent chacun un {item:11503} ; Grizzlys de la griffe colérique et Ravageurs Gangrepatte parcourent les mêmes bois pour Talo, et leurs organes sont pour {npc:10920}.\nLes Protecteurs Mort-bois (53-54) et les Vengeurs (54-55) du {area:1762} sont les suivants : sous le niveau 54, continuez à chasser les grizzlys et les ravageurs (51-52) ici jusqu'au niveau 54. Les quêtes rendues ensuite à {area:1769}, au {area:2479} et au {area:1997} vous amènent presque au niveau 55. Ou, en groupe, faites plutôt le donjon {area:1417} ou le donjon {area:1584}.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Suivez la route vers le nord-est jusqu'au {area:1767}. Les Ecorcheurs et Déchireurs Crochebois de l'est des bois portent chacun un {item:11503} ; Grizzlys de la griffe colérique et Ravageurs Gangrepatte parcourent les mêmes bois pour Talo. Sous le niveau 54.21, continuez à chasser les grizzlys et les ravageurs : les rendus au {area:1997} et au {area:2479} vous mènent au niveau 55. Ou, en groupe, faites plutôt le donjon {area:1584} ou le donjon {area:1417}.",
	-- ["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Suivez la route vers le nord-ouest. Le sud de {area:1763}, autour de son puits de lune corrompu, est tenu par des cultistes, adeptes, gardes du Conseil des ombres et leurs molosses.",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Depuis la {area:152}, suivez la route vers l'est jusqu'aux {zone:1422}. Les tentes de la Croisade écarlate se dressent juste après la ferme Felstone, entre {area:199} et {area:200}. Incendiez la tente de commandement avec les {object:176092} et plantez la bannière du Fléau. Attention : les Écarlates autour des tentes vont jusqu'au niveau 54 et les Invocateurs lancent des sorts : arrivez par le côté le plus proche de la tente de commandement et laissez les autres tranquilles.",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "Depuis le maître de vol de {area:2268}, volez jusqu'à {area:1497}.",
	-- ["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "Sa chasse suivante, les Grizzlys malades (55-56), attend la visite des Maleterres vers le niveau 58.",
	-- ["Jadefire moonwell"] = "Puits de lune des Jadefeu",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "Gardez la quête de la petite Pamela : Pamela est à {area:2262}, où vous reviendrez plus tard.",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "Gardez la branche : {npc:5770} est à {zone:1456}.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Gardez le colis : {npc:10781} est à {area:1497}.",
	-- ["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "Gardez {quest:5142} : Pamela est à {area:2262}, que vous revisiterez plus tard.",
	-- ["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Gardez {quest:5158} : {npc:5901} est dans {zone:1413}.",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "Gardez {quest:6164} : {npc:12384} le reprend lors de l'étape {area:2627} du guide des {zone:1423}.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Chevaliers et mages travaillent au {area:192} ; les médecins et chasseurs campent au sud.",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Quittez {area:1497} et chevauchez vers l'est sur la route à travers {zone:1420}, en passant {area:152}. La ferme des Felstone est la première ferme sur la route ; {npc:10778} attend dans la maison.",
	-- ["Level 52.63"] = "Niveau 52.63",
	-- ["Level 53"] = "Niveau 53",
	-- ["Level 53.02"] = "Niveau 53.02",
	-- ["Level 53.2"] = "Niveau 53.2",
	-- ["Level 53.34"] = "Niveau 53.34",
	-- ["Level 54.1"] = "Niveau 54.1",
	-- ["Level 54.45"] = "Niveau 54.45",
	-- ["Level 54.54"] = "Niveau 54.54",
	-- ["Level 54.7"] = "Niveau 54.7",
	-- ["Level 54.87"] = "Niveau 54.87",
	-- ["Level 55"] = "Niveau 55",
	-- ["On the way"] = "En chemin",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "Seulement avec 5 Coiffures de plumes mort-bois ({item:21377})",
	-- ["Radley and Durgen"] = "Radley et Durgen",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Retournez vers le sud en passant {area:1763} jusqu'au puits de lune corrompu des satyres Jadefeu et remplissez-y la flasque de {npc:9996}.",
	-- ["Ride back south-east to the Sanctuary."] = "Retournez vers le sud-est jusqu'au Sanctuaire.",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Retournez à {area:1497}, prenez le zeppelin pour {zone:1454} et volez jusqu'au {area:431}. Suivez la route vers l'ouest en quittant Bois-brisé et prenez l'embranchement nord vers {zone:1448}.",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Retraversez la rivière vers l'ouest et continuez jusqu'au {area:192} ; {npc:11610} se cache sur la colline au nord-est.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Allez à l'est jusqu'aux ruines sur la côte. Remplissez les quatre fioles du Chimiste Cuely aux bassins le long du rivage ; des nagas Fouette-bile patrouillent entre eux.",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Chevauchez vers le nord le long des collines de l'est ; {npc:1855} vit dans une petite maison au bord de {area:2619}, à la frontière des {zone:1423}.",
	-- ["Ride north up the road again."] = "Remontez la route vers le nord.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Chevauchez vers le nord-ouest jusqu'à Andorhal. {npc:10667} attend dans l'auberge en ruine à l'ouest de la ville ; les squelettes à l'intérieur sont de niveau 54-57, restez donc sur les bords.",
	-- ["Ride south past the {area:202} to {area:197}. Kill the Diseased Wolves you meet in the fields on the way."] = "Chevauchez vers le sud en passant le {area:202} jusqu'à {area:197}. Tuez les Loups malades que vous croisez dans les champs en chemin.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Chevauchez vers le sud en passant le {area:202} jusqu'à {area:197} ; la maison de {npc:10927} se dresse au bord de la route, et le monument de {npc:10936} est dans le cimetière derrière. Tuez les Loups malades que vous croisez dans les champs en chemin.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "Suivez la route vers le sud à travers {area:361} jusqu'au Sanctuaire.",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "Suivez la route vers le sud à travers {zone:1448} jusqu'au Sanctuaire.",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Chevauchez vers l'ouest jusqu'au {area:192} ; {npc:11610} se cache sur la colline au nord-est.",
	-- ["Ror stands at the far south end of {area:1761}."] = "Ror se tient à l'extrême sud du {area:1761}.",
	-- ["Scarlet Crusade"] = "Croisade écarlate",
	-- ["Scarlet forward camp"] = "Camp avancé écarlate",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Entrez dans la grotte : {npc:11558} se tient juste à l'entrée.",
	-- ["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Emmenez le chaton au même puits de lune et relâchez-le là avec {item:12565} ; une fois changé en {npc:10042}, ramenez-le à {npc:9996} et cliquez dessus pour le lui remettre.",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Emmenez le chaton au même puits de lune et relâchez-le là ; une fois changé en {npc:10042}, ramenez-le à {npc:9996} et cliquez dessus pour le lui remettre.",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Les annales se trouvent parmi les Tomes moisis ({object:176150}) de l'hôtel de ville d'Andorhal ; ouvrez-les jusqu'à trouver le bon.",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "Le village des furbolgs Mort-bois juste à l'ouest du tunnel. {npc:9462} (56) se tient parmi eux. {npc:11557}, un furbolg amical, est assis à l'extrémité nord du village.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Le village des furbolgs Mort-bois se trouve juste au sud du Sanctuaire. Chaque Mort-bois tué augmente aussi votre réputation auprès du {area:1769} ; gardez les plumes de coiffure. Continuez à les tuer jusqu'au niveau 53.92 : les prochains rendus du Sanctuaire et {area:1763} le demandent. Ou, en groupe, faites plutôt le donjon {area:1417} ou le donjon {area:1584}.",
	-- ["The Jadefire moonwell"] = "Le puits de lune des Jadefeu",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Les satyres legashi (51-52) occupent les collines au nord du camp des elfes de sang : {npc:235903} en veut cinq de chaque type.",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Les Fouisseurs makrinni (50-51) creusent le sable juste à l'est des ruines, sur le chemin du nord-est ; eux et les caches enfouies là donnent les Fragments de trésor de Bien-né.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Les tentes de la Croisade écarlate se dressent entre {area:199} et {area:200}. Incendiez la tente de commandement avec {object:176092} et plantez la bannière du Fléau.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "Les ours parcourent les collines au nord et à l'est du {area:202}.",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Le livre se trouve dans l'auberge en ruine de {area:2627} ; les morts-vivants de la ville sont de niveau 54-56, attirez-les donc un par un.\nLes Grandes termitières sont dispersées sur les collines à l'est de {area:2627}. Utilisez le {item:15042} sur chaque termitière que vous croisez.",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "La succube {npc:9518} attend au milieu de {area:1763}, à côté de {npc:11020}.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Les loups parcourent les champs entre Andorhal, {area:200} et le {area:202}. Finissez-les sur le chemin du retour vers l'est.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "À travers le {area:1769}",
	-- ["To {zone:1448}"] = "Vers {zone:1448}",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53."] = "Montez ici jusqu'au niveau 52.63 avant de rendre les quêtes ({area:200}) : elles vous font passer au niveau 53.",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complétez ici jusqu'au niveau 52.63 avant de rendre les quêtes aux {area:200} : elles vous amènent au niveau 53. Les Rôdeuses putrides (52-53) à l'ouest du camp écarlate sont à votre niveau ; les Mages et les Chevaliers écarlates (54-56) sont plus forts. Ou, en groupe, faites plutôt le donjon {area:1417} ou le donjon {area:2100}.",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Complétez ici jusqu'au niveau 53 avant que {npc:10739} ne vous envoie contre les Grizzlys malades (55-56) : les Rôdeuses putrides (52-53) sur le chemin des {area:200} au {area:202} sont à votre niveau. Ou, en groupe, faites plutôt le donjon {area:1417} ou le donjon {area:1584}.",
	-- ["Top up here to level 53.02 before the hand-ins at {area:202}: they take you to level 54."] = "Montez ici jusqu'au niveau 53.02 avant de rendre les quêtes ({area:202}) : elles vous font passer au niveau 54.",
	-- ["Top up here to level 53.2 before the hand-ins at {area:152}: they take you to level 54."] = "Montez ici jusqu'au niveau 53.2 avant de rendre les quêtes ({area:152}) : elles vous font passer au niveau 54.",
	-- ["Top up here to level 53.34 before the hand-ins at {area:1763}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Montez ici jusqu'au niveau 53.34 avant de rendre les quêtes ({area:1763}) : elles vous font passer au niveau 54. Ou, en groupe, faites plutôt le donjon {area:1417} ou le donjon {area:1584}.",
	-- ["Top up here to level 54.1 before the hand-ins at {area:361}: they take you to level 55."] = "Montez ici jusqu'au niveau 54.1 avant de rendre les quêtes ({area:361}) : elles vous font passer au niveau 55.",
	-- ["Top up here to level 54.45 before the hand-ins at {area:1769}: they take you to level 55."] = "Montez ici jusqu'au niveau 54.45 avant de rendre les quêtes ({area:1769}) : elles vous font passer au niveau 55.",
	-- ["Top up here to level 54.54 before the hand-ins at {area:2479}: they take you to level 55."] = "Montez ici jusqu'au niveau 54.54 avant de rendre les quêtes ({area:2479}) : elles vous font passer au niveau 55.",
	-- ["Top up here to level 54.7 before the hand-ins at {area:1997} : they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Montez ici jusqu'au niveau 54.7 avant de rendre les quêtes ({area:1997}) : elles vous font passer au niveau 55. Ou, en groupe, faites plutôt le donjon {area:1584} ou le donjon {area:1417}.",
	-- ["Top up here to level 54.87 before the hand-ins at {area:2255}: they take you to level 55."] = "Montez ici jusqu'au niveau 54.87 avant de rendre les quêtes ({area:2255}) : elles vous font passer au niveau 55.",
	-- ["Top up here to level 54.87 before the hand-ins in {zone:1452}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Complétez ici jusqu'au niveau 54.87 avant de rendre les quêtes à {zone:1452} : elles vous amènent au niveau 55. Ou, en groupe, faites plutôt le donjon {area:1584} ou le donjon {area:1417}.",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Entrez dans le tunnel du {area:1769} à côté de {npc:15395} et n'attaquez jamais les furbolgs Grumegueules à l'intérieur. Le tunnel débouche sur {zone:1452} ; suivez la route vers l'est jusqu'à {area:2255}, la ville gobeline où commence le prochain guide.",
	-- ["Walk {npc:11018} out of {area:1770} and keep her alive until she is out of the cave."] = "Escortez {npc:11018} hors de {area:1770} et gardez-la en vie jusqu'à ce qu'elle soit sortie de la grotte.",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "Vous avez manqué ceci lors du passage précédent de l'itinéraire ici : cela passe d'abord maintenant. C'est rapide et cela ouvre les quêtes qui suivent.\nPrenez une {object:176092} dans la caisse à côté de Derrington pour {quest:5096}.",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "tuez des Vengeurs Mort-bois ({npc:7157}) au {area:1762}, {zone:1448}",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "tuez des Chevaliers écarlates ({npc:1833}) au {area:192}, {zone:1422}",
	-- ["grind on {npc:10605}"] = "tuez en boucle : {npc:10605}",
	-- ["grind on {npc:1816}"] = "tuez en boucle : {npc:1816}",
	-- ["grind on {npc:1817}"] = "tuez en boucle : {npc:1817}",
	-- ["grind on {npc:1821}"] = "tuez en boucle : {npc:1821}",
	-- ["grind on {npc:7101}"] = "tuez en boucle : {npc:7101}",
	-- ["grind on {npc:7125}"] = "tuez en boucle : {npc:7125}",
	-- ["grind on {npc:7153}"] = "tuez en boucle : {npc:7153}",
	-- ["grind on {npc:7155}"] = "tuez en boucle : {npc:7155}",
	-- ["grind on {npc:7156}"] = "tuez en boucle : {npc:7156}",
	-- ["grind on {npc:7157}"] = "tuez en boucle : {npc:7157}",
	-- ["grind on {npc:8957}"] = "tuez en boucle : {npc:8957}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Les Écarlates d'{area:190} sont de niveau 58-60. Entrez jusqu'au point haut marqué sur votre carte, observez la ville, puis repartez.",
	-- ["{area:2268} flight master"] = "Maître de vol de {area:2268}",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627} : tuez-les au fil de vos rencontres",
	-- ["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, au puits de lune des Jadefeu",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, à l'extrémité sud du cimetière",
	-- ["{npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it."] = "La maison de {npc:10927} se trouve au bord de la route, et le monument de {npc:10936} est dans le cimetière derrière.",
	-- ["{npc:10927}, upstairs"] = "{npc:10927}, à l'étage",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, sous terre",
	-- ["{npc:11018}, below ground"] = "{npc:11018}, sous terre",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, sous terre",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557} : gardez 30 {quest:6031} pour lui ; il ne commerce qu'à partir de Neutre avec les Grumegueules",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557} : gardez 30 {quest:6031} pour lui ; il n'échange qu'à partir de Neutre auprès des Grumegueules ; sous terre",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, à l'entrée du tunnel",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558} : les Grumegueules ne vous parlent qu'à partir de Neutre ; patrouille par ici : regardez dans le cercle sur la carte",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "La dernière tâche de {npc:11610} demande le niveau 53. Les Chevaliers écarlates ({npc:1833}) et les Magus (54-55) du camp de bûcherons juste au sud-ouest sont le camp le plus proche.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} se tient à l'est du camp de bûcherons ; {npc:11611} garde la route au nord-est de {npc:11610}, en direction d'{area:190}.",
	-- ["{npc:1816} along the way to {npc:10739}"] = "{npc:1816} sur le chemin de {npc:10739}",
	-- ["{npc:1816} on the way"] = "{npc:1816} en chemin",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "Les chasses de {npc:1855} se font dans les {zone:1423} : gardez-les pour plus tard.",
	-- ["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659} prend les griffes de ravasaure d'Un'Goro ; il se tient dans {object:172960}, à courte distance du centre de la ville.",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}, juste à l'ouest du camp",
	-- ["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, à l'ouest du Sanctuaire",
	-- ["{npc:9996}'s kitten"] = "Le chaton de {npc:9996}",
	-- ["{npc:9996}: the {quest:86612}"] = "{npc:9996} : {quest:86612}",
	-- ["{object:175894}, beside the house"] = "{object:175894}, à côté de la maison",
	-- ["{object:175924}, inside"] = "{object:175924}, à l'intérieur",
	-- ["{quest:5058}, inside"] = "{quest:5058}, à l'intérieur",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} se rend à {area:2268} : gardez-la pour plus tard.",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408} : les morts-vivants de {area:2627} les laissent tomber tant que vous portez la {item:12846}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, un butin rare",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Les quêtes de {zone:1452} sont de niveau 55-58. Sous le niveau 55 après les quêtes rendues à {npc:9996} ? Les furbolgs Mort-bois (53-55) du {area:1762} sont à votre niveau et sur votre route vers le tunnel de {area:1769} au nord : tuez-les jusqu'au niveau 55. Chaque mort augmente aussi votre réputation auprès des Grumegueules. Attention : les Protecteurs et les Vengeurs appellent les alliés proches sous la moitié de leur vie et fuient chercher de l'aide quand ils sont presque morts : attirez-les un par un depuis la lisière du village. C'est un long complément pour qui suit uniquement cet itinéraire. Ou, en groupe, faites plutôt le donjon {area:1584} ou le donjon {area:1417}.",
}
