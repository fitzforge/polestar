-- German (deDE): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kerlonian Evershade
	-- {area:442} Auberdine · {area:448} Grove of the Ancients · {npc:11218} Kerlonian Evershade · {item:13536} Horn of Awakening · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Back north from the glaive (Druids: south along the road from {area:442}) to the {area:448}, where {npc:11218} sleeps beside Arbal. Take his quest, open his chest for the {item:13536}, use it to wake him and lead him south along the road to his bag at the southern edge of {zone:1439}; blow the horn again whenever he falls asleep. Then go on to {npc:11219} at {area:413}.\nCareful: Scripted ambushes of three mobs each attack along the road."] = "",
	-- {object:176634} Kerlonian's Chest
	["{object:176634}, beside him"] = "",
	-- {npc:11218} Kerlonian Evershade · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Escort {npc:11218} south along the road to his bag at the southern edge of {zone:1439}, then go on to {npc:11219} at {area:413}."] = "",

	-- Step 4: Bathran's Haunt: kill these as you meet them
	-- {area:411} Bathran's Haunt
	["{area:411}: kill these as you meet them"] = "",
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Nördlich von Maestras Posten liegen Pflanzenbündel um die Ruinen von {area:411}. Kultisten des dunklen Strangs halten die Ruinen gleich südlich davon: Jeder von ihnen kann {item:5366} fallen lassen.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, von den Pflanzenbündeln",

	-- Step 6: Astranaar
	-- {area:413} Maestra's Post · {npc:3845} Shindrell Swiftfire · {npc:4079} Sentinel Thenysil · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["The road from {area:413} comes in by the flight master: {npc:3845} and {npc:4079} stand there, {npc:3691} in the inn, {npc:3894} inside the building beyond it."] = "",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, im Gasthaus",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {area:442} Auberdine
	["{npc:3691}: {quest:990}, from {area:442}"] = "",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 7: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Geh nach Westen zum Ufer des {area:441}. Teronis liegt zwischen den Salzspuckmurlocs; jeder Murloc kann {item:5463} fallen lassen.",

	-- Step 8: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Südlich der Murlocs wartet {npc:3585} bei {area:416}.",

	-- Step 9: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "Die Tränen leuchten auf der kleinen Insel östlich von {area:415}.",

	-- Step 11: Stonetalon Mountains
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {area:2160} Windshear Mine
	["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}, north of the {area:2160}."] = "",

	-- Step 12: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} at the east end of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "",
	["Below ground"] = "",
	-- {npc:4276} Piznik
	["Keep {npc:4276} alive while he mines, below ground"] = "",

	-- Step 13: Windshear Crag
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["{npc:4080} and {npc:4077} camp on the {area:1076}, south-west of the mine."] = "",

	-- Step 14: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle
	["His hut stands just north of {npc:4080} and {npc:4077}."] = "",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "",

	-- Step 16: Windshear Crag: kill these as you meet them
	-- {area:461} Windshear Crag
	["{area:461}: kill these as you meet them"] = "",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "Die Venture Co. rodet den Wald von {area:461}. Holzarbeiter und Roder arbeiten überall; die Maschinenführer steuern die Schredder, und einer trägt die Baupläne.",

	-- Step 17: Webwinder Path
	["Inside"] = "",

	-- Step 18: The Ruins of Stardust
	-- {area:1276} Talondeep Path · {area:421} Mystral Lake
	["Back north through the {area:1276}: west of {area:421}, the stardust bushes grow among the ruins."] = "",

	-- Step 19: Alonso
	-- {npc:210995} Alonso · {area:1276} Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "",

	-- Step 20: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} steht bei {area:420} am Ostufer von {area:421}; {npc:210995} lagert an dessen Westufer. Beschmutzte Wasserelementare waten im See dazwischen.",
	["Underwater"] = "",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Töte die Elementare für 5 intakte Elementararmschienen und benutze dann {item:5456}",

	-- Step 21: The Foulweald
	["The Foulweald"] = "Die Fäulnisklauen",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Die Furbolgs der Fäulnisklauen leben in den Wäldern südlich der Straße, südöstlich von {area:415}. Der Höhlenbehüter und die Ursas bewachen die Höhle.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Folge der Straße nach Osten zu {area:419}; {npc:3916} steht am Mondbrunnen.",

	-- Step 23: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "",

	-- Step 24: Ilkrud Magthrull
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar · {area:412} Ruins of Ordil'Aran · {npc:3664} Ilkrud Magthrull
	["From {npc:3987}'s camp head south-west past {area:415} (its hand-ins wait for the way back) to the {area:412} south of the shrine: {npc:3664} and his voidwalkers hold them. Pull his guards first."] = "",

	-- Step 25: The Zoram Strand
	-- {area:414} Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Folge der Küste nach Norden zum {area:414}. {npc:3846} lagert am Strand; Naga der Rächerflossen bevölkern das Ufer.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, in den Ruinen am Ufer",
	-- {item:5490} Wrathtail Head
	["{item:5490}: any Wrathtail naga on the strand"] = "",

	-- Step 27: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} streift mit Wachen der Rächerflossen über die Nordspitze des {area:414}s.",

	-- Step 29: Maestra's Post
	-- {npc:3663} Delgren the Purifier · {zone:1440} Ashenvale
	["{npc:3663}: its circles are for your next {zone:1440} visit, at about 28"] = "",

	-- Step 30: Astranaar
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3845} Shindrell Swiftfire · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["Follow the road south-east from {area:413} back to {area:415}: {npc:3845} by the flight master, {npc:3691} in the inn, {npc:3894} inside."] = "",

	-- Step 31: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 32: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- Step 33: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "Nach {area:150}",

	-- Step 34: Menethil Harbor
	-- {npc:1242} Karl Boran · {npc:2094} James Halloran · {npc:2086} Valstag Ironjaw · {npc:1239} First Mate Fitzsimmons · {npc:1480} Caitlin Grassman · {npc:2111} Sida · {npc:2096} Tarrel Rockweaver
	["Off the boat, walk up the pier: {npc:1242} on the pier, {npc:2094} by the docks to the north, {npc:2086} in the keep, the inn ({npc:1239}) east of it with {npc:1480} and {npc:2111} beside it, {npc:2096} by the north gate on the way out east."] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, auf dem Pier nördlich des Gasthauses",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, im Gasthaus",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "{npc:2096}: Er bietet 305 nicht an, solange du es bei dir trägst",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, beim Nordtor",

	-- Step 35: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Holz- und Eisenstapel liegen um die Burg und entlang der Hafenmauern.",

	-- Step 36: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Folge der Küste von Menethil aus nach Norden. Murlocs der Blaukiemen füllen den Sumpf; {npc:1259} zieht mit einer Gruppe mitten hindurch.",

	-- Step 37: Young crocolisks
	["Young crocolisks"] = "Junge Krokilisken",
	-- {zone:1437} Wetlands
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["From the marsh head east across the {zone:1437}. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "",

	-- Step 38: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "Die Ausgrabungsstätte liegt auf dem Hügel südlich der Straße.",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "",

	-- Step 39: The raptor hills
	["The raptor hills"] = "Die Raptorenhügel",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "",

	-- Step 40: Ormer Ironbraid
	-- {npc:1078} Ormer Ironbraid · {zone:1437} Wetlands
	["{npc:1078}: the bigger raptors in the valley west of the dig are for your next {zone:1437} visit, at about 27"] = "",

	-- Step 41: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} lagert an der Straße; {npc:1244} steht weiter östlich am Fluss.",

	-- Step 42: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Höhlenpirscher und Egelpirscher füllen {area:1021}, die Höhle südöstlich der Ausgrabungsstätte.",

	-- Step 43: The Mosshide gnolls
	["The Mosshide gnolls"] = "Die Gnolle der Moosfelle",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Gnolle der Moosfelle und Bastarde der Moosfelle halten die Hügel südöstlich von {area:1025}.",

	-- Step 44: Rethiel the Greenwarden
	-- {area:309} Ironbeard's Tomb · {npc:1244} Rethiel the Greenwarden · {zone:1437} Wetlands
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Its flint comes from the Mosshide Fenrunners on the way to {area:309}; {npc:1244} takes it on your next {zone:1437} visit"] = "",

	-- Step 45: Ironbeard's Tomb
	-- {npc:1244} Rethiel the Greenwarden · {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner · Monstrous Oozes = {npc:1033} Monstrous Ooze
	["North-west from {npc:1244}: Mosshide Fenrunners and Mistweavers roam the riverbanks on the way, and almost every one drops flint. Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag."] = "",
	-- {item:2611} Crude Flint
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["{item:2611}: Mosshide Fenrunners and Mistweavers"] = "",

	-- Step 46: Menethil
	["Menethil"] = "",
	-- {npc:2096} Tarrel Rockweaver · {npc:2111} Sida · {npc:1480} Caitlin Grassman · {npc:2086} Valstag Ironjaw · {npc:2094} James Halloran · {npc:1242} Karl Boran
	["Back west along the road into Menethil: {npc:2096} by the road in, {npc:2111} and {npc:1480} at the inn, {npc:2086} in the keep, {npc:2094} on the west side by the docks, {npc:1242} on the pier north of the inn."] = "",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, in the keep"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier"] = "",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn: you have both flight paths since your first trip east."] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 48: Ironforge
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:4081} Lomac Gearstrip · {object:171524} Tinker Town · {area:2257} Deeprun Tram
	["The gryphons land in the {object:32372}. {npc:4081} stands in {object:171524}, east of it, by the {area:2257}."] = "",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Nur mit {item:5352} aus {zone:1439}: {npc:2786}, {object:32383}",

	-- Step 49: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 50: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 51: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 52: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 53: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["The tram comes in at the {object:28027}; walk west to the {object:2098}: {npc:1646} stands at its east side. (The route hands his letter in at the end of 03-loch-modan; this is for a character still carrying it.)"] = "",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: Thundris' Brief aus {area:442}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, back in {area:442} (06-wetlands)"] = "",

	-- Step 54: Cathedral Square
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:376} High Priestess Laurena
	["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:376} is in the Cathedral of Light."] = "",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {npc:11406} in {zone:1455} nimmt sie an, später",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {npc:258785} in {zone:1455} nimmt sie an, später",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {npc:11401} in {zone:1457} nimmt sie an, später",

	-- Step 55: Master Mathias Shaw
	-- {object:2100} Old Town
	["Mathias Shaw is at SI:7 in {object:2100}, south of the Keep."] = "",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}'s second loop"] = "",

	-- Step 56: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{object:2164} is in the {object:2101}. Warlocks: {npc:6122} is in its cellar."] = "",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {npc:6244} in {zone:1413} nimmt sie an, später",

	-- Step 57: Trade District
	-- {zone:1453} Stormwind · {zone:1431} Duskwood
	["Next: training in {zone:1453}, then the road east through Elwynn and south to {zone:1431}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "Zurück zur Kathedrale des Lichts: {npc:928} steht drinnen.",
	-- ["Black Oozes"] = "Schwarze Brühschlammer",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Schwarze Brühschlammer kriechen durch den Sumpf nördlich der Straße durch {area:1025}, westlich von {npc:2093}s Lager. Jeder Schlammer kann den Beutel von {npc:2111} haben.",
	-- ["Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of {npc:2093}'s camp. Any ooze there may hold {npc:2111}'s bag."] = "Schwarze, Karmesinrote und Monströse Brühschlammer füllen {area:309}, direkt westlich der Straße nach {area:205} und nördlich vom Lager von {npc:2093}. Jeder Schlammer dort kann den Beutel von {npc:2111} tragen.",
	-- ["Cathedral of Light"] = "Kathedrale des Lichts",
	-- ["Dragonmaw camp"] = "Lager der Dragonmaw",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "Eskortiere Kerlonian zu {area:413} in {zone:1440}.",
	-- ["Fen Creepers"] = "Moorkrabbler",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Moorkrabbler verstecken sich in den Sumpftümpeln nordwestlich von {area:1025}.",
	-- ["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Folge der Straße nach Osten. Junge Sumpflandkrokilisken lauern in den Tümpeln nördlich der Ausgrabungsstätte.",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Folge der Straße nach Norden nach {area:205}, am Fuß von {area:881}. {npc:1071} steht im Lager der Zwerge.",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "Folge der Straße nach Südosten nach {area:415}, auf der Insel im See.",
	-- ["For Bolvar Fordragon in {object:2117}: keep it"] = "Für Bolvar Fordragon in {object:2117}: behalte sie",
	-- ["For the giant crocolisks of the north coast, on your next visit"] = "Für die Riesigen Sumpflandkrokilisken der Nordküste, bei deinem nächsten Besuch",
	-- ["For {npc:2228} in {area:271}: keep it"] = "Für {npc:2228} in {area:271}: behalte es",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then head south along the road through {zone:1439}."] = "Nimm von {area:17203} das Schiff nach {area:442}; {npc:3649} steht am Nordende des Dorfes. Geh dann südlich der Straße durch {zone:1439}.",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "Nimm vom {area:17203} das Schiff nach {area:442}; {npc:3649} steht am Nordende des Dorfes. Reite dann auf der Straße nach Süden durch {zone:1439}.",
	-- ["Head east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Geh entlang der Straße von {zone:1437} nach Osten, südlich durch {area:836} nach {zone:1432} und westlich durch den Tunnel nach {zone:1426} zu {area:1537}.",
	-- ["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Geh nach Süden am {area:421} vorbei in den Tunnel {area:1276}; er kommt in Steinkrallengebirges {area:461} heraus. {npc:4080} und {npc:4077} lagern auf dem {area:1076} südwestlich des Felsens.",
	-- ["Hearth to Menethil"] = "Ruhestein nach Menethil",
	-- ["Hearthstone on cooldown? Head back north through the {area:1276}."] = "Ruhestein auf Abklingzeit? Geh zurück nach Norden durch den {area:1276}.",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Ruhestein noch nicht bereit? Reite nach Norden zurück durch {area:1276}.",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Kerlonian schläft bei {area:448} im Süden von {zone:1439}. Benutze {item:13536}, um ihn zu wecken, und führe ihn auf der Straße nach Süden nach {zone:1440} zu {npc:11219} bei {area:413}; blas erneut ins Horn, wann immer er einschläft.",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Moorläufer der Moosfelle und Nebelwirker der Moosfelle streifen an den Flussufern gleich westlich und südlich von {npc:1244} umher; fast jeder lässt Feuerstein fallen.",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Scheckige Raptoren und Scheckige Kreischer streifen durch die Hügel westlich der Ausgrabungsstätte.",
	-- ["Next: fly to {area:42}."] = "Als Nächstes: Flieg nach {area:42}.",
	-- ["Only if you looted {quest:337} in {zone:1431}"] = "Nur wenn du {quest:337} in {zone:1431} erbeutet hast",
	-- ["Raptor valley"] = "Raptorental",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Reite auf der Straße durch {zone:1437} nach Osten, nach Süden durch {area:836} nach {zone:1432} und nach Westen durch den Tunnel nach {zone:1426} bis {area:1537}.",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Reite nach Süden an {area:421} vorbei in den Tunnel {area:1276}; er führt im Steinkrallengebirge bei {area:461} heraus. {npc:4080} und {npc:4077} lagern am {area:1076} südwestlich der Klippe.",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Reite nach Westen ans Ufer von {area:441}. Teronis liegt zwischen den Murlocs der Salzflossen; jeder Murloc kann {item:5463} fallen lassen.",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Nimm das Schiff vom {area:17203} nach {area:442} und flieg nach {area:702}; {npc:11401} ist im Tempel des Mondes. Flieg dann zurück nach {area:442}.",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Nimm das Schiff vom {area:17203} nach {area:442}. Füge die beiden Anhängerhälften zu {item:15885} zusammen und wirke {spell:18960}: {npc:11802} ist in {area:2361}. Flieg dann nach {area:702} (über {area:442}).",
	-- ["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Nimm das Portal hinauf nach {area:1658} und flieg dann zurück nach {area:442}.",
	-- ["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Nimm {area:2257} von {object:171524} zu {object:28027} in {zone:1453} und geh dann zu {object:2098}.",
	-- ["The Bluegill hovels"] = "Die Hütten der Blaukiemen",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "Das Lager der Dragonmaw liegt südlich der Straße, gleich westlich von {area:1025}: Räuber, Sumpfläufer und Knochenwärter der Dragonmaw. Die Quest von {npc:2092} in {zone:1426} erfordert Stufe 28.",
	-- ["The bigger raptors hunt in the valley just west of the dig."] = "Die größeren Raptoren jagen im Tal gleich westlich der Ausgrabung.",
	-- ["The excavation site sits on the hill south of the road."] = "Die Ausgrabungsstätte liegt auf dem Hügel südlich der Straße.",
	-- ["The raptor hills"] = "Die Raptorenhügel",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Drei Behälter in den Murlochütten, von Süden nach Norden: {object:261}, dann {object:142151}, dann {object:259} am Nordende.",
	-- ["Venture Co. loggers"] = "Holzarbeiter der Venture Co.",
	-- ["West of Mystral Lake, the stardust bushes grow among the ruins."] = "Westlich vom Mystralsee wachsen die Sternenstaubbüsche zwischen den Ruinen.",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "grinde Räuber und Sumpfläufer der Dragonmaw im Lager der Dragonmaw, {zone:1437}",
	-- ["{item:15885}: join the two halves"] = "{item:15885}: Füge die beiden Hälften zusammen",
	-- ["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} und {npc:258785} sind in {object:32386}, in {object:32362}.",
	-- ["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: für {npc:2104} in der Burg",
	-- ["{npc:1440}, in the Royal Library"] = "{npc:1440}, in der Königlichen Bibliothek",
	-- ["{npc:1444}, in the {object:2098}"] = "{npc:1444}, auf {object:2098}",
	-- ["{npc:1573}, in the {object:32372}"] = "{npc:1573}, bei {object:32372}",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: Thundris' Brief aus {area:442}",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}, bei der Burg",
	-- ["{npc:2094}, by the north gate"] = "{npc:2094}, beim Nordtor",
	-- ["{npc:2097}, by the north gate"] = "{npc:2097}, beim Nordtor",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} steht in {area:2103}, ein kurzes Stück von {npc:1242} entfernt.",
	-- ["{npc:210995} may not offer these to every class; if he doesn't, carry on."] = "{npc:210995} bietet diese vielleicht nicht jeder Klasse an; wenn nicht, mach weiter.",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649}: Alexstons Antwort",
	-- ["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649}: Alexstons Antwort, falls du sie in {zone:1453} angenommen hast",
	-- ["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} und seine Leerwandler halten {area:412} südlich des Schreins. Lock zuerst seine Wachen.",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) führt die Gnolle der Distelfelle im Lager nördlich von {area:415} an. Räum zuerst seine Wachen weg, eine nach der anderen.",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}, in der Hütte nördlich von ihnen",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} schürft in der {area:2160} am Ostende der Klippe. Sprich mit ihm und wehre die Angreifer der Venture Co. ab, während er schürft.",
	-- ["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, der Käseladen in {object:2096}",
	-- ["{npc:4959} and {npc:482}"] = "{npc:4959} und {npc:482}",
	-- ["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, in der Kathedrale des Lichts",
	-- ["{object:2164} is in the {object:2101}."] = "{object:2164} ist in {object:2101}.",
	-- ["{zone:1455} priests"] = "Priester in {zone:1455}",
}
