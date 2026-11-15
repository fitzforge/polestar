-- French (frFR): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Lancez {spell:18960}",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lancez {spell:18960}. Avec les deux moitiés de pendentif dans vos sacs, placez-vous près du {area:2362}, sur la rive nord-ouest du lac, et utilisez une moitié pour les assembler, puis allez voir {npc:11802} à {area:2361}. {npc:11802} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885} : assemblez les moitiés au {area:2362}",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "Prenez {quest:5061} auprès de {npc:11802}, à l'étage de son bâtiment. Ensuite, {npc:11800} à {area:2361} emmène les Druides directement en vol jusqu'à {area:702}.",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "Prenez le portail jusqu'à {area:1658}, puis reprenez un vol pour {area:442} et le bateau pour {area:150}.",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "Entrez dans {zone:1457}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "Prenez le bateau au quai d'{area:442} jusqu'à {area:150}.",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 13: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, à l'auberge",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, chez {npc:1464}",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "{npc:2104}, près du donjon ; au dernier étage",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "{npc:2104} : {quest:98221}, les plans d'attaque dans {area:1036}",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, sur la jetée au nord de l'auberge",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "{npc:2094}, près des quais",
	-- {npc:270844} Sylessa Duskwhisper · {npc:2094} James Halloran
	["{npc:270844}, beside {npc:2094} by the docks"] = "{npc:270844}, à côté de {npc:2094}, près des quais",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "{npc:2097}, près de la porte nord : {npc:1071} la prend lors de l'arrêt à {area:205} de 30-40/01-hillsbrad-foothills",

	-- Step 14: James Halloran
	-- {area:17732} Excavation Site: Wetlands · {npc:2094} James Halloran
	["For your {area:17732} run, later in this guide: {npc:2094}, by the docks, wants hides from the raptors inside."] = "Pour votre expédition dans {area:17732}, plus loin dans ce guide : {npc:2094}, près des quais, veut des peaux des raptors de l'intérieur.",

	-- Step 15: Nord'el
	-- {item:279915} Nord'el · {area:150} Menethil Harbor
	["{item:279915} lies on the shore just south of {area:150}, a short walk past the town's south end. Then follow the coast north out of town to the hovels."] = "{item:279915} se trouve sur le rivage juste au sud de {area:150}, à quelques pas après l'extrémité sud de la ville. Suivez ensuite la côte vers le nord hors de la ville jusqu'aux huttes.",

	-- Step 16: The Bluegill hovels
	["The Bluegill hovels"] = "Les huttes des Branchie-bleue",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Suivez la côte vers le nord en sortant de Menethil jusqu'au {area:1022}. Trois conteneurs dans les huttes des murlocs, du sud au nord : la {object:261}, puis le {object:142151}, puis le {object:259} à l'extrémité nord.",

	-- Step 17: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "{area:1039} : tuez-les au passage",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "Suivez la côte vers le nord jusqu'à l'épave. Des Marins maudits arpentent la plage, des Soldats de marine maudits le pont ; {npc:1159} se tient sur la plage près de la proue. Des Crocilisques géants des Paluns rôdent sur la côte juste au nord.\nAttention : des Rampants des tourbières se cachent, camouflés, là où la rivière se divise près du navire fantôme, et peuvent se joindre au combat.",
	-- {npc:1158} Cursed Marine · {npc:270589} Nightveiled Rotheap
	["{npc:1158}; careful: {npc:270589}, a level 31 elite, roams this coast"] = "{npc:1158} ; attention : {npc:270589}, un élite de niveau 31, rôde sur cette côte",

	-- Step 18: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "En arrivant par le nord : {npc:2094} près des quais, {npc:1242} sur la jetée, {npc:2104} dans le donjon, puis {npc:1239} à l'auberge.",
	-- {npc:270844} Sylessa Duskwhisper
	["{npc:270844}, beside him"] = "{npc:270844}, à côté de lui",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649} in {area:442}, on this guide's boat trip: keep it"] = "Pour {npc:3649} à {area:442}, lors du trajet en bateau de ce guide : gardez-la",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242} : pour {npc:2104}, dans le donjon",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "{npc:2104}, au dernier étage",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Pour Bolvar Fordragon, dans le {object:2117} : gardez-la",

	-- Step 19: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "Le capitaine arpente le pont du navire échoué ; son coffre est dans la cale.",

	-- Step 20: Raptor valley
	["Raptor valley"] = "La vallée des raptors",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "Suivez la route vers l'est : les grands raptors pour {quest:295} chassent dans la vallée juste à l'ouest du site de fouilles.",

	-- Step 21: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "Le site de fouilles se trouve sur la colline au sud de la route : {npc:1078} au sommet, {npc:1077} sous terre.",

	-- Step 22: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "{area:118} : tuez-les au passage",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "Les reliques se trouvent dans les fouilles mêmes. {npc:1353}, un grand raptor Razormaw, rôde dans la vallée des raptors juste à l'ouest.\nDes Gardiens de Goaz (élites, 32) se tiennent parmi les reliques et {object:331} : éloignez-les un par un, ou contournez-les.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661} : le {object:331}",

	-- Step 23: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} et Whelgar",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "{npc:1077}, sous terre : la {item:279993}, sur les Gardiens de Goaz élites",

	-- Step 24: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "Gardiens de Goaz",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "Les Gardiens de Goaz se tiennent juste à l'ouest du camp de Whelgar : utilisez la {item:279996} qu'il vous a donnée à côté de l'un d'eux.\n{npc:270892} est élite : mieux vaut grouper.",

	-- Step 25: Prospector Whelgar
	["Below ground"] = "Sous terre",

	-- Step 26: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "Une nouvelle {item:279996}, pour les quatre gardiens titans autour des {zone:1437} ; sous terre. Leurs cœurs tombent sur des élites de niveau 32 lors du passage à {area:205}",

	-- Step 27: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "Au nord des fouilles, entrez dans le camp Gueule-de-dragon : cliquez sur les quatre jeux de plans d'attaque. Le plan d'{zone:1455} se trouve à l'extrémité ouest du camp, les trois autres plus à l'est. {npc:2091}, un élite, se tient à l'écart au sud-est : {quest:98221} n'a pas besoin de lui.",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "{item:3337} : les Écumeurs et les Coureurs des marais du camp",

	-- Step 28: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "Suivez la route vers l'est jusqu'à {area:1025} ; {npc:1244} se tient près de la rivière. Le silex de {quest:277} vous suit depuis votre dernier passage dans les {zone:1437}.",

	-- Step 29: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "{npc:270637} campe parmi les Courfangeux, juste à l'ouest de {npc:1244}.",
	-- {area:1038} Dragonmaw Gates · {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Incisives de Tranchegueule : sur les raptors près de {area:1038}, lors de la boucle des {zone:1437} de 30-40/01-hillsbrad-foothills",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same loop"] = "{quest:98246} : les œufs de Tranchegueule, sur la même boucle",

	-- Step 30: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "À l'est de {npc:270637} : {npc:2093} se tient au bord de la route.",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "{npc:2093} : pour {npc:2094} à Menethil",

	-- Step 31: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "Rampants des tourbières le long de la rivière",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "Au nord-ouest de {npc:2093}, jusqu'à la rivière : des Rampants des tourbières se cachent dans ses mares et le long de ses rives, jusqu'à {area:1024} à l'ouest. Remontez-la vers l'ouest jusqu'à en avoir douze, puis retournez à l'est voir {npc:1244}.\nAttention : hors combat, les Rampants des tourbières se camouflent de temps en temps : ils sont alors furtifs et difficiles à voir.",

	-- Step 32: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "{quest:98283}, un raptor élite, lors de la boucle des {zone:1437} de 30-40/01-hillsbrad-foothills",

	-- Step 33: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:260808} Highland Horror
	["For your {area:17732} run, on the way back west: {npc:1244} wants the root core of a {npc:260808} inside."] = "Pour votre expédition dans {area:17732}, sur le chemin du retour vers l'ouest : {npc:1244} veut le cœur de racine d'une {npc:260808} de l'intérieur.",

	-- Step 34: Excavation Site: Wetlands
	-- {area:17732} Excavation Site: Wetlands · {npc:260808} Highland Horror · {npc:1244} Rethiel the Greenwarden · {npc:260326} Relic Guardian · {item:270865} Titan Relic · {npc:1077} Prospector Whelgar
	["{area:17732} is a dungeon for a group of five at about level 28 to 31. Its entrance lies just south of the road west, east of Whelgar's dig.\nInside: the Thicket raptors and Shadetooth drop the hides for Halloran, a {npc:260808} the root core for {npc:1244}. Saltspine, Shadetooth and the {npc:260326} are the bosses; the {npc:260326} drops a {item:270865}, which starts a quest for {npc:1077}."] = "{area:17732} est un donjon pour un groupe de cinq, vers les niveaux 28 à 31. Son entrée se trouve juste au sud de la route vers l'ouest, à l'est des fouilles de Whelgar.\nÀ l'intérieur : les raptors du fourré et Shadetooth lâchent les peaux pour Halloran, une {npc:260808} le cœur de racine pour {npc:1244}. Saltspine, Shadetooth et le {npc:260326} sont les boss ; le {npc:260326} lâche un {item:270865}, qui lance une quête pour {npc:1077}.",
	-- {quest:98815} Highland Hides
	["{quest:98815}: the hides, inside"] = "{quest:98815} : les peaux, à l'intérieur",
	-- {quest:95646} Horrors in the Highland
	["{quest:95646}: the root core, inside"] = "{quest:95646} : le cœur de racine, à l'intérieur",

	-- Step 35: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, west of the entrance on the way back west."] = "Le {item:270865} de votre expédition dans {area:17732} : {npc:1077} est sous terre dans ses fouilles, à l'ouest de l'entrée, sur le chemin du retour vers l'ouest.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, sous terre",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077} : pour {npc:5387} à {zone:1455}, à la fin de ce guide",

	-- Step 36: Captain Stoutfist
	-- {area:150} Menethil Harbor · {area:2104} Deepwater Tavern · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1217} Glorin Steelbrow · {npc:2094} James Halloran
	["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:1217} in the {area:2104} south of it, {npc:2094} by the docks on the way to the boat."] = "Utilisez votre pierre de foyer pour revenir à {area:150} si vous l'avez liée à {area:2104}, ou marchez vers l'ouest par la route : {npc:2104} se tient au dernier étage de {area:2103}, {npc:1217} dans {area:2104}, au sud, {npc:2094} près des quais, sur le chemin du bateau.",
	["On the top floor"] = "Au dernier étage",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Pour la catapulte Gueule-de-dragon, lors de la boucle des {zone:1437} de 30-40/01-hillsbrad-foothills",
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["{npc:1217}, in the {area:2104}"] = "{npc:1217}, dans {area:2104}",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "Pour {npc:1284} à {zone:1453}, à la fin de ce guide",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "{npc:2094}, près des quais, sur le chemin du bateau",

	-- Step 37: Level 28
	["Level 28"] = "Niveau 28",
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Still below level 28? That happens when you start this guide here without the {zone:1437} and {zone:1440} quests of the guides before it: top up on the Bluegill Raiders along the coast just south of Menethil before the boat, so {zone:1440}'s level 28-32 quests aren't too hard."] = "Toujours en dessous du niveau 28 ? Cela arrive quand vous commencez ce guide ici sans les quêtes de {zone:1437} et de {zone:1440} des guides précédents : gagnez de l'expérience sur les Écumeurs Branchie-bleue le long de la côte, juste au sud de Menethil, avant le bateau, pour que les quêtes de niveau 28-32 de {zone:1440} ne soient pas trop dures.",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "tuez des {npc:1418} en boucle",

	-- Step 38: James Halloran
	-- {npc:2094} James Halloran
	["Your Excavation Site hides: {npc:2094}, by the docks."] = "Vos peaux du site de fouilles : {npc:2094}, près des quais.",

	-- Step 39: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "Le bateau pour {area:442} part du bout de la jetée ouest de Menethil.",

	-- Step 40: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}, up the road from the dock."] = "{npc:3649} se tient à l'extrémité nord d'{area:442}, en remontant la route depuis le quai.",
	-- {item:279915} Nord'el · {npc:270844} Sylessa Duskwhisper · {area:150} Menethil Harbor
	["{item:279915}, from {npc:270844} in {area:150}"] = "{item:279915}, de {npc:270844} à {area:150}",

	-- Step 41: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "{npc:3649} se tient à l'extrémité nord d'{area:442}.",
	-- {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on 03-darkshore-return's first {area:442} stop)"] = "La réponse d'Alexston, si vous l'avez encore (l'itinéraire la rend au premier arrêt à {area:442} de 03-darkshore-return)",

	-- Step 42: Auberdine
	-- {npc:3693} Terenthis
	["{npc:3693} stands by the flight master."] = "{npc:3693} se tient près du maître de vol.",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "{npc:3693} : l'escorte de Volcor, à la fin de {zone:1439}",

	-- Step 43: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["Your {area:2797} brain stems: {npc:8997} stands a short walk west of {npc:3693}."] = "Vos troncs cérébraux de {area:2797} : {npc:8997} se tient à quelques pas à l'ouest de {npc:3693}.",

	-- Step 44: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Prendre un vol pour {area:415}",

	-- Step 45: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {area:415} Astranaar
	["{npc:3845} stands by {area:415}'s flight master."] = "{npc:3845} se tient près du maître de vol d'{area:415}.",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "Pour {quest:4581} au {area:2358}",

	-- Step 46: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, à l'intérieur",

	-- Step 47: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691} stands in the inn, beside the innkeeper."] = "{npc:3691} se tient dans l'auberge, à côté de l'aubergiste.",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {zone:1439} Darkshore
	["{npc:3691}: {quest:990}, if you still carry it from {zone:1439}"] = "{npc:3691} : {quest:990}, si vous l'avez encore depuis {zone:1439}",

	-- Step 48: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria et {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "Les deux se tiennent ensemble à l'extrémité ouest de la route, au sud-ouest d'{area:415}.",

	-- Step 49: Therysil
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["{npc:3585} stands at the {area:416}, a short walk from Melyria and {npc:3901}."] = "{npc:3585} se tient au {area:416}, à quelques pas de Melyria et d'{npc:3901}.",
	-- {npc:3585} Therysil · {quest:945} Therylune's Escape · {zone:1439} Darkshore
	["{npc:3585}: {quest:945}, if you still carry it from {zone:1439}"] = "{npc:3585} : {quest:945}, si vous l'avez encore depuis {zone:1439}",

	-- Step 50: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Suivez la route vers l'est jusqu'au Val hurlant ({area:419}) ; {npc:3916} se tient près du puits de lune.",

	-- Step 51: Dartol's Rod
	["Dartol's Rod"] = "Bâtonnet de transformation de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Les Anciens fous et les Anciens flétris au nord du puits de lune portent la {item:5475} ; le vieux coffre qu'elle ouvre se trouve parmi eux.",

	-- Step 53: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Suivez la route vers l'est jusqu'aux camps de satyres de {area:429} ; {npc:3920} se cache à leur lisière.",

	-- Step 54: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} dirige les satyres de {area:429} ; il porte la branche.",

	-- Step 55: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there, {npc:221269} a few steps east of her."] = "{area:2358}, l'avant-poste elfe de la nuit à l'extrémité est de la route : {npc:3848} s'y trouve, et {npc:221269} à quelques pas à l'est d'elle.",
	-- {npc:221269} Maseara Autumnmoon · {area:430} Satyrnaar
	["{npc:221269}: her husband's trail in {area:430}, on the way back from the lake"] = "{npc:221269} : la piste de son mari à {area:430}, sur le chemin du retour depuis le lac",

	-- Step 56: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432} : tuez-les au passage",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "Le camp des Réprouvés se trouve dans les bois au sud de {area:2358}.\nDes coffres rouillés se trouvent autour des camps de furbolgs Sombretaillis à l'ouest des Réprouvés ; ouvrez-les jusqu'à ce que l'un d'eux contienne le pommeau.\nAttention : des Réprouvés non élites de niveau 28-30 environ gardent le camp. Certains sont camouflés, et ceux autour de la table attaquent souvent ensemble.",

	-- Step 57: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "{npc:3931} arpente les rives de {quest:1035}, au sud-ouest des coffres ; {object:669176} se trouve au nord du lac, en chemin.\nAttention : d'autres monstres, dont certains sous l'eau, se tiennent près de l'île. Éliminez-les d'abord pour qu'ils ne se joignent pas au combat quand vous attirez l'Oracle.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176} : pour {npc:3961} à {area:415}",

	-- Step 58: Satyrnaar
	-- {area:430} Satyrnaar · {area:2358} Forest Song · {object:19901} Circle of Imprisonment · {object:673431} Kurothel's Knapsack (no name in this language: may be words) · {item:281014} Vine-Wrapped Scroll · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and {object:673431} lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "Au nord du lac, rejoignez le camp des satyres de {area:430}, juste à l'ouest de {area:2358} : le {object:19901} s'y trouve, et {object:673431} est posé à côté, avec le {item:281014}.\nAttention : les Voleurs Gangremusc de {area:428} sont souvent camouflés, et {area:430} compte des satyres lanceurs de sorts.",
	-- {item:281014} Vine-Wrapped Scroll · {object:673431} Kurothel's Knapsack (no name in this language: may be words)
	["{item:281014}, from {object:673431}"] = "{item:281014}, dans {object:673431}",

	-- Step 59: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "Facultatif : {npc:3848} propose aussi {quest:1012}, trois druides de niveau 32 au fond de {area:432}, une grotte aux monstres camouflés qui réapparaissent vite, puis retour auprès d'elle. C'est au-dessus de votre niveau ici : ne la prenez que si vous êtes en groupe ou si vous voulez l'XP en plus ; le guide n'en a pas besoin.",
	-- {npc:221269} Maseara Autumnmoon
	["{npc:221269}, a few steps east"] = "{npc:221269}, à quelques pas à l'est",

	-- Step 60: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "Entrée de {area:432}",

	-- Step 61: Insane druids
	["Insane druids"] = "Druides fous",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Les trois druides sont dans {area:432}, éloignés les uns des autres : entrez par l'ouverture de la grotte, au sud du camp des Réprouvés, et non par la colline au-dessus d'eux. {npc:3940} est dans les salles est, {npc:3941} tout au fond, à l'extrémité nord-est, et {npc:3942} à l'extrémité ouest.\nAttention : la tanière abrite de nombreux monstres qui réapparaissent vite, dont des morts-vivants camouflés et des patrouilles : des monstres supplémentaires se joignent souvent au combat.",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}, à l'intérieur de {area:432}",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}, à l'intérieur de {area:432}",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}, à l'intérieur de {area:432}",

	-- Step 63: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Le second {object:19901} se trouve dans la vallée de {area:428}, sur le chemin vers l'ouest.",

	-- Step 65: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "L'Autel caché se trouve sur la colline juste au sud-est du puits de lune ; suivez le sentier sinueux.",

	-- Step 67: The Howling Vale
	-- {area:419} Howling Vale · {npc:3792} Terrowulf Packlord
	-- plural, as words: Terrowulf Fleshrippers = {npc:3789} Terrowulf Fleshripper
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "Empruntez le tunnel jusqu'au {area:419} ; le tome se trouve dans les ruines à son extrémité ouest. Attention : des Déchireurs et des Tisseurs des ombres Frayeloup (28-30) se tiennent en groupes serrés autour du tome, et le {npc:3792}, un rare de niveau 32, arpente le val. Attirez les loups un par un depuis le tunnel et laissez d'abord passer le Chef de meute.",

	-- Step 68: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "{npc:3691} et {npc:3961} sont à l'auberge ; {npc:3894} est dans le bâtiment juste au sud.",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "{npc:3961}, à l'auberge",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "{npc:3894}, dans le bâtiment au sud de l'auberge",

	-- Step 69: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake · {item:5462} Dartol's Rod of Transformation
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}. Use {item:5462} near him first: he only speaks to you in furbolg form."] = "{npc:3897}, un furbolg épargné par la corruption, est assis au sud de la route, en contrebas du {area:421}. Utilisez d'abord {item:5462} près de lui : il ne vous parle que sous forme de furbolg.",

	-- Step 70: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} et ses gardes campent juste à l'est de {npc:3897}.\nAttention : des loups et des araignées rôdent près du camp et peuvent se joindre au combat. Certains loups vont par deux.",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "{item:5388}, sur {npc:3696}",

	-- Step 72: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "À l'ouest de {npc:3897}, longez les collines du sud jusqu'au {area:416} : Melyria et {npc:3901} s'y tiennent ensemble.",

	-- Step 73: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {quest:967} The Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3663}: {quest:967}, if you still carry it from {zone:1439}"] = "{npc:3663} : {quest:967}, si vous l'avez encore depuis {zone:1439}",

	-- Step 74: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "Au nord jusqu'au {area:413}.",

	-- Step 75: Astranaar
	-- {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["South-east along the road to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "Au sud-est par la route jusqu'à {area:415} : {npc:3691} à l'auberge, le maître de vol à l'extrémité ouest.",

	-- Step 76: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Maître de vol d'{area:415}",

	-- Step 78: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "{npc:1571} est le maître de vol près de l'auberge de Menethil.",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maître de vol de {area:150}",

	-- Step 80: High Explorer Magellas
	-- {quest:98824} Prehistoric Prism · {npc:5387} High Explorer Magellas · {object:32356} Hall of Explorers · {object:32372} Great Forge
	["{quest:98824}: {npc:5387} stands in the {object:32356}, north-east of the {object:32372}."] = "{quest:98824} : {npc:5387} se tient dans {object:32356}, au nord-est de {object:32372}.",

	-- Step 81: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Prêtres d'{zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} et {npc:258785} sont dans le {object:32386}, dans {object:32362}.",

	-- Step 82: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",

	-- Step 83: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square
	["{npc:1646} stands in the {object:2098}."] = "{npc:1646} se tient sur {object:2098}.",
	-- {npc:1646} Baros Alexston · {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver
	["{npc:1646}: {quest:97914}, {npc:3649}'s letter, if you still carry it"] = "{npc:1646} : {quest:97914}, la lettre de {npc:3649}, si vous l'avez encore",

	-- Step 84: Cathedral of Light
	["Cathedral of Light"] = "Cathédrale de la Lumière",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Prenez le {area:2257} de {object:171524} jusqu'au {object:28027} de {zone:1453}, puis marchez jusqu'à la {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, dans la Cathédrale de la Lumière",

	-- Step 85: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Seulement si vous avez ramassé {quest:337} à {zone:1431}",

	-- Step 86: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "Retournez à la Cathédrale de la Lumière : {npc:928} se tient à l'intérieur.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Pour {npc:2228} à {area:271} : gardez-la",

	-- Step 87: Warden Thelwater
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square
	["For your {area:717} run: {npc:1719} keeps the {area:717}'s gate, south of the {object:2098}."] = "Pour votre expédition dans {area:717} : {npc:1719} garde l'entrée de {area:717}, au sud de {object:2098}.",

	-- Step 88: Warden Thelwater
	-- {npc:1719} Warden Thelwater · {quest:389} Bazil Thredd · {npc:1646} Baros Alexston
	["{npc:1719}: {quest:389}, from {npc:1646}"] = "{npc:1719} : {quest:389}, de la part de {npc:1646}",

	-- Step 90: Stockade
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square · {npc:1663} Dextren Ward · {quest:389} Bazil Thredd
	["{area:717} is a dungeon for a group of five, about levels 23 to 29, and a run takes under an hour. Its gate is {npc:1719}'s, south of the {object:2098}.\nInside: the Defias prisoners, convicts and insurgents for Thelwater, {npc:1663}'s hand for Millstipe, and {quest:389} at the far end."] = "{area:717} est un donjon pour un groupe de cinq, vers les niveaux 23 à 29, et une expédition prend moins d'une heure. Son entrée est celle de {npc:1719}, au sud de {object:2098}.\nÀ l'intérieur : les prisonniers, forçats et insurgés défias pour Thelwater, la main de {npc:1663} pour Millstipe, et {quest:389} tout au fond.",

	-- Step 91: Warden Thelwater
	-- {npc:1719} Warden Thelwater
	["{npc:1719}, at the gate"] = "{npc:1719}, à l'entrée",

	-- Step 93: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} et {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la fromagerie du {object:2096}",

	-- Step 94: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Ensuite : volez jusqu'à {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Inside"] = "À l'intérieur",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Les trois druides se tiennent ensemble au camp des Réprouvés au sud de {area:2358}.\nAttention : le repaire compte de nombreux monstres qui réapparaissent vite, dont des morts-vivants camouflés et des patrouilles : d'autres monstres se joignent souvent au combat.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "Le {object:19901} se trouve dans le camp des satyres de {area:430}, plus à l'est sur la route.\nAttention : les Voleurs Gangremusc de {area:428} sont souvent camouflés, et {area:430} compte des satyres lanceurs de sorts.",
	-- ["{area:1025}: kill these as you meet them"] = "{area:1025} : tuez-les au passage",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, l'avant-poste elfe de la nuit à l'extrémité est de la route : {npc:3848} s'y trouve.",
	-- ["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649} : la réponse d'Alexston, si vous l'avez prise à {zone:1453}",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}, à l'auberge",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, un furbolg épargné par la corruption, est assis au sud de la route, en contrebas du {area:421}.",
}
