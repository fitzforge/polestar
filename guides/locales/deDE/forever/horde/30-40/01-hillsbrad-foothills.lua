-- German (deDE): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "Für Charaktere der Stufen 29 bis 31: {quest:527}, die Aufträge in {area:272} und die Gnolle des Vorgebirges, alle auf oder unter deiner Stufe.",

	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "Flugmeister von {area:484}",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "Flieg von {area:484} nach {area:1638} und lerne bei {npc:3033} auf {area:1639}; flieg von dort weiter zum Wegekreuz.",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "Flieg von {area:484} nach {area:392}. {npc:5901} lagert an der Küste einen kurzen Fußweg südlich der Stadt; flieg von {area:392} weiter zum Wegekreuz.",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "{npc:5901}: dein {item:6637}, für das Kohlebecken",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "Flieg zum Wegekreuz",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Flugmeister in {area:392}",

	-- Step 7: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows · {zone:1454} Orgrimmar
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428} steht neben dem Flugmeister am Wegekreuz. {quest:1145} ist ab Stufe 29 verfügbar; darunter nimmst du sie beim Halt in {zone:1454} im nächsten Guide an.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428}: für {npc:4485} in {zone:1454}",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	["Crossroads flight master"] = "Flugmeister des Wegekreuzes",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:4949} wartet in der Burg Grommash, im {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Grommash Hold, falls du sie dabeihast",

	-- Step 10: Train
	["Train"] = "Trainieren",
	["Train your new spells."] = "Lerne deine neuen Zauber.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "{npc:4485} steht im {object:172958}, auf dem Weg hinaus zum Haupttor.",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "für {npc:4483} in den {area:439}, nächster Guide",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",

	-- Step 13: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "{npc:260093} bildet Paladine in der {zone:1458} aus.",

	-- Step 14: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Flugmeister der {zone:1458}",

	-- Step 15: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Flieg nach {area:228}. Das {object:113791} steht auf dem Hügel direkt südwestlich davon: Besiege die Verderbte Manifestation des Wassers daneben, lege ihre Armschienen ins Kohlebecken, sprich mit der {npc:5895} und behalte den {item:7813} für {npc:5901}. Flieg von {area:228} weiter nach {area:272}.",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "{item:6637}: Trink es am Menhir, um das Elementar zu sehen",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "für {npc:5901}, nächster Guide",

	-- Step 16: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "Flugmeister von {area:228}",

	-- Step 18: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "Der Steckbrief {quest:567} hängt beim Gasthaus; {npc:2216} steht darin. {npc:2393}, der Koch beim Gasthaus, will Schildkrötenfleisch und verkauft die Gewürze dafür.",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "{quest:567}, der Steckbrief beim Gasthaus",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, drinnen",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393}: {quest:7321}, die Schnappkiefer am Fluss südlich des Orts",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{item:3713}, von {npc:2393}",

	-- Step 19: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "Du hast Darthalias erste Aufträge aus dem Guide {area:287} 22-25 verpasst: Sie kommen jetzt zuerst. Sie liegen ein paar Stufen unter dir, gehen schnell und öffnen den Rest von {quest:527} in diesem Guide.",

	-- Step 20: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229} will, dass du seine zwei Späher aus {area:275} befreist.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, drinnen",

	-- Step 21: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "Nach Westen an den Hügeln vorbei zu den Höfen östlich des Orts {area:287}. {npc:232} bestellt das Feld beim nördlichen Bauernhaus, {npc:2403} das weiter südöstlich; Landarbeiter und Bauern sind überall.\nVorsicht: Wachen der Kirin Tor (55) patrouillieren auf den Feldern und Straßen von {area:287} und greifen die Horde an: Halte nach ihnen Ausschau und geh ihnen aus dem Weg.",

	-- Step 22: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "Zurück nach Osten nach {area:272}.",

	-- Step 23: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "Arbeiter von Hillsbrad",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "Zurück zu den Feldern: Die Arbeiter von Hillsbrad schuften südlich der Bauernhäuser. Vorsicht: Ein fliehender Arbeiter, der das Rathaus erreicht, kann Verstärkung mitbringen; Verlangsamungen oder Wurzeln halten sie von der Flucht ab.",

	-- Step 26: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "Südöstlich von Tarrens Mühle. Drull und {npc:2238} sind in den Gebäuden im Hof der Burg angekettet: {npc:2427} trägt {item:3467} und {npc:2428} {item:3499}, beide in der Burg. Töte sie und öffne dann beide Schlösser.",
	["Drull's ball and chain"] = "Drulls Kugel und Kette",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Kugel und Kette von {npc:2238}",

	-- Step 27: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "Zurück nach {area:272}.",

	-- Step 28: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "Der Fluss südlich von {area:272}: Töte diese, wenn sie dir begegnen",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "Von {area:272} nach Süden den Fluss entlang: Schnappkiefer (29) sonnen sich an seinen Ufern bis hinunter zu den Hügeln oberhalb von {area:271}. Manche haben {item:3712} dabei.",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "{item:3712}, von den Schnappkiefern",

	-- Step 29: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "Südlich der Flussbiegung lagern die Gnolle der Schlammschnauzen (26-28) in den Hügeln oberhalb von {area:290}; die Blüten wachsen zwischen ihren Zelten. Die Schamanen heilen und rufen Verstärkung: Zieh sie zuerst.",

	-- Step 30: North of Southshore
	["North of Southshore"] = "Nördlich von Süderstade",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "Von den Blüten zurück nach Norden den Fluss entlang und dann nach Westen zum Ort {area:287}, ein gutes Stück nördlich von {area:271} (die Wachen dort sind 55).",

	-- Step 31: The smithy
	["The smithy"] = "Die Schmiede",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	-- was: ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "Nach Westen über die Ausläufer zum Ort {area:287}: Die Schmiede steht in seiner Mitte. {npc:2404} und seine Lehrlinge arbeiten an der Esse; die {object:1736} ist daneben gestapelt. {npc:2449} läuft bei der Schmiede umher; {npc:2451} bestellt das Feld südöstlich des Orts."
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the west side of the town; {npc:2451} works the field south-east of the town."] = "",
	["Inside"] = "Drinnen",
	-- {npc:2449} Citizen Wilkes
	["{npc:2449}, on the west side of the town"] = "",

	-- Step 32: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "für {npc:2055}, beim Halt in {zone:1458} am Ende dieses Guides",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "{npc:2429} im Ort: {item:3708}, von den Yetis auf dem Weg zum Rathaus",

	-- Step 33: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "Westlich von Tarrens Mühle füllen die Höhlenyetis und Wilden Yetis (30-32) {area:277} in den Hügeln; etwa jeder sechzehnte trägt die Rute. Bleib in diesen Höhlen: Die Berg- und Riesenyetis (32-34) der Höhle weiter nördlich tragen sie auch, aber sie schlagen hart zu und kommen zu zweit.",

	-- Step 34: Town hall
	["Town hall"] = "Rathaus",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Weiter zur Stadt {area:287}, südwestlich der Yetihöhlen. Das Rathaus liegt auf der Westseite der Stadt: {npc:2335} (30) und {npc:2448} sind mit dem Stadtregister drinnen; die Proklamation hängt daneben. Stadträte laufen durch die Stadt.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, drinnen",

	-- Step 35: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "Thaivands nächster Auftrag, die Flammen, schickt dich zu den Berg- und Riesenyetis (32-34) und zu Helculars Grab mitten in {area:271}: Lass ihn aus.",

	-- Step 36: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "Für deinen Run durch die City of Dalaran, später in diesem Guide: {npc:2278} steht in {area:272}, ein kurzes Stück östlich von {npc:2410}.",

	-- Step 37: City of Dalaran
	["City of Dalaran"] = "City of Dalaran",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "Die City of Dalaran ist ein Dungeon für eine Gruppe aus fünf Spielern, etwa Stufe 28 bis 33, unter der violetten Kuppel. Ohne {item:277507} gehst du durch das Abwasserrohr nordwestlich des Kraters hinein: Der Pfeil führt dorthin.\nDrinnen: {npc:247126} ist für {npc:2278}. {npc:268743} in der Kanalisation gibt Opportunistic Education und nimmt die Quest dort auch wieder entgegen.",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}: {npc:247126}, drinnen",

	-- Step 39: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Geh südwestlich am Ort {area:287} vorbei zur {area:288}. Minenarbeiter arbeiten in den Tunneln; {npc:2305} (30) und {npc:2450} (29) sind tief im Inneren.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "In der {area:288}",

	-- Step 40: Level 30
	["Level 30"] = "Stufe 30",
	-- {npc:2410} Magus Wordeen Voidglare · {area:272} Tarren Mill · {zone:1454} Orgrimmar · {area:288} Azurelode Mine · {zone:1437} Wetlands
	-- plural, as words: Torn Fin Muckdwellers = {npc:2374} Torn Fin Muckdweller
	["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "Die Quests von {npc:2410} beim nächsten Halt in {area:272} und Alliance Relations in {zone:1454}, dem ersten Halt des nächsten Guides, gibt es ab Stufe 30. Noch nicht 30? Die Matschkrabbler und Küstenläufer der Fetzenflossen (28-30) drängen sich an der Küste südlich der {area:288}, ein kurzer Fußweg: Töte sie bis Stufe 30. Ihre Orakel (30-31) zaubern weiter östlich vom Ufer aus. Oder lauf mit einer Gruppe stattdessen den Dungeon Excavation Site (im {zone:1437}).",
	["Torn Fin murlocs"] = "Murlocs der Fetzenflossen",
	-- {npc:2375} Torn Fin Coastrunner
	["grind on {npc:2375}"] = "grinde an {npc:2375}",

	-- Step 41: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "{item:3712} fertig sammeln",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "Noch keine zehn {item:3712}? Die Schnappkiefer säumen den Fluss östlich von {area:272}, auf deinem Rückweg von der Mine.",

	-- Step 42: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "Nach Nordosten zurück nach {area:272}, mit großem Abstand nördlich an {area:271} vorbei (die Wachen dort sind 55).",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}: Ihr nächster Teil von {quest:539} und das Schwert von {npc:2419} sind Elite-Gruppenquests bei {area:290}: Nimm sie nur mit einer Gruppe an",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "{npc:2229} drinnen: Infiltration, erledigt beim Besuch mit 38-39 (das Syndikat dort ist 32-35)",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "Behalte Infiltration im Questlog: Das Syndikat (32-35) liegt jetzt über dir, und der Guide 38-39 (Alterac und Arathi) erledigt sie auf seiner ersten Runde in {area:272}.",

	-- Step 43: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "Voidglare, Bel'varil und {npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410} und {npc:2437} sind im Gasthaus, {npc:2770} gleich davor. Ihre Quests gibt es ab Stufe 30; darunter nimmt sie der erste Halt in {area:272} im Guide 38-39 an.",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "{npc:2410} drinnen: {quest:544}, für den Besuch mit 38-39 (die Verräter im Krater von {area:279} sind 33-35)",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410}: {quest:93680}, zusammen mit {quest:544} beim Besuch mit 38-39",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "{npc:2437} drinnen: {quest:556}, zusammen mit dem Krater beim Besuch mit 38-39",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "{npc:2770} vor dem Gasthaus: die Oger der Felsfäuste (32-34) beim Besuch im Arathihochland mit 38-39",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "Behalte diese im Questlog: Ihre Lager liegen jetzt zwei bis vier Stufen über dir, und der Guide 38-39 erledigt sie auf seiner ersten Runde in {area:272} und in {area:321}.",

	-- Step 44: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "{quest:96986} aus deinem Run durch die City of Dalaran: {npc:2278}, ein kurzes Stück östlich von {npc:2410}.",

	-- Step 45: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "{quest:539} mit einer Gruppe",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "Darthalias letzte Schlacht findet bei {area:290} statt, der Zwergenfestung südöstlich von {area:271}: Jeder Zwerg dort ist Elite (28-32), {npc:2304} auch. Tolle EP, wenn du eine Gruppe dafür hast.",

	-- Step 46: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "{quest:547} mit einer Gruppe",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "Das Schwert von {npc:2419} fällt von denselben Zwergen von {area:290} (etwa eines von zwölf).",

	-- Step 47: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "Räume {area:290} vom Tor an aus; die Zwerge rennen bei 30% Gesundheit los, um Hilfe zu holen.",

	-- Step 48: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "für {npc:2425} in der {zone:1458}, am Ende dieses Guides",

	-- Step 50: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Flieg zur {area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Flugmeister von {area:272}",

	-- Step 51: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055} steht im Apothekarium, im {object:36126}.",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "Faranells nächste Quest {quest:513} braucht ein {item:3388} ({skill:171}) und die Küste von {area:287}: Lass sie aus.",

	-- Step 52: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "{npc:2425} steht neben Sylvanas im {object:36126}.",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "{npc:2425}: Darthalias Belobigung",

	-- Step 53: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038} steht im Apothekarium. Seine Quest {quest:97985} gilt Stormheart, einem Elite der Stufe 30, der durch die Schlucht östlich vom {area:484} läuft, auf dem Weg zur {area:439} im nächsten Guide.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}: zurück zu ihm beim nächsten Halt in {zone:1458}, bei etwa Stufe 38",

	-- Step 54: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Lehrer in {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Trainiere, solange du in {zone:1458} bist: Die Lehrer stehen im {object:36070}, im {object:36073} und im {object:36082} (Paladine: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "Zurück in die Yetihöhlen westlich von {area:272} mit dem {item:3710}. Der Pfad teilt sich direkt hinter dem Eingang: Die {object:1768} brennt auf der oberen Ebene rechts, die {object:1769} auf der unteren Ebene links, an weiteren Yetis vorbei.",
	-- ["Back north to {area:321}."] = "Zurück nach Norden nach {area:321}.",
	-- ["Back to {area:272}"] = "Zurück nach {area:272}",
	-- ["Below ground"] = "Unter der Erde",
	-- ["Boulderfist camp"] = "Lager der Felsfäuste",
	-- ["Daggerspine naga"] = "Naga der Säbelflossen",
	-- ["Daggerspine shore"] = "Ufer der Säbelflossen",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Folge der Straße nach Norden aus {area:272} hinaus in die Ausläufer des Alteracgebirges. {quest:535} wartet beim Lager des Syndikats; gib ihm das Starkbier.",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "Für Charaktere der Stufe 29 bis 33, aber die meisten Quests hier sind Stufe 32-34, einige bis 36: mit Absicht, wegen ihrer Erfahrung. Das Syndikat, die Wachen von {area:279} und die Oger der Felsfäuste sind 31-35, also zieh sie einzeln.",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Geh von {area:271} nach Norden an {area:272} vorbei und folge der Straße weiter in die Ausläufer von Alterac. {quest:535} wartet beim Lager des Syndikats. Er bietet seinen Auftrag nur an, solange du „Unterwanderung“ von {npc:2229} dabeihast: Gib ihm gleich das Starkbier, und seine Belohnung ist das Schreiben des Syndikats, das Krusk will. Ein Schreiben des Syndikats von hier tut es auch: Hast du eins in deinen Taschen, überspringt der Guide {quest:535}.",
	-- ["Head back north to {area:272}."] = "Geh zurück nach Norden nach {area:272}.",
	-- ["Head back south down the road to {area:272}."] = "Geh die Straße zurück nach Süden bis {area:272}.",
	-- ["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Verlasse {area:272} nach Osten durch {area:1057} und folge der Straße nach Osten. Die Boulderfist-Oger und -Vollstrecker (32-34) lagern südlich der Straße, südlich von {area:313}; die Vollstrecker bleiben in der Höhle dort.",
	-- ["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north, down the slope above the town. Southshore Guards (55) stand at the graveyard's north-west corner and south-east of the grave: walk in between them, hand the quest in and leave the way you came."] = "Geh nach Osten zum Friedhof von {area:271}, am nordöstlichen Rand des Ortes: Helculars Grab liegt zwischen den anderen. Komm von Norden, den Hang oberhalb des Ortes hinunter. Wachen von Southshore (55) stehen an der Nordwestecke des Friedhofs und südöstlich des Grabes: Geh zwischen ihnen hindurch, gib die Quest ab und verschwinde auf demselben Weg, auf dem du gekommen bist.",
	-- ["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Geh südlich an der Stadt {area:287} vorbei zur {area:288}. Minenarbeiter arbeiten in den Tunneln; {npc:2305} (30) und {npc:2450} (29) sind tief im Inneren.",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp. Arcane Sentries (55, elite) and Kirin Tor Guards (55) stand around the violet dome itself: keep to the camp below the rim."] = "Geh nach Westen am Fuß der Berge entlang zur violetten Kuppel von {area:279}. {npc:2411}, {npc:2412} und {npc:2413} (33-34) stehen zusammen im östlichen Kraterrand, {npc:2414} (35) ein Stück westlich von ihnen; jeder trägt ein Blutsteinstück. Die Schildwachen und Theurgen (31-33) um sie herum lassen die Abgenutzten Steinmarken fallen. Vorsicht: Viele Wachen stehen in verbundenen Paaren, und andere patrouillieren allein um das Lager. Arkane Wächter (55, Elite) und Wachen der Kirin Tor (55) stehen um die violette Kuppel selbst: Bleib im Lager unterhalb des Rands.",
	-- ["Highland raptors and Plains Creepers"] = "Hochland-Raptoren und Plains Creepers",
	-- ["Lesser Troll's Blood Elixir: auction house or an alchemist, for {quest:515}."] = "Schwächeres Trollblut-Elixier: Auktionshaus oder ein Alchemist, für {quest:515}.",
	-- ["Level 31"] = "Stufe 31",
	-- ["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "Lydons nächster Auftrag ist ein Fass Shindigger Stout aus dem Keller von {area:290}, der Elite-Zwergenfestung südöstlich von {area:271}: Nimm es nur an, wenn du mit einer Gruppe hingehst.",
	-- ["North of Southshore's graveyard"] = "Nördlich des Friedhofs von Southshore",
	-- ["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "Auf dem Rückweg nach Norden streifen Highland Striders durch die Hügel rund um {area:321} und lassen die Augen fallen, und südlich davon spinnen die Plains Creepers (32-33) ihre Netze im Gras; sie tragen die Spinnenseide.",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "Nur wenn das Schreiben von {quest:535} nicht bei dir gelandet ist: Die Schleicher und Diebe des Syndikats (32-34) um die Lager westlich der Straße tragen auch Schreiben; etwa jeder dritte lässt eins fallen. Vorsicht: Mit 31-32 sind sie noch über dir und stehen dicht beieinander, mit Hexern (34-35) dazwischen: Zieh sie einzeln vom Rand des Lagers.",
	-- ["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "Stelle das {object:1729} auf den {object:1728} neben dem Gasthaus; oben",
	-- ["Shindigger keg"] = "Fässchen Shindigger-Starkbier",
	-- ["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Südlich von Hammerfall halten die Witherbark-Trolle das Dorf in den Hügeln. Axtwerfer bewachen die äußeren Hütten; die Hexendoktoren und Kopfjäger halten das Herz des Dorfes. Vorsicht: Alle drei Trollarten fliehen bei 15% Gesundheit, um Hilfe zu holen, was weitere Trolle aus den nahen Lagern heranziehen kann.",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "Im Südwesten füllen die Höhlenyetis und Wilden Yetis (30-32) {area:277} in den Hügeln westlich von {area:272}; etwa jeder sechzehnte trägt die Rute. Bleib in diesen Höhlen: Die Berg- und Riesenyetis (32-34) der Höhle weiter nördlich tragen sie auch, aber mit 29-30 schlagen sie hart zu und kommen zu zweit.",
	-- ["Syndicate missives"] = "Schreiben des Syndikats",
	-- ["The Daggerspine naga line the shore south-east of the town."] = "Die Naga der Daggerspine säumen das Ufer südöstlich der Stadt.",
	-- ["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "Die Fässer Shindigger Stout stehen im Keller von {area:290}, der Zwergenfestung südöstlich von {area:271}, neben {npc:2304} (32); jeder Zwerg dort ist Elite (28-32).",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Die Schleicher und Diebe des Syndikats (32-33) um die Lager westlich der Straße tragen die Schreiben; etwa jeder dritte lässt eins fallen.",
	-- ["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "Die Murlocs der Torn Fin lagern an den Stränden südwestlich der Bucht von {area:271}, unterhalb der Mine.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Das Fässchen steht mit einigen anderen im Lager des Syndikats an der Südostküste von {area:287}.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "Die Orcfestung am östlichen Ende der Straße. {npc:2851}, die Windreitermeisterin, steht beim Tor.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "Die Orc-Festung am östlichen Ende der Straße. {npc:2851}, der Windreitermeister, steht am Tor.\n{npc:15126} bietet das {quest:8263} erst an, wenn du bei den Entweihten ({zone:1461}) Freundlich bist: Überspringe es, wenn er es nicht anbietet.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "Die dritte Flamme brennt in der kleineren Höhle oben in den Hügeln nördlich der Höhlen.\nVorsicht: Riesen- und Bergyetis (32-34) stehen um die Flamme, oft zu zweit, und Frostrachen, ein seltener Yeti (37), streift in der Nähe umher. Mit 30-31 sind sie über deiner Stufe: Zieh die Yetis einzeln vom Höhleneingang, bevor du die Rute benutzt, und achte auf Frostrachen, bevor du hineingehst.",
	-- ["The {area:279} crater"] = "Der Krater von {area:279}",
	-- ["The {area:279} crater's eastern rim"] = "Der Ostrand des Kraters von {area:279}",
	-- ["Torn Fin beach"] = "Strand der Fetzenflossen",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "Nach Westen über die Ausläufer zum Ort {area:287}: Die Schmiede steht in seiner Mitte. {npc:2404} und seine Lehrlinge arbeiten an der Esse; die {object:1736} ist daneben gestapelt.",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "Nach Westen über die Ausläufer zum Ort {area:287}: Die Schmiede steht in seiner Mitte. {npc:2404} und seine Lehrlinge arbeiten an der Esse; die {object:1736} ist daneben gestapelt. {npc:2449} läuft bei der Schmiede umher; {npc:2451} bestellt das Feld südöstlich des Orts.",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "Mit {item:3388} in deinen Taschen bietet {npc:2055} im Apothekarium {quest:513} an; {npc:2216} nimmt das Elixier in {area:272} entgegen.",
	-- ["grind on {npc:2248}"] = "grinde an {npc:2248}",
	-- ["grind on {npc:2562}"] = "grinde an {npc:2562}",
	-- ["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the City of Dalaran dungeon instead."] = "{quest:544}, {quest:556} und {quest:676} von {area:272} werden ab Stufe 30 angeboten. Darunter? Töte weiter die Yetis in diesen Höhlen, bis du Stufe 30 bist. Oder lauf mit einer Gruppe stattdessen den Dungeon Stadt Dalaran.",
	-- ["{area:321} flight master"] = "Flugmeister von {area:321}",
	-- ["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the City of Dalaran dungeon instead."] = "Die Quests von {area:321} sind 32-36. Unter 31? Töte weiter die Boulderfist-Oger und -Vollstrecker an diesem Lager, bis du Stufe 31 bist. Oder lauf mit einer Gruppe stattdessen den Dungeon Stadt Dalaran.",
	-- ["{item:278225}, from Plains Creepers"] = "{item:278225}, von Plains Creepersn",
	-- ["{item:279469}: an object to loot, by the traitors"] = "{item:279469}: ein Objekt zum Plündern, bei den Verrätern",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}: Auktionshaus oder ein Alchemist, für {quest:513}.",
	-- ["{item:3703}, for {npc:2333}"] = "{item:3703}, für {npc:2333}",
	-- ["{npc:12920}, at the south gate"] = "{npc:12920}, am Südtor",
	-- ["{npc:2229} now offers {npc:2316} (level 36), Bel'varil Bracers of Binding and Voidglare Dalaran Patrols: leave them for the 38-39 visit, which takes them on its first {area:272} stop."] = "{npc:2229} bietet jetzt {npc:2316} (Stufe 36), Bel'varil Bracers of Binding und Voidglare Dalaran Patrols an: Heb sie dir für den Besuch bei 38-39 auf, der sie bei seinem ersten Halt in {area:272} annimmt.",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229} will, dass du seine zwei Späher aus {area:275} befreist, bevor er dir „Unterwanderung“ anvertraut.",
	-- ["{npc:2410}, inside"] = "{npc:2410}, drinnen",
	-- ["{npc:2410}, inside: offered from level 30"] = "{npc:2410}, drinnen: wird ab Stufe 30 angeboten",
	-- ["{npc:2410}: for the 38-39 visit to Alterac"] = "{npc:2410}: für den Besuch bei 38-39 in Alterac",
	-- ["{npc:2410}: he offers {quest:545} after it"] = "{npc:2410}: Er bietet danach {quest:545} an",
	-- ["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}: {quest:93680}, der {item:279469} ist bei den Verrätern",
	-- ["{npc:2437}, inside"] = "{npc:2437}, drinnen",
	-- ["{npc:2437}, inside: offered from level 30"] = "{npc:2437}, drinnen: wird ab Stufe 30 angeboten",
	-- ["{npc:2437}: for the 38-39 visit to Alterac"] = "{npc:2437}: für den Besuch bei 38-39 in Alterac",
	-- ["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "Guile of the Raptor von {npc:2706}, die nächste {quest:677} von {npc:2771} und Ward Restocking des Doktors warten auf den Besuch bei 38-39.",
	-- ["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "{npc:2706}: Seine Syndikatsleute sind an der Straße von {area:272} herein, beim Besuch bei 38-39",
	-- ["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "{npc:2770}: für {npc:2771} in {area:321}, später in diesem Guide (ab Stufe 30)",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}, am Tor",
	-- ["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} steht neben dem Flugmeister des Wegekreuzes.",
	-- ["{quest:513} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "{quest:513} braucht {item:3388}, einen Gegenstand von {skill:171}: Kauf eins im Auktionshaus, wenn du kannst (oder frag einen Alchemisten). Der Questtext sagt „Stark“, aber sie nimmt {item:3388}. Kein Elixier: Überspringe die Elixier-Schritte in {area:287}.",
	-- ["{quest:515} with a group"] = "{quest:515} mit einer Gruppe",
}
