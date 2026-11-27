-- German (deDE): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands
	["Western & {zone:1423}"] = "Westlich & {zone:1423}",

	-- Step 1: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Flieg nach {area:702}",
	-- {zone:1457} Darnassus · {zone:1450} Moonglade · {zone:1455} Ironforge · {area:3197} Chillwind Camp
	["The {zone:1457}, {zone:1450} and {zone:1455} stops are for players coming from the previous guides with their quests; opened with none of those quests in the log, the guide starts at {area:3197}."] = "Die Stopps in {zone:1457}, {zone:1450} und {zone:1455} sind für Spieler, die mit ihren Quests aus den vorherigen Guides kommen; ohne eine dieser Quests im Questlog geöffnet, beginnt der Guide in {area:3197}.",

	-- Step 2: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "Der Flug landet in {area:702}. {npc:7916} steht einen kurzen Fußweg nordwestlich vom Flugmeister.",
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}' next task sends you back to Ranshalla in {zone:1452}, behind the route now: skip it."] = "{npc:7916}s nächste Aufgabe schickt dich zurück zu Ranshalla in {zone:1452}, liegt hinter der Route: Überspringe sie.",

	-- Step 4: Herald Moonstalker
	-- {npc:10878} Herald Moonstalker
	["{npc:10878} stands by the Temple of the Moon."] = "{npc:10878} steht beim Tempel des Mondes.",

	-- Step 6: Arch Druid Fandral Staghelm
	-- {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building of the {area:1658}; {npc:4217}, next, is lower down inside it."] = "Fandral steht oben im Druidenhaus des {area:1658}; {npc:4217} liegt weiter unten, im Inneren.",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "{npc:3516}, oben",

	-- Step 8: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, oben",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade · {zone:2482} Mount Hyjal
	["{quest:6762} in {zone:1450}: {zone:2482}'s {zone:1450} errand takes you to her, in the next guide; keep it"] = "{quest:6762} in {zone:1450}: Der {zone:1450}-Auftrag für {zone:2482} führt dich zu ihr, im nächsten Guide; Behalte es",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} hat keinen Druidenlehrer",

	-- Step 9: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal nach {zone:1438}",

	-- Step 10: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Flieg nach {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Flugmeister von {area:702}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- Step 12: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Flugmeister von {area:150}",

	-- Step 13: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle
	["{npc:9616}' next task fills his jars in Un'Goro, behind the route now: skip it."] = "{npc:9616}s nächste Aufgabe füllt seine Krüge in Un'Goro, hinter der aktuellen Route: Überspringe sie.",

	-- Step 14: Ironforge
	-- {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["{npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14724} und {npc:14723} nehmen je sechzig Wollstoff, sechzig Seidenstoff und sechzig Magiestoff, dann sechzig {item:14047}: Gib ab, was du dabeihast (oder kaufe es im Auktionshaus), den Rest überspring.",
	-- {npc:15187} Cenarion Emissary Jademoon · {npc:15191} Windcaller Proudhorn · {zone:1451} Silithus
	["{npc:15187}, by the flight master where you land: for {npc:15191} in {zone:1451}, on the last guide; keep it"] = "{npc:15187}, beim Flugmeister, wo du landest: Für {npc:15191} in {zone:1451}, im letzten Guide; Behalte es",
	-- {npc:13843} Lieutenant Rotimer · {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13843}: for {npc:13841}, on the way to {area:3197}"] = "{npc:13843}: Für {npc:13841}, auf dem Weg zum {area:3197}",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "{item:2592}, aus deinen Taschen",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "{item:4306}, aus deinen Taschen",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "{item:4338}, aus deinen Taschen",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "{item:14047}, aus deinen Taschen",

	-- Step 15: Courier Hammerfall
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10877} Courier Hammerfall · {zone:1455} Ironforge · {npc:10838} Commander Ashlam Valorfist
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10877} walks the ring of {zone:1455} and sends you to {npc:10838}, whose camp this guide visits next. Chillwind's chain starts with it."] = "Ohne die {area:3197}-Quests des {zone:1428}-Guides: {npc:10877} wandelt den Ring des {zone:1455} ab und schickt dich zu {npc:10838}, dessen Lager dieser Guide als Nächstes besucht. Die Kette von Chillwind beginnt damit.",

	-- Step 16: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Flieg nach {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",

	-- Step 17: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them."] = "Reite von {area:271} nach Norden ins Alterac und nach Westen zu den Mauern von {area:279}: {npc:34365} steht vor ihnen.",

	-- Step 18: Lieutenant Haggerdin
	-- {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13841} camps beside the road north to {area:3197}."] = "{npc:13841} lagert neben der Straße nach Norden zum {area:3197}.",

	-- Step 19: Chillwind Camp: Clear the Way
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10838} Commander Ashlam Valorfist · {quest:5092} Clear the Way
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10838} stands in the middle of the camp. His {quest:5092} opens the camp's chain."] = "Ohne die {area:3197}-Quests des {zone:1428}-Guides: {npc:10838} steht in der Mitte des Lagers. Seine {quest:5092} öffnet die Lagerkette.",

	-- Step 20: Sorrow Hill: Clear the Way
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields just north of the camp.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled."] = "Skelettschinder und Sabbernde Ghule (50) streifen über die Felder nördlich des Lagers.\nVorsicht: Diese Untoten bemerken dich schon von weitem, und weitere Untote in der Nähe schließen sich dem Kampf an, wenn einer gepullt wird.",

	-- Step 21: Chillwind Camp: the cauldrons
	-- {area:3197} Chillwind Camp
	["{area:3197}: the cauldrons"] = "{area:3197}: die Kessel",
	-- {npc:11053} High Priestess MacDonnell
	["Back to the camp: Valorfist, then {npc:11053} beside him."] = "Zurück zum Lager: Tapferfaust, dann {npc:11053} neben ihm.",
	-- {area:199} Felstone Field
	["{area:199}'s cauldron, later in this guide"] = "Der Kessel des {area:199}, später in diesem Guide",

	-- Step 22: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Reinherz, Dumah, Tapferfaust und MacDonnell stehen in der Mitte des Lagers, beim Flugmeister.",
	-- {npc:11616} Nathaniel Dumah · {area:2277} Plaguewood
	["{npc:11616}: the termites come later, in the {area:2277}"] = "{npc:11616}: Die Termiten kommen später, im {area:2277}",
	-- {npc:10838} Commander Ashlam Valorfist · {area:199} Felstone Field
	["{npc:10838}: the watchtowers stand around Andorhal, on the way to {area:199}"] = "{npc:10838}: Die Wachtürme stehen um Andorhal, auf dem Weg zum {area:199}",

	-- Step 23: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission
	["No {quest:5401} yet? Pureheart gives you one here: the scourgestone quests need it."] = "Noch keine {quest:5401}? Reinherz gibt dir hier eine: Die Geißelstein-Quests brauchen sie.",

	-- Step 24: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Die Wachtürme von Andorhal",
	-- {item:12815} Beacon Torch · {area:199} Felstone Field · {npc:7572} Fallen Hero of the Horde
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp, on the way to {area:199}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Benutze das {item:12815} am Fuß jedes der vier Wachtürme am Rand von Andorhal, nördlich des Lagers, auf dem Weg zum {area:199}.\nVorsicht: Skelettkriegsherren und Fleischgolems (57, Elite) laufen durch Andorhals Straßen, und der {npc:7572} (59, Elite) wandert zwischen Andorhal und Northridge: Bleib bei den Türmen am Stadtrand und lass sie passieren.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Markiere {npc:10902} mit der {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Markiere {npc:10903} mit der {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Markiere {npc:10904} mit der {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Markiere {npc:10905} mit der {item:12815}",

	-- Step 25: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Kessel im {area:199}",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw · {npc:10778} Janice Felstone · {zone:1453} Stormwind
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["West of Andorhal to {area:199}: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54).\n{npc:10778}'s ghost wanders by the farmhouse at the field's edge, upstairs; her parcel lies inside the house: take it for {zone:1453}, at the end of this guide."] = "Westlich von Andorhal zum {area:199}: {npc:11075} (53) bewacht den Kessel zwischen den Schwatzghulen (54).\n{npc:10778}s Geist streift am Bauernhaus am Feldrand umher, oben; ihr Paket liegt im Haus: Nimm es für {zone:1453}, am Ende dieses Guides.",
	-- {npc:10778} Janice Felstone
	["{npc:10778}, upstairs in the farmhouse"] = "{npc:10778}, oben im Bauernhaus",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "{object:175894}, drinnen",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Für {zone:1453}: Behalte es",

	-- Step 26: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Back to {area:3197}."] = "Zurück zum {area:3197}.",
	-- {area:200} Dalson's Tears
	["The cauldron is at {area:200}"] = "Der Kessel liegt im {area:200}",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} ist ein Elite der Stufe 61",

	-- Step 27: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: Töte sie, wenn du ihnen begegnest",
	-- {quest:5401} Argent Dawn Commission · {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones while you wear the {quest:5401} (equip it as a trinket first).\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Skelettschinder und Sabbernde Ghule streifen über die Felder nördlich des Lagers; alle Geißel-Mobs hier lassen Geißelsteine fallen, solange du die {quest:5401} trägst (leg sie zuerst als Schmuckstück an).\nVorsicht: Diese Untoten bemerken dich schon von weitem, und weitere Untote in der Nähe schließen sich dem Kampf an, wenn einer gepullt wird.\nVorsicht: Das {npc:10411} (3 Spawns, 15 Min. Respawn) wird unsichtbar, wenn es nicht im Kampf ist, und ruft Steinschwingengargoyles, sobald ein Kampf beginnt.",

	-- Step 28: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the ghost in {area:2262}, the next stop."] = "Auf der Straße nach Osten aus {area:3197} steht das Bauernhaus von {npc:10927} im {area:197}: Ihre {quest:5142} führt zum Geist im {area:2262}, die nächste Station.",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: Behalte es für {area:2262}",

	-- Step 29: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Nach {zone:1423}",
	-- {zone:1422} Western Plaguelands
	["Follow the southern road east out of the {zone:1422}."] = "Folge der südlichen Straße nach Osten aus {zone:1422}.",

	-- Step 30: Pamela Redpath
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["The ruins of {area:2262} lie south of the road. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Die Ruinen des {area:2262} liegen südlich der Straße. {npc:10926}s Geist spielt beim zerstörten Haus am Südrand.",

	-- Step 31: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}s Puppe",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Die drei Teile der Puppe liegen in den zerstörten Häusern von {area:2262}; beim Aufheben können Geister erscheinen. Füge sie zur Puppe zusammen.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "{item:12886}; drinnen",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "{item:12888}; drinnen",

	-- Step 32: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, back in the {zone:1422}: keep it"] = "{quest:5152}, zurück in {zone:1422}: Behalte es",
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["{npc:11063} at {area:2268}, on this guide's second ride east: keep it"] = "{npc:11063} im {area:2268}, auf der zweiten Fahrt nach Osten dieses Guides: Behalte es",

	-- Step 33: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride back west along the road to {npc:10927}'s farmhouse; {npc:10936}'s monument is just north of it."] = "Reite auf der Straße zurück nach Westen zum Bauernhaus von {npc:10927}; das Denkmal von {npc:10936} liegt nordlich davon.",
	["Upstairs"] = "Oben",
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal, later on this loop: keep it"] = "{npc:10667} in Andorhal, später auf dieser Runde: Behalte es",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, am Denkmal",

	-- Step 34: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {npc:10927} Marlene Redpath
	["{npc:10739} stands by the farm at the {area:202}, north of {npc:10927}."] = "{npc:10739} steht beim Bauernhaus im {area:202}, nördlich von {npc:10927}.",
	["Inside"] = "Drinnen",

	-- Step 35: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202}: Töte sie, wenn du ihnen begegnest",
	-- {item:12841} Invader's Scourgestone · {quest:5401} Argent Dawn Commission
	["{item:12841}: wear the {quest:5401} while you kill"] = "{item:12841}: Trag beim Töten die {quest:5401}",

	-- Step 37: Diseased Grizzlies
	["Diseased Grizzlies"] = "Kranke Grizzlys",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The Diseased Grizzlies (55-56) roam the woods around the {area:202}, east and north of {npc:10739}."] = "Die Kranken Grizzlys (55–56) streifen durch die Wälder um das {area:202}, östlich und nördlich von {npc:10739}.",

	-- Step 38: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1457} Darnassus
	["{npc:10739}' next task goes to the druids of {zone:1457}, behind the route now: skip it."] = "{npc:10739}s nächste Aufgabe führt zu den Druiden des {zone:1457}, liegt hinter der Route: Überspringe sie.",

	-- Step 39: Dalson's Tears
	-- {npc:10836} Farmer Dalson · {npc:11152} The Scourge Cauldron
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key. {npc:11152} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "Reite nach Nordwesten zum Dalson-Bauernhaus. Das Tagebuch liegt in der Scheune; ein wanderndes Skelett trägt den Schlüssel zum Plumpsklo, und {npc:10836} wartet im Plumpsklo mit dem Schlüssel zum Schrank. {npc:11152} steht südwestlich des Bauernhauses, und daneben trägt sein Kesselherr den Schlüssel.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}, im Bauernhaus; drinnen",

	-- Step 40: Argent Officer Pureheart
	-- {area:3197} Chillwind Camp
	["Ride back south to {area:3197}."] = "Reite zurück nach Süden zum {area:3197}.",

	-- Step 42: Chillwind Camp
	-- {area:200} Dalson's Tears
	["Ride back south from {area:200} to the camp."] = "Reite von {area:200} zurück nach Süden zum Lager.",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} (from level 55)"] = "{npc:10838} (ab Stufe 55)",
	["The skeletons of Andorhal, next on this guide"] = "Die Skelette von Andorhal, als Nächstes in diesem Guide",

	-- Step 43: Chromie
	-- {npc:10667} Chromie
	["North to {npc:10667} in the ruined inn on the west side of Andorhal."] = "Nach Norden zu {npc:10667} in dem zerstörten Gasthaus auf der Westseite von Andorhal.",

	-- Step 44: Andorhal
	["Andorhal"] = "Andorhal",
	-- {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments · {npc:1852} Araj the Summoner
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["{quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk the streets: let them pass.\n{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{quest:5154} ist einer der modrigen Wälzer im Rathaus. Jedes Skelett in der Stadt lässt {quest:5537} fallen.\nVorsicht: Skelettkriegsherren ({npc:1788}) und Fleischgolems ({npc:1805}) (57, Elite) laufen durch die Straßen: Lass sie vorbeiziehen.\n{npc:1852} ist Elite: Eine Gruppe wird empfohlen. Er bewacht seine Phylakterie in der Mitte von Andorhal.",

	-- Step 45: Andorhal's grain silos
	["Andorhal's grain silos"] = "Andorhals Getreidesilos",
	-- {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["Use the {item:12627} by each grain silo on the north side of town to draw out Temporal Parasites, one silo after another.\nCareful: the Temporal Parasites are 55-57: draw them out one silo at a time, away from the Skeletal Warlords and Flesh Golems (57, elites) in the streets."] = "Benutze {item:12627} an jedem Getreidesilo im Norden der Stadt, um Zeitparasiten ({npc:10717}) hervorzulocken, ein Silo nach dem anderen.\nVorsicht: Die Zeitparasiten sind 55-57: Lock sie Silo für Silo hervor, weg von den Skelettkriegsherren ({npc:1788}) und Fleischgolems ({npc:1805}) (57, Elite) in den Straßen.",

	-- Step 46: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, bei der {area:2268}: Behalte es",

	-- Step 47: Sorrow Hill: kill these as you meet them
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Kleine Schließkästen liegen im Schutt überall in Andorhal; jeder birgt eine Uhr.\nVorsicht: Ghule und Skelette stehen meist neben den Kästen und greifen an, wenn du nah kommst. Siedende Ghule verletzen auch alle in der Nähe und durchbrechen dein Schleichen.",

	-- Step 49: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Kessel: {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm, east of Andorhal."] = "Der Kessel steht im {area:202}, beim Bauernhaus von {npc:10739}, östlich von Andorhal.",

	-- Step 50: Chillwind Camp
	-- {area:201} Gahrron's Withering
	["{area:201}'s cauldron, on this guide's ride north-east"] = "Der Kessel des {area:201}, auf der Fahrt nach Nordosten dieses Guides",
	-- {area:976} Gadgetzan
	["Arbington's next task goes to {area:976}, behind the route now: skip it."] = "Arbingtons nächste Aufgabe führt zum {area:976}, liegt hinter der Route: Überspringe sie.",

	-- Step 51: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone
	["Fly to {zone:1453} for Highlord Bolvar's errand for SI:7 and {npc:10778}'s parcel, then straight back."] = "Flieg nach {zone:1453} für den Auftrag von Hochlord Bolvar für SI:7 und das Paket von {npc:10778}, dann direkt zurück.",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Flugmeister in {area:3197}",

	-- Step 52: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, bei SI:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}, on the flight back"] = "{quest:6184} im {area:3197}, auf dem Rückflug",

	-- Step 53: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} nimmt sechzig Seidenstoff, sechzig Magiestoff und sechzig {item:14047}: Gib ab, was du dabeihast (oder kaufe es im Auktionshaus), den Rest überspring.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, der an den Kanälen entlanggeht",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, out of the way now: skip it."] = "Emmas Amulett geht zurück zu {npc:10778} in {zone:1422}, liegt jetzt abseits: Überspringe es.",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, im {object:2096}",

	-- Step 54: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Flieg nach {area:3197}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 55: Flint Shadowmore
	-- {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["The agents' remains lie at the {area:2260} in the {zone:1423}, on this guide's ride east"] = "Die Überreste der Agenten liegen im {area:2260} im {zone:1423}, auf der Fahrt nach Osten dieses Guides",

	-- Step 56: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Reite auf der Straße nach Norden zum Holzlager Northridge; {npc:11610} versteckt sich am Rand des Lagers.",

	-- Step 57: The Scarlet Crusade
	["The Scarlet Crusade"] = "Der Scharlachrote Kreuzzug",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Scharlachrote Sanitäter, Jäger, Ritter und Magier patrouillieren durch das Holzlager und auf der Straße Richtung {area:190}.",

	-- Step 59: Radley and Durgen
	["Radley and Durgen"] = "Radley und Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} (56) walks the Northridge camp east of {npc:11610}; {npc:11611} (57) guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} (56) läuft im Holzlager Northridge östlich von {npc:11610} umher; {npc:11611} (57) bewacht den Turm am südlichen Zugang zum {area:190}.\nVorsicht: Wachen stehen am Fuß des Turms, und eine weitere patrouilliert um ihn. Räume sie auf, bevor du dich auf Durgen einlässt, damit sie nicht mitkämpfen.",

	-- Step 60: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} versteckt sich am Rand des Holzfällerlagers.",

	-- Step 61: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Aussichtspunkt über {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Steig den Hügel westlich von {area:190} hinauf, um auf die Stadt hinabzublicken.\nVorsicht: Am Tor postierte Wachposten können getarnte Spieler entdecken. In der Stadt stehen weitere Wachposten, und ein Elite patrouilliert in der Nähe.",

	-- Step 63: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2277} Plaguewood · {area:2627} Terrordale
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank. His hunts are in the {area:2277} and {area:2627}, at the end of this guide's ride east."] = "Reite nach Osten zum Grenzfluss: {npc:1855} lebt in einer kleinen Hütte am Ufer. Seine Jagden liegen im {area:2277} und {area:2627}, am Ende der Fahrt nach Osten dieses Guides.",

	-- Step 64: Gahrron's Withering
	-- {npc:1855} Tirion Fordring · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south from {npc:1855}'s hut to {area:201}. {npc:11078} (58) guards the cauldron.\nCareful: Soulwrath is level 58, a level over you here: clear the ghouls around the cauldron first and pull him alone."] = "Reite von der Hütte von {npc:1855} nach Süden zum {area:201}. {npc:11078} (58) bewacht den Kessel.\nVorsicht: Soulwrath ist Stufe 58, hier eine Stufe über dir: Räume zuerst die Ghule um den Kessel und zieh ihn allein.",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "Für {npc:11053} im {area:3197}, am Ende dieses Guides",

	-- Step 65: Marris Stead
	-- {zone:1423} Eastern Plaguelands · {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride east into the {zone:1423}: the {area:2260} is the farm north of the southern road, north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "Reite nach Osten ins {zone:1423}: Der {area:2260} ist der Bauernhof nördlich der südlichen Straße, nordwestlich von {area:2262}. Die Überreste der drei Agenten sind Knochenumrisse am Boden: einer bei der Straße südlich des Bauernhofs, einer auf dem Hügel östlich des Hauses, einer auf dem Hügel davor.\nVorsicht: {npc:11878} (Stufe 62, Elite) und seine Elite-Hunde stehen vor dem Haus: Nimm die Überreste auf dem Hügel von der Seite und zieh ihn nicht. Du musst ihn nicht bekämpfen.",
	["Close enough to see the Blightcaller in front of the house"] = "Nah genug, um den Blightcaller vor dem Haus zu sehen",

	-- Step 66: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: Töte sie, wenn du ihnen begegnest",
	-- {zone:1423} Eastern Plaguelands · {area:2268} Light's Hope Chapel
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Gargantuan Plaguebats = {npc:272342} Gargantuan Plaguebat
	["Ride east along the southern road across the {zone:1423} to {area:2268}: Plaguehound Runts and Plaguebats roam beside it.\nCareful: Gargantuan Plaguebats (60) fly among the smaller bats near the western border: take the Plaguebats of your level."] = "Reite nach Osten entlang der südlichen Straße durch {zone:1423} zum {area:2268}: Seuchenhundwelpen und Seuchenfledermäuse streifen daneben.\nVorsicht: Riesige Seuchenfledermäuse (60) fliegen unter den kleineren Fledermäusen nahe der Westgrenze: Nimm die Seuchenfledermäuse deiner Stufe.",

	-- Step 67: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "{npc:11063}s nächste Aufgabe bei {area:2264} liegt zwischen Geißel-Mobs der Stufe 57-60: Überspringe sie.",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, at the end of this ride: keep it"] = "{npc:11038}, bei den Gräbern südlich der Kapelle: {npc:11140} ist im {area:2627}, am Ende dieser Fahrt: Behalte es",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast · {area:2261} Undercroft
	["{npc:11038}'s {npc:12250} is a group quest in the {area:2261} (a level 54 elite)."] = "{npc:11038}s {npc:12250} ist eine Gruppenquest im {area:2261} (ein Elite der Stufe 54).",

	-- Step 68: Carlin Redpath: Heroes of Darrowshire
	-- {area:190} Hearthglen · {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	-- plural, as words: Haunting Visions = {npc:4472} Haunting Vision
	["The libram is inside {area:190} among elite Scarlet guards, and {item:12955} among Haunting Visions at {area:201}: a group quest."] = "Das Libram liegt im {area:190} zwischen Scharlachroten Eliten, und {item:12955} zwischen Spukvisionen im {area:201}: eine Gruppenquest.",

	-- Step 69: Villains of Darrowshire
	-- {area:2623} Infectis Scar · {area:2624} Blackwood Lake
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["West into the middle of the zone: Marduk's sword lies in the {area:2623} and Horgus' skull at {area:2624}, north of it, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Nach Westen in die Mitte des Gebiets: Marduks Schwert liegt im {area:2623} und Horgus' Schädel im {area:2624}, nördlich davon, jeweils dort, wo Geister kämpfen; ausgewachsene Seuchenhunde jagen die Ebenen dazwischen.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "{item:12956}; unter Wasser",

	-- Step 70: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath
	["Back east to {npc:11063} at the chapel."] = "Zurück nach Osten zu {npc:11063} bei der Kapelle.",

	-- Step 71: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Reite nach Nordwesten zur {area:2276}, am Rand des Gebiets {area:2277}.",

	-- Step 72: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: Töte sie, wenn du ihnen begegnest",
	-- {area:2277} Plaguewood · {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Carrion Devourers = {npc:8605} Carrion Devourer
	["West through the {area:2277} to {area:2627}: fill the {item:15042} at the big termite mounds, and kill the Frenzied Plaguehounds and the Carrion Devourers on the way.\nCareful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "Nach Westen durch den {area:2277} zum {area:2627}: Fülle das {item:15042} an den großen Termitenhügeln und töte unterwegs die Rasenden Seuchenhunde und die Aasfresser.\nVorsicht: Die Rasenden Seuchenhunde sind Stufe 57–58: Zieh sie einzeln.",

	-- Step 73: Augustus the Touched
	-- {npc:12384} Augustus the Touched · {area:2627} Terrordale · {npc:11140} Egan · {npc:16184} Nerubian Overseer · {area:2626} Terrorweb Tunnel
	["{npc:12384} lives in the ruined hut in {area:2627}, and his receipt book lies in the ruined inn nearby. {npc:11140} stands by {npc:12384}' hut.\nCareful: a {npc:16184} (60, elite) walks {area:2627} and the {area:2626} south-west of it. Look for him before you ride in, and wait for him to pass."] = "{npc:12384} lebt in der verfallenen Hütte in {area:2627}, und sein Quittungsbuch liegt im nahen, verfallenen Gasthaus. {npc:11140} steht bei {npc:12384}s Hütte.\nVorsicht: Ein {npc:16184} (60, Elite) läuft durch {area:2627} und das südwestlich davon liegende {area:2626}. Such ihn, bevor du hineinreitest, und warte, bis er vorbeigeht.",

	-- Step 75: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:2626} Terrorweb Tunnel
	-- plural, as words: Crypt Fiends = {npc:8555} Crypt Fiend
	["Cross the river west to {npc:1855}'s hut.\nCareful: the short way from {area:2627} to {npc:1855} is the {area:2626}, whose south mouth opens by his hut: Crypt Fiends, Walkers, Horrors and Slayers (53-58) stand close together inside. Pull them one at a time, or ride round by the road outside it."] = "Quer den Fluss nach Westen zur Hütte von {npc:1855}.\nVorsicht: Der kurze Weg vom {area:2627} zu {npc:1855} ist der {area:2626}, dessen südliche Mündung an seiner Hütte liegt: Kryptenschrecken, Walker, Horrors und Schlitzer (53–58) stehen dicht gedrängt darin. Zieh sie einzeln, oder reite auf der Straße um ihn herum.",

	-- Step 77: Tirion Fordring
	["Listen to his story"] = "Hör dir seine Geschichte an",

	-- Step 78: Tirion Fordring: Of Forgotten Memories
	-- {quest:5781} Of Forgotten Memories · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["{quest:5781} is a group quest: {npc:11886} (57, elite) and his adds in the {area:2261}."] = "{quest:5781} ist eine Gruppenquest: {npc:11886} (57, Elite) und seine Adds im {area:2261}.",

	-- Step 79: Undercroft
	-- {area:2261} Undercroft
	["Cross the river south-east to the {area:2261}, the crypt in the south-west of the zone.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Quer den Fluss nach Südosten zum {area:2261}, der Krypta im Südwesten des Gebiets.\nVorsicht: Etwa vier Adds ohne Elite kommen mit Mercutio. Sie gehen zum Grab, statt auf der Stelle zu erscheinen.",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886} (57, elite)"] = "{item:14613}, von {npc:11886} (57, Elite)",

	-- Step 80: Tirion Fordring
	-- {quest:5845} Of Lost Honor · {area:2277} Plaguewood · {area:3197} Chillwind Camp
	["{quest:5845}'s symbol lies in the lake south of the {area:2277}: your group fetches it before the ride back to {area:3197}."] = "Das Symbol der {quest:5845} liegt im See südlich des {area:2277}: Deine Gruppe holt es, bevor es zurück nach {area:3197} geht.",

	-- Step 81: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1839} Scarlet High Clerist
	-- plural, as words: Scarlet Paladins = {npc:1834} Scarlet Paladin
	["Careful: Scarlet Paladins (55-56) and priests guard {item:12954} inside {area:190}'s town hall. They are elite, and a {npc:1839} (63, elite) stands near the book. Go in with your group; stay out of the Clerist's reach."] = "Vorsicht: Scharlachrote Paladine (55–56) und Priester bewachen {item:12954} im Rathaus des {area:190}. Sie sind Elite, und ein {npc:1839} (63, Elite) steht nahe des Buches. Geh mit deiner Gruppe hinein; bleib außerhalb der Reichweite des Cleristen.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "{item:12954}; drinnen",

	-- Step 82: Redpath's Shield
	-- {area:201} Gahrron's Withering
	["The shield lies east of the barn at {area:201}. Take your group around the barn to reach it."] = "Der Schild liegt östlich der Scheune im {area:201}. Führe deine Gruppe um die Scheune herum, um ihn zu erreichen.",

	-- Step 83: Carlin Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["Back to {npc:11063} at {area:2268} with your group."] = "Zurück zu {npc:11063} im {area:2268} mit deiner Gruppe.",

	-- Step 84: Eastern Plaguelands
	-- {area:2277} Plaguewood · {area:2268} Light's Hope Chapel
	["Ride to the lake south of the {area:2277}, north-west of {area:2268}."] = "Reite zum See südlich des {area:2277}, nordwestlich von {area:2268}.",
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "Der See für {quest:5845}",

	-- Step 85: Of Lost Honor
	["Underwater"] = "Unter Wasser",

	-- Step 86: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:3197} Chillwind Camp
	["West across the zone to {npc:1855}'s hut on the way back to {area:3197}."] = "Nach Westen quer durch das Gebiet zur Hütte von {npc:1855} auf dem Rückweg zum {area:3197}.",

	-- Step 87: Western Plaguelands
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp
	["Ride south-west through the {zone:1422} to {area:3197}."] = "Reite nach Südwesten durch {zone:1422} zum {area:3197}.",

	-- Step 88: Chillwind Camp
	["Dumah's next task sets a barrel down at Northridge, behind you now: skip it."] = "Dumahs nächste Aufgabe stellt ein Fass in Northridge ab, liegt hinter dir: Überspringe sie.",

	-- Step 89: Flint Shadowmore
	-- {zone:1453} Stormwind
	["Highlord Bolvar in {zone:1453}, on the way out of this guide"] = "Hochlord Bolvar in {zone:1453}, auf dem Weg aus diesem Guide",

	-- Step 91: Stormwind City
	["Stormwind City"] = "Sturmwind",
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:1748}, in {object:2117}"] = "{npc:1748}, in {object:2117}",

	-- Step 92: Stormwind
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone · {npc:10782} Royal Factor Bathrilor · {object:2096} Trade District · {npc:3520} Ol' Emma · {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["Without the flight to {zone:1453} at 56 earlier in this guide: {npc:10778}'s parcel goes to {npc:10782} in the {object:2096}, then {npc:3520} takes her own errand on the canals. {npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "Ohne den Flug nach {zone:1453} mit 56 früher in diesem Guide: Das Paket von {npc:10778} geht zu {npc:10782} in {object:2096}, dann nimmt {npc:3520} ihren eigenen Auftrag an den Kanälen an. {npc:14722} nimmt sechzig Seidenstoff, sechzig Magiestoff und sechzig {item:14047}: Gib ab, was du dabeihast (oder kaufe es im Auktionshaus), den Rest überspring.",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, behind you now: skip it."] = "Emmas Amulett geht zurück zu {npc:10778} in {zone:1422}, liegt hinter dir: Überspringe es.",

	-- Step 93: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Flieg nach {area:150}",

	-- Step 94: Boat to Theramore
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook
	["Take the boat to Theramore: {zone:2482}, the next guide, starts with the flight to {area:2255}."] = "Nimm das Boot nach Theramore: {zone:2482}, der nächste Guide, beginnt mit dem Flug nach {area:2255}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["After the farm's keys: the {object:177289} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "Nach den Schlüsseln des Hofs: {object:177289} steht gleich südwestlich des Bauernhauses, und sein Kessellord daneben trägt den Schlüssel.",
	-- ["Andorhal Watches"] = "Andorhal-Uhren",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Zurück nach Norden zum Ort {area:202}: Der Kessel bietet jetzt eine eigene Aufgabe an. Die Ghule in der Nähe droppen Somatische Verstärker.",
	-- ["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one, and {npc:9299} in {area:976} shows himself only to someone who has drunk one."] = "Zurück zu {npc:7775}s Lager, direkt südöstlich von {npc:7765}: Die {item:11242} bringt dir drei Videre-Elixiere. Behalte sie: {npc:9298} nimmt eins, und {npc:9299} in {area:976} zeigt sich nur jemandem, der eins getrunken hat.",
	-- ["Below ground"] = "Unter der Erde",
	-- ["Boat to {area:1108}"] = "Boot nach {area:1108}",
	-- ["Bones and equipment"] = "Knochen und Ausrüstung",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Kaufe für den Kessel im Teufelssteinfeld einen {item:13320} bei {npc:11056}, direkt bevor du losgehst: Die Beschleuniger verschwinden nach 30 Minuten.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Kaufe zwei weitere Arkanbeschleuniger für die Kessel am Ort {area:202} und bei Dalsons Tränenfeld und reite direkt dorthin: Sie verschwinden nach 30 Minuten.",
	-- ["Careful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "Vorsicht: Die Rasenden Seuchenhunde sind Stufe 57-58: Zieh sie einzeln.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Steig auf den Hügel westlich von {area:190} und blick auf die Stadt hinunter.",
	-- ["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "Wenn du aus {zone:1451} kommst, liegt {area:543} gleich hinter dem Kraterrand: {npc:10302} der Goblin sitzt am Wasser.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Überquere den Fluss nach Osten zum {area:2261}, der Gruft im Südwesten des Gebiets. {object:177667} liegt drinnen: Ihr Schlüssel ist bei {npc:12248} ganz im Nordosten, was im nächsten Guide erledigt wird.\nVorsicht: Mit Mercutio kommen etwa vier Begleiter ohne Elitestatus. Sie laufen zum Grab, statt an Ort und Stelle zu erscheinen.",
	-- ["Cross the river west to {npc:1855}'s hut."] = "Überquere den Fluss nach Westen zu {npc:1855}s Hütte.",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Durchquere den Süden des Kraters zu {npc:9619} an der Rampe.",
	-- ["Diseased Wolves"] = "Kranke Wölfe",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Baggerbrecher graben weiter westlich; Steinpanzerzangen, Steinpanzerschinder und Felspirscher jagen im selben Sand.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Baggerschläger graben in den Dünen nordwestlich der Burg; Steinpanzerskorpide und Sandhuscher streifen überall umher.",
	-- ["Eastern Pylon and the crate"] = "Östlicher Pylon und die Kiste",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Endet bei {npc:9298} in {area:618}: Behalte es",
	-- ["Ends with {npc:9298} in {zone:1452}: keep it"] = "Endet bei {npc:9298} in {zone:1452}: Behalte es",
	-- ["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- ["Fly from {area:976} to {area:541}. {npc:8737} stands at the back of the refuge; {npc:9117} is in the cave behind him.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Flieg von {area:976} nach {area:541}. {npc:8737} steht hinten in der Zuflucht; {npc:9117} ist in der Höhle hinter ihm.\n{npc:9999}, der Freund von {npc:9997}, wird vermisst.",
	-- ["Fly to Theramore"] = "Flieg nach Theramore",
	-- ["Fly to {area:2255}"] = "Flieg nach {area:2255}",
	-- ["Fly to {area:2268}"] = "Flieg zur {area:2268}",
	-- ["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- ["Fly to {area:392}."] = "Flieg nach {area:392}.",
	-- ["Fly to {area:541}"] = "Flieg nach {area:541}",
	-- ["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- ["For the druids of {zone:1457}: keep it"] = "Für die Druiden von {zone:1457}: Behalte es",
	-- ["For {area:1377}: keep it"] = "Für {area:1377}: Behalte es",
	-- ["For {area:3197}: keep it"] = "Für {area:3197}: Behalte es",
	-- ["For {zone:1448}: keep it"] = "Für {zone:1448}: Behalte es",
	-- ["For {zone:1451}: keep it"] = "Für {zone:1451}: Behalte es",
	-- ["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Reite von Theramore nach Westen in {zone:1413} und die Küste nach Norden hinauf bis {area:392}.",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Flieg von {area:392} nach {area:2255} und reite nach Süden zum {area:2250}.",
	-- ["From {area:702}, fly to {area:1116}."] = "Flieg von {area:702} zur {area:1116}.",
	-- ["Hearth to {area:392} (bound there earlier on this guide), then fly on to {area:976}."] = "Benutze den Ruhestein nach {area:392} (früher in diesem Guide dort gebunden) und flieg dann weiter nach {area:976}.",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Horgus' Schädel liegt am {area:2624} und Marduks Schwert im Gebiet {area:2623}, jeweils dort, wo Geister kämpfen; ausgewachsene Seuchenhunde jagen auf den Ebenen dazwischen.",
	-- ["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan."] = "Wenn du The {item:9328} übersprungen hast, grinde hier bis Stufe 56,89, um im Plan der Route zu bleiben.",
	-- ["Into {zone:1451}"] = "Nach {zone:1451}",
	-- ["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Führ {npc:7774} im Schritttempo zurück zu {npc:7765}: Sie läuft immer wieder davon, also läute die Glocke, um sie zurückzurufen (nicht im Kampf), und räume die Harpyien auf dem Weg, bevor sie sie erreicht.",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führ {npc:9999} nach Norden nach {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",
	-- ["Level 56.89"] = "Stufe 56,89",
	-- ["MacDonnell's next task, {area:201}'s cauldron, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "MacDonnells nächste Aufgabe, der Kessel bei {area:201}, wartet auf den Abschnitt in den Pestländern im {zone:1451}-Guide: Nimm sie dann an.",
	-- ["More watches"] = "Mehr Uhren",
	-- ["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "Noch keine {quest:5401} ({spell:437801} gibt sie dir auf dem Weg des Guides für {zone:1452})? Pureheart gibt dir hier eine: Die Quests für die Geißelsteine brauchen sie.",
	-- ["North to the refuge, for the quests the first Un'Goro visit left: {npc:9618} stands just outside and {npc:9117} in the cave at the back; the expedition's other three wait for your next stop here."] = "Nach Norden zur Zuflucht, für die Quests, die vom ersten Besuch in Un'Goro übrig sind: {npc:9618} steht direkt draußen und {npc:9117} in der Höhle hinten; die anderen drei der Expedition warten auf deinen nächsten Halt hier.",
	-- ["Northern Pylon"] = "Nördlicher Kristallpylon",
	-- ["On {npc:7583}"] = "Bei {npc:7583}",
	-- ["Ranshalla in {zone:1452}: keep it"] = "Ranshalla in {zone:1452}: Behalte es",
	-- ["Ride back south to the camp."] = "Reite zurück nach Süden zum Lager.",
	-- ["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Reite zurück nach Südwesten zum Turm von {area:2742} in {area:2738}; klettere hinauf und töte die Angreifer, die beim Verkrusteten Silithidenobjekt auftauchen.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Reite zurück zum {area:3197} und flieg zum Ort {area:150}, nimm das Boot nach {area:442} und flieg nach {area:702}; das Portal führt hinauf nach {zone:1457}.",
	-- ["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Reite zurück nach {area:3425}. {npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Reite die Rampe hinab in den Krater: {npc:9619} lagert an ihrem Fuß.",
	-- ["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Reite nach Osten zum Grenzfluss: {npc:1855} lebt in einer kleinen Hütte am Ufer.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Reite nach Osten zum Turm von {area:2742} in {area:2738}; klettere hinauf und töte die Angreifer, die beim Verkrusteten Silithidenobjekt auftauchen.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Reite nach Osten zum {area:1943}, wo der Roboter zwischen den Gorillas steht. Bleib dort aus der tiefen Höhle fern.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Reite nach Osten zum {area:537}, klettere hinauf und benutze {npc:10541} an den Lavaschloten nahe dem Gipfel.",
	-- ["Ride east to {npc:13220}."] = "Reite nach Osten zu {npc:13220}.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Reite an der Ostseite nach Norden zum Gorillaplateau. {npc:9622}, ein Gorilla der Stufe 55, sitzt in dessen tiefster Höhle: Säubere zuerst die Gorillas am Höhleneingang.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Reite nach Norden nach {area:2627}. {npc:12384} lebt in der zerstörten Hütte, sein Quittungsbuch liegt im zerstörten Gasthaus in der Nähe.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\nCareful: the Frenzied Plaguehounds north-east of the hut are 57-58, a level or two over you: pull them one at a time."] = "Reite nach Norden nach {area:2627}. {npc:12384} lebt in der zerstörten Hütte, sein Quittungsbuch liegt im zerstörten Gasthaus in der Nähe.\nVorsicht: Die Rasenden Seuchenhunde nordöstlich der Hütte sind 57-58, eine oder zwei Stufen über dir: Pulle sie einzeln.",
	-- ["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Reite nach Nordwesten zu Dalsons Hof. Das Tagebuch liegt in der Scheune; ein umherwanderndes Skelett trägt den Schlüssel für das Nebengebäude, und {npc:10836} wartet im Nebengebäude mit dem Schrankschlüssel.",
	-- ["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Reite weiter nach Westen bis {area:3425}. {npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- ["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "Reite durch den nordwestlichen Pass des Kraters hinaus nach {zone:1451}: {npc:13220} steht bei {area:3077}, wo der Pass herauskommt.",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Reite nach Süden nach {area:201}, wo {npc:11078} den Kessel bewacht.",
	-- ["Ride south-west to the camp."] = "Reite nach Südwesten zum Lager.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Reite nach Südwesten zum Lager von {npc:7771} bei {area:1938}.",
	-- ["Ride west along the road to the hot springs."] = "Reite auf der Straße nach Westen zu den heißen Quellen.",
	-- ["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Reite nach Westen in die Ruinen von Rabenwind: {npc:7774} versteckt sich im kleinen runden Gebäude ganz hinten. Öffne die Truhe neben ihr für {item:9189}: Es hält 15 Minuten, genau wie die Quest.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Reite nach Westen an {area:541} vorbei und an der Westseite nach Süden zu {area:543}: {npc:10302}, der Goblin, sitzt am Wasser.",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Reite nach Westen ins {area:2627}. Kleine Seuchenhunde, Seuchenfledermäuse und Aaslarven streifen durch seine Wälder; füll {item:15042} an den großen Termitenhügeln und töte weiter nördlich die Rasenden Seuchenhunde.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Verscheuche {npc:7583} mit {item:12928}",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Skelettschinder und Sabbernde Ghule streifen über die Felder nördlich des Lagers; die ganze Geißel hier droppt Geißelsteine.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Skeletal Flayers und Slavering Ghouls streifen über die Felder nördlich des Lagers; alle Geißel-Mobs hier lassen Geißelsteine (Scourgestones) fallen.\nVorsicht: Diese Untoten bemerken dich schon von weitem, und weitere Untote in der Nähe schließen sich dem Kampf an, wenn einer gepullt wird.\nVorsicht: Das {npc:10411} (3 Spawns, 15 Min. Respawn) wird unsichtbar, wenn es nicht im Kampf ist, und ruft Rockwing Gargoyles, sobald ein Kampf beginnt.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Kleine Schließkassetten liegen überall in Andorhal im Schutt; in jeder steckt eine Uhr.",
	-- ["Take the boat to the mainland and ride north-east past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Nimm das Boot zum Festland und reite nach Nordosten an den {area:1119} vorbei zu {npc:7775}s Lager. Er braut das {item:11243} aus einer {item:11242}: Nimm seinen Auftrag dafür an.",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Nimm das Boot zum Festland und reite nach Nordosten zu {npc:14637}s Lager beim Ort {area:1119}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Tar Beasts suhlen sich im {area:538}; die Feuerelementare von {area:537} in der Mitte tragen die Asche; die Gorishi-Wespen des {area:540} im Süden tragen die Drüse. Jede Kreatur im Krater kann {item:11018} fallen lassen.\nVorsicht: Gorishi Workers, die unter 45 % Gesundheit fallen, rufen mit 50 % Wahrscheinlichkeit Verbündete in 25 yd Umkreis zu Hilfe.",
	-- ["Temple of the Moon"] = "Der Tempel des Mondes",
	-- ["Ten {item:11040} from the {item:11020}"] = "Zehn {item:11040} aus dem {item:11020}",
	-- ["The Gorishi hive"] = "Der Gorishi-Bau",
	-- ["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Die Teerbestien und Teerlords suhlen sich in den {area:538}, südlich der Zuflucht auf dem Weg hinab in den Krater.",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Der Kessel bietet jetzt eine eigene Aufgabe an; die Skelette um ihn herum droppen Knöcherne Aufstachler.",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Der Kessel steht am Ort {area:202}, bei {npc:10739}' Hof.",
	-- ["The crater"] = "Der Krater",
	-- ["The fields"] = "Die Felder",
	-- ["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "Der Riese {npc:7765} sitzt gleich nordwestlich vom Lager von {npc:7775}.",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Die Gorillas leben auf {area:1943}, östlich von {area:541}. Behalte ihre Felle für {npc:9619}. Halte dich aus der tiefsten Höhle fern: {npc:9622} ist Stufe 55.\nVorsicht: Un'Goro Gorillas (Stufe 50-51) rufen Verbündete in 20 yd Umkreis zu Hilfe, sobald sie auf 25 % Gesundheit fallen. In der Gegend gibt es eine Höhle voller Affen, und ein Kampf dort bringt viele Adds.",
	-- ["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Die Gorillas leben auf dem {area:1943}, gleich östlich des Pylons: Sammle die Felle für {npc:9619} jetzt, solange du hier oben bist. Halte dich von der tiefsten Höhle fern: {npc:9622} ist Stufe 55.\nVorsicht: Un'Goro-Gorillas (Stufe 50-51) rufen Verbündete im Umkreis von 20 Metern zu Hilfe, sobald sie auf 25 % Gesundheit fallen. In der Gegend gibt es eine Höhle voller Affen, und Kämpfe dort ziehen viele zusätzliche Gegner an.",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Der nächste Guide beginnt hier in {area:392} und fliegt weiter nach {area:976}.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Die Felle kommen nach Runde 2, auf dem Gorillaplateau",
	-- ["The pelts come from the gorillas on {area:1943}"] = "Die Felle stammen von den Gorillas auf {area:1943}",
	-- ["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "Der Pylon steht auf den östlichen Klippen über dem Bau von {npc:9684}; die {item:11113} der Expedition steht im verlassenen Lager im östlichen Dschungel.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}."] = "Der Pylon steht am Hang östlich der Zuflucht. {npc:9166} kreisen über den Hängen ringsum: Sie zählen für {npc:9997}.",
	-- ["The pylon stands on the western cliffs."] = "Der Pylon steht auf den westlichen Klippen.",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Die geschrumpften Riesen streifen durch das Gebiet {area:1119}; die Meereselementare waten westlich davon an der Küste entlang.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Die Gequälten Druiden und Schildwachen spuken im verfallenen Südwindposten südwestlich von {npc:13220}.",
	-- ["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- ["The {area:2742} tower"] = "Der Turm von {area:2742}",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "Die {item:11242} wächst in einem zerfallenen Gebäude nördlich von {npc:7765}: Kletter vom Felsvorsprung daneben durch das Loch in der Wand hinein.",
	-- ["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "Der {item:280417} liegt ein kurzes Stück westlich von {npc:9619}s Lager.",
	-- ["Umber in {area:493}: keep it"] = "Umber in {area:493}: Behalte es",
	-- ["Umber in {zone:1450}: keep it"] = "Umber in {zone:1450}: Behalte es",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Benutze den {item:12627} bei den Getreidesilos, um Temporale Parasiten hervorzulocken. {quest:5154} ist einer der muffigen Folianten im Rathaus. Jedes Skelett in der Stadt droppt {quest:5537}.",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "Benutze den {item:12627} bei den Getreidesilos, um Temporale Parasiten hervorzulocken. {quest:5154} ist einer der muffigen Folianten im Rathaus. Jedes Skelett in der Stadt droppt {quest:5537}.\nVorsicht: Die Temporalen Parasiten sind 55-57, und Skelettkriegsherren und Fleischgolems (57, Elite) laufen durch die Straßen: Lock die Parasiten einzeln bei den Silos hervor und lass die Elites vorbeiziehen.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Benutze die {item:12815} am Fuß jedes der vier Wachtürme rund um den Rand von Andorhal, nördlich des Lagers.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Benutze die {item:12815} am Fuß jedes der vier Wachtürme am Rand von Andorhal, nördlich des Lagers.\nVorsicht: Skelettkriegsherren und Fleischgolems (57, Elite) laufen durch Andorhals Straßen, und der {npc:7572} (59, Elite) wandert zwischen Andorhal und Nordgrat umher: Bleib bei den Türmen am Stadtrand und lass sie vorbeiziehen.",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Geh in die {area:1769} und nimm den Tunnelzweig nach {area:493} bis nach {area:2361}.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Geh in die {area:1769} und nimm den Tunnelzweig nach {zone:1450} bis nach {area:2361}.",
	-- ["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Nach Westen durch den Süden des Kraters: Dinosaurierknochen liegen im Südwesten zwischen den Stegodons auf dem Boden: Die sind Elite, sammle die Knochen um sie herum auf und hol dir den Rest von den Diemetradons. Die {item:11112} der Expedition liegt im südwestlichen Dschungel.",
	-- ["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Nach Westen am Südrand des Kraters entlang: Der Gorishi-Bau füllt ihn. Benutze die Schabphiole an einer Brutstätte, einer Kammer mit hängenden Larven.",
	-- ["Western Pylon"] = "Westlicher Kristallpylon",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.",
	-- ["Zapped giants and sea elementals"] = "Geschrumpfte Riesen und Meereselementare",
	-- ["grind on {npc:11740}"] = "Grinde an {npc:11740}",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "grinde an {npc:1796} am Ort {area:202}, {zone:1422}",
	-- ["their trainers are in {zone:1457} too"] = "ihre Lehrer sind ebenfalls in {zone:1457}",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: Töte diese, sobald sie dir begegnen",
	-- ["{area:1942}: kill these as you meet them"] = "{area:1942}: Töte sie, wenn du ihnen begegnest",
	-- ["{area:1943}: kill these as you meet them"] = "{area:1943}: Töte diese, wenn du ihnen begegnest",
	-- ["{area:200} cauldron"] = "Kessel bei {area:200}",
	-- ["{area:201} cauldron"] = "Kessel bei {area:201}",
	-- ["{area:348} flight master"] = "Flugmeister von {area:348}",
	-- ["{area:392} flight master"] = "Flugmeister in {area:392}",
	-- ["{area:442} flight master"] = "Flugmeister von {area:442}",
	-- ["{area:489} flight master"] = "Flugmeister von {area:489}",
	-- ["{area:538}: kill these as you meet them"] = "{area:538}: Töte sie, wenn du ihnen begegnest",
	-- ["{area:976} flight master"] = "Flugmeister von {area:976}",
	-- ["{item:11478}; below ground"] = "{item:11478}; unterirdisch",
	-- ["{item:11479}; below ground"] = "{item:11479}; unterirdisch",
	-- ["{item:11480}; below ground"] = "{item:11480}; unterirdisch",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} liegt im Rathaus von {area:190}, westlich von {npc:1855}: Die scharlachroten Wachen stehen dicht beieinander.",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} liegt östlich der Scheune bei {area:201}.",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}, von {npc:11056}",
	-- ["{item:14613}, from {npc:11886} (57, elite): grouping up is advised"] = "{item:14613}, von {npc:11886} (57, Elite): Eine Gruppe wird empfohlen",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: Ihre Eskorte kommt später auf der Route",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} wartet im zerstörten Gasthaus auf der Westseite von Andorhal.",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} steht beim Hof am Ort {area:202}, nordöstlich der Felder.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}s Geist wandert beim Bauernhaus im {area:199} umher, westlich von {area:200}; ihr Paket liegt drinnen.",
	-- ["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} und {npc:7740} stehen beim Tempel des Mondes; fülle {item:11682} am Mondbrunnen darin.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path now; the {zone:2482} guide flies to {area:493}, and the {zone:1451} guide comes back here."] = "{npc:10897}, der Flugmeister von {area:493}, steht südlich des Sees, außerhalb von {area:2361}: Lerne jetzt die Flugroute; der Guide für {zone:2482} fliegt nach {area:493}, und der Guide für {zone:1451} kommt hierher zurück.",
	-- ["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}s Bauernhaus steht auf dem Hügel östlich des Lagers; das Denkmal von {npc:10936} liegt gleich nördlich davon.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, bei den Gräbern südlich der Kapelle",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} bewacht den Kessel im {area:199}, westlich von Andorhal.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} steht bei der Hütte von Augustus im {area:2627}.",
	-- ["{npc:11610}'s next task, {npc:11613} and {npc:11611}, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "{npc:11610}s nächste Aufgabe, {npc:11613} und {npc:11611}, wartet auf den Abschnitt in den Pestländern im {zone:1451}-Guide: Nimm sie dann an.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} läuft durch das Holzlager Northridge östlich von {npc:11610}; {npc:11611} bewacht den Turm am südlichen Zugang von {area:190}.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} läuft durch das Lager von Northridge östlich von {npc:11610}; {npc:11611} bewacht den Turm an der südlichen Zufahrt von {area:190}.\nVorsicht: Wachen stehen am Fuß des Turms, und eine weitere kreist patrouillierend um ihn. Räume sie, bevor du Durgen angreifst, damit sie sich dem Kampf nicht anschließen.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: Die Termiten kommen später, im {area:2627}",
	-- ["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} läuft hier umher: Schau in den Kreis auf der Karte",
	-- ["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} ist Elite: Eine Gruppe wird empfohlen",
	-- ["{npc:12384} lives in the ruined hut in {area:2627}, and his receipt book lies in the ruined inn nearby. {npc:11140} stands by {npc:12384}' hut."] = "{npc:12384} lebt in der zerstörten Hütte im {area:2627}, und sein Quittungsbuch liegt im zerstörten Gasthaus in der Nähe. {npc:11140} steht bei der Hütte von {npc:12384}.",
	-- ["{npc:15189}'s and {npc:15191}'s next tasks (the Stonelash scorpids and the Dredge Crushers) wait for the {zone:1451} guide's {area:3425} stop: take them then."] = "Die nächsten Aufgaben von {npc:15189} und {npc:15191} (die Steinpeitschenskorpide und die Baggerbrecher) warten auf den Halt in {area:3425} im Guide für {zone:1451}: Nimm sie dann an.",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, bei den Zelten der Allianz",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} ist Elite: Eine Gruppe wird empfohlen. Er bewacht sein Phylakterium in der Mitte von Andorhal.",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852} ist Elite: Eine Gruppe wird empfohlen. Er bewacht sein Phylakterium mitten in Andorhal.\nKleine Schließkassetten liegen überall in den Trümmern von Andorhal; jede enthält eine Uhr.\nVorsicht: Ghule und Skelette stehen meist neben den Kassetten und greifen an, wenn du nahe kommst. Searing Ghouls verletzen außerdem jeden in der Nähe und brechen die Tarnung.",
	-- ["{npc:5411} in {area:976}: keep it"] = "{npc:5411} in {area:976}: Behalte es",
	-- ["{npc:5594}, inside"] = "{npc:5594}, drinnen",
	-- ["{npc:5901}, on the coast north of town"] = "{npc:5901}, an der Küste nördlich der Stadt",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: Behalte es für {area:976}",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "{npc:7775}s Lager liegt nördlich vom Ort {area:1119}. Er braut das {item:11243} aus einer {item:11242}: Nimm seinen Auftrag dafür an.",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}s Lager liegt nördlich vom Ort {area:1119}. Er verkauft das {item:11243}, sobald er seinen Köder hat.",
	-- ["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "{npc:7876}, Nordseite der Stadt: Der Teer ist in Un'Goro, behalte ihn",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: Behalte es für {area:440}",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: Behalte es für {zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: Behalte es für Un'Goro",
	-- ["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}: Behalte es für Un'Goro; drinnen",
	-- ["{npc:8598}, 170 yd north-east"] = "{npc:8598}, 170 yd nordöstlich",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}, im Gebiet {area:1658}",
	-- ["{npc:9117}, below ground"] = "{npc:9117}, unter der Erde",
	-- ["{npc:9299} in {area:976}: keep it"] = "{npc:9299} in {area:976}: Behalte es",
	-- ["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} ist ein Geist auf dem Friedhof direkt östlich der Stadt: Trink dort ein {item:11243}, das dich tötet, lass deinen Geist frei und sprich als Geist mit ihm. Lauf dann zurück zu deinem Körper, um wiederbelebt zu werden: Der Grabstein steht in der Nähe.",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} wartet auf dem Friedhof gleich östlich des Orts; der Grabstein steht in der Nähe.",
	-- ["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} lagert am Fuß der Rampe in den Krater.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Der Bau von {npc:9684} liegt im Dschungel nördlich von {npc:9619}, unterhalb der östlichen Klippen: Benutze dort {item:11568}. {npc:9684} ist Stufe 56: Fang mit voller Gesundheit an.",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} sitzt am Südosthang des {area:537}, in der Mitte des Kraters.",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}, im Bauernhaus",
	-- ["{object:177667}, below ground"] = "{object:177667}, unterirdisch",
	-- ["{object:179565}; inside"] = "{object:179565}; drinnen",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} ist in {area:392}",
	-- ["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, falls du sie noch vom ersten Besuch hast",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} in {area:493}: Behalte es",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} in {zone:1450}: Behalte es",
	-- ["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, falls ein Ravasaurus seit dem ersten Besuch die Schuppe fallen gelassen hat",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}: Töte sie, wenn du ihnen begegnest",
	-- ["{zone:1451}: kill these as you meet them"] = "{zone:1451}: Töte sie, wenn du ihnen begegnest",
	-- ["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, wo im nächsten Guide trainiert wird, hat keinen Druidenlehrer",
}
