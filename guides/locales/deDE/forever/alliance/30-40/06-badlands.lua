-- German (deDE): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Reite zurück nach Westen zur Straße und folge ihr nach Süden aus {zone:1432} durch den Pass ins {zone:1418}. {npc:2910} und {npc:2860} lagern nebeneinander bei der Ausgrabung.",

	-- Step 2: Shadowforge camp
	["Shadowforge camp"] = "Lager der Schattenschmiede",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Die Zwerge der Schattenschmiede lagern gleich nördlich der Ausgrabungsstätte; die zerknitterte Karte liegt zwischen ihren Zelten. Tunnelgräber und Dunkelwirker tragen Ryedols Spitzhacke. Klippenkojoten streifen über die Hänge drumherum.",

	-- Step 3: The excavation crate
	["The excavation crate"] = "Die Ausgrabungskiste",
	["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Reite nach Nordosten zur verlassenen Ausgrabung; die Vorratskiste liegt dort zwischen den Ogern der Staubspeier.",

	-- Step 4: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "Ryedols nächster Auftrag führt nach {area:1517}: Überspring ihn.",

	-- Step 5: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} und {npc:2817} lagern zusammen im {area:1877}, mitten im {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Die Muscheln liegen an der Nordwestküste des Schlingendorntals, im nächsten Guide: Behalte sie",

	-- Step 6: Ogres and buzzards
	["Ogres and buzzards"] = "Oger und Bussarde",
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Die Oger der Staubspeier lagern gleich südlich des Tals; jeder von ihnen lässt Schrott fallen. Bussarde kreisen über der Ebene im Osten.",

	-- Step 7: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Das zerschlagene Skelett liegt gleich östlich der Oger, am Rand des Lagers der Steingrufttroggs; die Knochenknacker und Schamanen drumherum lassen die Splitter fallen. Theldurin sitzt weiter südlich beim zerstörten Lager.",
	-- {zone:1418} Badlands
	["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "Die nächste Aufgabe des Skeletts, Murdaloc, wartet bis zum späteren Guide für das {zone:1418} mit 43.",

	-- Step 8: Valley of Fangs
	-- {npc:4454} Fizzle Brassbolts · {area:439} Shimmering Flats · {zone:1446} Tanaris
	["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "für {npc:4454} in {area:439}: Der Guide für {zone:1446} kommt mit 45 dort vorbei, behalte sie",

	-- Step 9: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Reite nach Westen in {area:1878}; {npc:2921} arbeitet mitten darin an seinen Maschinen.",

	-- Step 10: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Kleine Felselementare",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Die Kleinen Felselementare streifen durch {area:1878} westlich von {npc:2921}.",

	-- Step 12: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Felselementare",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Die Felselementare streifen südöstlich von {npc:2921} umher; Riesenbussarde und Alte Klippenkojoten teilen sich die Ebene westlich davon.",

	-- Step 14: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Große Felselementare",
	-- {area:342} Camp Boff
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental · Dustbelcher Wyrmhunters = {npc:2716} Dustbelcher Wyrmhunter
	["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Die Großen Felselementare (Stufe 42) wandern in der äußersten Südwestecke unterhalb von {area:342}; zieh sie einzeln. Die Wyrmjäger und Raufer der Staubspeier bei {area:342} lassen auch Schrott fallen.",

	-- Step 15: Lotwil Veriatus
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, neben {npc:2921}",
	-- {item:2868} Patterned Bronze Bracers
	["only if you carry {item:2868} (a blacksmith's craft)"] = "nur wenn du {item:2868} dabeihast (von Schmieden hergestellt)",
	-- {npc:2921} Lotwil Veriatus
	["{npc:2921}'s next test needs crafted gear: skip it."] = "{npc:2921}s nächster Test braucht hergestellte Ausrüstung: Überspring ihn.",

	-- Step 16: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Reite nach Nordosten zu den Zwergenruinen im Norden des {zone:1418}; die Truhe steht zwischen den Zwergen der Schattenschmiede. {npc:2745} in der Nähe ist Elite: Halte Abstand.",

	-- Step 18: Theldurin the Lost
	-- {area:345} Agmond's End
	["Ride south to {area:345}."] = "Reite nach Süden zur {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "für {npc:2786} in {zone:1455}: behalte sie",

	-- Step 19: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn"] = "{npc:1470}, im Gasthaus",

	-- Step 20: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Nimm vom hinteren Pier das Schiff nach Theramore.",

	-- Step 21: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Der Flugmeister steht am Tor von {area:514}; {npc:5083} und {npc:4964} sind in der Zitadelle.",
	["for the Dustwallow loop in the next guide"] = "für die Runde durch die Marschen von Dustwallow im nächsten Guide",

	-- Step 23: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Folge der Straße nach Westen durch den Norden von {zone:1443} zu den Ruinen von {area:2405}. Dort steht {npc:11863}s Turm auf dem Hügel, auf dem Weg zum Wrack.",

	-- Step 24: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "Die Truhe des Schiffswracks liegt am Ufer gleich westlich von {npc:11863}s Turm.",

	-- Step 25: Lord Kragaru
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, ein Zentaurenhäuptling, lagert an der Nordwestküste, nördlich von {npc:11863}s Turm.",

	-- Step 27: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {item:6245} Karnitol's Satchel
	["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "{npc:5638}s nächste Aufgabe, {item:6245}, ist eine Beute an der fernen Küste: Überspring sie.",

	-- Step 28: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Folge der Straße nach Süden zu {area:2407}.",

	-- Step 29: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} steht am Rand des {area:596}, südwestlich von {area:2407}; {object:176751} liegen zwischen den Skeletten. Ein {npc:217590} krabbelt auf dem Friedhof herum: Fang einen mit dem Insektenfang-Set und hak ihn dann ab.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: fang ihn, für My Little Friends",

	-- Step 30: Maraudine centaurs
	["Maraudine centaurs"] = "Zentauren der Maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Die Zentauren der Maraudine halten das {area:607} westlich des Friedhofs; jede Art lässt die Totems fallen.",

	-- Step 31: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} wird im Zentaurenlager westlich des Friedhofs gefangen gehalten. Befrei sie und halte sie auf dem Weg hinaus am Leben; sie hält beim Friedhof an.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "eskortiere {npc:12277} zurück zum Friedhof",

	-- Step 33: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:606} Gelkis Village · {area:602} Mannoroc Coven · {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "Die Karawane von {npc:11626} hält an der Straße östlich von {area:606}. Nimm die Quest an und geh mit den Kodos an {area:602} vorbei; töte die Dämonen, die sie anspringen. Sprich danach mit {npc:11596} in seinem Lager östlich des {area:596}.",

	-- Step 34: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Die Dämonen versammeln sich bei {area:602} im Süden von {zone:1443}: Teufelshunde (Manafresser, Magier- und Leyjäger), Nethermaiden und Netherschwestern und Captains der Verdammniswächter rund um die Grube.",

	-- Step 35: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Untote Verheerer streifen über die Knochenfelder südlich des Dorfs der Magram, östlich des Kovens; ganz im Südosten benutzt du {item:15848}, um die Schreckgespenster der Magram anzulocken.",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Folge der Straße nach Norden zu {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "für {npc:5637} in {zone:1455}: behalte sie",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "für {npc:3980} in {area:271}: behalte sie",

	-- Step 39: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",
	["The next guide starts in Theramore."] = "Der nächste Guide beginnt in Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Folge der Straße nach Westen durch den Norden von {zone:1443} zu den Ruinen von {area:2405}; die Truhe des Schiffswracks liegt gleich westlich davon am Ufer.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "{npc:11863}s Turm steht auf dem Hügel östlich des Wracks.",
}
