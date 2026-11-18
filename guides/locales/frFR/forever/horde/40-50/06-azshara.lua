-- French (frFR): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "Maître de vol de {area:75}",

	-- Step 3: Booty Bay
	-- {area:75} Stonard · {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["The flight from {area:75} lands on {area:35}'s upper deck. {npc:7406} has his workshop on the upper ring of the bay."] = "Le vol depuis {area:75} se pose sur le pont supérieur de {area:35}. {npc:7406} a son atelier sur le cercle supérieur de la baie.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}, à l'intérieur",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}, dans l'auberge",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley, on the top floor: Stoley's shipment from {zone:1446}"] = "« Loup de mer » MacKinley, au dernier étage : la cargaison de Stoley venue de {zone:1446}",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "{npc:2487}, sur le balcon du même bâtiment",

	-- Step 4: The Bloodsail ships
	["The Bloodsail ships"] = "Les navires de la Voile sanglante",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "Au sud de Baie-du-Butin, trois navires de la Voile sanglante mouillent au large du {area:43} : {npc:2550}, {npc:2548} et {npc:2546} se tiennent chacun sur un pont avec leur équipage. Nagez jusqu'à eux et passez d'un navire à l'autre.",

	-- Step 6: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {quest:8552} demande un groupe de 2. Passez-la si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 12: Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp · {npc:2497} Nimboya · {object:2076} Bubbling Cauldron
	["The flight lands at {area:117}; {npc:2497} stands by the {object:2076}."] = "Le vol se pose au {area:117} ; {npc:2497} se tient près du {object:2076}.",

	-- Step 13: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Retour à {object:3202}",

	-- Step 14: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:818} (élite de niveau 47) demande un groupe de 2. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.\nAttention : deux gardes élites lanceurs de sorts, autour du niveau 45, se tiennent avec {npc:818} et se joignent au combat avec lui.",
	["Below ground"] = "Sous terre",

	-- Step 18: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 19: Zilzibin Drumlore
	-- {zone:1454} Orgrimmar · {npc:7010} Zilzibin Drumlore · {zone:1446} Tanaris
	["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}."] = "En traversant {zone:1454} vers le maître de vol, passez par la Herse : {npc:7010} prend le rapport sur les insectes de {zone:1446}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, la Herse",

	-- Step 20: Dran Droffers
	["The Droffers' shop is a few steps further into the Drag."] = "La boutique des Droffers est à quelques pas plus loin dans la Herse.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, la Herse",

	-- Step 22: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Entrer en {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Chevauchez vers l'est sur la route en quittant Bois-brisé. {npc:11548} attend au {area:1235}, juste à côté de la route, à quelques pas à l'ouest de la {area:3137} de l'Alliance : arrivez par l'ouest et évitez les Sentinelles d'Azshara ({npc:11276}) et Jarrodenus (élite).",

	-- Step 23: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236} : tuez-les au passage",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Les fantômes bien-nés hantent les ruines juste au nord du sanctuaire ; les satyres Haldarr campent un peu plus au nord.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117} se promène autour de {area:1235} : cherchez dans le cercle sur la carte",

	-- Step 24: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Retournez voir {npc:11548} au sanctuaire ; restez à l'ouest des gardes de {area:3137}.",

	-- Step 25: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Suivez la route vers le nord jusqu'à {area:1237}, le camp de la Horde.",

	-- Step 26: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Maître de vol de {area:1237}",

	-- Step 27: Orgrimmar
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag: if you still carry it"] = "{npc:7010}, la Herse : si vous l'avez encore",

	-- Step 28: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1447} Azshara
	["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, the {zone:1447} guide at 55 offers it again."] = "{quest:4494} demande le niveau 50 : {npc:7010}, dans la Herse, la donne à partir de là. Sous le niveau 50, le guide {zone:1447} à 55 la propose de nouveau.",

	-- Step 30: Paladin trainer
	["Paladin trainer"] = "Maître des paladins",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} aux {zone:1456} ; {zone:1454} n'a pas de maître des paladins",

	-- Step 31: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Prendre un vol pour {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 32: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and Magatha are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Volez jusqu'aux {zone:1456} ; c'est sur le chemin du {area:1099}. Pas encore de trajet aérien ? Volez jusqu'au {area:378} et allez vers l'ouest à travers {zone:1412}. Hamuul et Magatha sont sur la {area:1639} ; les Druides et les Paladins s'entraînent ici ({npc:3033}, {npc:246344}).",
	-- {npc:6746} Innkeeper Pala
	["{npc:6746}, at the inn: for Hamuul"] = "{npc:6746}, à l'auberge : pour Hamuul",
	-- {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{npc:5769}, on the {area:1639}"] = "{npc:5769}, sur la {area:1639}",

	-- Step 33: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 34: Thunder Bluff
	-- {quest:3761} Un'Goro Soil
	["{quest:3761} is gathered in the next guide."] = "{quest:3761} se récolte dans le guide suivant.",

	-- Step 35: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Prendre un vol pour {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 36: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776} : les ours sont à {zone:1448}",

	-- Step 37: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Hippogryphes Aigreplume",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Les hippogryphes nichent sur les collines au sud-ouest du camp. Tuez-en un, puis utilisez le récipient miniaturisé sur son corps.",

	-- Step 38: Hippogryph nests
	["Hippogryph nests"] = "Nids d'hippogryphes",
	-- {area:2522} Ruins of Isildien · {object:142071} Egg-O-Matic
	["The hippogryph nests are on the hills to the south, around the {area:2522}; each holds an egg for the {object:142071}."] = "Les nids d'hippogryphes se trouvent sur les collines au sud, autour des {area:2522} ; chacun contient un œuf pour l'{object:142071}.",

	-- Step 40: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Fées fléchetteuses",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Les dragons féériques voltigent dans les bois juste à l'ouest du camp. Utilisez le récipient sur chacun de ceux que vous tuez.",

	-- Step 42: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Marcheurs des bois errants",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Les tréants errent sur les routes forestières entre le camp et le centre de {zone:1444} ; ils sont peu nombreux, cherchez le long des chemins.",

	-- Step 45: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108} : tuez-les au passage",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray · Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Les Élémentaires marins et les Embruns ondoient le long du rivage autour du quai.\nLes Marcheurs des terres et les Géants des falaises parcourent les collines au nord du quai. Frappez d'abord chacun avec l'{item:18904} : une fois rapetissés, ils ne sont plus élites. Chaque géant rapetissé lâche du résidu ; utilisez aussi le Récipient de Muisek sur son corps.",

	-- Step 47: Northspring harpies
	["Northspring harpies"] = "Harpies Northspring",
	["The Northspring harpies nest on the ridges in the far north-west, past the giants' hills. The Windcallers heal, so kill them first and pull one at a time."] = "Les harpies Sourcenord nichent sur les crêtes à l'extrême nord-ouest, au-delà des collines des géants. Les Mandevents soignent : tuez-les en premier et attirez-les un par un.",

	-- Step 48: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Retour à {area:1099}",

	-- Step 49: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maître de vol de {area:1099}",

	-- Step 50: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",

	-- Step 52: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, à côté du maître des coursiers du vent",

	-- Step 53: The Egg-O-Matic
	-- {object:142071} Egg-O-Matic
	["The {object:142071}"] = "Le {object:142071}",
	-- {object:142071} Egg-O-Matic
	["The {object:142071}, in the middle of town"] = "L'{object:142071}, au centre de la ville",

	-- Step 54: Marin Noggenfogger
	-- {zone:1449} Un'Goro Crater
	["Pestlezugg's samples come from {zone:1449}."] = "Les échantillons de Pestlezugg viennent de {zone:1449}.",

	-- Step 55: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Suivez la route vers le sud jusqu'à {area:1938} ; {npc:7771} campe à côté. De là, la route vers l'ouest descend dans {zone:1449}, où commence le guide suivant.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Gardez {quest:3444} : le coffre de {npc:7771} s'ouvre lors d'une visite ultérieure.",

	-- Step 56: The Dunemaul Compound
	-- {area:1938} Broken Pillar · {npc:12046} Gor'marok the Ravager · {npc:11758} Andi Lynn · {zone:1446} Tanaris
	["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, carried from your first {zone:1446} visit."] = "Au sud du {area:1938}, les ogres Cognedune tiennent leur camp, avec {npc:12046} à son extrémité est : la quête de {npc:11758}, gardée depuis votre première visite en {zone:1446}.",

	-- Step 57: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley · {npc:7876} Tran'rek · {zone:1446} Tanaris · {area:976} Gadgetzan · {npc:11758} Andi Lynn
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "À l'ouest du camp, sur le chemin de la rampe d'Un'Goro : les Chardonniers noueux et les Modeleurs de racines (48-50) de {quest:3362} sont pour {npc:7876}, gardée depuis votre première visite en {zone:1446}. Ils se déplacent beaucoup : attirez-les un par un. {npc:7876} la reprend lors de l'arrêt à {area:976} du guide suivant, avec celle de {npc:11758}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",
	-- ["Back north-east to {npc:8420}."] = "Retournez au nord-est voir {npc:8420}.",
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Prenez un vol de {area:1237} pour {zone:1454}, sortez par la grande porte jusqu'aux tours des zeppelins et prenez le zeppelin pour {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- ["Fly to {area:1638}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Prenez un vol pour {area:1638} ; c'est sur la route de {area:1099}. Pas encore de trajet aérien là-bas ? Prenez un vol pour {area:378} et traversez {zone:1412} vers l'ouest. Hamuul et {npc:4046} sont sur {area:1639} ; druides et paladins s'entraînent ici ({npc:3033}, {npc:246344}).",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["Fly to {zone:1456}"] = "Prendre un vol pour {zone:1456}",
	-- ["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Volez jusqu'aux {zone:1456} ; c'est sur le chemin du {area:1099}. Pas encore de trajet aérien ? Volez jusqu'au {area:378} et allez vers l'ouest à travers {zone:1412}. Hamuul et {npc:4046} sont sur la {area:1639} ; les Druides et les Paladins s'entraînent ici ({npc:3033}, {npc:246344}).",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Suivez la route vers le sud ; les basilics se prélassent sur les rochers à l'est, au milieu de la jungle. Leurs éclats tombent souvent.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "Chez le maître de vol de {area:3317}, prenez un vol pour {area:1497}.",
	-- ["Hearth to {area:1099}"] = "Pierre de foyer vers {area:1099}",
	-- ["Highborne and Haldarr satyrs"] = "Bien-nés et satyres Haldarr",
	-- ["If you skipped {quest:8552} or {quest:591}, grind here to level 49.93 to stay on the route's plan."] = "Si vous avez passé {quest:8552} ou {quest:591}, tuez des monstres ici jusqu'au niveau 49.93 pour rester dans le plan de la route.",
	-- ["Ironjaw Basilisks"] = "Basilics gueule de fer",
	-- ["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Gardez les livraisons pour {npc:4046}, {npc:8659} et {npc:6522} : vous passerez plus tard par {zone:1456}, {zone:1454} et {zone:1458}.",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Gardez {area:1417} pour {npc:7771}, à {zone:1446}.",
	-- ["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Gardez le paiement de {npc:8659} et {quest:3504} d'Ag'tor : ils retournent à {area:1237} lors d'une visite ultérieure.",
	-- ["Level 49.93"] = "Niveau 49.93",
	-- ["Level 50"] = "Niveau 50",
	-- ["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}, and its experience shortens the top-up to 50 in {zone:1447}."] = "En traversant {zone:1454} vers le maître de vol, passez par la Herse : {npc:7010} prend le rapport sur les insectes de {zone:1446}, et son expérience raccourcit la mise à niveau jusqu'à 50 en {zone:1447}.",
	-- ["Only once all three robots are home"] = "Seulement une fois les trois robots rentrés",
	-- ["Ride into {area:16}"] = "Entrez en {area:16}",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Allez au nord-est jusqu'au camp du gobelin sur les falaises au-dessus de {area:1227}.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Allez au nord-ouest jusqu'à {area:1108} ; {npc:14637} attend sur le quai.",
	-- ["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Allez au sud-ouest jusqu'aux ruines. Les quatre tablettes s'y trouvent, gardées par les nagas Fouette-bile ; toute Sirène ou tout Myrmidon Fouette-bile peut porter la rune de {npc:8420}.",
	-- ["Ride west back to {area:1237}."] = "Retournez à l'ouest jusqu'à {area:1237}.",
	-- ["Sea elementals"] = "Elémentaires marins",
	-- ["South down the road again.\nRide south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Redescendez la route vers le sud.\nAllez vers le sud par la route jusqu'au {area:1938} ; {npc:7771} campe à côté. D'ici, la route vers l'ouest descend dans le {zone:1449}, où commence le prochain guide.",
	-- ["Stay here: the next guide starts with the flight to {area:976}."] = "Restez ici : le prochain guide commence par le vol vers {area:976}.",
	-- ["Take the zeppelin back to {zone:1454}."] = "Reprenez le zeppelin pour {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Prenez le zeppelin pour {zone:1454} à la tour devant {zone:1458}, puis prenez un vol pour {area:431}.",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Les Marcheurs des terres et les Géants des falaises parcourent les collines au nord du quai. Réduisez d'abord chacun avec l'{item:18904} : réduits, ils ne sont plus élites. Chaque géant réduit lâche un résidu ; utilisez aussi le récipient miniaturisé sur son corps.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Les Elémentaires marins et les Embruns ondoient le long du rivage autour du quai.",
	-- ["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Les Hippogryphes Tête-tonnerre survolent les collines juste au sud de {area:1237}.",
	-- ["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Le camp des elfes de sang se trouve juste au sud de {npc:8420}. Ses quatre pièces d'équipement sont dans les caisses autour du camp.",
	-- ["The {object:2076} beside {npc:2519}"] = "Le {object:2076} à côté de {npc:2519}",
	-- ["To {object:3202}"] = "Vers {object:3202}",
	-- ["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it."] = "Complétez ici jusqu'au niveau 50 : {quest:4493}, de {npc:7010} à {zone:1454} à la fin d'{zone:1447}, le demande.",
	-- ["Undamaged Hippogryph Feathers"] = "Plumes d'hippogryphe sans défaut",
	-- ["Upstairs"] = "À l'étage",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "La tour de Xylem se dresse sur la falaise juste au nord de {area:1237} ; le chemin monte en lacets par son flanc nord.",
	-- ["Zapped giants"] = "Géants réduits",
	-- ["grind on {npc:6125}"] = "tuez en boucle : {npc:6125}",
	-- ["{area:1221}: kill these as you meet them"] = "{area:1221} : tuez-les au passage",
	-- ["{npc:6986}, the {object:172959}"] = "{npc:6986}, {object:172959}",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776} : les ours sont dans {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} se trouve dans {object:36082}.",
	-- ["{npc:7854}, inside"] = "{npc:7854}, à l'intérieur",
	-- ["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Le goudron de {npc:7876} et les échantillons de l'Alchimiste Pestlezugg viennent de {zone:1449}.",
	-- ["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, à la lisière est du camp : pas d'expérience, seulement une téléportation vers la tour d'Azshara",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- ["{object:3202} flight master"] = "Maître de vol de Grom'gol",
	-- ["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} se récolte dans le guide suivant ; le paiement de {npc:4046} retourne à {npc:8587} plus tard.",
}
