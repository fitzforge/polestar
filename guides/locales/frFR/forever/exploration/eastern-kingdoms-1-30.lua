-- French (frFR): the guide forever/exploration/eastern-kingdoms-1-30 (forever/exploration/eastern-kingdoms-1-30.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 1-30"] = "Exploration : {zone:1415} 1-30",

	-- Step 1: Elwynn Forest (1/2)
	-- {zone:1429} Elwynn Forest · {zone:1426} Dun Morogh
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Alliance starts in {zone:1429}; dwarves and gnomes can begin at the {zone:1426} step. 12 areas to discover here, levels 5-10."] = "Découvrir une zone rapporte de l'expérience selon son niveau : ce guide se suit donc en même temps que la progression. L'Alliance commence dans {zone:1429} ; nains et gnomes peuvent commencer à l'étape {zone:1426}. 12 zones à découvrir ici, niveaux 5-10.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Explorer toute la carte du monde avec un seul personnage est un défi Héritage Forever (1 point d'Héritage pour tout le compte).",
	-- {area:9} Northshire Valley · {zone:1429} Elwynn Forest · {area:87} Goldshire
	["{area:9} opens onto {zone:1429}; {area:87} is south down the road."] = "{area:9} donne sur {zone:1429} ; {area:87} est au sud, en suivant la route.",

	-- Step 2: Elwynn Forest (2/2)
	["any one of these names counts"] = "n'importe lequel de ces noms compte",

	-- Step 3: Westfall (1/2)
	["14 areas to discover here, levels 9-18."] = "14 zones à découvrir ici, niveaux 9-18.",
	-- {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:120} Westbrook Garrison
	["{zone:1436} borders {zone:1429} to the west: follow the road out past the {area:120}."] = "{zone:1436} borde {zone:1429} à l'ouest : suivez la route au-delà de {area:120}.",
	-- {area:108} Sentinel Hill
	["Flight path here: {area:108} (Thor)."] = "Trajet aérien ici : {area:108} (Thor).",

	-- Step 5: Duskwood (1/2)
	["13 areas to discover here, levels 10-30."] = "13 zones à découvrir ici, niveaux 10-30.",
	-- {zone:1431} Duskwood · {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:42} Darkshire
	["{zone:1431} is east of {zone:1436} and south of {zone:1429}. Its road runs east to {area:42}."] = "{zone:1431} est à l'est de {zone:1436} et au sud de {zone:1429}. Sa route mène à l'est jusqu'à {area:42}.",
	-- {area:42} Darkshire · {npc:2409} Felicia Maline
	["Flight path here: {area:42} ({npc:2409})."] = "Trajet aérien ici : {area:42} ({npc:2409}).",

	-- Step 7: Redridge Mountains (1/2)
	["11 areas to discover here, levels 15-24."] = "11 zones à découvrir ici, niveaux 15-24.",
	-- {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood
	["Redridge starts at {area:1002}, where the roads from {zone:1429} and {zone:1431} meet."] = "Les Carmines commencent à {area:1002}, où se rejoignent les routes de {zone:1429} et de {zone:1431}.",
	-- {area:69} Lakeshire · {npc:931} Ariena Stormfeather
	["Flight path here: {area:69} ({npc:931})."] = "Trajet aérien ici : {area:69} ({npc:931}).",

	-- Step 9: Dun Morogh (1/3)
	["18 areas to discover here, levels 4-12."] = "18 zones à découvrir ici, niveaux 4-12.",
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind City · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "Prenez {area:2257} depuis {object:28027} de {zone:1453} jusqu'à {zone:1455} (ou prenez un vol pour {zone:1455}), puis quittez la ville par ses portes.",

	-- Step 12: Loch Modan (1/2)
	["11 areas to discover here, levels 10-18."] = "11 zones à découvrir ici, niveaux 10-18.",
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:925} Algaz Station
	["Leave {zone:1426} east through the gate tunnel; it opens into {zone:1432} at {area:925}."] = "Quittez {zone:1426} vers l'est par le tunnel de la porte ; il débouche sur {zone:1432} à {area:925}.",
	-- {area:144} Thelsamar · {npc:1572} Thorgrum Borrelson
	["Flight path here: {area:144} ({npc:1572})."] = "Trajet aérien ici : {area:144} ({npc:1572}).",

	-- Step 14: Wetlands (1/2)
	["15 areas to discover here, levels 20-30."] = "15 zones à découvrir ici, niveaux 20-30.",
	-- {area:925} Algaz Station · {area:836} Dun Algaz · {zone:1437} Wetlands
	["From {area:925}, the road north through the {area:836} pass leads into the {zone:1437}."] = "Depuis {area:925}, la route vers le nord par le col de {area:836} mène dans {zone:1437}.",
	-- {area:150} Menethil Harbor · {npc:1571} Shellei Brondir
	["Flight path here: {area:150} ({npc:1571})."] = "Trajet aérien ici : {area:150} ({npc:1571}).",
	-- {area:1038} Dragonmaw Gates · {area:1037} Grim Batol
	["the discovery triggers at the {area:1038}: do not go into {area:1037} itself"] = "la découverte se déclenche à {area:1038} : n'entrez pas dans {area:1037}",

	-- Step 16: Hillsbrad Foothills (1/2)
	["12 areas to discover here, levels 20-31."] = "12 zones à découvrir ici, niveaux 20-31.",
	-- {area:881} Thandol Span · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {zone:1424} Hillsbrad Foothills
	["Cross the {area:881} in northern {zone:1437} into the {zone:1417} (level 30+ creatures off the road), follow the road west past {area:320} and on into {zone:1424}."] = "Traversez {area:881}, au nord de {zone:1437}, pour entrer dans {zone:1417} (créatures de niveau 30+ hors de la route), puis suivez la route vers l'ouest après {area:320} jusque dans {zone:1424}.",
	-- {area:271} Southshore · {npc:2432} Darla Harris
	["Flight path here: {area:271} ({npc:2432})."] = "Trajet aérien ici : {area:271} ({npc:2432}).",
	-- {area:272} Tarren Mill
	["Horde guards: touch the edge of {area:272} and move on"] = "Gardes de la Horde : touchez le bord de {area:272} et repartez",

	-- Step 18: Silverpine Forest (1/2)
	["15 areas to discover here, levels 10-20."] = "15 zones à découvrir ici, niveaux 10-20.",
	-- {area:287} Hillsbrad · {area:285} Southpoint Tower · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["Follow the road west from {area:287} past {area:285} into {zone:1421}, Horde country with Horde guards at the {area:228}."] = "Suivez la route vers l'ouest depuis {area:287}, après {area:285}, jusque dans {zone:1421}, territoire de la Horde gardé à {area:228}.",
	-- {area:228} Sepulcher
	["Horde guards: touch the edge of {area:228} and move on"] = "Gardes de la Horde : touchez le bord de {area:228} et repartez",

	-- Step 20: Tirisfal Glades (1/3)
	["17 areas to discover here, levels 5-10."] = "17 zones à découvrir ici, niveaux 5-10.",
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {area:154} Deathknell · {zone:1458} Undercity
	["Silverpine's road north leads into {zone:1420}. {area:159}, {area:154} and the {zone:1458} ruins are Horde ground."] = "La route de la Forêt des Pins argentés mène au nord dans {zone:1420}. {area:159}, {area:154} et les ruines de {zone:1458} sont des terres de la Horde.",
	-- {area:153} Ruins of Lordaeron
	["Horde guards: touch the edge of {area:153} and move on"] = "Gardes de la Horde : touchez le bord de {area:153} et repartez",

	-- Step 21: Tirisfal Glades (2/3)
	-- {area:159} Brill
	["Horde guards: touch the edge of {area:159} and move on"] = "Gardes de la Horde : touchez le bord de {area:159} et repartez",

	-- Step 22: Tirisfal Glades (3/3)
	-- {area:154} Deathknell
	["Horde guards: touch the edge of {area:154} and move on"] = "Gardes de la Horde : touchez le bord de {area:154} et repartez",

	-- Step 23: Tirisfal Glades (1/3)
	-- {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Horde starts in {zone:1420}; orcs, trolls and tauren arrive by zeppelin from {zone:1454}. 17 areas to discover here, levels 5-10."] = "Découvrir une zone rapporte de l'expérience selon son niveau : ce guide se suit donc en même temps que la progression. La Horde commence dans {zone:1420} ; orcs, trolls et taurens arrivent en zeppelin depuis {zone:1454}. 17 zones à découvrir ici, niveaux 5-10.",
	-- {area:154} Deathknell · {zone:1420} Tirisfal Glades · {area:159} Brill · {zone:1458} Undercity
	["{area:154} opens onto {zone:1420}; {area:159} is east along the road. Orcs, trolls and tauren arrive at the zeppelin tower by the {zone:1458}."] = "{area:154} donne sur {zone:1420} ; {area:159} est à l'est, le long de la route. Orcs, trolls et taurens arrivent à la tour des zeppelins près de {zone:1458}.",

	-- Step 26: Silverpine Forest (1/2)
	-- {zone:1421} Silverpine Forest · {zone:1420} Tirisfal Glades · {area:159} Brill
	["{zone:1421} is south of {zone:1420}: follow the road south from {area:159}."] = "{zone:1421} est au sud de {zone:1420} : suivez la route vers le sud depuis {area:159}.",
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["Flight path here: {area:228} ({npc:2226})."] = "Trajet aérien ici : {area:228} ({npc:2226}).",

	-- Step 28: Hillsbrad Foothills (1/2)
	-- {zone:1424} Hillsbrad Foothills · {area:285} Southpoint Tower · {area:272} Tarren Mill · {area:271} Southshore
	["At the south end of Silverpine the road turns east into {zone:1424} by {area:285}. {area:272} in the north-east is the Horde town; {area:271} is Alliance."] = "Au sud de la Forêt des Pins argentés, la route tourne à l'est vers {zone:1424}, près de {area:285}. {area:272}, au nord-est, est la ville de la Horde ; {area:271} est à l'Alliance.",
	-- {area:272} Tarren Mill
	["Flight path here: {area:272} (Zarise)."] = "Trajet aérien ici : {area:272} (Zarise).",

	-- Step 29: Hillsbrad Foothills (2/2)
	-- {area:271} Southshore
	["Alliance guards: touch the edge of {area:271} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:271} et repartez",

	-- Step 30: Wetlands (1/2)
	-- {area:287} Hillsbrad · {zone:1417} Arathi Highlands · {area:881} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["Walk east from {area:287} into the {zone:1417} (level 30+ creatures off the road), south to the {area:881} bridge, and across it into the {zone:1437}. {area:150} is an Alliance town."] = "Marchez vers l'est depuis {area:287} jusque dans {zone:1417} (créatures de niveau 30+ hors de la route), au sud jusqu'au pont de {area:881}, et traversez-le pour entrer dans {zone:1437}. {area:150} est une ville de l'Alliance.",

	-- Step 31: Wetlands (2/2)
	-- {area:150} Menethil Harbor
	["Alliance guards: touch the edge of {area:150} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:150} et repartez",

	-- Step 32: Loch Modan (1/2)
	-- {area:836} Dun Algaz · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:925} Algaz Station
	["The {area:836} pass in south-eastern {zone:1437} leads down into {zone:1432} by {area:925}."] = "Le col de {area:836}, au sud-est de {zone:1437}, descend vers {zone:1432} près de {area:925}.",

	-- Step 33: Loch Modan (2/2)
	-- {area:144} Thelsamar
	["Alliance guards: touch the edge of {area:144} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:144} et repartez",

	-- Step 34: Dun Morogh (1/3)
	-- {area:925} Algaz Station · {zone:1426} Dun Morogh · {area:131} Kharanos · {zone:1455} Ironforge
	["From {area:925} take the tunnel west into {zone:1426}. {area:131} and {zone:1455}'s gates are Alliance ground."] = "Depuis {area:925}, prenez le tunnel vers l'ouest jusque dans {zone:1426}. {area:131} et les portes de {zone:1455} sont des terres de l'Alliance.",

	-- Step 35: Dun Morogh (2/3)
	-- {area:809} Gates of Ironforge
	["Alliance guards: touch the edge of {area:809} and move on; any one of these names counts"] = "Gardes de l'Alliance : touchez le bord de {area:809} et repartez ; n'importe lequel de ces noms compte",
	-- {area:131} Kharanos
	["Alliance guards: touch the edge of {area:131} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:131} et repartez",

	-- Step 36: Dun Morogh (3/3)
	-- {area:132} Coldridge Valley
	["Alliance guards: touch the edge of {area:132} and move on; any one of these names counts"] = "Gardes de l'Alliance : touchez le bord de {area:132} et repartez ; n'importe lequel de ces noms compte",

	-- Step 37: Duskwood (1/2)
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:117} Grom'gol Base Camp · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	["Hearth or fly back to the {zone:1458} (or go to {zone:1454}), take the zeppelin to {area:117} in {zone:1434} and walk north along the road into {zone:1431}. Northern Stranglethorn is level 30+ off the road."] = "Utilisez la pierre de foyer ou prenez un vol pour {zone:1458} (ou allez à {zone:1454}), prenez le zeppelin pour {area:117} dans {zone:1434} et suivez la route vers le nord jusque dans {zone:1431}. Le nord de Strangleronce est de niveau 30+ hors de la route.",
	-- {area:42} Darkshire
	["Alliance guards: touch the edge of {area:42} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:42} et repartez",

	-- Step 39: Westfall (1/2)
	-- {zone:1436} Westfall · {zone:1431} Duskwood · {area:108} Sentinel Hill
	["{zone:1436} borders {zone:1431} to the west. {area:108} is an Alliance town."] = "{zone:1436} borde {zone:1431} à l'ouest. {area:108} est une ville de l'Alliance.",

	-- Step 40: Westfall (2/2)
	-- {area:108} Sentinel Hill
	["Alliance guards: touch the edge of {area:108} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:108} et repartez",

	-- Step 41: Elwynn Forest (1/2)
	["12 areas to discover here, levels 5-10."] = "12 zones à découvrir ici, niveaux 5-10.",
	-- {zone:1429} Elwynn Forest · {zone:1436} Westfall · {zone:1431} Duskwood · {area:87} Goldshire · {area:9} Northshire Valley · {zone:1453} Stormwind City
	["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429} est au nord de {zone:1436} et de {zone:1431}. {area:87}, {area:9} et les portes de {zone:1453} sont des terres de l'Alliance gardées.",
	-- {zone:1453} Stormwind City
	["Alliance guards: touch the edge of {zone:1453} and move on; any one of these names counts"] = "Gardes de l'Alliance : touchez le bord de {zone:1453} et repartez ; n'importe lequel de ces noms compte",
	-- {area:9} Northshire Valley
	["Alliance guards: touch the edge of {area:9} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:9} et repartez",
	-- {area:87} Goldshire
	["Alliance guards: touch the edge of {area:87} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:87} et repartez",

	-- Step 43: Redridge Mountains (1/2)
	-- {zone:1429} Elwynn Forest · {area:1002} Three Corners · {area:69} Lakeshire
	["Go east through {zone:1429} to {area:1002}, where Redridge starts. {area:69} is an Alliance town."] = "Traversez {zone:1429} vers l'est jusqu'à {area:1002}, où commencent Les Carmines. {area:69} est une ville de l'Alliance.",
	-- {area:69} Lakeshire
	["Alliance guards: touch the edge of {area:69} and move on"] = "Gardes de l'Alliance : touchez le bord de {area:69} et repartez",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Flight path here: {area:228} ({npc:2226})."] = "Trajet aérien ici : {area:228} ({npc:2226}).",
	-- ["Horde guards: touch the edge of {area:228} and move on"] = "Gardes de la Horde : touchez le bord de {area:228} et repartez",
	-- ["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "Prenez {area:2257} depuis {object:28027} de {zone:1453} jusqu'à {zone:1455} (ou prenez un vol pour {zone:1455}), puis quittez la ville par ses portes.",
	-- ["The {area:228}"] = "{area:228}",
	-- ["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429} est au nord de {zone:1436} et de {zone:1431}. {area:87}, {area:9} et les portes de {zone:1453} sont des terres de l'Alliance gardées.",
}
