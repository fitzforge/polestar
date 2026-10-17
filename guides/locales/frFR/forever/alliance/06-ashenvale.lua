-- French (frFR): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Prenez le bateau de {area:17203} à {area:442}. Assemblez les deux moitiés de pendentif pour obtenir {item:15885} et lancez {spell:18960} : {npc:11802} est à {area:2361}. Puis volez jusqu'à {area:702} (en passant par {area:442}).",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885} : assemblez les deux moitiés",

	-- Step 2: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Prenez le portail qui monte à l'{area:1658}, puis retournez en vol à {area:442}.",

	-- Step 3: Elune's Grace
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:11401} Priestess Alathea
	["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Prenez le bateau de {area:17203} à {area:442} et volez jusqu'à {area:702} ; {npc:11401} est dans le Temple de la Lune. Retournez ensuite en vol à {area:442}.",

	-- Step 4: Boat to Auberdine
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "À {area:17203}, prenez le bateau pour {area:442} ; {npc:3649} se tient à l'extrémité nord du village. Suivez ensuite la route vers le sud à travers {zone:1439}.",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}: Alexston's reply"] = "{npc:3649} : la réponse d'Alexston",

	-- Step 5: Kerlonian Evershade
	-- {area:448} Grove of the Ancients · {zone:1439} Darkshore · {item:13536} Horn of Awakening · {zone:1440} Ashenvale · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Kerlonian dort au {area:448}, dans le sud de {zone:1439}. Utilisez {item:13536} pour le réveiller et conduisez-le vers le sud par la route jusqu'en {zone:1440}, auprès de {npc:11219} au {area:413} ; sonnez à nouveau du cor chaque fois qu'il s'endort.",
	-- {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Escort Kerlonian to {area:413} in {zone:1440}."] = "Escortez Kerlonian jusqu'au {area:413}, en {zone:1440}.",

	-- Step 7: Bathran's Haunt
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Au nord du Poste de Maestra, des bottes de plantes jonchent les ruines du {area:411}. Des Sectateurs de la Rive noire occupent les ruines juste au sud : n'importe lequel peut laisser tomber {item:5366}.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, sur les bottes de plantes",

	-- Step 9: Astranaar
	-- {area:415} Astranaar
	["Follow the road south-east to {area:415}, on the island in the lake."] = "Suivez la route vers le sud-est jusqu'à {area:415}, sur l'île au milieu du lac.",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, à l'auberge",

	-- Step 10: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Allez vers l'ouest jusqu'à la rive du {area:441}. Teronis gît parmi les murlocs Crache-sel ; n'importe quel murloc peut laisser tomber {item:5463}.",

	-- Step 11: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Au sud des murlocs, {npc:3585} attend au sanctuaire : {area:416}.",

	-- Step 12: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} et ses marcheurs du Vide occupent {area:412}, au sud du sanctuaire. Attirez d'abord ses gardes.",

	-- Step 13: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Longez la côte vers le nord jusqu'à la {area:414}. {npc:3846} campe sur la plage ; les nagas Irequeue grouillent sur le rivage.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, dans les ruines du rivage",

	-- Step 15: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} arpente la pointe nord de la {area:414} avec des gardes Irequeue.",

	-- Step 19: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) commande les gnolls Crin-de-Chardon au camp situé au nord d'{area:415}. Éliminez d'abord ses gardes, un par un.",

	-- Step 20: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "Les larmes brillent sur le petit îlot à l'est d'{area:415}.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Suivez la route vers l'est jusqu'au Val hurlant ({area:419}) ; {npc:3916} se tient près du puits de lune.",

	-- Step 23: The Foulweald
	["The Foulweald"] = "Les Vile-sylve",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Les furbolgs Vile-sylve vivent dans les bois au sud de la route, au sud-est d'{area:415}. Les Protecteurs et les Ursa Vile-sylve gardent la tanière.",

	-- Step 24: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} se tient au {area:420}, sur la rive est du {area:421} ; {npc:210995} campe sur sa rive ouest. Des Elémentaires d’eau souillés pataugent dans le lac entre les deux.",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Tuez les élémentaires pour 5 Bracelets élémentaires intacts ({item:12220}), puis utilisez {item:5456}",

	-- Step 25: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "À l'ouest du Lac Mystral, les buissons couverts de poussière d'étoile poussent parmi les ruines.",

	-- Step 27: Windshear Crag
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Allez vers le sud après le {area:421} et entrez dans le tunnel de {area:1276} ; il débouche sur la {area:461}, dans les Serres-Rocheuses. {npc:4080} et {npc:4077} campent sur le {area:1076}, au sud-ouest de la combe.",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, in the hut north of them"] = "{npc:4201}, dans la cabane au nord",

	-- Step 28: Venture Co. loggers
	["Venture Co. loggers"] = "Déboiseurs de la KapitalRisk",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "La KapitalRisk rase la forêt de la {area:461}. Déboiseurs et Défricheurs y travaillent partout ; les Opérateurs pilotent les déchiqueteuses et l'un d'eux porte les plans.",

	-- Step 29: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} creuse dans la {area:2160}, à l'extrémité est de la combe. Parlez-lui et repoussez les pillards de la KapitalRisk pendant qu'il creuse.",

	-- Step 31: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "Vers {area:150}",
	-- {area:1276} Talondeep Path
	["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Pierre de foyer en recharge ? Revenez vers le nord par {area:1276}.",
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 32: Menethil Harbor
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, sur la jetée au nord de l'auberge",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, à l'auberge",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep"] = "{npc:2086}, près du donjon",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}, près de la porte nord",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}, près de la porte nord",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, près de la porte nord",

	-- Step 33: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Des piles de bois et de fer sont éparpillées autour du donjon et le long des murs du port.",

	-- Step 35: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Sortez de Menethil en longeant la côte vers le nord. Les Murlocs Branchie-bleue grouillent dans le marais ; {npc:1259} se promène avec un groupe en son milieu.",

	-- Step 37: The Bluegill hovels
	["The Bluegill hovels"] = "Les huttes des Branchie-bleue",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Trois conteneurs dans les huttes des murlocs, du sud au nord : {object:261}, puis {object:142151}, puis {object:259} à l'extrémité nord.",

	-- Step 38: Karl Boran
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242} : pour {npc:2104}, dans le donjon",

	-- Step 39: Captain Stoutfist
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} se tient dans le {area:2103}, à quelques pas de {npc:1242}.",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Pour Bolvar Fordragon, dans le {object:2117} : gardez-la",

	-- Step 40: Young crocolisks
	["Young crocolisks"] = "Jeunes crocilisques",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Suivez la route vers l'est. Des Jeunes crocilisques des Paluns ({npc:1417}) rôdent dans les mares au nord du site de fouilles.",

	-- Step 41: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "Les excavations se trouvent sur la colline au sud de la route.",

	-- Step 42: The raptor hills
	["The raptor hills"] = "Les collines des raptors",
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor
	["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Les Raptors tachetés et les Hurleurs tachetés parcourent les collines à l'ouest des excavations.",

	-- Step 44: Raptor valley
	["Raptor valley"] = "La vallée des raptors",
	["The bigger raptors hunt in the valley just west of the dig."] = "Les plus gros raptors chassent dans la vallée juste à l'ouest des fouilles.",

	-- Step 46: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Les Traqueuses des grottes et les Traqueuses sanguines peuplent le {area:1021}, la grotte au sud-est des excavations.",

	-- Step 47: Black Oozes
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes"] = "Limons noirs",
	-- {area:1025} Green Belt · {npc:2093} Einar Stonegrip · {npc:2111} Sida
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Les Limons noirs rampent dans le marais au nord de la route de {area:1025}, à l'ouest du camp d'{npc:2093}. N'importe quel limon peut détenir le sac de {npc:2111}.",

	-- Step 48: Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} campe au bord de la route ; {npc:1244} se tient plus à l'est, près de la rivière.",

	-- Step 49: The Mosshide gnolls
	["The Mosshide gnolls"] = "Les gnolls Poil-moussu",
	-- {area:1025} Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Les Gnolls Poil-moussu et les Bâtards Poil-moussu occupent les collines au sud-est de {area:1025}.",

	-- Step 51: Crude Flint
	-- {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Les Paludiers Poil-moussu et les Tisseurs de brumes Poil-moussu parcourent les berges juste à l'ouest et au sud de {npc:1244} ; presque tous laissent tomber du silex.",

	-- Step 53: Fen Creepers
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers"] = "Rampants des tourbières",
	-- {area:1025} Green Belt
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Les Rampants des tourbières se cachent dans les mares du marais au nord-ouest de {area:1025}.",

	-- Step 54: Dun Modr
	-- {area:205} Dun Modr · {area:881} Thandol Span · {npc:1071} Longbraid the Grim
	["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Suivez la route vers le nord jusqu'à {area:205}, au pied du {area:881}. {npc:1071} se tient dans le camp des nains.",

	-- Step 56: Dragonmaw camp
	["Dragonmaw camp"] = "Camp Dragonmaw",
	-- {area:1025} Green Belt · {npc:2092} Pilot Longbeard · {zone:1426} Dun Morogh
	["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "Le camp Dragonmaw se trouve au sud de la route, juste à l'ouest de {area:1025} : Ecumeurs, Arpenteurs et Gardiens. La quête de {npc:2092} à {zone:1426} demande le niveau 28.",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Raiders = {npc:1034} Dragonmaw Raider
	["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "tuez en boucle des Ecumeurs Dragonmaw et des Arpenteurs Dragonmaw au camp Dragonmaw ({zone:1437})",

	-- Step 57: Hearth to Menethil
	["Hearth to Menethil"] = "Pierre de foyer vers Menethil",
	["For the giant crocolisks of the north coast, on your next visit"] = "Pour les crocilisques géants de la côte nord, lors de votre prochaine visite",

	-- Step 58: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Suivez vers l'est la route qui traverse {zone:1437}, puis vers le sud par {area:836} jusqu'au {zone:1432}, et vers l'ouest par le tunnel jusqu'à {zone:1426} et {area:1537}.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, à {object:32372}",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Seulement avec {item:5352} de {zone:1439} : {npc:2786}, {object:32383}",

	-- Step 59: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Prêtres d'{zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} et {npc:258785} sont dans le {object:32386}, dans {object:32362}.",

	-- Step 60: Cathedral of Light
	["Cathedral of Light"] = "Cathédrale de la Lumière",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Prenez le {area:2257} de {object:171524} jusqu'au {object:28027} de {zone:1453}, puis marchez jusqu'à la {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, dans la Cathédrale de la Lumière",
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}, sur la {object:2098}",

	-- Step 61: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}, dans la Bibliothèque royale",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Seulement si vous avez ramassé {quest:337} à {zone:1431}",

	-- Step 62: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "Retournez à la Cathédrale de la Lumière : {npc:928} se tient à l'intérieur.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Pour {npc:2228} à {area:271} : gardez-la",

	-- Step 63: Mage Quarter
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164} se trouve dans le {object:2101}.",

	-- Step 64: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} et {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la fromagerie du {object:2096}",

	-- Step 65: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Ensuite : volez jusqu'à {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Longez la côte vers le nord jusqu'à {area:414}. {npc:3846} campe sur la plage ; les nagas Irequeue grouillent sur le rivage.",
	-- ["Kill the elementals for 5 Intact {quest:1016}, then use the {item:5456}"] = "Tuez les élémentaires pour obtenir 5 Bracelets élémentaires intacts ({quest:1016}), puis utilisez {item:5456}",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast Teleport: {zone:1450}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Prenez le bateau de {area:17203} à {area:442}. Assemblez les deux moitiés de pendentif pour obtenir {item:15885} et lancez Téléportation : {zone:1450} : {npc:11802} se trouve à {area:2361}. Volez ensuite jusqu'à {area:702} (en passant par {area:442}).",
	-- ["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. {area:364} Watcher and the Ursas guard the den."] = "Les furbolgs Vile-sylve vivent dans les bois au sud de la route, au sud-est d'{area:415}. Le Protecteur et les Ursa gardent {area:364}.",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["{object:176364} Harbor"] = "{object:176364}",
	-- ["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} arpente la pointe nord de {area:414} avec des gardes Irequeue.",
}
