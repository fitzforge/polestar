-- German (deDE): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands · {zone:1448} Felwood · {zone:1452} Winterspring
	["Western & {zone:1423}, {zone:1448} & {zone:1452}"] = "",

	-- Step 1: The Bulwark
	-- {area:199} Felstone Field · {area:152} The Bulwark · {npc:11055} Shadow Priestess Vandis
	["Back west along the road from {area:199} to the {area:152}: {npc:11055} takes the cauldron's report."] = "",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: his termites are in {area:2627}, later in this guide"] = "",

	-- Step 2: Dalson's Tears
	-- {area:199} Felstone Field · {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road past {area:199}, {npc:11077} guards the cauldron at {area:200}: kill him for the key, then use the cauldron."] = "",

	-- Step 4: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Wachtürme und Silos von Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord
	["Ride south-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites (55-57): fight them one at a time and let the biggest go.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room.\nCareful: Skeletal Warlords, level 56-57 elites, stand by the first and second towers (the south-western and the western one): mark those towers from the far side of the doorway once the Warlord has turned away, and never pull one. Putridius (58, rare) walks among the silos."] = "",
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

	-- Step 5: Chromie
	["Upstairs"] = "Im Obergeschoss",

	-- Step 6: Counting Out Time
	-- {npc:10667} Chromie · {npc:1805} Flesh Golem
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth. A {npc:1805}, a level 56-57 elite, stands among the houses just east of the inn: take the boxes on the west side first and keep clear of it."] = "",

	-- Step 9: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "Nach Westen zu {area:152}.",

	-- Step 10: Apothecary Dithers
	-- {quest:838} Scholomance · {area:152} The Bulwark
	["Derrington's {quest:838} is offered from level 55: still under 55 here, the next {area:152} stop offers it again."] = "",

	-- Step 11: Skeletal Fragments
	-- {area:152} The Bulwark
	["The skeletons on the fields east of the {area:152} drop the fragments: take them on the ride east."] = "",

	-- Step 12: Target: Writhing Haunt
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt · {npc:11076} Cauldron Lord Razarch
	["East past {area:200} to the {area:202}: {npc:11076} guards its cauldron."] = "",
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark · {zone:1423} Eastern Plaguelands
	["from the cauldron, for {npc:11055} at the {area:152}: on the way back west, after the {zone:1423}"] = "",

	-- Step 13: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.",
	["Inside"] = "Drinnen",

	-- Step 16: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it."] = "",

	-- Step 17: Diseased Grizzlies
	["Diseased Grizzlies"] = "Kranke Grizzlys",
	["Careful: the grizzlies are 55-56: pull them one at a time."] = "",

	-- Step 19: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Nach {zone:1423}",

	-- Step 20: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "Reite auf der Straße nach Osten in die {zone:1423}. {npc:1855} wohnt in einem kleinen Haus am {area:2619}, direkt nördlich der Straße an der Grenze; seine drei Jagdaufträge liegen im Gebiet dieses Guides.",

	-- Step 22: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "Folge der Straße von den {zone:1422} nach Osten, über den Fluss und quer durch die gesamten {zone:1423}, bis zur Kapelle der {object:92525} im äußersten Osten.",

	-- Step 23: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "Der Geist von {npc:10926} steht in den Ruinen von {area:2262}, im Südwesten.",

	-- Step 24: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "Der Kopf der Puppe und ihre beiden Hälften liegen in den Häusern rund um {npc:10926}; füge sie aus deinen Taschen zusammen.",

	-- Step 25: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "eine Nachricht für {npc:11063} in der {area:2268}",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Behalte {quest:5152}: {npc:10927} wohnt am {area:197} in den {zone:1422}.",

	-- Step 26: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "Zaeldarr lauert gleich westlich von {area:2262}.",
	["Below ground"] = "Unter der Erde",

	-- Step 27: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Vorsicht: {npc:10411} wird außerhalb des Kampfes unsichtbar und ruft Felsschwingengargoyles herbei, sobald ein Kampf beginnt. Es gibt nur 3, und sie erscheinen alle 15 Min. neu.",

	-- Step 28: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Zurück zur {area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "Die Geister für {quest:5211} kommen mit dem Halt bei {area:2264} später in diesem Guide: Behalte sie.",

	-- Step 29: Caretaker Alen
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls · {spell:437801} Light's Hope
	["{npc:11038} offers {quest:5281} from level 55; under it, the next {spell:437801} stop offers it again."] = "",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}: for {npc:11140} in {area:2627} later in this guide"] = "",

	-- Step 30: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Flugmeister in {area:2268}",

	-- Step 31: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "Zum {area:197}",

	-- Step 32: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Reite von {area:272} die Straße nach Norden hinauf. Das Haus von {npc:10927} steht an der Straße am {area:197}, und das Denkmal von {npc:10936} ist auf dem Friedhof dahinter.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, im Obergeschoss",

	-- Step 33: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Reite nach Nordwesten nach Andorhal. {npc:10667} wartet im zerstörten Gasthaus auf der Westseite der Stadt; die Skelette darin sind Stufe 54-57, also halte dich an die Ränder.",

	-- Step 34: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "Die Annalen liegen zwischen den Modrigen Folianten im Rathaus von Andorhal; öffne sie, bis du den richtigen findest.\nVorsicht: Ein {npc:10996}, ein Elite der Stufe 58-59, kann in Andorhal stehen, wie an vielen anderen Stellen der {zone:1422}: Halte Abstand.",

	-- Step 36: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Flieg zur {area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "Reite zurück nach Süden nach {area:272} und flieg zur {area:2268}.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Flugmeister von {area:272}",

	-- Step 37: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls
	["{npc:11038}, if you didn't take {quest:5281} on the last stop"] = "",
	-- {npc:11063} Carlin Redpath · {area:190} Hearthglen
	["{npc:11063}'s Heroes of Darrowshire needs a group in {area:190} and a ride back here at the end: leave it."] = "",

	-- Step 38: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: Töte sie, wenn du ihnen begegnest",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "Seuchenhunde und ihre kleinen Artgenossen streifen an den Ufern des Sees südwestlich der Kapelle umher; Seuchenfledermäuse und Aaslarven teilen sich das Gelände. Vorsicht: Die größten Seuchenhunde sind Stufe 56, zieh sie einzeln.\nDas zerbrochene Schwert liegt am Boden nordwestlich des Sees.",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His Ranger hunt (Rangers 59-60, in the north) is above you on this trip: leave it."] = "",

	-- Step 40: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Kleine Seuchenhunde und Seuchenfledermäuse streifen durch die Hügel nördlich von {area:2260}, Aaslarven kriechen zwischen ihnen; arbeite dich nach Norden Richtung {area:2627} vor.",

	-- Step 41: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "Der Geist {npc:11140} steht bei einer Hütte im {area:2627}, in der Nordwestecke; {npc:12384} sitzt in der Hütte.",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}, drinnen",

	-- Step 42: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}: Töte diese, wenn du ihnen begegnest",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "Das Buch liegt im zerstörten Gasthaus von {area:2627}; die Untoten im Ort sind Stufe 54-56, also zieh sie einzeln.\nDie Großen Termitenhügel stehen überall in den Hügeln östlich von {area:2627}. Benutze {item:15042} an jedem Hügel, an dem du vorbeikommst.\nVorsicht: Zigguratbeschützer (58, Elite) stehen bei den Zikkuraten östlich und nordöstlich des Orts: Nimm die Hügel näher am Ort und halte dich von ihnen fern.",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}: Die Untoten von {area:2627} lassen sie fallen, solange du {item:12846} trägst",

	-- Step 43: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Keep the termites: {npc:11615} at the {area:152} takes them on this guide's ride back west."] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: Töte sie, wenn du ihnen begegnest",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the Monstrous Plaguebats up to 58: take the 57s one at a time and leave the 58s."] = "",

	-- Step 45: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Der Schädel liegt in {area:2622}, zwischen Verseuchten Schrecken und Seuchenmonstern.",
	["Underwater"] = "Unter Wasser",

	-- Step 46: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Reite auf der Straße nach Süden zu {area:2264}. {item:15447} verdirbt binnen zehn Minuten: Töte die Geißel des Orts zügig und zerreibe die sieben Stücke sofort mit {item:15454}.\nVorsicht: Ungesehene Diener rufen im Umkreis von 25 Metern um Hilfe, sobald sie auf 40 % Gesundheit fallen. Außerhalb des Kampfes werden sie außerdem mit {spell:10228} unsichtbar. Wenn innerhalb des Orts um Hilfe gerufen wird, können sich sehr viele Gegner dem Kampf anschließen. Am Ortsrand zu kämpfen senkt dieses Risiko.\nMit {quest:5211} in deinem Questlog (von {npc:11063} zu Beginn dieses Guides) hinterlässt die Geißel rund um den Ort Geister von Darrowshire: Sprich jeden an, um ihn zu befreien. Befreie sie, bevor du mit {item:15447} anfängst.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Befreie Geister von Darrowehr: Sprich mit ihnen",

	-- Step 47: Carlin Redpath
	-- {area:2268} Light's Hope Chapel
	["Ride east along the road to {area:2268}."] = "",

	-- Step 48: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride back west along the road to the {area:2260}."] = "",

	-- Step 49: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride north-west to {npc:1855}'s hut by the {area:2619} and hear him out."] = "",

	-- Step 50: Undercroft
	-- {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft · {area:2260} Marris Stead
	["{npc:11886} lurks in the {area:2261}, the crypt just south of the {area:2260}.\nCareful: about four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 51: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Back north-west to {npc:1855}'s hut."] = "",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next errand, Of Lost Honor, leads into the Mossflayer trolls (57-59) of the far north-east: leave it."] = "",

	-- Step 52: Kirsta Deepshadow
	-- {npc:1855} Tirion Fordring · {zone:1422} Western Plaguelands · {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp · {area:152} The Bulwark
	["Ride west from {npc:1855}'s hut into the {zone:1422}: {npc:11610} hides on the hill north-east of the {area:192}, on the way to the {area:152}."] = "",
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Her Scarlets wait until {npc:11615} has given you the termite barrel at the {area:152}: the barrel goes down in the same lumber mill."] = "",

	-- Step 54: The Bulwark
	-- {area:152} The Bulwark
	["On west to the {area:152}."] = "",

	-- Step 56: High Executor Derrington
	-- {area:152} The Bulwark · {quest:838} Scholomance · {quest:964} Skeletal Fragments · {area:201} Gahrron's Withering
	["Under 55 on the first {area:152} stop? Derrington's {quest:838} is offered now: Dithers' {quest:964} come from the skeletons on the ride back west from {area:201}."] = "",

	-- Step 58: Scarlet Crusade
	["Scarlet Crusade"] = "Scharlachroter Kreuzzug",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Back north-east to the {area:192}: knights and magi work the camp, the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "",

	-- Step 60: Radley and Durgen
	["Radley and Durgen"] = "Radley und Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} steht östlich des Holzfällerlagers; {npc:11611} bewacht die Straße nordöstlich von {npc:11610}, in Richtung {area:190}.\nVorsicht: Wachen stehen am Fuß des Turms, und eine weitere kreist auf Patrouille darum. Räume sie weg, bevor du Durgen angreifst, damit sie nicht in den Kampf eingreifen.",

	-- Step 61: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11610}'s last errand looks over {area:190}, among Scarlets of 58-60: leave it."] = "",

	-- Step 62: Target: Gahrron's Withering
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south-east to {area:201}, the farm under the eastern hills: {npc:11078} (58) guards its cauldron. Kill him for the key, then use the cauldron.\nCareful: Soulwrath is about two levels over you here: clear the ghouls around the cauldron first, start at full health and use your cooldowns on him."] = "",

	-- Step 63: Skeletal Fragments
	-- {area:200} Dalson's Tears · {area:199} Felstone Field
	["On the ride back west, the skeletons on the fields around {area:200} and {area:199} (50-53) drop the fragments."] = "",

	-- Step 64: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "Noch einmal nach Westen zu {area:152}.",

	-- Step 66: Class trainer
	["Class trainer"] = "Klassenlehrer",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Train before the flight."] = "",

	-- Step 67: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {area:1638} Thunder Bluff · {quest:1000} The New Frontier · {zone:1452} Winterspring · {quest:1123} Rabine Saturna · {zone:1450} Moonglade · {zone:1451} Silithus
	["Only if {area:1638}'s {quest:1000} is still open for you (the {zone:1452} guide's stop offers it from level 54): it opens {quest:1123} in {zone:1450} and her {zone:1451} chain, so fly there first."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 68: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Flieg nach {area:431}",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Then the flight master."] = "",

	-- Step 69: Fly to Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop. Then the flight master."] = "",

	-- Step 70: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033} (Druiden) lehrt auf {area:1639}, {npc:246344} (Paladine) ebenfalls in der Stadt.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} auf der {area:1639}; {npc:246344}",

	-- Step 71: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {area:1641} Hunter Rise
	["{npc:10881} stands on {area:1641}."] = "",

	-- Step 72: Arch Druid Hamuul Runetotem
	-- {area:1639} Elder Rise
	["Hamuul is on {area:1639}."] = "",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} is in {zone:1450}, later in this guide."] = "",

	-- Step 73: Fly to Splintertree Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 74: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "",
	-- {npc:10922} Greta Mosshoof · {zone:1413} Barrens
	["{npc:10922}: the Cleansed Water from Islen in the {zone:1413}"] = "",

	-- Step 75: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in linked groups, many with stuns: pull them one group at a time."] = "",

	-- Step 76: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Zurück nach Süden zum Refugium, ein kurzer Ritt.",

	-- Step 77: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} (57) wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9529} Maybess Riverbreeze
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["Corrupted Soul Shards from the cultists, for {npc:9529}' Salve via Hunting"] = "",

	-- Step 78: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Enforcers = {npc:7114} Jaedenar Enforcer
	["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Ein {item:13140} ist gedroppt: Die Vollstrecker von Jaedenar, Darkweavers, Hexenmeister und Legionäre der Schattenfeste tragen ab und zu einen. Benutze ihn, um die Quest zu starten, und befreie dann auf dem Rückweg {npc:11018} aus ihrem Käfig im Südende der Höhle.",

	-- Step 79: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "{npc:11016}, unterirdisch",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}: lead her out of {area:1770}"] = "",

	-- Step 80: Rescue From Jaedenar
	-- {npc:11018} Arko'narin · {npc:11019} Jessir Moonbow · {area:2479} Emerald Sanctuary
	["Lead {npc:11018} out through the cave: she fights beside you, and the cultists you didn't clear on the way in come at you both. {npc:11019} takes her report at the {area:2479}, next."] = "",
	-- {area:1770} Shadow Hold
	["out of {area:1770}, at its mouth"] = "",

	-- Step 81: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["Back south to the Sanctuary: {npc:9529} takes the shards on the west side of the camp."] = "",

	-- Step 83: Jessir Moonbow
	-- {npc:11019} Jessir Moonbow · {npc:11018} Arko'narin
	["{npc:11019}, at the Sanctuary's east side, takes {npc:11018}'s report."] = "",
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {area:1763} Jaedenar · {zone:1448} Felwood
	["{npc:11019}: {npc:9518}, in {area:1763}, on the last guide's ride north through {zone:1448}"] = "",

	-- Step 84: Deadwood Cauldron
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	-- was: ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Reite die Straße nach Norden. Der Kessel steht in {area:1762}, direkt südwestlich von {area:1769}; die Deadwood-Furbolgs dort sind feindlich."
	["Ride north up the whole {zone:1448} road, past {area:1997}. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 85: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {area:1769} Timbermaw Hold · {npc:11558} Kernda · {zone:1448} Felwood
	["Only if a {quest:8471} dropped for you and you are Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): {npc:11558} waits at the {zone:1448} entrance of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} läuft hier herum: schau in den Kreis auf der Karte",

	-- Step 87: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {quest:5527} A Reliquary of Purity · {area:2577} Dire Maul
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}.\n{npc:11801} offers {quest:5527} only after you have been inside {area:2577} once: if he doesn't offer it, carry on without it."] = "",

	-- Step 88: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Beide Quests führen nach {zone:1451}: Behalte sie.",

	-- Step 90: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "Reite vom Tunnelausgang nach {zone:1452} nach Süden zu {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086} sind in {zone:1448}, bei einer späteren Reise: Behalte sie.",

	-- Step 91: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Mondbestrahlte Eulenbestien",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Reite nach Osten nach {area:2255} und von dort nach Norden; die Mondbestrahlten Eulenbestien streifen durch die Hügel an den Südhängen von {area:2241}. Vorsicht: Sie sind Stufe 57-58: Zieh sie einzeln.\nVorsicht: Hailspite, Elites der Stufe 60, sammeln sich in den Schneefeldern südöstlich von {area:2255}, wo auch ein paar Mondbestrahlte Eulenbestien umherstreifen: Bleib an den Hängen nördlich der Stadt.",

	-- Step 92: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Makellose Yetihörner",
	-- {area:2255} Everlook
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "Umis Hörner, mitgebracht von deinem letzten Halt in {area:2255}: Die Yetihügel beginnen direkt südöstlich von {area:2255}. Nur Matriarchen und Patriarchen lassen Hörner fallen, und die Patriarchen erreichen Stufe 58: Zieh sie einzeln.",

	-- Step 93: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook · {zone:2482} Mount Hyjal · {zone:1451} Silithus
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it. {zone:2482} is next: its way in starts here in {area:2255}; {area:976}, Linken's sword and {zone:1451} follow it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Eine zerrissene Schriftrolle liegt am Eingang von {area:2261}, der Gruft südlich von {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Zurück durch den Tunnel, nimm den Ausgang nach {area:618} und reite dann nach Süden zu {area:2246}.",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "Zurück durch den Tunnel, nimm den Ausgang nach {zone:1452}: {npc:11556} steht genau dort, wo er herauskommt.",
	-- ["Back to {area:1638}"] = "Zurück nach {area:1638}",
	-- ["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Trink das {item:11243} auf dem Friedhof direkt östlich von {area:976}: Es tötet dich, und nur als Geist kannst du {npc:9299} sehen, in einer Felsspalte in den Hügeln genau nördlich davon. Sprich dort mit ihm, lauf dann zurück zu deinem Körper und belebe dich wieder: Der Auffällige Grabstein, zu dem er dich schickt, steht auf diesem Friedhof.",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Flieg nach {zone:1458}, nimm den Zeppelin nach {zone:1454} und flieg weiter nach {area:1638}.",
	-- ["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Flieg zum {area:1099}. Die Hippogryphennester sind im Süden von {zone:1444}; jedes enthält ein Ei für {object:142071}.",
	-- ["Fly to {area:1497}"] = "Flieg zur {area:1497}",
	-- ["Fly to {area:1997}"] = "Flieg nach {area:1997}",
	-- ["Fly to {area:541}"] = "Flieg nach {area:541}",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Flieg zur {area:541} und reite dann nach Südwesten durch Un'Goro zum Pass nach {zone:1451}. Der nächste Guide beginnt bei {area:3077}, wo der Pass herauskommt.",
	-- ["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Rasende Seuchenhunde und Monströse Seuchenfledermäuse teilen sich die Felder um {area:2272} und den {area:2271}, südlich von {area:2273}.",
	-- ["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "Rasende Seuchenhunde teilen sich die Felder um {area:2272} und {area:2271}, südlich von {area:2273}; Giftige Seuchenfledermäuse fliegen über die Felder im Norden, Monströse Seuchenfledermäuse um {area:2272} und {area:2271}. Vorsicht: Die Hunde sind Stufe 57-58 und die größten Monströsen Seuchenfledermäuse 58: Zieh sie einzeln.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Geh durch die {area:1769} und nimm die Abzweigung des Tunnels nach {area:493}. {npc:11801} ist in {area:2361}.",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Geh durch die {area:1769} und nimm die Abzweigung des Tunnels nach {zone:1450}. {npc:11801} ist in {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya versteckt sich zwischen den Trollen der Moosschinder in {area:2273}, in der Nordostecke.",
	-- ["Hameya's mound"] = "Hameyas Hügel",
	-- ["Hameya's scroll"] = "Hameyas Schriftrolle",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "Ruhestein nach {zone:1454}: Er ist noch vom Guide für {zone:1447} dort gebunden (Magier teleportieren sich). Dann zum Flugmeister.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "Ruhestein nach {zone:1454}: Er ist noch vom Guide für {zone:1447} dort gebunden (Magier teleportieren sich). Trainiere vor dem Flug.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "Ruhestein nach {zone:1454}: Er ist noch vom Guide für {zone:1447} dort gebunden. Dann zum Flugmeister.",
	-- ["Hippogryph eggs"] = "Hippogryphen-Eier",
	-- ["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Drinnen: {quest:4493}, falls du sie im Guide für {zone:1447} in {zone:1454} angenommen hast",
	-- ["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "Behalte die Termiten: {npc:11615} am {area:813} nimmt sie beim Ritt in die {zone:1422} im nächsten Guide an.",
	-- ["Level 56"] = "Stufe 56",
	-- ["On to {zone:1451}"] = "Weiter nach {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Auf der {area:1641}. Hab Wolle, Seide und Magiestoff in deinen Taschen.",
	-- ["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Nur wenn {quest:8471} für dich gefallen ist: {npc:11558} wartet am Eingang der {area:1769} im {zone:1448} und spricht erst ab neutralem Ruf bei der Holzschlundfeste mit dir.",
	-- ["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Nur wenn du in {area:618} eine Flasche {item:12820} gefunden hast: Reite die Straße nach Norden hinauf. Der Kessel steht in {area:1762}, gleich südwestlich der {area:1769}; die Furbolgs der Totenwaldfelle dort sind feindselig.",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "Nur wenn du {quest:2741} noch dabeihast: Reite vom {area:1099} nach Süden; die Hippogryphennester sind im Süden von {zone:1444}, jedes enthält ein Ei für den Eiomaten.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Seuchenhunde und ihre Kleinen streifen an den Ufern des Sees südwestlich der Kapelle umher.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "Plaguehounds und ihre Runts streifen an den Ufern des Sees südwestlich der Kapelle umher; Plaguebats und Carrion Grubs teilen sich das Gelände.\nDas zerbrochene Schwert liegt am Boden nordwestlich des Sees.",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Reite nach Osten nach {area:2255} und von dort nach Norden; die Mondbestrahlten Eulenbestien streifen durch die Hügel an den Südhängen von {area:2241}. Zieh sie einzeln.\nVorsicht: Hailspite, Elites der Stufe 60, sammeln sich in den Schneefeldern südöstlich von {area:2255}, wo auch ein paar Mondbestrahlte Eulenbestien umherstreifen: Bleib an den Hängen nördlich der Stadt.",
	-- ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Reite die Straße nach Norden. Der Kessel steht in {area:1762}, direkt südwestlich von {area:1769}; die Deadwood-Furbolgs dort sind feindlich.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with Greater Invisibility. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Reite von der Lodge nach Süden nach {area:2264}, an der Straße. {item:15447} verdirbt innerhalb von zehn Minuten: Töte das Scourge der Stadt schnell und grinde die sieben Stücke sofort mit {item:15454}.\nVorsicht: Unseen Servants rufen Verbündete im Umkreis von 25 yd zu Hilfe, sobald sie auf 40% Gesundheit fallen. Außerhalb des Kampfes werden sie außerdem mit Große Unsichtbarkeit unsichtbar. Wenn ein Hilferuf in der Stadt geschieht, kann eine große Zahl Mobs in den Kampf eingreifen. Kämpfen am Stadtrand senkt dieses Risiko.\nMit {quest:5211} in deinem Log (von {npc:11063} am Anfang dieses Guides) hinterlassen die Scourge rund um die Stadt Darrowshire Spirits: Sprich mit jedem, um ihn zu befreien. Befreie sie, bevor du dich an {item:15447} machst.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Reite von der Lodge auf der Straße nach Süden zu {area:2264}. {item:15447} verdirbt binnen zehn Minuten: Töte die Geißel des Orts zügig und zerreibe die sieben Stücke sofort mit {item:15454}.\nVorsicht: Unsichtbare Diener rufen im Umkreis von 25 Metern um Hilfe, sobald sie auf 40 % Gesundheit fallen. Außerhalb des Kampfes werden sie außerdem mit {spell:10228} unsichtbar. Wenn innerhalb des Orts um Hilfe gerufen wird, können sich sehr viele Gegner dem Kampf anschließen. Am Ortsrand zu kämpfen senkt dieses Risiko.\nMit {quest:5211} in deinem Questlog (von {npc:11063} am Ende des Un'Goro-Guides) hinterlässt die Geißel rund um den Ort Geister von Darrowehr: Sprich jeden an, um ihn zu befreien. Befreie sie, bevor du mit {item:15447} anfängst.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Reite von der Lodge auf der Straße nach Süden zu {area:2264}. {item:15447} verdirbt binnen zehn Minuten: Töte die Geißel des Orts zügig und zerreibe die sieben Stücke sofort mit {item:15454}.\nVorsicht: Unsichtbare Diener rufen im Umkreis von 25 Metern um Hilfe, sobald sie auf 40 % Gesundheit fallen. Außerhalb des Kampfes werden sie außerdem mit {spell:10228} unsichtbar. Wenn innerhalb des Orts um Hilfe gerufen wird, können sich sehr viele Gegner dem Kampf anschließen. Am Ortsrand zu kämpfen senkt dieses Risiko.\nMit {quest:5211} in deinem Questlog (von {npc:11063} zu Beginn dieses Guides) hinterlässt die Geißel rund um den Ort Geister von Darrowehr: Sprich jeden an, um ihn zu befreien. Befreie sie, bevor du mit {item:15447} anfängst.",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Reite vom {area:1099} nach Süden: Die Hippogryphennester sind im Süden von {zone:1444}; jedes enthält ein Ei für {object:142071}.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "Reite nach Südwesten zu den Ruinen von {area:2738}. {object:179565} für {quest:1123} steht in einem der zerstörten Häuser.",
	-- ["Ride west to the {area:2260}."] = "Reite nach Westen zu {area:2260}.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Verscheuche {npc:7583} mit {item:12928}",
	-- ["Sword of Marduk"] = "Zertrümmertes Schwert von Marduk",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Die Annalen liegen zwischen den Modrigen Folianten im Rathaus von Andorhal; öffne sie, bis du den richtigen findest.",
	-- ["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "Der Flug landet bei {area:541}: {npc:9997} steht neben dem Flugmeister und {npc:8737} bei der Höhle ein paar Schritte entfernt. {npc:9997}s Arbeit liegt in Un'Goro auf dem Rückweg nach Norden im nächsten Guide.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Die Waldläufer, Pfadschreiter und Waldmänner der Hochelfen bewachen die Lodge beim {area:2275}; das Register liegt drinnen. Waldläufer erreichen Stufe 60: Zieh sie einzeln. Giftige Seuchenfledermäuse fliegen auf dem Weg über die Felder.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Die Hochelfen-Rangers, Pathstriders und Woodsmen bewachen die Lodge bei {area:2275}; das Register liegt darin. Rangers erreichen 60: Zieh sie einzeln. Noxious Plaguebats fliegen auf dem Weg über die Felder.\nDer Schädel liegt in {area:2622}, zwischen Blighted Horrors und Plague Monstrosities.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Der Pass aus dem Un'Goro-Krater endet an der {area:3077}, dem Friedhof im Nordosten von {zone:1451}. {npc:13220} steht zwischen den Gräbern.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "Das zertrümmerte Schwert liegt nordwestlich des Sees auf dem Boden.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Der Schädel liegt in {area:2622}, zwischen Verseuchten Schrecken und Seuchenmonstern.",
	-- ["The western hills"] = "Die westlichen Hügel",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "Die Maschine {object:142071}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} liegt gleich hinter {area:2261}.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Sich zu gruppieren ist empfohlen, such dir Leute dafür. {npc:11897} ist ein Elite der Stufe 60: Die meisten Klassen schaffen ihn solo auf Stufe 62, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die EP wieder erarbeiten.",
	-- ["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "Leve hier bis Stufe 56 auf, bevor du dich an die Rasenden Seuchenhunde von Nordtal (57-58) wagst: Die Giftigen Seuchenfledermäuse (54-56) über den Feldern auf dem Weg nach Osten passen zu deiner Stufe, und {npc:11878} will zwanzig davon. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1583} (Untere).",
	-- ["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "Umis dritter Streich gilt Goblins in {area:976}, Un'Goro und {area:2255}: Behalte ihn für später.",
	-- ["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Benutze {item:12928} an {npc:7583}, dem Goblinmädchen in {area:976}. {npc:10977} und {npc:10978} erschreckst du später auf der Route.",
	-- ["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- ["grind on {npc:8601}"] = "grinde {npc:8601}",
	-- ["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "behalte sie: Die Waldläufer (59-60) warten auf den zweiten Ritt in den Norden im nächsten Guide",
	-- ["{area:2255} flight master"] = "Flugmeister in {area:2255}",
	-- ["{area:976} flight master"] = "Flugmeister von {area:976}",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} verdirbt binnen zehn Minuten: Töte die Geißel des Orts zügig und zerreibe die sieben Stücke sofort mit {item:15454}.",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880} läuft durch das {object:172982} und die angrenzenden Straßen: Halte auf dem Weg zum Turm des Flugmeisters nach ihm Ausschau; der Kreis auf der Karte ist sein Laufweg.",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}: für {npc:7776} im {quest:7492}, am Ende dieses Guides",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Der Geist {npc:11140} steht bei einer Hütte im {area:2627}, in der Nordwestecke.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}, nördlich vom Tiefgewölbe ({area:2261}).",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}, nördlich vom {area:2261}. Seine Jagd auf {npc:8564} im Norden des Gebiets wartet auf die nächste Reise in die Pestländer im nächsten Guide.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}.",
	-- ["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} lagert an der Straße zur {area:1336}, südlich von {area:976}.",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} läuft um {area:2276} herum: schau in den Kreis auf der Karte",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} ist ein Geist auf dem Friedhof gleich nördlich von {area:976}; Ein verdächtiger Grabstein liegt südlich davon, außerhalb der Stadtmauer.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Der Flugmeister von {object:1661} ist im Westturm des {object:36078}, außerhalb der Mauern.",
	-- ["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} geht zurück zu {npc:8737} in Un'Goro: Behalte sie.",
	-- ["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "{quest:3941} geht an {npc:9117} in der Höhle hier, bei der Rückkehr des nächsten Guides nach {area:541}: Behalte sie.",
	-- ["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} sind im {zone:1448}, auf einer späteren Reise: Behalte sie, falls du sie hast.",
	-- ["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Die Gegenstände für {quest:5168} liegen in den späteren Gebieten der Pestländer: Behalte sie.",
}
