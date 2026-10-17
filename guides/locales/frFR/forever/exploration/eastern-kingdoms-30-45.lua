-- French (frFR): the guide forever/exploration/eastern-kingdoms-30-45 (forever/exploration/eastern-kingdoms-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 30-45"] = "Exploration : {zone:1415} 30-45",

	-- Step 1: Alterac Mountains (1/2)
	-- {zone:1424} Hillsbrad Foothills
	["Picks up in {zone:1424}, where the 1-30 guide leaves the Horde and passes the Alliance. 15 areas to discover here, levels 27-39."] = "Reprend aux {zone:1424}, où le guide 1-30 laisse la Horde et passe l'Alliance. 15 zones à découvrir ici, niveaux 27-39.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Explorer toute la carte du monde avec un seul personnage est un défi d'héritage de Forever (1 point d'héritage pour tout le compte).",
	-- {area:271} Southshore · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:271} in {zone:1424} and walk north into the {zone:1416}."] = "Volez jusqu'à {area:271}, dans les {zone:1424}, et marchez vers le nord jusqu'aux {zone:1416}.",
	-- {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:272} in {zone:1424} and walk north into the {zone:1416}."] = "Volez jusqu'à {area:272}, dans les {zone:1424}, et marchez vers le nord jusqu'aux {zone:1416}.",
	["any one of these names counts"] = "n'importe lequel de ces noms compte",

	-- Step 3: Arathi Highlands (1/2)
	["16 areas to discover here, levels 30-40."] = "16 zones à découvrir ici, niveaux 30-40.",
	-- {zone:1417} Arathi Highlands · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	["The {zone:1417} lie east of the {zone:1416} and {zone:1424}."] = "Les {zone:1417} se trouvent à l'est des {zone:1416} et des {zone:1424}.",
	-- {area:320} Refuge Pointe · {area:321} Hammerfall
	["{area:320} in the middle is the Alliance town; {area:321} in the east is Horde."] = "{area:320}, au centre, est la ville de l'Alliance ; {area:321}, à l'est, est à la Horde.",
	-- {area:321} Hammerfall · {area:320} Refuge Pointe
	["{area:321} in the east is the Horde town; {area:320} in the middle is Alliance."] = "{area:321}, à l'est, est la ville de la Horde ; {area:320}, au centre, est à l'Alliance.",
	-- {area:320} Refuge Pointe · {npc:2835} Cedrik Prose
	["Flight path here: {area:320} ({npc:2835})."] = "Trajet aérien ici : {area:320} ({npc:2835}).",
	-- {area:321} Hammerfall
	["Flight path here: {area:321} (Urda)."] = "Trajet aérien ici : {area:321} (Urda).",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "Ville de l'Alliance : les personnages de la Horde n'ont qu'à en toucher le bord (gardes)",

	-- Step 4: Arathi Highlands (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "Ville de la Horde : les personnages de l'Alliance n'ont qu'à en toucher le bord (gardes)",
	["elite Syndicate and ogres inside the walls: the discovery triggers at the gate"] = "Syndicat et ogres élites dans l'enceinte : la découverte se déclenche à la porte",

	-- Step 5: Badlands (1/2)
	["14 areas to discover here, levels 36-45."] = "14 zones à découvrir ici, niveaux 36-45.",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {zone:1418} Badlands
	["Cross the {area:880} south into the {zone:1437}, go through the {object:1668} pass into {zone:1432} and take the road south out of {zone:1432} into the {zone:1418}."] = "Traversez {area:880} vers le sud jusqu'aux {zone:1437}, passez le col de {object:1668} jusqu'au {zone:1432} et prenez la route vers le sud hors du {zone:1432} jusqu'aux {zone:1418}.",
	-- {area:144} Thelsamar · {zone:1432} Loch Modan
	["Faster: fly to {area:144} in {zone:1432}."] = "Plus rapide : volez jusqu'à {area:144}, au {zone:1432}.",
	-- {area:340} Kargath
	["{area:340} in the west is the Horde town."] = "{area:340}, à l'ouest, est la ville de la Horde.",
	-- {area:340} Kargath
	["Flight path here: {area:340} (Gorrik)."] = "Trajet aérien ici : {area:340} (Gorrik).",

	-- Step 7: Riverglades (1/2)
	["14 areas to discover here, levels 36-44."] = "14 zones à découvrir ici, niveaux 36-44.",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1428} Burning Steppes · {zone:1433} Redridge Mountains · {zone:1446} Tanaris · {area:16727} Powderfuse Port · {area:17780} Krol'dok Stronghold
	["The {zone:2548} lie east of the {zone:1418} and the {zone:1428}: the way in is the fork east off the {zone:1433} road (a ship also runs from {zone:1446} to {area:16727}, the neutral goblin port on its coast). {area:17780} is an ogre clan's outdoor dungeon."] = "{zone:2548} se trouve à l'est des {zone:1418} et de {zone:1428} : on y entre par l'embranchement à l'est de la route des {zone:1433} (un navire relie aussi {zone:1446} à {area:16727}, le port gobelin neutre sur sa côte). {area:17780} est le donjon extérieur d'un clan d'ogres.",

	-- Step 9: Stranglethorn Vale (1/4)
	-- {area:35} Booty Bay · {area:392} Ratchet
	["27 areas to discover here, levels 30-50. {area:35} at the southern tip is a neutral goblin port with a boat to {area:392}."] = "27 zones à découvrir ici, niveaux 30-50. {area:35}, à la pointe sud, est un port gobelin neutre avec un bateau pour {area:392}.",
	-- {area:42} Darkshire · {zone:1453} Stormwind · {zone:1431} Duskwood · {zone:1434} Stranglethorn Vale
	["Fly to {area:42} (or {zone:1453}) and take the road south out of {zone:1431} into northern {zone:1434}."] = "Volez jusqu'à {area:42} (ou {zone:1453}) et prenez la route vers le sud hors de {zone:1431} jusqu'au nord de {zone:1434}.",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:117} Grom'gol Base Camp
	["Take the zeppelin from {zone:1454} or the {zone:1458} to {area:117}."] = "Prenez le zeppelin depuis {zone:1454} ou {zone:1458} jusqu'à {area:117}.",
	-- {area:35} Booty Bay
	["Flight path here: {area:35} (Gyll)."] = "Trajet aérien ici : {area:35} (Gyll).",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Flight paths here: {area:35} (Gringer), {object:3202} (Thysta)."] = "Trajets aériens ici : {area:35} (Gringer), {object:3202} (Thysta).",

	-- Step 10: Stranglethorn Vale (2/4)
	["free-for-all PvP inside the arena ring"] = "JcJ sans restriction dans l'arène",

	-- Step 11: Stranglethorn Vale (3/4)
	["level 50 area, well above this guide's range"] = "zone de niveau 50, bien au-dessus de ce guide",

	-- Step 12: Stranglethorn Vale (4/4)
	["elite ogres: discover it from the edge"] = "ogres élites : découvrez-la depuis le bord",

	-- Step 13: Swamp of Sorrows (1/2)
	["11 areas to discover here, levels 36-43."] = "11 zones à découvrir ici, niveaux 36-43.",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows
	["Go back north into {zone:1431} and follow its road east through {zone:1430} (level 50+ creatures off the road) into the {zone:1435}."] = "Revenez au nord dans {zone:1431} et suivez sa route vers l'est à travers {zone:1430} (créatures de niveau 50+ hors de la route) jusqu'au {zone:1435}.",
	-- {area:75} Stonard
	["{area:75} is the Horde town."] = "{area:75} est la ville de la Horde.",
	-- {area:75} Stonard
	["Flight path here: {area:75} (Breyk)."] = "Trajet aérien ici : {area:75} (Breyk).",
}
