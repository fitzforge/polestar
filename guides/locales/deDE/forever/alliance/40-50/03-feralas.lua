-- German (deDE): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:1121} Isle of Dread
	["Feathermoon's isle, ogres, yetis and the {area:1121}."] = "Mondfederinsel, Oger, Yetis und die {area:1121}.",
	["Two new flight paths for later"] = "Zwei neue Flugrouten für später",
	-- {zone:1446} Tanaris
	["Then on to {zone:1446}"] = "Dann weiter nach {zone:1446}",
	["Stays on the main route"] = "Bleibt auf der Hauptroute",
	["Boats to and from the island"] = "Boote zur Insel und zurück",

	-- Step 1: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "Hinein nach {zone:1413}",

	-- Step 2: Thalanaar flight master
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "Flugmeister von {area:489}",

	-- Step 3: Boat to Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold
	["Boat to {area:1116}"] = "Boot nach {area:1116}",

	-- Step 4: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast · {npc:7880} Ginro Hearthkindle
	["{area:1116} stands on {area:1120}, off the {area:1108}: the boat from the coast's dock crosses to it. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{area:1116} liegt auf {area:1120}, vor der {area:1108}: Das Boot vom Steg der Küste setzt dorthin über. {npc:7880} steht im Obergeschoss seines Gebäudes: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
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
	["Boat to {area:1108}"] = "Boot nach {area:1108}",

	-- Step 10: Feralas
	["The courier's boat"] = "Das Boot des Kuriers",

	-- Step 11: The courier's boat
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "Nimm das Boot zum Gebiet {area:1108} und folge dem Ufer nach Süden zum zerstörten Ruderboot am Strand.",

	-- Step 12: Gordunni ogres
	["Gordunni ogres"] = "Oger der Gordunni",
	-- {npc:5236} Gordunni Shaman
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north.\nCareful: the {npc:5236} are 44-45 and the Warlocks 43-44, casters a level or two over you here: pull them one at a time from the camp's edge, and take the Brutes (42-43) on the slopes first."] = "Reite nach Osten zum Lager der Gordunni in den Hügeln südöstlich des Yetitals: Hexenmeister und Schamanen halten das Lager, Schläger streifen über die Hänge drumherum und weiter nördlich.\nVorsicht: Die {npc:5236} sind Stufe 44-45 und die Hexenmeister 43-44, Zauberwirker also ein oder zwei Stufen über dir: Zieh sie einzeln vom Rand des Lagers und nimm dir zuerst die Schläger (42-43) an den Hängen vor.",

	-- Step 13: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "Reite nach Norden ins Yetital. Jeder Wildschrammyeti kann einen dicken Yetibalg droppen; {npc:5346} (Stufe 48) streift durch die Mitte.",

	-- Step 14: Ironfur bears
	["Ironfur bears"] = "Eisenfellbären",
	-- {area:1105} Feral Scar Vale · {area:1136} High Wilderness
	-- plural, as words: Ironfur Bears = {npc:5268} Ironfur Bear · Ironfur Patriarchs = {npc:5274} Ironfur Patriarch
	-- was: ["Ride north out of {area:1105}: the Ironfur Bears (41-42) at the foot of the {area:1136} drop Rhapsody's last liver.\nCareful: Ironfur Patriarchs (48-49) and the Rage Scar yetis (46-49) roam the hills further north: stay at their edge."] = "Reite nach Norden aus dem {area:1105}: Die Eisenfellbären (41-42) am Fuß der {area:1136} droppen Rhapsodys letzte Leber.\nVorsicht: Eisenfellpatriarchen (48-49) und die Yetis von Rage Scar (46-49) streifen weiter nördlich durch die Hügel: Bleib an ihrem Rand."
	["Ride north out of {area:1105}: the Ironfur Bears (41-42) at the foot of the {area:1136} drop Rhapsody's Ironfur livers.\nCareful: Ironfur Patriarchs (48-49) and the Rage Scar yetis (46-49) roam the hills further north: stay at their edge."] = "",

	-- Step 15: Isle of Dread
	-- {area:1121} Isle of Dread · {area:1120} Sardor Isle · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["The {area:1121} is the island just south of {area:1120}: swim over. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "Die {area:1121} ist die Insel direkt südlich von {area:1120}: Schwimm hinüber. Hatecrest Serpent Guards und Sorceresses halten sie; {npc:8136} (Stufe 47) wartet in der Höhle an ihrem Südende. Zieh zuerst seine Wachen.",
	-- {item:9248} Mysterious Relic
	["{item:9248}; below ground"] = "{item:9248}; unter der Erde",

	-- Step 16: Feathermoon Stronghold
	-- {npc:7877} Latronicus Moonspear · {npc:7878} Vestia Moonspear · {npc:7900} Angelas Moonbreeze · {npc:7880} Ginro Hearthkindle · {npc:7852} Pratt McGrubben
	["Coming from the south: {npc:7877} and {npc:7878} first, then {npc:7900} beside {npc:7880}'s building, then the stairs. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:7852} is by the flight master, on the way out."] = "Von Süden kommend: zuerst {npc:7877} und {npc:7878}, dann {npc:7900} neben dem Gebäude von {npc:7880}, dann die Treppe. {npc:7880} steht im Obergeschoss seines Gebäudes: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden. {npc:7852} ist beim Flugmeister, auf dem Weg hinaus.",
	-- {npc:7879} Quintis Jonespyre
	["{npc:7879}, upstairs"] = "{npc:7879}, oben",
	-- {npc:7852} Pratt McGrubben
	["{npc:7852}'s next order, Improved Quality, wants Rage Scar hides from yetis of 46-49: skip it."] = "Der nächste Auftrag von {npc:7852}, Verbesserte Qualität, verlangt Häute von Narbenwut-Yetis der Stufe 46-49: Überspring ihn.",

	-- Step 17: Fly to Thalanaar
	-- {area:489} Thalanaar
	["Fly to {area:489}"] = "Flieg nach {area:489}",
	["Feathermoon flight master"] = "Flugmeister von Feathermoon",

	-- Step 18: Back to the coast
	["Back to the coast"] = "Zurück zur Küste",
	-- {zone:1444} Feralas · {zone:2652} Shen'dralas · {area:489} Thalanaar
	["You came into {zone:1444} from {zone:2652}, so {area:489}'s flight path is still to learn: take the boat back to the coast and ride east along the road; you pick up the flight path when this guide ends at {area:489}."] = "Du bist aus {zone:2652} nach {zone:1444} gekommen, daher fehlt dir noch die Flugroute von {area:489}: Nimm das Boot zurück zur Küste und reite nach Osten die Straße entlang; die Flugroute holst du dir, wenn dieser Guide in {area:489} endet.",

	-- Step 19: Feralas
	["Grimtotem camp"] = "Lager der Grimmtotem",

	-- Step 20: Grimtotem camp
	-- {area:489} Thalanaar · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["From {area:489} ride west along the road to the Grimtotem camp north of it. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "Reite von {area:489} nach Westen entlang der Straße zum Lager der Grimtotem nördlich davon. {npc:7956} wartet davor; befreie die Sprite Darters aus dem Pferch in der Mitte und halte {npc:7956} und mindestens sechs von ihnen am Leben.",

	-- Step 21: Grimtotem tauren
	["Grimtotem tauren"] = "Tauren der Grimmtotem",
	-- {npc:222286} Namida Grimtotem
	["Careful: {npc:222286}, an elite of level 43, stands at the camp's north-east edge, around 67,39: pull the Naturalists, Raiders and Shamans away from her."] = "Vorsicht: {npc:222286}, ein Elite der Stufe 43, steht am Nordostrand des Lagers, bei etwa 67,39: Zieh die Naturalists, Raiders und Shamans von ihr weg.",

	-- Step 22: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "für Tyrande in {zone:1457}: Die Route führt dich mit 47 dorthin",

	-- Step 23: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "Reite nach Südosten zu den Gnollen der Waldpfoten; die Rucksäcke des Kuriers liegen in ihrem südlichen Lager, und ein Paket darin startet eine Lieferung nach {area:489}. Der Stock der Zukk'ash liegt gleich südlich: Kämpf dich hinunter zur Kapsel, in der Raschal steckt, befreie ihn und halte ihn auf dem Weg nach draußen am Leben.",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}, aus den Rucksäcken",
	-- {object:164954} Zukk'ash Pod
	["{object:164954}, inside"] = "{object:164954}, drinnen",

	-- Step 24: Grind to 45
	["Grind to 45"] = "Grinde bis 45",
	-- {area:1105} Feral Scar Vale · {area:978} Zul'Farrak
	["Ride west into {area:1105}: its yetis are 43-45. The Rage Scar yetis in the hills to the north are 46-49: leave them. Or, with a group, run the {area:978} dungeon instead."] = "Reite nach Westen in das {area:1105}: Seine Yetis sind 43-45. Die Yetis von Rage Scar in den Hügeln im Norden sind 46-49: Lass sie in Ruhe. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:978}.",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "grinde an {npc:5292} im {area:1105}, {zone:1444}",

	-- Step 25: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1108} Forgotten Coast · {area:1099} Camp Mojache · {npc:7880} Ginro Hearthkindle
	["Hearth back to {area:1116} if your stone is bound there and ready. Otherwise ride west to the {area:1108} dock, giving the Horde guards at {area:1099} a wide berth, and take the boat. {npc:7880} waits upstairs."] = "",

	-- Step 26: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "{npc:3936} bittet dich dann, Nachrichten nach {zone:1457} zu bringen: Überspring das, {area:976} schickt dich stattdessen dorthin.",

	-- Step 28: Ride to Thalanaar
	-- {area:489} Thalanaar
	["Ride to {area:489}"] = "Reite nach {area:489}",
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["No flight path to {area:489} yet: take the boat back to the coast and ride east along the road to {area:489}, on the {zone:1441} border."] = "Noch keine Flugroute nach {area:489}: Nimm das Boot zurück zur Küste und reite nach Osten die Straße entlang nach {area:489}, an der Grenze zu {zone:1441}.",

	-- Step 29: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "Reite nach Nordosten zum Außenposten der Nachtelfen an der Grenze zu {zone:1441}.",
	-- {npc:4048} Falfindel Waywarder · {area:489} Thalanaar
	["{npc:4048} walks around {area:489}: look inside the circle on the map"] = "{npc:4048} läuft um {area:489} herum: Schau in den Kreis auf der Karte",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "Nimm das Boot zum Gebiet {area:1108} und reite nach Osten durch {zone:1444} zum Lager der Grimmtotem nördlich der Straße. {npc:7956} wartet davor; befreie die Grimmlingflitzer aus dem Pferch in der Mitte und halte {npc:7956} und mindestens sechs von ihnen am Leben.",
	-- ["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "Nimm das Boot zum Gebiet {area:1108} und reite nach Osten ins {area:1105}. {npc:14637}s Quests an der Küste erfordern Stufe 45.",
	-- ["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "Flug ab Theramore: {area:608}. Reite dann südlich aus {zone:1443} hinaus nach {zone:1444}; die Straße führt nach Westen zum Steg im Gebiet {area:1108}, wo das Boot nach Feathermoon zur {area:1120} übersetzt.",
	-- ["Giants and elementals"] = "Riesen und Elementare",
	-- ["Hearth to Feathermoon."] = "Ruhestein nach Feathermoon.",
	-- ["No {quest:7735} yet? Keep killing the Rage Scar yetis until one drops, then right-click it."] = "Noch keinen {quest:7735}? Töte weiter die Rage Scar Yetis, bis einer ihn fallen lässt, und klick ihn dann rechts an.",
	-- ["Rage Scar yetis"] = "Wutschrammyetis",
	-- ["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "Reite zurück nach Nordwesten zum Steg im Gebiet {area:1108} und nimm das Boot zur Insel.",
	-- ["Ride back to the {area:1108}; the goblin stands by the dock."] = "Reite zurück zum Gebiet {area:1108}; der Goblin steht beim Steg.",
	-- ["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "Reite auf der Straße zurück nach Westen, dann nach Norden in die Hügel der Wutschrammyetis. Jeder Yeti hier kann einen Balg droppen; einer droppt vielleicht einen {quest:7735}, den {npc:7852} ebenfalls bezahlt.",
	-- ["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "Reite nach Osten zum Lager der Gordunni in den Hügeln südöstlich des Yetitals: Hexenmeister und Schamanen halten das Lager, Schläger streifen über die Hänge drumherum und weiter nördlich.",
	-- ["Ride north out of {area:1105} into the Rage Scar hills. Every yeti here can drop a hide, and about one in thirty a {quest:7735}, which {npc:7852} pays for too.\nCareful: the Rage Scar yetis are level 46-48, still one to three above you at 45: take them from the edge of the hills, one at a time."] = "Reite aus {area:1105} nach Norden in die Hügel von Rage Scar. Jeder Yeti hier kann ein Fell fallen lassen, und etwa jeder dreißigste einen {quest:7735}, den {npc:7852} ebenfalls bezahlt.\nVorsicht: Die Yetis von Rage Scar sind Stufe 46-48, mit 45 noch eine bis drei Stufen über dir: Nimm sie dir einzeln vom Rand der Hügel aus vor.",
	-- ["Ride north out of {area:1105}: the Ironfur Bears (41-42) at the foot of the {area:1136} drop Rhapsody's last liver.\nCareful: Ironfur Patriarchs (48-49) and the Rage Scar yetis (46-49) roam the hills further north: stay at their edge."] = "Reite nach Norden aus dem {area:1105}: Die Eisenfellbären (41-42) am Fuß der {area:1136} droppen Rhapsodys letzte Leber.\nVorsicht: Eisenfellpatriarchen (48-49) und die Yetis von Rage Scar (46-49) streifen weiter nördlich durch die Hügel: Bleib an ihrem Rand.",
	-- ["Ride west into {area:1105}: its yetis are 43-45. The Rage Scar yetis in the hills to the north are 46-48, so they wait until you are 45. Or, with a group, run the {area:978} dungeon instead."] = "Reite nach Westen in das {area:1105}: Seine Yetis sind 43-45. Die Yetis von Rage Scar in den Hügeln im Norden sind 46-48, also warten sie, bis du 45 bist. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:978}.",
	-- ["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "Reite nach Westen zum freundlichen Bergriesen am Fuß der Hügel. Die Landgänger und Klippenriesen um ihn herum sind Elite: Halte Abstand.",
	-- ["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "Läute die Glocke, wann immer {npc:7774} stehen bleibt und umherwandert, und führe sie nach Süden zu {npc:7765}.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "Mit einer Gruppe kommst du schneller ans Ziel, wenn du {area:978} läufst, statt zu grinden. Die Trollstadt liegt im Norden von {zone:1446}, dem nächsten Gebiet der Route; komm danach zurück zu {npc:14637} im Gebiet {area:1108}.",
	-- ["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "Uferschreiter, Tiefenschreiter und Wellenschreiter (Elite-Riesen) waten nördlich des Stegs an der Küste entlang: Triff einen mit dem {item:18904} und töte den geschrumpften Riesen. Meereselementare und Meeresschauer treiben in derselben Brandung.",
	-- ["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "Schwimm von der Insel nach Süden zum Gebiet {area:1121}. Schlangenwachen und Zauberhexerinnen der Hasskämme halten es; {npc:8136} (Stufe 47) wartet in der Höhle an seinem Südende. Zieh zuerst seine Wachen.",
	-- ["The {zone:1446} guide starts with the trip east, past {area:489}."] = "Der Guide für {zone:1446} beginnt mit der Reise nach Osten, an {area:489} vorbei.",
	-- ["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "Du endest am Steg im Gebiet {area:1108}: Der Guide für {zone:1446} beginnt mit der Reise von hier nach Osten.",
	-- ["grind on {npc:5292} at {area:1105}, {area:357}"] = "grinde an {npc:5292} im {area:1105}, {area:357}",
	-- ["grind on {npc:5296}"] = "Grinde an {npc:5296}",
	-- ["if you carry {quest:1100} from {zone:1441}"] = "falls du {quest:1100} aus {zone:1441} dabeihast",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: Töte diese, sobald sie dir begegnen",
	-- ["{area:1136}: kill these as you meet them"] = "{area:1136}: Töte diese, sobald sie dir begegnen",
	-- ["{area:978} instead of grinding"] = "{area:978} statt Grinden",
	-- ["{npc:14637}'s refills are level 55: skip them."] = "{npc:14637}s Folgequests sind Stufe 55: Überspring sie.",
	-- ["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774} wandert durch die Hügel nördlich von {npc:7765}, zwischen den Harpyien der Nordschwingen; ihre Glocke liegt in der Truhe neben ihr.",
	-- ["{npc:7774}'s escort"] = "{npc:7774}s Eskorte",
	-- ["{npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:7880} steht im Obergeschoss seines Gebäudes: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
}
