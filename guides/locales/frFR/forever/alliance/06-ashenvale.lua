-- French (frFR): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kerlonian Evershade
	-- {area:442} Auberdine · {area:448} Grove of the Ancients · {npc:11218} Kerlonian Evershade · {item:13536} Horn of Awakening · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Back north from the glaive (Druids: south along the road from {area:442}) to the {area:448}, where {npc:11218} sleeps beside Arbal. Take his quest, open his chest for the {item:13536}, use it to wake him and lead him south along the road to his bag at the southern edge of {zone:1439}; blow the horn again whenever he falls asleep. Then go on to {npc:11219} at {area:413}.\nCareful: Scripted ambushes of three mobs each attack along the road."] = "",
	-- {object:176634} Kerlonian's Chest
	["{object:176634}, beside him"] = "{object:176634}, à côté de lui",
	-- {npc:11218} Kerlonian Evershade · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Escort {npc:11218} south along the road to his bag at the southern edge of {zone:1439}, then go on to {npc:11219} at {area:413}."] = "",

	-- Step 4: Bathran's Haunt: kill these as you meet them
	-- {area:411} Bathran's Haunt
	["{area:411}: kill these as you meet them"] = "{area:411} : tuez-les au passage",
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Au nord du Poste de Maestra, des bottes de plantes jonchent les ruines du {area:411}. Des Sectateurs de la Rive noire occupent les ruines juste au sud : n'importe lequel peut laisser tomber {item:5366}.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, sur les bottes de plantes",

	-- Step 6: Astranaar
	-- {area:413} Maestra's Post · {npc:3845} Shindrell Swiftfire · {npc:4079} Sentinel Thenysil · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["The road from {area:413} comes in by the flight master: {npc:3845} and {npc:4079} stand there, {npc:3691} in the inn, {npc:3894} inside the building beyond it."] = "",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, à l'auberge",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {area:442} Auberdine
	["{npc:3691}: {quest:990}, from {area:442}"] = "",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, à l'intérieur",

	-- Step 7: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Allez vers l'ouest jusqu'à la rive du {area:441}. Teronis gît parmi les murlocs Crache-sel ; n'importe quel murloc peut lâcher {item:5463}.",

	-- Step 8: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Au sud des murlocs, {npc:3585} attend au sanctuaire : {area:416}.",

	-- Step 9: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "Les larmes brillent sur le petit îlot à l'est d'{area:415}.",

	-- Step 11: Stonetalon Mountains
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {area:2160} Windshear Mine
	["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}, north of the {area:2160}."] = "",

	-- Step 12: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} at the east end of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "",
	["Below ground"] = "Sous terre",
	-- {npc:4276} Piznik
	["Keep {npc:4276} alive while he mines, below ground"] = "",

	-- Step 13: Windshear Crag
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["{npc:4080} and {npc:4077} camp on the {area:1076}, south-west of the mine."] = "",

	-- Step 14: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle
	["His hut stands just north of {npc:4080} and {npc:4077}."] = "",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}, à l'intérieur",

	-- Step 16: Windshear Crag: kill these as you meet them
	-- {area:461} Windshear Crag
	["{area:461}: kill these as you meet them"] = "{area:461} : tuez-les au passage",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "La KapitalRisk rase la forêt de la {area:461}. Déboiseurs et Défricheurs y travaillent partout ; les Opérateurs pilotent les déchiqueteuses et l'un d'eux porte les plans.",

	-- Step 17: Webwinder Path
	["Inside"] = "À l'intérieur",

	-- Step 18: The Ruins of Stardust
	-- {area:1276} Talondeep Path · {area:421} Mystral Lake
	["Back north through the {area:1276}: west of {area:421}, the stardust bushes grow among the ruins."] = "",

	-- Step 19: Alonso
	-- {npc:210995} Alonso · {area:1276} Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "{npc:210995} ne propose peut-être pas ces quêtes à toutes les classes ; sinon, continuez. ; il patrouille autour du {area:1276} : la carte indique où chercher",

	-- Step 20: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} se tient au {area:420}, sur la rive est du {area:421} ; {npc:210995} campe sur sa rive ouest. Des Elémentaires d’eau souillés pataugent dans le lac entre les deux.",
	["Underwater"] = "Sous l'eau",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Tuez les élémentaires pour 5 Bracelets élémentaires intacts ({item:12220}), puis utilisez {item:5456}",

	-- Step 21: The Foulweald
	["The Foulweald"] = "Les Vile-sylve",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Les furbolgs Vile-sylve vivent dans les bois au sud de la route, au sud-est d'{area:415}. Les Protecteurs et les Ursa Vile-sylve gardent la tanière.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Suivez la route vers l'est jusqu'au Val hurlant ({area:419}) ; {npc:3916} se tient près du puits de lune.",

	-- Step 23: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "{npc:3987} (niveau 25) dirige les furbolgs Crin-de-Chardon du camp au nord d'{area:415}. Éliminez d'abord ses gardes, un par un.\nAttention : les furbolgs proches de lui se joignent généralement au combat quand vous l'attirez. Tuer d'abord ceux qui sont sur son chemin vous permet de l'affronter seul.",

	-- Step 24: Ilkrud Magthrull
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar · {area:412} Ruins of Ordil'Aran · {npc:3664} Ilkrud Magthrull
	["From {npc:3987}'s camp head south-west past {area:415} (its hand-ins wait for the way back) to the {area:412} south of the shrine: {npc:3664} and his voidwalkers hold them. Pull his guards first."] = "",

	-- Step 25: The Zoram Strand
	-- {area:414} Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Longez la côte vers le nord jusqu'à la {area:414}. {npc:3846} campe sur la plage ; les nagas Irequeue grouillent sur le rivage.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, dans les ruines du rivage",
	-- {item:5490} Wrathtail Head
	["{item:5490}: any Wrathtail naga on the strand"] = "",

	-- Step 27: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} arpente la pointe nord de la {area:414} avec des gardes Irequeue.",

	-- Step 29: Maestra's Post
	-- {npc:3663} Delgren the Purifier · {zone:1440} Ashenvale
	["{npc:3663}: its circles are for your next {zone:1440} visit, at about 28"] = "",

	-- Step 30: Astranaar
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3845} Shindrell Swiftfire · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["Follow the road south-east from {area:413} back to {area:415}: {npc:3845} by the flight master, {npc:3691} in the inn, {npc:3894} inside."] = "",

	-- Step 31: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Maître de vol d'{area:415}",

	-- Step 32: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 33: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "Vers {area:150}",

	-- Step 34: Menethil Harbor
	-- {npc:1242} Karl Boran · {npc:2094} James Halloran · {npc:2086} Valstag Ironjaw · {npc:1239} First Mate Fitzsimmons · {npc:1480} Caitlin Grassman · {npc:2111} Sida · {npc:2096} Tarrel Rockweaver
	["Off the boat, walk up the pier: {npc:1242} on the pier, {npc:2094} by the docks to the north, {npc:2086} in the keep, the inn ({npc:1239}) east of it with {npc:1480} and {npc:2111} beside it, {npc:2096} by the north gate on the way out east."] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, sur la jetée au nord de l'auberge",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "{npc:2086}, près du donjon ; à l'intérieur",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, à l'auberge",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "{npc:2096} : il ne propose pas la 305 tant que vous l'avez sur vous",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, près de la porte nord",

	-- Step 35: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Des piles de bois et de fer sont éparpillées autour du donjon et le long des murs du port.",

	-- Step 36: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Sortez de Menethil en longeant la côte vers le nord. Les Murlocs Branchie-bleue grouillent dans le marais ; {npc:1259} se promène avec un groupe en son milieu.",

	-- Step 37: Young crocolisks
	["Young crocolisks"] = "Jeunes crocilisques",
	-- {zone:1437} Wetlands
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["From the marsh head east across the {zone:1437}. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "",

	-- Step 38: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "Le site de fouilles se trouve sur la colline au sud de la route.",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "{npc:1076}, sous terre",

	-- Step 39: The raptor hills
	["The raptor hills"] = "Les collines des raptors",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "Des Raptors tachetés et des Hurleurs tachetés parcourent les collines à l'ouest du site de fouilles.\nAttention : quand un {npc:1021} tombe à 30 % de vie, il appelle à l'aide les créatures dans un rayon de 20 m. Les Hurleurs tachetés vont souvent par trois, et les raptors attirés par leurs appels peuvent aussi se joindre au combat.",

	-- Step 40: Ormer Ironbraid
	-- {npc:1078} Ormer Ironbraid · {zone:1437} Wetlands
	["{npc:1078}: the bigger raptors in the valley west of the dig are for your next {zone:1437} visit, at about 27"] = "",

	-- Step 41: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} campe au bord de la route ; {npc:1244} se tient plus à l'est, près de la rivière.",

	-- Step 42: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Les Traqueuses des grottes et les Traqueuses sanguines peuplent le {area:1021}, la grotte au sud-est des excavations.",

	-- Step 43: The Mosshide gnolls
	["The Mosshide gnolls"] = "Les gnolls Poil-moussu",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Les Gnolls Poil-moussu et les Bâtards Poil-moussu occupent les collines au sud-est de {area:1025}.",

	-- Step 44: Rethiel the Greenwarden
	-- {area:309} Ironbeard's Tomb · {npc:1244} Rethiel the Greenwarden · {zone:1437} Wetlands
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Its flint comes from the Mosshide Fenrunners on the way to {area:309}; {npc:1244} takes it on your next {zone:1437} visit"] = "",

	-- Step 45: Ironbeard's Tomb
	-- {npc:1244} Rethiel the Greenwarden · {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner · Monstrous Oozes = {npc:1033} Monstrous Ooze
	["North-west from {npc:1244}: Mosshide Fenrunners and Mistweavers roam the riverbanks on the way, and almost every one drops flint. Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag."] = "",
	-- {item:2611} Crude Flint
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["{item:2611}: Mosshide Fenrunners and Mistweavers"] = "",

	-- Step 46: Menethil
	["Menethil"] = "Menethil",
	-- {npc:2096} Tarrel Rockweaver · {npc:2111} Sida · {npc:1480} Caitlin Grassman · {npc:2086} Valstag Ironjaw · {npc:2094} James Halloran · {npc:1242} Karl Boran
	["Back west along the road into Menethil: {npc:2096} by the road in, {npc:2111} and {npc:1480} at the inn, {npc:2086} in the keep, {npc:2094} on the west side by the docks, {npc:1242} on the pier north of the inn."] = "",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "{npc:1480}, à l'intérieur",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, in the keep"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier"] = "",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn: you have both flight paths since your first trip east."] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 48: Ironforge
	-- {object:32372} Great Forge · {npc:4081} Lomac Gearstrip · {object:171524} Tinker Town · {area:2257} Deeprun Tram
	["The gryphons land in the {object:32372}. {npc:4081} stands in {object:171524}, east of it, by the {area:2257}."] = "",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Seulement avec {item:5352} de {zone:1439} : {npc:2786}, {object:32383}",

	-- Step 49: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 50: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:199} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 51: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Paladin le plus vite.",

	-- Step 52: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",

	-- Step 53: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["The tram comes in at the {object:28027}; walk west to the {object:2098}: {npc:1646} stands at its east side. (The route hands his letter in at the end of 03-loch-modan; this is for a character still carrying it.)"] = "",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646} : la lettre de Thundris, d'{area:442}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, back in {area:442} (06-wetlands)"] = "",

	-- Step 54: Cathedral Square
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:376} High Priestess Laurena
	["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:376} is in the Cathedral of Light."] = "",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:11406}, à {zone:1455}",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:258785}, à {zone:1455}",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:11401}, à {zone:1457}",

	-- Step 55: Master Mathias Shaw
	-- {object:2100} Old Town
	["Mathias Shaw is at SI:7 in {object:2100}, south of the Keep."] = "",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}'s second loop"] = "",

	-- Step 56: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{object:2164} is in the {object:2101}. Warlocks: {npc:6122} is in its cellar."] = "",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122} : à rendre plus tard à {npc:6244}, dans {zone:1413}",

	-- Step 57: Trade District
	-- {zone:1453} Stormwind · {zone:1431} Duskwood
	["Next: training in {zone:1453}, then the road east through Elwynn and south to {zone:1431}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground"] = "Une nouvelle {item:279996}, pour les quatre gardiens titans autour des {zone:1437} ; sous terre",
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "Retournez à la Cathédrale de la Lumière : {npc:928} se tient à l'intérieur.",
	-- ["Black Oozes"] = "Limons noirs",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Les Limons noirs rampent dans le marais au nord de la route de {area:1025}, à l'ouest du camp d'{npc:2093}. N'importe quel limon peut détenir le sac de {npc:2111}.",
	-- ["Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag.\nMosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Des Limons noirs, des Limons cramoisis et des Limons monstrueux remplissent {area:309}, juste à l'ouest de la route de {area:205} et au nord du camp d'Einar. N'importe quel limon peut avoir le sac de {npc:2111}.\nDes Paludiers Poil-moussu et des Tisseurs de brumes Poil-moussu parcourent les berges juste à l'ouest et au sud de {npc:1244} ; presque tous lâchent du silex.",
	-- ["Cast {spell:18960}"] = "Lancez {spell:18960}",
	-- ["Cathedral of Light"] = "Cathédrale de la Lumière",
	-- ["Dragonmaw camp"] = "Camp Dragonmaw",
	-- ["Escort Kerlonian to {area:413} in {area:331}."] = "Escortez Kerlonian jusqu'au {area:413}, en {area:331}.",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "Escortez Kerlonian jusqu'au {area:413}, en {zone:1440}.",
	-- ["Fen Creepers"] = "Rampants des tourbières",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Les Rampants des tourbières se cachent dans les mares du marais au nord-ouest de {area:1025}.",
	-- ["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- ["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell.\nThe moonwell lies in the hills north-east of {area:415}."] = "Suivez la route vers l'est jusqu'au {area:419} ; {npc:3916} se tient près du puits de lune.\nLe puits de lune se trouve dans les collines au nord-est d'{area:415}.",
	-- ["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Suivez la route vers l'est. Des Jeunes crocilisques des Paluns ({npc:1417}) rôdent dans les mares au nord du site de fouilles.",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Suivez la route vers le nord jusqu'à {area:205}, au pied du {area:881}. {npc:1071} se tient dans le camp des nains.",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "Suivez la route vers le sud-est jusqu'à {area:415}, sur l'île au milieu du lac.",
	-- ["For Bolvar Fordragon in {object:2117}: keep it"] = "Pour Bolvar Fordragon, dans le {object:2117} : gardez-la",
	-- ["For the giant crocolisks of the north coast, on your next visit"] = "Pour les crocilisques géants de la côte nord, lors de votre prochaine visite",
	-- ["For {npc:2228} in {area:271}: keep it"] = "Pour {npc:2228} à {area:271} : gardez-la",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Pour {npc:2916} à {zone:1455}, à la fin de ce guide",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then head south along the road through {zone:1439}."] = "Au {area:17203}, prenez le bateau pour {area:442} ; {npc:3649} se tient au nord du village. Suivez ensuite la route vers le sud à travers {zone:1439}.",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "À {area:17203}, prenez le bateau pour {area:442} ; {npc:3649} se tient à l'extrémité nord du village. Suivez ensuite la route vers le sud à travers {zone:1439}.",
	-- ["Head east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Suivez la route des {zone:1437} vers l'est, passez au sud par {area:836} jusqu'au {zone:1432}, puis à l'ouest par le tunnel jusqu'à {zone:1426} et {area:1537}.",
	-- ["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Allez au sud après le {area:421}, dans le tunnel du {area:1276} ; il débouche sur le {area:461}, dans les Serres-Rocheuses. {npc:4080} et {npc:4077} campent sur le {area:1076}, au sud-ouest du pic.",
	-- ["Hearth to Menethil"] = "Pierre de foyer vers Menethil",
	-- ["Hearth to {area:2104}"] = "Pierre de foyer vers {area:2104}",
	-- ["Hearth to {area:415}"] = "Pierre de foyer vers {area:415}",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Pierre de foyer en recharge ? Revenez vers le nord par {area:1276}.",
	-- ["Into {zone:1426}"] = "Vers {zone:1426}",
	-- ["Into {zone:1432}"] = "Vers le {zone:1432}",
	-- ["Into {zone:1455}"] = "Vers {zone:1455}",
	-- ["Into {zone:1457}"] = "Vers {zone:1457}",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {area:331} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep.\nCareful: Scripted ambushes of three mobs each attack along the road: furbolgs on the {zone:1439} stretch and undead nearer {area:413}."] = "Kerlonian dort au {area:448}, dans le sud de {zone:1439}. Utilisez le {item:13536} pour le réveiller et menez-le vers le sud par la route jusqu'en {area:331}, auprès de {npc:11219} au {area:413} ; sonnez à nouveau du cor chaque fois qu'il s'endort.\nAttention : des embuscades scriptées de trois monstres chacune attaquent le long de la route : des furbolgs sur le tronçon de {zone:1439} et des morts-vivants plus près du {area:413}.",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Kerlonian dort au {area:448}, dans le sud de {zone:1439}. Utilisez {item:13536} pour le réveiller et conduisez-le vers le sud par la route jusqu'en {zone:1440}, auprès de {npc:11219} au {area:413} ; sonnez à nouveau du cor chaque fois qu'il s'endort.",
	-- ["Kill the elementals for 5 Intact {quest:1016}, then use the {item:5456}"] = "Tuez les élémentaires pour obtenir 5 Bracelets élémentaires intacts ({quest:1016}), puis utilisez {item:5456}",
	-- ["Melyria and {npc:3901}"] = "Melyria et {npc:3901}",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Les Paludiers Poil-moussu et les Tisseurs de brumes Poil-moussu parcourent les berges juste à l'ouest et au sud de {npc:1244} ; presque tous laissent tomber du silex.",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Les Raptors tachetés et les Hurleurs tachetés parcourent les collines à l'ouest des excavations.",
	-- ["Next: fly to {area:42}."] = "Ensuite : volez jusqu'à {area:42}.",
	-- ["Only if you looted {quest:337} in {zone:1431}"] = "Seulement si vous avez ramassé {quest:337} à {zone:1431}",
	-- ["Raptor valley"] = "La vallée des raptors",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised.\nFen Creepers hide in the marsh pools north-west of the {area:1025}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "Des dragonnets rouges remplissent les collines à l'ouest des portes, des Griffes pourries affolées occupent {area:1025}, des Tranchegueules les pentes nord ; Neru se tient au nord-est (utilisez la {item:279996}).\n{quest:98283} est élite : il est conseillé de se grouper.\nDes Rampants des tourbières se cachent dans les mares du marais au nord-ouest de {area:1025}.\nAttention : hors combat, les Rampants des tourbières lancent Camouflage de temps en temps : ils sont furtifs et difficiles à voir.",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Suivez vers l'est la route qui traverse {zone:1437}, puis vers le sud par {area:836} jusqu'au {zone:1432}, et vers l'ouest par le tunnel jusqu'à {zone:1426} et {area:1537}.",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Allez vers le sud après le {area:421} et entrez dans le tunnel de {area:1276} ; il débouche sur la {area:461}, dans les Serres-Rocheuses. {npc:4080} et {npc:4077} campent sur le {area:1076}, au sud-ouest de la combe.",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Allez vers l'ouest jusqu'à la rive du {area:441}. Teronis gît parmi les murlocs Crache-sel ; n'importe quel murloc peut laisser tomber {item:5463}.",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Prenez le bateau de {area:17203} à {area:442} et volez jusqu'à {area:702} ; {npc:11401} est dans le Temple de la Lune. Retournez ensuite en vol à {area:442}.",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast Teleport: {zone:1450}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Prenez le bateau de {area:17203} à {area:442}. Assemblez les deux moitiés de pendentif pour obtenir {item:15885} et lancez Téléportation : {zone:1450} : {npc:11802} se trouve à {area:2361}. Volez ensuite jusqu'à {area:702} (en passant par {area:442}).",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Prenez le bateau de {area:17203} à {area:442}. Assemblez les deux moitiés de pendentif pour obtenir {item:15885} et lancez {spell:18960} : {npc:11802} est à {area:2361}. Puis volez jusqu'à {area:702} (en passant par {area:442}).",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "Prenez le bateau du {area:17203} pour {area:442}. Assemblez les deux demi-pendentifs en {item:15885} et lancez {spell:18960} : {npc:11802} est à {area:2361}. Ensuite, {npc:11800}, à {area:2361}, emmène les Druides en vol directement au {area:702}.",
	-- ["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Prenez le portail qui monte à l'{area:1658}, puis retournez en vol à {area:442}.",
	-- ["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Prenez le {area:2257} de {object:171524} jusqu'au {object:28027} de {zone:1453}, puis marchez jusqu'à la {object:2098}.",
	-- ["The Bluegill hovels"] = "Les huttes des Branchie-bleue",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "Le camp Dragonmaw se trouve au sud de la route, juste à l'ouest de {area:1025} : Ecumeurs, Arpenteurs et Gardiens. La quête de {npc:2092} à {zone:1426} demande le niveau 28.",
	-- ["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. {area:364} Watcher and the Ursas guard the den."] = "Les furbolgs Vile-sylve vivent dans les bois au sud de la route, au sud-est d'{area:415}. Le Protecteur et les Ursa gardent {area:364}.",
	-- ["The bigger raptors hunt in the valley just west of the dig."] = "Les plus gros raptors chassent dans la vallée juste à l'ouest des fouilles.",
	-- ["The excavation site sits on the hill south of the road."] = "Les excavations se trouvent sur la colline au sud de la route.",
	-- ["The raptor hills"] = "Les collines des raptors",
	-- ["The two stand together at the western end of the road.\nSouth of the murlocs, {npc:3585} waits at the {area:416}."] = "Les deux se tiennent ensemble à l'extrémité ouest de la route.\nAu sud des murlocs, {npc:3585} attend au {area:416}.",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Trois conteneurs dans les huttes des murlocs, du sud au nord : {object:261}, puis {object:142151}, puis {object:259} à l'extrémité nord.",
	-- ["Venture Co. loggers"] = "Déboiseurs de la KapitalRisk",
	-- ["West of Mystral Lake, the stardust bushes grow among the ruins."] = "À l'ouest du Lac Mystral, les buissons couverts de poussière d'étoile poussent parmi les ruines.",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "tuez en boucle des Ecumeurs Dragonmaw et des Arpenteurs Dragonmaw au camp Dragonmaw ({zone:1437})",
	-- ["{area:1025}: kill these as you meet them"] = "{area:1025} : tuez-les au passage",
	-- ["{area:442} flight master"] = "Maître de vol d'{area:442}",
	-- ["{item:15885}: join the two halves"] = "{item:15885} : assemblez les deux moitiés",
	-- ["{item:3349} on the way"] = "{item:3349} en chemin",
	-- ["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} et {npc:258785} sont dans le {object:32386}, dans {object:32362}.",
	-- ["{npc:1217}, upstairs in the inn"] = "{npc:1217}, à l'étage de l'auberge",
	-- ["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242} : pour {npc:2104}, dans le donjon",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244} : {quest:98283}, un raptor élite",
	-- ["{npc:1440}, in the Royal Library"] = "{npc:1440}, dans la Bibliothèque royale",
	-- ["{npc:1444}, in the {object:2098}"] = "{npc:1444}, sur la {object:2098}",
	-- ["{npc:1573}, in the {object:32372}"] = "{npc:1573}, à {object:32372}",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646} : la lettre de Thundris, d'{area:442}",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}, près du donjon",
	-- ["{npc:2092}'s quest in {zone:1455} needs level 28. If you are short of it after these hand-ins, grind the Dragonmaw orcs at the camps along the road east to {area:836} before you go on."] = "La quête de {npc:2092} à {zone:1455} demande le niveau 28. S'il vous manque après ces rendus, tuez des orcs Dragonmaw dans les camps le long de la route vers l'est jusqu'à {area:836} avant de continuer.",
	-- ["{npc:2094} stands by the north gate."] = "{npc:2094} se tient près de la porte nord.",
	-- ["{npc:2094}, by the north gate"] = "{npc:2094}, près de la porte nord",
	-- ["{npc:2097}, by the north gate"] = "{npc:2097}, près de la porte nord",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} se tient dans le {area:2103}, à quelques pas de {npc:1242}.",
	-- ["{npc:2104}, by the keep"] = "{npc:2104}, près du donjon",
	-- ["{npc:2104}, on the top floor"] = "{npc:2104}, au dernier étage",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649} : la réponse d'Alexston",
	-- ["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649} : la réponse d'Alexston, si vous l'avez prise à {zone:1453}",
	-- ["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} et ses marcheurs du Vide occupent {area:412}, au sud du sanctuaire. Attirez d'abord ses gardes.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide; inside"] = "{npc:3970} : pour {npc:1480} à Menethil, à la fin de ce guide ; à l'intérieur",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) commande les gnolls Crin-de-Chardon au camp situé au nord d'{area:415}. Éliminez d'abord ses gardes, un par un.",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}, dans la cabane au nord",
	-- ["{npc:4201}, in the hut north of them; inside"] = "{npc:4201}, dans la hutte au nord ; à l'intérieur",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} creuse dans la {area:2160}, à l'extrémité est de la combe. Parlez-lui et repoussez les pillards de la KapitalRisk pendant qu'il creuse.",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "{npc:4276} creuse dans {area:2160}, à l'extrémité est du pic. Parlez-lui et repoussez les pillards de la KapitalRisk pendant qu'il mine.\nAttention : les kobolds arrivent par vagues. La première vague se compose de combattants au corps à corps, la deuxième y ajoute des lanceurs de sorts. Les monstres normaux de la mine réapparaissent vite et peuvent se joindre au combat pendant les vagues. Un groupe est recommandé.",
	-- ["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la fromagerie du {object:2096}",
	-- ["{npc:4959} and {npc:482}"] = "{npc:4959} et {npc:482}",
	-- ["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, dans la Cathédrale de la Lumière",
	-- ["{npc:5082}, Mikhail and Tapoke Jahn are all at Menethil's inn; Tapoke fights you when you talk to Mikhail, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn.\n{npc:2104} stands in {area:2103}, a short walk from {npc:1242}.\n{npc:2104} stands in {area:2103}."] = "{npc:5082}, Mikhail et Tapoke Jahn sont tous à l'auberge de Menethil ; Tapoke vous attaque quand vous parlez à Mikhail, mais abandonne une fois battu. {npc:1480} se tient à quelques pas au nord-est de l'auberge.\n{npc:2104} se tient dans {area:2103}, à quelques pas de {npc:1242}.\n{npc:2104} se tient dans {area:2103}.",
	-- ["{object:176364} Harbor"] = "{object:176364}",
	-- ["{object:2164} is in the {object:2101}."] = "{object:2164} se trouve dans le {object:2101}.",
	-- ["{zone:1437}: kill these as you meet them"] = "{zone:1437} : tuez-les au passage",
	-- ["{zone:1455} priests"] = "Prêtres d'{zone:1455}",
}
