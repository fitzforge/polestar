-- German (deDE): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "Kein {item:4371} für {quest:174}? {npc:3133} verkauft sie im Haus neben {npc:276}, in begrenzter Menge; {npc:1448} in {area:150} verkauft sie auch.",
	-- {npc:352} Dungar Longdrink · {zone:1453} Stormwind
	["From {npc:352} in {zone:1453}"] = "Von {npc:352} in {zone:1453}",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taverne Zum Scharlachroten Raben",
	-- {npc:840} Watcher Backus
	["{npc:840}, at the north entrance of town"] = "{npc:840}, am Nordeingang des Orts",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, im Rathaus",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, beim Rathaus",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, von {npc:3133}, falls du keine hast",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, at the east end of town"] = "{npc:276}, am Ostende des Orts",

	-- Step 2: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "Schattenwirker der Nachtheuler",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "Die Worgen halten die Wälder des Schattenhains, westlich von {area:42} und nördlich der Straße. Zieh sie einzeln.",

	-- Step 4: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "Dunkelläufer der Nachtheuler",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "Die Dunkelläufer streifen durch die Wälder südlich der Straße, westlich von {area:42}.",

	-- Step 6: Blind Mary
	-- {area:42} Darkshire
	["Her house stands on the hill south-east of {area:42}."] = "Ihr Haus steht auf dem Hügel südöstlich von {area:42}.",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "Faulreißer der Nachtheuler und der {npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "Die stärksten Worgen streifen durch die Wälder südlich von {area:42}, westlich und südlich des {area:121}. Der {npc:511} versteckt sich in der kleinen Gruft beim Friedhof.",

	-- Step 8: Darkshire
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house"] = "{npc:661}, beim Haus von {npc:633}",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["Head west along the road; the hermit's shack stands north-east of the {area:492}."] = "Geh entlang der Straße nach Westen; die Hütte des Einsiedlers steht nordöstlich des {area:492}.",

	-- Step 10: Plague Spreaders
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["Plague Spreaders"] = "Seuchenverbreiter",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "Die Seuchenverbreiter wandeln in der nördlichen Hälfte des {area:492}. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.",

	-- Step 11: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "{npc:311}s Lager",

	-- Step 12: Raven Hill Cemetery, west
	-- {area:492} Raven Hill Cemetery
	["{area:492}, west"] = "{area:492}, Westen",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "Skeletträuber, Skelettheiler und Skelettwärter halten den Westteil des Friedhofs, gleich östlich von {npc:311}s Lager.",

	-- Step 13: Sven Yorgen's Camp
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "Für {npc:1212} in {zone:1453}, im nächsten Guide",

	-- Step 14: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "Das Lager der Defias liegt im Südwesten des {zone:1431}, südlich von {area:94} nahe der Grenze zu {zone:1436}. Die Geldkassette steht zwischen den Zelten.",

	-- Step 15: Vul'Gol Ogre Mound
	-- {object:119} Abercrombie's Crate
	["Head east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Geh nach Osten zum Ogerhügel. {object:119} steht im Lager an seinem Eingang; Ogern der Splitterfaust bewachen es.",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "Nur falls ein {npc:272273} {quest:96138} fallen ließ: Rechtsklick darauf",

	-- Step 17: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Zurück nach {area:42}",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "Für {npc:482} in {zone:1453}, im nächsten Guide",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263}, im Rathaus",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, im Haus hinter dem Rathaus",
	["Wait a moment, then speak with her again"] = "Warte einen Moment und sprich sie dann erneut an",

	-- Step 18: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, im Gasthaus",
	-- {item:2594} Flagon of Mead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, von {npc:1464}",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "{npc:1217}, oben im Gasthaus",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "{npc:2104}, bei der Burg",

	-- Step 19: The wreck of the Third Fleet
	["The wreck of the Third Fleet"] = "Das Wrack der Dritten Flotte",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "Folge der Küste nach Norden zum Schiffswrack. Verfluchte Seemänner wandeln am Strand, Verfluchte Marinesoldaten an Deck; {npc:1159} steht am Strand beim Bug. Riesige Sumpflandkrokilisken lauern an der Küste gleich nördlich davon.",

	-- Step 20: Bluegill Raiders
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Bluegill Raiders"] = "Räuber der Blaukiemen",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "Folge der Küste nach Nordosten am Wrack vorbei: Die Räuber der Blaukiemen halten den Sumpf hinter den Riesigen Krokilisken.",

	-- Step 22: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "Der Kapitän wandelt auf dem Deck des Schiffswracks; seine Geldkassette steht im Laderaum.",

	-- Step 23: Glorin Steelbrow
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, in the next guide"] = "Für {npc:1284} in {zone:1453}, im nächsten Guide",

	-- Step 24: Whelgar's Excavation Site
	["Follow the road east to the excavation site."] = "Folge der Straße nach Osten zu Whelgars Ausgrabungsstätte.",

	-- Step 25: The dig and Sarltooth
	-- {npc:1353} Sarltooth
	["The dig and {npc:1353}"] = "Die Ausgrabung und {npc:1353}",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "Die Relikte liegen in der Ausgrabung selbst. {npc:1353}, ein großer Scharfzahn, streift durch das Raptorental gleich westlich davon.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: die {object:331}",

	-- Step 26: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} und Whelgar",

	-- Step 27: Dragonmaw camp
	["Dragonmaw camp"] = "Lager der Dragonmaw",
	["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "Die Orcs der Dragonmaw lagern östlich der Ausgrabungsstätte. Räuber und Sumpfläufer tragen die Kriegsbanner.",

	-- Step 28: Captain Stoutfist
	-- {area:150} Menethil Harbor
	["Head back west along the road to {area:150}."] = "Geh zurück nach Westen entlang der Straße nach {area:150}.",
	-- {quest:98221} From the Ashes · {quest:465} Nek'rosh's Gambit
	["{quest:98221}: {quest:465} comes after it on Forever"] = "{quest:98221}: {quest:465} folgt darauf in Forever",

	-- Step 29: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {npc:2091} Chieftain Nek'rosh
	["Head east again to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "Geh wieder nach Osten zum Lager der Drachenmaul. Die vier Sätze Angriffspläne liegen im {area:1036}; {npc:2091}, ein Elite, steht ebenfalls im Lager.",

	-- Step 30: To Theramore
	["To Theramore"] = "Nach Theramore",
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104}, in {area:2103}"] = "{npc:2104}, in {area:2103}",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of the next guide"] = "Für das Katapult der Dragonmaw, auf der Runde durch das {zone:1437} im nächsten Guide",
	-- {area:513} Theramore Isle · {zone:1445} Dustwallow Marsh
	["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "Nimm das Boot vom Pier von Menethil nach {area:513} in den {zone:1445}.",

	-- Step 31: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Auf der Straße nach Süden durch das {zone:1413} lagert {npc:6244} östlich der Straße, nordöstlich von {area:378}; komm von Osten und halte dich von den Wachen der Horde fern.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: in {zone:1440}, auf dem Weg nach {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: der Inkubus, neben dem Sukkubus; das {item:190309} liegt nahe {quest:1738}",

	-- Step 32: The Great Lift
	-- {zone:1413} Barrens · {area:378} Camp Taurajo · {area:485} The Great Lift · {zone:1441} Thousand Needles
	["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "Folge von Theramore der Straße nach Westen aus den Marschen von Dustwallow ins {zone:1413} und dann nach Süden; mach einen großen Bogen um {area:378}. {area:485} am Südende des {zone:1413} bringt dich hinab nach {zone:1441}. Das Tagebuch liegt am Fuß des Aufzugs.",
	-- {npc:4048} Falfindel Waywarder · {zone:1444} Feralas
	["For {npc:4048} in {zone:1444}, much later"] = "Für {npc:4048} in {zone:1444}, viel später",

	-- Step 33: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Folge den Schluchten nach Osten zur Salzebene. Die Goblins und Gnome der {area:2240} sind neutral und geben beiden Fraktionen Quests.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Für {quest:5762} im Schlingendorntal, später",

	-- Step 34: The salt flats
	["The salt flats"] = "Die Salzebene",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Scorpid Terrors = {npc:4139} Scorpid Terror
	["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868} liegt überall in der Ebene. Skorpidhäscher, Spiegelpanzerschildkröten und Salzsteinbasilisken streifen durch die Nordhälfte, Salzsteinkristallhäute, Skorpidschrecker und Spiegelpanzerschnapper durch die Mitte und die Salzsteinstarrer (34-35, fünf Stufen über dir: einzeln) durch den äußersten Süden. Salzwüstengeier kreisen über allem.",

	-- Step 35: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454}: für Martek im {zone:1418}, später",

	-- Step 36: Back to Menethil
	["Back to Menethil"] = "Zurück nach Menethil",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dragonmaw catapult"] = "Katapult der Dragonmaw",
	-- ["Ride back west along the road to {area:150}."] = "Reite die Straße zurück nach Westen nach {area:150}.",
	-- ["Ride east again to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "Reite wieder nach Osten zum Lager der Dragonmaw. Die vier Sätze Angriffspläne liegen im {area:1036}; {npc:2091}, ein Elite, steht ebenfalls im Lager.",
	-- ["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "Reite wieder nach Osten; das Katapult steht im Lager der Dragonmaw südlich der Straße.",
	-- ["Ride east to the ogre mound. {item:1349} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Reite nach Osten zum Ogerhort Vul'Gol. {item:1349} liegt im Lager am Eingang; Oger der Splitterfäuste bewachen es.",
	-- ["Ride east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Reite nach Osten zum Ogerhügel. {object:119} steht im Lager an seinem Eingang; Oger der Splitterfäuste bewachen sie.",
	-- ["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "Reite die Straße nach Westen; die Hütte des Einsiedlers steht nordöstlich des {area:492}.",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "Der nächste Schritt, Sieg über Nek'rosh, stellt dich gegen einen Elite-Häuptling: Überspring ihn.",
}
