-- German (deDE): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Flieg nach {area:150}",

	-- Step 2: Red Jack Flint
	-- {npc:4455} Red Jack Flint · {area:2103} Menethil Keep
	["{npc:4455} stands by {area:2103}'s door, just north of the flight master."] = "{npc:4455} steht an der Tür von {area:2103}, direkt nördlich des Flugmeisters.",
	-- {quest:1132} Fiora Longears
	["For {quest:1132} in Theramore's inn, where this guide's boat goes"] = "Für {quest:1132} im Gasthaus von Theramore, wohin das Boot dieses Guides fährt",

	-- Step 3: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern · {npc:4963} Mikhail · {npc:5082} Vincent Hyal
	["{npc:1217} stands in the {area:2104}, south of the keep, where {npc:4963} and {npc:5082} wait too."] = "{npc:1217} steht in der {area:2104} südlich der Burg, wo auch {npc:4963} und {npc:5082} warten.",
	["Inside"] = "Drinnen",

	-- Step 4: Deepwater Tavern
	-- {quest:1248} The Missing Diplomat · {npc:4963} Mikhail
	["Tapoke Jahn (34) slips out of the tavern once you take {quest:1248}: stay close behind him. He turns on you outside, a friend joins him, and he gives up once badly hurt. If you lose him the quest fails: abandon it and take it again from {npc:4963}."] = "Tapoke Jahn (34) schleicht sich aus der Taverne, sobald du {quest:1248} annimmst: Bleib dicht hinter ihm. Draußen greift er dich an, ein Freund schließt sich ihm an, und er gibt auf, sobald er schwer verletzt ist. Verlierst du ihn, schlägt die Quest fehl: Brich sie ab und nimm sie erneut bei {npc:4963} an.",

	-- Step 5: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Das Wrack der Flying Osprey liegt im seichten Wasser südlich der Burg.",

	-- Step 6: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lichtschmiedeblöcke",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Die Murlocs der Blaukiemen am Strand südwestlich von Menethil tragen die Blöcke.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "{item:2702}; unter Wasser",

	-- Step 7: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "Für {npc:1416} in {zone:1453}, nach Schlingendorn",

	-- Step 9: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Der Flugmeister steht am Tor von {area:514}; {npc:5083} und {npc:4964} sind in der Zitadelle.",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "{npc:5083}, im obersten Stockwerk",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "{npc:4964}, im obersten Stockwerk",
	-- {npc:4964} Commander Samaul · {area:503} Sentry Point
	["{npc:4964}: {area:503} is the watchtower on the road west, next"] = "{npc:4964}: {area:503} ist der Wachturm an der Straße nach Westen, als Nächstes",
	-- {quest:1132} Fiora Longears
	["{quest:1132}, inside the inn in the north of town"] = "{quest:1132}, im Gasthaus im Norden der Stadt",
	-- {npc:4456} Fiora Longears · {area:415} Astranaar
	["{npc:4456}'s next errand goes to {area:415}, off this route: leave it."] = "Der nächste Auftrag von {npc:4456} führt nach {area:415}, abseits dieser Route: Lass ihn aus.",
	-- {quest:1132} Fiora Longears · {zone:1441} Thousand Needles
	["{quest:1132}: the wyverns are in {zone:1441}, later in this guide"] = "{quest:1132}: Die Wyverns sind in {zone:1441}, weiter hinten in diesem Guide",

	-- Step 10: Sentry Point
	-- {area:503} Sentry Point · {area:403} Shady Rest Inn · {npc:4967} Archmage Tervosh
	["Follow the road north-west out of Theramore to the watchtower at {area:503}, where the road to the {area:403} turns west. Look around the tower: {npc:4967} appears at its foot, and you hand the quest in to him there."] = "Folge der Straße nach Nordwesten aus Theramore bis zum Wachturm bei {area:503}, wo die Straße zum {area:403} nach Westen abbiegt. Sieh dich am Turm um: {npc:4967} erscheint an seinem Fuß, und dort gibst du die Quest bei ihm ab.",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the foot of the tower"] = "{npc:4967}, am Fuß des Turms",
	-- {npc:4967} Archmage Tervosh · {npc:4966} Private Hendel · {area:504} North Point Tower · {zone:1445} Dustwallow Marsh
	["{npc:4967}: {npc:4966} holds {area:504}, for the {zone:1445} visit at 39"] = "{npc:4967}: {npc:4966} hält {area:504}, für den {zone:1445}-Besuch mit 39",
	-- {npc:4966} Private Hendel · {zone:1445} Dustwallow Marsh
	["Take Tervosh's next errand now: he stands here only right after the hand-in. {npc:4966} waits for the next {zone:1445} visit, at about 39."] = "Nimm Tervoshs nächsten Auftrag jetzt an: Er steht hier nur direkt nach der Abgabe. {npc:4966} wartet auf den nächsten Besuch im {zone:1445}, bei etwa Stufe 39.",

	-- Step 11: The Shady Rest Inn
	-- {zone:1413} Barrens
	["Follow the road west to the burned inn on the road toward the {zone:1413}: the black shield and Reethe's guard badge lie in the ashes and the hoofprints are in the mud beside the inn."] = "Folge der Straße nach Westen bis zum verbrannten Gasthaus an der Straße Richtung {zone:1413}: der schwarze Schild und Reethes Wachenabzeichen liegen in der Asche und die Hufabdrücke sind im Schlamm neben dem Gasthaus.",
	-- {object:21042} Theramore Guard Badge
	["{object:21042}: for Captain Vimes, on the way back through Theramore"] = "{object:21042}: für Captain Vimes, auf dem Rückweg durch Theramore",

	-- Step 12: Into Barrens
	-- {zone:1413} Barrens
	["Into {zone:1413}"] = "Hinein nach {zone:1413}",

	-- Step 13: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Auf der Straße nach Süden durch das {zone:1413} lagert {npc:6244} östlich der Straße, nordöstlich von {area:378}; komm von Osten und halte dich von den Wachen der Horde fern.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: in {zone:1440}, auf dem Weg nach {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: der Inkubus, neben dem Sukkubus; das {item:190309} liegt nahe {quest:1738}",

	-- Step 14: Myriam Moonsinger
	-- {npc:12866} Myriam Moonsinger · {area:1316} Razorfen Downs · {area:485} Great Lift
	-- plural, as words: Razorfen Battleguards = {npc:7873} Razorfen Battleguard · Death's Head Cultists = {npc:7872} Death's Head Cultist
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:12866} stands by the entrance of {area:1316}, a few hundred yards north-east of the top of the {area:485}; the Razorfen Battleguards, Thornweavers and Death's Head Cultists (33-34, elite) hold the thorny slopes around her. Skip it if you are alone."] = "Das sind Elite-Mobs: eine Gruppe zu finden ist empfehlenswert, such Leute, mit denen du es machst. {npc:12866} steht am Eingang von {area:1316}, ein paar hundert Meter nordöstlich des oberen Endes von {area:485}; die Razorfen-Kampfveteranen, Dornweber und Todeskopf-Kultisten (33-34, Elite) halten die dornigen Hänge um sie herum. Lass es, wenn du allein bist.",

	-- Step 15: Henrig Lonebrow's Journal
	-- {area:485} Great Lift · {zone:1441} Thousand Needles · {item:5791} Henrig Lonebrow's Journal · {area:2097} Darkcloud Pinnacle
	["Down the {area:485} into {zone:1441}. Careful: wait on the platform until the lift is level with it before you step on, and stay on it until it stops; the drop beside it kills. {item:5791} lies a couple of hundred yards north-east of the lift's foot, in {area:2097}, where the Grimtotems (25-27) camp."] = "Den {area:485} hinab nach {zone:1441}. Vorsicht: Warte auf der Plattform, bis der Aufzug auf gleicher Höhe ist, bevor du aufsteigst, und bleibe darauf, bis er hält; der Sturz daneben tötet. {item:5791} liegt ein paar hundert Meter nordöstlich des Aufzugfußes, in {area:2097}, wo die Grimmtotems (25-27) lagern.",
	-- {item:5791} Henrig Lonebrow's Journal · {npc:4048} Falfindel Waywarder · {area:482} Highperch
	["{item:5791}: for {npc:4048}, just past {area:482}"] = "{item:5791}: für {npc:4048}, gleich hinter {area:482}",

	-- Step 16: Highperch
	-- {area:482} Highperch
	["West to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac."] = "Nach Westen zu den Klippen der Wyverne bei {area:482}. Jeder Wyvern dort kann eine Giftdrüse fallen lassen.",

	-- Step 17: Falfindel Waywarder
	-- {npc:4048} Falfindel Waywarder · {area:482} Highperch · {zone:1444} Feralas · {area:489} Thalanaar · {area:1717} Razorfen Kraul
	["{npc:4048} camps north of {area:482}, just over the border into {zone:1444} on the path up to {area:489}: hand him the journal. His next quest is inside {area:1717}: leave it."] = "{npc:4048} lagert nördlich von {area:482}, direkt hinter der Grenze in {zone:1444} auf dem Weg hoch zu {area:489}: Gib ihm das Tagebuch. Seine nächste Quest ist drinnen in {area:1717}: Lass sie.",

	-- Step 18: Thousand Needles
	-- {area:484} Freewind Post
	["East through the canyons. {area:484}, a Horde camp with guards, sits on the mesa here: keep to the canyon floor and give the foot of its lifts a wide berth."] = "Nach Osten durch die Schluchten. {area:484}, ein Hordenlager mit Wachen, liegt hier auf dem Tafelberg: Bleib unten in der Schlucht und halte großen Abstand zum Fuß seiner Aufzüge.",
	-- {area:482} Highperch
	["The canyons east of {area:482}"] = "Die Schluchten östlich von {area:482}",

	-- Step 20: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Folge den Schluchten nach Osten zur Salzebene. Die Goblins und Gnome der {area:2240} sind neutral und geben beiden Fraktionen Quests.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Für {quest:5762} im Schlingendorntal, später",

	-- Step 21: Mirage Raceway: kill these as you meet them
	-- {area:2240} Mirage Raceway
	["{area:2240}: kill these as you meet them"] = "{area:2240}: Töte diese, sobald sie dir begegnen",
	-- {object:19868} Rocket Car Rubble · {npc:5935} Ironeye the Invincible
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Saltstone Gazers = {npc:4150} Saltstone Gazer · Scorpid Terrors = {npc:4139} Scorpid Terror
	-- was: ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "{object:19868} liegen überall in der Ebene. Skorpidhäscher und Salzwüstenaasfresser streifen durch die Nordhälfte, Spiegelpanzerschildkröten (30-31) durch die Mitte der Ebene: Jag sie für die Panzer. Vorsicht: Spiegelpanzerschnapper (34-35) wandern durch die ganze Ebene, und die Salzsteinstarrer (34-35) und Skorpidschrecker (33-34) halten den äußersten Süden: Lass sie in Ruhe und bleib in der Nordhälfte."
	["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half.\nCareful: {npc:5935} (37, rare) roams the south-east of the flats, around 83-88,71-84: leave it be."] = "{object:19868} liegt überall auf den Flächen verstreut. Skorpid-Räuber und Salzebenen-Aasfresser streifen durch die Nordhälfte, Funkelschalen-Schildkröten (30-31) durch die Mitte der Flächen: jage sie wegen der Panzer. Vorsicht: Funkelschalen-Schnapper (34-35) ziehen durch die ganzen Flächen, und die Salzstein-Beobachter (34-35) und Skorpid-Schrecken (33-34) halten den äußersten Süden: lass sie in Ruhe und bleib in der Nordhälfte.\nVorsicht: {npc:5935} (37, selten) streift durch den Südosten der Flächen, um 83-88,71-84: lass es in Ruhe.",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises"] = "{item:5795}, von den Spiegelpanzerschildkröten",
	-- {npc:4078} Collin Mauren · {zone:1453} Stormwind
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["Crystalized Scale, from the Saltstone Basilisks: eight for {npc:4078} in {zone:1453}"] = "Crystalized Scale, von den Saltstone Basilisks: acht für {npc:4078} in {zone:1453}",

	-- Step 22: Mirage Raceway
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: for {quest:1111} on {area:392}'s dock, where this guide ends"] = "{npc:4452}: für {quest:1111} an {area:392}s Steg, wo dieser Guide endet",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, at the end of 30-40"] = "{npc:4454}: für Martek in {zone:1418}, am Ende von 30-40",
	-- {npc:4630} Pozzik · {npc:3391} Gazlowe · {area:392} Ratchet
	["{npc:4630}: for {npc:3391} in {area:392}, on the way to the boat"] = "{npc:4630}: für {npc:3391} in {area:392}, auf dem Weg zum Boot",

	-- Step 23: Into Tanaris
	-- {zone:1446} Tanaris
	["Into {zone:1446}"] = "Hinein nach {zone:1446}",
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris
	["From the raceway follow the road south out of the {area:439} into {zone:1446}."] = "Folge von der Rennstrecke der Straße nach Süden aus {area:439} hinaus nach {zone:1446}.",

	-- Step 24: Gadgetzan
	-- {area:976} Gadgetzan · {npc:7823} Bera Stonehammer
	["{area:976} is a short walk down the road; keep to it. {npc:7823}, the Alliance flight master, stands inside the walls."] = "{area:976} ist ein kurzer Fußweg die Straße hinunter; bleib auf ihr. {npc:7823}, der Flugmeister der Allianz, steht hinter den Mauern.",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Flugmeister von {area:976}",

	-- Step 26: Theramore
	-- {npc:4456} Fiora Longears · {npc:4948} Adjutant Tesoran · {area:514} Foothold Citadel · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes and {npc:4948} on the top floor of {area:514}; {npc:4941} stands in the town."] = "{npc:4456} ist im Norden der Stadt, Captain Vimes und {npc:4948} im obersten Stockwerk von {area:514}; {npc:4941} steht in der Stadt.",
	-- {zone:1445} Dustwallow Marsh
	["Vimes's next errand, The Deserters, is for the {zone:1445} visit at 39: leave it."] = "Vimes' nächster Auftrag, The Deserters, ist für den {zone:1445}-Besuch bei 39: Lass ihn.",

	-- Step 27: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {area:35} Booty Bay · {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	-- was: ["From Theramore follow the road north-west through the marsh into the {zone:1413} and up the coast to {area:392}: Stranglethorn starts at {area:35}, across the sea. {area:392}'s gryphon master stands above the dock."] = "Folge von Theramore der Straße nordwestlich durch den Sumpf in das {zone:1413} und die Küste hinauf bis {area:392}: Schlingendorntal beginnt bei {area:35}, jenseits des Meeres. Der Greifenmeister von {area:392} steht über dem Steg."
	["From Theramore follow the road north-west through the marsh into the {zone:1413} and up the coast to {area:392}: Stranglethorn starts at {area:35}, across the sea. {area:392}'s gryphon master stands above the dock; {npc:3391} is upstairs in the house above it; {quest:1111} waits on the dock by the boat."] = "Von Theramore aus folge der Straße nach Nordwesten durch das Sumpfland in die {zone:1413} und die Küste entlang nach {area:392}: Das Schlingendorntal beginnt bei {area:35}, jenseits des Meeres. Der Greifenmeister von {area:392} steht oberhalb des Stegs; {npc:3391} ist oben im Haus darüber; {quest:1111} wartet am Steg beim Boot.",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631}, on {area:35}'s dock where the boat lands"] = "{npc:3391}: für {npc:4631}, an {area:35}s Steg, wo das Boot anlegt",
	-- {quest:1111} Wharfmaster Dizzywig · {quest:1039} The Barrens Port · {npc:8026} Thyn'tel Bladeweaver · {zone:1457} Darnassus
	["{quest:1111}: {quest:1039}, from {npc:8026} in {zone:1457}"] = "{quest:1111}: {quest:1039}, von {npc:8026} in {zone:1457}",
	-- {quest:1111} Wharfmaster Dizzywig · {npc:3945} Caravaneer Ruzzgot · {area:35} Booty Bay
	["{quest:1111}: for {npc:3945} in {area:35}, where the boat lands"] = "{quest:1111}: für {npc:3945} in {area:35}, wo das Boot landet",
	-- {area:2240} Mirage Raceway
	["Dizzywig's next errand goes back to the {area:2240}, which the route next visits at 45: leave it."] = "Dizzywigs nächster Auftrag geht zurück zum {area:2240}, den die Route als Nächstes bei 45 besucht: Lass ihn.",

	-- Step 28: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Boot nach {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Zurück nach Westen über die Straße zu den Satyrlagern von {area:429}.",
	-- ["Boat to {area:150}"] = "Schiff nach {area:150}",
	-- ["Dartol's Rod"] = "Dartols Rute der Transformation",
	-- ["Down the {area:485} into {zone:1441}, then west to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac. Careful: wait on the platform until the lift is level with it before you step on, and stay on it until it stops; the drop beside it kills."] = "Hinab den {area:485} nach {zone:1441}, dann nach Westen zu den Klippen der Wyverns bei {area:482}. Jede Wyvern dort kann einen Giftbeutel fallen lassen. Vorsicht: Warte auf der Plattform, bis der Aufzug auf ihrer Höhe ist, bevor du hinaufsteigst, und bleib darauf, bis er anhält; der Sturz daneben ist tödlich.",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Folge der Straße nach Osten zu den Satyrlagern von {area:429}; {npc:3920} versteckt sich an ihrem Rand.",
	-- ["Follow the road west out of Theramore to the burned inn on the road toward the {zone:1413}: the black shield lies in the ashes and the hoofprints are in the mud beside the inn."] = "Folge der Straße nach Westen aus Theramore zum verbrannten Gasthaus an der Straße in Richtung {zone:1413}: Der schwarze Schild liegt in der Asche, und die Hufabdrücke sind im Schlamm neben dem Gasthaus.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Folge der Straße von {area:415} aus nach Westen; {area:413} liegt nördlich davon.",
	-- ["From Theramore follow the road north-west through the marsh into the {zone:1413} and up the coast to {area:392}: Stranglethorn starts at {area:35}, across the sea. {area:392}'s gryphon master stands above the dock."] = "Folge von Theramore der Straße nordwestlich durch den Sumpf in das {zone:1413} und die Küste hinauf bis {area:392}: Schlingendorntal beginnt bei {area:35}, jenseits des Meeres. Der Greifenmeister von {area:392} steht über dem Steg.",
	-- ["From {area:608}"] = "Start: {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Insane druids"] = "Wahnsinnige Druiden",
	-- ["Melyria and {npc:3901}"] = "Melyria und {npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Rostige Truhen stehen rund um die Furbolglager des Schattendickichts westlich der Verlassenen; öffne sie, bis eine den Knauf enthält.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "{area:150}: Nimm das Boot vom Steg in {area:442}.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Nimm den Tunnel ins Gebiet {area:419}; der Foliant liegt in den Ruinen an seinem Westende.",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Die Wahnsinnigen und Welken Urtume nördlich des Mondbrunnens tragen den {item:5475}; die abgenutzte Truhe, die er öffnet, steht zwischen ihnen.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "Das Lager der Verlassenen liegt in den Wäldern südlich von {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "Der Mondbrunnen liegt in den Hügeln nordöstlich von {area:415}.",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Der zweite {object:19901} liegt im Tal {area:428}, auf dem Weg nach Westen.",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "Der Schrein liegt auf dem Hügel gleich südöstlich des Mondbrunnens; folge dem gewundenen Pfad hinauf.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Die drei Druiden stehen zusammen im Lager der Verlassenen südlich von {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "Die beiden stehen zusammen am Westende der Straße.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Das Wrack der Flying Osprey liegt im seichten Wasser südlich der Burg.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "Das {npc:3931} läuft am Ufer des {quest:1035} entlang, südwestlich der Truhen; der {object:669176} liegt unterwegs nördlich des Sees.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "Der {object:19901} steht im Satyrlager von {area:430}, weiter östlich an der Straße.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} und {npc:221269} stehen dort.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} steht dort.",
	-- ["{area:429} satyrs"] = "Satyrn von {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} steht im oberen Stockwerk der Burg von Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} und seine Wachen lagern gleich östlich von {npc:3897}.",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, ein Furbolg, den die Verderbnis nicht berührt hat, sitzt südlich der Straße unterhalb vom {area:421}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: für {npc:1480} in Menethil, am Ende dieses Guides",
	-- ["{npc:4456} is in the north of town, Captain Vimes in {area:514}; {npc:4941} stands in the town."] = "{npc:4456} ist im Norden der Stadt, Captain Vimes in {area:514}; {npc:4941} steht in der Stadt.",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} führt die Satyrn von {area:429} an; er trägt den Zweig.",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} und {npc:4962} Jahn sind alle im Gasthaus von Menethil; Tapoke greift dich an, wenn du mit {npc:4963} sprichst, gibt aber auf, sobald er besiegt ist. {npc:1480} steht ein kurzes Stück nordöstlich des Gasthauses.",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Snappers (tortoises) the whole flats. Saltstone Basilisks and Crystalhides hold the middle; the Gazers (34-35) only the far south."] = "{object:19868} liegt überall auf den Ebenen verstreut. Scorpid Reavers und Salt Flats Scavengers streifen durch die Nordhälfte, Sparkleshell Snappers (Schildkröten) über die gesamten Ebenen. Saltstone Basilisks und Crystalhides halten die Mitte; die Gazers (34-35) nur den äußersten Süden.",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "{object:19868} liegen überall in der Ebene. Skorpidhäscher und Salzwüstenaasfresser streifen durch die Nordhälfte, Spiegelpanzerschildkröten (30-31) durch die Mitte der Ebene: Jag sie für die Panzer. Vorsicht: Spiegelpanzerschnapper (34-35) wandern durch die ganze Ebene, und die Salzsteinstarrer (34-35) und Skorpidschrecker (33-34) halten den äußersten Süden: Lass sie in Ruhe und bleib in der Nordhälfte.",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: für {npc:3961} in {area:415}",
	-- ["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",
}
