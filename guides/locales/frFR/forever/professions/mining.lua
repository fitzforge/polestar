-- French (frFR): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "Apprendre {skill:186}",
	-- {skill:186} Mining · {item:2901} Mining Pick · {spell:2580} Find Minerals · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:11584} Cactus Apple Surprise · {item:247840} Mining for Dummies · {item:277115} Apprentice's Mining Pack · {spell:1230161} Lodestone
	-- plural, as words: Poor Copper Veins = {object:562111} Poor Copper Vein
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on {spell:2580} (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "Tout maître de {skill:186} de votre faction enseigne {skill:186} (Apprenti) à tout niveau (10 pc), tout comme l'apprenti maître mineur de chaque zone de départ ; la flèche indique le plus proche. Achetez une {item:2901} chez un marchand de fournitures ou un marchand général : gardez-la dans vos sacs, vous ne pouvez pas miner sans elle. Activez {spell:2580} (grimoire, onglet Général) pour voir les gisements sur la minicarte. Les zones de départ de Forever ont aussi des Filons de cuivre pauvres ({item:2770} et {item:2835}, dès la compétence 1). La quête de la première heure de chaque zone de départ (Rongeurs retors, La distribution du courrier de la Vallée des Frigères, La Protectrice sylvestre, Surprise aux {item:11584} de Galgar, Une humble contribution, La dernière volonté de Marla) offre {item:247840} en récompense : le lire donne 2 points de compétence, jusqu'à 15. Les marchands de fournitures et les apprentis maîtres vendent le {item:277115}, un sac à minerai et à pierre de quatre emplacements (25 pc). Si vous vous êtes assis au feu de camp de votre zone de départ pour Les grands espaces sauvages, le guide de camping propose aussi Introduction au camping : {skill:186} : rendez-la au maître mineur qu'elle désigne une fois la compétence 20 atteinte, pour la recette {spell:1230161}.",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "Cuivre : {zone:1429} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "Minez chaque gisement de cuivre (1, orange), cuivre pauvre (1, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 50. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 1-10. Comptez environ 60 gisements pour ces 49 points.",
	["Copper"] = "Cuivre",
	["Poor Copper"] = "Cuivre pauvre",
	["Copper, Poor Copper"] = "Cuivre, cuivre pauvre",

	-- Step 3: Copper & Poor Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (1-50)"] = "Cuivre et cuivre pauvre : {zone:1426} (1-50)",

	-- Step 4: Copper: Darkshore (1-50)
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (1-50)"] = "Cuivre : {zone:1439} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 60 nodes for these 49 points."] = "Minez chaque gisement de cuivre (1, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 50. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 10-20. Comptez environ 60 gisements pour ces 49 points.",

	-- Step 5: Copper: Zephras Isle (1-50)
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (1-50)"] = "Cuivre : {zone:2521} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 60 nodes for these 49 points."] = "Minez chaque gisement de cuivre (1, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 50. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 1-15. Comptez environ 60 gisements pour ces 49 points.",

	-- Step 6: Copper & Poor Copper: Durotar (1-50)
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (1-50)"] = "Cuivre et cuivre pauvre : {zone:1411} (1-50)",

	-- Step 7: Copper: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (1-50)"] = "Cuivre : {zone:1412} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "Minez chaque gisement de cuivre (1, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 50. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 1-10. Comptez environ 60 gisements pour ces 49 points.",

	-- Step 8: Copper & Poor Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (1-50)"] = "Cuivre et cuivre pauvre : {zone:1420} (1-50)",
	["Poor Copper, Copper"] = "Cuivre pauvre, cuivre",

	-- Step 9: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "{skill:186} Compagnon",
	-- {skill:186} Mining · {spell:1230161} Lodestone · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "{skill:186} (Compagnon) porte le plafond à 150 ; il demande la compétence 50, sans niveau de personnage, et coûte 5 pa : apprenez-le dès que vous atteignez 50. La flèche indique le maître de {skill:186} de votre faction le plus proche. {spell:1230161}, l'objet de camping de Forever pour {skill:186}, est enseigné dès la compétence 20 (1 pa, ou gratuit via Introduction au camping : {skill:186}) : une {item:2835} et une {item:2840} chacune, elle donne des points jusqu'à 25 ; posée près d'un feu de camp, elle donne à tout le camp une amélioration pendant une heure.",

	-- Step 10: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "Cuivre : {zone:1429} (50-65) (suite)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "Minez chaque gisement de cuivre (1, jaune), cuivre pauvre (1, jaune) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 65. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 1-10. Comptez environ 80 gisements pour ces 15 points.",

	-- Step 11: Copper & Poor Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "Cuivre et cuivre pauvre : {zone:1426} (50-65, suite)",

	-- Step 12: Copper: Darkshore (50-65) cont.
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (50-65) cont."] = "Cuivre : {zone:1439} (50-65) (suite)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 80 nodes for these 15 points."] = "Minez chaque gisement de cuivre (1, jaune) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 65. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 10-20. Comptez environ 80 gisements pour ces 15 points.",

	-- Step 13: Copper: Zephras Isle (50-65) cont.
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (50-65) cont."] = "Cuivre : {zone:2521} (50-65, suite)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 80 nodes for these 15 points."] = "Minez chaque gisement de cuivre (1, jaune) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 65. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 1-15. Comptez environ 80 gisements pour ces 15 points.",

	-- Step 14: Copper & Poor Copper: Durotar (50-65) cont.
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (50-65) cont."] = "Cuivre et cuivre pauvre : {zone:1411} (50-65, suite)",

	-- Step 15: Copper: Mulgore (50-65) cont.
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (50-65) cont."] = "Cuivre : {zone:1412} (50-65) (suite)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "Minez chaque gisement de cuivre (1, jaune) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 65. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70) donne aussi des points. Zone de niveau 1-10. Comptez environ 80 gisements pour ces 15 points.",

	-- Step 16: Copper & Poor Copper: Tirisfal Glades (50-65) cont.
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (50-65) cont."] = "Cuivre et cuivre pauvre : {zone:1420} (50-65, suite)",

	-- Step 17: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["At 65 a {skill:186} trainer teaches {spell:2659} (2s; grey at 115) and {spell:3304} (50c; grey at 75): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "À 65, un maître de {skill:186} enseigne {spell:2659} (2 pa ; gris à 115) et {spell:3304} (50 pc ; gris à 75) : fondre à une forge augmente aussi {skill:186}, alors fondez ce que vous minez.",

	-- Step 18: Incendicite & Tin: Wetlands (65-125)
	-- {zone:1437} Wetlands
	["Incendicite & Tin: {zone:1437} (65-125)"] = "Incendicite et étain : {zone:1437} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Incendicite (65, orange), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minez chaque gisement de cuivre (1, vert), incendicite (65, orange), étain (65, orange), argent (dès 75, rare) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 125. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70), {spell:3304} (gris à 75), {spell:2659} (gris à 115) donnent aussi des points. {spell:2659} demande une {item:2840} et une {item:3576} chacune : gardez des barres des fontes précédentes. Zone de niveau 20-30. Comptez environ 130 gisements pour ces 60 points. {spell:2658} (2 pa ; orange jusqu'à 100, gris à 125) est enseigné dès 75 : apprenez-le si vous passez près d'un maître de {skill:186}, il ne vaut pas un trajet à lui seul.",
	["Tin, Copper"] = "Étain, Cuivre",
	["Incendicite, Tin"] = "Incendicite, étain",

	-- Step 19: Tin: Ashenvale (65-125)
	-- {zone:1440} Ashenvale
	["Tin: {zone:1440} (65-125)"] = "Étain : {zone:1440} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minez chaque gisement de cuivre (1, vert), étain (65, orange), argent (dès 75, rare) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 125. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70), {spell:3304} (gris à 75), {spell:2659} (gris à 115) donnent aussi des points. {spell:2659} demande une {item:2840} et une {item:3576} chacune : gardez des barres des fontes précédentes. Zone de niveau 18-30. Comptez environ 130 gisements pour ces 60 points. {spell:2658} (2 pa ; orange jusqu'à 100, gris à 125) est enseigné dès 75 : apprenez-le si vous passez près d'un maître de {skill:186}, il ne vaut pas un trajet à lui seul.",
	["Tin, Silver"] = "Étain, Argent",
	["Tin"] = "Étain",

	-- Step 20: Copper & Tin: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Copper & Tin: {zone:1413} (65-125)"] = "Cuivre et étain : {zone:1413} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minez chaque gisement de cuivre (1, vert), étain (65, orange), argent (dès 75, rare) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 125. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70), {spell:3304} (gris à 75), {spell:2659} (gris à 115) donnent aussi des points. {spell:2659} demande une {item:2840} et une {item:3576} chacune : gardez des barres des fontes précédentes. Zone de niveau 10-25. Comptez environ 280 gisements pour ces 60 points. {spell:2658} (2 pa ; orange jusqu'à 100, gris à 125) est enseigné dès 75 : apprenez-le si vous passez près d'un maître de {skill:186}, il ne vaut pas un trajet à lui seul.",
	["Copper, Tin"] = "Cuivre, Étain",

	-- Step 21: Tin: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin: {zone:1424} (65-125)"] = "Étain : {zone:1424} (65-125)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minez chaque gisement de cuivre (1, vert), étain (65, orange), argent (dès 75, rare) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 125. Fondez à une forge quand vos sacs sont pleins : {spell:2657} (orange jusqu'à 25, gris à 70), {spell:3304} (gris à 75), {spell:2659} (gris à 115) donnent aussi des points. {spell:2659} demande une {item:2840} et une {item:3576} chacune : gardez des barres des fontes précédentes. Zone de niveau 20-30. Comptez environ 140 gisements pour ces 60 points. {spell:2658} (2 pa ; orange jusqu'à 100, gris à 125) est enseigné dès 75 : apprenez-le si vous passez près d'un maître de {skill:186}, il ne vaut pas un trajet à lui seul.",

	-- Step 22: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "{skill:186} Expert",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "{skill:186} (Expert) porte le plafond à 225 ; il demande la compétence 125, sans niveau de personnage, et coûte 50 pa : apprenez-le dès que vous atteignez 125. La flèche indique le maître de {skill:186} de votre faction le plus proche. Apprenez {spell:3307} (5 pa ; orange jusqu'à 130, gris à 140) lors de la même visite : fondre à une forge augmente aussi {skill:186}, alors fondez ce que vous minez.",

	-- Step 23: Iron: Arathi Highlands (125-155)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (125-155)"] = "Fer : {zone:1417} (125-155)",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "Minez chaque gisement d'étain (65, vert), pierre de sang inférieure (75, vert), argent (75, vert, rare), fer (125, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 155. Fondez à une forge quand vos sacs sont pleins : {spell:3307} (orange jusqu'à 130, gris à 140) donne aussi des points. Zone de niveau 30-40. Comptez environ 50 gisements pour ces 30 points.",
	["Iron, Tin"] = "Fer, étain",
	["Lesser Bloodstone, Silver"] = "Pierre de sang inférieure, argent",

	-- Step 24: Iron: Arathi Highlands (155-175)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (155-175)"] = "Fer : {zone:1417} (155-175)",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, yellow), Gold (155, orange, rare) node you pass and circle the waypoints until {skill:186} 175. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 30-40. Expect about 40 nodes for these 20 points. {spell:3308} (25s; orange to 170, grey at 185) is taught from 155: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "Minez chaque gisement d'étain (65, vert), pierre de sang inférieure (75, vert), argent (75, vert, rare), fer (125, jaune), or (155, orange, rare) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 175. Fondez à une forge quand vos sacs sont pleins : {spell:3308} (orange jusqu'à 170, gris à 185) donne aussi des points. Zone de niveau 30-40. Comptez environ 40 gisements pour ces 20 points. {spell:3308} (25 pa ; orange jusqu'à 170, gris à 185) est enseigné dès 155 : apprenez-le si vous passez près d'un maître de {skill:186}, il ne vaut pas un trajet à lui seul.",
	["Lesser Bloodstone, Gold"] = "Pierre de sang inférieure, or",

	-- Step 25: Mithril: Badlands (175-200)
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (175-200)"] = "Mithril : {zone:1418} (175-200)",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 35-45. Expect about 40 nodes for these 25 points."] = "Minez chaque gisement de fer (125, vert), or (155, orange), mithril (175, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 200. Fondez à une forge quand vos sacs sont pleins : {spell:3308} (orange jusqu'à 170, gris à 185) donne aussi des points. Zone de niveau 35-45. Comptez environ 40 gisements pour ces 25 points.",
	["Iron, Mithril"] = "Fer, mithril",

	-- Step 26: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "{skill:186} Artisan",
	-- {skill:186} Mining
	["Artisan {skill:186} raises the cap to 300; it needs skill 200 and no character level, and costs 5g: train it as soon as you reach 200. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} (Artisan) porte le plafond à 300 ; il demande la compétence 200, sans niveau de personnage, et coûte 5 po : apprenez-le dès que vous atteignez 200. La flèche indique le maître de {skill:186} de votre faction le plus proche.",

	-- Step 27: Mithril: Badlands (200-230) cont.
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (200-230) cont."] = "Mithril : {zone:1418} (200-230, suite)",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 35-45. Expect about 90 nodes for these 30 points."] = "Minez chaque gisement de fer (125, vert), or (155, jaune), mithril (175, jaune) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 230. La fonte ne donne plus de points à partir d'ici (les fontes supérieures sont grises une fois apprises) : fondez pour fabriquer ou vendre, ou vendez le minerai. Zone de niveau 35-45. Comptez environ 90 gisements pour ces 30 points.",

	-- Step 28: Mithril & Dark Iron: Searing Gorge (230-245)
	-- {object:147516} Dark Iron · {zone:1427} Searing Gorge
	["Mithril & {object:147516}: {zone:1427} (230-245)"] = "Mithril et {object:147516} : {zone:1427} (230-245)",
	-- {object:147516} Dark Iron · {skill:186} Mining · {item:11099} Dark Iron Ore · {object:174824} Black Forge (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. {item:11099} smelts only at the {object:174824} in {area:1584} (8 ore a bar). Zone level 43-50. Expect about 40 nodes for these 15 points."] = "Minez chaque gisement d'or (155, vert), mithril (175, vert), {object:147516} (230, orange), vrai-argent (230, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 245. La fonte ne donne plus de points à partir d'ici (les fontes supérieures sont grises une fois apprises) : fondez pour fabriquer ou vendre, ou vendez le minerai. Le {item:11099} ne se fond qu'à la Forge noire, dans {area:1584} (8 minerais par barre). Zone de niveau 43-50. Comptez environ 40 gisements pour ces 15 points.",
	-- {object:147516} Dark Iron
	["Mithril, {object:147516}"] = "Mithril, {object:147516}",

	-- Step 29: Small Thorium: Felwood (245-275)
	-- {zone:1448} Felwood
	["Small Thorium: {zone:1448} (245-275)"] = "Petit filon de thorium : {zone:1448} (245-275)",
	-- {skill:186} Mining · {npc:9528} Arathandris Silversky · {npc:9529} Maybess Riverbreeze
	["Mine every Gold (155, green, rare), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Quests here that need {skill:186}: Salve via {skill:186} (level 55, {npc:9528}; Alliance), Salve via {skill:186} (level 55, {npc:9529}; Horde). Zone level 48-55. Expect about 50 nodes for these 30 points."] = "Minez chaque gisement d'or (155, vert, rare), mithril (175, vert), vrai-argent (230, orange), petit filon de thorium (245, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 275. La fonte ne donne plus de points à partir d'ici (les fontes supérieures sont grises une fois apprises) : fondez pour fabriquer ou vendre, ou vendez le minerai. Quêtes ici qui demandent {skill:186} : Du baume par la pioche ({skill:186}, niveau 55, {npc:9528} ; Alliance), Du baume par la pioche ({skill:186}, niveau 55, {npc:9529} ; Horde). Zone de niveau 48-55. Comptez environ 50 gisements pour ces 30 points.",
	["Mithril, Small Thorium"] = "Mithril, petit filon de thorium",
	["Small Thorium, Truesilver"] = "Petit filon de thorium, vrai-argent",

	-- Step 30: Small Thorium & Rich Thorium: Winterspring (275-300)
	-- {zone:1452} Winterspring
	["Small Thorium & Rich Thorium: {zone:1452} (275-300)"] = "Petit filon et riche filon de thorium : {zone:1452} (275-300)",
	-- {skill:186} Mining
	["Mine every Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 55-60. Expect about 40 nodes for these 25 points."] = "Minez chaque gisement de vrai-argent (230, jaune), petit filon de thorium (245, jaune), riche filon de thorium (275, orange) sur votre passage et faites le tour des points de passage jusqu'à {skill:186} 300. La fonte ne donne plus de points à partir d'ici (les fontes supérieures sont grises une fois apprises) : fondez pour fabriquer ou vendre, ou vendez le minerai. Zone de niveau 55-60. Comptez environ 40 gisements pour ces 25 points.",
	["Rich Thorium, Small Thorium"] = "Riche filon de thorium, petit filon de thorium",
	["Rich Thorium, Truesilver"] = "Riche filon de thorium, vrai-argent",
	["Rich Thorium"] = "Riche filon de thorium",
	["Small Thorium, Rich Thorium"] = "Petit filon de thorium, riche filon de thorium",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "Tout maître de {skill:186} de votre faction enseigne {skill:186} niveau Apprenti (personnage niveau 5) ; la flèche indique le plus proche. Achetez {item:2901} chez un marchand de fournitures d'artisanat ou un marchand général : gardez-la dans vos sacs, impossible de miner sans elle.",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} Artisan porte le plafond à 300 ; il faut 200 en compétence et le niveau 35. La flèche indique le maître de {skill:186} le plus proche de votre faction.",
	-- ["Copper, Silver"] = "Cuivre, Argent",
	-- ["Copper: {zone:1411} (1-50)"] = "Cuivre : {zone:1411} (1-50)",
	-- ["Copper: {zone:1411} (50-65) cont."] = "Cuivre : {zone:1411} (50-65) (suite)",
	-- ["Copper: {zone:1420} (1-50)"] = "Cuivre : {zone:1420} (1-50)",
	-- ["Copper: {zone:1420} (50-65) cont."] = "Cuivre : {zone:1420} (50-65) (suite)",
	-- ["Copper: {zone:1426} (1-50)"] = "Cuivre : {zone:1426} (1-50)",
	-- ["Copper: {zone:1426} (50-65) cont."] = "Cuivre : {zone:1426} (50-65) (suite)",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} Expert porte le plafond à 225 ; il faut 125 en compétence et le niveau 20. La flèche indique le maître de {skill:186} le plus proche de votre faction.",
	-- ["Gold"] = "Or",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "Or et Mithril : {zone:1435} (175-200)",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "Or et Mithril : {zone:1435} (200-230) (suite)",
	-- ["Gold, Iron"] = "Or, Fer",
	-- ["Gold, Mithril"] = "Or, Mithril",
	-- ["Gold: {zone:1435} (155-175)"] = "Or : {zone:1435} (155-175)",
	-- ["Iron, Silver"] = "Fer, Argent",
	-- ["Iron: {zone:1416} (125-155)"] = "Fer : {zone:1416} (125-155)",
	-- ["Iron: {zone:1431} (125-155)"] = "Fer : {zone:1431} (125-155)",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} Compagnon porte le plafond à 150 ; il faut 50 en compétence et le niveau 10. La flèche indique le maître de {skill:186} le plus proche de votre faction.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Minez tous les gisements sur votre passage : Cuivre (1, vert), Étain (65, orange), Argent (dès 75). Faites le tour des points de passage jusqu'à {skill:186} 125. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 10-20.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "Minez tous les gisements sur votre passage : Cuivre (1, vert), Étain (65, orange), Argent (dès 75). Faites le tour des points de passage jusqu'à {skill:186} 125. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 10-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "Minez tous les gisements sur votre passage : Cuivre (1, vert), Étain (65, orange), Argent (dès 75). Faites le tour des points de passage jusqu'à {skill:186} 125. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 15-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "Minez tous les gisements sur votre passage : Cuivre (1, vert), Étain (65, orange), Argent (dès 75). Faites le tour des points de passage jusqu'à {skill:186} 125. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 20-30.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Minez tous les gisements sur votre passage : Cuivre (1, orange). Faites le tour des points de passage jusqu'à {skill:186} 50. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 1-10.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Minez tous les gisements sur votre passage : Cuivre (1, orange). Faites le tour des points de passage jusqu'à {skill:186} 50. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 10-20.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Minez tous les gisements sur votre passage : Cuivre (1, jaune). Faites le tour des points de passage jusqu'à {skill:186} 65. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 1-10.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Minez tous les gisements sur votre passage : Cuivre (1, jaune). Faites le tour des points de passage jusqu'à {skill:186} 65. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 10-20.",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "Minez tous les gisements sur votre passage : Or (155, vert), Mithril (175, vert), Vrai-argent (230, orange), Petit thorium (245, orange). Faites le tour des points de passage jusqu'à {skill:186} 275. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 45-55.",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "Minez tous les gisements sur votre passage : Or (155, vert), Mithril (175, vert), {object:147516} (230, orange), Vrai-argent (230, orange). Faites le tour des points de passage jusqu'à {skill:186} 245. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 43-50.",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Minez tous les gisements sur votre passage : Fer (125, vert), Or (155, orange), Mithril (175, orange). Faites le tour des points de passage jusqu'à {skill:186} 200. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 35-45.",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Minez tous les gisements sur votre passage : Fer (125, vert), Or (155, jaune), Mithril (175, jaune). Faites le tour des points de passage jusqu'à {skill:186} 230. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 35-45.",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Minez tous les gisements sur votre passage : Argent (75, vert), Fer (125, jaune), Or (155, orange). Faites le tour des points de passage jusqu'à {skill:186} 175. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 35-45.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "Minez tous les gisements sur votre passage : Étain (65, vert), Argent (75, vert), Fer (125, orange). Faites le tour des points de passage jusqu'à {skill:186} 155. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 18-30.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "Minez tous les gisements sur votre passage : Étain (65, vert), Argent (75, vert), Fer (125, orange). Faites le tour des points de passage jusqu'à {skill:186} 155. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 30-40.",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "Minez tous les gisements sur votre passage : {object:147516} (230, jaune), Vrai-argent (230, jaune), Petit thorium (245, jaune), Riche thorium (275, orange). Faites le tour des points de passage jusqu'à {skill:186} 300. Fondez le minerai à une forge quand vos sacs sont pleins : la fonte augmente aussi {skill:186}. Niveau de zone 50-58.",
	-- ["Rich Thorium: {zone:1428} (275-300)"] = "Riche thorium : {zone:1428} (275-300)",
	-- ["Silver, Tin"] = "Argent, Étain",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "Étain et Argent : {zone:1413} (65-125)",
	-- ["Tin & Silver: {zone:1424} (65-125)"] = "Étain et Argent : {zone:1424} (65-125)",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "Étain et Argent : {zone:1433} (65-125)",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "Étain et Argent : {zone:1439} (65-125)",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "Vrai-argent et Petit thorium : {zone:1419} (245-275)",
	-- ["Truesilver, {object:147516}"] = "Vrai-argent, {object:147516}",
	-- ["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516} et Vrai-argent : {zone:1427} (230-245)",
	-- ["{object:147516}, Gold"] = "{object:147516}, Or",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}, Riche thorium",
}
