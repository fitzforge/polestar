-- German (deDE): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Geh zurück nach Westen zur Straße und folge ihr nach Süden aus {zone:1432} durch den Pass in die {zone:1418}. {npc:2910} und {npc:2860} lagern Seite an Seite an der Grabungsstätte.",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Die Zwerge der Schattenschmiede lagern gleich nördlich der Ausgrabungsstätte; die zerknitterte Karte liegt zwischen ihren Zelten. Tunnelgräber und Dunkelwirker tragen Ryedols Spitzhacke. Klippenkojoten streifen über die Hänge drumherum.",

	-- Step 5: The excavation crate
	["The excavation crate"] = "Die Ausgrabungskiste",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Geh nach Nordosten zur verlassenen Grabungsstätte; die Versorgungskiste liegt dort zwischen den Ogern der Staubbäuche.",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "Ryedols nächster Auftrag führt nach {area:1517}: Überspring ihn.",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} und {npc:2817} lagern zusammen im {area:1877}, mitten im {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Die Muscheln liegen an der Nordwestküste des Schlingendorntals, im nächsten Guide: Behalte sie",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Das zerschlagene Skelett liegt gleich östlich der Oger, am Rand des Lagers der Steingrufttroggs; die Knochenknacker und Schamanen drumherum lassen die Splitter fallen. Theldurin sitzt weiter südlich beim zerstörten Lager.",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "",

	-- Step 10: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Geh nach Westen in die {area:1878}; {npc:2921} arbeitet in der Mitte bei seinen Maschinen.",

	-- Step 11: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Kleine Felselementare",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "",

	-- Step 13: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Head north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Geh nach Nordosten zu den Zwergenruinen im Norden der {zone:1418}; die Truhe steht zwischen den Zwergen der Schattenschmiede. {npc:2745} in der Nähe ist Elite: Gib ihm Raum.",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "",

	-- Step 14: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:345} Agmond's End
	["Head south down the road: {npc:4618} and {npc:2817} camp in the {area:1877}, on the way to {area:345}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "",

	-- Step 15: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "Geh nach Süden zu {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "für {npc:2786} in {zone:1455}: behalte sie",

	-- Step 16: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Felselementare",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Die Felselementare streifen südöstlich von {npc:2921} umher; Riesenbussarde und Alte Klippenkojoten teilen sich die Ebene westlich davon.",

	-- Step 17: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "",

	-- Step 18: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "",

	-- Step 20: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, neben {npc:2921}",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 22: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "",

	-- Step 23: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 25: Theramore flight master
	["Theramore flight master"] = "",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "",

	-- Step 26: Nijel's Point
	-- {npc:5638} Kreldig Ungor
	["{npc:5638}: the wreck is on the north-west coast, at the end of the loop"] = "",

	-- Step 27: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Folge der Straße nach Süden zu {area:2407}.",

	-- Step 28: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} steht am Rand des {area:596}, südwestlich von {area:2407}; {object:176751} liegen zwischen den Skeletten. Ein {npc:217590} krabbelt auf dem Friedhof herum: Fang einen mit dem Einsteigerpaket für Entomologen und hak ihn dann ab.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: fang ihn, für My Little Friends",

	-- Step 29: Maraudine centaurs
	["Maraudine centaurs"] = "Zentauren der Maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Die Zentauren der Maraudine halten das {area:607} westlich des Friedhofs; jede Art lässt die Totems fallen.",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "eskortiere {npc:12277} zurück zum Friedhof",

	-- Step 31: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "",

	-- Step 32: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Untote Verheerer streifen über die Knochenfelder südlich des Dorfs der Magram, östlich des Kovens; ganz im Südosten benutzt du {item:15848}, um die Schreckgespenster der Magram anzulocken.",

	-- Step 35: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Folge der Straße nach Westen durch den Norden von {zone:1443} zu den Ruinen von {area:2405}. Dort steht {npc:11863}s Turm auf dem Hügel, auf dem Weg zum Wrack.",

	-- Step 36: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "Die Truhe des Schiffswracks liegt am Ufer gleich westlich von {npc:11863}s Turm.",

	-- Step 37: Claim Rackmore's Treasure!
	["Underwater"] = "",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Folge der Straße nach Norden zu {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "für {npc:5637} in {zone:1455}: behalte sie",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "für {npc:3980} in {area:271}: behalte sie",

	-- Step 39: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "",
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, ein Zentaurenhäuptling, lagert an der Nordwestküste, nördlich von {npc:11863}s Turm.",

	-- Step 44: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",
	["The next guide starts in Theramore."] = "Der nächste Guide beginnt in Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Folge der Straße nach Westen durch den Norden von {zone:1443} zu den Ruinen von {area:2405}; die Truhe des Schiffswracks liegt gleich westlich davon am Ufer.",
	-- ["Greater Rock Elementals"] = "Große Felselementare",
	-- ["Head back west to the road and follow it south out of {zone:1432} through the pass into the {area:3}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Geh zurück nach Westen zur Straße und folge ihr nach Süden aus {zone:1432} durch den Pass in die {area:3}. {npc:2910} und {npc:2860} lagern Seite an Seite an der Grabungsstätte.",
	-- ["Head north-east to the dwarven ruins in the north of the {area:3}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Geh nach Nordosten zu den Zwergenruinen im Norden der {area:3}; die Truhe steht zwischen den Zwergen der Schattenschmiede. {npc:2745} in der Nähe ist Elite: Gib ihm Raum.",
	-- ["Lesser Rock Elementals"] = "Kleine Felselementare",
	-- ["Ogres and buzzards"] = "Oger und Bussarde",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Reite zurück nach Westen zur Straße und folge ihr nach Süden aus {zone:1432} durch den Pass ins {zone:1418}. {npc:2910} und {npc:2860} lagern nebeneinander bei der Ausgrabung.",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Reite nach Nordosten zur verlassenen Ausgrabung; die Vorratskiste liegt dort zwischen den Ogern der Staubspeier.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Reite nach Nordosten zu den Zwergenruinen im Norden des {zone:1418}; die Truhe steht zwischen den Zwergen der Schattenschmiede. {npc:2745} in der Nähe ist Elite: Halte Abstand.",
	-- ["Ride south to {area:345}."] = "Reite nach Süden zur {area:345}.",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Reite nach Westen in {area:1878}; {npc:2921} arbeitet mitten darin an seinen Maschinen.",
	-- ["Shadowforge camp"] = "Lager der Schattenschmiede",
	-- ["Take the boat to Theramore from the far pier."] = "Nimm vom hinteren Pier das Schiff nach Theramore.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Die Oger der Staubspeier lagern gleich südlich des Tals; jeder von ihnen lässt Schrott fallen. Bussarde kreisen über der Ebene im Osten.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Die Großen Felselementare (Stufe 42) wandern in der äußersten Südwestecke unterhalb von {area:342}; zieh sie einzeln. Die Wyrmjäger und Raufer der Staubspeier bei {area:342} lassen auch Schrott fallen.",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Die Kleinen Felselementare streifen durch {area:1878} westlich von {npc:2921}.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Das zerschlagene Skelett liegt gleich östlich der Oger, am Rand des Lagers der Steingrufttroggs; die Knochenknacker und Schamanen drumherum lassen die Splitter fallen. Theldurin sitzt weiter südlich beim zerstörten Lager.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Die Dämonen versammeln sich bei {area:602} im Süden von {zone:1443}: Teufelshunde (Manafresser, Magier- und Leyjäger), Nethermaiden und Netherschwestern und Captains der Verdammniswächter rund um die Grube.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Der Flugmeister steht am Tor von {area:514}; {npc:5083} und {npc:4964} sind in der Zitadelle.",
	-- ["The next guide starts in Theramore."] = "Der nächste Guide beginnt in Theramore.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "Die nächste Aufgabe des Skeletts, Murdaloc, wartet bis zum späteren Guide für das {zone:1418} mit 43.",
	-- ["Theramore"] = "Theramore",
	-- ["for the Dustwallow loop in the next guide"] = "für die Runde durch die Marschen von Dustwallow im nächsten Guide",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "für {npc:4454} in {area:439}: Der Guide für {zone:1446} kommt mit 45 dort vorbei, behalte sie",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "nur wenn du {item:2868} dabeihast (von Schmieden hergestellt)",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "Die Karawane von {npc:11626} hält an der Straße östlich von {area:606}. Nimm die Quest an und geh mit den Kodos an {area:602} vorbei; töte die Dämonen, die sie anspringen. Sprich danach mit {npc:11596} in seinem Lager östlich des {area:596}.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "{npc:11863}s Turm steht auf dem Hügel östlich des Wracks.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} wird im Zentaurenlager westlich des Friedhofs gefangen gehalten. Befrei sie und halte sie auf dem Weg hinaus am Leben; sie hält beim Friedhof an.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, im Gasthaus",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "{npc:2921}s nächster Test braucht hergestellte Ausrüstung: Überspring ihn.",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "{npc:4618} und {npc:2817} lagern zusammen im {area:1877}, mitten im {area:3}.",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "{npc:5638}s nächste Aufgabe, {item:6245}, ist eine Beute an der fernen Küste: Überspring sie.",
}
