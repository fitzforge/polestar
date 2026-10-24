-- German (deDE): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words) · {object:1661} The Undercity
	["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "Flieg von {area:35} nach {object:3202}. Der Zeppelin nach {object:1661} startet vom Turm auf der Westseite des Lagers.",
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "Zeppelin nach {zone:1458}",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661} hat keinen Jäger- oder Schamanenlehrer: Nimm stattdessen vom selben Turm den Zeppelin nach {zone:1454} und trainiere in der Stadt, dann nimm vom Turm vor dem Haupttor von {zone:1454} den Zeppelin nach {zone:1458}.",

	-- Step 3: Thunder Bluff
	-- {spell:18960} Teleport: Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Wirke {spell:18960} und nimm den Flug von {npc:11798} nach {area:1638}; {npc:3033} bildet dich auf der {area:1639} aus. Flieg dann nach {zone:1454} und nimm vom Turm vor dem Haupttor den Zeppelin nach {zone:1458}.",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Lehrer in {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Trainiere, solange du in {zone:1458} bist: Die Lehrer stehen im {object:36070}, im {object:36073} und im {object:36082} (Paladine: {npc:260093}).",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- {zone:1458} Undercity · {area:272} Tarren Mill
	["The zeppelin lands at the towers outside the {zone:1458}: head down into the city and fly to {area:272}."] = "Der Zeppelin landet an den Türmen vor der {zone:1458}: Geh hinunter in die Stadt und flieg nach {area:272}.",

	-- Step 6: Boulderfist camp
	["Boulderfist camp"] = "Lager der Felsfäuste",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Geh von {area:272} nach Osten durch {area:1857} und folge der Straße nach Osten. Die Oger und Vollstrecker der Felsfäuste (32-34) lagern südlich der Straße, südöstlich von {area:313}.",

	-- Step 7: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "Die violetten Splitter leuchten gleich neben der Straße, ein kurzes Stück westlich von {area:321}.",

	-- Step 8: Hammerfall
	-- {npc:2851} Urda
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "Die Orcfestung am östlichen Ende der Straße. {npc:2851}, die Windreitermeisterin, steht beim Tor.",

	-- Step 9: Highland raptors
	["Highland raptors"] = "Hochlandraptoren",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "Hochlandschreiter streifen überall um {area:321} durch die Hügel; sie und die Hochlandhauer weiter westlich lassen die Augen fallen.",

	-- Step 11: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "Nordöstlich von Hammerfall graben die Kobolde der Trockenstoppel in der Schlucht; die Kobolde am Eingang und die Buddler und Feldvermesser weiter drinnen lassen alle die Körner von Myzrael fallen.",

	-- Step 12: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} liegen am hinteren Ende der Schlucht.",

	-- Step 13: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "Jeder {object:180105} ist ein Ring aus Menhiren; der Schlüssel liegt auf dem Stein in seiner Mitte. Der östliche Kreis liegt in den Hügeln nordwestlich von {area:321}.",

	-- Step 14: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "Die Trolle der Witherbark halten das Dorf in den südöstlichen Hügeln. Axtwerfer bewachen die äußeren Hütten; die Hexendoktoren und Kopfjäger halten das Herz des Dorfs.",

	-- Step 15: Fleshstalker raptors
	["Fleshstalker raptors"] = "Hochlandfleischpirscher",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Hochlandfleischpirscher (36-37) jagen im südlichen Hochland, ein Rudel nördlich von {area:316} und ein weiteres auf der Ebene westlich davon. Zieh sie einzeln.",

	-- Step 16: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Geh nach Südwesten zur Goblinbucht an der Südküste. {npc:2766} hält auf der Klippe darüber Wache.",

	-- Step 17: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "Eskortiere den Professor hinunter zum Ufer. Zwei Naga der Säbelflossen überfallen ihn unterwegs: Bleib dicht dran.",

	-- Step 19: Daggerspine shore
	["Daggerspine shore"] = "Ufer der Säbelflossen",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "Westlich der Bucht halten die Räuber und Zauberhexerinnen der Säbelflossen (38-40) das Ufer: Zieh sie einzeln. Die beiden Wracks liegen davor im seichten Wasser, die Karten und Logbücher darin; die Edelsteine liegen um die Wracks auf dem Meeresgrund.",

	-- Step 20: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "für {npc:2487} in {area:35}, etwa ab Stufe 44",

	-- Step 21: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head north; the outer circle stands in the middle of the highlands."] = "Geh nach Norden; der äußere Kreis steht mitten im Hochland.",

	-- Step 22: Northfold Manor
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "Das Syndikat hält das ummauerte Gut und seinen Hof im Nordwesten; seine Straßenräuber, Söldner und Pfadpirscher tragen die Blutsteinamulette.",

	-- Step 23: The Stone of West Binding
	-- {object:2689} Stone of West Binding
	["The {object:2689}"] = "{object:2689}",
	-- {area:1857} Thoradin's Wall
	["The western circle is near {area:1857}, where you came in."] = "Der westliche Kreis ist nahe {area:1857}, wo du hereingekommen bist.",

	-- Step 24: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Der innere Kreis liegt südlich des westlichen Kreises, östlich von Stromgarde.",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "Die nächste Aufgabe des Steins erfordert Fozruk, einen Elite der Stufe 42: Lass sie liegen.",

	-- Step 25: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Zurück nach {area:321}",

	-- Step 26: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Die Schläger der Felsfäuste lagern vor der Halle der Oger südlich von {area:321}; die Magier der Felsfäuste stehen zwischen ihnen. Zieh sie einzeln.",

	-- Step 27: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "{quest:678} von {npc:2771} geht als Nächstes gegen Elite-Felsfäuste: Lass sie liegen.",

	-- Step 28: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Ins {zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Geh von Arathi nach Südwesten über {area:880}, südlich durch die {zone:1437} (halte dich von {area:150} fern) und östlich nach {zone:1432}; die Straße verlässt {zone:1432} nach Süden in die {zone:1418}. Folge ihr nach Süden zum Goblinlager im {area:1877}.",

	-- Step 29: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: Fizzles Brief aus {area:439}",

	-- Step 30: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Head west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Geh entlang der Straße nach Westen; das Lager von {npc:2921} liegt in der {area:1878}, auf halbem Weg nach {area:340}.",

	-- Step 31: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340} ist die Hordefestung, in die Klippen am Westrand des Gebiets gebaut.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "für Helgrum in {area:75}, etwa ab Stufe 42",

	-- Step 32: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Kleine Felselementare",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "Die kleinen Elementare treiben über die Ebene gleich westlich von {npc:2921}s Lager. Jedes Felselementar im Gebiet kann {npc:6868}s Felselementarsplitter fallen lassen: Behalte sie.",

	-- Step 34: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Felselementare",
	-- {area:1878} The Dustbowl
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Die größeren Felselementare stehen an den Hängen nordwestlich vom {area:1878}; jedes lässt eine Steinplatte fallen.",

	-- Step 36: Coyotes and buzzards
	["Coyotes and buzzards"] = "Kojoten und Bussarde",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Die Alten Klippenkojoten und Riesenbussarde streifen durch das Becken südlich vom {area:1878}. Kojoten lassen Kieferknochen und Fangzähne fallen; nur die Bussarde lassen Flügel und Muskelmägen fallen.",

	-- Step 37: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Große Felselementare",
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Die Großen Felselementare (42-44, deutlich über dir) wandern durch die Rinnen im Südwesten; die Armschienen fallen etwa bei jedem fünften Kill. Zieh sie einzeln und ruh dich zwischen den Kämpfen aus, oder lass sie. Töte unterwegs weiter Kojoten und Bussarde, die du noch brauchst.",

	-- Step 38: Kargath
	-- {area:340} Kargath
	["Head north back to {area:340}."] = "Geh nach Norden zurück nach {area:340}.",

	-- Step 39: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: nur wenn du {item:2868} dabeihast ({skill:164} oder Auktionshaus)",

	-- Step 41: Stonevault troggs
	["Stonevault troggs"] = "Steingrufttroggs",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Die Steingrufttroggs graben um die Höhleneingänge südlich vom {area:1877}, auf dem Weg zur {area:345}; die Knochenknacker und Schamanen lassen die Splitter fallen.",

	-- Step 42: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin sitzt zwischen den Zwergenruinen an der {area:345}, südlich vom {area:1877}.",

	-- Step 43: Valley of Fangs
	-- {npc:4618} Martek the Exiled
	["Follow the road north; {npc:4618}'s camp is on the way."] = "Folge der Straße nach Norden; {npc:4618}s Lager liegt auf dem Weg.",

	-- Step 44: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Bleib auf der Straße nach Norden; die Truhe liegt in der Grabungsstätte von {area:1517}, am Fuß der Ruinen nordwestlich der Straße.",

	-- Step 45: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Geh die Straße zurück nach Süden, am {area:1877} vorbei.",

	-- Step 46: Hearth to Kargath
	-- {area:340} Kargath
	["Hearth to {area:340}"] = "Ruhestein nach {area:340}",

	-- Step 47: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "Nimm den Zeppelin nach {zone:1454} vom Turm auf der Westseite von {object:3202}.",
	["Zeppelin tower"] = "Zeppelinturm",

	-- Step 49: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "Dein Lehrer ist in {area:1638}, einen Flug von {zone:1454} entfernt: {npc:3033} (Druiden) auf der {area:1639}, {npc:246344} (Paladine). Flieg von dort weiter nach {area:380}.",

	-- Step 51: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Head north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Geh die Straße vom {area:380} nach Norden zu den {area:386}; {npc:3389} hält auf der Anhöhe über dem Wasser Wache.",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace
	["for {npc:5395} in {zone:1443}, in the next guide"] = "für {npc:5395} in {zone:1443}, im nächsten Guide",

	-- Step 52: Ratchet
	-- {area:380} Crossroads · {area:392} Ratchet
	["Head back south to the {area:380} and fly to {area:392}."] = "Geh zurück nach Süden zum {area:380} und flieg nach {area:392}.",
	-- {item:3713} Soothing Spices · {zone:1445} Dustwallow Marsh
	["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}, für Sumpfauge Jarl in {zone:1445}",
	-- {zone:1445} Dustwallow Marsh
	["The next guide heads into {zone:1445}."] = "Der nächste Guide führt in die {zone:1445}.",

	-- Step 53: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Geh von {area:392} an der Küste nach Süden zu {area:720}. {npc:6236} steht an der Arena: Betritt das Gitter, um den Kampf zu beginnen; die Herausforderer kommen einzeln, dann {npc:6238} (33).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride back south down the road, past the {area:1877}."] = "Reite die Straße zurück nach Süden, am {area:1877} vorbei.",
	-- ["Ride back south to the {area:380} and fly to {area:392}."] = "Reite zurück nach Süden nach {area:380} und flieg nach {area:392}.",
	-- ["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Reite von {area:272} nach Osten durch {area:1857} und folge der Straße nach Osten. Die Oger und Vollstrecker der Felsfäuste (32-34) lagern südlich der Straße, südöstlich von {area:313}.",
	-- ["Ride north back to {area:340}."] = "Reite nach Norden zurück nach {area:340}.",
	-- ["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Reite von {area:380} die Straße nach Norden zu {area:386}; {npc:3389} hält auf der Anhöhe über dem Wasser Wache.",
	-- ["Ride north; the outer circle stands in the middle of the highlands."] = "Reite nach Norden; der äußere Kreis steht mitten im Hochland.",
	-- ["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Reite von {area:392} die Küste entlang nach Süden zur {area:720}. {npc:6236} steht bei der Arena: Tritt auf das Gitter, um den Kampf zu starten; die Herausforderer kommen einzeln, dann {npc:6238} (33).",
	-- ["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Reite nach Südwesten aus Arathi über den {area:880}, nach Süden durch das {zone:1437} (meide {area:150}) und nach Osten nach {zone:1432}; die Straße verlässt {zone:1432} nach Süden ins {zone:1418}. Folge ihr nach Süden zum Goblinlager im {area:1877}.",
	-- ["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Reite nach Südwesten zur Bucht der Goblins an der Südküste. {npc:2766} hält auf der Klippe darüber Wache.",
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "Reite auf der Straße nach Westen; Lotwils Lager liegt in {area:1878} auf halbem Weg nach {area:340}.",
	-- ["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Reite auf der Straße nach Westen; {npc:2921}s Lager liegt im {area:1878} auf halbem Weg nach {area:340}.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Die Alten Klippenkojoten und Riesenbussarde streifen durch das Becken südlich von {area:1878}. Kojoten lassen Kieferknochen und Fangzähne fallen; nur die Bussarde lassen Flügel und Muskelmägen fallen.",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Die größeren Felselementare stehen an den Hängen nordwestlich von {area:1878}; jedes lässt eine Steinplatte fallen.",
	-- ["The western circle is near {area:1857}, where you rode in."] = "Der westliche Kreis liegt nahe {area:1857}, wo du hereingeritten bist.",
	-- ["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "Der Zeppelin landet an den Türmen vor {zone:1458}: Reite hinunter in die Stadt und flieg nach {area:272}.",
	-- ["The {area:380}"] = "{area:380}",
}
