-- German (deDE): the guide forever/exploration/eastern-kingdoms-30-45 (forever/exploration/eastern-kingdoms-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 30-45"] = "Erkundung: {zone:1415} 30-45",

	-- Step 1: Alterac Mountains (1/2)
	-- {zone:1424} Hillsbrad Foothills
	["Picks up in {zone:1424}, where the 1-30 guide leaves the Horde and passes the Alliance. 15 areas to discover here, levels 27-39."] = "Setzt in {zone:1424} ein, wo der Guide für 1-30 die Horde verlässt und die Allianz durchreist. Hier gibt es 15 Gebiete zu entdecken, Stufe 27-39.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Die gesamte Weltkarte mit einem Charakter zu erkunden, ist eine Vermächtnisherausforderung in Forever (1 accountweiter Vermächtnispunkt).",
	-- {area:271} Southshore · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:271} in {zone:1424} and walk north into the {zone:1416}."] = "Flieg nach {area:271} in {zone:1424} und geh nach Norden in {zone:1416}.",
	-- {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:272} in {zone:1424} and walk north into the {zone:1416}."] = "Flieg nach {area:272} in {zone:1424} und geh nach Norden in {zone:1416}.",
	["any one of these names counts"] = "jeder dieser Namen zählt",

	-- Step 3: Arathi Highlands (1/2)
	["16 areas to discover here, levels 30-40."] = "Hier gibt es 16 Gebiete zu entdecken, Stufe 30-40.",
	-- {zone:1417} Arathi Highlands · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	["The {zone:1417} lie east of the {zone:1416} and {zone:1424}."] = "{zone:1417} liegt östlich von {zone:1416} und {zone:1424}.",
	-- {area:320} Refuge Pointe · {area:321} Hammerfall
	["{area:320} in the middle is the Alliance town; {area:321} in the east is Horde."] = "{area:320} in der Mitte ist die Allianzstadt; {area:321} im Osten gehört der Horde.",
	-- {area:321} Hammerfall · {area:320} Refuge Pointe
	["{area:321} in the east is the Horde town; {area:320} in the middle is Alliance."] = "{area:321} im Osten ist die Hordestadt; {area:320} in der Mitte gehört der Allianz.",
	-- {area:320} Refuge Pointe · {npc:2835} Cedrik Prose
	["Flight path here: {area:320} ({npc:2835})."] = "Flugroute hier: {area:320} ({npc:2835}).",
	-- {area:321} Hammerfall
	["Flight path here: {area:321} (Urda)."] = "Flugroute hier: {area:321} (Urda).",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "Allianzstadt: Hordecharaktere müssen nur ihren Rand berühren (Wachen)",

	-- Step 4: Arathi Highlands (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "Hordestadt: Allianzcharaktere müssen nur ihren Rand berühren (Wachen)",
	["elite Syndicate and ogres inside the walls: the discovery triggers at the gate"] = "Elite-Syndikat und Oger innerhalb der Mauern: Die Entdeckung löst schon am Tor aus",

	-- Step 5: Badlands (1/2)
	["14 areas to discover here, levels 36-45."] = "Hier gibt es 14 Gebiete zu entdecken, Stufe 36-45.",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {zone:1418} Badlands
	["Cross the {area:880} south into the {zone:1437}, go through the {object:1668} pass into {zone:1432} and take the road south out of {zone:1432} into the {zone:1418}."] = "Überquere {area:880} nach Süden ins {zone:1437}, geh durch den Pass {object:1668} nach {zone:1432} und nimm die Straße nach Süden aus {zone:1432} hinaus ins {zone:1418}.",
	-- {area:144} Thelsamar · {zone:1432} Loch Modan
	["Faster: fly to {area:144} in {zone:1432}."] = "Schneller: Flieg nach {area:144} in {zone:1432}.",
	-- {area:340} Kargath
	["{area:340} in the west is the Horde town."] = "{area:340} im Westen ist die Hordestadt.",
	-- {area:340} Kargath
	["Flight path here: {area:340} (Gorrik)."] = "Flugroute hier: {area:340} (Gorrik).",

	-- Step 7: Riverglades (1/2)
	["14 areas to discover here, levels 36-44."] = "Hier gibt es 14 Gebiete zu entdecken, Stufe 36-44.",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1428} Burning Steppes · {zone:1433} Redridge Mountains · {zone:1446} Tanaris · {area:16727} Powderfuse Port · {area:17780} Krol'dok Stronghold
	["The {zone:2548} lie east of the {zone:1418} and the {zone:1428}: the way in is the fork east off the {zone:1433} road (a ship also runs from {zone:1446} to {area:16727}, the neutral goblin port on its coast). {area:17780} is an ogre clan's outdoor dungeon."] = "{zone:2548} liegt östlich von {zone:1418} und {zone:1428}: Der Weg hinein ist die Abzweigung nach Osten von der Straße in {zone:1433} (ein Schiff fährt auch von {zone:1446} nach {area:16727}, dem neutralen Goblinhafen an der Küste). {area:17780} ist der Freiluft-Dungeon eines Ogerklans.",

	-- Step 9: Stranglethorn Vale (1/4)
	-- {area:35} Booty Bay · {area:392} Ratchet
	["27 areas to discover here, levels 30-50. {area:35} at the southern tip is a neutral goblin port with a boat to {area:392}."] = "Hier gibt es 27 Gebiete zu entdecken, Stufe 30-50. {area:35} an der Südspitze ist ein neutraler Goblinhafen mit einem Schiff nach {area:392}.",
	-- {area:42} Darkshire · {zone:1453} Stormwind · {zone:1431} Duskwood · {zone:1434} Stranglethorn Vale
	["Fly to {area:42} (or {zone:1453}) and take the road south out of {zone:1431} into northern {zone:1434}."] = "Flieg nach {area:42} (oder {zone:1453}) und nimm die Straße nach Süden aus {zone:1431} hinaus in den Norden von {zone:1434}.",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:117} Grom'gol Base Camp
	["Take the zeppelin from {zone:1454} or the {zone:1458} to {area:117}."] = "Nimm den Zeppelin von {zone:1454} oder {zone:1458} nach {area:117}.",
	-- {area:35} Booty Bay
	["Flight path here: {area:35} (Gyll)."] = "Flugroute hier: {area:35} (Gyll).",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Flight paths here: {area:35} (Gringer), {object:3202} (Thysta)."] = "Flugrouten hier: {area:35} (Gringer), {object:3202} (Thysta).",

	-- Step 10: Stranglethorn Vale (2/4)
	["free-for-all PvP inside the arena ring"] = "Freies PvP für alle innerhalb des Arenarings",

	-- Step 11: Stranglethorn Vale (3/4)
	["level 50 area, well above this guide's range"] = "Gebiet der Stufe 50, weit über dem Bereich dieses Guides",

	-- Step 12: Stranglethorn Vale (4/4)
	["elite ogres: discover it from the edge"] = "Elite-Oger: Entdecke es vom Rand aus",

	-- Step 13: Swamp of Sorrows (1/2)
	["11 areas to discover here, levels 36-43."] = "Hier gibt es 11 Gebiete zu entdecken, Stufe 36-43.",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows
	["Go back north into {zone:1431} and follow its road east through {zone:1430} (level 50+ creatures off the road) into the {zone:1435}."] = "Geh zurück nach Norden in {zone:1431} und folge der Straße nach Osten durch {zone:1430} (Kreaturen ab Stufe 50 abseits der Straße) in {zone:1435}.",
	-- {area:75} Stonard
	["{area:75} is the Horde town."] = "{area:75} ist die Hordestadt.",
	-- {area:75} Stonard
	["Flight path here: {area:75} (Breyk)."] = "Flugroute hier: {area:75} (Breyk).",
}
