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
	["Into {zone:1418}"] = "Hinein nach {zone:1418}",

	-- Step 2: Dorgaron
	-- {npc:269577} Dorgaron · {area:346} Hammertoe's Digsite · {area:345} Agmond's End
	-- plural, as words: Stonevault Bonesnappers = {npc:2893} Stonevault Bonesnapper
	["{npc:269577} of the Explorers' League camps at the foot of the pass. His artifacts drop from the Shadowforge diggers at {area:346} and the Stonevault Bonesnappers at {area:345}, and the helmet lies in the Shadowforge camp."] = "{npc:269577} von der Forscherliga lagert am Fuß des Passes. Seine Artefakte lassen die Buddler der Schattenschmiede bei {area:346} und die Knochenknacker der Steingrufttroggs bei {area:345} fallen, und der Helm liegt im Lager der Schattenschmiede.",
	-- {npc:269577} Dorgaron · {item:278404} Pristine Mattock · {zone:1418} Badlands
	["{npc:269577}: keep it, the {item:278404} waits for the 40-50 {zone:1418} visit"] = "{npc:269577}: behalten, die {item:278404} wartet auf den Besuch in {zone:1418} mit 40-50",

	-- Step 4: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Geh zurück nach Westen zur Straße und folge ihr nach Süden aus {zone:1432} durch den Pass in die {zone:1418}. {npc:2910} und {npc:2860} lagern Seite an Seite an der Grabungsstätte.",

	-- Step 5: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "{area:346}: Töte diese, sobald sie dir begegnen",
	-- {npc:269577} Dorgaron
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map and {npc:269577}'s mining helmet lie among their tents. Tunnelers and Darkweavers carry Ryedol's pick and {npc:269577}'s artifacts. Crag Coyotes roam the slopes around it."] = "Die Zwerge der Schattenschmiede lagern gleich nördlich der Ausgrabungsstätte; die zerknitterte Karte und der Bergbauhelm von {npc:269577} liegen zwischen ihren Zelten. Tunnelgräber und Dunkelwirker tragen Ryedols Spitzhacke und die Artefakte von {npc:269577}. Klippenkojoten streifen über die Hänge drumherum.",
	-- {item:278403} Explorers' League Mining Helmet
	["{item:278403}, in the Shadowforge camp"] = "{item:278403}, im Lager der Schattenschmiede",
	-- {item:7847} Buzzard Gizzard
	-- plural, as words: Starving Buzzards = {npc:2829} Starving Buzzard · Giant Buzzards = {npc:2831} Giant Buzzard
	["{item:7847}: the Starving Buzzards (35-37) circling the hills north of the digsite drop it most often; leave the Giant Buzzards (39-41) of the far west"] = "{item:7847}: Die Verhungernden Bussarde (35-37), die über den Hügeln nördlich der Ausgrabungsstätte kreisen, lassen ihn am häufigsten fallen; lass die Riesenbussarde (39-41) im fernen Westen in Ruhe",

	-- Step 6: The excavation crate
	["The excavation crate"] = "Die Ausgrabungskiste",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Geh nach Nordosten zur verlassenen Grabungsstätte; die Versorgungskiste liegt dort zwischen den Ogern der Staubbäuche.",

	-- Step 7: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "Ryedols nächster Auftrag führt nach {area:1517}: Überspring ihn.",

	-- Step 8: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} und {npc:2817} lagern zusammen im {area:1877}, mitten im {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Die Muscheln liegen an der Nordwestküste des Schlingendorntals, im nächsten Guide: Behalte sie",

	-- Step 9: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Das zerschlagene Skelett liegt gleich östlich der Oger, am Rand des Lagers der Steingrufttroggs; die Knochenknacker und Schamanen drumherum lassen die Splitter fallen. Theldurin sitzt weiter südlich beim zerstörten Lager.",

	-- Step 10: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "{area:345}: Töte diese, sobald sie dir begegnen",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Maulers = {npc:2717} Dustbelcher Mauler · Stonevault Bonesnappers = {npc:2893} Stonevault Bonesnapper · Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["Buzzards circle the plain to the east. Careful: the Dustbelcher Maulers, Shamans and Wyrmhunters (40-43) camp far to the south-west: leave them.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: the Stonevault Bonesnappers are 39-40 and the Shamans 40-41, a level or two over you here: pull them from the camp's edge, one at a time.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "Bussarde kreisen über der Ebene im Osten. Vorsicht: Die Raufer, Schamanen und Wyrmjäger der Staubspeier (40-43) lagern weit im Südwesten: Lass sie in Ruhe.\nDas zerschlagene Skelett liegt am Rand des Lagers der Steingrufttroggs; {quest:739}, der Mörder von Agmond, läuft zwischen den Knochenknackern umher.\nVorsicht: Die Knochenknacker der Steingrufttroggs sind 39-40 und die Schamanen 40-41, ein bis zwei Stufen über dir: Zieh sie einzeln vom Rand des Lagers.\nVorsicht: Lords der Staubspeier sind Stufe 44-45. Sie benutzen {spell:5242} und {spell:1160}, und unter 50 % Gesundheit rufen sie Verbündete im Umkreis von 15 Metern zu Hilfe. Sieben von ihnen stehen etwa 750 Meter südlich von {area:340}.",
	-- {item:7847} Buzzard Gizzard · {area:345} Agmond's End
	["{item:7847}, if you still need one: the Buzzards east of {area:345} drop it only rarely"] = "{item:7847}, falls du noch einen brauchst: Die Bussarde östlich von {area:345} lassen ihn nur selten fallen",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "{quest:739} selbst (42) läuft zwischen den Bonesnappers umher: Lass ihn für den späteren Guide für {zone:1418} auf Stufe 43 übrig und töte jetzt die Bonesnappers für diese Quest.",
	-- {item:278402} Unstudied Artifact
	["{item:278402}, from the Shadowforge diggers and the Bonesnappers"] = "{item:278402}, von den Buddlern der Schattenschmiede und den Knochenknackern",

	-- Step 11: Theldurin the Lost
	-- {area:1517} Uldaman
	["Theldurin sits by the ruined camp south of the trogg camp. His tablet lies just inside {area:1517}'s cave mouth, beside level 38 elites: a quest for a group."] = "Theldurin sitzt beim zerstörten Lager südlich des Troggenlagers. Seine Tafel liegt gleich hinter dem Höhleneingang von {area:1517}, neben Elites der Stufe 38: eine Quest für eine Gruppe.",

	-- Step 12: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Geh nach Westen in die {area:1878}; {npc:2921} arbeitet in der Mitte bei seinen Maschinen.",

	-- Step 13: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Kleine Felselementare",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch · {npc:2860} Sigrun Ironhew · {npc:269756} Malevolent Mirage
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard · Dustbelcher Ogres = {npc:2701} Dustbelcher Ogre
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards. The Dustbelcher Ogres (38-39) on the {area:1878}'s west side drop {npc:2860}'s scrap. Careful: a {npc:269756}, a level 42 elite, drifts about the {area:1878}: give it a wide berth.\nCareful: the Lesser Rock Elementals are 37-39 and hit hard: fight them one at a time."] = "Die Kleinen Felselementare streifen durch {area:1878} westlich von {npc:2921}; jeder Felselementar kann die Felselementarsplitter für {npc:1470} fallen lassen. Die Oger der Staubspeier (38-39) auf der Westseite von {area:1878} lassen den Schrott für {npc:2860} fallen. Vorsicht: Eine {npc:269756}, ein Elite der Stufe 42, treibt durch {area:1878}: Mach einen großen Bogen darum.\nVorsicht: Die Kleinen Felselementare sind 37-39 und schlagen hart zu: Kämpf einzeln gegen sie.",
	-- {item:4630} Scrap Metal
	-- plural, as words: Dustbelcher Ogres = {npc:2701} Dustbelcher Ogre
	["{item:4630}, from the Dustbelcher Ogres"] = "{item:4630}, von den Ogern der Staubspeier",

	-- Step 15: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {area:1517} Uldaman · {zone:1418} Badlands · {npc:2932} Magregan Deepshadow
	-- plural, as words: Obsidian Golems = {npc:4872} Obsidian Golem · Shadowforge Diggers = {npc:4846} Shadowforge Digger
	["Head north to {area:1517}'s entrance, in the north of the {zone:1418}: the chest lies just inside the cave mouth. {npc:2932} and the Obsidian Golems (38) stand beside it and Shadowforge Diggers (35-36) work the tunnel, all elite: keep your group together."] = "Geh nach Norden zum Eingang von {area:1517} im Norden von {zone:1418}: Die Truhe liegt gleich hinter dem Höhleneingang. {npc:2932} und die Obsidian Golems (38) stehen daneben, und Shadowforge Diggers (35-36) arbeiten im Tunnel, alle Elite: Halte deine Gruppe zusammen.",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "{item:4631}; unter der Erde",

	-- Step 16: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:1517} Uldaman · {area:345} Agmond's End
	["{npc:4618} and {npc:2817} camp in the {area:1877}, on the road between {area:1517} and {area:345}."] = "{npc:4618} und {npc:2817} lagern im {area:1877}, auf der Straße zwischen {area:1517} und {area:345}.",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "Für {npc:4454} an der {area:2240}: Der Guide für {zone:1446} kommt bei Stufe 45 an ihm vorbei, behalte es",

	-- Step 17: Sigrun Ironhew
	-- {area:1877} Valley of Fangs · {area:346} Hammertoe's Digsite · {npc:2860} Sigrun Ironhew
	["East from the {area:1877} to {area:346}: {npc:2860} takes the scrap metal."] = "Vom {area:1877} nach Osten zu {area:346}: {npc:2860} nimmt den Metallschrott an.",

	-- Step 18: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "Geh nach Süden zu {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "für {npc:2786} in {zone:1455}: behalte sie",

	-- Step 19: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Felselementare",
	-- {npc:2921} Lotwil Veriatus · {npc:269756} Malevolent Mirage · {area:1878} Dustbowl
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west. Careful: a {npc:269756}, a level 42 elite, drifts about the {area:1878}: give it a wide berth."] = "Die Felselementare streifen südöstlich von {npc:2921} umher; Riesenbussarde und Alte Klippenkojoten teilen sich die Ebene westlich davon. Vorsicht: Eine {npc:269756}, ein Elite der Stufe 42, treibt durch {area:1878}: Mach einen großen Bogen darum.",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "Zum {area:2101}",

	-- Step 22: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "{npc:1470}, im Gasthaus; unter der Erde",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "Ein {npc:217590} krabbelt im {area:596} herum: Fang einen mit dem Werkzeug aus dem Einsteigerpaket für Entomologen von {npc:217412}.",
	-- ["Fly to Theramore"] = "Flieg nach Theramore",
	-- ["Fly to {area:150}"] = "Flieg nach {area:150}",
	-- ["Follow the road north to {area:608}."] = "Folge der Straße nach Norden zu {area:608}.",
	-- ["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Folge der Straße nach Norden zu {area:608}: {npc:5396} steht am Südende, {npc:5638} in der Mitte, {npc:1182} im Norden.",
	-- ["Follow the road south to {area:2407}."] = "Folge der Straße nach Süden zu {area:2407}.",
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Folge der Straße nach Westen durch den Norden von {zone:1443} zu den Ruinen von {area:2405}. Dort steht {npc:11863}s Turm auf dem Hügel, auf dem Weg zum Wrack.",
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Folge der Straße nach Westen durch den Norden von {zone:1443} zu den Ruinen von {area:2405}; die Truhe des Schiffswracks liegt gleich westlich davon am Ufer.",
	-- ["Greater Rock Elementals"] = "Große Felselementare",
	-- ["Head back west to the road and follow it south out of {zone:1432} through the pass into the {area:3}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Geh zurück nach Westen zur Straße und folge ihr nach Süden aus {zone:1432} durch den Pass in die {area:3}. {npc:2910} und {npc:2860} lagern Seite an Seite an der Grabungsstätte.",
	-- ["Head north-east to the dwarven ruins in the north of the {area:3}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Geh nach Nordosten zu den Zwergenruinen im Norden der {area:3}; die Truhe steht zwischen den Zwergen der Schattenschmiede. {npc:2745} in der Nähe ist Elite: Gib ihm Raum.",
	-- ["Head north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Geh nach Nordosten zu den Zwergenruinen im Norden der {zone:1418}; die Truhe steht zwischen den Zwergen der Schattenschmiede. {npc:2745} in der Nähe ist Elite: Gib ihm Raum.",
	-- ["Lesser Rock Elementals"] = "Kleine Felselementare",
	-- ["Maraudine centaurs"] = "Zentauren der Maraudine",
	-- ["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "Geh vom Boot aus den Pier hinauf zu Baldruc, dem Flugmeister am Tor von {area:514}.",
	-- ["Ogres and buzzards"] = "Oger und Bussarde",
	-- ["Rackmore's chest lies just south-east of the {object:177673}."] = "Rackmores Truhe liegt gleich südöstlich von {object:177673}.",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Reite zurück nach Westen zur Straße und folge ihr nach Süden aus {zone:1432} durch den Pass ins {zone:1418}. {npc:2910} und {npc:2860} lagern nebeneinander bei der Ausgrabung.",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Reite nach Nordosten zur verlassenen Ausgrabung; die Vorratskiste liegt dort zwischen den Ogern der Staubspeier.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Reite nach Nordosten zu den Zwergenruinen im Norden des {zone:1418}; die Truhe steht zwischen den Zwergen der Schattenschmiede. {npc:2745} in der Nähe ist Elite: Halte Abstand.",
	-- ["Ride south to {area:345}."] = "Reite nach Süden zur {area:345}.",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Reite nach Westen in {area:1878}; {npc:2921} arbeitet mitten darin an seinen Maschinen.",
	-- ["Shadowforge camp"] = "Lager der Schattenschmiede",
	-- ["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "Südwestlich in die Schluchten: Nur die Greater Rock Elementals dort lassen die Armschienen fallen.",
	-- ["Take the boat to Theramore from the far pier."] = "Nimm vom hinteren Pier das Schiff nach Theramore.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Die Oger der Staubspeier lagern gleich südlich des Tals; jeder von ihnen lässt Schrott fallen. Bussarde kreisen über der Ebene im Osten.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "Die Dustbelcher-Oger lagern direkt südlich des Tals; jeder von ihnen lässt Schrott fallen. Bussarde kreisen über der Ebene im Osten.\nDas zerschlagene Skelett liegt am Rand des Stonevault-Troggcamps; {quest:739}, der Mörder von Agmond, läuft zwischen den Bonesnappers umher.\nVorsicht: Dustbelcher Lords sind Stufe 44-45. Sie benutzen {spell:5242} und {spell:1160}, und unter 50 % Gesundheit rufen sie Verbündete im Umkreis von 15 Metern zu Hilfe. Sieben von ihnen stehen etwa 750 yd südlich von {area:340}.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Die Großen Felselementare (Stufe 42) wandern in der äußersten Südwestecke unterhalb von {area:342}; zieh sie einzeln. Die Wyrmjäger und Raufer der Staubspeier bei {area:342} lassen auch Schrott fallen.",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Die Kleinen Felselementare streifen durch {area:1878} westlich von {npc:2921}.",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "Die Lesser Rock Elementals wandern durch die {area:1878} westlich von {npc:2921}; jedes Felselementar kann die Rock Elemental Shards für {npc:1470} fallen lassen.",
	-- ["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Die Zentauren der Maraudine halten das {area:607} westlich des Friedhofs; jede Art lässt die Totems fallen.",
	-- ["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Die Felselementare streifen südöstlich von {npc:2921} umher; Riesenbussarde und Alte Klippenkojoten teilen sich die Ebene westlich davon.",
	-- ["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Die Zwerge der Schattenschmiede lagern gleich nördlich der Ausgrabungsstätte; die zerknitterte Karte liegt zwischen ihren Zelten. Tunnelgräber und Dunkelwirker tragen Ryedols Spitzhacke. Klippenkojoten streifen über die Hänge drumherum.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Die Naga der Schlitterklingen halten die Nordwestküste nördlich des Turms von {npc:11863}; Karnitols Tasche liegt davor auf dem Meeresgrund, und jeder Naga kann Rackmores goldenen Schlüssel fallen lassen. Schwimm hinaus nach {area:2406} vor der äußersten Nordspitze und benutze {item:15766} an {object:177673}: {npc:12369} (38) erscheint; töte ihn für {quest:6027}.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Die Naga der Schlitterklingen halten die Nordwestküste nördlich des Turms von {npc:11863}; Karnitols Tasche liegt davor auf dem Meeresgrund. Schwimm hinaus nach {area:2406} vor der äußersten Nordspitze und benutze {item:15766} an {object:177673}: {npc:12369} (38) erscheint; töte ihn für {quest:6027}.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Das zerschlagene Skelett liegt gleich östlich der Oger, am Rand des Lagers der Steingrufttroggs; die Knochenknacker und Schamanen drumherum lassen die Splitter fallen. Theldurin sitzt weiter südlich beim zerstörten Lager.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Die Dämonen versammeln sich bei {area:602} im Süden von {zone:1443}: Teufelshunde (Manafresser, Magier- und Leyjäger), Nethermaiden und Netherschwestern und Captains der Verdammniswächter rund um die Grube.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Die Dämonen sammeln sich am {area:602} im Süden von {zone:1443}: Höllenhunde (Mana Eaters, Mage und Ley Hunters), Nether Maidens und Sisters sowie Doomwarder Captains rund um die Grube.\nVorsicht: Die meisten Mobs hier laufen Patrouillenrouten, sodass du leicht zusätzliche Mobs ziehst.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Der Flugmeister steht am Tor von {area:514}; {npc:5083} und {npc:4964} sind in der Zitadelle.",
	-- ["The next guide starts in Theramore."] = "Der nächste Guide beginnt in Theramore.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "Die nächste Aufgabe des Skeletts, Murdaloc, wartet bis zum späteren Guide für das {zone:1418} mit 43.",
	-- ["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "Die Truhe des Schiffswracks liegt gleich südwestlich von {npc:11863}s Turm.",
	-- ["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "Die Truhe des Schiffswracks liegt am Ufer gleich westlich von {npc:11863}s Turm.",
	-- ["The {area:2657}"] = "{area:2657}",
	-- ["Theramore"] = "Theramore",
	-- ["Theramore flight master"] = "Flugmeister von Theramore",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Untote Verheerer streifen über die Knochenfelder südlich des Dorfs der Magram, östlich des Kovens; ganz im Südosten benutzt du {item:15848}, um die Schreckgespenster der Magram anzulocken.",
	-- ["Underwater"] = "Unter Wasser",
	-- ["escort {npc:12277} back toward the graveyard"] = "eskortiere {npc:12277} zurück zum Friedhof",
	-- ["for the Dustwallow loop in the next guide"] = "für die Runde durch die Marschen von Dustwallow im nächsten Guide",
	-- ["for {npc:3980} in {area:271}: keep it"] = "für {npc:3980} in {area:271}: behalte sie",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "für {npc:4454} in {area:439}: Der Guide für {zone:1446} kommt mit 45 dort vorbei, behalte sie",
	-- ["for {npc:5637} in {zone:1455}: keep it"] = "für {npc:5637} in {zone:1455}: behalte sie",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "nur wenn du {item:2868} dabeihast (von Schmieden hergestellt)",
	-- ["{area:144} flight master"] = "Flugmeister in {area:144}",
	-- ["{area:598}: kill these as you meet them"] = "{area:598}: Töte diese, sobald sie dir begegnen",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766}, an {object:177673}",
	-- ["{item:15881}, from the Slitherblade naga"] = "{item:15881}, von den Naga der Schlitterklingen",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "Die Karawane von {npc:11626} hält an der Straße östlich von {area:606}. Nimm die Quest an und geh mit den Kodos an {area:602} vorbei; töte die Dämonen, die sie anspringen. Sprich danach mit {npc:11596} in seinem Lager östlich des {area:596}.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "{npc:11863}s Turm steht auf dem Hügel östlich des Wracks.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} wird im Zentaurenlager westlich des Friedhofs gefangen gehalten. Befrei sie und halte sie auf dem Weg hinaus am Leben; sie hält beim Friedhof an.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} wird im Zentaurenlager westlich des Friedhofs festgehalten. Befreie sie und halte sie auf dem Weg hinaus am Leben; sie bleibt am Friedhof stehen.\nVorsicht: Die geskripteten Gruppen sind verbunden und erscheinen nur während der Eskorte, du kannst sie also nicht vorher räumen oder einzeln ziehen. Die normalen Zentauren auf dem Pfad vor dem Start zu räumen hilft dagegen.",
	-- ["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, ein Zentaurenhäuptling, lagert an der Nordwestküste, nördlich von {npc:11863}s Turm.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, im Gasthaus",
	-- ["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: fang ihn, für My Little Friends",
	-- ["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, neben {npc:2921}",
	-- ["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "{npc:2920}, neben {npc:2921}, tauscht gegen {item:2868}, ein Schmiedeprodukt: Dieser Schritt erscheint nur, wenn du ein Paar bei dir hast.",
	-- ["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "Der letzte Test von {npc:2921} ist optional: fünf {item:4628}, die nur die Greater Rock Elementals (42-44) in den südwestlichen Schluchten fallen lassen, etwa bei jedem fünften Kill, weit über deiner Stufe. Nimm ihn nur an, wenn du sie einzeln bewältigen kannst; ansonsten gib die Tafeln ab und zieh weiter.",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "{npc:2921}s nächster Test braucht hergestellte Ausrüstung: Überspring ihn.",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "{npc:4618} und {npc:2817} lagern zusammen im {area:1877}, mitten im {area:3}.",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "{npc:5638}s nächste Aufgabe, {item:6245}, ist eine Beute an der fernen Küste: Überspring sie.",
	-- ["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, falls 30-40/02 sie nicht angenommen hat: Das Wrack liegt unterhalb von {npc:11863}s Turm",
	-- ["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} steht am Rand des {area:596}, südwestlich von {area:2407}; {object:176751} liegen zwischen den Skeletten.",
	-- ["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} steht am Rand des {area:596}, südwestlich von {area:2407}; {object:176751} liegen zwischen den Skeletten. Ein {npc:217590} krabbelt auf dem Friedhof herum: Fang einen mit dem Einsteigerpaket für Entomologen und hak ihn dann ab.",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} liegt neben {object:35251}. Sein silberner Schlüssel wird von den Trockenschnappkrebsen rund um das Wrack fallen gelassen; der goldene stammt von den Naga der Schlitterklingen an der Nordwestküste, als Nächstes.",
}
