-- French (frFR): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {zone:1450} Moonglade
	["Cast Teleport: {zone:1450}"] = "",

	-- Step 2: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast Teleport: {zone:1450}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885} : assemblez les deux moitiés",

	-- Step 4: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Prenez le portail qui monte à l'{area:1658}, puis retournez en vol à {area:442}.",

	-- Step 6: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 7: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "Vers {zone:1457}",

	-- Step 11: Boat to Auberdine
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then head south along the road through {zone:1439}."] = "Au {area:17203}, prenez le bateau pour {area:442} ; {npc:3649} se tient au nord du village. Suivez ensuite la route vers le sud à travers {zone:1439}.",
	-- {npc:3649} Thundris Windweaver · {zone:1453} Stormwind
	["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649} : la réponse d'Alexston, si vous l'avez prise à {zone:1453}",

	-- Step 12: Kerlonian Evershade
	-- {area:448} Grove of the Ancients · {zone:1439} Darkshore · {item:13536} Horn of Awakening · {area:331} Ashenvale · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {area:331} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep.\nCareful: Scripted ambushes of three mobs each attack along the road: furbolgs on the {zone:1439} stretch and undead nearer {area:413}."] = "Kerlonian dort au {area:448}, dans le sud de {zone:1439}. Utilisez le {item:13536} pour le réveiller et menez-le vers le sud par la route jusqu'en {area:331}, auprès de {npc:11219} au {area:413} ; sonnez à nouveau du cor chaque fois qu'il s'endort.\nAttention : des embuscades scriptées de trois monstres chacune attaquent le long de la route : des furbolgs sur le tronçon de {zone:1439} et des morts-vivants plus près du {area:413}.",
	-- {object:176634} Kerlonian's Chest
	["{object:176634}, beside him"] = "{object:176634}, à côté de lui",
	-- {area:413} Maestra's Post · {area:331} Ashenvale
	["Escort Kerlonian to {area:413} in {area:331}."] = "Escortez Kerlonian jusqu'au {area:413}, en {area:331}.",

	-- Step 15: Bathran's Haunt: kill these as you meet them
	-- {area:411} Bathran's Haunt
	["{area:411}: kill these as you meet them"] = "{area:411} : tuez-les au passage",
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Au nord du Poste de Maestra, des bottes de plantes jonchent les ruines du {area:411}. Des Sectateurs de la Rive noire occupent les ruines juste au sud : n'importe lequel peut laisser tomber {item:5366}.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, sur les bottes de plantes",

	-- Step 17: Astranaar
	-- {npc:3970} Llana · {npc:1480} Caitlin Grassman
	["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide; inside"] = "{npc:3970} : pour {npc:1480} à Menethil, à la fin de ce guide ; à l'intérieur",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, à l'auberge",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, à l'intérieur",

	-- Step 18: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} et ses marcheurs du Vide occupent {area:412}, au sud du sanctuaire. Attirez d'abord ses gardes.",

	-- Step 19: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria et {npc:3901}",
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["The two stand together at the western end of the road.\nSouth of the murlocs, {npc:3585} waits at the {area:416}."] = "Les deux se tiennent ensemble à l'extrémité ouest de la route.\nAu sud des murlocs, {npc:3585} attend au {area:416}.",

	-- Step 20: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Allez vers l'ouest jusqu'à la rive du {area:441}. Teronis gît parmi les murlocs Crache-sel ; n'importe quel murloc peut lâcher {item:5463}.",

	-- Step 21: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Longez la côte vers le nord jusqu'à la {area:414}. {npc:3846} campe sur la plage ; les nagas Irequeue grouillent sur le rivage.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, dans les ruines du rivage",

	-- Step 23: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} arpente la pointe nord de la {area:414} avec des gardes Irequeue.",

	-- Step 26: Hearth to Astranaar
	-- {area:415} Astranaar
	["Hearth to {area:415}"] = "Pierre de foyer vers {area:415}",

	-- Step 28: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "{npc:3987} (niveau 25) dirige les furbolgs Crin-de-Chardon du camp au nord d'{area:415}. Éliminez d'abord ses gardes, un par un.\nAttention : les furbolgs proches de lui se joignent généralement au combat quand vous l'attirez. Tuer d'abord ceux qui sont sur son chemin vous permet de l'affronter seul.",

	-- Step 29: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn · {area:415} Astranaar
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell.\nThe moonwell lies in the hills north-east of {area:415}."] = "Suivez la route vers l'est jusqu'au {area:419} ; {npc:3916} se tient près du puits de lune.\nLe puits de lune se trouve dans les collines au nord-est d'{area:415}.",

	-- Step 30: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "Les larmes brillent sur le petit îlot à l'est d'{area:415}.",

	-- Step 32: The Foulweald
	["The Foulweald"] = "Les Vile-sylve",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Les furbolgs Vile-sylve vivent dans les bois au sud de la route, au sud-est d'{area:415}. Les Protecteurs et les Ursa Vile-sylve gardent la tanière.",

	-- Step 33: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} se tient au {area:420}, sur la rive est du {area:421} ; {npc:210995} campe sur sa rive ouest. Des Elémentaires d’eau souillés pataugent dans le lac entre les deux.",
	["Underwater"] = "Sous l'eau",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Tuez les élémentaires pour 5 Bracelets élémentaires intacts ({item:12220}), puis utilisez {item:5456}",

	-- Step 34: Alonso
	-- {npc:210995} Alonso · {area:1276} The Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "{npc:210995} ne propose peut-être pas ces quêtes à toutes les classes ; sinon, continuez. ; il patrouille autour du {area:1276} : la carte indique où chercher",

	-- Step 35: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "À l'ouest du Lac Mystral, les buissons couverts de poussière d'étoile poussent parmi les ruines.",

	-- Step 38: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "{npc:4276} creuse dans {area:2160}, à l'extrémité est du pic. Parlez-lui et repoussez les pillards de la KapitalRisk pendant qu'il mine.\nAttention : les kobolds arrivent par vagues. La première vague se compose de combattants au corps à corps, la deuxième y ajoute des lanceurs de sorts. Les monstres normaux de la mine réapparaissent vite et peuvent se joindre au combat pendant les vagues. Un groupe est recommandé.",
	["Below ground"] = "Sous terre",

	-- Step 39: Windshear Crag
	-- {area:421} Mystral Lake · {area:1276} The Talondeep Path · {area:461} Windshear Crag · {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Allez au sud après le {area:421}, dans le tunnel du {area:1276} ; il débouche sur le {area:461}, dans les Serres-Rocheuses. {npc:4080} et {npc:4077} campent sur le {area:1076}, au sud-ouest du pic.",

	-- Step 40: Webwinder Path
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}, à l'intérieur",

	-- Step 41: Windshear Crag
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, in the hut north of them; inside"] = "{npc:4201}, dans la hutte au nord ; à l'intérieur",

	-- Step 42: Windshear Crag: kill these as you meet them
	-- {area:461} Windshear Crag
	["{area:461}: kill these as you meet them"] = "{area:461} : tuez-les au passage",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "La KapitalRisk rase la forêt de la {area:461}. Déboiseurs et Défricheurs y travaillent partout ; les Opérateurs pilotent les déchiqueteuses et l'un d'eux porte les plans.",

	-- Step 43: Webwinder Path
	["Inside"] = "À l'intérieur",

	-- Step 45: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Maître de vol d'{area:415}",

	-- Step 46: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 47: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "Vers {area:150}",

	-- Step 48: Menethil Harbor
	-- {npc:5082} Vincent Hyal · {npc:1480} Caitlin Grassman · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:5082}, Mikhail and Tapoke Jahn are all at Menethil's inn; Tapoke fights you when you talk to Mikhail, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn.\n{npc:2104} stands in {area:2103}, a short walk from {npc:1242}.\n{npc:2104} stands in {area:2103}."] = "{npc:5082}, Mikhail et Tapoke Jahn sont tous à l'auberge de Menethil ; Tapoke vous attaque quand vous parlez à Mikhail, mais abandonne une fois battu. {npc:1480} se tient à quelques pas au nord-est de l'auberge.\n{npc:2104} se tient dans {area:2103}, à quelques pas de {npc:1242}.\n{npc:2104} se tient dans {area:2103}.",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, sur la jetée au nord de l'auberge",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242} : pour {npc:2104}, dans le donjon",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "{npc:1217}, à l'étage de l'auberge",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, à l'auberge",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "{npc:1480}, à l'intérieur",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}, près de la porte nord",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "{npc:2086}, près du donjon ; à l'intérieur",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "{npc:2104}, au dernier étage",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Pour Bolvar Fordragon, dans le {object:2117} : gardez-la",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "{npc:2104}, près du donjon",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "{npc:2096} : il ne propose pas la 305 tant que vous l'avez sur vous",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, près de la porte nord",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}, près de la porte nord",

	-- Step 49: Sida's Bag on the way
	-- {item:3349} Sida's Bag
	["{item:3349} on the way"] = "{item:3349} en chemin",

	-- Step 50: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Des piles de bois et de fer sont éparpillées autour du donjon et le long des murs du port.",

	-- Step 51: James Halloran
	-- {npc:2094} James Halloran
	["{npc:2094} stands by the north gate."] = "{npc:2094} se tient près de la porte nord.",

	-- Step 52: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Sortez de Menethil en longeant la côte vers le nord. Les Murlocs Branchie-bleue grouillent dans le marais ; {npc:1259} se promène avec un groupe en son milieu.",

	-- Step 54: Young crocolisks
	["Young crocolisks"] = "Jeunes crocilisques",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Suivez la route vers l'est. Des Jeunes crocilisques des Paluns ({npc:1417}) rôdent dans les mares au nord du site de fouilles.",

	-- Step 55: The Bluegill hovels
	["The Bluegill hovels"] = "Les huttes des Branchie-bleue",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Trois conteneurs dans les huttes des murlocs, du sud au nord : {object:261}, puis {object:142151}, puis {object:259} à l'extrémité nord.",

	-- Step 56: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "Le site de fouilles se trouve sur la colline au sud de la route.",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "{npc:1076}, sous terre",
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground"] = "Une nouvelle {item:279996}, pour les quatre gardiens titans autour des {zone:1437} ; sous terre",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Pour {npc:2916} à {zone:1455}, à la fin de ce guide",

	-- Step 57: The raptor hills
	["The raptor hills"] = "Les collines des raptors",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "Des Raptors tachetés et des Hurleurs tachetés parcourent les collines à l'ouest du site de fouilles.\nAttention : quand un {npc:1021} tombe à 30 % de vie, il appelle à l'aide les créatures dans un rayon de 20 m. Les Hurleurs tachetés vont souvent par trois, et les raptors attirés par leurs appels peuvent aussi se joindre au combat.",

	-- Step 59: Raptor valley
	["Raptor valley"] = "La vallée des raptors",
	["The bigger raptors hunt in the valley just west of the dig."] = "Les plus gros raptors chassent dans la vallée juste à l'ouest des fouilles.",

	-- Step 61: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} campe au bord de la route ; {npc:1244} se tient plus à l'est, près de la rivière.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244} : {quest:98283}, un raptor élite",

	-- Step 62: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Les Traqueuses des grottes et les Traqueuses sanguines peuplent le {area:1021}, la grotte au sud-est des excavations.",

	-- Step 63: The Mosshide gnolls
	["The Mosshide gnolls"] = "Les gnolls Poil-moussu",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Les Gnolls Poil-moussu et les Bâtards Poil-moussu occupent les collines au sud-est de {area:1025}.",

	-- Step 65: Wetlands: kill these as you meet them
	-- {zone:1437} Wetlands
	["{zone:1437}: kill these as you meet them"] = "{zone:1437} : tuez-les au passage",
	-- {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Monstrous Oozes = {npc:1033} Monstrous Ooze · Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag.\nMosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Des Limons noirs, des Limons cramoisis et des Limons monstrueux remplissent {area:309}, juste à l'ouest de la route de {area:205} et au nord du camp d'Einar. N'importe quel limon peut avoir le sac de {npc:2111}.\nDes Paludiers Poil-moussu et des Tisseurs de brumes Poil-moussu parcourent les berges juste à l'ouest et au sud de {npc:1244} ; presque tous lâchent du silex.",

	-- Step 67: The Green Belt: kill these as you meet them
	-- {area:1025} The Green Belt
	["{area:1025}: kill these as you meet them"] = "{area:1025} : tuez-les au passage",
	-- {area:1025} The Green Belt · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw · Fen Creepers = {npc:1040} Fen Creeper
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised.\nFen Creepers hide in the marsh pools north-west of the {area:1025}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "Des dragonnets rouges remplissent les collines à l'ouest des portes, des Griffes pourries affolées occupent {area:1025}, des Tranchegueules les pentes nord ; Neru se tient au nord-est (utilisez la {item:279996}).\n{quest:98283} est élite : il est conseillé de se grouper.\nDes Rampants des tourbières se cachent dans les mares du marais au nord-ouest de {area:1025}.\nAttention : hors combat, les Rampants des tourbières lancent Camouflage de temps en temps : ils sont furtifs et difficiles à voir.",

	-- Step 69: Hearth to Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["Hearth to {area:2104}"] = "Pierre de foyer vers {area:2104}",

	-- Step 71: Menethil
	["Menethil"] = "Menethil",
	-- {npc:2092} Pilot Longbeard · {zone:1455} Ironforge · {area:836} Dun Algaz
	["{npc:2092}'s quest in {zone:1455} needs level 28. If you are short of it after these hand-ins, grind the Dragonmaw orcs at the camps along the road east to {area:836} before you go on."] = "La quête de {npc:2092} à {zone:1455} demande le niveau 28. S'il vous manque après ces rendus, tuez des orcs Dragonmaw dans les camps le long de la route vers l'est jusqu'à {area:836} avant de continuer.",
	["For the giant crocolisks of the north coast, on your next visit"] = "Pour les crocilisques géants de la côte nord, lors de votre prochaine visite",

	-- Step 72: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "Vers le {zone:1432}",

	-- Step 73: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "Vers {zone:1426}",

	-- Step 74: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "Vers {zone:1455}",

	-- Step 76: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Head east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Suivez la route des {zone:1437} vers l'est, passez au sud par {area:836} jusqu'au {zone:1432}, puis à l'ouest par le tunnel jusqu'à {zone:1426} et {area:1537}.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, à {object:32372}",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Seulement avec {item:5352} de {zone:1439} : {npc:2786}, {object:32383}",

	-- Step 77: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 78: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn Two-Handed Maces from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 79: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 80: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Prêtres d'{zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} et {npc:258785} sont dans le {object:32386}, dans {object:32362}.",

	-- Step 81: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",

	-- Step 82: Cathedral of Light
	["Cathedral of Light"] = "Cathédrale de la Lumière",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Prenez le {area:2257} de {object:171524} jusqu'au {object:28027} de {zone:1453}, puis marchez jusqu'à la {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, dans la Cathédrale de la Lumière",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Pour {npc:2228} à {area:271} : gardez-la",

	-- Step 83: Cathedral of Light
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}, sur la {object:2098}",

	-- Step 84: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}, dans la Bibliothèque royale",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Seulement si vous avez ramassé {quest:337} à {zone:1431}",

	-- Step 86: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164} se trouve dans le {object:2101}.",

	-- Step 87: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} et {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la fromagerie du {object:2096}",

	-- Step 88: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Ensuite : volez jusqu'à {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "Retournez à la Cathédrale de la Lumière : {npc:928} se tient à l'intérieur.",
	-- ["Black Oozes"] = "Limons noirs",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Les Limons noirs rampent dans le marais au nord de la route de {area:1025}, à l'ouest du camp d'{npc:2093}. N'importe quel limon peut détenir le sac de {npc:2111}.",
	-- ["Cast {spell:18960}"] = "Lancez {spell:18960}",
	-- ["Dragonmaw camp"] = "Camp Dragonmaw",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "Escortez Kerlonian jusqu'au {area:413}, en {zone:1440}.",
	-- ["Fen Creepers"] = "Rampants des tourbières",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Les Rampants des tourbières se cachent dans les mares du marais au nord-ouest de {area:1025}.",
	-- ["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Longez la côte vers le nord jusqu'à {area:414}. {npc:3846} campe sur la plage ; les nagas Irequeue grouillent sur le rivage.",
	-- ["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Suivez la route vers l'est jusqu'au Val hurlant ({area:419}) ; {npc:3916} se tient près du puits de lune.",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Suivez la route vers le nord jusqu'à {area:205}, au pied du {area:881}. {npc:1071} se tient dans le camp des nains.",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "Suivez la route vers le sud-est jusqu'à {area:415}, sur l'île au milieu du lac.",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "À {area:17203}, prenez le bateau pour {area:442} ; {npc:3649} se tient à l'extrémité nord du village. Suivez ensuite la route vers le sud à travers {zone:1439}.",
	-- ["Hearth to Menethil"] = "Pierre de foyer vers Menethil",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Pierre de foyer en recharge ? Revenez vers le nord par {area:1276}.",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Kerlonian dort au {area:448}, dans le sud de {zone:1439}. Utilisez {item:13536} pour le réveiller et conduisez-le vers le sud par la route jusqu'en {zone:1440}, auprès de {npc:11219} au {area:413} ; sonnez à nouveau du cor chaque fois qu'il s'endort.",
	-- ["Kill the elementals for 5 Intact {quest:1016}, then use the {item:5456}"] = "Tuez les élémentaires pour obtenir 5 Bracelets élémentaires intacts ({quest:1016}), puis utilisez {item:5456}",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Les Paludiers Poil-moussu et les Tisseurs de brumes Poil-moussu parcourent les berges juste à l'ouest et au sud de {npc:1244} ; presque tous laissent tomber du silex.",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Les Raptors tachetés et les Hurleurs tachetés parcourent les collines à l'ouest des excavations.",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Suivez vers l'est la route qui traverse {zone:1437}, puis vers le sud par {area:836} jusqu'au {zone:1432}, et vers l'ouest par le tunnel jusqu'à {zone:1426} et {area:1537}.",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Allez vers le sud après le {area:421} et entrez dans le tunnel de {area:1276} ; il débouche sur la {area:461}, dans les Serres-Rocheuses. {npc:4080} et {npc:4077} campent sur le {area:1076}, au sud-ouest de la combe.",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Allez vers l'ouest jusqu'à la rive du {area:441}. Teronis gît parmi les murlocs Crache-sel ; n'importe quel murloc peut laisser tomber {item:5463}.",
	-- ["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Au sud des murlocs, {npc:3585} attend au sanctuaire : {area:416}.",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Prenez le bateau de {area:17203} à {area:442} et volez jusqu'à {area:702} ; {npc:11401} est dans le Temple de la Lune. Retournez ensuite en vol à {area:442}.",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast Teleport: {zone:1450}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Prenez le bateau de {area:17203} à {area:442}. Assemblez les deux moitiés de pendentif pour obtenir {item:15885} et lancez Téléportation : {zone:1450} : {npc:11802} se trouve à {area:2361}. Volez ensuite jusqu'à {area:702} (en passant par {area:442}).",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Prenez le bateau de {area:17203} à {area:442}. Assemblez les deux moitiés de pendentif pour obtenir {item:15885} et lancez {spell:18960} : {npc:11802} est à {area:2361}. Puis volez jusqu'à {area:702} (en passant par {area:442}).",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "Prenez le bateau du {area:17203} pour {area:442}. Assemblez les deux demi-pendentifs en {item:15885} et lancez {spell:18960} : {npc:11802} est à {area:2361}. Ensuite, {npc:11800}, à {area:2361}, emmène les Druides en vol directement au {area:702}.",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "Le camp Dragonmaw se trouve au sud de la route, juste à l'ouest de {area:1025} : Ecumeurs, Arpenteurs et Gardiens. La quête de {npc:2092} à {zone:1426} demande le niveau 28.",
	-- ["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. {area:364} Watcher and the Ursas guard the den."] = "Les furbolgs Vile-sylve vivent dans les bois au sud de la route, au sud-est d'{area:415}. Le Protecteur et les Ursa gardent {area:364}.",
	-- ["The excavation site sits on the hill south of the road."] = "Les excavations se trouvent sur la colline au sud de la route.",
	-- ["The raptor hills"] = "Les collines des raptors",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Venture Co. loggers"] = "Déboiseurs de la KapitalRisk",
	-- ["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Paladin le plus vite.",
	-- ["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",
	-- ["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:199} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "tuez en boucle des Ecumeurs Dragonmaw et des Arpenteurs Dragonmaw au camp Dragonmaw ({zone:1437})",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}, près du donjon",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} se tient dans le {area:2103}, à quelques pas de {npc:1242}.",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649} : la réponse d'Alexston",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) commande les gnolls Crin-de-Chardon au camp situé au nord d'{area:415}. Éliminez d'abord ses gardes, un par un.",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}, dans la cabane au nord",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} creuse dans la {area:2160}, à l'extrémité est de la combe. Parlez-lui et repoussez les pillards de la KapitalRisk pendant qu'il creuse.",
	-- ["{object:176364} Harbor"] = "{object:176364}",
	-- ["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} arpente la pointe nord de {area:414} avec des gardes Irequeue.",
}
