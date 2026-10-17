-- French (frFR): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale
	["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "Prenez le vol de {area:392} à {area:2897}, sur la côte de {zone:1440}.",
	-- {npc:12717} Muglash
	["{npc:12717}: starts his escort at once"] = "{npc:12717} : son escorte commence aussitôt",

	-- Step 2: Vorsha the Lasher
	-- {npc:12717} Muglash
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717} remonte la plage vers le nord jusqu'à un brasero naga. Éteignez le brasero, puis protégez-le pendant les vagues de nagas jusqu'à la mort de Vorsha la Flagellante.",
	["Naga brazier"] = "Brasero naga",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "Ruines de {area:2797}",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "On rejoint les saphirs par les ruines englouties au nord de la plage : descendez l'escalier dans la fosse.",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "Saphirs d'Aku'Mai",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "Les Saphirs d'Aku'Mai sont des cristaux bleus sur les parois des tunnels menant au portail de {area:2797}, sous terre et hors de l'instance : plongez depuis la fosse, passez sous le mur et entrez dans la grotte. Les satyres et nagas des tunnels sont élites : il est conseillé de grouper. Les cristaux réapparaissent vite, inutile d'aller loin.",

	-- Step 5: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "{npc:12736} Sancrea propose ensuite une quête à {area:2797} ; laissez-la sauf si vous avez un groupe.",

	-- Step 6: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "À l'est de Zoram'gar, les furbolgs Crin-de-Chardon occupent le village et les collines autour de leur antre.",

	-- Step 7: Thistlefur Hold
	["Thistlefur Hold"] = "Antre des Crins-de-Chardon",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "Dans l'antre, des coffres de troll jalonnent les tunnels. {npc:12818} est retenu tout au fond : libérez-le et protégez-le jusqu'à la sortie, puis il rentre à {area:428}.",

	-- Step 8: Zoram'gar Outpost
	["Back west to Zoram'gar before heading east for good."] = "Retournez à Zoram'gar à l'ouest avant de partir pour de bon vers l'est.",

	-- Step 9: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "Suivez la route principale vers l'est après {area:415} (Alliance : restez sur la route). {npc:12678}, un grand grizzly, rôde dans {area:418}, au sud de la route, à l'ouest de {area:421}. Sa patte lance la quête de chasse suivante.",

	-- Step 10: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "Fontaine de {area:418}",
	-- {area:418} Ruins of Stardust · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "La fontaine se trouve au milieu de {area:418} : utilisez-y {item:7767}.",

	-- Step 11: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}, un ajout de Forever, se tient sur la rive ouest de {area:421} avec trois quêtes rapides de tueur de dragon.",

	-- Step 12: Tideress
	-- {npc:12759} Tideress · {area:421} Mystral Lake · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}, un élémentaire d'eau corrompu, dérive dans {area:421}. Son objet {item:16408} lance une quête pour Bois-brisé.",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "Les furbolgs Vile-sylve tiennent les bois à l'est de {area:421}, au sud de la route. Placez {item:16972} sur {object:178206} et gardez-le : les furbolgs viennent l'abattre. {npc:12918} arrive en dernier ; son totem tombe dans la corbeille.",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "Continuez vers l'est sur la route. {npc:12858} attend au sud-ouest du Camp de bûcherons chanteguerre. Lui et ses grunts prennent d'assaut {area:2360} : laissez-les attirer l'aggro et restez avec {npc:12858} jusqu'à la mort de {npc:12860}.",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} se tient au camp de bûcherons. Les Estafettes d'Ashenvale elfes de la nuit rôdent dans les bois au sud-est ; elles sont camouflées, restez attentif.",

	-- Step 16: Splintertree Post
	-- {area:431} Splintertree Post · {area:428} Night Run
	["North up the road to {area:431} and {area:428} beside it."] = "Remontez la route vers le nord jusqu'à {area:431} et {area:428} juste à côté.",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718} : seulement si vous portez les pages du manuel",

	-- Step 17: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}, un grand sabre-de-nuit, rôde dans les bois au sud-est du Camp de bûcherons chanteguerre. Sa griffe lance la quête de chasse suivante.",

	-- Step 18: Felmusk satyrs
	["Felmusk satyrs"] = "Satyres Gangremusc",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "Au nord-ouest de Bois-brisé, les Satyres Gangremusc campent dans les bois. Chaque satyre peut laisser des cornes.",

	-- Step 19: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}, une panthère des ombres, rôde dans les bois autour de {area:426}, à l'ouest du camp Gangremusc. Sa tête lance la quête de chasse suivante.",

	-- Step 20: Mystral Lake
	-- {area:421} Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "Retournez au sud-ouest vers {area:421}. Des Elémentaires d’eau souillés dérivent le long de ses rives ; le belvédère se dresse sur l'île et domine l'avant-poste de l'Alliance.",
	["Gazebo"] = "Belvédère",

	-- Step 23: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {npc:2995} Tal
	["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Prenez le vol pour {area:1638} si vous connaissez le trajet aérien. Sinon, volez jusqu'à {area:378}, chevauchez vers l'ouest en {zone:1412} en passant par {area:222} jusqu'à {area:1638}, et prenez son trajet aérien auprès de {npc:2995}, sur la hauteur centrale.",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "Parlez à {npc:3057}, à {area:1638} : {quest:93739}",

	-- Step 24: The Earthen Ring
	["The Earthen Ring"] = "Le Cercle terrestre",
	-- {zone:1456} Thunder Bluff · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury
	["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "Descendez de {zone:1456} par un ascenseur. Le camp du Cercle terrestre se trouve au nord des pitons : {npc:264074}, {npc:264072} et {npc:259118}.",

	-- Step 25: Gloomrise
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "Au nord du camp, des araignées envahissent le cimetière de {area:17044}. Utilisez {item:273015} de {npc:264074} sur les Gnawed Corpses ; les Spinners laissent {item:273181}. {npc:264082} se tient au nord : son objet {item:273658} lance {quest:96294}.",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "Échantillons de toxine de la cime du Chagrin ({item:273001}), sur les Cadavres rongés ({npc:264096})",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, sur les Tisseuses de la cime du Chagrin ({npc:264081})",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{item:273658}, sur {npc:264082}",

	-- Step 26: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "Retournez au camp au sud, puis montez à {zone:1456} pour le vol vers {area:378}.",

	-- Step 27: Brine
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {npc:5899} Brine · {area:1718} Great Lift
	["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "Prenez le vol de {zone:1456} à {area:378}. La hutte de {npc:5899} se dresse sur la crête au-dessus du point d'eau des huttins, au sud du camp, sur la route de {area:1718}.",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "pour {npc:5901}, au sud de {area:392} : guide suivant",

	-- Step 28: Great Lift
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {zone:1413} Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "Prenez le vol de {zone:1456} à {area:378} et suivez la route vers le sud jusqu'à {area:1718}, tout au sud de {zone:1413}.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, en haut de l'ascenseur",

	-- Step 29: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "Descendez par l'ascenseur, puis suivez la route vers l'est à travers les canyons jusqu'à {area:484}, un village tauren au sommet des mesas. Son ascenseur est du côté nord.",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}, près du maître des coursiers du vent",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}, la marchande de fournitures d'artisanat : les Harpies hurlantes de {area:487}",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "L'avis de recherche près de {npc:10537}",

	-- Step 30: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "Descendez par l'ascenseur. L'œuf repose dans un nid au fond du canyon, à l'un de trois endroits : au sud-est des mesas (52.3,55.2), à l'est (56.4,50.4) ou au sud-ouest (37.6,56.1).",

	-- Step 32: Galak centaurs
	["Galak centaurs"] = "Centaures galak",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "Les camps galak remplissent le canyon au nord du Poste de Librevent ; Eclaireurs, Querelleurs et Chasse-vent galak partagent chaque camp. Un {npc:10617} solitaire circule entre les camps : tuez-le dès que vous le croisez, sa note lance une quête pour {area:2237}.",

	-- Step 33: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986} se tient au sommet d'une mesa à l'est des camps galak. Pour {quest:1149}, avancez jusqu'au bout des planches à côté de lui et sautez : vous atterrissez sans dommage.",

	-- Step 35: Grimtotem camps
	["Grimtotem camps"] = "Camps du Totem sinistre",
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "À l'ouest du Poste de Librevent, les camps du Totem sinistre sous {area:2097}. Les notes secrètes sont dans les Coffres à documents des camps sud-est, sud-ouest et nord-ouest.",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, camp sud-est",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, camp sud-ouest",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, camp nord-ouest",

	-- Step 36: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "Montez le chemin jusqu'au sommet de {area:2097}. {npc:10646} est retenue captive près de {npc:10896} (29) : éliminez d'abord les gardes et {npc:10896}, puis libérez-la et protégez-la pendant la descente ; des embusqués du Totem sinistre vous attaquent en route.",

	-- Step 37: Whitereach Post
	-- {area:2237} Whitereach Post
	["Follow the canyon west to {area:2237}."] = "Suivez le canyon vers l'ouest jusqu'à {area:2237}.",
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "La quête suivante de {npc:10428}, Feu sacré, se termine à {zone:1456}, hors de cet itinéraire. Passez-la.",
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "Tuez {npc:10720} qui s'en prend à {npc:10638}",

	-- Step 38: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "À l'ouest du poste, les wyvernes nichent sur les falaises de {area:482} ; les œufs sont dans les nids. {npc:10427} attend du côté est des aires de nidification : libérez-le et gardez-le en vie jusqu'au retour à {area:2237}.",

	-- Step 40: Roguefeather Den
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "Au sud de Noir-nuage, les harpies de {area:487}. {npc:4490} (31) circule parmi elles : éclaircissez les harpies autour d'elle avant de l'attirer. Les Harpies hurlantes, Volplumes hurlantes et Imploratrices célestes hurlantes de ce lieu sont pour {npc:4877}.",

	-- Step 43: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}, un élémentaire de roche qui frappe fort, arpente les falaises de {area:482}. {npc:4499} est élite : il est conseillé de grouper.",

	-- Step 44: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Suivez le canyon vers l'est pour quitter les mesas et rejoindre les Salines. Les gobelins et gnomes de {area:2240} sont neutres et donnent des quêtes aux deux factions.",
	["His crate is for Stranglethorn, later on the route"] = "Sa caisse est pour Strangleronce, plus loin sur l'itinéraire",

	-- Step 45: The salt flats
	["The salt flats"] = "Les Salines",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868} jonche les Salines au nord de la piste. Scorpides ravageurs et Tortues nacrétoile parcourent la moitié nord, des Charognards des Salines tournoient au-dessus, et des Basilics du sel gemme paissent à l'ouest de la piste. Les Peaux de cristal du sel gemme parcourent le centre des Salines et les Contemplateurs du sel gemme (34-35, cinq niveaux au-dessus de vous : un à la fois) l'extrême sud.",

	-- Step 46: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454} : sa lettre est pour Martek l'Exilé dans {zone:1418}, vers le niveau 38",

	-- Step 47: Freewind Post
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to {zone:1454}."] = "Le guide suivant part d'ici en vol vers {zone:1454}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Shadumbra"] = "Shadumbra",
	-- ["Sharptalon"] = "Serres-tranchantes",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Tideress"] = "Maréen",
	-- ["Ursangous"] = "Ursangous",
}
