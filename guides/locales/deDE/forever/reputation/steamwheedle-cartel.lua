-- German (deDE): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "Ruf: Dampfdruckkartell",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "Alle Goblinstädte auf einmal: {npc:14637}s elektrisierte Riesen und {npc:14338}s Fesseln, dann fünf neue Rüstmeister und ihre Hüte.",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "Forevers Goblin-Rüstmeister: Ausrüstung für Stufe 20 bis 50 bei Freundlich und Wohlwollend",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "Fünf Goblinstädte teilen sich eine Rufgruppe, das Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} und Forevers neues {faction:2827} in {zone:2548}. Du beginnst bei jeder bei Neutral (500 darin). Ein Zugewinn bei einer Stadt gibt den anderen halb so viel; eine Quest für das Kartell selbst, wie die von {npc:14637}, zahlt jeder Stadt voll aus. Verluste verteilen sich genauso: Ein {npc:4624} oder irgendein Goblin der Städte kostet 125 (die Hälfte bei den anderen Städten), und Ruf bei den Blutsegelbukaniern gibt es nur so. {npc:14637} lagert an der Straße durch das mittlere {zone:1444} und arbeitet für jeden, selbst für Spieler, die die Goblins hassen. Seine ersten beiden Quests sind Stufe 48 und schalten seine wiederholbaren frei (Stufe 55); Forever zahlt alle auf jeder Stufe voll aus.",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003}: 150 bei jeder Stadt",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721}: 150 bei jeder Stadt",

	-- Step 2: Zapped giants
	["Zapped giants"] = "Geschrumpfte Riesen",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "Benutze {item:18904} an einem lebenden Riesen ({npc:5357}, {npc:5358} oder einem Shore, Deep oder {npc:5361}, Stufe 47-50), und er schrumpft zu einer elektrisierten Version; töte sie für ihr {item:18956}, jedes Mal eines. Die Land Walkers und Cliff Giants in den nordwestlichen Hügeln sind am dichtesten; die Strider laufen an der Küste und im Flachwasser. Der Schrumpfer hält zwei Stunden: Wenn er ausläuft, brich die Quest ab und nimm sie erneut an.",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "{item:18904}, an einem lebenden Riesen",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}, von den elektrisierten Riesen",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "Sea Elementals und Sea Sprays",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "Die Sea Elementals und Sea Sprays (Stufe 47-49) treiben an der {area:1108} und im Flachwasser unter den Riesen: Etwa die Hälfte lässt einen {item:18958} fallen.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958}: Sea Elementals und Sea Sprays",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "Zurück zu {npc:14637}",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "Ab jetzt bietet {npc:14637} {quest:7725} (10 Rückstände) und {quest:7726} (6 Kerne) an, immer wieder: jedes Mal 25 Ruf bei jeder Stadt.",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}, unter 56",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "Die Southsea-Piraten von {area:1336} (Stufe 44-45) an der Ostküste von {zone:1446} geben {faction:369} je 5 bis zum Ende von Wohlwollend, die anderen Städte die Hälfte. Zwei Quests bei {area:977} bringen je 100 {faction:369}: {quest:8366} (10 von jedem Piraten) und {quest:8365} (20 Southsea Pirate Hats, einer von zehn Piraten). Ab Stufe 56 sind die Piraten grau und zahlen wenig: Überspring dann diesen Schritt.",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{npc:10267}, eine Goblin bei {area:251} im Norden der {zone:1428}, hat eine Reihe, die jeder Stadt 150 und {faction:577} weitere 150 gibt. Benutze ihren {item:12284} an einem Broodling, töte es, solange das Gerät es festhält, und heb die {quest:4726} auf, die es hinterlässt. Das Gerät nimmt nur Black und Scalding Broodlings, nicht die Flamescale Broodlings im Westen: Scalding Broodlings (Stufe 53-54) streifen westlich und östlich von {area:251}, Black Broodlings (51-52) in der nordöstlichen Ecke des Gebiets, der dichtesten Gruppe. Sie sind wenige und verstreut: Der Pfad führt an beiden vorbei und endet bei den Black Broodlings.",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "Scalding Broodlings westlich von {area:251}",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "Scalding Broodlings östlich von {area:251}",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "Black Broodlings im Nordosten",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "{item:12284}, an einem Black oder {npc:7048}",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}, von den Broodlings hinterlassen",
	["100 to every town"] = "100 bei jeder Stadt",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808} ist in {faction:577}. Die Chillwind Chimaeras (Stufe 55-57) südwestlich von {faction:577} lassen die Hörner bei jedem fünften Mal fallen.",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444}: von Chillwind-Chimären",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "Zurück zu {npc:10267}",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "{quest:4810} gibt 50 bei jeder Stadt. Ihre späteren Quests, Egg Freezing (150 bei jeder Stadt) und Egg Collection (200), werden im Rookery der Oberen Schwarzfelsspitze gemacht, einem Dungeon für zehn Spieler: Nimm sie mit deiner Gruppe an.",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "Düsterbruch Nord: {npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "{npc:14338} sitzt in Fesseln im Düsterbruch Nord, dem Flügel der Gordok-Oger (ein Dungeon für fünf Spieler ab Stufe 57: bildet eine Gruppe). Jeder {item:18250} befreit ihn einmal: 150 bei jeder Stadt, und bei deinem nächsten Durchlauf ist er wieder gefesselt. Gordok-Oger lassen die Schlüssel fallen (etwa einer von fünfzehn; {npc:14321} einer von sieben): Ein kompletter Durchlauf des Flügels bringt meist einen. Sein {item:18258} zahlt beim ersten Mal 100 und danach 50, für 4 Ballen Runenstoff, 8 {item:8170}, 2 {item:14341} und das {item:18240} aus dem Korb im Flügel. Bist du hier unter Stufe 57? Hebe das Überspringen dieses Schritts später auf.",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}, Gordok-Oger",
	-- {quest:5525} Free Knot!
	["{quest:5525}: 150 to every town"] = "{quest:5525}: 150 für jede Stadt",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}, bei jedem weiteren Durchlauf erneut: 150",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "Jede Stadt bis Freundlich",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "Von Neutral 500 bis Freundlich sind es 2.500 bei jeder Stadt. Die Quests oben geben jeder Stadt bis zu 700 ({npc:14637}s zwei Quests mit je 300, {npc:10267}s 150, das erste Free Knot mit 150 und der erste Ogre Suit mit 100); den Rest holen {npc:14637}s wiederholbare Quests, jeweils 25 für jede Stadt: 10 Rückstände (zehn Riesen) oder 6 Kerne (etwa zwölf Elementare). Auch die Quests der Städte selbst zählen, wobei jede den anderen Städten die Hälfte gibt: die von {faction:470} im {zone:1413} (Stufe 10-25, etwa 4.300: die Samophlange-Questreihe 625, {npc:3446}s Botengänge, die Eskorten von Wizzlecrank und Gilthares mit je 150), die von {faction:21} in Schlingendorntal, Arathi und im {zone:1418} (30-50, etwa 6.500: die drei OOX-Roboter-Rettungen mit je 250, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, die Sunken-Treasure-Questreihe bei {area:327}), die von {faction:369} in {zone:1446} (43-55, etwa 3.000: der {item:8548} 200, Wastewander Justice je 100, die WANTED-Plakate) und die von {faction:577} in {zone:1452} (52-60, etwa 1.450: {npc:9298}s Winterquell-Questreihe, Umis Yeti-Quests). Forever fügt ein paar niedrige hinzu: A Simmering Storm und Stormy Potential in {zone:1411} sowie WANTED: Bruuz ({faction:470} je 100), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever zahlt sie auf jeder Stufe in voller Höhe aus. Kills helfen, solange sie nicht grau sind, je 5: Südmeerpiraten im {zone:1413} für {faction:470} und in {zone:1446} für {faction:369} sowie die Lager der Venture Co. im Schlingendorntal für {faction:21}, bis zum Ende von Wohlwollend; Wastewander-Banditen für {faction:369} und Blutsegelbukaniere für {faction:21} nur bis zum Ende von Neutral. Freundlich schaltet die erste Ausrüstung jedes Rüstmeisters frei.",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725}: 10 Rückstände",
	["25 to every town"] = "25 für jede Stadt",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726}: 6 Kerne",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "Jede Stadt bis Wohlwollend",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "Von Freundlich bis Wohlwollend sind es 6.000: 240 Abgaben bei {npc:14637}, oder 40 Free-Knot-Durchläufe, oder eine Mischung. Man kann nichts auf Vorrat sammeln: Rückstände und Kerne droppen nur, solange ihre Quest in deinem Questlog ist, und du kannst nur einen {item:18250} gleichzeitig tragen, also gib ihn vor dem nächsten Durchlauf ab. Wohlwollend schaltet die blauen Gegenstände jedes Rüstmeisters frei.",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "Jede Stadt bis Respektvoll",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "Von Wohlwollend bis Respektvoll sind es weitere 12.000: 480 Abgaben bei {npc:14637} (4.800 Rückstände) oder 80 Free-Knot-Durchläufe. Respektvoll schaltet die fünf kosmetischen Hüte frei, der Grund, warum die meisten Spieler das hier machen. Der Vermächtnis-Vorteil „Diplomat“ bringt bis zu 10% extra.",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{npc:265574}, der Rüstmeister von {faction:470}, bei den Docks. Freundlich, Ausrüstung für Stufe 20: {item:274740} 41s (Ausdauer, Beweglichkeit), {item:274741} 54s (Ausdauer, Zaubermacht), {item:274742} 34s (Intelligenz, Beweglichkeit). Wohlwollend: {item:274743}, eine Nebenhand, 66s (Intelligenz, Willenskraft); {item:274744}, ein Einhand-Streitkolben, 1g 65s (Ausdauer, Stärke). Respektvoll: {item:274021}, ein kosmetischer Hut, 2g.",
	-- {item:274740} Quilted Cloak
	["{item:274740}, Friendly"] = "{item:274740}, Freundlich",
	-- {item:274741} Rumpled Kilt
	["{item:274741}, Friendly"] = "{item:274741}, Freundlich",
	-- {item:274742} Ratchet Wristwraps
	["{item:274742}, Friendly"] = "{item:274742}, Freundlich",
	-- {item:274743} Defective Samophlange
	["{item:274743}, Honored"] = "{item:274743}, Wohlwollend",
	-- {item:274744} Barrens Basher
	["{item:274744}, Honored"] = "{item:274744}, Wohlwollend",
	-- {item:274021} Barrens Headband
	["{item:274021}, Revered"] = "{item:274021}, Respektvoll",

	-- Step 14: Booty Bay: Gezzy Gunkgear
	-- {npc:265575} Gezzy Gunkgear · {faction:21} Booty Bay · {item:274745} Deckswabber's Mitts · {item:274746} Sea Giant's Toe Ring · {item:274747} Soggy Boots · {item:274748} Booty Bay Bruiser's Buckshot · {item:274749} Souvenir Sea Shell · {item:274022} Tough Guy's Eyepatch
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}, der Rüstmeister von {faction:21}. Freundlich, Ausrüstung für Stufe 30: {item:274745} 1g 10s (Stärke, Beweglichkeit), {item:274746} 1g 48s (Heilung und Zauberschaden), {item:274747} 1g 3s (Intelligenz, Willenskraft). Wohlwollend: {item:274748}, eine Schusswaffe, 3g 11s (Angriffskraft, Ausdauer); {item:274749}, eine Halskette, 1g 66s (Gesundheitsregeneration, Ausdauer). Respektvoll: {item:274022}, 5g.",
	-- {item:274745} Deckswabber's Mitts
	["{item:274745}, Friendly"] = "{item:274745}, Freundlich",
	-- {item:274746} Sea Giant's Toe Ring
	["{item:274746}, Friendly"] = "{item:274746}, Freundlich",
	-- {item:274747} Soggy Boots
	["{item:274747}, Friendly"] = "{item:274747}, Freundlich",
	-- {item:274748} Booty Bay Bruiser's Buckshot
	["{item:274748}, Honored"] = "{item:274748}, Wohlwollend",
	-- {item:274749} Souvenir Sea Shell
	["{item:274749}, Honored"] = "{item:274749}, Wohlwollend",
	-- {item:274022} Tough Guy's Eyepatch
	["{item:274022}, Revered"] = "{item:274022}, Respektvoll",

	-- Step 15: Gadgetzan: Rettrick
	-- {npc:265576} Rettrick · {faction:369} Gadgetzan · {item:274750} Reflective Wristguards · {item:274751} Sunburn Spaulders · {item:274752} Sandstorm Cover · {item:274753} Jhordy's Misplaced Screwdriver · {item:274754} Suspicious Spare Part · {item:274023} Stolen Wastewander Cowl
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}, der Rüstmeister von {faction:369}. Freundlich, Ausrüstung für Stufe 40: {item:274750} 2g 74s (Intelligenz, Heilung, Zauberschaden), {item:274751} 2g 94s (Beweglichkeit, Angriffskraft), {item:274752}, ein Umhang, 2g 36s (Willenskraft, Zaubermacht). Wohlwollend: {item:274753}, eine Einhandwaffe, 9g 46s (Stärke, Beweglichkeit); {item:274754}, ein Ring, 3g 80s (Stärke, Ausdauer). Respektvoll: {item:274023}, 10g.",
	-- {item:274750} Reflective Wristguards
	["{item:274750}, Friendly"] = "{item:274750}, Freundlich",
	-- {item:274751} Sunburn Spaulders
	["{item:274751}, Friendly"] = "{item:274751}, Freundlich",
	-- {item:274752} Sandstorm Cover
	["{item:274752}, Friendly"] = "{item:274752}, Freundlich",
	-- {item:274753} Jhordy's Misplaced Screwdriver
	["{item:274753}, Honored"] = "{item:274753}, Wohlwollend",
	-- {item:274754} Suspicious Spare Part
	["{item:274754}, Honored"] = "{item:274754}, Wohlwollend",
	-- {item:274023} Stolen Wastewander Cowl
	["{item:274023}, Revered"] = "{item:274023}, Respektvoll",

	-- Step 16: Everlook: Zippie Fizzbolt
	-- {npc:265577} Zippie Fizzbolt · {faction:577} Everlook · {item:274755} Steamwheedle Grips · {item:274756} Impractical Headwarmer · {item:274757} Substandard Belt Chain · {item:274758} Coldmetal Guard · {item:274759} Everlook Pathcarver · {item:274760} Everlook Delivery Bot · {item:274761} Parachute-Priest Pager · {item:274024} Fizzbolt's Fashionable Fedora
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}, der Rüstmeister von {faction:577}. Freundlich, Ausrüstung für Stufe 50: {item:274755} 3g 10s (Willenskraft, Intelligenz), {item:274756} 5g 84s (Beweglichkeit, Ausdauer, Frostwiderstand), {item:274757} 4g 68s (Beweglichkeit, Angriffskraft), {item:274758}, ein Brustteil, 10g 96s (Stärke, Ausdauer). Wohlwollend, drei Schmuckstücke für etwa 7g 55s: {item:274759} (Naturwiderstand), {item:274760} (Frostwiderstand) und {item:274761} (Schattenwiderstand), die letzten beiden mit einem Benutzen-Effekt. Respektvoll: {item:274024}, 25g.",
	-- {item:274755} Steamwheedle Grips
	["{item:274755}, Friendly"] = "{item:274755}, Freundlich",
	-- {item:274756} Impractical Headwarmer
	["{item:274756}, Friendly"] = "{item:274756}, Freundlich",
	-- {item:274757} Substandard Belt Chain
	["{item:274757}, Friendly"] = "{item:274757}, Freundlich",
	-- {item:274758} Coldmetal Guard
	["{item:274758}, Friendly"] = "{item:274758}, Freundlich",
	-- {item:274759} Everlook Pathcarver
	["{item:274759}, Honored"] = "{item:274759}, Wohlwollend",
	-- {item:274760} Everlook Delivery Bot
	["{item:274760}, Honored"] = "{item:274760}, Wohlwollend",
	-- {item:274761} Parachute-Priest Pager
	["{item:274761}, Honored"] = "{item:274761}, Wohlwollend",
	-- {item:274024} Fizzbolt's Fashionable Fedora
	["{item:274024}, Revered"] = "{item:274024}, Respektvoll",

	-- Step 17: Powderfuse: Friz Frazzlespark
	-- {npc:255897} Friz Frazzlespark · {faction:2827} Powderfuse · {area:16727} Powderfuse Port · {zone:2548} Riverglades · {item:276200} Crawler's Clackers · {item:276201} Misplaced Pantaloons · {item:276202} Disengagement Ring · {item:276203} Primitive Fishing Pole · {item:276204} Thrash's Trash · {item:276199} Haughty Fellow's Monocle
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897} verkauft die Belohnungen von {faction:2827} in {area:16727}, an der Ostküste von {zone:2548}, neben allgemeinen Waren. Freundlich, Ausrüstung für Stufe 40: {item:276200} 2g 74s (Ausdauer, Angriffskraft), {item:276201} 2g 94s (Intelligenz, Willenskraft), {item:276202} 2g 36s (Beweglichkeit, Willenskraft). Wohlwollend: {item:276203}, eine Zweihandwaffe, 9g 46s (Ausdauer, Stärke, Beweglichkeit); {item:276204}, ein Schild, 3g 80s (Ausdauer, Zauberschaden, Heilung). Respektvoll: {item:276199}, 10g.",
	-- {item:276200} Crawler's Clackers
	["{item:276200}, Friendly"] = "{item:276200}, Freundlich",
	-- {item:276201} Misplaced Pantaloons
	["{item:276201}, Friendly"] = "{item:276201}, Freundlich",
	-- {item:276202} Disengagement Ring
	["{item:276202}, Friendly"] = "{item:276202}, Freundlich",
	-- {item:276203} Primitive Fishing Pole
	["{item:276203}, Honored"] = "{item:276203}, Wohlwollend",
	-- {item:276204} Thrash's Trash
	["{item:276204}, Honored"] = "{item:276204}, Wohlwollend",
	-- {item:276199} Haughty Fellow's Monocle
	["{item:276199}, Revered"] = "{item:276199}, Respektvoll",

	-- Step 18: Every town to Exalted
	["Every town to Exalted"] = "Jede Stadt bis Ehrfürchtig",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "Von Respektvoll bis Ehrfürchtig sind es weitere 21.000 bei jeder Stadt: 840 Abgaben bei {npc:14637} oder 140 Free-Knot-Durchläufe. Kein Rüstmeister verkauft etwas für Ehrfürchtig: Das ist nur für die Titelleiste.",
}
