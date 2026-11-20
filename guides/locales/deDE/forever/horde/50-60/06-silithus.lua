-- German (deDE): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1446} Tanaris · {zone:1451} Silithus
	["{zone:1446}, {zone:1451} & the Plaguelands"] = "",
	-- {zone:1446} Tanaris · {zone:1451} Silithus
	["{zone:1446}, {zone:1451} and the Plaguelands."] = "",
	["Takes you all the way to 60"] = "Bringt dich bis Stufe 60",
	["Stays on the main route"] = "Bleibt auf der Hauptroute",
	["Finishes the Plaguelands chains"] = "",
	["Lots of flying between zones"] = "Viel Fliegen zwischen den Gebieten",

	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Flugmeister in {area:2255}",

	-- Step 2: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Trink das {item:11243} auf dem Friedhof direkt östlich von {area:976}: Es tötet dich, und nur als Geist kannst du {npc:9299} sehen, in einer Felsspalte in den Hügeln genau nördlich davon. Sprich dort mit ihm, lauf dann zurück zu deinem Körper und belebe dich wieder: Der Auffällige Grabstein, zu dem er dich schickt, steht auf diesem Friedhof.",

	-- Step 3: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Benutze {item:12928} an {npc:7583}, dem Goblinmädchen in {area:976}. {npc:10977} und {npc:10978} erschreckst du später auf der Route.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Verscheuche {npc:7583} mit {item:12928}",

	-- Step 4: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1413} guide"] = "",

	-- Step 5: Alchemist Pestlezugg
	["Inside"] = "Drinnen",

	-- Step 6: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} geht zurück zu {npc:8737} in Un'Goro: Behalte sie.",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} lagert an der Straße zur {area:1336}, südlich von {area:976}.",

	-- Step 8: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Flieg nach {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Flugmeister von {area:976}",

	-- Step 9: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken · {area:537} Fire Plume Ridge
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. Take her errand before climbing {area:537}."] = "",
	-- {npc:8737} Linken
	["Hold {npc:8737}'s errand for your return to the refuge."] = "",

	-- Step 10: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Der Goblin {npc:10302} sitzt am Ort {area:543}, gleich östlich des Pylons.",

	-- Step 11: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Reite nach Osten zum Ort {area:537}, steig hinauf und benutze {npc:10541} am Lavaschlot nahe dem Gipfel; reite dann zurück nach Westen zu {npc:10302}.",

	-- Step 12: Volcanic Activity
	-- plural, as words: Scorching Elementals = {npc:6520} Scorching Elemental · Living Blazes = {npc:6521} Living Blaze
	["Collect ash from the Scorching Elementals and Living Blazes on the ridge. Stay outside Blazerunner's cave: he is elite."] = "",

	-- Step 13: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} sitzt verirrt und erschöpft auf dem Grat.",
	["Below ground"] = "Unter der Erde",

	-- Step 14: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führ {npc:9999} nach Norden nach {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",

	-- Step 16: Quixxil
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	-- was: ["Scare {npc:10977} with {npc:10980}"] = "Erschrecke {npc:10977} mit {npc:10980}"
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 17: J.D. Collie
	-- {npc:9117} J.D. Collie
	["{npc:9117} is at the back of the refuge cave."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, unter der Erde",

	-- Step 18: Linken's Memory
	-- {quest:3942} Linken's Memory · {area:2479} Emerald Sanctuary
	["Keep {quest:3942} for Eridan at the {area:2479}."] = "",

	-- Step 19: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} schickt dich zu {npc:9298} in {zone:1452}: Behalte es.",

	-- Step 20: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "Nur wenn du auf dem Weg hierher {quest:4496} in {area:976} angenommen hast: Die Gorishi in {area:540} südlich von {area:537} droppen die Duftdrüse, und die meisten Tiere und Pflanzen des Kraters droppen {item:11018}.",

	-- Step 21: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "Benutze {item:11833} dort, wo der Pfeil hinzeigt, im Gorishi-Bau von {area:540}, um {npc:10041} (Stufe 56) zu rufen.",

	-- Step 22: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56 and his lair lies on the way to the north-east plateau."] = "",

	-- Step 24: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Der Unterschlupf von {npc:9684} liegt gleich südlich des Pylons. Benutze dort {npc:9619}s Köder; {npc:9684} ist Stufe 56 und schlägt hart zu, also fang mit voller Gesundheit an.",

	-- Step 25: The Mighty U'cha
	-- {npc:9684} Lar'korwi · {npc:9622} U'cha
	["Ride north from {npc:9684} to the gorilla cave on the plateau. {npc:9622} is level 55. Clear a path in one gorilla at a time."] = "",

	-- Step 27: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["Ride around the crater to the north-western pass. It leads up to {area:3077} in {zone:1451}; {npc:13220} stands among the graves."] = "",

	-- Step 28: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	-- was: ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Reite nach Südwesten zu den Ruinen vom {area:2738}. Der {object:179565} für {npc:11801} steht in einem der verfallenen Häuser."
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Reite nach Südwesten zu den Ruinen vom {area:2738}. Der {object:179565} für {npc:11801} steht in einem der verfallenen Häuser.",

	-- Step 30: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Ride back to the Southwind tower and climb it. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "",

	-- Step 32: Layo Starstrike
	-- {area:3077} Valor's Rest · {npc:13220} Layo Starstrike
	["Ride north-east from Southwind to {area:3077}. Give {npc:13220} the object from the tower before heading for the southern dunes."] = "",

	-- Step 33: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Reite nach Westen zur ummauerten Festung mitten in der Wüste. {npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 34: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: Töte sie, wenn du ihnen begegnest",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Baggerschläger, Steinpanzerskorpide und Sandhuscher teilen sich den Sand gleich nördlich der Burg.",

	-- Step 35: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Die leuchtenden Tafelbruchstücke liegen um das Lager des Schattenhammers im äußersten Nordwesten; die Staubstürmer und Wüstenrumpler dort lassen sie auch fallen. Vorsicht: Die größten Wüstenrumpler und die Wirbelnden Eindringlinge sind Stufe 58: Zieh sie einzeln.",

	-- Step 36: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 37: Level 57
	["Level 57"] = "Stufe 57",
	-- {area:3425} Cenarion Hold · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Dredge Strikers = {npc:11740} Dredge Striker · Sand Skitterers = {npc:11738} Sand Skitterer · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Silithid Darters = {npc:231984} Silithid Darter
	["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Die Baggerbrecher (57-58) im Südosten sind unter Stufe 57 zwei Stufen über dir. Steig zuerst bei den Baggerschlägern (55-56) im Sand östlich von {area:3425} auf 57 auf, wo zwischen ihnen Sandhuscher und Steinpanzerskorpide (54-56) umherstreifen, abseits der Silithid Darters im nördlichen Sand. Oder geh mit einer Gruppe stattdessen in den Dungeon {area:1583} (unterer Teil) oder den Dungeon {quest:838}.",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker
	["Dredge Strikers"] = "Baggerschläger",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "Grinde an {npc:11740}",

	-- Step 38: Bor Wildmane
	-- {area:3425} Cenarion Hold
	["Pick up Bor's request on the way past {area:3425}. The western Twilight camp has his texts on the return from Kirika."] = "",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, auf der Westseite der Burg",

	-- Step 39: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Ride south-east to {area:3447} under the Un'Goro cliffs.\nAt 57, take level 57-58 Rock Stalkers; leave the 59s."] = "",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "{item:20377} von {npc:11739}, 130 yd südwestlich",

	-- Step 41: The Twilight Lexicon
	["All three Twilight Keepers are level 60. Bring help below 59 or leave the lexicon with Ortell."] = "",

	-- Step 42: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Baggerbrecher und Steinpanzerzangen",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Geh nach Norden entlang der westlichen Dünen; Baggerbrecher und Steinpanzerzangen ziehen von hier bis zurück zur Burg umher.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741} läuft um {area:2738} herum: schau in den Kreis auf der Karte",

	-- Step 43: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Reite nach Westen zum Lager der Horde nördlich vom {area:2744}.",

	-- Step 44: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Silithystgeysire brechen überall in der südlichen Wüste aus. Lauf in das Silithyst, das einer zurücklässt, und bring es zum Silithyst Extractor der Horde in Kirikas Lager; Kämpfen oder Aufsteigen lässt es fallen.",

	-- Step 45: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Schinder und Felspirscher",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers (57-58) and Rock Stalkers roam the dunes south-west of Kirika's camp. Below 58, leave the level 59 Stalkers alone."] = "",

	-- Step 46: Twilight Vanguard
	["Twilight Vanguard"] = "Vorhut der Twilight",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803} läuft durch das Lager der Vanguard ganz im Südwesten. Behalte jeden {item:20404}, den die Kultisten fallen lassen: {npc:15306} und Ortell wollen später je zehn.",

	-- Step 49: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} hält das Lager im Westen.",

	-- Step 51: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804} steht im Außenposten westlich von {area:3425}. Behalte auch hier alle Encrypted Twilight Texts, die fallen.",

	-- Step 53: Bor's texts
	["Bor's texts"] = "",
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["On the west side of the hold, take ten Encrypted Twilight Texts from Twilight Avengers or Geolords no more than one level above you. Pull them out from the edge; leave the named Keepers, Stonecallers and Flamereavers alone."] = "",

	-- Step 54: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} und {npc:15190} stehen oben in ihrem Gebäude: Geht drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 55: Level 58
	["Level 58"] = "Stufe 58",
	-- {npc:15181} Commander Mar'alith · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["After the hand-ins, top up only if you still need 58 for {npc:15181}. Hunt Dredge Crushers (57-58) south of the hold, away from the Twilight camps. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers"] = "",

	-- Step 57: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Reite nach Nordosten zu {area:3447}.",

	-- Step 58: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "Der Ranzen liegt in den Bergen im äußersten Süden, hinter Bronzebeards Lager. Totenstachel, ein Eliteskorpid, patrouilliert in der Nähe: Schnapp ihn dir, während er weg ist.",

	-- Step 59: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171} und {npc:15170} lagern im Lager von Bronzebeard, direkt nördlich der Berge der Tasche. Befrage sie: Geh jedes ganze Gespräch durch; du musst sie nicht bekämpfen.",

	-- Step 60: Twilight Base Camp
	-- {quest:8323} True Believers
	["Only if Ortell gave you {quest:8323}: bring him ten more texts on the return trip."] = "",

	-- Step 61: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Zurück nach {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "Mar'aliths nächster Auftrag, Into the Maw of Madness, führt unter Elites nach {area:2744}. Überspring ihn.",

	-- Step 63: Fly to Gadgetzan
	-- {area:3425} Cenarion Hold · {area:976} Gadgetzan
	["Ride from Ortell to {area:3425} and fly to {area:976} for the hive hand-ins."] = "",

	-- Step 65: Gadgetzan
	-- {area:976} Gadgetzan · {quest:2741} The Super Egg-O-Matic
	["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Flieg nach {area:976}. Hast du {quest:2741} noch dabei? Die Maschine steht mitten in der Stadt.",

	-- Step 68: Ratchet
	["Liv takes the ash at her workshop on the north end of the docks."] = "",

	-- Step 69: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",

	-- Step 70: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 71: Paladin trainer
	["Paladin trainer"] = "Paladinlehrer",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} in {zone:1456}; in {zone:1454} gibt es keinen Paladin-Lehrer",

	-- Step 74: Tai'tasi
	-- {quest:96999} Wrap Return · {zone:2482} Mount Hyjal · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {npc:3187} Tai'tasi
	["Only with {quest:96999} from {zone:2482} in your log: {area:367} is a short ride south of {zone:1454}, by the coast road; {npc:3187} stands in the village."] = "",

	-- Step 75: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",

	-- Step 76: The Bulwark
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "Reite vom Zeppelinturm die Straße entlang nach Osten zum {area:152}, auf dem Weg in die {zone:1422}.",

	-- Step 78: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp
	["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610} versteckt sich auf dem Hügel nordöstlich vom {area:192}.",

	-- Step 79: Scarlet Crusade
	["Scarlet Crusade"] = "Scharlachroter Kreuzzug",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "Ritter und Magier arbeiten im {area:192}; die Sanitäter und Jäger lagern südlich davon. Stell dabei {npc:11615}s Termitenfass mitten im Sägewerk ab.\nVorsicht: Ein {npc:10996}, ein Elite der Stufe 58-59, kann am Holzfällerlager stehen, wie an vielen anderen Stellen der {zone:1422}: Halte Abstand.",

	-- Step 81: Radley and Durgen
	["Radley and Durgen"] = "Radley und Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} steht östlich des Holzfällerlagers; {npc:11611} bewacht die Straße nordöstlich von {npc:11610}, in Richtung {area:190}.\nVorsicht: Wachen stehen am Fuß des Turms, und eine weitere kreist auf Patrouille darum. Räume sie weg, bevor du Durgen angreifst, damit sie nicht in den Kampf eingreifen.",

	-- Step 83: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "Davils Buchband liegt weiter nördlich, auf dem Weg nach {area:190}.",

	-- Step 84: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Die Scarlets von {area:190} sind Stufe 58-60. Reite zum auf deiner Karte markierten hohen Punkt, sieh dir die Stadt an und verschwinde wieder.\nVorsicht: Am Tor postierte Sentinels können getarnte Spieler entdecken. Weitere Sentinels stehen in der Stadt, und ein Elite läuft in der Nähe eine Patrouillenroute ab.",

	-- Step 86: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Wachtürme und Silos von Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Reite nach Süden nach Andorhal. {npc:10667} wartet im verfallenen Gasthaus auf der Westseite der Stadt. Stell dich mit der {item:12815} in den Eingang jedes der vier Türme, um ihn zu markieren; halte dich an den Stadtrand. Benutze den {item:12627} bei den Silos mitten in der Stadt, um Temporale Parasiten hervorzulocken.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, oben",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Markiere {npc:10903} mit der {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Markiere {npc:10904} mit der {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Markiere {npc:10905} mit der {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Markiere {npc:10902} mit der {item:12815}",

	-- Step 87: Chromie
	["Upstairs"] = "Oben",

	-- Step 88: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Die Schließkassetten stehen in den zerstörten Häusern von Andorhal rund um das Gasthaus von {npc:10667}. Vorsicht: Ghule und Skelette stehen meist neben den Kassetten und greifen an, wenn du näher kommst. Searing Ghouls verletzen außerdem jeden in der Nähe und brechen die Tarnung.",

	-- Step 92: High Executor Derrington
	-- {quest:105} Alas, Andorhal · {npc:1852} Araj the Summoner
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord
	["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "Der Splitter für {quest:105} liegt zu Füßen von {npc:1852}, mitten in Andorhal: Er ist ein Elite der Stufe 61, umgeben von Skeletal Warlords (Elite), ein Kampf für eine Gruppe.",

	-- Step 94: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Weiter östlich an der Straße bewacht {npc:11077} den Kessel bei {area:200}.",

	-- Step 95: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Bauernhaus von {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse beside the cauldron, the cabinet stands inside and the outhouse is behind it. A {npc:10816} (55) carries the outhouse key; {npc:10836} (56) comes out when you open the outhouse and carries the cabinet key."] = "",

	-- Step 97: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Der Schild liegt bei {area:201}, südlich von {npc:1855}s Hütte.",

	-- Step 98: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Reite nach Osten zu {npc:1855}s Hütte am Fluss {area:2619} und hör ihn an.",

	-- Step 101: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Champions der Geißel",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Champions der Geißel streifen durch das Tal ({area:2270}) nördlich der Kapelle. Führe {npc:11063}s {item:13156} über jeden, den du tötest: Die Schädel, die mitschwingen, sind die, die er will.",

	-- Step 103: Hameya's scroll
	["Hameya's scroll"] = "Hameyas Schriftrolle",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Eine zerrissene Schriftrolle liegt am Eingang von {area:2261}, der Gruft südlich von {area:2260}.",

	-- Step 104: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "Pamela und {area:2261}",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Reite nach {area:2262} im Südwesten; Pamela spielt zwischen den Häusern. {npc:11886} lauert in {area:2261}, der Gruft direkt westlich der Stadt.\nVorsicht: Etwa vier Nicht-Elite-Adds kommen mit Mercutio. Sie laufen zum Grab, statt sofort zu erscheinen.",

	-- Step 105: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Reite nach Nordwesten zu {npc:1855}s Hütte.",

	-- Step 107: Alas, Andorhal
	-- {npc:1852} Araj the Summoner · {object:177241} Araj's Phylactery
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord
	["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852} (61, Elite) steht mitten in Andorhal zwischen Skeletal Warlords (56-57, Elite): Töte ihn mit deiner Gruppe und nimm dann dort den Splitter aus {object:177241}.",

	-- Step 108: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Reite nach Südwesten zu {npc:10667} in Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "Die Schlacht um Darrowshire von {npc:10667} endet gegen Elitegegner. Überspring sie.",

	-- Step 109: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "Nach Westen zu {area:152}.",

	-- Step 111: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Nach {zone:1423}",

	-- Step 112: Pathstrider
	-- {area:2276} Quel'Lithien Lodge · {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider
	["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "Reite nach Nordosten zu {area:2276} bei {area:2275}: Die hochelfischen Waldläufer, Pfadschreiter und Holzfäller bewachen es, und das Register liegt drinnen. Vorsicht: Die Pfadschreiter sind 57-58, aber die Waldläufer bis 60: Zieh sie einzeln und nimm die Waldläufer zuletzt.",
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} läuft um {area:2276} herum: schau in den Kreis auf der Karte",

	-- Step 113: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "Der See für {quest:5845}",

	-- Step 114: Of Lost Honor
	["Underwater"] = "Unter Wasser",

	-- Step 115: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Hameya versteckt sich unter den Mossflayer-Trollen von {area:2273}, in der Nordostecke.\nVorsicht: Die Trolle entlang des Pfades nach {area:2273} sind Stufe 57-59. Sie laufen bei wenig Gesundheit weg und rufen um Hilfe, daher bringen sie oft Adds mit.",

	-- Step 117: Nathanos Blightcaller
	-- {npc:1855} Tirion Fordring · {area:2260} Marris Stead
	["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "Reite von {npc:1855} nach Südosten zum Bauernhaus von {area:2260}.",

	-- Step 119: Hameya's mound
	["Hameya's mound"] = "Hameyas Hügel",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675} liegt gleich südlich, hinter {area:2261}.",

	-- Step 120: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:11897} ist ein Elite der Stufe 60: Überspring ihn, wenn du allein bist.",

	-- Step 122: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "Nach {zone:1422}",

	-- Step 125: Target: Writhing Haunt
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark
	["from the cauldron, for {npc:11055} at the {area:152}"] = "vom Kessel, für {npc:11055} bei {area:152}",

	-- Step 126: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.",

	-- Step 129: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} The Writhing Haunt · {area:201} Gahrron's Withering
	["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739} lagert bei {area:202} neben dem Kessel; seine Bären streifen über die Hügel nördlich und östlich davon, auf dem Weg nach {area:201}.",

	-- Step 130: Diseased Grizzlies
	["Diseased Grizzlies"] = "Kranke Grizzlys",

	-- Step 133: Target: Gahrron's Withering
	-- {area:202} The Writhing Haunt · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "Zurück nach Osten an {area:202} vorbei zu {area:201}, der Farm unter den östlichen Hügeln: {npc:11078} bewacht ihren Kessel. Töte ihn für den Schlüssel und benutze dann den Kessel.",

	-- Step 134: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "Noch einmal nach Westen zu {area:152}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Zurück zum Südwindposten und steig auf den Turm. Wenn du oben den Bau aufscheuchst, kommen Wegelagerer des Ashischwarms heraus; einer trägt {item:17346}.",
	-- ["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Vorsicht: Un'Goro Gorillas (Stufe 50-51) rufen Verbündete im Umkreis von 20 yd zu Hilfe, sobald sie auf 25% Gesundheit fallen. In der Gegend gibt es eine Höhle voller Affen, und ein Kampf dort bringt viele Adds.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "Sammle zwanzig Encrypted Twilight Texts von den Kultisten hier, zehn für {npc:15306} und zehn für Ortell.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "Sammle zwanzig Verschlüsselte Texte der Twilight von den Kultisten hier, zehn für {npc:15306} und zehn für Ortell. Hol sie dir von den Rächern der Twilight und Geolords; lass die Flamereavers und Stonecallers (59-60) in Ruhe.",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Dithers bietet {item:14619} an ({quest:838}). Überspring sie.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Baggerschläger, Steinpanzerskorpide und Sandhuscher teilen sich den Sand gleich nördlich der Burg.",
	-- ["Dredge and scorpids"] = "Bagger und Skorpide",
	-- ["Fly to {area:1637} and train."] = "Flieg nach {area:1637} und trainiere.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Flieg nach {area:976}. Der {object:142071} steht mitten in der Stadt.",
	-- ["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "Wenn du {quest:6135} übersprungen hast, grinde hier bis Stufe 59,14, um im Plan der Route zu bleiben. Oder lauf stattdessen mit einer Gruppe den Dungeon {quest:838} oder den Dungeon {area:2279}.",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Behalte den Köder: {npc:9684} ist Stufe 56, und die zweite Runde führt an seinem Unterschlupf vorbei.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Behalte {quest:3942}: {npc:9116} ist im Refugium ({area:2479}), auf dem Weg des nächsten Guides durch den {zone:1448}.",
	-- ["Level 59.14"] = "Stufe 59,14",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Mar'aliths Liebste Natalia braucht Stufe 58 und führt in den {area:2744} zwischen Elitegegner. Überspring sie.",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Nach Norden zum Holzlager Northridge; stell das Fass mit Pestland-Termiten mitten in der Mühle ab.",
	-- ["Ride east across the plaguelands to the chapel."] = "Reite nach Osten durch die Pestländer zur Kapelle.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Reite die Straße entlang nach Osten zum {area:152} an der Grenze.",
	-- ["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Reite nach Nordosten zur {area:3077}; du verlässt {zone:1451} durch den Pass daneben.",
	-- ["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "Reite von {npc:1855} nach Südosten zu {area:2261}; {object:177675} liegt direkt dahinter.",
	-- ["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Reite nach Südosten zu {area:3447} unter den Klippen des Un'Goro-Kraters.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Reite nach Südwesten zu den Ruinen vom {area:2738}. Der {object:179565} für {npc:11801} steht in einem der verfallenen Häuser.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Reite nach {area:2262} im Südwesten; {npc:10926} spielt zwischen den Häusern. {npc:11886} lauert im Tiefgewölbe ({area:2261}), der Gruft gleich westlich des Orts.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Reite nach Westen zur ummauerten Burg mitten in der Wüste.",
	-- ["Scare {npc:10977} with {npc:10980}"] = "Erschrecke {npc:10977} mit {npc:10980}",
	-- ["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Steinpanzerschinder und Felspirscher streifen durch die Dünen südwestlich von Kirikas Lager.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Nimm den Zeppelin vom Turm vor {area:1637} nach {zone:1420} und reite nach {zone:1458}. Fürstin Sylvanas hält das {object:36126}.",
	-- ["The Spirits of Southwind"] = "Die Geister von Southwind",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Die leuchtenden Tafelbruchstücke liegen um das Lager der Twilight im äußersten Nordwesten; die Staubstürmer und Wüstenrumpler dort lassen sie auch fallen.",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "Das Sägewerk liegt direkt neben Radley: Stell {npc:11615}s Termitenfass mitten hinein.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Der Pass aus dem Un'Goro-Krater endet an der {area:3077}, dem Friedhof im Nordosten von {zone:1451}. {npc:13220} steht zwischen den Gräbern.",
	-- ["The spare texts from the cultists"] = "Die übrigen Texte von den Kultisten",
	-- ["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} liegt gleich hinter {area:2261}.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Durch den Pass und nach Osten entlang der nördlichen Klippen zu {area:541}. {npc:8737} steht bei der Höhle; {npc:9117} ist drinnen.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Durch den Pass und nach Osten entlang der nördlichen Klippen nach {area:541}. {npc:9997} steht neben dem Flugmeister.",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Steig hier auf Stufe 58 auf, bevor du zu Ortells Felspirschern (57-59) und in den Süden gehst; auch {quest:8304} von {npc:15181}, zurück in {area:3425}, braucht Stufe 58. Die Baggerbrecher (57-58) auf dem Weg nach Südosten sind die, die {npc:15191} will: Lass die Kultisten des Schattenhammers um sie herum in Ruhe. Oder geh mit einer Gruppe stattdessen in den Dungeon {area:1583} (unterer Teil) oder den Dungeon {quest:838}.",
	-- ["Use {npc:10980} on {npc:10977}"] = "Benutze {npc:10980} an {npc:10977}",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Nach Westen zum {area:152}. Der nächste Guide beginnt in {zone:1458}, ein kurzer Ritt nach Westen.",
	-- ["grind on {npc:10717}"] = "grinde {npc:10717}",
	-- ["grind on {npc:11741}"] = "grinde {npc:11741}",
	-- ["ten for each quest: {npc:15306} takes his ten before Ortell"] = "zehn für jede Quest: {npc:15306} nimmt seine zehn vor Ortell",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "Der Hof von {npc:10778} ist der erste östlich vom {area:152}. Plappernde Ghule auf dem Hof tragen die andere Hälfte ihres Amuletts; {npc:11075} bewacht den Kessel auf dem Feld.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} und {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}s eigener Auftrag ist nicht auf dieser Route. Überspring ihn.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} läuft durch das Lager der Vorhut im äußersten Südwesten. Jeder Kultist hier lässt Verschlüsselte Texte der Twilight fallen, ob Quest oder nicht: Sammle zwanzig, zehn für {npc:15306} und zehn für Ortell.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} steht im Außenposten westlich von {area:3425}. Füll deine Verschlüsselten Texte der Twilight bei den Kultisten hier auf zwanzig auf.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Die Aufträge von {npc:11878} sind nicht auf dieser Route. Überspring sie.",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{quest:8304} von {npc:15181} in {area:3425} braucht Stufe 58: Hol sie an den Dredge Crushers (57-58) westlich des Außenpostens auf und lass die Twilight Avengers, Geolords und Stonecallers (57-61) um sie herum in Ruhe. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1583} (Untere) oder den Dungeon {quest:838}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}, nördlich vom Tiefgewölbe ({area:2261}).",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, auf der Westseite der Burg",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}s nächste Aufgabe, Von verlorener Ehre, ist nicht auf dieser Route. Überspring sie.",
	-- ["{npc:9117} is inside the cave."] = "{npc:9117} ist in der Höhle.",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619} will jetzt das Fell von {npc:9622}, zurück in der nordöstlichen Höhle: Überspringe es.",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}: Töte sie, wenn du ihnen begegnest",
}
