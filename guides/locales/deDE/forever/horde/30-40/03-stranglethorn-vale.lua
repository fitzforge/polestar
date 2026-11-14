-- German (deDE): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Flugmeister: {area:2408}",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Flieg von {area:2408} nach {area:1638} und lerne bei {npc:3033} auf {area:1639}; flieg von dort weiter nach {zone:1454}.",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "Zurück nach {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "{npc:5640} steht im {object:172961} auf der Westseite der Stadt.",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Lehrer in {zone:1454}",
	["Train while you are in the city."] = "Lerne, solange du in der Stadt bist.",

	-- Step 6: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["{area:35} first: the goblins' boat sails there from {area:392}, and every {area:35} quest is for the north of the vale, which you then walk up into."] = "Zuerst {area:35}: Das Schiff der Goblins fährt von {area:392} dorthin, und alle Quests aus {area:35} führen in den Norden des Tals, in den du dann hinaufläufst.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 7: Ratchet
	-- {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["{npc:3391} waits upstairs in the house by the flight master; {quest:1111} stands on the docks, beside the boat."] = "{npc:3391} wartet oben im Haus beim Flugmeister; {quest:1111} steht auf den Docks neben dem Schiff.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, oben",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631} in {area:35}, where the boat goes"] = "{npc:3391}: für {npc:4631} in {area:35}, wohin das Schiff fährt",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}, auf den Docks",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "Dizzywigs Teile gehen zurück zu Kravel in {area:439}, abseits der Route: Lass sie liegen.",

	-- Step 8: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Schiff nach {area:35}",

	-- Step 9: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil · {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:2858} Gringer
	["{npc:4631} stands on the pier where the boat docks. {npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs, {npc:2858} the flight master on the upper deck."] = "{npc:4631} steht auf dem Pier, an dem das Schiff anlegt. {npc:2495}s Laden ist im Gebäude östlich des Gasthauses; {npc:2498} ist im Erdgeschoss des Gasthauses, {npc:2496}, {npc:737} und {npc:773} oben, {npc:2858}, der Flugmeister, auf dem oberen Deck.",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the pier"] = "{npc:4631}, auf dem Pier",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, drinnen",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "{npc:2498}, drinnen, auf dem untersten Stockwerk",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}, oben",
	-- {npc:2496} Baron Revilgaz · {area:37} Lake Nazferiti
	["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496}: Cozzles Schließkiste steht am {area:37}, später in diesem Guide",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, oben",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, oben",

	-- Step 10: Grom'gol
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Leave {area:35} through the tunnel and follow the road north to {object:3202}, the orc camp on the west side of the vale. Stay on the road: the jungle beside it is above your level."] = "Verlass {area:35} durch den Tunnel und folge der Straße nach Norden nach {object:3202}, dem Orclager auf der Westseite des Tals. Bleib auf der Straße: Der Dschungel daneben liegt über deiner Stufe.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: für das Arathihochland, später auf der Route",

	-- Step 11: Nesingwary's camp
	["Nesingwary's camp"] = "Lager von Nesingwary",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:773} Krazek · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. {npc:773} wants it investigated: walk among its tents. From here on, keep every page of {quest:338} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "Folge der Straße von {object:3202} nach Norden; Nesingwarys Jagdlager liegt auf dem Hügel nordöstlich des Flusses. {npc:773} will, dass es untersucht wird: Geh zwischen den Zelten umher. Ab hier behältst du jede Seite von {quest:338}, die du erbeutest: {npc:716} nimmt sie bei deinem nächsten Besuch im Schlingendorntal.",

	-- Step 12: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}: Töte diese, wenn sie dir begegnen",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Flusskrokilisken liegen am Fluss unterhalb des Lagers. Junge Schlingendorntiger streifen westlich des Lagers umher, junge Panther östlich davon. Geh westlich am Lager vorbei. Schlingendornraptoren (33-34) jagen auf den Lichtungen, und die Trolle der Blutskalpe halten die Ruinen an der Küste: Jeder Blutskalp kann einen Hauer droppen. Ein {item:4614} ist ein sehr seltener Drop von ihnen: Falls einer droppt, lies ihn. Vorsicht: In den Trolllagern patrouillieren viele Mobs, daher greifen oft weitere Trolle in einen Kampf ein.",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: Töte diese, sobald sie dir begegnen",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp."] = "Schlingendorn-Tiger (32) streifen durch die Hügel um das Lager und südlich davon, Panther (32) durch die Lichtungen westlich und südwestlich davon. Die Geologen der Venture Co., die die Gesprungenen Kristalle tragen, arbeiten in den Lagern bei {area:37}, südöstlich des Lagers.",

	-- Step 15: Cozzle's Footlocker
	-- {npc:4723} Foreman Cozzle · {area:37} Lake Nazferiti · {object:20691} Cozzle's Footlocker · {npc:2496} Baron Revilgaz
	["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}."] = "{npc:4723} (38) ist im Haus der Venture Co. am Westufer des {area:37}, zwischen den Geologen: Sein Schlüssel öffnet {object:20691} im selben Haus, in der die Baupläne für {npc:2496} liegen.",
	-- {npc:4723} Foreman Cozzle
	["from {npc:4723}"] = "von {npc:4723}",
	-- {item:5852} Fuel Regulator Blueprints · {object:20691} Cozzle's Footlocker
	["{item:5852}, in {object:20691}"] = "{item:5852}, in {object:20691}",

	-- Step 16: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Die Schattentatzenpanther kommen viel später, bei {object:3202}",

	-- Step 17: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "Ältere Schlingendorn-Tiger",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "Die Älteren Schlingendorn-Tiger (34-35) streifen durch die Hügel südwestlich des Lagers. Vorsicht: Trolllager sind nah am Tigergebiet, und Trolle können in einen Kampf eingreifen, wenn du unvorsichtig ziehst.",

	-- Step 18: Nesingwary's camp
	["Back north to the camp."] = "Zurück nach Norden zum Lager.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}: Töte diese, sobald sie dir begegnen",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Westlich am Lager vorbei sitzen Crystal Spine-Basilisken (34-35) auf den Felsen; jeder Bloodscalp im Dorf dahinter kann ein Ohr fallen lassen.\n{npc:729}, ein Tiger der Stufe 37, streift über den Hügelkamm südwestlich des Lagers.\nVorsicht: Das Raptornest hat junge Raptoren, die in den Kampf eingreifen, wenn du die ausgewachsenen angreifst.",

	-- Step 21: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Lashtail-Raptoren",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}."] = "Auf deinem Rückweg nach Süden zu {object:3202} jagen die Lashtail-Raptoren (35-36) im Dschungel zwischen dem Lager und {object:3202}: Sie zählen für Hemet und für {npc:2464}.",

	-- Step 22: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464} steht mitten in {object:3202}, {npc:2497} beim Zeppelinturm, {npc:2465} neben dem Flugmeister.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "{npc:2465}: Die Klauen der Shadowmaw und der Fang der Tigerin kommen am Ende dieses Guides",

	-- Step 23: Level 35
	["Level 35"] = "Stufe 35",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words) · {area:796} Scarlet Monastery
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{area:35}'s and {object:3202}'s next quests are 35-38. Still below 35 after Aggro'gosh's hand-in? The Lashtail Raptors (35) hunt the jungle just north of {object:3202}: kill them until level 35. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "Die nächsten Quests von {area:35} und {object:3202} sind 35-38. Nach der Abgabe bei Aggro'gosh noch unter 35? Die Lashtail-Raptoren (35) jagen im Dschungel direkt nördlich von {object:3202}: Töte sie, bis du Stufe 35 bist. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Bibliothek oder Waffenkammer).",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "grinde an {npc:686}",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Flugmeister von {object:3202}",

	-- Step 25: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "{npc:2495}s Laden ist im Gebäude östlich des Gasthauses; {npc:2498} ist im Erdgeschoss des Gasthauses, {npc:2496}, {npc:737} und {npc:773} oben neben dem Flugmeister.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, drinnen",
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496}: für Pozzik an der {area:2240}, auf dem Weg nach {zone:1446} um Stufe 43",

	-- Step 26: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Flugmeister von {area:35}",

	-- Step 27: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Nordwestlich von Grom'gol liegt {area:104} unter Wasser vor der Küste. Die {item:4094} liegt auf dem Meeresgrund bei den versunkenen Ruinen; achte auf deinen Atem und die Murlocs.",
	["Underwater"] = "Unter Wasser",

	-- Step 28: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}: Töte diese, wenn sie dir begegnen",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Die Bloodscalp-Kopfjäger (36-37) im Dorf an der Küste tragen die geschrumpften Köpfe.\nDie Bloodscalp-Trolle halten die Ruinen die Küste hinauf nördlich des Riffs und das Dorf dahinter; jeder kann eine {item:3915} fallen lassen. Plündere weiter Seiten von {quest:338}.",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "Östlich der Mosh'Ogg-Hügel pirschen Shadowmaw-Panther (37-38) durch den Dschungel Richtung See; die Schlingendorn-Tigerinnen streifen über dasselbe Gelände und lassen hin und wieder einen makellosen Fang fallen. Snapjaw-Krokilisken säumen den Fluss direkt westlich des Dschungels; behalte ihre Häute für {npc:2495}. Vorsicht: Shadowmaw-Panther (Stufe 37-38) und Ältere Shadowmaw-Panther (Stufe 42-43) benutzen Schleichen außerhalb des Kampfes, sodass sie verborgen bleiben, bis du nah herankommst.",

	-- Step 31: Green Hills pages
	["Green Hills pages"] = "Seiten der Grünen Hügel",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters on your next Stranglethorn visit, at about 40."] = "Seiten von {item:2755} fallen mit etwa 1% je von den Bloodscalp- und Skullsplitter-Trollen; behalte jede Seite, die du plünderst, und such im Auktionshaus nach dem Rest. {npc:716} nimmt die Kapitel bei deinem nächsten Besuch im Schlingendorntal an, bei etwa 40.",

	-- Step 32: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Lager der Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "Die Mosh'Ogg-Oger lagern in den Hügeln direkt östlich von {object:3202}, auf deinem Rückweg. Töte 10 Rohlinge und 5 Hexendoktoren (36-37); zieh sie einzeln.",

	-- Step 33: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "Zurück nach {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2465}: für forever/horde/40-50/01-stranglethorn-vale",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2497}: für forever/horde/40-50/01-stranglethorn-vale",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "Der nächste Guide nimmt den Zeppelin nach {zone:1454} vom Turm auf der Westseite des Lagers.",

	-- Step 34: Level 36
	["Level 36"] = "Stufe 36",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Mosh'Ogg Brutes and Witch Doctors camp in the hills just east of the camp: kill them until level 36, pulling one at a time, then walk back to the zeppelin tower. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "Die Quests von Dustwallow sind 35-38. Nach den Abgaben bei {object:3202} noch unter 36? Die Mosh'Ogg-Rohlinge und Hexendoktoren lagern in den Hügeln direkt östlich des Lagers: Töte sie, bis du Stufe 36 bist, und zieh dabei einen nach dem anderen; geh dann zurück zum Zeppelinturm. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Waffenkammer) oder den Dungeon {area:1316}.",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "grinde an {npc:1142}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Elder tigers and Lashtail raptors"] = "Alte Tiger und Schmetterschwänze",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Folge der Straße von {object:3202} nach Norden; Nesingwarys Jagdlager liegt auf dem Hügel nordöstlich des Flusses. Ab hier behältst du jede Seite von {quest:338}, die du erbeutest: {npc:716} Stonepot will sie später.",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Folge der Straße nach Süden nach {area:35} an der Südspitze des Tals und geh durch den Tunnel in den Klippen hinein. Bleib auf der Straße: Der Dschungel daneben liegt weit über deiner Stufe. {npc:2858}, der Flugmeister der Horde, wartet auf dem oberen Deck.",
	-- ["Head south down the coast to {object:3202} and fly to {area:35}."] = "Geh die Küste nach Süden hinunter nach Grom'gol und flieg nach {area:35}.",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Seiten von {item:2755} droppen mit je etwa 1% von den Trollen der Bloodscalp und der Skullsplitter; behalte jede Seite, die du erbeutest, und schau im Auktionshaus nach dem Rest. {npc:716} Stonepot nimmt die Kapitel später in diesem Guide.",
	-- ["Shadowmaw panthers"] = "Schattentatzenpanther",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Die Schmetterschwänze (35-36) jagen im Dschungel gleich nordöstlich von {object:3202}.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Die Oger der Mosh'Ogg lagern in den Hügeln gleich östlich von {object:3202}. Töte einen Schläger der Mosh'Ogg und einen Hexendoktor der Mosh'Ogg (36-37); zieh sie einzeln.",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Die Schattentatzenpanther (37-38) schleichen durch den Dschungel östlich der Hügel der Mosh'Ogg und nordöstlich Richtung See; sie greifen aus der Verstohlenheit an. Erbeute unterwegs jede Seite der Grünen Hügel.",
	-- ["The camp by the river"] = "Das Lager am Fluss",
	-- ["The zeppelin lands at the tower on the west side of the camp."] = "Der Zeppelin landet am Turm auf der Westseite des Lagers.",
	-- ["Venture Co. camp"] = "Lager der Venture Co.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Das Lager der vermissten Jäger von {npc:773} ist das von Nesingwary: Geh zwischen den Zelten umher, dann ist die Untersuchung abgeschlossen. Flusskrokilisken liegen am Fluss unterhalb des Lagers.",
}
