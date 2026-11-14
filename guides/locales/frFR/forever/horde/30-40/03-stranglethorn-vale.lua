-- French (frFR): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maître de vol de {area:2408}",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Prenez un vol de {area:2408} pour {area:1638} et allez vous entraîner auprès de {npc:3033} sur {area:1639} ; de là, continuez en vol jusqu'à {zone:1454}.",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "Retour à {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "{npc:5640} se tient dans {object:172961}, à l'ouest de la ville.",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Maîtres d'{zone:1454}",
	["Train while you are in the city."] = "Entraînez-vous pendant que vous êtes en ville.",

	-- Step 6: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["{area:35} first: the goblins' boat sails there from {area:392}, and every {area:35} quest is for the north of the vale, which you then walk up into."] = "{area:35} d'abord : le bateau des gobelins s'y rend depuis {area:392}, et toutes les quêtes de {area:35} concernent le nord de la vallée, que vous remonterez ensuite à pied.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 7: Ratchet
	-- {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["{npc:3391} waits upstairs in the house by the flight master; {quest:1111} stands on the docks, beside the boat."] = "{npc:3391} attend à l'étage de la maison près du maître de vol ; {quest:1111} se tient sur les quais, à côté du bateau.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, à l'étage",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631} in {area:35}, where the boat goes"] = "{npc:3391} : pour {npc:4631} à {area:35}, là où va le bateau",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}, sur les quais",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "Les pièces de Dizzywig retournent à Kravel dans {area:439}, hors de l'itinéraire : laissez-les.",

	-- Step 8: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Bateau pour {area:35}",

	-- Step 9: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil · {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:2858} Gringer
	["{npc:4631} stands on the pier where the boat docks. {npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs, {npc:2858} the flight master on the upper deck."] = "{npc:4631} se tient sur la jetée où accoste le bateau. La boutique de {npc:2495} est dans le bâtiment à l'est de l'auberge ; {npc:2498} est au rez-de-chaussée de l'auberge, {npc:2496}, {npc:737} et {npc:773} à l'étage, {npc:2858}, le maître de vol, sur le ponton supérieur.",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the pier"] = "{npc:4631}, sur la jetée",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, à l'intérieur",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "{npc:2498}, à l'intérieur, au rez-de-chaussée",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}, à l'étage",
	-- {npc:2496} Baron Revilgaz · {area:37} Lake Nazferiti
	["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496} : le coffre de Cozzle se trouve à {area:37}, plus loin dans ce guide",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, à l'étage",

	-- Step 10: Grom'gol
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Leave {area:35} through the tunnel and follow the road north to {object:3202}, the orc camp on the west side of the vale. Stay on the road: the jungle beside it is above your level."] = "Quittez {area:35} par le tunnel et suivez la route vers le nord jusqu'à {object:3202}, le camp orc à l'ouest de la vallée. Restez sur la route : la jungle alentour est au-dessus de votre niveau.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497} : pour les Hautes-terres Arathies, plus loin sur l'itinéraire",

	-- Step 11: Nesingwary's camp
	["Nesingwary's camp"] = "Camp de Nesingwary",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:773} Krazek · {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. {npc:773} wants it investigated: walk among its tents. From here on, keep every page of The {item:2755} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "Suivez la route vers le nord depuis {object:3202} ; le camp de chasse de Nesingwary se trouve sur la colline au nord-est de la rivière. {npc:773} veut qu'on enquête dessus : marchez parmi ses tentes. Dès maintenant, gardez chaque page ramassée du livre {item:2755} : {npc:716} les prendra lors de votre prochain passage à Strangleronce.",

	-- Step 12: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100} : tuez-les au passage",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Des Crocilisques des rivières se trouvent le long de la rivière sous le camp. Les Jeunes tigres de Strangleronce rôdent à l'ouest du camp, les Jeunes panthères à l'est. Allez vers l'ouest après le camp. Les Raptors de Strangleronce (33-34) chassent dans les clairières, et les trolls Bloodscalp tiennent les ruines sur la côte : chaque Bloodscalp peut lâcher une défense. Le {item:4614} est un butin très rare sur eux : si vous en obtenez un, lisez-le. Attention : les camps trolls ont de nombreuses patrouilles, d'autres trolls rejoignent donc souvent le combat.",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434} : tuez-les au passage",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: their camps are crowded, with Venture Co. Agents (39) among the geologists (36-38): pull from the camps' edges, one at a time."] = "Les Tigres de Strangleronce (32) parcourent les collines autour du camp et au sud, les Panthères (32) les clairières à l'ouest et au sud-ouest. Les Géologues de la KapitalRisk, qui portent les Cristaux réduits, travaillent dans les camps près de {area:37}, au sud-est du camp. Attention : leurs camps sont bondés, avec des Agents de la KapitalRisk (39) parmi les géologues (36-38) : attirez-les depuis le bord des camps, un par un.",

	-- Step 15: Cozzle's Footlocker
	-- {npc:4723} Foreman Cozzle · {area:37} Lake Nazferiti · {object:20691} Cozzle's Footlocker · {npc:2496} Baron Revilgaz
	-- plural, as words: Venture Co. Agents = {npc:260429} Venture Co. Agent
	["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}. Careful: Venture Co. Agents (39) stand in and around the house: clear the doorway before you go in."] = "{npc:4723} (38) est dans la maison de la KapitalRisk sur la rive ouest de {area:37}, parmi les géologues : sa clé ouvre {object:20691} dans la même maison, qui contient les plans pour {npc:2496}. Attention : des Agents de la KapitalRisk (39) se tiennent dans la maison et autour : dégagez l'entrée avant d'entrer.",
	-- {npc:4723} Foreman Cozzle
	["from {npc:4723}"] = "sur {npc:4723}",
	-- {item:5852} Fuel Regulator Blueprints · {object:20691} Cozzle's Footlocker
	["{item:5852}, in {object:20691}"] = "{item:5852}, dans {object:20691}",

	-- Step 16: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Les Panthères Ombregueule viendront bien plus tard, près de {object:3202}",

	-- Step 17: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "Anciens tigres de Strangleronce",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "Les Anciens tigres de Strangleronce (34-35) parcourent les collines au sud-ouest du camp. Attention : des camps trolls sont proches du territoire des tigres, et des trolls peuvent rejoindre le combat si vous attirez sans prudence.",

	-- Step 18: Nesingwary's camp
	["Back north to the camp."] = "Retournez au camp, au nord.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301} : tuez-les au passage",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "À l'ouest après le camp, des Basilics de cristal (34-35) se tiennent sur les rochers ; chaque Bloodscalp du village plus loin peut lâcher une oreille.\n{npc:729}, un tigre de niveau 37, rôde au sommet de la colline au sud-ouest du camp.\nAttention : le nid de raptors abrite de jeunes raptors qui rejoignent le combat quand vous attaquez les adultes.",

	-- Step 21: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Raptors Fouette-queue",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}."] = "En redescendant vers le sud jusqu'à {object:3202}, les Raptors Fouette-queue (35-36) chassent dans la jungle entre le camp et {object:3202} : ils comptent pour Hemet et pour {npc:2464}.",

	-- Step 22: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464} se tient au centre de {object:3202}, {npc:2497} près de la tour du zeppelin, {npc:2465} à côté du maître de vol.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "{npc:2465} : les griffes d'Ombregueule et le croc de la tigresse viennent à la fin de ce guide",

	-- Step 23: Level 35
	["Level 35"] = "Niveau 35",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{area:35}'s and {object:3202}'s next quests are 35-38. Still below 35 after Aggro'gosh's hand-in? The Lashtail Raptors (35) hunt the jungle just north of {object:3202}: kill them until level 35."] = "Les quêtes suivantes de {area:35} et de {object:3202} sont de niveau 35-38. Toujours en dessous de 35 après avoir rendu la quête d'Aggro'gosh ? Les Raptors Fouette-queue (35) chassent dans la jungle juste au nord de {object:3202} : tuez-les jusqu'au niveau 35.",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "tuez en boucle : {npc:686}",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maître de vol de Grom'gol",

	-- Step 25: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "La boutique de {npc:2495} est dans le bâtiment à l'est de l'auberge ; {npc:2498} est au rez-de-chaussée de l'auberge, {npc:2496}, {npc:737} et {npc:773} à l'étage, à côté du maître de vol.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",

	-- Step 26: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 27: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Au nord-ouest de Grom'gol, {area:104} s'étend sous l'eau au large de la côte. L'{item:4094} repose au fond de la mer près des ruines englouties ; surveillez votre souffle et les murlocs.",
	["Underwater"] = "Sous l'eau",

	-- Step 28: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102} : tuez-les au passage",
	-- {item:3915} Bloody Bone Necklace · {item:2755} Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of The {item:2755}."] = "Les Chasseurs de tête Bloodscalp (36-37) du village sur la côte portent les têtes réduites.\nLes trolls Bloodscalp tiennent les ruines plus haut sur la côte, au nord du récif, et le village au-delà ; chacun peut lâcher un {item:3915}. Continuez à ramasser des pages du livre {item:2755}.",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "À l'est des collines Mosh'Ogg, les Panthères Ombregueule (37-38) rôdent dans la jungle en direction du lac ; les Tigresses de Strangleronce parcourent le même terrain et lâchent de temps en temps un croc intact. Les Crocilisques Gueule d'acier bordent la rivière juste à l'ouest de la jungle ; gardez leurs peaux pour {npc:2495}. Attention : les Panthères Ombregueule (niveau 37-38) et les Anciennes panthères Ombregueule (niveau 42-43) se camouflent hors combat, elles restent donc cachées jusqu'à ce que vous vous approchiez.",

	-- Step 31: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Camp Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "Les ogres Mosh'Ogg campent dans les collines juste à l'est de {object:3202}, sur votre chemin du retour. Tuez 10 Brutes et 5 Sorciers-docteurs (36-37) ; attirez-les un par un.",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "Retour à {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2465} : pour forever/horde/40-50/01-stranglethorn-vale",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2497} : pour forever/horde/40-50/01-stranglethorn-vale",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "Le prochain guide prend le zeppelin pour {zone:1454} depuis la tour à l'ouest du campement.",

	-- Step 33: Level 36
	["Level 36"] = "Niveau 36",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Mosh'Ogg Brutes and Witch Doctors camp in the hills just east of the camp: kill them until level 36, pulling one at a time, then walk back to the zeppelin tower."] = "Les quêtes du marécage d'Âprefange sont de niveau 35-38. Toujours en dessous de 36 après avoir rendu les quêtes de {object:3202} ? Les Brutes et les Sorciers-docteurs Mosh'Ogg campent dans les collines juste à l'est du camp : tuez-les jusqu'au niveau 36 en les attirant un par un, puis revenez à pied à la tour du zeppelin.",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "tuez en boucle : {npc:1142}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Elder tigers and Lashtail raptors"] = "Anciens tigres et raptors flagellants",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Suivez la route vers le nord depuis {object:3202} ; le camp de chasse de Nesingwary se trouve sur la colline au nord-est de la rivière. Dès maintenant, gardez chaque page de {quest:338} ramassée : {npc:716} les demandera plus tard.",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Suivez la route vers le sud jusqu'à {area:35}, à la pointe sud de la vallée, et entrez par le tunnel dans les falaises. Restez sur la route : la jungle alentour est bien au-dessus de votre niveau. {npc:2858}, le maître de vol de la Horde, attend sur le ponton supérieur.",
	-- ["Green Hills pages"] = "Pages des Vertes collines",
	-- ["Head south down the coast to {object:3202} and fly to {area:35}."] = "Descendez la côte vers le sud jusqu'à Grom'gol et volez jusqu'à {area:35}.",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Les pages de {item:2755} tombent à environ 1 % chacune sur les trolls Bloodscalp et Skullsplitter ; gardez chaque page ramassée et cherchez le reste à l'hôtel des ventes. {npc:716} prend les chapitres plus loin dans ce guide.",
	-- ["Shadowmaw panthers"] = "Panthères Ombregueule",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Les Raptors flagellants (35-36) chassent dans la jungle juste au nord-est de {object:3202}.",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Les Panthères Ombregueule (37-38) rôdent dans la jungle à l'est des collines Mosh'Ogg et au nord-est vers le lac ; elles attaquent en camouflage. Ramassez chaque page des Vertes collines trouvée en chemin.",
	-- ["The camp by the river"] = "Le camp près de la rivière",
	-- ["Upstairs"] = "À l'étage",
	-- ["Venture Co. camp"] = "Camp de la KapitalRisk",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Les Jeunes tigres de Strangleronce rôdent à l'ouest du camp, les Jeunes panthères au sud et à l'est.\nAllez vers l'ouest après le camp. Les Raptors de Strangleronce (33-34) chassent dans les clairières, et les trolls Bloodscalp tiennent les ruines sur la côte : chaque Bloodscalp peut lâcher une défense. Le {item:4614} est un butin très rare sur eux : si vous en obtenez un, lisez-le.\nAttention : les camps trolls ont de nombreuses patrouilles, d'autres trolls rejoignent donc souvent le combat.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",
	-- ["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496} : pour Pozzik à {area:2240}, en route vers {zone:1446} vers le niveau 43",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Le camp des chasseurs disparus de {npc:773} est celui de Nesingwary : marchez parmi ses tentes et l'enquête est terminée. Des Crocilisques des rivières se trouvent le long de la rivière sous le camp.",
}
