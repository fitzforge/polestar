-- German (deDE): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Marshal's Refuge
	["Fly to Marshal's Refuge"] = "",
	-- {object:176945} Camp Mojache (no name in this language: may be words)
	["{object:176945} flight master"] = "",

	-- Step 2: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at Valor's Rest, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "",

	-- Step 3: The Spirits of Southwind
	-- {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of Southwind Village. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "",

	-- Step 5: Cenarion Hold
	["Cenarion Hold"] = "",
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 6: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Baggerschläger, Steinpanzerskorpide und Sandhuscher teilen sich den Sand gleich nördlich der Burg.",

	-- Step 7: Twilight Base Camp
	["Twilight Base Camp"] = "",
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Die leuchtenden Tafelbruchstücke liegen um das Lager der Twilight im äußersten Nordwesten; die Staubstürmer und Wüstenrumpler dort lassen sie auch fallen.",

	-- Step 8: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 9: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Zurück zum Südwindposten und steig auf den Turm. Wenn du oben den Bau aufscheuchst, kommen Wegelagerer des Ashischwarms heraus; einer trägt {item:17346}.",

	-- Step 10: The Spirits of Southwind
	["Inside"] = "",

	-- Step 11: Hermit Ortell
	["Ride south-east to Ortell's Hideout under the Un'Goro cliffs."] = "",
	["Below ground"] = "",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "",

	-- Step 12: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Baggerbrecher und Steinpanzerzangen",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Geh nach Norden entlang der westlichen Dünen; Baggerbrecher und Steinpanzerzangen ziehen von hier bis zurück zur Burg umher.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around Southwind Village: look inside the circle on the map"] = "",

	-- Step 13: General Kirika
	["Ride west to the Horde camp north of Hive'Regal."] = "",

	-- Step 14: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Silithystgeysire brechen überall in der südlichen Wüste aus. Lauf in das Silithyst, das einer zurücklässt, und bring es zum Silithyst Extractor der Horde in Kirikas Lager; Kämpfen oder Aufsteigen lässt es fallen.",

	-- Step 15: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Schinder und Felspirscher",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Steinpanzerschinder und Felspirscher streifen durch die Dünen südwestlich von Kirikas Lager.",

	-- Step 16: Twilight Vanguard
	["Twilight Vanguard"] = "Vorhut der Twilight",
	-- {npc:11803} Twilight Keeper Exeter · {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} läuft durch das Lager der Vorhut im äußersten Südwesten. Jeder Kultist hier lässt Verschlüsselte Texte der Twilight fallen, ob Quest oder nicht: Sammle zwanzig, zehn für {npc:15306} und zehn für Ortell.",

	-- Step 18: Twilight Post
	["Twilight Post"] = "",
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} hält das Lager im Westen.",

	-- Step 19: Twilight Outpost
	["Twilight Outpost"] = "",
	-- {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of Cenarion Hold. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "",

	-- Step 20: Level 58
	["Level 58"] = "",
	-- {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia · {quest:838} Scholomance
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger
	["{npc:15181}'s {quest:8304}, at Cenarion Hold, needs level 58: top up on the Twilight Avengers, Geolords and Stonecallers west of the outpost. Or, with a group, run the Blackrock Spire dungeon (Lower) or the {quest:838} dungeon instead."] = "",
	-- {npc:11880} Twilight Avenger
	["grind on {npc:11880}"] = "",

	-- Step 21: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold: the texts are already in your bags"] = "",

	-- Step 22: Hermit Ortell
	["Ride north-east to Ortell's Hideout."] = "",

	-- Step 23: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "Der Ranzen liegt in den Bergen im äußersten Süden, hinter Bronzebeards Lager. Totenstachel, ein Eliteskorpid, patrouilliert in der Nähe: Schnapp ihn dir, während er weg ist.",

	-- Step 24: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "",

	-- Step 25: Twilight Base Camp
	["The spare texts from the cultists"] = "Die übrigen Texte von den Kultisten",

	-- Step 26: Back to Cenarion Hold
	["Back to Cenarion Hold"] = "",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	["Mar'alith's next errand, Into the Maw of Madness, leads into Hive'Regal among elites. Skip it."] = "",

	-- Step 28: Layo Starstrike
	-- {zone:1451} Silithus
	["Ride north-east to Valor's Rest; you leave {zone:1451} through the pass beside it."] = "",

	-- Step 30: Marshal's Refuge
	["Marshal's Refuge"] = "",
	-- {npc:8737} Linken
	["Through the pass and east along the northern cliffs to Marshal's Refuge. {npc:8737} stands by the cave."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",

	-- Step 31: Frenzied Pterrordax
	-- {npc:9167} Frenzied Pterrordax
	["{npc:9167} walks around here: look inside the circle on the map"] = "",

	-- Step 32: Krakle
	-- {npc:10302} Krakle
	["{npc:10302} the goblin sits at Golakka Hot Springs, just east of the pylon."] = "",

	-- Step 33: Krakle's Thermometer
	-- {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to Fire Plume Ridge, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "",

	-- Step 34: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} schickt dich zu {npc:9298} in {zone:1452}: Behalte es.",

	-- Step 35: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the Slithering Scar, to call the {npc:10041} (level 56)."] = "",

	-- Step 36: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Behalte den Köder: {npc:9684} ist Stufe 56, und die zweite Runde führt an seinem Unterschlupf vorbei.",

	-- Step 37: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Der Unterschlupf von {npc:9684} liegt gleich südlich des Pylons. Benutze dort {npc:9619}s Köder; {npc:9684} ist Stufe 56 und schlägt hart zu, also fang mit voller Gesundheit an.",

	-- Step 38: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",

	-- Step 39: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117} is inside the cave."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the Emerald Sanctuary, on the next guide's way through {zone:1448}."] = "",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Benutze {npc:10980} an {npc:10977}",

	-- Step 40: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} sitzt verirrt und erschöpft auf dem Grat.",

	-- Step 41: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to Marshal's Refuge. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 43: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619} will jetzt das Fell von {npc:9622}, zurück in der nordöstlichen Höhle: Überspringe es.",

	-- Step 45: Gadgetzan
	["Gadgetzan"] = "",
	-- {object:142071} Egg-O-Matic
	["Fly to Gadgetzan. The {object:142071} stands in the middle of town."] = "",

	-- Step 46: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	["Gadgetzan flight master"] = "",

	-- Step 47: Class trainer
	["Class trainer"] = "",

	-- Step 48: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 51: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 54: Radley and Durgen
	["Radley and Durgen"] = "Radley und Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward Hearthglen.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 56: Davil's Libram
	["The libram lies further north, on the way to Hearthglen."] = "",

	-- Step 57: Hearthglen
	["Hearthglen"] = "",
	["Hearthglen's Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 59: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Wachtürme und Silos von Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Reite nach Süden nach Andorhal. {npc:10667} wartet im verfallenen Gasthaus auf der Westseite der Stadt. Stell dich mit der {item:12815} in den Eingang jedes der vier Türme, um ihn zu markieren; halte dich an den Stadtrand. Benutze den {item:12627} bei den Silos mitten in der Stadt, um Temporale Parasiten hervorzulocken.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Markiere {npc:10903} mit der {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Markiere {npc:10904} mit der {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Markiere {npc:10905} mit der {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Markiere {npc:10902} mit der {item:12815}",

	-- Step 60: Chromie
	["Upstairs"] = "",

	-- Step 61: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 64: The Bulwark
	["The Bulwark"] = "",

	-- Step 66: Dalson's Tears
	["Dalson's Tears"] = "",
	-- {npc:11077} Cauldron Lord Malvinious
	["East along the road, {npc:11077} guards the cauldron at Dalson's Tears."] = "",

	-- Step 68: Northridge Lumber Camp
	["Northridge Lumber Camp"] = "",
	["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Nach Norden zum Holzlager Northridge; stell das Fass mit Pestland-Termiten mitten in der Mühle ab.",

	-- Step 69: Redpath's Shield
	-- {npc:1855} Tirion Fordring
	["The shield lies at Gahrron's Withering, south of {npc:1855}'s hut."] = "",

	-- Step 70: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to {npc:1855}'s hut by the Thondroril River and hear him out."] = "",

	-- Step 72: Light's Hope Chapel
	["Light's Hope Chapel"] = "",

	-- Step 73: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Champions der Geißel",
	-- {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the Noxious Glade, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "",

	-- Step 75: Hameya's scroll
	["Hameya's scroll"] = "Hameyas Schriftrolle",
	["A torn scroll lies at the entrance of the Undercroft, the crypt south of the Marris Stead."] = "",

	-- Step 76: Pamela and the Undercroft
	["Pamela and the Undercroft"] = "",
	-- {npc:11886} Mercutio Filthgorger
	["Ride to Darrowshire in the south-west; Pamela plays among the houses. {npc:11886} lurks in the Undercroft, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 78: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Reite nach Nordwesten zu {npc:1855}s Hütte.",

	-- Step 81: Level 59.14
	["Level 59.14"] = "",
	-- {quest:6135} Duskwing, Oh How I Hate Thee... · {quest:838} Scholomance
	["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the Stratholme dungeon instead."] = "",
	-- {npc:10717} Temporal Parasite
	["grind on {npc:10717}"] = "",

	-- Step 82: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Reite nach Südwesten zu {npc:10667} in Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "Die Schlacht um Darrowshire von {npc:10667} endet gegen Elitegegner. Überspring sie.",

	-- Step 83: The Bulwark
	["West to the Bulwark."] = "",

	-- Step 84: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 86: Of Lost Honor
	["Underwater"] = "",

	-- Step 87: Infiltrator Hameya
	["Hameya hides among the Mossflayer trolls of Zul'Mashar, in the north-east corner.\nCareful: The trolls along the path to Zul'Mashar are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 90: Hameya's mound
	["Hameya's mound"] = "Hameyas Hügel",
	-- {object:177675} Mound of Dirt
	["The {object:177675} is just behind the Undercroft."] = "",

	-- Step 91: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:3425}"] = "Zurück nach {area:3425}",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Dithers bietet {item:14619} an ({quest:838}). Überspring sie.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Baggerschläger, Steinpanzerskorpide und Sandhuscher teilen sich den Sand gleich nördlich der Burg.",
	-- ["Dredge and scorpids"] = "Bagger und Skorpide",
	-- ["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Weiter östlich an der Straße bewacht {npc:11077} den Kessel bei {area:200}.",
	-- ["Fly to {area:1637} and train."] = "Flieg nach {area:1637} und trainiere.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Flieg nach {area:976}. Der {object:142071} steht mitten in der Stadt.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Behalte {quest:3942}: {npc:9116} ist im Refugium ({area:2479}), auf dem Weg des nächsten Guides durch den {zone:1448}.",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Mar'aliths Liebste Natalia braucht Stufe 58 und führt in den {area:2744} zwischen Elitegegner. Überspring sie.",
	-- ["Ride east across the plaguelands to the chapel."] = "Reite nach Osten durch die Pestländer zur Kapelle.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Reite die Straße entlang nach Osten zum {area:152} an der Grenze.",
	-- ["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Reite nach Osten zu {npc:1855}s Hütte am Fluss {area:2619} und hör ihn an.",
	-- ["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Reite nach Nordosten zur {area:3077}; du verlässt {zone:1451} durch den Pass daneben.",
	-- ["Ride north-east to {area:3447}."] = "Reite nach Nordosten zu {area:3447}.",
	-- ["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Reite nach Südosten zu {area:3447} unter den Klippen des Un'Goro-Kraters.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Reite nach Südwesten zu den Ruinen vom {area:2738}. Der {object:179565} für {npc:11801} steht in einem der verfallenen Häuser.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Reite nach {area:2262} im Südwesten; {npc:10926} spielt zwischen den Häusern. {npc:11886} lauert im Tiefgewölbe ({area:2261}), der Gruft gleich westlich des Orts.",
	-- ["Ride west to the Horde camp north of {area:2744}."] = "Reite nach Westen zum Lager der Horde nördlich vom {area:2744}.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Reite nach Westen zur ummauerten Burg mitten in der Wüste.",
	-- ["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Champions der Geißel streifen durch das Tal ({area:2270}) nördlich der Kapelle. Führe {npc:11063}s {item:13156} über jeden, den du tötest: Die Schädel, die mitschwingen, sind die, die er will.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Nimm den Zeppelin vom Turm vor {area:1637} nach {zone:1420} und reite nach {zone:1458}. Fürstin Sylvanas hält das {object:36126}.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Die leuchtenden Tafelbruchstücke liegen um das Lager der Twilight im äußersten Nordwesten; die Staubstürmer und Wüstenrumpler dort lassen sie auch fallen.",
	-- ["The libram lies further north, on the way to {area:190}."] = "Davils Buchband liegt weiter nördlich, auf dem Weg nach {area:190}.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Der Pass aus dem Un'Goro-Krater endet an der {area:3077}, dem Friedhof im Nordosten von {zone:1451}. {npc:13220} steht zwischen den Gräbern.",
	-- ["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Der Schild liegt bei {area:201}, südlich von {npc:1855}s Hütte.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Durch den Pass und nach Osten entlang der nördlichen Klippen zu {area:541}. {npc:8737} steht bei der Höhle; {npc:9117} ist drinnen.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Nach Westen zum {area:152}. Der nächste Guide beginnt in {zone:1458}, ein kurzer Ritt nach Westen.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "Der Hof von {npc:10778} ist der erste östlich vom {area:152}. Plappernde Ghule auf dem Hof tragen die andere Hälfte ihres Amuletts; {npc:11075} bewacht den Kessel auf dem Feld.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} und {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}s eigener Auftrag ist nicht auf dieser Route. Überspring ihn.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} steht im Außenposten westlich von {area:3425}. Füll deine Verschlüsselten Texte der Twilight bei den Kultisten hier auf zwanzig auf.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Die Aufträge von {npc:11878} sind nicht auf dieser Route. Überspring sie.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}, nördlich vom Tiefgewölbe ({area:2261}).",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, auf der Westseite der Burg",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}s nächste Aufgabe, Von verlorener Ehre, ist nicht auf dieser Route. Überspring sie.",
}
