-- German (deDE): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "",

	-- Step 2: Thalanaar flight master
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 3: Boat to Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold
	["Boat to {area:1116}"] = "",

	-- Step 4: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast · {npc:7880} Ginro Hearthkindle
	["{area:1116} stands on {area:1120}, off the {area:1108}: the boat from the coast's dock crosses to it. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}, neben ihm",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}, oben in der Festung",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}: Seine Antwort wartet später in {area:702}",

	-- Step 5: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "Geh auf der Insel nach Süden zu den Ruinen der Naga; der Pavillon steht zwischen ihnen.",

	-- Step 7: Hatecrest naga
	["Hatecrest naga"] = "Naga der Hasskämme",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "Zurück zu den {area:1117}. Jeder Naga der Hasskämme dort kann Schuppen droppen.",

	-- Step 8: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136} wartet bis zum Ende der Runde auf dem Festland.",

	-- Step 9: Boat to Forgotten Coast
	-- {area:1108} Forgotten Coast
	["Boat to {area:1108}"] = "",

	-- Step 10: Feralas
	["The courier's boat"] = "Das Boot des Kuriers",

	-- Step 11: The courier's boat
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "Nimm das Boot zum Gebiet {area:1108} und folge dem Ufer nach Süden zum zerstörten Ruderboot am Strand.",

	-- Step 12: Gordunni ogres
	["Gordunni ogres"] = "Oger der Gordunni",
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "Reite nach Osten zum Lager der Gordunni in den Hügeln südöstlich des Yetitals: Hexenmeister und Schamanen halten das Lager, Schläger streifen über die Hänge drumherum und weiter nördlich.",

	-- Step 13: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "Reite nach Norden ins Yetital. Jeder Wildschrammyeti kann einen dicken Yetibalg droppen; {npc:5346} (Stufe 48) streift durch die Mitte.",

	-- Step 14: Isle of Dread
	-- {area:1121} Isle of Dread · {area:1120} Sardor Isle · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["The {area:1121} is the island just south of {area:1120}: swim over. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "",
	-- {item:9248} Mysterious Relic
	["{item:9248}; below ground"] = "",

	-- Step 15: Feathermoon Stronghold
	-- {npc:7877} Latronicus Moonspear · {npc:7878} Vestia Moonspear · {npc:7900} Angelas Moonbreeze · {npc:7880} Ginro Hearthkindle · {npc:7852} Pratt McGrubben
	["Coming from the south: {npc:7877} and {npc:7878} first, then {npc:7900} beside {npc:7880}'s building, then the stairs. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:7852} is by the flight master, on the way out."] = "",
	-- {npc:7879} Quintis Jonespyre
	["{npc:7879}, upstairs"] = "",

	-- Step 16: Fly to Thalanaar
	-- {area:489} Thalanaar
	["Fly to {area:489}"] = "",
	["Feathermoon flight master"] = "",

	-- Step 17: Feralas
	["Grimtotem camp"] = "Lager der Grimmtotem",

	-- Step 18: Grimtotem camp
	-- {area:489} Thalanaar · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["From {area:489} ride west along the road to the Grimtotem camp north of it. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "",

	-- Step 19: Grimtotem tauren
	["Grimtotem tauren"] = "Tauren der Grimmtotem",

	-- Step 20: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "für Tyrande in {zone:1457}: Die Route führt dich mit 47 dorthin",

	-- Step 21: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "Reite nach Südosten zu den Gnollen der Waldpfoten; die Rucksäcke des Kuriers liegen in ihrem südlichen Lager, und ein Paket darin startet eine Lieferung nach {area:489}. Der Stock der Zukk'ash liegt gleich südlich: Kämpf dich hinunter zur Kapsel, in der Raschal steckt, befreie ihn und halte ihn auf dem Weg nach draußen am Leben.",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}, aus den Rucksäcken",
	-- {object:164954} Zukk'ash Pod
	["{object:164954}, inside"] = "",

	-- Step 22: High Wilderness: kill these as you meet them
	-- {area:1136} High Wilderness
	["{area:1136}: kill these as you meet them"] = "",
	-- {quest:7735} Pristine Yeti Hide · {npc:7852} Pratt McGrubben · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak
	["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide, and about one in thirty a {quest:7735}, which {npc:7852} pays for too.\n{npc:14637}'s quests on the coast need level 45: grind the yetis here until level 44.5, so the kills also bring {npc:7852}'s hides. Or, with a group, run the {area:978} dungeon instead."] = "",
	-- {npc:5296} Rage Scar Yeti
	["grind on {npc:5296}"] = "",

	-- Step 23: Rage Scar Hold
	-- {quest:7735} Pristine Yeti Hide
	["No {quest:7735} yet? Keep killing the Rage Scar yetis until one drops, then right-click it."] = "",

	-- Step 24: Feathermoon Stronghold
	-- {npc:7880} Ginro Hearthkindle
	["{npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 25: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "{npc:3936} bittet dich dann, Nachrichten nach {zone:1457} zu bringen: Überspring das, {area:976} schickt dich stattdessen dorthin.",

	-- Step 27: Grind to 45
	["Grind to 45"] = "Grinde bis 45",
	-- {area:1105} Feral Scar Vale · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak · {area:1517} Uldaman
	["Ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "grinde an {npc:5292} im {area:1105}, {zone:1444}",

	-- Step 28: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast
	["Ride back to the {area:1108}; the goblin stands by the dock."] = "Reite zurück zum Gebiet {area:1108}; der Goblin steht beim Steg.",

	-- Step 29: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Shore Striders = {npc:5359} Shore Strider · Deep Striders = {npc:5360} Deep Strider · Wave Striders = {npc:5361} Wave Strider · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "Uferschreiter, Tiefenschreiter und Wellenschreiter (Elite-Riesen) waten nördlich des Stegs an der Küste entlang: Triff einen mit dem {item:18904} und töte den geschrumpften Riesen. Meereselementare und Meeresschauer treiben in derselben Brandung.",

	-- Step 30: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["{npc:14637}'s refills are level 55: skip them."] = "{npc:14637}s Folgequests sind Stufe 55: Überspring sie.",
	-- {zone:1446} Tanaris · {area:489} Thalanaar
	["The {zone:1446} guide starts with the trip east, past {area:489}."] = "",

	-- Step 31: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "Reite nach Nordosten zum Außenposten der Nachtelfen an der Grenze zu {zone:1441}.",
	-- {npc:4048} Falfindel Waywarder · {area:489} Thalanaar
	["{npc:4048} walks around {area:489}: look inside the circle on the map"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "Nimm das Boot zum Gebiet {area:1108} und reite nach Osten durch {zone:1444} zum Lager der Grimmtotem nördlich der Straße. {npc:7956} wartet davor; befreie die Grimmlingflitzer aus dem Pferch in der Mitte und halte {npc:7956} und mindestens sechs von ihnen am Leben.",
	-- ["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "Nimm das Boot zum Gebiet {area:1108} und reite nach Osten ins {area:1105}. {npc:14637}s Quests an der Küste erfordern Stufe 45.",
	-- ["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "Flug ab Theramore: {area:608}. Reite dann südlich aus {zone:1443} hinaus nach {zone:1444}; die Straße führt nach Westen zum Steg im Gebiet {area:1108}, wo das Boot nach Feathermoon zur {area:1120} übersetzt.",
	-- ["Giants and elementals"] = "Riesen und Elementare",
	-- ["Hearth to Feathermoon."] = "Ruhestein nach Feathermoon.",
	-- ["Rage Scar yetis"] = "Wutschrammyetis",
	-- ["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "Reite zurück nach Nordwesten zum Steg im Gebiet {area:1108} und nimm das Boot zur Insel.",
	-- ["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "Reite auf der Straße zurück nach Westen, dann nach Norden in die Hügel der Wutschrammyetis. Jeder Yeti hier kann einen Balg droppen; einer droppt vielleicht einen {quest:7735}, den {npc:7852} ebenfalls bezahlt.",
	-- ["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "Reite nach Westen zum freundlichen Bergriesen am Fuß der Hügel. Die Landgänger und Klippenriesen um ihn herum sind Elite: Halte Abstand.",
	-- ["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "Läute die Glocke, wann immer {npc:7774} stehen bleibt und umherwandert, und führe sie nach Süden zu {npc:7765}.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "Mit einer Gruppe kommst du schneller ans Ziel, wenn du {area:978} läufst, statt zu grinden. Die Trollstadt liegt im Norden von {zone:1446}, dem nächsten Gebiet der Route; komm danach zurück zu {npc:14637} im Gebiet {area:1108}.",
	-- ["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "Schwimm von der Insel nach Süden zum Gebiet {area:1121}. Schlangenwachen und Zauberhexerinnen der Hasskämme halten es; {npc:8136} (Stufe 47) wartet in der Höhle an seinem Südende. Zieh zuerst seine Wachen.",
	-- ["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "Du endest am Steg im Gebiet {area:1108}: Der Guide für {zone:1446} beginnt mit der Reise von hier nach Osten.",
	-- ["grind on {npc:5292} at {area:1105}, {area:357}"] = "grinde an {npc:5292} im {area:1105}, {area:357}",
	-- ["if you carry {quest:1100} from {zone:1441}"] = "falls du {quest:1100} aus {zone:1441} dabeihast",
	-- ["{area:978} instead of grinding"] = "{area:978} statt Grinden",
	-- ["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774} wandert durch die Hügel nördlich von {npc:7765}, zwischen den Harpyien der Nordschwingen; ihre Glocke liegt in der Truhe neben ihr.",
	-- ["{npc:7774}'s escort"] = "{npc:7774}s Eskorte",
}
