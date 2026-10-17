-- German (deDE): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran
	["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} steht in {area:2103}; {npc:2094} steht am Nordtor.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}"] = "{npc:2104}: für {npc:270637}",

	-- Step 2: Prospector Whelgar
	-- {area:118} Whelgar's Excavation Site
	["Follow the road east to {area:118}."] = "Folge der Straße nach Osten zu {area:118}.",

	-- Step 3: Goaz Warder
	-- {item:279996} Goaz Stone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Die Goazwärter stehen gleich westlich von Whelgars Lager: Benutze neben einem davon {item:279996}, den er dir gegeben hat.",

	-- Step 4: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Ein neuer {item:279996}, für die vier Titanenwächter rund um das {zone:1437}",

	-- Step 5: The Green Belt
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Folge der Straße nach Nordosten in {area:1025}: {npc:270637} lagert daneben, {npc:1244} ein Stück weiter östlich.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, ein Elite-Raptor",

	-- Step 6: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Nach Süden zum {area:1036} der Dragonmaw: Das erste Katapult steht auf dem Weg, und {object:671518} liegt im Lager.",
	["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "Der nächste Schritt, Sieg über Nek'rosh, stellt dich gegen einen Elite-Häuptling: Überspring ihn.",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: für {npc:2104}",

	-- Step 7: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} steht in den südöstlichen Hügeln: Benutze daneben {item:279996}.",

	-- Step 8: Dragonmaw Gates
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 9: Whelps, raptors and Neru
	-- {npc:271458} Neru
	["Whelps, raptors and {npc:271458}"] = "Welpen, Raptoren und {npc:271458}",
	-- {area:1025} The Green Belt · {npc:271458} Neru · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Rote Welpen füllen die Hügel westlich der Tore, Wahnsinnige Faulklauen ({npc:271334}) {area:1025}, Scharfzähne die nördlichen Hänge; {npc:271458} steht im Nordosten (benutze {item:279996}).\n{quest:98283} ist Elite: Eine Gruppe wird empfohlen.",

	-- Step 10: The Green Belt
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Für König Magni in {zone:1455}, am Ende dieses Guides",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Nach Norden die Straße entlang nach {area:205}. {npc:271460} steht in den Ruinen (benutze {item:279996}); {npc:271481} wird auf der Westseite festgehalten: Führ ihn hinaus zu {npc:1072}.",

	-- Step 12: The Villards
	["The Villards"] = "Die Villards",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:881} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} wartet nördlich von {area:205} am {area:881}; {npc:271322} ein kurzes Stück weiter nordöstlich.",

	-- Step 13: Prospector Whelgar
	["Back south down the road to the excavation site."] = "Die Straße zurück nach Süden zur Ausgrabungsstätte.",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Für {npc:2916} in {zone:1455}, am Ende dieses Guides",

	-- Step 14: Menethil Harbor
	["West along the road to Menethil."] = "Nach Westen die Straße entlang nach Menethil.",

	-- Step 15: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Schiff nach {area:271}",

	-- Step 16: Southshore
	-- {npc:251493} Captain McManus · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Nimm im Ort alles mit, bevor du aufbrichst. Vom Schiff aus triffst du zuerst {npc:251493}, nordwestlich des Flugmeisters; {npc:2381} und {npc:2438} stehen zwischen Flugmeister und Gasthaus, Farren und {npc:2366} im Gasthaus, Maleb im Rathaus.",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, von {npc:2381}",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: Die Löwen kommen später",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, im Gasthaus: für {area:35} (04-stranglethorn-vale)",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: Seine Spur führt nach Arathi",

	-- Step 17: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs der Fetzenflossen",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Die Murlocs der Fetzenflossen drängen sich am {area:295}, südwestlich von {area:271}.",

	-- Step 18: Farren
	["Farren"] = "Farren",

	-- Step 19: Murloc heads
	["Murloc heads"] = "Murlocköpfe",
	["Back to the same murlocs; not every one drops a head."] = "Zurück zu denselben Murlocs; nicht jeder lässt einen Kopf fallen.",

	-- Step 21: Daggerspine naga
	["Daggerspine naga"] = "Naga der Säbelflossen",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Die Naga halten das Ufer südöstlich von {area:271}.",

	-- Step 22: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}"] = "Ein Bericht für {object:2117}",

	-- Step 23: Snapjaws
	["Snapjaws"] = "Schnappkiefer",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Die Schnappkiefer-Schildkröten sonnen sich am Fluss östlich von {area:271}, südlich von {area:272} (Horde).",

	-- Step 24: Syndicate camp
	["Syndicate camp"] = "Syndikatslager",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "Das Syndikatslager liegt an der Grenze zu Alterac im Norden von {area:287}, westlich von {area:272} (Horde); die Dokumente liegen im Lager.",

	-- Step 25: Yeti cave
	["Yeti cave"] = "Yetihöhle",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Die Yetis leben in der Höhle in den Hügeln nördlich von {area:271}, auf deinem Rückweg nach Süden.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} will außerdem {item:3719}, {item:2997} und {item:2321}: hergestellt oder gekauft; den Umhang gibst du ab, wenn du später wieder in {area:271} bist.",

	-- Step 26: Hillsbrad's town hall
	-- {area:287} Hillsbrad
	["{area:287}'s town hall"] = "Rathaus von {area:287}",
	-- {area:287} Hillsbrad · {item:279386} Sealed Company Request · {npc:2335} Magistrate Burnside
	["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Nach Westen zu den Höfen von {area:287}: Leg {item:279386} auf den Buchhaltungstisch im Rathaus, wo {npc:2335} und die Ratsherren stehen.",
	-- {area:287} Hillsbrad
	["{area:287} town hall"] = "Rathaus von {area:287}",

	-- Step 28: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {npc:2432} Darla Harris · {area:271} Southshore
	["From {npc:2432} in {area:271}"] = "Von {npc:2432} in {area:271}",

	-- Step 29: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "Der Käseladen im {object:2096}.",

	-- Step 30: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} wartet in der Taverne „Zum Schwein und Pfeife“ in {object:2100}; er und seine zwei Schläger greifen dich an, hören aber auf, sobald sie besiegt sind.",

	-- Step 31: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} bildet in {object:2100} Krieger aus, neben der Taverne „Zum Schwein und Pfeife“. {npc:6236} wartet auf {area:720} im {zone:1413}, auf dem Weg nach {area:392} viel später (40-50/01).",

	-- Step 33: Cathedral of Light
	["Cathedral of Light"] = "Kathedrale des Lichts",

	-- Step 34: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} ist im {object:2164}; {npc:211033} nahe dem Kanal; {npc:5081} südlich vom {object:2101}.",

	-- Step 36: Druid training
	["Druid training"] = "Druidenausbildung",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} hat keinen Druidenlehrer: Trainiere vor der Bahn bei {npc:5504} in {zone:1453}.",

	-- Step 37: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Nimm die {area:2257} vom {object:28027} nach {zone:1455}.",
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	["Level 30 and 32 spells"] = "Zauber der Stufen 30 und 32",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Zerstöre die vier Sätze Angriffspläne im Lager für {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Folge der Straße nach Nordosten in {area:1025}: {npc:270637} lagert daneben, {npc:1244} ein Stück weiter östlich.",
	-- ["Golm"] = "Golm",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Nach Nordosten zu {area:1038}: {npc:271373} werden dort festgehalten, und {npc:271338} steht an den Toren (benutze {item:279996}).",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Rote Welpen füllen die Hügel westlich der Tore, Wahnsinnige Faulklauen ({npc:271334}) {area:1025}, Scharfzähne die nördlichen Hänge; Neru steht im Nordosten (benutze {item:279996}).\n{quest:98283} ist Elite: Such dir am besten eine Gruppe.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Nach Süden zum {area:1036} des Drachenmals; {object:671518} liegt im Lager.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} steht in {area:2103}; {npc:2094} und {npc:270844} stehen zusammen am Nordtor.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: für {npc:3649} in {area:442} (02-desolace)",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} hat keinen Druidenlehrer: Trainiere vor der Bahn bei {npc:5504} in {zone:1453}.",
}
